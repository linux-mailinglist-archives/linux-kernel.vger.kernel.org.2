Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E8E3371681
	for <lists+linux-kernel@lfdr.de>; Mon,  3 May 2021 16:18:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229567AbhECOTo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 May 2021 10:19:44 -0400
Received: from mail-eopbgr40110.outbound.protection.outlook.com ([40.107.4.110]:28633
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229472AbhECOTl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 May 2021 10:19:41 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dHSOamusZzuh9BNNm00skl+zym4nQFlDejrK/IZrwiYRqY6u5/H1wR5ackICuR/S8bUZCSNXuL9a9i6tjvShz8J3gYrKVk/E2mkqAzib/UwHgElrDJFN5aSc4owkTBmp4lsS1dfNG0pYK0ZlFUclKQqEBiZlXd3EnVngK/kqv+KT7SC+2m96WvQcyLO8ttHpj/d4iUA7r2c/PVdbHVj+4c3rimtyjpAFAdEILWgaMDJiuBltQ+B4UziXdSt9VeHmUalod5UHdvyP9mHeaO6c0A8Bh4UtcHjTNZQGgts1KmBfR9So6orDvuFWeinJLJg02OnEdjLWO1iPgygsb3pxoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zynJJBTcenqp3PDoRtQOW6Ocd0GrOsKVNMUvsbHXUCk=;
 b=m4kCXJdhLtidK70tZP9Im/g/ie7oZORZSFicAwWGaXVhp7dI13LRmYkt8rwfj/V4TqDvgnn7Bld5dkEHpkfYlIBlFuiNsoi0OIswfYwYfPexfzK5z2toBBhA9GDWwkM2WDaaBtGiVpbtFcfhdxij2X1P2O0tVWfxlPe6zhoB4NwlqhEWKK010AMLGznpoCpWqqHS+rvjzJWDDymjcP3hysJ5ddegBy1q2+hTPCEXdhICRtQr6X2A0VI3lWdUL0oYwG7T/EQ+S5uKOHSZwriVodfDvwH2PnB+8l0AnpeZTve/ql6st3e6J4uCHFDHfUH8xGSCnACec7VPWYpuzkLAiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kontron.de; dmarc=pass action=none header.from=kontron.de;
 dkim=pass header.d=kontron.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mysnt.onmicrosoft.com;
 s=selector2-mysnt-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zynJJBTcenqp3PDoRtQOW6Ocd0GrOsKVNMUvsbHXUCk=;
 b=K9xH2DevKKKtBT4Hvw2O99SbFkUt2QgoEvHF7eyKLL/o9WJrkYLfB1hzLwJFY28qJYaJUpXB0ACTShhXmrpp9iyeMnESSQKJIXMTssZkry3GxmUF+45nFXjOtEqaCyjBMfIRK062pnFfcYqTumQjOLu54Of3ugAwj4JLzGBgIbI=
Authentication-Results: nxp.com; dkim=none (message not signed)
 header.d=none;nxp.com; dmarc=none action=none header.from=kontron.de;
Received: from AM0PR10MB2963.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:157::14)
 by AM0PR10MB3521.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:159::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.25; Mon, 3 May
 2021 14:18:46 +0000
Received: from AM0PR10MB2963.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::3d8a:f56b:3a0c:8a87]) by AM0PR10MB2963.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::3d8a:f56b:3a0c:8a87%7]) with mapi id 15.20.4087.044; Mon, 3 May 2021
 14:18:46 +0000
Subject: Re: [PATCH 06/16] soc: imx: gpcv2: add runtime PM support for
 power-domains
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>, robh+dt@kernel.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        p.zabel@pengutronix.de, l.stach@pengutronix.de, krzk@kernel.org,
        agx@sigxcpu.org, marex@denx.de, andrew.smirnov@gmail.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, ping.bai@nxp.com, aford173@gmail.com,
        abel.vesa@nxp.com
References: <20210429073050.21039-1-peng.fan@oss.nxp.com>
 <20210429073050.21039-7-peng.fan@oss.nxp.com>
