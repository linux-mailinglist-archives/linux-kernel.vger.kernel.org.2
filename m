Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC004374F5C
	for <lists+linux-kernel@lfdr.de>; Thu,  6 May 2021 08:30:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232023AbhEFGbR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 May 2021 02:31:17 -0400
Received: from mail-eopbgr130125.outbound.protection.outlook.com ([40.107.13.125]:36974
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229622AbhEFGbP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 May 2021 02:31:15 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Eu9ZIrZASsCAg7XMg+Zf+vt02477tEWXYW9khRWHhCDrPqfixIikD6aTTcRmvE+Xqzsy+bfT/audUN8IOCgCwi2/xNjaGg3oXkgruvqd2+3hOhuonklA2/z0c5KeVzlXypQELVkwH1MDvS8Rgyw0zO8AsasJCoDTRFIgoqM124Y4SFKO7hTtJEN+BlY/bsmsgeUX31KO/PqbqoAsOmkHp/7GgmodGGFgK/yxmYvYzXdKwU3uH1Ejqsf2DQTm2EPu4dNhAmYLpzvoxXIRLzKdTdOQ4tagO4qFpuN+u6IexQ+D2w5J5ilVohzxAy8zIKzVHghW/gK5hYr0mTjKlF3wmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kxAvLBVK7zWtMeWMOBRbxva3zcKR4ynQDBQIXgadRVk=;
 b=W31Yqdw5Uy+WQc+X5IQz5wsWD0GyjT49oyaifyMILvs+wQuV9xbQGjT96X9I/O5ASwRdxR0kUzHQoJ076r/l72UMV4s1HbwmooaFJyZjUJ5WHIklyTMw0Zt4c0gFJ5KF3T2rIcg8apNORQAaZOBZZMTtLEG/+giuytT2sRkpz9Tlf6AtupO57TZGelFQ/JuHHDKFYBX48kn37imL8GzBn/uPRRu65YKqstfBCfLk4n/zAT40WCkvqbh2IcPMJZh1vPGSENbDmc6bBmDYyDqL0vEXZaAszNucKFhaI05VliZ9g7AR/Dn0RNWXVUKaFBS+70d92VrNT1luzERTnIERAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kontron.de; dmarc=pass action=none header.from=kontron.de;
 dkim=pass header.d=kontron.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mysnt.onmicrosoft.com;
 s=selector2-mysnt-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kxAvLBVK7zWtMeWMOBRbxva3zcKR4ynQDBQIXgadRVk=;
 b=gKjw1xaHXUERvkr2TzFjnsaFmlciyB2F5yFDx8XoTEqKUdRz9QRnXRsZP6DFrnXGXbi0KVmLJEpeNJ71aa71zqFr73ACe87KMzOKdoBWwPGOnSyPq07/VNhBZgO1376qjJlvFCdmCbLKLiLWzBRf2XhEoY9cywMPtENcNesw23E=
Authentication-Results: nxp.com; dkim=none (message not signed)
 header.d=none;nxp.com; dmarc=none action=none header.from=kontron.de;
Received: from AM0PR10MB2963.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:157::14)
 by AM0PR10MB2114.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:42::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25; Thu, 6 May
 2021 06:30:13 +0000
Received: from AM0PR10MB2963.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::3d8a:f56b:3a0c:8a87]) by AM0PR10MB2963.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::3d8a:f56b:3a0c:8a87%7]) with mapi id 15.20.4108.026; Thu, 6 May 2021
 06:30:13 +0000
Subject: Re: [PATCH V2 03/13] soc: imx: gpcv2: switch to clk_bulk_* API
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>, robh+dt@kernel.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        p.zabel@pengutronix.de, l.stach@pengutronix.de, krzk@kernel.org,
        agx@sigxcpu.org, marex@denx.de, andrew.smirnov@gmail.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, ping.bai@nxp.com, aford173@gmail.com,
        abel.vesa@nxp.com, Peng Fan <peng.fan@nxp.com>
References: <20210506010440.7016-1-peng.fan@oss.nxp.com>
 <20210506010440.7016-4-peng.fan@oss.nxp.com>
