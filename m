Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2828C3715F5
	for <lists+linux-kernel@lfdr.de>; Mon,  3 May 2021 15:27:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234272AbhECN2p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 May 2021 09:28:45 -0400
Received: from mail-eopbgr50095.outbound.protection.outlook.com ([40.107.5.95]:34469
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233773AbhECN2n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 May 2021 09:28:43 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AG9/udV30TsZPK1nj8F4xciizFmiPrlTCtxokhTqGuwdPYGBaPadRostFQbhb59Qxs313r4MqYspcFFklJoCP6wb/GfNU4RIYLNGl7eNmTrd6htBOGrwslrk0mEcRUB7GYPFEg5L61MLJh+/ypsrxUwu1XOBosSW8Al7GRJcNGNT22Zeq+xm80aWocqO8kpu8a89xcE4T6xk6DXv/m/LdsqXx9lx91z0OnihNM3bHvTFWMdn3d1pHJD7ZcAUgQTgCS8iKqmLCTsFTmpQjSanggk+46QSb8hzwawrCz6a3VP8taIATQESSsRA5M6oXPLynLPK99YObuLRQ2TQ1KR00Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sfQO5XcsSrjrbvbyS89aVhwPhsyrpDKQhnfGvaT2BGU=;
 b=fv+uiYgZKq+m1JUymmkYbdoZt9IkTLPVwKfJzTl+/y4dA/iswACu5/lljB50qYgiuw8Gai7oiWjv7fOwckZ56Eth5RMaqHzyZa3+LZ5HbV9Lcx853SMHFMNUsPd54bLrBgn+lNFpyfz0GyrCGx3JQ1r5d7iV75PgthYBJdILXGmuZ0mO+rzKKoy0OUNozY+1UDmhA+7ciXuJxxMACL5Gw/7GyrgT9oMMDmO+zBz07ga8d2hKszpn1VvnJ2opxufwMafej/cVw1rbWiJ2MHKwDDfM5HkwSxqDuns+pGo0pXfuduU5QXFStWBc3K/G7x+jDqqroCGBTvExBnt37+lbEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kontron.de; dmarc=pass action=none header.from=kontron.de;
 dkim=pass header.d=kontron.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mysnt.onmicrosoft.com;
 s=selector2-mysnt-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sfQO5XcsSrjrbvbyS89aVhwPhsyrpDKQhnfGvaT2BGU=;
 b=bRnfBugU/6yqgKm2i6ALa+18YjhaP80tOsjydTWXEMqJdtaxohdwBn4N0KZJ991YOXYTNyz4CvS9W7ktWj6ZykAgw88O8oYPk9Awl3u4kunhAr04ftT0PoVol04cQ1xyF7WlZ3ko8ZUm0tfIgUC8p1vUZswfmkY8HiDTWkzVpLE=
Authentication-Results: nxp.com; dkim=none (message not signed)
 header.d=none;nxp.com; dmarc=none action=none header.from=kontron.de;
Received: from AM0PR10MB2963.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:157::14)
 by AM9PR10MB4564.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:260::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.40; Mon, 3 May
 2021 13:27:48 +0000
Received: from AM0PR10MB2963.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::3d8a:f56b:3a0c:8a87]) by AM0PR10MB2963.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::3d8a:f56b:3a0c:8a87%7]) with mapi id 15.20.4087.044; Mon, 3 May 2021
 13:27:48 +0000
Subject: Re: [PATCH 02/16] soc: imx: gpcv2: move domain mapping to domain
 driver probe
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>, robh+dt@kernel.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        p.zabel@pengutronix.de, l.stach@pengutronix.de, krzk@kernel.org,
        agx@sigxcpu.org, marex@denx.de, andrew.smirnov@gmail.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, ping.bai@nxp.com, aford173@gmail.com,
        abel.vesa@nxp.com
References: <20210429073050.21039-1-peng.fan@oss.nxp.com>
 <20210429073050.21039-3-peng.fan@oss.nxp.com>
