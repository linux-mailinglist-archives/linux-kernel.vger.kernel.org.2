Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD5033097A4
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Jan 2021 19:48:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232118AbhA3SsO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Jan 2021 13:48:14 -0500
Received: from smtprelay0171.hostedemail.com ([216.40.44.171]:40950 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S230045AbhA3SsM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Jan 2021 13:48:12 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay08.hostedemail.com (Postfix) with ESMTP id 9F2FF182CED34;
        Sat, 30 Jan 2021 18:47:30 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:800:960:973:988:989:1260:1261:1277:1311:1313:1314:1345:1359:1515:1516:1518:1534:1542:1593:1594:1711:1730:1747:1777:1792:2393:2559:2562:2828:3138:3139:3140:3141:3142:3355:3622:3868:4321:5007:7652:10004:10400:10848:11026:11232:11473:11657:11658:11914:12043:12296:12297:12555:12740:12895:12986:13439:13894:14181:14659:14721:21080:21627:30054:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: root04_1201875275b3
X-Filterd-Recvd-Size: 3185
Received: from [192.168.1.159] (unknown [47.151.137.21])
        (Authenticated sender: joe@perches.com)
        by omf08.hostedemail.com (Postfix) with ESMTPA;
        Sat, 30 Jan 2021 18:47:29 +0000 (UTC)
Message-ID: <49b8e2550e661d5f8a5d0b353ec23819cdcae3d2.camel@perches.com>
Subject: Re: [PATCH 09/29] drm/gma500: Avoid comma separated statements
From:   Joe Perches <joe@perches.com>
To:     Jiri Kosina <trivial@kernel.org>,
        Patrik Jakobsson <patrik.r.jakobsson@gmail.com>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Date:   Sat, 30 Jan 2021 10:47:28 -0800
In-Reply-To: <e96626cd1301ff44e5101e0e5913d8439b425c9f.1598331148.git.joe@perches.com>
References: <cover.1598331148.git.joe@perches.com>
         <e96626cd1301ff44e5101e0e5913d8439b425c9f.1598331148.git.joe@perches.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2020-08-24 at 21:56 -0700, Joe Perches wrote:
> Use semicolons and braces.

Ping?
 
> Signed-off-by: Joe Perches <joe@perches.com>
> ---
>  drivers/gpu/drm/gma500/mdfld_intel_display.c | 44 +++++++++++++-------
>  1 file changed, 28 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/gpu/drm/gma500/mdfld_intel_display.c b/drivers/gpu/drm/gma500/mdfld_intel_display.c
> index aae2d358364c..bfa330df9443 100644
> --- a/drivers/gpu/drm/gma500/mdfld_intel_display.c
> +++ b/drivers/gpu/drm/gma500/mdfld_intel_display.c
> @@ -824,33 +824,45 @@ static int mdfld_crtc_mode_set(struct drm_crtc *crtc,
>  		if ((ksel == KSEL_CRYSTAL_19) || (ksel == KSEL_BYPASS_19)) {
>  			refclk = 19200;
>  
> 
> -			if (is_mipi || is_mipi2)
> -				clk_n = 1, clk_p2 = 8;
> -			else if (is_hdmi)
> -				clk_n = 1, clk_p2 = 10;
> +			if (is_mipi || is_mipi2) {
> +				clk_n = 1;
> +				clk_p2 = 8;
> +			} else if (is_hdmi) {
> +				clk_n = 1;
> +				clk_p2 = 10;
> +			}
>  		} else if (ksel == KSEL_BYPASS_25) {
>  			refclk = 25000;
>  
> 
> -			if (is_mipi || is_mipi2)
> -				clk_n = 1, clk_p2 = 8;
> -			else if (is_hdmi)
> -				clk_n = 1, clk_p2 = 10;
> +			if (is_mipi || is_mipi2) {
> +				clk_n = 1;
> +				clk_p2 = 8;
> +			} else if (is_hdmi) {
> +				clk_n = 1;
> +				clk_p2 = 10;
> +			}
>  		} else if ((ksel == KSEL_BYPASS_83_100) &&
>  					dev_priv->core_freq == 166) {
>  			refclk = 83000;
>  
> 
> -			if (is_mipi || is_mipi2)
> -				clk_n = 4, clk_p2 = 8;
> -			else if (is_hdmi)
> -				clk_n = 4, clk_p2 = 10;
> +			if (is_mipi || is_mipi2) {
> +				clk_n = 4;
> +				clk_p2 = 8;
> +			} else if (is_hdmi) {
> +				clk_n = 4;
> +				clk_p2 = 10;
> +			}
>  		} else if ((ksel == KSEL_BYPASS_83_100) &&
>  					(dev_priv->core_freq == 100 ||
>  					dev_priv->core_freq == 200)) {
>  			refclk = 100000;
> -			if (is_mipi || is_mipi2)
> -				clk_n = 4, clk_p2 = 8;
> -			else if (is_hdmi)
> -				clk_n = 4, clk_p2 = 10;
> +			if (is_mipi || is_mipi2) {
> +				clk_n = 4;
> +				clk_p2 = 8;
> +			} else if (is_hdmi) {
> +				clk_n = 4;
> +				clk_p2 = 10;
> +			}
>  		}
>  
> 
>  		if (is_mipi)


