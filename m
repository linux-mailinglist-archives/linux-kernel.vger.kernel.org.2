Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35053371686
	for <lists+linux-kernel@lfdr.de>; Mon,  3 May 2021 16:21:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229609AbhECOWi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 May 2021 10:22:38 -0400
Received: from mail-vi1eur05on2095.outbound.protection.outlook.com ([40.107.21.95]:30113
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229472AbhECOWh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 May 2021 10:22:37 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a1wEnFidN9APUuJWbODDDKJJDCK4YyTRQYCkiz0jcDBI0H/umVWyu5TJHkJXY30hGjk9p/AcSTj6Wgbpd2e01dODNdMR2t8wVlBfNx3nuWtDldUYZTDlnosOmCow11GjqFSmW5RRvjXgVUmNzp0cnzzJ2IJafrbGpPaeuxArrvUD4Vy2YKSQjxXGuvad3dswfgfNku0t70J79mpfiMpYkUrBKAnOA0U/SOj4pWae9Mhda5d6S473ccpi7Z1FQ6fIPGICm+QcDcr/ywhuuhyfyGPDiEvhMSD0XnTm9rZnxdoPYxTSGbmQDxWD79xt9Xu0HvvFgRlyB5K0zSR8BZdG+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YljL4jirMf+LgBeP8qwBakVFfKPHd3e5hA0fS0GmseM=;
 b=QASQTGBsvw0vTvkIa7B73GNYiavb+KOXNgvA1oDXgD+t56dvx1OI2EaHDUSrqKIEos6dCdbHaIY4RAi0GUJM7jQjnps0f/emUDhSbRYVs9rm36xvFesnKms4DXD0N4yoGWQQzobs4hLagr4yi1qpMEpIx0OhT2ykJVUrZy55DJpSq2COmDEFSP1Dqbyoz3cAualHx48yGPH3FTgr/IK5N6sbdWKUXx1BPB640zSzogLrI6/b9LGWLLPaqG5dP3xvKPCC2N1YcwD9x0ZD1UTBlYAAMzo+FnKP31A/NL0AOR8RBAzHQbWUnYFEiOWfKYdThADE5eshqfr77T0m71hLFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kontron.de; dmarc=pass action=none header.from=kontron.de;
 dkim=pass header.d=kontron.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mysnt.onmicrosoft.com;
 s=selector2-mysnt-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YljL4jirMf+LgBeP8qwBakVFfKPHd3e5hA0fS0GmseM=;
 b=QLAW+iT5S7MFOHpPFeS4k1dlp5DohqDMG/eGmXt+4qE1y7b8k8CtmAv0/8Z57AzCxVOhDXw4j5JzEPnyTbq2UA6ymwz1SI6N1ISQPcJ95K9F9xgq6b8lEIUzs1saEUYIDmBtnAIcXdCN7r1PRe6TWT9K7+Hmt7t2ipYDab0uZlA=
Authentication-Results: nxp.com; dkim=none (message not signed)
 header.d=none;nxp.com; dmarc=none action=none header.from=kontron.de;
Received: from AM0PR10MB2963.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:157::14)
 by AM8PR10MB4658.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:357::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.38; Mon, 3 May
 2021 14:21:41 +0000
Received: from AM0PR10MB2963.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::3d8a:f56b:3a0c:8a87]) by AM0PR10MB2963.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::3d8a:f56b:3a0c:8a87%7]) with mapi id 15.20.4087.044; Mon, 3 May 2021
 14:21:41 +0000
Subject: Re: [PATCH 07/16] soc: imx: gpcv2: allow domains without
 power-sequence control
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>, robh+dt@kernel.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        p.zabel@pengutronix.de, l.stach@pengutronix.de, krzk@kernel.org,
        agx@sigxcpu.org, marex@denx.de, andrew.smirnov@gmail.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, ping.bai@nxp.com, aford173@gmail.com,
        abel.vesa@nxp.com
References: <20210429073050.21039-1-peng.fan@oss.nxp.com>
 <20210429073050.21039-8-peng.fan@oss.nxp.com>
