Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDFF23E5346
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Aug 2021 08:12:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237738AbhHJGMZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Aug 2021 02:12:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:38020 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230243AbhHJGMY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Aug 2021 02:12:24 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C957160E97;
        Tue, 10 Aug 2021 06:12:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1628575923;
        bh=Uax4h37HJuuNp3d1U8G/Mg+6ZY5i9zgBWvdL7SyIohk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UyDguacFBDdGqtP5ysPk5KLyePbBA9UW+8HsHymM9LwSnmiCx1SbKwHFdze7QNGf2
         Ti0W8Rb/o6ySuxmJNJXpjlwMFfkQiSm5AVnLStAuELkT8D6B3RENPpvJ4aTo40vUDQ
         5MV39P8r2awNaZVC/tj69Z3QXlUIrJnUfzRbOuLc=
Date:   Tue, 10 Aug 2021 08:12:00 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Dongliang Mu <mudongliangabcd@gmail.com>
Cc:     Samuel Iglesias Gonsalvez <siglesias@igalia.com>,
        Jens Taprogge <jens.taprogge@taprogge.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Aditya Srivastava <yashsri421@gmail.com>,
        Lv Yunlong <lyl2019@mail.ustc.edu.cn>,
        industrypack-devel@lists.sourceforge.net,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/4] ipack: tpci200: fix many double free issues in
 tpci200_pci_probe
Message-ID: <YRIYsNCMmKrPfRlF@kroah.com>
References: <20210809143049.3531188-1-mudongliangabcd@gmail.com>
 <YRFKlOvXKKQX9vr6@kroah.com>
 <CAD-N9QXFWr2APy294T6v+16d8SXtUuLEoPvZTw1ZDwfQ+D4kFg@mail.gmail.com>
 <CAD-N9QVgnbwNScKD6anFLUELbJ5tAZ1hWbKhOStwZ+kPwgvVLw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAD-N9QVgnbwNScKD6anFLUELbJ5tAZ1hWbKhOStwZ+kPwgvVLw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 10, 2021 at 07:41:55AM +0800, Dongliang Mu wrote:
> On Tue, Aug 10, 2021 at 7:08 AM Dongliang Mu <mudongliangabcd@gmail.com> wrote:
> >
> > On Mon, Aug 9, 2021 at 11:32 PM Greg Kroah-Hartman
> > <gregkh@linuxfoundation.org> wrote:
> > >
> > > On Mon, Aug 09, 2021 at 10:30:26PM +0800, Dongliang Mu wrote:
> > > > The function tpci200_register called by tpci200_install and
> > > > tpci200_unregister called by tpci200_uninstall are in pair. However,
> > > > tpci200_unregister has some cleanup operations not in the
> > > > tpci200_register. So the error handling code of tpci200_pci_probe has
> > > > many different double free issues.
> > > >
> > > > Fix this problem by moving those cleanup operations out of
> > > > tpci200_unregister, into tpci200_pci_remove and reverting
> > > > the previous commit 9272e5d0028d ("ipack/carriers/tpci200:
> > > > Fix a double free in tpci200_pci_probe").
> > > >
> > > > Reported-by: Dongliang Mu <mudongliangabcd@gmail.com>
> > > > Fixes: 9272e5d0028d ("ipack/carriers/tpci200: Fix a double free in tpci200_pci_probe")
> > > > Signed-off-by: Dongliang Mu <mudongliangabcd@gmail.com>
> > > > ---
> > > > v1->v2: revise PATCH 2/3, 3/3, not depending on PATCH 1/3; move the
> > > > location change of tpci_unregister into one separate patch;
> > >
> > > Also needs to go to the stable trees, right?
> >
> > Yes, this needs to go to the stable trees.
> 
> Hi gregkh,
> 
> Let me clarify more. In my series, PATCH 3/4 4/4 depends on PATCH 1/4
> and PATCH 2/4. And also PATCH 2/4 depends on PATCH 1/4 as they are
> closely related.
> 
> But from your reply, the last 2 patches should not depend on the first
> 2 patches. I don't quite understand as I don't send some patch series
> before. For a patch series, the latter ones should depend on the
> former ones, right? If I have any misunderstanding, please let me
> know.

Yes, they can depend on previous patches, but if some patches are to be
merged today for 5.14-final, and others later for 5.15-rc1, then ideally
they will be separate series of changes as those go to two different
branches in my tree at the moment.

> BTW, PATCH 3/4 has some compilation issues. I will fix it in the next version.

As you haven't even tested these, I'm really hesitant to take them at
all.

Please just send the first two patches, fixed up, as a series after you
have tested them, and then after they are merged into Linus's tree, you
can send the cleanup patches, as they are just "nice" to have.

thanks,

greg k-h
