Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C59F3C2174
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jul 2021 11:21:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231910AbhGIJYS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jul 2021 05:24:18 -0400
Received: from esa.microchip.iphmx.com ([68.232.153.233]:30098 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231913AbhGIJYQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jul 2021 05:24:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1625822493; x=1657358493;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=xnu5fiH3XiqlibW7t16ZbskhbU8t3Gem/ISjrQ//RO0=;
  b=bVjyqjRUgtcs1KarVT0su0D0YxyovH6fgZIUKR63gLbWcMYiRfkxv3m2
   6hYqgppnIXX+q37v+yxNwXpQ9TmBUH+1CAX2SMbXEO4j4DHtvrI6MiFtL
   hQ9EhsOf2B/B3DU/RC8QHwftOvSDNK4AOzXA6yArCr1M6R0Yewqcr84Nw
   7K1/weOk1TdUFjm68c2dxqNtxXCtat2g+hL7aEuhAA87025oVSAeuNOtO
   +xsxnVtxRmBs4Bh9YiorStrOGeizhGFHBSMOBzlhslHAsbhEu4o9heg5m
   BqfB3Dr/9Tp97xwbTbVG1vY8sg55IyDtZ0B72ZjkzKHMnzDBWclr3SCFY
   w==;
IronPort-SDR: ddEbgxlalOF9OW4SY+KYLwCN0uScEnOa/JJ1whBb0r/5PIFVXCTCANCGCX/Av5Dlb2k3XnTY+9
 CKpFbbMXGKkaSklLrE7hczmPwNDuYiM3oKgvJfnVc6bkzHfV1L7hkdwmojwwm3AykNWp7TDwZm
 pcY/6moSv3HPUT1yrXRdV1XaW+wU69sy5d/FwFxfhDMG0Bh9EUXMVTv0l9R1/40NLx6C5SLokl
 h9mfd4Dbv78qyyP9vQmDEbbVt+8tHRlZxhnicWA889qes2PWZV7Ffg1zzSq/z9aJ2lKcOcCYYa
 OLM=
X-IronPort-AV: E=Sophos;i="5.84,226,1620716400"; 
   d="scan'208";a="128227406"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 09 Jul 2021 02:21:33 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Fri, 9 Jul 2021 02:21:32 -0700
Received: from [10.12.72.46] (10.10.115.15) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server id 15.1.2176.2 via Frontend
 Transport; Fri, 9 Jul 2021 02:21:30 -0700
Subject: Re: [PATCH] clk: at91: clk-generated: Limit the requested rate to our
 range
To:     Codrin Ciubotariu <codrin.ciubotariu@microchip.com>,
        <linux-clk@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <alexandre.belloni@bootlin.com>, <ludovic.desroches@microchip.com>,
        <claudiu.beznea@microchip.com>
References: <20210707131213.3283509-1-codrin.ciubotariu@microchip.com>
From:   Nicolas Ferre <nicolas.ferre@microchip.com>
Organization: microchip
Message-ID: <7586cf33-078a-cb85-98c8-9969baa0f19d@microchip.com>
Date:   Fri, 9 Jul 2021 11:21:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210707131213.3283509-1-codrin.ciubotariu@microchip.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/07/2021 at 15:12, Codrin Ciubotariu wrote:
> On clk_generated_determine_rate(), the requested rate could be outside
> of clk's range. Limit the rate to the clock's range to not return an
> error.

Isn't it saner for the user to return an error code instead of 
automatically restrain the dynamics requested without notice?

Can you elaborate the use case where returning an error is not convenient?

Regards,
   Nicolas

> Fixes: df70aeef6083 ("clk: at91: add generated clock driver")
> Signed-off-by: Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
> ---
>   drivers/clk/at91/clk-generated.c | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/clk/at91/clk-generated.c b/drivers/clk/at91/clk-generated.c
> index b4fc8d71daf2..b656d25a9767 100644
> --- a/drivers/clk/at91/clk-generated.c
> +++ b/drivers/clk/at91/clk-generated.c
> @@ -128,6 +128,12 @@ static int clk_generated_determine_rate(struct clk_hw *hw,
>   	int i;
>   	u32 div;
>   
> +	/* do not look for a rate that is outside of our range */
> +	if (gck->range.max && req->rate > gck->range.max)
> +		req->rate = gck->range.max;
> +	if (gck->range.min && req->rate < gck->range.min)
> +		req->rate = gck->range.min;
> +
>   	for (i = 0; i < clk_hw_get_num_parents(hw); i++) {
>   		if (gck->chg_pid == i)
>   			continue;
> 


-- 
Nicolas Ferre