From:   Frieder Schrempf <frieder.schrempf@kontron.de>
Message-ID: <450c97d8-a7c1-fcf0-2485-529ff702989e@kontron.de>
Date:   Mon, 3 May 2021 16:18:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
In-Reply-To: <20210429073050.21039-7-peng.fan@oss.nxp.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [109.250.134.29]
X-ClientProxiedBy: AM5PR0101CA0026.eurprd01.prod.exchangelabs.com
 (2603:10a6:206:16::39) To AM0PR10MB2963.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:157::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.10.27] (109.250.134.29) by AM5PR0101CA0026.eurprd01.prod.exchangelabs.com (2603:10a6:206:16::39) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.27 via Frontend Transport; Mon, 3 May 2021 14:18:45 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b82bf9c3-70a1-4cdf-80e1-08d90e3e5d0e
X-MS-TrafficTypeDiagnostic: AM0PR10MB3521:
X-Microsoft-Antispam-PRVS: <AM0PR10MB352112A2F53D955185A0C7FEE95B9@AM0PR10MB3521.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:529;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RrIvfVclTuJVtyOoJNUPhZ2SEMbR7NYX/Qw3sLioesArQHm7bpYmQYd7j9goFLw2RHE+/d199Fp9XlIOpohytjO9boaOyAA3Is/9TUTjrGq9AHpL1M16rUsQpX8rWwJHFqAek3+Xps6KY7/4+vME7nXuJJZ2xG75U9jfvt1jA0MuojtBi95owwFVevtnEJwBSj2Psx72UFsoQJzdyCWy6f1MNdAOfgkAaU4jvbh5wldrIRcOFe7LBuz/NIhzdnbh9EcHsX8mjzC+NvIs9KTVSRD7O2NE7MoPLl4lqXwAhDn5obOq6HKV8u4vmW55A0f7dc6n0tSZJ/N2HoTAqy6lZNbCGdy6KN8PKYPHPXv6gbzdQLoeL3kpBoQecGxFLOhSQRXAsk3nasNQPT6OnveR1Db17ZDN2jv1sp4cXXGCes2I3mSQuFXZF5tWRCJtsMYo8DikUmcngaHPdfs/y1mX/7mPphoDzLIVTD7GPDpWsIGwkSgWY1iddPqCKH7Kt2PNE08j4+0gcG7sBtUQDR1pgqpJm429SHVlkI/McNnpjyegTzVvNNsP4AUSi6NZjIuYHNla0i/XvJGGkBw4T6oYQB3Gg6YSJCWW7w6OmurP4bf4Nc8wU+vofnyVQJg8T30+z0pgJM6ziAqzlqN/EC0h/lL/87sYC60v5A9ObNZUjh0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR10MB2963.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(346002)(366004)(376002)(396003)(136003)(39850400004)(7416002)(83380400001)(36756003)(31696002)(26005)(66946007)(6486002)(4326008)(478600001)(16526019)(186003)(53546011)(66556008)(66476007)(16576012)(5660300002)(8936002)(316002)(38100700002)(2906002)(86362001)(956004)(2616005)(8676002)(31686004)(44832011)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?NE5yVnJFcUJVbzdaUU5xQlNVaUcwUmgwZlFhSXBnOGlJcVp4eENlYWFFeGFh?=
 =?utf-8?B?WGpXZE9IMW91WU1kMWN5VlFFL0lSSi9OWlZpenFKSVRHa29kV2VENzVDUHdS?=
 =?utf-8?B?WlhSQmNicnJSV25wWEhpMUZvOTd0WFhpeDRQUXdzNzNmVHF3NmkvSVY0Mzd4?=
 =?utf-8?B?WGZ5YXMvK1dUSTMrTUIvVyt5WmpJaFpxRUZ4Ri9kblFWZldwVXJvL25GRkwy?=
 =?utf-8?B?TUVOZXI4a2dTajNQczl1dmNyM0piZDNkcWxJVHNsQXN3ZXZReVMvQjhQQ2Y0?=
 =?utf-8?B?YUcrNjVrN3o0eUJNeXpTMmlBNHYwZGVnQ2o3eDJ6UE0yaTFDc1RzUzBlME96?=
 =?utf-8?B?VWh3aStOUVUrbzFzZkxET3A1WFB1UUZsS1VoYktsUWh1bDdvVk1VTzhnU3d6?=
 =?utf-8?B?YnA3Z2dzVDVuTDlITzN0bnErSndUTzlVdVRGTnZ2VnR2d3hkUTRDSk8xeFFi?=
 =?utf-8?B?KzBMMVUvNE9uUDV5TDMxTS9HeHZ3S1ViWXY3aWNkem8vUGk3TUJ6Vmxsak5Q?=
 =?utf-8?B?c3hZWkdWMjRXelhyb1NubklPdG1OZUo0cFhVcTBxUlo2WHBsd0lIQXlVZ2xB?=
 =?utf-8?B?ZnVVdEovcDVoekxtMDNPNzdxNlV2TmRuMkVRTTlJdm50WW0wNStEbTFXdkx5?=
 =?utf-8?B?QjdYZ0JOYlZQOEtOcDFNZytYLy9yM3pZeEdBc3R3OGVkeWl0WnJZWmVhTk9w?=
 =?utf-8?B?NkVnbXJKSUhJRko4WUxXYjhjUDdsaXVRWlRyVUhNajZvNVhnZWFmelkxK09L?=
 =?utf-8?B?ZCtjcDMwREhpVEdJR0xHTnM5cHBuZ0JYaGNvblFIcDBXRFNlalpYcjVERVB0?=
 =?utf-8?B?bTRUT1JPMEtIaUVlVnRuYlpONldJV3hTcWhLcXRZY3E1K2JvVTgzTGdjd29H?=
 =?utf-8?B?YytXRllWY29kREN0bndxdWtUZ1FGMFJVNlZQdUxOYlVKUzF1SkQzcU9mUEM0?=
 =?utf-8?B?d3JHQm5RTnJOS3BMRGNKRUYzTjhYT2xiNEVqZjlqM254S2ZwVWZwOVlZUnFh?=
 =?utf-8?B?ZWtrb0crdWxWcTkzNmlyQmJiTDBMLzlNejVldG9scDZFUDQyLzhVSkFwRFJw?=
 =?utf-8?B?UjFNSFhrZXBrSzlVdG9VSVRoMTFxaXdUOTFTWW04bUZOb1pkWFY0VmxDRDlC?=
 =?utf-8?B?VktjNzV2MGkzOHBZVnVXd0NCSHYzQ0o5c0IwODFoUUdBaUwxeEw5VldqWEtx?=
 =?utf-8?B?SUFJcGtkK25YU3FiNnl4QjVLRnZqRXY4MkVTZ3FQV05hV0Vya0Q3T2xNNEFR?=
 =?utf-8?B?RW9MSmFVbmVEUDVMUUdheFREOVNkd1lFZFJOZGxUU3ozVE1Yek0yYitkTy90?=
 =?utf-8?B?VkxMV1FDaitxWVpRajVRVHJpcW8rbDYzWUdzcmt4ZWhOaWkrUEtKTDlKT0dG?=
 =?utf-8?B?Uk1xNjU5K0VRbCsvUW5Mc21MK21hWHVxbVRSTlVJejdhcjB4NVNOU3lzN3p1?=
 =?utf-8?B?U3VwUGhnaGcxNW9jdG96RjI0V3pCMEZ2V2dRZlRTVFY1WmFLTktpV2JybGFQ?=
 =?utf-8?B?YllrR2djekp0T0pZa3l6MWNjQXVkbTNXNDNEdnlsMmJiRnVrZ2xrTzVUN09Z?=
 =?utf-8?B?SnVzRFVMWE1hSlY2OGRjVlFDaWQ3bnZXSXN2OU5TSUQ0Wjl1RzdheXZjdU1L?=
 =?utf-8?B?cE15c3k4TW1JeThlcFVKQ2g1K2F3bFBadzAvUmhNWVVvZDVULzNLOC9RT3hX?=
 =?utf-8?B?OFR1WllZL2h2eEpQYmg0cE91ZFRvUUxXU2FKemJnMVJWTG85RlBnRHlyQ0Uv?=
 =?utf-8?Q?/XCD4hnkieQoBtvpFBaEzxuAzoTQd+j2NhneSrj?=
