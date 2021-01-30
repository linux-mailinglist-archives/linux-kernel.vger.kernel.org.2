Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 356FF3097B5
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Jan 2021 19:57:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231912AbhA3S4K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Jan 2021 13:56:10 -0500
Received: from smtprelay0165.hostedemail.com ([216.40.44.165]:37202 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S230095AbhA3S4J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Jan 2021 13:56:09 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay03.hostedemail.com (Postfix) with ESMTP id 44849837F24C;
        Sat, 30 Jan 2021 18:55:26 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:800:960:973:988:989:1260:1261:1277:1311:1313:1314:1345:1359:1515:1516:1518:1534:1540:1593:1594:1711:1730:1747:1777:1792:2194:2199:2393:2559:2562:2828:3138:3139:3140:3141:3142:3352:3622:3868:4321:5007:7652:7875:10004:10400:10848:11232:11658:11914:12297:12555:12740:12895:12986:13069:13311:13357:13439:13894:14181:14659:14721:21080:21627:30054:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: ball06_08104aa275b3
X-Filterd-Recvd-Size: 1735
Received: from [192.168.1.159] (unknown [47.151.137.21])
        (Authenticated sender: joe@perches.com)
        by omf10.hostedemail.com (Postfix) with ESMTPA;
        Sat, 30 Jan 2021 18:55:25 +0000 (UTC)
Message-ID: <bfac54e37f602bcdac73f6aee4e9fcd4fd651795.camel@perches.com>
Subject: Re: [PATCH 03/29] ia64: Avoid comma separated statements
From:   Joe Perches <joe@perches.com>
To:     Jiri Kosina <trivial@kernel.org>, linux-kernel@vger.kernel.org
Cc:     Tony Luck <tony.luck@intel.com>, Fenghua Yu <fenghua.yu@intel.com>,
        linux-ia64@vger.kernel.org
Date:   Sat, 30 Jan 2021 10:55:24 -0800
In-Reply-To: <be37cf8fdcad19678cd164946252bc67713ddcdf.1598331148.git.joe@perches.com>
References: <cover.1598331148.git.joe@perches.com>
         <be37cf8fdcad19678cd164946252bc67713ddcdf.1598331148.git.joe@perches.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2020-08-24 at 21:56 -0700, Joe Perches wrote:
> Use semicolons and braces.

ping?


> Signed-off-by: Joe Perches <joe@perches.com>
> ---
>  arch/ia64/kernel/smpboot.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/ia64/kernel/smpboot.c b/arch/ia64/kernel/smpboot.c
> index c29c600d7967..3311b9d21319 100644
> --- a/arch/ia64/kernel/smpboot.c
> +++ b/arch/ia64/kernel/smpboot.c
> @@ -224,8 +224,11 @@ get_delta (long *rt, long *master)
>  		go[SLAVE] = 0;
>  		t1 = ia64_get_itc();
>  
> 
> -		if (t1 - t0 < best_t1 - best_t0)
> -			best_t0 = t0, best_t1 = t1, best_tm = tm;
> +		if (t1 - t0 < best_t1 - best_t0) {
> +			best_t0 = t0;
> +			best_t1 = t1;
> +			best_tm = tm;
> +		}
>  	}
>  
> 
>  	*rt = best_t1 - best_t0;


