Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 005BF3E41C4
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Aug 2021 10:45:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234067AbhHIIpl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Aug 2021 04:45:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:49144 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233940AbhHIIpj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Aug 2021 04:45:39 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4F0AD61004;
        Mon,  9 Aug 2021 08:45:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1628498718;
        bh=EcmaJregycm6/qVSvcmyKPkSmG1lwe85pKw2N0uoBEQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=N/vkNIaN7ow+se6o1ZwW9aNp1vHhLfosQvhscN6Gnnxl0IpE776+D7SXlSIb+W88Q
         zRC+ouAabJK3pMAGDZz2BryN8krKyzawtY6o/f6zWQVQOEy8XI3eWpiI2hnO+ZKTKE
         UEgQZdBAM/L/QTp0JiuyfY8+ku0IBuWgUDF+HrbA=
Date:   Mon, 9 Aug 2021 10:45:16 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Dongliang Mu <mudongliangabcd@gmail.com>
Cc:     Samuel Iglesias Gonsalvez <siglesias@igalia.com>,
        Jens Taprogge <jens.taprogge@taprogge.org>,
        Lv Yunlong <lyl2019@mail.ustc.edu.cn>,
        Aditya Srivastava <yashsri421@gmail.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        industrypack-devel@lists.sourceforge.net,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/3] ipack: tpci200: fix many double free issues in
 tpci200_pci_probe
Message-ID: <YRDrHPcC8Nb3g0sg@kroah.com>
References: <20210721111137.1523229-1-mudongliangabcd@gmail.com>
 <20210721111137.1523229-2-mudongliangabcd@gmail.com>
 <YQvXfQ4A04cy5MEA@kroah.com>
 <CAD-N9QX7A=Z4=bpjw63zCZ=KTTJTYP=n9g29Kp1d39DxgK2_Eg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAD-N9QX7A=Z4=bpjw63zCZ=KTTJTYP=n9g29Kp1d39DxgK2_Eg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 09, 2021 at 11:40:13AM +0800, Dongliang Mu wrote:
> On Thu, Aug 5, 2021 at 8:20 PM Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > On Wed, Jul 21, 2021 at 07:11:31PM +0800, Dongliang Mu wrote:
> > > The function tpci200_register called by tpci200_install and
> > > tpci200_unregister called by tpci200_uninstall are in pair. However,
> > > tpci200_unregister has some cleanup operations not in the
> > > tpci200_register. So the error handling code of tpci200_pci_probe has
> > > many different double free issues.
> > >
> > > Fix this problem by moving those cleanup operations out of
> > > tpci200_unregister, into tpci200_pci_remove and reverting
> > > the previous commit 9272e5d0028d
> > >
> > > Reported-by: Dongliang Mu <mudongliangabcd@gmail.com>
> > > Fixes: 9272e5d0028d ("ipack/carriers/tpci200: Fix a double free in tpci200_pci_probe")
> > > Signed-off-by: Dongliang Mu <mudongliangabcd@gmail.com>
> > > ---
> > >  drivers/ipack/carriers/tpci200.c | 35 ++++++++++++++++----------------
> > >  1 file changed, 17 insertions(+), 18 deletions(-)
> >
> > This needs to be applied to the tree now, and should not depend on your
> > patch 1/3 here as it is a bugfix.  Please redo this series and send 2,
> > one to be merged for 5.14-final and to go to the stable kernels, and a
> > separate "clean up things" series that can wait until 5.15-rc1.
> 
> No problem. I will send a separate fix.
> 
> BTW, how about the PATCH 3/3 in this series [1]? It does not depend on
> PATCH 1/3, however, it does not include the fix to memleak, but also
> moves the unregister function. Shall I send it separately?
> 
> [1] https://lkml.org/lkml/2021/7/21/370

Please resend everything, as none of these were applied and are all gone
from my queue.

thanks,

greg k-h
