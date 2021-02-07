Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF8183123AC
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Feb 2021 11:49:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229750AbhBGKq4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Feb 2021 05:46:56 -0500
Received: from smtprelay0199.hostedemail.com ([216.40.44.199]:40782 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229506AbhBGKq3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Feb 2021 05:46:29 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id BE53518223253;
        Sun,  7 Feb 2021 10:45:46 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:960:973:988:989:1260:1261:1277:1311:1313:1314:1345:1359:1381:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2393:2559:2562:2828:3138:3139:3140:3141:3142:3353:3867:3868:5007:6120:7652:7901:8603:10004:10400:10471:10848:11026:11473:11657:11658:11914:12043:12296:12297:12438:12555:13069:13163:13229:13255:13311:13357:13439:13894:14659:14721:21080:21451:21627:21990:30012:30054,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: nest17_010c860275f5
X-Filterd-Recvd-Size: 2900
Received: from [192.168.1.159] (unknown [47.151.137.21])
        (Authenticated sender: joe@perches.com)
        by omf19.hostedemail.com (Postfix) with ESMTPA;
        Sun,  7 Feb 2021 10:45:46 +0000 (UTC)
Message-ID: <c00c5058effff98b6cd76a0cfadb469c33091e08.camel@perches.com>
Subject: Re: [PATCH] I was wondering why I can't set the resolution to
 2560x1080, while in windows 7 I can without a problem. I looked at the
 radeon driver code and found it doesn't support this resolution. So I made
 some changes. I added the hdmi_mhz parameter. In cmdline I set
 radeon.hdmi_mhz=190 Only tested on the Radeon HD 5830
From:   Joe Perches <joe@perches.com>
To:     Marcin Raszka <djraszit@gmail.com>, linux-kernel@vger.kernel.org
Date:   Sun, 07 Feb 2021 02:45:44 -0800
In-Reply-To: <20210207094604.7250-1-djraszit@gmail.com>
References: <20210207094604.7250-1-djraszit@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Your subject needs to be changed and a commit log added.

> diff --git a/drivers/gpu/drm/radeon/radeon_connectors.c b/drivers/gpu/drm/radeon/radeon_connectors.c
[]
> @@ -37,6 +37,8 @@
>  #include <linux/pm_runtime.h>
>  #include <linux/vga_switcheroo.h>
> 
> +extern int hdmimhz;
> +
>  static int radeon_dp_handle_hpd(struct drm_connector *connector)
>  {
>  	struct radeon_connector *radeon_connector = to_radeon_connector(connector);
> @@ -503,7 +505,7 @@ static void radeon_add_common_modes(struct drm_encoder *encoder, struct drm_conn
>  	struct mode_size {
>  		int w;
>  		int h;
> -	} common_modes[17] = {
> +	} common_modes[18] = {

probably better without a specific array size

>  		{ 640,  480},
>  		{ 720,  480},
>  		{ 800,  600},
> @@ -520,10 +522,11 @@ static void radeon_add_common_modes(struct drm_encoder *encoder, struct drm_conn
>  		{1680, 1050},
>  		{1600, 1200},
>  		{1920, 1080},
> -		{1920, 1200}
> +		{1920, 1200},
> +		{2560, 1080}
>  	};
>  
> 
> -	for (i = 0; i < 17; i++) {
> +	for (i = 0; i < 18; i++) {

	for (i = 0; i < ARRAY_SIZE(common_modes); i++) {

> @@ -1491,25 +1494,32 @@ static enum drm_mode_status radeon_dvi_mode_valid(struct drm_connector *connecto
>  	    (mode->clock > 135000))
>  		return MODE_CLOCK_HIGH;
>  
> 
> -	if (radeon_connector->use_digital && (mode->clock > 165000)) {
> +	if (radeon_connector->use_digital && (mode->clock > (hdmimhz * 1000))) {
>  		if ((radeon_connector->connector_object_id == CONNECTOR_OBJECT_ID_DUAL_LINK_DVI_I) ||
>  		    (radeon_connector->connector_object_id == CONNECTOR_OBJECT_ID_DUAL_LINK_DVI_D) ||
> -		    (radeon_connector->connector_object_id == CONNECTOR_OBJECT_ID_HDMI_TYPE_B))
> +		    (radeon_connector->connector_object_id == CONNECTOR_OBJECT_ID_HDMI_TYPE_B)){
> +			printk("MODE_CLOCK_HIHG0 %d", hdmimhz);

unnecessary debugging printks?