X-OriginatorOrg: kontron.de
X-MS-Exchange-CrossTenant-Network-Message-Id: b82bf9c3-70a1-4cdf-80e1-08d90e3e5d0e
X-MS-Exchange-CrossTenant-AuthSource: AM0PR10MB2963.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2021 14:18:46.3147
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8c9d3c97-3fd9-41c8-a2b1-646f3942daf1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Yxtp4V/VR5cpklX/8AUFvsRIYH07LsY+5gRZJztkwYjSxFGmc6U5vBAFO8g2MDyu3J11QsK+QAz2frDam/tP3w+HRoTP3FS9UKGbiVgyTOY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR10MB3521
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29.04.21 09:30, Peng Fan (OSS) wrote:
> From: Lucas Stach <l.stach@pengutronix.de>
> 
> This allows to nest domains into other power domains and have the
> parent domain powered up/down as required by the child domains.
> 
> Signed-off-by: Lucas Stach <l.stach@pengutronix.de>

With the fix from patch 13/16 squashed:

Reviewed-by: Frieder Schrempf <frieder.schrempf@kontron.de>

> ---
>   drivers/soc/imx/gpcv2.c | 18 +++++++++++++++++-
>   1 file changed, 17 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/soc/imx/gpcv2.c b/drivers/soc/imx/gpcv2.c
> index d27025e37a9e..87165619a689 100644
> --- a/drivers/soc/imx/gpcv2.c
> +++ b/drivers/soc/imx/gpcv2.c
> @@ -12,6 +12,7 @@
>   #include <linux/of_device.h>
>   #include <linux/platform_device.h>
>   #include <linux/pm_domain.h>
> +#include <linux/pm_runtime.h>
>   #include <linux/regmap.h>
>   #include <linux/regulator/consumer.h>
>   #include <linux/sizes.h>
> @@ -141,11 +142,17 @@ static int imx_pgc_power_up(struct generic_pm_domain *genpd)
>   	u32 reg_val;
>   	int ret;
>   
> +	ret = pm_runtime_get_sync(domain->dev);
> +	if (ret) {
> +		pm_runtime_put_noidle(domain->dev);
> +		return ret;
> +	}
> +
>   	if (!IS_ERR(domain->regulator)) {
>   		ret = regulator_enable(domain->regulator);
>   		if (ret) {
>   			dev_err(domain->dev, "failed to enable regulator\n");
> -			return ret;
> +			goto out_put_pm;
>   		}
>   	}
>   
> @@ -200,6 +207,8 @@ static int imx_pgc_power_up(struct generic_pm_domain *genpd)
>   out_regulator_disable:
>   	if (!IS_ERR(domain->regulator))
>   		regulator_disable(domain->regulator);
> +out_put_pm:
> +	pm_runtime_put(domain->dev);
>   
>   	return ret;
>   }
> @@ -262,6 +271,8 @@ static int imx_pgc_power_down(struct generic_pm_domain *genpd)
>   		}
>   	}
>   
> +	pm_runtime_put(domain->dev);
> +
>   	return 0;
>   
>   out_clk_disable:
> @@ -519,6 +530,8 @@ static int imx_pgc_domain_probe(struct platform_device *pdev)
>   		return dev_err_probe(domain->dev, domain->num_clks,
>   				     "Failed to get domain's clocks\n");
>   
> +	pm_runtime_enable(domain->dev);
> +
>   	regmap_update_bits(domain->regmap, GPC_PGC_CPU_MAPPING,
>   			   domain->bits.map, domain->bits.map);
>   
> @@ -542,6 +555,7 @@ static int imx_pgc_domain_probe(struct platform_device *pdev)
>   out_domain_unmap:
>   	regmap_update_bits(domain->regmap, GPC_PGC_CPU_MAPPING,
>   			   domain->bits.map, 0);
> +	pm_runtime_disable(domain->dev);
>   
>   	return ret;
>   }
> @@ -556,6 +570,8 @@ static int imx_pgc_domain_remove(struct platform_device *pdev)
>   	regmap_update_bits(domain->regmap, GPC_PGC_CPU_MAPPING,
>   			   domain->bits.map, 0);
>   
> +	pm_runtime_disable(domain->dev);
> +
>   	return 0;
>   }
>   
> 