From:   Frieder Schrempf <frieder.schrempf@kontron.de>
Message-ID: <6c4e6934-c0f0-7838-4dbc-3a639dfd06d0@kontron.de>
Date:   Mon, 3 May 2021 15:27:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
In-Reply-To: <20210429073050.21039-3-peng.fan@oss.nxp.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [109.250.134.29]
X-ClientProxiedBy: AM0PR03CA0097.eurprd03.prod.outlook.com
 (2603:10a6:208:69::38) To AM0PR10MB2963.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:157::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.10.27] (109.250.134.29) by AM0PR03CA0097.eurprd03.prod.outlook.com (2603:10a6:208:69::38) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.27 via Frontend Transport; Mon, 3 May 2021 13:27:47 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d4a3ddd0-8c4f-4341-afee-08d90e373e26
X-MS-TrafficTypeDiagnostic: AM9PR10MB4564:
X-Microsoft-Antispam-PRVS: <AM9PR10MB4564642D5E83B1D1EE13C18CE95B9@AM9PR10MB4564.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BTsJeRJ+rg70NIRrtHfsvAuAom3CHVm+/Pvj2wUDvUUT2MonQdIhcfZghkJ5qOVoICN5omePMzV5yHQD5ZwVXty7DXdpF+jd0F/aVGRZw62SjQt019U9Ao/ZtQzDhHFqSdgTP4t27K0K8yE2TXhjUhA+EeUOi1XySH4jwMPrmn9qnjea1LQvkxYVszHM8Jga71PVx2aIUEKscwhsu/Ite2AnHQeAP4489+3V8Lzdoo3rxASasaolkG5rMWG40lcfxqksEicp+oU4Kg8TcBdcRqyuAkcpF4Pv+1GxoNoo/H9gWpliQq3XMGbIXx3K9lxeIw8DPNyMX+sXoOkJurCrppT2totSpX5AHXWF1D74Azz/VbiYds5h3ibOdOWuSKj/UCi8VY5+0Ndf9kSYPjbzIZT5eFGCfyaYpMA/oMtYs2miU8j0rOjb8h6xe0n6cIPKvDpmS+FiZUWqOUAliWYyCDA8K/dP8RtFpDUySa3Pox1ipOYJ1QFa/ORwfGFMT9BzR2UVwpRoF5anFO+lx99MF9CIEdA9I1RMXhmxD4S2/TfUirQV5BVU3HPb64m7YB+q1UgBsvTbR0XejZDmT4zZwjR0GmbWnVSFytX1zgnDGqefP+erT8zGlNFHXLhoiYN5Dljuc9TtANUjoN28RzHSlwme7JXklwbHAx+IJ3vrDYH8HvJvdFnmz+QLfkwiYqLQ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR10MB2963.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(366004)(39850400004)(346002)(376002)(396003)(136003)(66476007)(31696002)(38100700002)(2616005)(4326008)(6486002)(36756003)(66946007)(66556008)(478600001)(8676002)(53546011)(31686004)(7416002)(956004)(86362001)(2906002)(316002)(16576012)(8936002)(83380400001)(26005)(186003)(16526019)(5660300002)(44832011)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?RjNjZ0M3NjZKaXlmUnllKzVRbExQamtuNUpPM01tek9HZWZJL2o5bGFHaWxC?=
 =?utf-8?B?M2REQ2MxM0V1T0w1N1ZsNlkyYitXZTVTcDU3T3d1cUdSdGYzbEYwaVRUbFY1?=
 =?utf-8?B?NnFTRmEyTVpGZDJBck9salBaS1ovZkxxaUZyNVdGVmEwM2xjWlpKbTNBS2Rn?=
 =?utf-8?B?dVNrbHB5aTU2TjBaek1VanBuUy81R2gxbmgrUDdVb24rVlNUUG1DQVMvTXJG?=
 =?utf-8?B?S3lqYnV6b3RNdkpKZmI0QVhtNWRLUDdDVG1ubVMraVZaZ256RE9TcVhZVi9n?=
 =?utf-8?B?NjU3NDVSOVRyM3VkcThTMXFZUGRLTUhiY2xuZzNzZSsveTBNRnIzMTlIN3pF?=
 =?utf-8?B?TWhOWXJHWjVodlJuSEI2MEVBMDh1cWR5UlczRG84YjVqb1U1MitEbHNaU0ll?=
 =?utf-8?B?LysyczFlR1VHZGx6MmFhdlZYRU5xazhqNCtHcDBUWmhKTnVKK1dQMVpMOVZp?=
 =?utf-8?B?VGplVUsydTJuNUQvY2hLTFdCcTVQWFhTSU8zTHJQaUxtOHpIc2NhQ3Niajdj?=
 =?utf-8?B?a1RwbTdVVkFqeWlITXBhTVFDa0dnRmRaU0FQK2JzcU0xdVZFZFozVUc3SSt3?=
 =?utf-8?B?ejFkbEhXb2dLQUU2RnYzVmxCVlhmTUpmd2JaOXBMZFZZNXpHZTBFanY4WjFQ?=
 =?utf-8?B?cGEyS3dOanY5VlZXNG1JZzFaVFhrMVczMG51VEpPNGt4NlhRSk96WFRlbFcv?=
 =?utf-8?B?cXpQcUhjdXJTd0FEL0gvZDNaMTkxTDdjb1BLTUVHTGNvOGdiZGExM3RFeCtm?=
 =?utf-8?B?Tm1aOWhwWmlFeWs4NFBrTUhRNURmTTRuRVM5Sm5hN3VIVTg2WHZPZFFOaHZ2?=
 =?utf-8?B?Rkg3Sm9uZUpScmVrK1NxKzdPbjJ1WmJWYU1tWkFoN1JmNUFpQjV0Q2ZMbzBF?=
 =?utf-8?B?NDRrbi96TlE1NjAyeVZPQ25tV0VUUlIzYWc0SkJmSUJrWHBRWHZwVHlGaDk0?=
 =?utf-8?B?RjQ1bG9Jd3plbWZqenBFK3RoZFJmU05uR0lTRVgweTlaamNpeVJQeU1PWEhv?=
 =?utf-8?B?bWVDN2IvVmcram9Ud0MwdHNFV0NIMGwxN2ZqeUh3c3V3V0ZITHBqR2Jlb1F3?=
 =?utf-8?B?bHYzT240MVNOckVJUGZUQ3o2THRyQzJ1d2ZmQUNQaHFjNlR2K2FzV1kxZVVT?=
 =?utf-8?B?VGtJckU1Q3Z5UjB5eWFKc3h6dnlvMWdRUmhzR0RXbGpaNzJTd0dSR1JjUWRN?=
 =?utf-8?B?cGh1aFdDV1p1a3QwdmlZMzhnSWIwdmgxUkFNQmhlY1dUZWxTd1dZdkxBSm5w?=
 =?utf-8?B?b2taVTdicTQvM1I0VFRnUElqbmRNcHQwYWxKd2RBZ3diSHlEbzlxQmsxZkgr?=
 =?utf-8?B?YW1MOXd4TDR1Mk9QR0xtbG1wd3V5TmVUVWt1dHhJT3RNTUJBOWZ3T2d1aE8v?=
 =?utf-8?B?SDA2Uzh2ZDg5SXRQVng2SEJiK3VtUU5HY1ZtSEZ5YmtSb25IaGlyZXF5V3RY?=
 =?utf-8?B?OCsvQ044NmowQ1lINjd4bklrMytvMXpiMmdIZjRST2NEdWdPNmdaUnBqSzM3?=
 =?utf-8?B?RFRuYm4zb2YwL1EvQk1sYVZKWk9VVmpxOU8xZTdEVDU2NnRlR011NnRuNWR1?=
 =?utf-8?B?dkJibEwwbks3RCtFOEpMRXRNTXYyTUVQZnJBM01mTEhRK0RoRjdQcm5NZTJl?=
 =?utf-8?B?Q0lTYjhPY3l3VEMzVURJRUd3YnhOYnVuUHFrVHlOWWFMbG41bkg4Si90eExs?=
 =?utf-8?B?aEorYzQvNi8vQUhsVjMrUm9kQ0VabFV4Yklmand3VTVlSFlVcXlidmp6d3Yz?=
 =?utf-8?Q?zs7Hz91fnrfR6N9Lmm4rEmcizXUmgdBxzHLswWN?=
