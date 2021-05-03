Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AD4F371674
	for <lists+linux-kernel@lfdr.de>; Mon,  3 May 2021 16:13:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234213AbhECOOG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 May 2021 10:14:06 -0400
Received: from mail-eopbgr00111.outbound.protection.outlook.com ([40.107.0.111]:61700
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229900AbhECOOE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 May 2021 10:14:04 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=imvzv2jUQZsLGHQO/Mm/m1G3qmgBkzyW57eyvlz5ZYF2cGhF6Hbu2w07MyBpbYQQr8Ac5+/a+N2gKmxL/97mcfLgV9Q7F5LLpP/7t6YxAVnqJecaRR8Yy6wKZ76Ys08oBRHPkVkEWUM97ZllQsqwn+yguVaftseYSs2xZC6fizmKrZj8DvTnjvZID3tT4KQz6fvPjjwNGfPiOh08ybqp/EUNBDlljtvSBz/gV9LgRdQfpFt7I9ICF8Btjk/Uceybr2Ke9D9Bk1uBICKGcjsyYNKlhnIktmdO0DOMDPfxJb7U22n1Fcey0oSy0BxC/tlh8nGttp2xuOGR3/wOJhh0WA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RPmT2W6n5g0SxSWdQ82dO2Y6YSh3oZbUQ2DFQrMm1HI=;
 b=g7C5ASHs7jxQQJxzOJkrzmtfHPv1KUa9FTOOBWQ6ge4uOonBmGbbCpqJqrsS+DvJM36JxTt++07GO0hLujTFSTaBTPZu1oiV7fO3FRa5t5QhpJiOajt/9ctcKGn+AZphS5N5lLMysoom5GpsAvtR6MJeHF67ZkU5ypjJarzkLVMPukBgY1HELbTiBGZePhTXYQTHp3T/7h6HM0ULU6ku1/outN2A4asWH7Uoyj6uu7dtGMundILKa3ZLJSYm9xtuKgKGedS1kPJIeWYQA4A5EW7NugvqgoG8WOjQWJJl8HNcmcsHRRoZ4aEgdIepJtKWC7HYABJZRTzMv5cWiZ2yaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kontron.de; dmarc=pass action=none header.from=kontron.de;
 dkim=pass header.d=kontron.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mysnt.onmicrosoft.com;
 s=selector2-mysnt-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RPmT2W6n5g0SxSWdQ82dO2Y6YSh3oZbUQ2DFQrMm1HI=;
 b=NfEgLy3uGUXL7h5AsIOSbIhhJVs0oIeIKG8k2KCkh/BJfsgQfrkiVrDPS3VBVqEenwbn6EU2f1gjfNaXRTq/2q2uVwQXTjZgnmjWgptnF7cQmcMXLwoWepMd/qGG/mLOroBLhkT3STEkHvRGMCsdIKmcd/hoRkTCH3yb9oBmmzY=
Authentication-Results: nxp.com; dkim=none (message not signed)
 header.d=none;nxp.com; dmarc=none action=none header.from=kontron.de;
Received: from AM0PR10MB2963.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:157::14)
 by AM9PR10MB4529.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:26e::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.38; Mon, 3 May
 2021 14:13:09 +0000
Received: from AM0PR10MB2963.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::3d8a:f56b:3a0c:8a87]) by AM0PR10MB2963.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::3d8a:f56b:3a0c:8a87%7]) with mapi id 15.20.4087.044; Mon, 3 May 2021
 14:13:09 +0000
Subject: Re: [PATCH 04/16] soc: imx: gpcv2: split power up and power down
 sequence control
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>, robh+dt@kernel.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        p.zabel@pengutronix.de, l.stach@pengutronix.de, krzk@kernel.org,
        agx@sigxcpu.org, marex@denx.de, andrew.smirnov@gmail.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, ping.bai@nxp.com, aford173@gmail.com,
        abel.vesa@nxp.com
References: <20210429073050.21039-1-peng.fan@oss.nxp.com>
 <20210429073050.21039-5-peng.fan@oss.nxp.com>
From:   Frieder Schrempf <frieder.schrempf@kontron.de>
Message-ID: <0ce76966-27e7-84ae-5848-4b7b164c27db@kontron.de>
Date:   Mon, 3 May 2021 16:13:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
In-Reply-To: <20210429073050.21039-5-peng.fan@oss.nxp.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [109.250.134.29]
X-ClientProxiedBy: AS8PR04CA0030.eurprd04.prod.outlook.com
 (2603:10a6:20b:310::35) To AM0PR10MB2963.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:157::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.10.27] (109.250.134.29) by AS8PR04CA0030.eurprd04.prod.outlook.com (2603:10a6:20b:310::35) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.27 via Frontend Transport; Mon, 3 May 2021 14:13:08 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fb83ea83-daa7-4f2d-c800-08d90e3d9412
