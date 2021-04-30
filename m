Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E3B936F9D6
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Apr 2021 14:16:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231856AbhD3MR1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Apr 2021 08:17:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:37856 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229911AbhD3MRZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Apr 2021 08:17:25 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4FF3661059;
        Fri, 30 Apr 2021 12:16:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1619784996;
        bh=uqks43nqlqQ49VpQR/3gkgAqdEBhthvpFSdy6FJKWOo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ziYZnYdEfRh3i0XJH8CIgCpiVMSAUKlt5EN1UUbB73Bfv5CqTyQarKSZTqVM47AN4
         mO8OIQGwzqt/jJutwVAIPiKC9d2qvYuYlmsUF9tm1RVgrZEdur6+G5lzbs5ruxuHeI
         5IciP/LJty/9u9Awy7amtjK7Xx6hO7S6hSGT3854=
Date:   Fri, 30 Apr 2021 14:16:29 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Pavel Machek <pavel@ucw.cz>
Cc:     linux-kernel@vger.kernel.org, Kangjie Lu <kjlu@umn.edu>,
        Daniel Vetter <daniel.vetter@ffwll.ch>
Subject: Re: [PATCH 075/190] Revert "gma/gma500: fix a memory disclosure bug
 due to uninitialized bytes"
Message-ID: <YIv1HSXC4kKa+jHc@kroah.com>
References: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
 <20210421130105.1226686-76-gregkh@linuxfoundation.org>
 <20210429202301.GI31692@amd>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210429202301.GI31692@amd>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 29, 2021 at 10:23:01PM +0200, Pavel Machek wrote:
> Hi!
> 
> >  drivers/gpu/drm/gma500/cdv_intel_display.c | 2 --
> >  1 file changed, 2 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/gma500/cdv_intel_display.c b/drivers/gpu/drm/gma500/cdv_intel_display.c
> > index 5d3302249779..f89c2088dc2d 100644
> > --- a/drivers/gpu/drm/gma500/cdv_intel_display.c
> > +++ b/drivers/gpu/drm/gma500/cdv_intel_display.c
> > @@ -405,8 +405,6 @@ static bool cdv_intel_find_dp_pll(const struct gma_limit_t *limit,
> >  	struct gma_crtc *gma_crtc = to_gma_crtc(crtc);
> >  	struct gma_clock_t clock;
> >  
> > -	memset(&clock, 0, sizeof(clock));
> > -
> >  	switch (refclk) {
> >  	case 27000:
> >  		if (target < 200000) {
> 
> Original description is correct, we are returning with .vco and .dot
> unitialized which is at least very very ugly, so we should keep the
> memset and not revert this.

Good point, revert now dropped, thanks.

greg k-h
