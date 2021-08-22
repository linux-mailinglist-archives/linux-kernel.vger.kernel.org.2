Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F5723F3F46
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Aug 2021 14:37:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231459AbhHVMg5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Aug 2021 08:36:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:33874 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230495AbhHVMg5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Aug 2021 08:36:57 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9228C61207;
        Sun, 22 Aug 2021 12:36:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1629635775;
        bh=UwmFqYaF4dGehC4JVLviprvq+rgfH8eWTr7mCR0PFYg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cGp8e1w2IiuUTBA7hxsNv47w9RvGcB1GB6zBcAHFvv0yXJYQgBPbGYOf2U5IiMGJz
         I8Yq+FHldp95SDI9gwKozUzqFLzBzP3l9juU/ZCQfBnowy2MQcK/ArDugLo+XbaS+1
         INYbJSttFyo5h08RJaEXxbvnB+tz1KMZvFAHzk+w=
Date:   Sun, 22 Aug 2021 14:36:11 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Cc:     Saurav Girepunje <saurav.girepunje@gmail.com>,
        Phillip Potter <phil@philpotter.co.uk>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        linux-staging@lists.linux.dev,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        saurav.girepunje@hotmail.com
Subject: Re: [PATCH] staging: r8188eu: core: remove condition with no effect
Message-ID: <YSJEu3sbnR6uIach@kroah.com>
References: <YSFgrLUfXzgcT6k4@user>
 <CAA=Fs0kByg1NztU+Nf__RUzTHuVh_q2hvcyh+3JqXiVgn+_VeQ@mail.gmail.com>
 <1821445.fzUCeO1EU3@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1821445.fzUCeO1EU3@localhost.localdomain>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 22, 2021 at 01:06:09PM +0200, Fabio M. De Francesco wrote:
> On Sunday, August 22, 2021 1:58:10 AM CEST Phillip Potter wrote:
> > On Sat, 21 Aug 2021 at 21:23, Saurav Girepunje
> > 
> > <saurav.girepunje@gmail.com> wrote:
> > > Remove the condition with no effect (if == else) in rtw_led.c
> > > file.
> > > 
> > > Signed-off-by: Saurav Girepunje <saurav.girepunje@gmail.com>
> > > ---
> > > 
> > >  drivers/staging/r8188eu/core/rtw_led.c | 5 +----
> > >  1 file changed, 1 insertion(+), 4 deletions(-)
> > 
> > Thanks for this, looks good.
> > 
> > Acked-by: Phillip Potter <phil@philpotter.co.uk>
> > 
> > Regards,
> > Phil
> 
> Dear Philip,
> 
> Before acking, please check at least if it applies to the current version of 
> the tree and check if it compiles without adding warnings and / or errors. :-)

That is not necessary or needed here, I can do that when I apply the
patch.

greg k-h
