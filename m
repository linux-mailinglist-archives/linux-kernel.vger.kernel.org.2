Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A030C3E5342
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Aug 2021 08:09:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237729AbhHJGKS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Aug 2021 02:10:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:37798 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230243AbhHJGKR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Aug 2021 02:10:17 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 32BFF60ED8;
        Tue, 10 Aug 2021 06:09:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1628575795;
        bh=/nrVBz516xXg1+GxJ8fRvs9UDMO+EFBay4x+98pdHL0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WETrxmpOpkXlrF/yCynkhVq9kjd1EvF+Pa51SQ1JkO+aIY1Pt26pdYwjXA2gSsZJw
         m11l8uw1WnK2i3Z1JeytuAG1dzQrdeuzK7mljDUJVRtME7/FQds7+0IJZr5LJsxXCz
         ahDG14bC7aOoMzix9ZPHyBNrOyotYT/++BV9z3JU=
Date:   Tue, 10 Aug 2021 08:09:51 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Dongliang Mu <mudongliangabcd@gmail.com>
Cc:     Samuel Iglesias Gonsalvez <siglesias@igalia.com>,
        Jens Taprogge <jens.taprogge@taprogge.org>,
        Aditya Srivastava <yashsri421@gmail.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Lv Yunlong <lyl2019@mail.ustc.edu.cn>,
        Zhouyang Jia <jiazhouyang09@gmail.com>,
        industrypack-devel@lists.sourceforge.net,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 2/4] ipack: tpci200: fix memory leak in the
 tpci200_register
Message-ID: <YRIYL/UBWNUxPefp@kroah.com>
References: <20210809143049.3531188-1-mudongliangabcd@gmail.com>
 <20210809143049.3531188-2-mudongliangabcd@gmail.com>
 <YRFKnvN+jUoOaCiA@kroah.com>
 <CAD-N9QXn3K9J+pXtTW08_ty0m9AbWWdWYppnbezBTRRtCNKGWw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAD-N9QXn3K9J+pXtTW08_ty0m9AbWWdWYppnbezBTRRtCNKGWw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 10, 2021 at 07:09:15AM +0800, Dongliang Mu wrote:
> On Mon, Aug 9, 2021 at 11:32 PM Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > On Mon, Aug 09, 2021 at 10:30:27PM +0800, Dongliang Mu wrote:
> > > The error handling code in tpci200_register does not free interface_regs
> > > allocated by ioremap and the current version of error handling code is
> > > problematic.
> > >
> > > Fix this by refactoring the error handling code and free interface_regs
> > > when necessary.
> > >
> > > Reported-by: Dongliang Mu <mudongliangabcd@gmail.com>
> > > Fixes: 43986798fd50 ("ipack: add error handling for ioremap_nocache")
> > > Signed-off-by: Dongliang Mu <mudongliangabcd@gmail.com>
> > > ---
> > >  drivers/ipack/carriers/tpci200.c | 24 ++++++++++++++----------
> > >  1 file changed, 14 insertions(+), 10 deletions(-)
> >
> > Also for stable?
> 
> Yes, it should.

Then please resend it, and the other commits that you wish to see go to
the stable tree, with the needed "cc: stable..." line in the
signed-off-by area.

thanks,

greg k-h