From:   Frieder Schrempf <frieder.schrempf@kontron.de>
Message-ID: <f384f461-fac4-5423-619f-e35a4abea7f5@kontron.de>
Date:   Mon, 3 May 2021 16:21:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
In-Reply-To: <20210429073050.21039-8-peng.fan@oss.nxp.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [109.250.134.29]
X-ClientProxiedBy: AM6P194CA0012.EURP194.PROD.OUTLOOK.COM
 (2603:10a6:209:90::25) To AM0PR10MB2963.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:157::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.10.27] (109.250.134.29) by AM6P194CA0012.EURP194.PROD.OUTLOOK.COM (2603:10a6:209:90::25) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.25 via Frontend Transport; Mon, 3 May 2021 14:21:40 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1d613b50-8488-4ca8-ca19-08d90e3ec58b
X-MS-TrafficTypeDiagnostic: AM8PR10MB4658:
X-Microsoft-Antispam-PRVS: <AM8PR10MB465828D92D92E9E936802511E95B9@AM8PR10MB4658.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kZyPawfVRiaEXpKtH007vj45dwz68NBv0j36K8t6gBvDvHlClFUKuq7n1Z4+O4BZQeJD9CC7MeQYGI+4Fo1YedRuybtJQ/04gkWKCIAbZkH6vIFhp2sXoEVPeHTOX9LVPQl6aDObBc4aRCFlP007v1Jc+6eAAYK0NXnL66AL8MNTd4v8nDQiCC/TL8Q339jlVLtCwAJZAarTeHZtOClPC76dJOXVfWNeUZJb6oZJW1f5ZCyK2qwzIq4D3t9vI1ADK4ovEJ4pZCXVXw5ySomggh2owmFQpHSllJLGDVfqh8mMaLFcd/8yx6B0ziMo/hzDG8iMnaK7cy+BRHIEOZ7e0ZfXpdohIUHwy83fbZB1waq2sCI+RlUUdMP5jrX3oY8N2aVJleqgUwB1n+tGf1ln+hg/BolQj6n7WqpvahHSCQ4KHcfdL6U4YHAm+oYQXqo/0/Y23Lh19+CCZlsz3wo/R2RaS+EH0s3jz52CG6Zy3TnBl1zxlsr5aIJHttuEVTT3Q2DDH3+iJOpKCOFzhK8jhH0YmqfRDhufZGjJLxyRHdYjy9PMU39hOEGY7O/ma3ww5zIKPg4MgmYgOszkA8c3fw6RJJbELXrqgh+FDrdf0FvsNL1u8vNFWPYSs+drhugBSYYPSNViWhlqbk7oq2+xNdJ1bIDwRylLbYZ9B5gQHkEJBQGa1uOMDCEiimIR7mcw
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR10MB2963.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(366004)(396003)(376002)(346002)(39850400004)(136003)(8676002)(186003)(66476007)(53546011)(478600001)(26005)(31696002)(31686004)(4326008)(316002)(38100700002)(66556008)(7416002)(2616005)(86362001)(956004)(6486002)(8936002)(36756003)(83380400001)(66946007)(2906002)(44832011)(16576012)(5660300002)(16526019)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?ckdHb2RxbTM2ZURMZkFnN3RvZlBpdzVLUU1sYmdoTDc2TG54SG9ZTzI1T1hz?=
 =?utf-8?B?Q0NvTGU5ZkNQdmZKYTNMU1pNSkROWmNNMVlyRWVBdmpzbGZJenpteFFyU0RT?=
 =?utf-8?B?YUdVWXhTbSt1c0tKYmJwVVUvOGRCbG50c25SMFM4NXUxZEd4enZIQVpCWEwx?=
 =?utf-8?B?RThRdUNwWGppd1ZUanA3YlVWaVFLUkM1c0xuY1V5TXFOcEhDRm0yVU9zUVFh?=
 =?utf-8?B?NUhsdmFIMFFrMHplTHVFUW1kRStCOERpVEpDS2NPNlBOQWVRMTRDVmRzcmdB?=
 =?utf-8?B?TmJEdGxUSHkrL09ITGlDeERZTjJrTlE3UkZ5eEk5YWQ0bW1EOGZFaGtUdUFY?=
 =?utf-8?B?MHVEUnN4aFFUQnMzS2NkL09jSXNxaEU4c2l1TWtVZFF0R0hPS0dKMmxCZzJi?=
 =?utf-8?B?YTh6R2VyRGdvZVAwUEJ2bElEZ0NPek82dEtOQWxZM2I4N0M0RFJKMXl5NWVO?=
 =?utf-8?B?NWEwU3piNEErRnRFQy9jTnQ2dTdEK2VRNi9JWVhZUHFJWUorNXVncllaM1B3?=
 =?utf-8?B?eVlONGpKYlQ0a2RJVXRiM3ZzMkhwS1F6ZmFkekhxSjJhQ29pY2dmSURHK1lB?=
 =?utf-8?B?emJkRlBYLzRUOVFIMkloTVpieWhVRTdHeUtwaGpiRFA0YVpDSkZqRHYrSitn?=
 =?utf-8?B?aytBRXB3YlRBL3QyNGhTR2UrdFFVU2VkdXVNdUhvR1ZRK2JNeGR2Q3BqNzFw?=
 =?utf-8?B?aVdqeWRpVXI2YngxYnBVSGdVQmxlYm1ibjFKK0FURVVLWklyeGx5emVTRmY5?=
 =?utf-8?B?STY1ZDlpZVBXUkIrejNrRnRaVERFR2VTbFpSTEhSNmNyNnIzNWpJdkdPa0RN?=
 =?utf-8?B?RHMyd3FwM2NaRDNYRTFkd2ZYZzlmakg4anVEVVRsUktHYWxJampkdHhqRVVD?=
 =?utf-8?B?S0FhbDF1TDJJd1FVZnUrVFlVQWhSaVZTci9pL0lHaTlsOW9OWXBKN3NQVng4?=
 =?utf-8?B?TGdQM05JV2RBeXA3L3hoMGZuYkVINFFnMU1JaW1aNS9NSGJnd3dRL1Y2U2VG?=
 =?utf-8?B?c3h5VHNjbmdHaERUeUp1VWx6SUd1dGxqTG9weG9ldUlJWTdLMTEwanZPZkM2?=
 =?utf-8?B?blkzTmlrOHY4N3NpczQ1ck9EL3U3UlhnL1EzNjlRdEN1WVhnVWlhTzQrRGdN?=
 =?utf-8?B?Yk9wT0lRMXltb3ZiOC9tcGZTS2t5OGNNd09mOXBJSTgveDUzcmZydWRpYTEw?=
 =?utf-8?B?a0RnQTBSSmF4L1BCZFVSWDJ1dUlBUmEvbjFOY3lKTVQ5aHppRDNqeVpCNUZ4?=
 =?utf-8?B?WXZSOFVWdEhoL1dSNEI1SkJEMzExKzFLdDAxY25qVEtRMkxLek9xR1FmWlIy?=
 =?utf-8?B?cjY2RmxPVkZoUkJYbWh2S2pZejJYRmNpaUhSM0N4bkUzeXJXSHNOWFZ3WWZI?=
 =?utf-8?B?MGVaekltLzJjWk1RQkQ4N2J2WGlQL0FjMkZyQVd4NVVSVDE4UmowK01RQTNW?=
 =?utf-8?B?Qnk3OVBMallSNmhPZmFTbzhRUUlDZTlLczMyM0twc2xuQmRXcUJiZWhweWR4?=
 =?utf-8?B?aFNuRE1PSmdGenB3cDRiZyt5MHlNQkluM2xIbm9EZHQvclJWemQvbzdTa3lr?=
 =?utf-8?B?UG00OHFmR3lFUWtSeWZwbk5uakpWODRLTTRTSXhIQmlvS01rQVRKZ1N0VnRZ?=
 =?utf-8?B?dnlndDJLbkZqNGxNN0ROOGFoK3BZZWJxamlETjF6ZWpieFRycGNwVzRqdGpR?=
 =?utf-8?B?OGlCYkd3UGE3S2lHUXRrWWh5QWY4YitMbThLQmZ2TnMzdU94bk44SEE3bFEr?=
 =?utf-8?Q?eVf9ke6YlsVlsO+XLZJM89qoz8w9Anv5izr0LbK?=
