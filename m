Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5722F371611
	for <lists+linux-kernel@lfdr.de>; Mon,  3 May 2021 15:37:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234346AbhECNim (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 May 2021 09:38:42 -0400
Received: from mail-db8eur05on2133.outbound.protection.outlook.com ([40.107.20.133]:37057
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233582AbhECNid (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 May 2021 09:38:33 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GzuFER0TspLsR0ZxYwwCZGj3ciBMQ4+8i4GXAoD/qCjoBkTeMewR61GbHt90Knbjrx3Y3484BsYjPgU1UPaRhm2zUzVLeJ9T4iX/3jxM1xEw+GM52mio3M2AEgM7X5E44y6PL5GDqrHx4IF9ClrlflvlfWEFnLscu9RjDfc7nhNeiWwL6mEJW7rEDVt2n+YyD/SZ/fyqhw2NWfmM2vAx3E2Wjp2NVwX2Ubb6pQYGVqS0jFHBGouvyo7kDl0nnhR1FFJoJnjOh1pqHUyxsMWGRwsnuWkO+MLWG7P3t3gwiur7mdWVvTiQEWnZoujLnZoAxL9JhB0SuA8fRQj35MRjOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LMqRouZLqSLd8cVUXItu3Wk0i4YymEROaIPTjAm9kG8=;
 b=VzKI7sNR2HMZHhjLxSVGU8UmNt/jdnppABTJ+yB05bORn5h2OKAHrZI+fTY35XRgXmUYEIt2U9iuKWOTWrPcDst7TOzrEspiITvwDS3SLMmXutBrVx6WDQ/iKk7lF45TDwTAWLGRi8cHMFC5z8RFt9ZMj5Pntf/qxQRXuJYybzO9IvDnaJKFuG+Q/f7MaxX0nEPU+F2BxdoUDO98lCIMoC1Fy+GGpXxsZVGBtjZwbBagubHxfLf3UJSuXCl3Tf0OrjrBFiiWe2KSDX28I9Tmu/PC4dWtjrq4grsv6R9gtR3IOku4HsJoOOiGcA6T/2Z7H9nqrZAq3w88t1pJ+6reFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kontron.de; dmarc=pass action=none header.from=kontron.de;
 dkim=pass header.d=kontron.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mysnt.onmicrosoft.com;
 s=selector2-mysnt-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LMqRouZLqSLd8cVUXItu3Wk0i4YymEROaIPTjAm9kG8=;
 b=A6V7A2ZVfCQVDR4t3cT05Pq5lHT6PP8rEPeyfTRvVJYwQRDMj4NopIjN8iX9cckQVzi7Vl2SR8VaUxPoiZTYUGiuxMyHSPv9gGPkBhe4i1zkbMbP+N8+7M/ij33uLep/s9rVk2d5xFV3kbaXhDpFBVx4gzUYx39iQs7/ci6rEMY=
Authentication-Results: nxp.com; dkim=none (message not signed)
 header.d=none;nxp.com; dmarc=none action=none header.from=kontron.de;
Received: from AM0PR10MB2963.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:157::14)
 by AM0PR10MB2484.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:d7::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.40; Mon, 3 May
 2021 13:37:38 +0000
Received: from AM0PR10MB2963.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::3d8a:f56b:3a0c:8a87]) by AM0PR10MB2963.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::3d8a:f56b:3a0c:8a87%7]) with mapi id 15.20.4087.044; Mon, 3 May 2021
 13:37:38 +0000
Subject: Re: [PATCH 03/16] soc: imx: gpcv2: switch to clk_bulk_* API
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>, robh+dt@kernel.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        p.zabel@pengutronix.de, l.stach@pengutronix.de, krzk@kernel.org,
        agx@sigxcpu.org, marex@denx.de, andrew.smirnov@gmail.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, ping.bai@nxp.com, aford173@gmail.com,
        abel.vesa@nxp.com
References: <20210429073050.21039-1-peng.fan@oss.nxp.com>
 <20210429073050.21039-4-peng.fan@oss.nxp.com>
From:   Frieder Schrempf <frieder.schrempf@kontron.de>
Message-ID: <a3d75d88-421b-b10b-c16e-d46b77078a53@kontron.de>
Date:   Mon, 3 May 2021 15:37:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
In-Reply-To: <20210429073050.21039-4-peng.fan@oss.nxp.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [109.250.134.29]
X-ClientProxiedBy: AM0PR05CA0094.eurprd05.prod.outlook.com
 (2603:10a6:208:136::34) To AM0PR10MB2963.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:157::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.10.27] (109.250.134.29) by AM0PR05CA0094.eurprd05.prod.outlook.com (2603:10a6:208:136::34) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.27 via Frontend Transport; Mon, 3 May 2021 13:37:36 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a58d8bd9-3627-48c7-4b4a-08d90e389db8
