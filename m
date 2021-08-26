Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B67FC3F8562
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Aug 2021 12:35:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241415AbhHZKgF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Aug 2021 06:36:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:48728 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241180AbhHZKgE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Aug 2021 06:36:04 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id EB9DE61058;
        Thu, 26 Aug 2021 10:35:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1629974117;
        bh=QaM6O1Y7m4Zhb5o0MZ7+t2h1kPiV9Wz2NzgnOqwG4Q0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=wIY9LwK/dFc/gNWnp1ZPngN0x3nzPeLMxser5uFGnSduiSvYkbjZ2agRjNMIW16pU
         gQ1MMYqazaUbUxgHTSEvKhdNko3QMDY/Di3Oe9odzN1sN9+2WiaOLYZrnqsQvLvFhy
         oxbndY4vyW0L1R5uHMeHf+IHhxtcP3MkH7eplmoA=
Date:   Thu, 26 Aug 2021 12:34:03 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Cc:     Saurav Girepunje <saurav.girepunje@gmail.com>,
        Phillip Potter <phil@philpotter.co.uk>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        linux-staging@lists.linux.dev,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        saurav.girepunje@hotmail.com
Subject: Re: [PATCH] staging: r8188eu: core: remove condition with no effect
Message-ID: <YSduG401BA80Xnsb@kroah.com>
References: <YSFgrLUfXzgcT6k4@user>
 <CAA=Fs0kByg1NztU+Nf__RUzTHuVh_q2hvcyh+3JqXiVgn+_VeQ@mail.gmail.com>
 <1821445.fzUCeO1EU3@localhost.localdomain>
 <YSJEu3sbnR6uIach@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YSJEu3sbnR6uIach@kroah.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 22, 2021 at 02:36:11PM +0200, Greg KH wrote:
> On Sun, Aug 22, 2021 at 01:06:09PM +0200, Fabio M. De Francesco wrote:
> > On Sunday, August 22, 2021 1:58:10 AM CEST Phillip Potter wrote:
> > > On Sat, 21 Aug 2021 at 21:23, Saurav Girepunje
> > > 
> > > <saurav.girepunje@gmail.com> wrote:
> > > > Remove the condition with no effect (if == else) in rtw_led.c
> > > > file.
> > > > 
> > > > Signed-off-by: Saurav Girepunje <saurav.girepunje@gmail.com>
> > > > ---
> > > > 
> > > >  drivers/staging/r8188eu/core/rtw_led.c | 5 +----
> > > >  1 file changed, 1 insertion(+), 4 deletions(-)
> > > 
> > > Thanks for this, looks good.
> > > 
> > > Acked-by: Phillip Potter <phil@philpotter.co.uk>
> > > 
> > > Regards,
> > > Phil
> > 
> > Dear Philip,
> > 
> > Before acking, please check at least if it applies to the current version of 
> > the tree and check if it compiles without adding warnings and / or errors. :-)
> 
> That is not necessary or needed here, I can do that when I apply the
> patch.

As proof of that, this patch applied just fine to my tree right now...

thanks,

greg k-h
