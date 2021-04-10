Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 802E035ABD8
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Apr 2021 10:16:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233827AbhDJIQg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Apr 2021 04:16:36 -0400
Received: from mail2-relais-roc.national.inria.fr ([192.134.164.83]:36484 "EHLO
        mail2-relais-roc.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229494AbhDJIQe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Apr 2021 04:16:34 -0400
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3AhHlmwqg61Ye3+5hDwb+Ew+rd1XBQXvMji2hD?=
 =?us-ascii?q?6mlwRA09T+WzkceykPMHkSLlkTp5YhAdsP2JJaXoexjh3LFv5415B9ufdS3HnE?=
 =?us-ascii?q?ftE41494vlxFTbdRHW0uJGz69vf+xfJbTLZ2RStsrx7AmmH9tI+rDuzImTmezc?=
 =?us-ascii?q?w31xJDsGV4hc6W5CZTqmLg=3D=3D?=
X-IronPort-AV: E=Sophos;i="5.82,210,1613430000"; 
   d="scan'208";a="502532363"
Received: from 173.121.68.85.rev.sfr.net (HELO hadrien) ([85.68.121.173])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Apr 2021 10:16:19 +0200
Date:   Sat, 10 Apr 2021 10:16:19 +0200 (CEST)
From:   Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To:     Mitali Borkar <mitaliborkar810@gmail.com>
cc:     gregkh@linuxfoundation.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, outreachy-kernel@googlegroups.com,
        mitali_s@me.iitr.ac.in
Subject: Re: [Outreachy kernel] [PATCH 1/3] staging: rtl8192e: replace
 comparison to NULL by boolean
In-Reply-To: <YHEJngq5MHBEspGY@kali>
Message-ID: <alpine.DEB.2.22.394.2104101015560.2975@hadrien>
References: <YHEJngq5MHBEspGY@kali>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 10 Apr 2021, Mitali Borkar wrote:

> Replaced comparison to NULL by boolean expressions
> (here used boolean negations). This improves readability of code.
> Reported by checkpatch.
>
> Signed-off-by: Mitali Borkar <mitaliborkar810@gmail.com>
> ---
>  drivers/staging/rtl8192e/rtl819x_HTProc.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/staging/rtl8192e/rtl819x_HTProc.c b/drivers/staging/rtl8192e/rtl819x_HTProc.c
> index 65202dd53447..0b1e92f17805 100644
> --- a/drivers/staging/rtl8192e/rtl819x_HTProc.c
> +++ b/drivers/staging/rtl8192e/rtl819x_HTProc.c
> @@ -276,7 +276,7 @@ void HTConstructCapabilityElement(struct rtllib_device *ieee, u8 *posHTCap,
>  	struct rt_hi_throughput *pHT = ieee->pHTInfo;
>  	struct ht_capab_ele *pCapELE = NULL;
>
> -	if ((posHTCap == NULL) || (pHT == NULL)) {
> +	if ((!posHTCap) || (!pHT)) {

You can drop the parentheses. ! has higher precedenace than ||.

julia

>  		netdev_warn(ieee->dev,
>  			    "%s(): posHTCap and pHTInfo are null\n", __func__);
>  		return;
> @@ -357,7 +357,7 @@ void HTConstructInfoElement(struct rtllib_device *ieee, u8 *posHTInfo,
>  	struct rt_hi_throughput *pHT = ieee->pHTInfo;
>  	struct ht_info_ele *pHTInfoEle = (struct ht_info_ele *)posHTInfo;
>
> -	if ((posHTInfo == NULL) || (pHTInfoEle == NULL)) {
> +	if ((!posHTInfo) || (!pHTInfoEle)) {
>  		netdev_warn(ieee->dev,
>  			    "%s(): posHTInfo and pHTInfoEle are null\n",
>  			    __func__);
> @@ -397,7 +397,7 @@ void HTConstructInfoElement(struct rtllib_device *ieee, u8 *posHTInfo,
>  void HTConstructRT2RTAggElement(struct rtllib_device *ieee, u8 *posRT2RTAgg,
>  				u8 *len)
>  {
> -	if (posRT2RTAgg == NULL) {
> +	if (!posRT2RTAgg) {
>  		netdev_warn(ieee->dev, "%s(): posRT2RTAgg is null\n", __func__);
>  		return;
>  	}
> @@ -420,7 +420,7 @@ static u8 HT_PickMCSRate(struct rtllib_device *ieee, u8 *pOperateMCS)
>  {
>  	u8 i;
>
> -	if (pOperateMCS == NULL) {
> +	if (!pOperateMCS) {
>  		netdev_warn(ieee->dev, "%s(): pOperateMCS is null\n", __func__);
>  		return false;
>  	}
> @@ -453,7 +453,7 @@ u8 HTGetHighestMCSRate(struct rtllib_device *ieee, u8 *pMCSRateSet,
>  	u8		mcsRate = 0;
>  	u8		availableMcsRate[16];
>
> -	if (pMCSRateSet == NULL || pMCSFilter == NULL) {
> +	if (!pMCSRateSet || !pMCSFilter) {
>  		netdev_warn(ieee->dev,
>  			    "%s(): pMCSRateSet and pMCSFilter are null\n",
>  			    __func__);
> --
> 2.30.2
>
> --
> You received this message because you are subscribed to the Google Groups "outreachy-kernel" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to outreachy-kernel+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/outreachy-kernel/YHEJngq5MHBEspGY%40kali.
>