X-MS-TrafficTypeDiagnostic: AM0PR10MB2484:
X-Microsoft-Antispam-PRVS: <AM0PR10MB248455A886314D85FAE91E3FE95B9@AM0PR10MB2484.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:4714;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Mw0+RKUeAhZzppnDXDaq5Ains1B4PKUhrFxy8CtRFAXpO9hUPiackvpqcMOhX/hMOMVgkZslKzoBSFxldhhmypej52hbE5aafmBCabisxznBmjvwKcjfxKXPFpcM/2AAm5EiVsT34Bo91wjaPwsYLvcJKRaVuMXNsS5Pcqq7rW2brV0/RAPkY51EoABoimspqcKYDU5o0JnA8YJ2U/lYNdSvvC3yx8He1JBLckA20q5g1T7VHNrgw2tbh+PWzbLskRymMjwsrTiI3KQyAmwEvk5vGC1fwu6u+WF4N7JGiDm4+VTdH4M0GQzJec9bmpeMzuGKhv+R+ao5XWSmFx0t7yj7XrYEwl9veHsN6SgBipGpQ+Jcjx4usf11iiaaUcU5+v3iei9ggoGpnfEHbyIsNbxDTaEUt22Z5h0+p3acAJZa5CGlI0swwKYQ8TSiqlm23fwTzbXskmZD9Cv3LwdqbJKoR3yDlR7ZRzq/t3yotsOiID9B3SEEmfdFOaZrfYSdONmEiwKlnESmZ/idOjfBZsYqzTvwBaiwX63ETFsr7Lc6y3ydd6AxxDMM/XNPDCu9Iycy8r05tPRvaCclVxmcLGOLvYOoYiHq3u3lc+3V/D95L+/KB2kzaJA/T4utQK0byALP6INlJh6EPAnmFWGl5bMXYSmtsD4dqig93svZzTbBnHwn23DTun6TM20WDgXL
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR10MB2963.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(376002)(366004)(39850400004)(396003)(346002)(136003)(83380400001)(44832011)(26005)(2906002)(53546011)(66556008)(7416002)(2616005)(956004)(31696002)(4326008)(86362001)(31686004)(38100700002)(16526019)(8936002)(5660300002)(6486002)(316002)(186003)(36756003)(16576012)(478600001)(8676002)(66476007)(66946007)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?dVdoaUZCMStaVjVHem9jSkdPMXRmWG96RUUxUEw1VVlZQkx6TTcybmMrSUZ3?=
 =?utf-8?B?N2FOcENwdnVrVjUyTVV3ZTE4elNNTVZUcEQ4SXFNNm43czRwckQ1Qy95RUhO?=
 =?utf-8?B?NjdoMGRSM3RhWGFBcUVGU1hwalZ6VDZpUGRVT2lyWExoNXJCV1pzSFJKRFBM?=
 =?utf-8?B?RFdjT21EVVlxQzNUaVl5UHNnazVwanpwcVFMMUEyYVdMSWk5Y1prM3JaRTgw?=
 =?utf-8?B?YThoeVhDSWc0bWIzdTB1U3BwRkQ1UU01T2ExKzBBSWxTVWVpdGxNd2hZR0E2?=
 =?utf-8?B?OVpQdkpmN3R1ZEQwcDgrbjJiWjZIL0dQV0p2SEt6VC8zVlJ2MFA3MTR0RGQz?=
 =?utf-8?B?cVlGMUFmdVY3cU5aczFQTHFTYTJ2cnJyQlVLSXpaY1lHVzVVR3FmK29rNjRI?=
 =?utf-8?B?M0VVTTV2MDN6SmcxSU52c08wQTUzZ1ZiUnErbkVUck9OMytWV3o4aDlDR045?=
 =?utf-8?B?L2xxSU10OTBza1N5alhDZVNrYjNnbzVraVdCN0dMRGdacTREVUtnZHhqNWF6?=
 =?utf-8?B?OUM5UFNENW5SNEhQcnpoYkZCYVZPMzE0TU5zdXlVNjNweUI5NlBJZm1uWkFx?=
 =?utf-8?B?ak0zbCtFUVpLR2haU1poZEh2RDZiSENadEVRQXVJdld0di94bStkajUyMTVK?=
 =?utf-8?B?elFzMDdpazR6bmRxTTNVK0JQQXl5ZWlDSTRXTzlueHpMdXVSUVRZOXQvTU9N?=
 =?utf-8?B?Z29XY2NQUGlWNG9ROGNxVU1Ga3FnMmVPNlNkaTN5c1JZZE1HQTVIbWNiMlJX?=
 =?utf-8?B?VFN4eHFCa2RVQlZyRk5pdjN0cVJzL1dZVHJQZ0FHMVNMbmdtalk3Ulh6cVZa?=
 =?utf-8?B?NFZWcWJVczBmZ1ZLb3FrVGZiWCtXbXFhWVpIUFhKU0RQclJBS3hEU25VOCtk?=
 =?utf-8?B?N2pWellVNlBiMWd2dVZHdGYrT0ovblNCQS9UTGZ2bkZoUEJLUU5HQ3RUMzg4?=
 =?utf-8?B?NjYweEQwOEgyUXJVeGx4aHIxdDZjTUxvbHN6ZHZicGdySEx1dXB2bG8ya0Y1?=
 =?utf-8?B?Tm54aXdhUUlIQnZHUkwvUFNXQjFhZm1sUkgycm4vZGVoS0lGVVc5aHQ1SFpY?=
 =?utf-8?B?S2pMUFNCUTBQT3JuTlRmcnJ5dXpNWW11dXlZZlBFanpSdG1HRmxhQ3RqN2tR?=
 =?utf-8?B?djNDRkthYTlvWDhxYWNSOGY1bnFLeFVTYXByT3VmbHJVUkJXVUFJN2hRbDl5?=
 =?utf-8?B?aGN4OHFhZk1XSXI1TjRRa3ZmMUxRVHNibmZlVE9RL2xucDNNQW1KV2hDcDFB?=
 =?utf-8?B?VS80QkpVVjFNaFY3a0xkL1hrQU1UcE5pSzR3dWJnWXBPK3dXTVc1VHlqQmhY?=
 =?utf-8?B?RHhIVXVKbUVvbmUzYUNHSVo0YjVNNkowQlVadkViRTU0MW1GaGdCMVJxR2tj?=
 =?utf-8?B?dzgwNHJOTmJrajc1YS9JbkZZRzBKMmVQVVlzcEEwcUo0SG9oTTZGQ1pzWFpB?=
 =?utf-8?B?V0E0Q1JjZUQ1NCtvc29rQ0Q4eEZvRW52dTRka3JOOHZUeFNublNXeTdhRjlk?=
 =?utf-8?B?eEVGN3BWV2lRSmFNSXVLTEV0aFhXcVg3ZWFLRkwvTER2aU9DUzUydkxlc1RV?=
 =?utf-8?B?ZjJlV2hqVVFaUEV1MHJqT3FNdTlsVUR6K1R5SklhckFmVkc4TU5EbzRQZ3Zt?=
 =?utf-8?B?bXJ1Wml2NWtlZHRjbHJYaE01cHVmVjJOcm1JN1hJajJldUgxbTBmdG04Kzg4?=
 =?utf-8?B?b1MrbVN6SXdXNkIxTThVQjZUWTU3S2ZKSmF1MFVObWZaMkdHV3ZiOEJnR1Fu?=
 =?utf-8?Q?H9VdhNKLckFUb0ZhluqJ6v5ODRb9wwlG5YRVgaF?=
