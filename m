Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D85F3716A3
	for <lists+linux-kernel@lfdr.de>; Mon,  3 May 2021 16:30:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229713AbhECObB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 May 2021 10:31:01 -0400
Received: from mail-eopbgr10102.outbound.protection.outlook.com ([40.107.1.102]:9198
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229670AbhECOa5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 May 2021 10:30:57 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JS/CAUwuIPGMrlJ7R3SxdrDAiHeF9x9F4J4Nkn4vQo9kx2lCilxF8LgkiXomSCI95MNm6HyuEjYf4XaetyTkbmZVbKsch9M2Wdjb6Q3XmBVFikZt0HIYGFvll03QqodlLtE4QCK5oEzQhv5eghBSFdDprE1KL4LglBfAASLNWQ+oTeCPh0+xWHCppcQJcR3QyenMsrb08m7xKxDiDBkTj+EyhcDm/z7upq2viObM8fCr4qEzd5px0MBUgVy+vJDj9Y/bNJ54kKGFTR0+0qXGL5f1+IdEXzGwT5H3Akw9A2Se+t2buOxA61mmGPEIZYL1GAekUwys7wpSN0FK4CCScw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k0XzSTSuTQYjUScgNLZ+70L+d3HY3s5BjUlQFLx9vCY=;
 b=foXpR4SOGNphgcr/LNriQL639SQe4HcLbV/XiEV4qif65jd40aK3Ih2ArnIhDCBCZ6eJ0xdJGzydM+OUblw8dLPB5TXqXTER9HFRrA8LaMEQM5wSSH77eSTwlj1A8bPN9deZ0JyTCVhE64HfqZ6m+clfKvWnlXayXkgMacU7cusEAoax2Czp4605k/VdIvdOR2wpkBiwD8+EH2EcAwM9Mpfhzvmz2i0Uy3PBBWavQtTRbqNYXe7L9BUiBCYJa4tFc69zAhYQ5CebenaAMyAH0tPHk0sWI5xXfKODCGs0j3OLGQJC0I3Ae63DsqSlLFmJTrf3swxar/3++jY+0jdVrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kontron.de; dmarc=pass action=none header.from=kontron.de;
 dkim=pass header.d=kontron.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mysnt.onmicrosoft.com;
 s=selector2-mysnt-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k0XzSTSuTQYjUScgNLZ+70L+d3HY3s5BjUlQFLx9vCY=;
 b=E7hz3SFnsYTQYssrw5NlGnXsnuton0D3zlDlIPid/HNvdG18y1AawpvP4EHA8BnNl5wL63+/ylWQBFT4CwsYYp1CQ8FdIiorhtD3t2GZp6DLrHZk1f44A0y3FU7dwJJXiMyQYdd8PTWGRYZPKr9iYsPKOMhNof4g2vtzkT+J8Ls=
Authentication-Results: nxp.com; dkim=none (message not signed)
 header.d=none;nxp.com; dmarc=none action=none header.from=kontron.de;
Received: from AM0PR10MB2963.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:157::14)
 by AM0PR10MB2068.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:4f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.38; Mon, 3 May
 2021 14:30:01 +0000
Received: from AM0PR10MB2963.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::3d8a:f56b:3a0c:8a87]) by AM0PR10MB2963.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::3d8a:f56b:3a0c:8a87%7]) with mapi id 15.20.4087.044; Mon, 3 May 2021
 14:30:01 +0000
Subject: Re: [PATCH 09/16] soc: imx: gpcv2: add support for optional resets
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>, robh+dt@kernel.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        p.zabel@pengutronix.de, l.stach@pengutronix.de, krzk@kernel.org,
        agx@sigxcpu.org, marex@denx.de, andrew.smirnov@gmail.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, ping.bai@nxp.com, aford173@gmail.com,
        abel.vesa@nxp.com
References: <20210429073050.21039-1-peng.fan@oss.nxp.com>
 <20210429073050.21039-10-peng.fan@oss.nxp.com>