X-MS-TrafficTypeDiagnostic: AM9PR10MB4529:
X-Microsoft-Antispam-PRVS: <AM9PR10MB45296527AA2DC78CDC786B9BE95B9@AM9PR10MB4529.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: X0zVOtKONaKhGw57ESXuXSKy7I0aJdG2gsl4Xgw+Rx+6cNgu8XwRODvY7XLzDTx9BZyutQ2si3nDS3KT1I/emj+0k5JtwM2mlx3O8BWE4YzeYZfADyN6uUxr2t1SWBjzA7N76TyNf7ImmXYpBF7kIADUNBQ4ZZ/BvVef9cy+1qC+wl3G4oqolzIbxYkrcuZBa0d1YhS4EaWJSiJEeAE0qD2818WDvMm51gUG22zhmVjqS7wLI0ppSl5petDVokh9vhiJubfDYTsCS8hHR20F3Y95XtZcIWy/0YVu19SUhqDpXM79iQsKstLQb4G7nBLlNRG3C5Y5t6cKdwTZbMEfIKGXwuGLuo+Oo4O/VKxMuxqha0kwu5E0aQBj08t4+zirfMFTQwl79bFP0oF2Alj+d2kTNQklO2uhwACnWIsiJSrBFdbSPOpvojBPZU3XRq2jDBAo6RUx9m19Ra3SMbUdKXhOSYCK7PloqcP5VMTjMJ26mmElMt+yuXcUs1uemwjoi0K2KJCS81HfFCYHctf6a6BjpcnvZh5Z1BJ3uED9UG5HOMwvgyDoHtfCU9d8bjBRs8cG2G0lCiK03wOMeT5+0Xt0oRn5uNxkijbhIJq78WvX7m+kz4n8Q+MTSyI890MWB4nhOhi9Owi1+GVecswxUKzZ0j+UBpb4G37dvLBcDKQqk3pLD9+g5MQgUz5JwFQr
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR10MB2963.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(136003)(346002)(396003)(39850400004)(366004)(376002)(66556008)(66946007)(66476007)(8936002)(8676002)(186003)(16526019)(26005)(956004)(2616005)(6486002)(16576012)(316002)(86362001)(36756003)(53546011)(31696002)(5660300002)(7416002)(38100700002)(2906002)(478600001)(31686004)(44832011)(4326008)(83380400001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?WmoxeHBqYVdyK001b1VRZTdHekRsd3FDbmQ5UGR1RElqZEZSS3B3VDNzZW9s?=
 =?utf-8?B?bzZKWTdHM2w1ZEZvdXlWNDVuVVhHeHhGMVZqSytROE1wTk9adUx6aHJ6aGNU?=
 =?utf-8?B?dW5wRThrdkkrWk5oTnUrcGdIQlY2Q3Y0MjU5cXdTc1Z3ZjREWTBWbEgyMTJD?=
 =?utf-8?B?elROclJ0emllT0tpc09OK25pUHZUQUhBdVAvdDV1dm9LMjFsb2N5WGVDZEhP?=
 =?utf-8?B?YmNRYW1uTEZoN3hxNUJabGRTMUtMZjFaVXNJL1Z5a0UxYWIrMFN0c21FaWlV?=
 =?utf-8?B?Rks1NzVic1FsNXE2TTc0aXVlYkpGczVMakJIQ0QrUWprU1d3ZkVCYTlhVEk3?=
 =?utf-8?B?Q3hNM2dPUFFBTnAzZ0hZTDRDYmJnYVNvVzJ0dnJ6dmVnNEc1OFp5cHRvWUtI?=
 =?utf-8?B?QnBFM0I0dHN5dGhCamI2SmYwSkNPSzFZQzBGVnlGY05oa2tYaUthc0d2d09U?=
 =?utf-8?B?Q3NRUjh0SmZrY2NKLzMyL0pOYlg5Qk1XK21NSDFaM3l3cUo1VUw4cm9xYktI?=
 =?utf-8?B?dnU1NWdCNDNkTUN5bnFjcVpWck5QNE01ZFJBMDJiZTFHMFBKUlZHTHZEV2cr?=
 =?utf-8?B?MENtNFNOdUlkc1EzeS85MTM4emQ0MmFDRGJKL1JoNjE5cFowRFFCa1l3UHpX?=
 =?utf-8?B?R2NSdFVPVFd3cFVoeTZoek1HcXFkbHpNWGlGSGI0Q2VUL0NldEk4T29BNkxq?=
 =?utf-8?B?dXR5UUNaN29sM3oydllTN3QwZCt2YzF3YTU2cGlyS09CeHV1RkFBVWJHVUds?=
 =?utf-8?B?Nlk0blRDbWQ3UjB2QThOTlRUS2F1Z0Zqc3pmT0MrYmxIUHNwSFhVQ3U5MjAy?=
 =?utf-8?B?UVdWbk0xYkxHRCsyOG1iaEFwTExnbXdDemdvUEhlcG5QWlNXbnZOd3FaaUc1?=
 =?utf-8?B?aVhNK3pxQjUxbFJIU3Y4Rk9YKzcvbXFoMytHU29ac0VVdTJrN1FNSFlQb25v?=
 =?utf-8?B?Z1F1U0ZEd0k3VVJyVnlvYXZ2blorQnJ6Wmx6U2R6ZXNid09FaVZYT3lNUFVm?=
 =?utf-8?B?QnhxWjVFTEZoU0tKZ29qM3o3OGZpczhBcEMxeE9oVG9TRXNwYjVSVGZzYWg3?=
 =?utf-8?B?RXFaMGEyQTJuQ0wwRGRLUVMvTHorL3JqRnFKRDhtNFg1TFFIT0RxaXJXY0Mr?=
 =?utf-8?B?OFR6THA0bnM2SkEvd1U4R1VqSnpURVFxVDdQdVdaVnlkN1RvalNRekRibUd3?=
 =?utf-8?B?b1VKNERiZXo2d2ZzUkVEdUoyNWlVSXdDS3g5RVFoU0EzTEpFb1c4T3JvYlNo?=
 =?utf-8?B?TmRPNVMycHJXY1RjdkI3SDlvYnFDUHE1cExucUtINVRVVjhwa3c1RHI5NlFx?=
 =?utf-8?B?ODhKVUNQQ1RIeEhINW1MOVpBeCs3U2lmLzdzR2JFYWVBcnI1U1AzTjhHaWh0?=
 =?utf-8?B?a1Z4SDdrN1ZnVVBVa2lrZUlKN0crR3RScmp4U08vUmZGWHl5YXpsYzZqUGM5?=
 =?utf-8?B?SFlHWUwyZ2RVZUs4Wm95WUVMR0ZxODRTWm1ra2lMeTFzMlVnYXZkeEtjYkZa?=
 =?utf-8?B?aDNQWTNtUGgwS2xCS1JqVGpmTW5jNGNtOVRydjNLUklXbHl4anRDaEhRSlVB?=
 =?utf-8?B?MlVtMmQ0aDdvdCtjYTJOWEh6aEhqcjJQQTAvVm5UcVhGN2R5cTVPZ0tYR0pv?=
 =?utf-8?B?eGFLb0t0Q0xwbHNkNCtYM2ltYXdxTFdUTzJIMVo5SUJiSXRLdjcvbWpnd3dW?=
 =?utf-8?B?NmVha1dHQ3JaTnAwSldGSlM3dmMvd1k2UmFyZWxzUjdJdDRTa29BM2ZvckN3?=
 =?utf-8?Q?9igWi8dRRkDgB8KMVfDvLFhYYgC73dILtpohBGl?=
X-OriginatorOrg: kontron.de
X-MS-Exchange-CrossTenant-Network-Message-Id: fb83ea83-daa7-4f2d-c800-08d90e3d9412
X-MS-Exchange-CrossTenant-AuthSource: AM0PR10MB2963.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2021 14:13:09.1107
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8c9d3c97-3fd9-41c8-a2b1-646f3942daf1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9FSsYlCJQvGUHy3YIV5QS2l+ApdSSdXPOhCz0g6RxdH14Vr2zkdJqgCc7PGK64P5fNSjON7/FVyFzqX54D529iNJleOV+uCRyQz3+sLp1cU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR10MB4529
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29.04.21 09:30, Peng Fan (OSS) wrote:
> From: Lucas Stach <l.stach@pengutronix.de>
> 
> The current mixed function to control both power up and power down
> sequences is very hard to follow and already contains some sequence
> errors like triggering the ADB400 handshake at the wrong time due to
> this. Split the function into two, which results in slightly more
> code, but is way easier to get right.
> 
> Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
> ---
>   drivers/soc/imx/gpcv2.c | 141 ++++++++++++++++++++++++----------------
>   1 file changed, 86 insertions(+), 55 deletions(-)
> 
> diff --git a/drivers/soc/imx/gpcv2.c b/drivers/soc/imx/gpcv2.c
> index 1d90c7802972..7356e48ebdad 100644
> --- a/drivers/soc/imx/gpcv2.c
> +++ b/drivers/soc/imx/gpcv2.c
> @@ -125,20 +125,19 @@ struct imx_pgc_domain_data {
>   	const struct regmap_access_table *reg_access_table;
>   };
>   
> -static int imx_gpc_pu_pgc_sw_pxx_req(struct generic_pm_domain *genpd,
> -				      bool on)
> +static inline struct imx_pgc_domain *
> +to_imx_pgc_domain(struct generic_pm_domain *genpd)
>   {
> -	struct imx_pgc_domain *domain = container_of(genpd,
> -						      struct imx_pgc_domain,
> -						      genpd);
> -	unsigned int offset = on ?
> -		GPC_PU_PGC_SW_PUP_REQ : GPC_PU_PGC_SW_PDN_REQ;
> -	const bool enable_power_control = !on;
> -	const bool has_regulator = !IS_ERR(domain->regulator);
> -	int i, ret = 0;
> -	u32 pxx_req;
> -
> -	if (has_regulator && on) {
> +	return container_of(genpd, struct imx_pgc_domain, genpd);
> +}
> +
> +static int imx_pgc_power_up(struct generic_pm_domain *genpd)
> +{
> +	struct imx_pgc_domain *domain = to_imx_pgc_domain(genpd);
> +	u32 reg_val;
> +	int ret;
> +
> +	if (!IS_ERR(domain->regulator)) {
>   		ret = regulator_enable(domain->regulator);
>   		if (ret) {
>   			dev_err(domain->dev, "failed to enable regulator\n");
> @@ -147,72 +146,104 @@ static int imx_gpc_pu_pgc_sw_pxx_req(struct generic_pm_domain *genpd,
>   	}
>   
>   	/* Enable reset clocks for all devices in the domain */
> -	clk_bulk_prepare_enable(domain->num_clks, domain->clks);
> +	ret = clk_bulk_prepare_enable(domain->num_clks, domain->clks);

As mentioned, the change above should be moved to patch 03/16.

>   	if (ret) {
>   		dev_err(domain->dev, "failed to enable reset clocks\n");
> +		goto out_regulator_disable;
> +	}
> +
> +	/* request the domain to power up */
> +	regmap_update_bits(domain->regmap, GPC_PU_PGC_SW_PUP_REQ,
> +			   domain->bits.pxx, domain->bits.pxx);
> +	/*
> +	 * As per "5.5.9.4 Example Code 4" in IMX7DRM.pdf wait
> +	 * for PUP_REQ/PDN_REQ bit to be cleared
> +	 */
> +	ret = regmap_read_poll_timeout(domain->regmap, GPC_PU_PGC_SW_PUP_REQ,
> +				       reg_val, !(reg_val & domain->bits.pxx),
> +				       0, USEC_PER_MSEC);
> +	if (ret) {
> +		dev_err(domain->dev, "failed to command PGC\n");
> +		goto out_clk_disable;
> +	}
> +
> +	/* disable power control */
> +	regmap_update_bits(domain->regmap, GPC_PGC_CTRL(domain->pgc),
> +			   GPC_PGC_CTRL_PCR, 0);

As we already touch this here, we could also simplify this a bit using 
regmap_clear_bits() instead.

> +
> +	/* request the ADB400 to power up */
> +	if (domain->bits.hsk)
> +		regmap_update_bits(domain->regmap, GPC_PU_PWRHSK,
> +				   domain->bits.hsk, domain->bits.hsk);
> +
> +	/* Disable reset clocks for all devices in the domain */
> +	clk_bulk_disable_unprepare(domain->num_clks, domain->clks);
> +
> +	return 0;
> +
> +out_clk_disable:
> +	clk_bulk_disable_unprepare(domain->num_clks, domain->clks);
> +out_regulator_disable:
> +	if (!IS_ERR(domain->regulator))
>   		regulator_disable(domain->regulator);
> +
> +	return ret;
> +}
> +
> +static int imx_pgc_power_down(struct generic_pm_domain *genpd)
> +{
> +	struct imx_pgc_domain *domain = to_imx_pgc_domain(genpd);
> +	u32 reg_val;
> +	int ret;
> +
> +	/* Enable reset clocks for all devices in the domain */
> +	ret = clk_bulk_prepare_enable(domain->num_clks, domain->clks);
> +	if (ret) {
> +		dev_err(domain->dev, "failed to enable reset clocks\n");
>   		return ret;
>   	}
>   
> -	if (enable_power_control)
> -		regmap_update_bits(domain->regmap, GPC_PGC_CTRL(domain->pgc),
> -				   GPC_PGC_CTRL_PCR, GPC_PGC_CTRL_PCR);
> -
> +	/* request the ADB400 to power down */
>   	if (domain->bits.hsk)
>   		regmap_update_bits(domain->regmap, GPC_PU_PWRHSK,
> -				   domain->bits.hsk, on ? domain->bits.hsk : 0);
> +				   domain->bits.hsk, 0);

See above, regmap_clear_bits()

>   
> -	regmap_update_bits(domain->regmap, offset,
> -			   domain->bits.pxx, domain->bits.pxx);
> +	/* enable power control */
> +	regmap_update_bits(domain->regmap, GPC_PGC_CTRL(domain->pgc),
> +			   GPC_PGC_CTRL_PCR, GPC_PGC_CTRL_PCR);
>   
> +	/* request the domain to power down */
> +	regmap_update_bits(domain->regmap, GPC_PU_PGC_SW_PDN_REQ,
> +			   domain->bits.pxx, domain->bits.pxx);
>   	/*
>   	 * As per "5.5.9.4 Example Code 4" in IMX7DRM.pdf wait
>   	 * for PUP_REQ/PDN_REQ bit to be cleared
>   	 */
> -	ret = regmap_read_poll_timeout(domain->regmap, offset, pxx_req,
> -				       !(pxx_req & domain->bits.pxx),
> +	ret = regmap_read_poll_timeout(domain->regmap, GPC_PU_PGC_SW_PDN_REQ,
> +				       reg_val, !(reg_val & domain->bits.pxx),
>   				       0, USEC_PER_MSEC);
>   	if (ret) {
>   		dev_err(domain->dev, "failed to command PGC\n");
> -		/*
> -		 * If we were in a process of enabling a
> -		 * domain and failed we might as well disable
> -		 * the regulator we just enabled. And if it
> -		 * was the opposite situation and we failed to
> -		 * power down -- keep the regulator on
> -		 */
> -		on = !on;
> +		goto out_clk_disable;
>   	}
>   
> -	if (enable_power_control)
> -		regmap_update_bits(domain->regmap, GPC_PGC_CTRL(domain->pgc),
> -				   GPC_PGC_CTRL_PCR, 0);
> -
>   	/* Disable reset clocks for all devices in the domain */
>   	clk_bulk_disable_unprepare(domain->num_clks, domain->clks);
>   
> -	if (has_regulator && !on) {
> -		int err;
> -
> -		err = regulator_disable(domain->regulator);
> -		if (err)
> -			dev_err(domain->dev,
> -				"failed to disable regulator: %d\n", err);
> -		/* Preserve earlier error code */
> -		ret = ret ?: err;
> +	if (!IS_ERR(domain->regulator)) {
> +		ret = regulator_disable(domain->regulator);
> +		if (ret) {
> +			dev_err(domain->dev, "failed to disable regulator\n");
> +			return ret;
> +		}
>   	}
>   
> -	return ret;
> -}
> +	return 0;
>   
> -static int imx_gpc_pu_pgc_sw_pup_req(struct generic_pm_domain *genpd)
> -{
> -	return imx_gpc_pu_pgc_sw_pxx_req(genpd, true);
> -}
> +out_clk_disable:
> +	clk_bulk_disable_unprepare(domain->num_clks, domain->clks);
>   
> -static int imx_gpc_pu_pgc_sw_pdn_req(struct generic_pm_domain *genpd)
> -{
> -	return imx_gpc_pu_pgc_sw_pxx_req(genpd, false);
> +	return ret;
>   }
>   
>   static const struct imx_pgc_domain imx7_pgc_domains[] = {
> @@ -590,8 +621,8 @@ static int imx_gpcv2_probe(struct platform_device *pdev)
>   
>   		domain = pd_pdev->dev.platform_data;
>   		domain->regmap = regmap;
> -		domain->genpd.power_on  = imx_gpc_pu_pgc_sw_pup_req;
> -		domain->genpd.power_off = imx_gpc_pu_pgc_sw_pdn_req;
> +		domain->genpd.power_on  = imx_pgc_power_up;
> +		domain->genpd.power_off = imx_pgc_power_down;
>   
>   		pd_pdev->dev.parent = dev;
>   		pd_pdev->dev.of_node = np;
> 