X-OriginatorOrg: kontron.de
X-MS-Exchange-CrossTenant-Network-Message-Id: a58d8bd9-3627-48c7-4b4a-08d90e389db8
X-MS-Exchange-CrossTenant-AuthSource: AM0PR10MB2963.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2021 13:37:37.9572
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8c9d3c97-3fd9-41c8-a2b1-646f3942daf1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sMHjGPE8cJhNGqNOfTT69hUHgOcIponiDetNc5LvSxkTW6ImW2bOqQRfFWtyw6IUL+sf3SlwtsGgaTupr+N1KEXjs5LvA7UTmjP8Rvaw0Sg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR10MB2484
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29.04.21 09:30, Peng Fan (OSS) wrote:
> From: Lucas Stach <l.stach@pengutronix.de>
> 
> Use clk_bulk API to simplify the code a bit. Also add some error
> checking to the clk_prepare_enable calls.
> 
> Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
> ---
>   drivers/soc/imx/gpcv2.c | 60 +++++++++--------------------------------
>   1 file changed, 12 insertions(+), 48 deletions(-)
> 
> diff --git a/drivers/soc/imx/gpcv2.c b/drivers/soc/imx/gpcv2.c
> index 552d3e6bee52..1d90c7802972 100644
> --- a/drivers/soc/imx/gpcv2.c
> +++ b/drivers/soc/imx/gpcv2.c
> @@ -100,13 +100,11 @@
>   
>   #define GPC_PGC_CTRL_PCR		BIT(0)
>   
> -#define GPC_CLK_MAX		6
> -
>   struct imx_pgc_domain {
>   	struct generic_pm_domain genpd;
>   	struct regmap *regmap;
>   	struct regulator *regulator;
> -	struct clk *clk[GPC_CLK_MAX];
> +	struct clk_bulk_data *clks;
>   	int num_clks;
>   
>   	unsigned int pgc;
> @@ -149,8 +147,12 @@ static int imx_gpc_pu_pgc_sw_pxx_req(struct generic_pm_domain *genpd,
>   	}
>   
>   	/* Enable reset clocks for all devices in the domain */
> -	for (i = 0; i < domain->num_clks; i++)
> -		clk_prepare_enable(domain->clk[i]);
> +	clk_bulk_prepare_enable(domain->num_clks, domain->clks);

Looks like this fails to catch the return value. This is fixed in patch 
04/13 but should happen here already. All the rest looks good to me.

> +	if (ret) {
> +		dev_err(domain->dev, "failed to enable reset clocks\n");
> +		regulator_disable(domain->regulator);
> +		return ret;
> +	}
>   
>   	if (enable_power_control)
>   		regmap_update_bits(domain->regmap, GPC_PGC_CTRL(domain->pgc),
> @@ -187,8 +189,7 @@ static int imx_gpc_pu_pgc_sw_pxx_req(struct generic_pm_domain *genpd,
>   				   GPC_PGC_CTRL_PCR, 0);
>   
>   	/* Disable reset clocks for all devices in the domain */
> -	for (i = 0; i < domain->num_clks; i++)
> -		clk_disable_unprepare(domain->clk[i]);
> +	clk_bulk_disable_unprepare(domain->num_clks, domain->clks);
>   
>   	if (has_regulator && !on) {
>   		int err;
> @@ -438,41 +439,6 @@ static const struct imx_pgc_domain_data imx8m_pgc_domain_data = {
>   	.reg_access_table = &imx8m_access_table,
>   };
>   
> -static int imx_pgc_get_clocks(struct imx_pgc_domain *domain)
> -{
> -	int i, ret;
> -
> -	for (i = 0; ; i++) {
> -		struct clk *clk = of_clk_get(domain->dev->of_node, i);
> -		if (IS_ERR(clk))
> -			break;
> -		if (i >= GPC_CLK_MAX) {
> -			dev_err(domain->dev, "more than %d clocks\n",
> -				GPC_CLK_MAX);
> -			ret = -EINVAL;
> -			goto clk_err;
> -		}
> -		domain->clk[i] = clk;
> -	}
> -	domain->num_clks = i;
> -
> -	return 0;
> -
> -clk_err:
> -	while (i--)
> -		clk_put(domain->clk[i]);
> -
> -	return ret;
> -}
> -
> -static void imx_pgc_put_clocks(struct imx_pgc_domain *domain)
> -{
> -	int i;
> -
> -	for (i = domain->num_clks - 1; i >= 0; i--)
> -		clk_put(domain->clk[i]);
> -}
> -
>   static int imx_pgc_domain_probe(struct platform_device *pdev)
>   {
>   	struct imx_pgc_domain *domain = pdev->dev.platform_data;
> @@ -490,9 +456,10 @@ static int imx_pgc_domain_probe(struct platform_device *pdev)
>   				      domain->voltage, domain->voltage);
>   	}
>   
> -	ret = imx_pgc_get_clocks(domain);
> -	if (ret)
> -		return dev_err_probe(domain->dev, ret, "Failed to get domain's clocks\n");
> +	domain->num_clks = devm_clk_bulk_get_all(domain->dev, &domain->clks);
> +	if (domain->num_clks < 0)
> +		return dev_err_probe(domain->dev, domain->num_clks,
> +				     "Failed to get domain's clocks\n");
>   
>   	regmap_update_bits(domain->regmap, GPC_PGC_CPU_MAPPING,
>   			   domain->bits.map, domain->bits.map);
> @@ -517,7 +484,6 @@ static int imx_pgc_domain_probe(struct platform_device *pdev)
>   out_domain_unmap:
>   	regmap_update_bits(domain->regmap, GPC_PGC_CPU_MAPPING,
>   			   domain->bits.map, 0);
> -	imx_pgc_put_clocks(domain);
>   
>   	return ret;
>   }
> @@ -532,8 +498,6 @@ static int imx_pgc_domain_remove(struct platform_device *pdev)
>   	regmap_update_bits(domain->regmap, GPC_PGC_CPU_MAPPING,
>   			   domain->bits.map, 0);
>   
> -	imx_pgc_put_clocks(domain);
> -
>   	return 0;
>   }
>   
> 