X-OriginatorOrg: kontron.de
X-MS-Exchange-CrossTenant-Network-Message-Id: d4a3ddd0-8c4f-4341-afee-08d90e373e26
X-MS-Exchange-CrossTenant-AuthSource: AM0PR10MB2963.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2021 13:27:47.9977
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8c9d3c97-3fd9-41c8-a2b1-646f3942daf1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kO38L7+/zJjrnP7NwuhlE8KTqGUa0OHngCcAzWoZQWqvs4jfAchI8lRReGCvQiaZuNDkqK10fHms9hyx20Th5cuv7KnUJH8BwkFdAK2S7I8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR10MB4564
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29.04.21 09:30, Peng Fan (OSS) wrote:
> From: Lucas Stach <l.stach@pengutronix.de>
> 
> As long as the power domain driver is active we want power control
> over the domain (which is what the mapping bit requests), so there
> is no point in whacking it for every power control action, simply
> set the bit in driver probe and clear it when the driver is removed.
> 
> Signed-off-by: Lucas Stach <l.stach@pengutronix.de>

Reviewed-by: Frieder Schrempf <frieder.schrempf@kontron.de>

> ---
>   drivers/soc/imx/gpcv2.c | 22 +++++++++++++---------
>   1 file changed, 13 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/soc/imx/gpcv2.c b/drivers/soc/imx/gpcv2.c
> index 512e6f4acafd..552d3e6bee52 100644
> --- a/drivers/soc/imx/gpcv2.c
> +++ b/drivers/soc/imx/gpcv2.c
> @@ -140,14 +140,11 @@ static int imx_gpc_pu_pgc_sw_pxx_req(struct generic_pm_domain *genpd,
>   	int i, ret = 0;
>   	u32 pxx_req;
>   
> -	regmap_update_bits(domain->regmap, GPC_PGC_CPU_MAPPING,
> -			   domain->bits.map, domain->bits.map);
> -
>   	if (has_regulator && on) {
>   		ret = regulator_enable(domain->regulator);
>   		if (ret) {
>   			dev_err(domain->dev, "failed to enable regulator\n");
> -			goto unmap;
> +			return ret;
>   		}
>   	}
>   
> @@ -203,9 +200,7 @@ static int imx_gpc_pu_pgc_sw_pxx_req(struct generic_pm_domain *genpd,
>   		/* Preserve earlier error code */
>   		ret = ret ?: err;
>   	}
> -unmap:
> -	regmap_update_bits(domain->regmap, GPC_PGC_CPU_MAPPING,
> -			   domain->bits.map, 0);
> +
>   	return ret;
>   }
>   
> @@ -499,10 +494,13 @@ static int imx_pgc_domain_probe(struct platform_device *pdev)
>   	if (ret)
>   		return dev_err_probe(domain->dev, ret, "Failed to get domain's clocks\n");
>   
> +	regmap_update_bits(domain->regmap, GPC_PGC_CPU_MAPPING,
> +			   domain->bits.map, domain->bits.map);
> +
>   	ret = pm_genpd_init(&domain->genpd, NULL, true);
>   	if (ret) {
>   		dev_err(domain->dev, "Failed to init power domain\n");
> -		goto out_put_clocks;
> +		goto out_domain_unmap;
>   	}
>   
>   	ret = of_genpd_add_provider_simple(domain->dev->of_node,
> @@ -516,7 +514,9 @@ static int imx_pgc_domain_probe(struct platform_device *pdev)
>   
>   out_genpd_remove:
>   	pm_genpd_remove(&domain->genpd);
> -out_put_clocks:
> +out_domain_unmap:
> +	regmap_update_bits(domain->regmap, GPC_PGC_CPU_MAPPING,
> +			   domain->bits.map, 0);
>   	imx_pgc_put_clocks(domain);
>   
>   	return ret;
> @@ -528,6 +528,10 @@ static int imx_pgc_domain_remove(struct platform_device *pdev)
>   
>   	of_genpd_del_provider(domain->dev->of_node);
>   	pm_genpd_remove(&domain->genpd);
> +
> +	regmap_update_bits(domain->regmap, GPC_PGC_CPU_MAPPING,
> +			   domain->bits.map, 0);
> +
>   	imx_pgc_put_clocks(domain);
>   
>   	return 0;
> 