From:   Frieder Schrempf <frieder.schrempf@kontron.de>
Message-ID: <3caab947-4e47-a11f-e482-bb1250a3efc5@kontron.de>
Date:   Mon, 3 May 2021 16:30:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
In-Reply-To: <20210429073050.21039-10-peng.fan@oss.nxp.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [109.250.134.29]
X-ClientProxiedBy: AM0PR08CA0010.eurprd08.prod.outlook.com
 (2603:10a6:208:d2::23) To AM0PR10MB2963.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:157::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.10.27] (109.250.134.29) by AM0PR08CA0010.eurprd08.prod.outlook.com (2603:10a6:208:d2::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.29 via Frontend Transport; Mon, 3 May 2021 14:30:01 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8c7d7319-b3a2-47d2-ad85-08d90e3fefb4
X-MS-TrafficTypeDiagnostic: AM0PR10MB2068:
X-Microsoft-Antispam-PRVS: <AM0PR10MB2068AC5FE1870C2C8D7104E5E95B9@AM0PR10MB2068.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:3383;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jlwxinihYqpXL68N9A6x0bMlOCZrCuYSBKiCkzUJJINptX0ERg0K+J0dBc9PdDw2betQpJLeg+/rJHzZB/XswFoB01HUhLFH8Tg50xLF0i5mz8+zXGNPXcO9t+lSAf/VpinhEkXfSTglP2hfvlmLrOUXVfVrGh/wN21xgJdFz8d+IVwVbi2X0xi8CaE1jweyjJla3PBuaMYShr/lb+duI9R91Px/vEwStD8MS2AreO7283EGGJYFRlg1KxobDPhr7I+ZjTeC494R5C+agV6GCbSKeKExXDEPFoIv7l5dgZXCBWLOzSmrpVthgUxun2Rv0x31yjp+cpOuGJnLZX34ukfYvUryUTBFlod0HujkJkm8Xe2/f2szYj67JftS6qremzFVoc/NZuXZEZK03NjNe+CfZPtBdpwZ6TdsNTFwzofmLzQ4+vy5buqRQZ2ypwjjkIL1dLRpSABkQrzKQ7099rRvsqlYCoOBNuAIy0L/VPWn366/T8/fIqNuMXUWwIR4ZDHxOnQaZ2/PgviIr2OnR9CwBbEWNg2KFBxZoNU6wEmFFVzxq98xSml6GabLXmsHGCPDY8ZgRLqA8V81rdjTKJDwwr0t6A2giga2/mpkhCI8U23hx2oE9OTaKm7QmQJ4VR0LS1kUuQKjIjBJ5elBssmj7Q+58b220m1ookXcNy8TtolKLkk2NH/cczcjENAL
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR10MB2963.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(396003)(39850400004)(346002)(366004)(136003)(376002)(956004)(38100700002)(31686004)(2616005)(8676002)(16526019)(186003)(4326008)(478600001)(2906002)(66556008)(66946007)(66476007)(26005)(7416002)(83380400001)(31696002)(53546011)(36756003)(16576012)(6486002)(5660300002)(316002)(44832011)(8936002)(86362001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?eEtKZHBXclBaSTM3eU1LWm1IUHkwNUZzRjFOcHJzWWpvYnk3QTd5NUc4cXg0?=
 =?utf-8?B?RWNCQU9oNVJyRWRialRKRWhPVEM5K2I5UWJ6Rm50VUZkajRqNzZ2MWpITmlu?=
 =?utf-8?B?VWtjZElyMVhpTTJrMmQ4T3hwang5a1BSR2NpUm5RRFh1K1l1SSthdGlwWXZJ?=
 =?utf-8?B?YmJqRUd6V1RNL1A5MC9KbFhERlJGTVpNaG9kTy9sWHFoT1ExUWFwTkFVS1hw?=
 =?utf-8?B?aVh3Vk43eW8xSlhVUUtOVm43bStidUxlb1dzYTVsVHNsR1VpTE5vU3kveCtr?=
 =?utf-8?B?UUlCK0p4UUtOWnVKeEJPRmxOaUcwS3BBYUNGTjhQeURpdHd0Z3VEdGdGK3dk?=
 =?utf-8?B?dVFtdFNrYW5DWldIT2dIVWtkc2pFYXhpNVVPMW9tYzVGTFByWVdFQlY4cE5p?=
 =?utf-8?B?bkdBT0ZYUkdCVSt0OEhMbmFnayszeGhKZTkyUTZpeitZeEVDakVnbjNpTUVC?=
 =?utf-8?B?NkFQYVo1OUZWLzdra3RSV3BKYTZtVVJrS0F6NFlGNVg0U25XZUppVnNqSlBk?=
 =?utf-8?B?RGNZMHg0MkdOR3N0WmtkRmN3Z0pKK1pOMzVwSkRzRXk3NnQ3OWpxbVNuazY1?=
 =?utf-8?B?ZHEyT0lZNWEwU1BKVnJpN1RuSi9GbUFuYW5hMDVDTnhZc1pKc2cvTHF2Nko4?=
 =?utf-8?B?aWhYZWJJeVZueWJ5ZXRFWDB4M3dXNThvckt4K0pYelpadTFTL2NFQVhYSHEv?=
 =?utf-8?B?dEFnd25PbkRyQkplalB5cytpZWVVYVVMQ3VINGU0bHVqTmRta21vMGRoemJt?=
 =?utf-8?B?UTJXSVJtbUl2aUNwVFdQMnVjb3RIMHhPRUlZdkFFbDU3SndvK2xTdjJXTDJI?=
 =?utf-8?B?dDcrdGRtQmduSEhxWDU1bXczQlhJZE52ejNLR1JheEVGalhQNlUzK3UvNlly?=
 =?utf-8?B?SC81cXpZdE9ieTRkdWJlWk1mSWcrUzhlVVpCQWpYM2MyUU5CMXpYWVdnNUtD?=
 =?utf-8?B?bVM5bWhleGpmbHdRbzgzU1dua1JmdzRBbU0wc0VySFZQSTZERVFDaWMvci9j?=
 =?utf-8?B?WHU0S1pST3FsbDlpbjRKMmd6ZDBtWDUvMXBmQzdQWERaNks5eEQ1Q1BRc2Rr?=
 =?utf-8?B?UHNHbjhZbXN6Mkk0MnVVWTF2MUhlbWgvdGU5QlVNd24yNVA1c3BvSDJyNGdQ?=
 =?utf-8?B?Tmd1RExyUFBRa2VDTTFkU3BveXFoTWdieXY0Wkg4SlVDekV5ZDJ3UmNSRW9p?=
 =?utf-8?B?c3pXeWErZzY4ZEh3d1NpbG5UL3BRNjM4YkVadWIvR3lmanpMWEtxZG9jb3Ur?=
 =?utf-8?B?SnpjNmVPa0pOYWFBTnlReTVWWXBmR3ZkcEhHa2dRdHozNFhoM1Y3dmRPT3VY?=
 =?utf-8?B?QWdvZE1zT2JHVk5JcUpnOGhiNUV2Z2hJRkZHRUNmRkxiWHlWMzRhd2lZYVpX?=
 =?utf-8?B?QmZRQjJ0d2xWRGRqc2orNnNXNjZ0Smgrb2dqQnptYk04U1NpTUI1TzI5UDU2?=
 =?utf-8?B?Q1VibDBuWEkrcEhyRm9vR0RnT0pMcEVxMDVJdDNUZ200SmM2Mng0SVJsODZp?=
 =?utf-8?B?RG9oRjNrOEtpaDBIaFFBSHQxaTRZdW1zQjQzcWpOU3Zsb2dlbU5JeVpITTl3?=
 =?utf-8?B?MUxhQkRmWEh6bzlMbFB2WFFPSkEwSEdJL3J2MXJoc3dlYXlUSVlSTU9GdUlI?=
 =?utf-8?B?Z1JIVDJIYXA5cU1SaU9BSEl4R25KSXVhKzdCd1JqaFkweDZ4WmtkbU50ZGRu?=
 =?utf-8?B?b3B0b0ZVd3Z5Y2ErcXJvNDRhbUYwdi9Rbk5BSks3aU5KelFuT1ZXbm9xcHFX?=
 =?utf-8?Q?QtEjWzIx2Oxagt0jTrDmmhikxmc3443m7mPxfWM?=
X-OriginatorOrg: kontron.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c7d7319-b3a2-47d2-ad85-08d90e3fefb4
X-MS-Exchange-CrossTenant-AuthSource: AM0PR10MB2963.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2021 14:30:01.8478
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8c9d3c97-3fd9-41c8-a2b1-646f3942daf1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: izHpEgftTvVomk4u3RtBZri56GcdzKY3nUUuprP1NIdm0/7zwozd+YTSnQ1B+ncNgg39hk0uRtoQlkDYbLzYeKBFdeIQf01yxzZKXRU8PeM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR10MB2068
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29.04.21 09:30, Peng Fan (OSS) wrote:
> From: Lucas Stach <l.stach@pengutronix.de>
> 
> Normally the reset for the devices inside the power domain is
> triggered automatically from the PGC in the power-up sequencing,
> however on i.MX8MM this doesn't work for the GPU power domains.
> 
> Add support for triggering the reset explicitly during the power
> up sequencing.
> 
> Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
> ---
>   drivers/soc/imx/gpcv2.c | 15 +++++++++++++++
>   1 file changed, 15 insertions(+)
> 
> diff --git a/drivers/soc/imx/gpcv2.c b/drivers/soc/imx/gpcv2.c
> index 640f4165cfba..4a2c2a255d1a 100644
> --- a/drivers/soc/imx/gpcv2.c
> +++ b/drivers/soc/imx/gpcv2.c
> @@ -15,6 +15,7 @@
>   #include <linux/pm_runtime.h>
>   #include <linux/regmap.h>
>   #include <linux/regulator/consumer.h>
> +#include <linux/reset.h>
>   #include <linux/sizes.h>
>   #include <dt-bindings/power/imx7-power.h>
>   #include <dt-bindings/power/imx8mq-power.h>
> @@ -108,6 +109,7 @@ struct imx_pgc_domain {
>   	struct generic_pm_domain genpd;
>   	struct regmap *regmap;
>   	struct regulator *regulator;
> +	struct reset_control *reset;
>   	struct clk_bulk_data *clks;
>   	int num_clks;
>   
> @@ -163,6 +165,8 @@ static int imx_pgc_power_up(struct generic_pm_domain *genpd)
>   		goto out_regulator_disable;
>   	}
>   
> +	reset_control_assert(domain->reset);
> +
>   	if (domain->bits.pxx) {
>   		/* request the domain to power up */
>   		regmap_update_bits(domain->regmap, GPC_PU_PGC_SW_PUP_REQ,
> @@ -185,6 +189,11 @@ static int imx_pgc_power_up(struct generic_pm_domain *genpd)
>   				   GPC_PGC_CTRL_PCR, 0);
>   	}
>   
> +	/* delay for reset to propagate */
> +	udelay(5);
> +
> +	reset_control_deassert(domain->reset);
> +
>   	/* request the ADB400 to power up */
>   	if (domain->bits.hskreq) {
>   		regmap_update_bits(domain->regmap, GPC_PU_PWRHSK,
> @@ -531,11 +540,17 @@ static int imx_pgc_domain_probe(struct platform_device *pdev)
>   				      domain->voltage, domain->voltage);
>   	}
>   
> +

Spurious blank line. Otherwise:

Reviewed-by: Frieder Schrempf <frieder.schrempf@kontron.de>

>   	domain->num_clks = devm_clk_bulk_get_all(domain->dev, &domain->clks);
>   	if (domain->num_clks < 0)
>   		return dev_err_probe(domain->dev, domain->num_clks,
>   				     "Failed to get domain's clocks\n");
>   
> +	domain->reset = devm_reset_control_array_get_optional_exclusive(domain->dev);
> +	if (IS_ERR(domain->reset))
> +		return dev_err_probe(domain->dev, PTR_ERR(domain->reset),
> +				     "Failed to get domain's resets\n");
> +
>   	pm_runtime_enable(domain->dev);
>   
>   	if (domain->bits.map)
> 