From:   Frieder Schrempf <frieder.schrempf@kontron.de>
Message-ID: <4e810413-84c8-f04d-45c4-9eabcca2dab0@kontron.de>
Date:   Thu, 6 May 2021 08:30:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
In-Reply-To: <20210506010440.7016-4-peng.fan@oss.nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [89.244.180.42]
X-ClientProxiedBy: FR3P281CA0041.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:4a::17) To AM0PR10MB2963.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:157::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.10.27] (89.244.180.42) by FR3P281CA0041.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:4a::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.11 via Frontend Transport; Thu, 6 May 2021 06:30:12 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 548735d7-f627-499f-580f-08d910586785
X-MS-TrafficTypeDiagnostic: AM0PR10MB2114:
X-Microsoft-Antispam-PRVS: <AM0PR10MB2114B946C18DEC7E4CFB449CE9589@AM0PR10MB2114.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:3276;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: w2TtyI0TjGB9RgeEjoIRoIBRj6Mcm6RjKqc6u1zqSc3cj44Kr92rsJSUczZie46gXu12LL6i/3ZkeArzodAOE1UMs1wqpIp+zYb04roeIpmo6kEdAxSz1mSll0SrOu64KmJiXd9ONhTLez0kieYFOy5VZXoH50i6bkWh2XwwVqw35qHe8WFP5D5SFQ1RzHC4gkLCUkIqeZpo7N7Nfp87pHlFCtZ9TR5oUUZMijQPGcLDnQEZVlwLi1Ds+tISf7UAk67HQL9py9vr1JpueGeSB94zTTxnSdkpbTliWgdwqSb0j6U0XsJJ53Mw45fKlhmttvoIIYGMi0u8Wd72oAjJZZ1U4YL0Rdnw0bPDaa0av7pUeIKu0DbkCQHevq/mcPJA4nehuG66lHH6vLH+QesK06T4q8mACbpXDcKBf6LuIB7kk1FfChuUf56QSOISgKPDfAtz+ExwqhoJfnxkG9RSFHdxK/PuSlb8dv78TwvLzAyAaiGMbm1iOEd7vRmHNM4Vkn3TerdFhhdh3uA4ZZoIj+lUH63i60GGdDSkdKfgcIfXZuf28DEeh8N3dUWjhALYRb24NOxAMcuWZSwba6Al4EqF0VJ+gdMKk8jZ512PTTi646akMLg7OPbd8uwK25Le0O1BWzlFoCg93V/8GJLuD4uS9E2zSC5+Nr1r0i9MQWigdV9gwPmgyuMay7TMDIzc
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR10MB2963.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(366004)(346002)(376002)(396003)(136003)(39850400004)(31686004)(186003)(66476007)(38100700002)(8676002)(66946007)(26005)(66556008)(16576012)(16526019)(8936002)(5660300002)(36756003)(83380400001)(86362001)(2616005)(44832011)(4326008)(31696002)(2906002)(478600001)(316002)(7416002)(6486002)(53546011)(956004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?L0FuV0ZnNGFLT0V1VTAzM3IyTTk4d3N5eTR5enhSSXZ4cHNRbWZvNG5yUEkv?=
 =?utf-8?B?SlBBUjNIS2lVUEtaOWtBVnRIN1NjSVhRNUc0d1hMNmduRFFkYTN2L0xBNnBN?=
 =?utf-8?B?UDhCQ1JNYklpd1c4YUsvTE0yTDhFOFo4T3ZmbUpvb3ZpY1hiZUVDc2pwQ3hM?=
 =?utf-8?B?UldraVUxemU5aFJvVXI0WUtBWHloUmkyc1NSNWFpRTA3Q0dqN29vSjJGNWtz?=
 =?utf-8?B?WHpkV3dZNkpNNmpJYXM4cnFDN1g2SU5rYTRMU2VQQmlqMXFvUjhkdjhDMmUy?=
 =?utf-8?B?M0ZvSnhoSG1id0RkMnd2bWpGd09Oei8yYnRwaUdrTkhSMEs3UnZTcFRWQWFQ?=
 =?utf-8?B?ZStjcm5jWXpMelRFZWxHdTBXRGZnZjluYk5SWXJxbGtCM0VvVG5hSUlwOGt4?=
 =?utf-8?B?S3BHSDJ6clhLbmxRaGpqQ0ZaRnp1UFU1N05mc0RpNUI3djZENVBhd0NmejFB?=
 =?utf-8?B?dmV3blQxaGMzN05xQkxYVGJQYUY0aTAwMGp5Q0poRGlqMTZDNVVMUDJRY3NH?=
 =?utf-8?B?YnNJS3ExVWVsZUZvcFpTUkRNN0xuempMZmJJRkYzSUFCZ1NrZE5nUEE3THRz?=
 =?utf-8?B?SVE2bG9obkFBc0N5cnVIUWVCZTBELzNnNW1aUnc2WW5PZ3JXNTd2MmU3Z3Nh?=
 =?utf-8?B?Y2tUbFVFdDJEZDZUUWFhRzJBRnFod281Z1ZMSDR4Vk1zRGlUN1FUQlFDakNr?=
 =?utf-8?B?YktYYTFGeXNCSGZsaExaa0pqSWw2M2ZqaWwxM3Z2b2srMUhCV2dZTUlCcUhl?=
 =?utf-8?B?ekVKdkJEaERHZ21UWTdjTGdrSWphYmYrUzgvZ1FYSFg2TExTSjdXZWZlNGNz?=
 =?utf-8?B?aDVnbi9VdkdlSHJ5WEJpanBpcG1qWGVqbzFjNm5YQjJoTDZLU2paYzRFNEU3?=
 =?utf-8?B?d1JEZStENFhDSlB3djA5R3dTRFFFdC9HZVk2R0dhbG8vZVNITEFiRkJZNStl?=
 =?utf-8?B?ZmFnUzlhQVcrNFQ5MEJTQXptTjhmM0pRYkRKdE9JU3IxZmxxNE00dlllVkFZ?=
 =?utf-8?B?TlBYOGUzd2U5VkYzc3NRNmpQRHBDUG1rclVJUzBQMUNIZUZ5aDduRVBFL1lR?=
 =?utf-8?B?dzNrRlhTRmdXQytPRlhpWmZLbUttNjkzR3NvS0lxNmhLNEpuOEhZTldGYTdR?=
 =?utf-8?B?MDlSeG1xWTBpdENtNFVMYmJ2MGwwaHJSamZNQlNWTW5UNFFrcXNRajkwT1hT?=
 =?utf-8?B?RkZoUEpPcjM0T0xkZG5sSWxSVHYrWnJ3UmNsWXp6MVE0UWJMMUpSSXpSS1Ro?=
 =?utf-8?B?RDNNd3lUUjQ2TFhFelFDZW9MVExYK3NGRnNCK1VJWEpnMkZYd0RIN0pzUmV2?=
 =?utf-8?B?cXR4QzV0TUNEQ1hjVUFqN1VtR0pOUDU3b3VWYW5KWnI2TkVUZGJVcitiaWlh?=
 =?utf-8?B?b0Y1d1lyQjZlV0p4R3RVcW9jaWYwTzVvbHJvSFhhQWF0TmVwbmd4U1ZaOTh2?=
 =?utf-8?B?OGtsUGxwM1dDMiswRUdlQnpwYnhxMGNKQndVSmtvSmJoZFhvejVOTEVUUURE?=
 =?utf-8?B?L3pzOEtjREFMblNDV1kzV3NSZlZzc3RWVWszdGFxRmlSSWNvRExiRDVBclJM?=
 =?utf-8?B?YVFGc1hJbXZRSDhCU3kzMi9QTjRRU29JSG40MkN4TEd5VHduN204VzRtcGF5?=
 =?utf-8?B?bEl4eFowUGdCY0J6QUtaeGk0ZjRHdjNwU3prc2czL29DWDZnOXZaUmsyTitx?=
 =?utf-8?B?TDYvV3l4OXYvcXo5R2wyTHdid090MmxTRVZSL3BzK0wveENIZld1MmJNRy9h?=
 =?utf-8?Q?fkdnjKy3UW0VQlfvQ2wIV16xJYQbYTsx4P1oq1n?=
X-OriginatorOrg: kontron.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 548735d7-f627-499f-580f-08d910586785
X-MS-Exchange-CrossTenant-AuthSource: AM0PR10MB2963.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2021 06:30:13.1853
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8c9d3c97-3fd9-41c8-a2b1-646f3942daf1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xz61oLyrS3oXAIcyv7+YuQoiaoLokv7HUmUs7qS6V85PBVKb5E1yCis+P9amCt9OBxeJabPeI89fPfIIy9WOT3Xe2RCS36BX1590TL+FNEg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR10MB2114
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06.05.21 03:04, Peng Fan (OSS) wrote:
> From: Lucas Stach <l.stach@pengutronix.de>
> 
> Use clk_bulk API to simplify the code a bit. Also add some error
> checking to the clk_prepare_enable calls.
> 
> Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
> Signed-off-by: Peng Fan <peng.fan@nxp.com>

Reviewed-by: Frieder Schrempf <frieder.schrempf@kontron.de>

> ---
>  drivers/soc/imx/gpcv2.c | 60 +++++++++--------------------------------
>  1 file changed, 12 insertions(+), 48 deletions(-)
> 
> diff --git a/drivers/soc/imx/gpcv2.c b/drivers/soc/imx/gpcv2.c
> index 552d3e6bee52..4222b6e87e7c 100644
> --- a/drivers/soc/imx/gpcv2.c
> +++ b/drivers/soc/imx/gpcv2.c
> @@ -100,13 +100,11 @@
>  
>  #define GPC_PGC_CTRL_PCR		BIT(0)
>  
> -#define GPC_CLK_MAX		6
> -
>  struct imx_pgc_domain {
>  	struct generic_pm_domain genpd;
>  	struct regmap *regmap;
>  	struct regulator *regulator;
> -	struct clk *clk[GPC_CLK_MAX];
> +	struct clk_bulk_data *clks;
>  	int num_clks;
>  
>  	unsigned int pgc;
> @@ -149,8 +147,12 @@ static int imx_gpc_pu_pgc_sw_pxx_req(struct generic_pm_domain *genpd,
>  	}
>  
>  	/* Enable reset clocks for all devices in the domain */
> -	for (i = 0; i < domain->num_clks; i++)
> -		clk_prepare_enable(domain->clk[i]);
> +	ret = clk_bulk_prepare_enable(domain->num_clks, domain->clks);
> +	if (ret) {
> +		dev_err(domain->dev, "failed to enable reset clocks\n");
> +		regulator_disable(domain->regulator);
> +		return ret;
> +	}
>  
>  	if (enable_power_control)
>  		regmap_update_bits(domain->regmap, GPC_PGC_CTRL(domain->pgc),
> @@ -187,8 +189,7 @@ static int imx_gpc_pu_pgc_sw_pxx_req(struct generic_pm_domain *genpd,
>  				   GPC_PGC_CTRL_PCR, 0);
>  
>  	/* Disable reset clocks for all devices in the domain */
> -	for (i = 0; i < domain->num_clks; i++)
> -		clk_disable_unprepare(domain->clk[i]);
> +	clk_bulk_disable_unprepare(domain->num_clks, domain->clks);
>  
>  	if (has_regulator && !on) {
>  		int err;
> @@ -438,41 +439,6 @@ static const struct imx_pgc_domain_data imx8m_pgc_domain_data = {
>  	.reg_access_table = &imx8m_access_table,
>  };
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
>  static int imx_pgc_domain_probe(struct platform_device *pdev)
>  {
>  	struct imx_pgc_domain *domain = pdev->dev.platform_data;
> @@ -490,9 +456,10 @@ static int imx_pgc_domain_probe(struct platform_device *pdev)
>  				      domain->voltage, domain->voltage);
>  	}
>  
> -	ret = imx_pgc_get_clocks(domain);
> -	if (ret)
> -		return dev_err_probe(domain->dev, ret, "Failed to get domain's clocks\n");
> +	domain->num_clks = devm_clk_bulk_get_all(domain->dev, &domain->clks);
> +	if (domain->num_clks < 0)
> +		return dev_err_probe(domain->dev, domain->num_clks,
> +				     "Failed to get domain's clocks\n");
>  
>  	regmap_update_bits(domain->regmap, GPC_PGC_CPU_MAPPING,
>  			   domain->bits.map, domain->bits.map);
> @@ -517,7 +484,6 @@ static int imx_pgc_domain_probe(struct platform_device *pdev)
>  out_domain_unmap:
>  	regmap_update_bits(domain->regmap, GPC_PGC_CPU_MAPPING,
>  			   domain->bits.map, 0);
> -	imx_pgc_put_clocks(domain);
>  
>  	return ret;
>  }
> @@ -532,8 +498,6 @@ static int imx_pgc_domain_remove(struct platform_device *pdev)
>  	regmap_update_bits(domain->regmap, GPC_PGC_CPU_MAPPING,
>  			   domain->bits.map, 0);
>  
> -	imx_pgc_put_clocks(domain);
> -
>  	return 0;
>  }
>  
> 