X-OriginatorOrg: kontron.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d613b50-8488-4ca8-ca19-08d90e3ec58b
X-MS-Exchange-CrossTenant-AuthSource: AM0PR10MB2963.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2021 14:21:41.6228
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8c9d3c97-3fd9-41c8-a2b1-646f3942daf1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JoRfNypJfByoxMandMVZCeTS7fMHmwrWdALZhxp7WTFoPmI5WTpQ04mxN/LCeVuVrrE4QbiNExV1mGVK7Ir823wJRTM+0zhPvfQ14RK13q4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR10MB4658
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29.04.21 09:30, Peng Fan (OSS) wrote:
> From: Lucas Stach <l.stach@pengutronix.de>
> 
> Some of the PGC domains only control the handshake with the ADB400
> and don't have any power sequence controls. Make such domains work
> by allowing the pxx and map bits to be empty and skip all actions
> using those controls.
> 
> Signed-off-by: Lucas Stach <l.stach@pengutronix.de>

Reviewed-by: Frieder Schrempf <frieder.schrempf@kontron.de>

> ---
>   drivers/soc/imx/gpcv2.c | 89 +++++++++++++++++++++++------------------
>   1 file changed, 49 insertions(+), 40 deletions(-)
> 
> diff --git a/drivers/soc/imx/gpcv2.c b/drivers/soc/imx/gpcv2.c
> index 87165619a689..640f4165cfba 100644
> --- a/drivers/soc/imx/gpcv2.c
> +++ b/drivers/soc/imx/gpcv2.c
> @@ -163,24 +163,27 @@ static int imx_pgc_power_up(struct generic_pm_domain *genpd)
>   		goto out_regulator_disable;
>   	}
>   
> -	/* request the domain to power up */
> -	regmap_update_bits(domain->regmap, GPC_PU_PGC_SW_PUP_REQ,
> -			   domain->bits.pxx, domain->bits.pxx);
> -	/*
> -	 * As per "5.5.9.4 Example Code 4" in IMX7DRM.pdf wait
> -	 * for PUP_REQ/PDN_REQ bit to be cleared
> -	 */
> -	ret = regmap_read_poll_timeout(domain->regmap, GPC_PU_PGC_SW_PUP_REQ,
> -				       reg_val, !(reg_val & domain->bits.pxx),
> -				       0, USEC_PER_MSEC);
> -	if (ret) {
> -		dev_err(domain->dev, "failed to command PGC\n");
> -		goto out_clk_disable;
> -	}
> +	if (domain->bits.pxx) {
> +		/* request the domain to power up */
> +		regmap_update_bits(domain->regmap, GPC_PU_PGC_SW_PUP_REQ,
> +				   domain->bits.pxx, domain->bits.pxx);
> +		/*
> +		 * As per "5.5.9.4 Example Code 4" in IMX7DRM.pdf wait
> +		 * for PUP_REQ/PDN_REQ bit to be cleared
> +		 */
> +		ret = regmap_read_poll_timeout(domain->regmap,
> +					       GPC_PU_PGC_SW_PUP_REQ, reg_val,
> +					       !(reg_val & domain->bits.pxx),
> +					       0, USEC_PER_MSEC);
> +		if (ret) {
> +			dev_err(domain->dev, "failed to command PGC\n");
> +			goto out_clk_disable;
> +		}
>   
> -	/* disable power control */
> -	regmap_update_bits(domain->regmap, GPC_PGC_CTRL(domain->pgc),
> -			   GPC_PGC_CTRL_PCR, 0);
> +		/* disable power control */
> +		regmap_update_bits(domain->regmap, GPC_PGC_CTRL(domain->pgc),
> +				   GPC_PGC_CTRL_PCR, 0);
> +	}
>   
>   	/* request the ADB400 to power up */
>   	if (domain->bits.hskreq) {
> @@ -241,23 +244,26 @@ static int imx_pgc_power_down(struct generic_pm_domain *genpd)
>   		}
>   	}
>   
> -	/* enable power control */
> -	regmap_update_bits(domain->regmap, GPC_PGC_CTRL(domain->pgc),
> -			   GPC_PGC_CTRL_PCR, GPC_PGC_CTRL_PCR);
> -
> -	/* request the domain to power down */
> -	regmap_update_bits(domain->regmap, GPC_PU_PGC_SW_PDN_REQ,
> -			   domain->bits.pxx, domain->bits.pxx);
> -	/*
> -	 * As per "5.5.9.4 Example Code 4" in IMX7DRM.pdf wait
> -	 * for PUP_REQ/PDN_REQ bit to be cleared
> -	 */
> -	ret = regmap_read_poll_timeout(domain->regmap, GPC_PU_PGC_SW_PDN_REQ,
> -				       reg_val, !(reg_val & domain->bits.pxx),
> -				       0, USEC_PER_MSEC);
> -	if (ret) {
> -		dev_err(domain->dev, "failed to command PGC\n");
> -		goto out_clk_disable;
> +	if (domain->bits.pxx) {
> +		/* enable power control */
> +		regmap_update_bits(domain->regmap, GPC_PGC_CTRL(domain->pgc),
> +				   GPC_PGC_CTRL_PCR, GPC_PGC_CTRL_PCR);
> +
> +		/* request the domain to power down */
> +		regmap_update_bits(domain->regmap, GPC_PU_PGC_SW_PDN_REQ,
> +				   domain->bits.pxx, domain->bits.pxx);
> +		/*
> +		 * As per "5.5.9.4 Example Code 4" in IMX7DRM.pdf wait
> +		 * for PUP_REQ/PDN_REQ bit to be cleared
> +		 */
> +		ret = regmap_read_poll_timeout(domain->regmap,
> +					       GPC_PU_PGC_SW_PDN_REQ, reg_val,
> +					       !(reg_val & domain->bits.pxx),
> +					       0, USEC_PER_MSEC);
> +		if (ret) {
> +			dev_err(domain->dev, "failed to command PGC\n");
> +			goto out_clk_disable;
> +		}
>   	}
>   
>   	/* Disable reset clocks for all devices in the domain */
> @@ -532,8 +538,9 @@ static int imx_pgc_domain_probe(struct platform_device *pdev)
>   
>   	pm_runtime_enable(domain->dev);
>   
> -	regmap_update_bits(domain->regmap, GPC_PGC_CPU_MAPPING,
> -			   domain->bits.map, domain->bits.map);
> +	if (domain->bits.map)
> +		regmap_update_bits(domain->regmap, GPC_PGC_CPU_MAPPING,
> +				   domain->bits.map, domain->bits.map);
>   
>   	ret = pm_genpd_init(&domain->genpd, NULL, true);
>   	if (ret) {
> @@ -553,8 +560,9 @@ static int imx_pgc_domain_probe(struct platform_device *pdev)
>   out_genpd_remove:
>   	pm_genpd_remove(&domain->genpd);
>   out_domain_unmap:
> -	regmap_update_bits(domain->regmap, GPC_PGC_CPU_MAPPING,
> -			   domain->bits.map, 0);
> +	if (domain->bits.map)
> +		regmap_update_bits(domain->regmap, GPC_PGC_CPU_MAPPING,
> +				   domain->bits.map, 0);
>   	pm_runtime_disable(domain->dev);
>   
>   	return ret;
> @@ -567,8 +575,9 @@ static int imx_pgc_domain_remove(struct platform_device *pdev)
>   	of_genpd_del_provider(domain->dev->of_node);
>   	pm_genpd_remove(&domain->genpd);
>   
> -	regmap_update_bits(domain->regmap, GPC_PGC_CPU_MAPPING,
> -			   domain->bits.map, 0);
> +	if (domain->bits.map)
> +		regmap_update_bits(domain->regmap, GPC_PGC_CPU_MAPPING,
> +				   domain->bits.map, 0);
>   
>   	pm_runtime_disable(domain->dev);
>   
> 
