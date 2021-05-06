Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E650375034
	for <lists+linux-kernel@lfdr.de>; Thu,  6 May 2021 09:31:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233481AbhEFHcT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 May 2021 03:32:19 -0400
Received: from mail-eopbgr70129.outbound.protection.outlook.com ([40.107.7.129]:9601
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232271AbhEFHcR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 May 2021 03:32:17 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PWv1mvVXvRTWm3c9lRD1nmK5IXeUFtlrBiblj1Bp2TNaroUbH3EnXX4MdSt5EJvM/E5sUD2zc7C1o6VuSxasKxqEsnPilbsKucoIVmT2ZzRvyAgwgjDWa6PLsMkavWEfr5zbTY+S+K/Bn6u22Qc1vUa+AXO8vYkS8h2guTVcIK3n6Je1KfZE0GTufeSuN2t/fuIaucXgICtfUzZATVO2beQRkHIg9dc1Dfd/NzpfCad7dWqlVM+vgHo+Cq6HWHNLoracnAriWMm1RnebVLTlIhDXJh6rACKOLMJV4RSiORfxlUMBvgyAfB3UxiRvBCbZqMBgdx8JuAAGHcH2ALTnJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jPJFZwcv1yY4YE9O6p+gGopYbBFRSy4kdL6KLBLoCgo=;
 b=FkzfAoQYom1SCuBJXhN7iWEzig5WAngMGA8NyiXOkeo0bd5aJUH9bRI2g0NWQxYWM1Qbqhd0r9R4XByY2QOxgMn1BIJlq/XlbbJ1L4dWb5YGCWt+glzg9Kt3A8OOyNZnmNmfoD/rshgQ08h7AaxFopPKw+92YVib/cjK+8tggjqnvRbJAQEXDufWzjjo1gKdEEd1yMPs4UkAXrsA3XoCgErzN81bS7yvjNPx5Eg21OsVGOSdeVRrhZdyHotRUyT4aySgk/IFNGcr5mgTQpdtgChqrwOdci6KeNfKtn1xd+6jP9v4ue88tlkjJ26Wyu2oeiRZH3e6gurThQW5yWaN9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kontron.de; dmarc=pass action=none header.from=kontron.de;
 dkim=pass header.d=kontron.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mysnt.onmicrosoft.com;
 s=selector2-mysnt-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jPJFZwcv1yY4YE9O6p+gGopYbBFRSy4kdL6KLBLoCgo=;
 b=dEE2FBUT9XgTNiSuSNtbNzAEeAmlLK2d2vVdpCZhOvOxJ6HxarvNm9pEH2GSI4q0cP9SopIdaBBZl0yTPVYZt1n4v2AKiOw4XV0RUkLDIMgj/lxVYpW0t6hFI5Slgo7hxR/KVyH1zC8NGFvNKsr7oTy2I3jfFKF/0eNC16gHZ6I=
Authentication-Results: nxp.com; dkim=none (message not signed)
 header.d=none;nxp.com; dmarc=none action=none header.from=kontron.de;
Received: from AM0PR10MB2963.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:157::14)
 by AM8PR10MB4132.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1ef::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.24; Thu, 6 May
 2021 07:31:17 +0000
Received: from AM0PR10MB2963.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::3d8a:f56b:3a0c:8a87]) by AM0PR10MB2963.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::3d8a:f56b:3a0c:8a87%7]) with mapi id 15.20.4108.026; Thu, 6 May 2021
 07:31:16 +0000
Subject: Re: [PATCH V3 3/4] soc: imx: Add generic blk-ctl driver
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>, robh+dt@kernel.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        p.zabel@pengutronix.de, l.stach@pengutronix.de, krzk@kernel.org,
        agx@sigxcpu.org, marex@denx.de, andrew.smirnov@gmail.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, ping.bai@nxp.com, aford173@gmail.com,
        abel.vesa@nxp.com, Peng Fan <peng.fan@nxp.com>
References: <20210506041555.10719-1-peng.fan@oss.nxp.com>
 <20210506041555.10719-4-peng.fan@oss.nxp.com>
From:   Frieder Schrempf <frieder.schrempf@kontron.de>
Message-ID: <32ffebc3-2155-4b92-5795-37d63235eb51@kontron.de>
Date:   Thu, 6 May 2021 09:31:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
In-Reply-To: <20210506041555.10719-4-peng.fan@oss.nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [89.244.180.42]
X-ClientProxiedBy: AM6PR0202CA0046.eurprd02.prod.outlook.com
 (2603:10a6:20b:3a::23) To AM0PR10MB2963.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:157::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.10.27] (89.244.180.42) by AM6PR0202CA0046.eurprd02.prod.outlook.com (2603:10a6:20b:3a::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.24 via Frontend Transport; Thu, 6 May 2021 07:31:15 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 055b2308-538f-485c-2437-08d91060ef21
X-MS-TrafficTypeDiagnostic: AM8PR10MB4132:
X-Microsoft-Antispam-PRVS: <AM8PR10MB4132975F34845060BCD832FBE9589@AM8PR10MB4132.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CFvu8dcgrnlQ4ytUkqdScGOVCatsK6F1QMhd+ErODijrCDLRgv1dJIrZmUuhKEVvxJ+PL05TSUuQlJn8xRdUGKOF9krAjh9aSsNzaoByqdRpVXrJUCkZLnXEIYxfGghmM6Pej0P6Hkmo14Mhyew1aW0wT0o1Yeyt+QjOPAYLMg8SyHxNtk9z7EUWpGYmOFJgSjxSmW8UXKrE48rnpqbShVq7HTcgkN5q2icCj2QjIiJYFJ2ibvscPqPbwOcSKE/KyMY3H2D6YKNd3mAZTJrIqi3YqvZZMePE0aW8tTHfMnIBFx/HmFSH6npC8ClzotpM3vZyoVhW2s2dLdx4rhB6sDmr5V9krZE4+WBd9NfL2rZm44+9Pl/vmd5LLwdon0Lr+c2U+cYNYYmhFmksgSRyk3BTFKqGABzNNIUUf640W86Rf27If/j3CaLiqKU9t0nE4tyLGHU1c9V9rd+7Ybm+AYdYy8wZkQehR2lW1uiusz2f5FHpFPhqxHfXvGlmAkD4MbjxfjBtRs4bpfyU2wjjElzK2OeyHIkWHZjNvXQexcTodAQHzuuyRE7eDIsPnTfRSY4HViw9MniSBT8tRoTZ+LTCrGAOrw3JRevTZbTV7nkzrLHb4kDjn22aFBElDbu4eNz1b6YWQFKYixYNhngJN3r6OjkCOSA67S494cwIdhsPUIiQjBMKTnaUEfYg43SA6v4W1q1puiI/dO8V0lspEQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR10MB2963.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(376002)(39840400004)(396003)(366004)(136003)(346002)(86362001)(8676002)(316002)(6486002)(26005)(38100700002)(53546011)(5660300002)(66476007)(478600001)(16526019)(2906002)(66556008)(83380400001)(16576012)(7416002)(66946007)(4326008)(8936002)(956004)(186003)(31686004)(44832011)(2616005)(36756003)(31696002)(41533002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?ajJhMXN3ci9SM1VHaGp5SDZIUm12VzJGTjFuNGFvVDdBNkVUTHN6V2kwWHA2?=
 =?utf-8?B?OWY3S25XVjNkbWhRRncvY01LU1ovVEZFTE1OeE4vaUVncGpYaHBnL3V0ekFF?=
 =?utf-8?B?bWx4elBhU1lBYVl5TjNFVW9KbVVaQmtMWVNHZHRDWm90a1R6YzlIYlJZaGdH?=
 =?utf-8?B?RnhGcmRMSENKUlJEV2liU09TUGw4M2x0TnQ3YzBNYi91R0xMWnA4cXB5cmtm?=
 =?utf-8?B?OGlKVUFDN25tTUw5SnhKUFllVG9LSWVFbmhHcmlyVlQwUjBFblQ1Q1d3WXBO?=
 =?utf-8?B?eFdsMjJKQmlhcTB5WlA0c2p0amZDODg4RzVjMHFGdUI5bktLd3lkalVTRHVr?=
 =?utf-8?B?UUZwNnRVVEp6dFlPSDBueTVYWStxbXh5eVdoVWhBdk9ZczdrSWoxY2pJZHZs?=
 =?utf-8?B?VUpSazVKblVtT1NaZEd2MXp3cEVOck15TEpEL1RubFIxenluRUpOQ0wzcnhZ?=
 =?utf-8?B?S2NwUHZ2Y1hWUkZLalpxbkVEUTdPTEZKNExzTjNyaHBIMzNrUmRGVlY2TFRy?=
 =?utf-8?B?a3B1MFhLR1h1dkFQOSt2ZWZsVUcwVjJxSmRuNTZuVmJJT2ZpdWhYckZDakkz?=
 =?utf-8?B?T3Nua2dQZzYrTHV4RGxteE5UMXFrTDFOOHNhMVpaTkRLOG9vNExCMGpoYThr?=
 =?utf-8?B?SHlQdEFuZk5NR3ljbjR4S3JXQ25OZkFaOUpRZHNwcDBYMmcwNVJMeUUrd1h2?=
 =?utf-8?B?YzNOOG9MMHkyL1pMR3NXMUcwQXM0QW5JZVBYN0hlcG54NmdyK2dzUGNEOGxy?=
 =?utf-8?B?RDBZSU5seHgrbFgzeDM4QWNOZmtGUENGS0ZFUForc3ZXcmJJUU9mVGpFYnNH?=
 =?utf-8?B?Y29kSXNRUks4Q3BNQTNubFErMHd1NDJCTjcrdzFGVUgrMk5rWVhqT20zcnB3?=
 =?utf-8?B?V2dNc0h5K2pZMnh1Y1pOWmZ5elNKaVViYW1rL3BlUzJSRFBjaWpXTWpvVUpW?=
 =?utf-8?B?bE4yanJITGlpeDFiMGdjdkx0ZHN1NG5MbGI1UkNheVREbHJ0NnVWcE0zdk1z?=
 =?utf-8?B?M2JlOEYzbko0OHhYR2o3Z21KUEFXb1BjdkFxM21tOWJVdEV2ckNtN2FCVUhK?=
 =?utf-8?B?Q1pWdFdzeitpdTYxUlU4WFN3aHl1Q1lFa2tjYWRUVHVRRVppSVRENzh2MW41?=
 =?utf-8?B?aVdLYlVzREhDdk80Z1A5THJlSUlmWDdjWFB6YmhpVHdEZlhFOHFEcjI4TTJj?=
 =?utf-8?B?ZXVXTnZVdkIvUW1Db1ZHZFFjdWVSeHVEMncvdkhtR3FMc2NrTExZTWJwSkMz?=
 =?utf-8?B?Q0tiUmsrUDFOM2svMmlITWExYWRBbmpJYTl1aXdDTmNIT3ltMEtVVUc1VkRo?=
 =?utf-8?B?aXoyTHNDUk95RWNlYnRJOVo3cHJJMSt0dHBuYU5GVjJHVFllTkRkQkhidjhM?=
 =?utf-8?B?a1c5SDVReEZTYy9pZlAxeWpldkFUaFN6amtVRk56Tit1ZTlpOGVXL1pBNUE5?=
 =?utf-8?B?WXpDSlpub1puMFQ0ajhndTNkeWFJSlVTL1VXYllhRkxKTG1CZStOb09wazR6?=
 =?utf-8?B?K1lTcVNMN0E2bHBaQjVpdjlQWmp2VlliUzduTnVrMStPYXF1NlcrMHR2REIz?=
 =?utf-8?B?NnYyTjFjYlUybngvbWk5OTIrWXdZZVAvak9JOFNMSDRPS1VUZitHNVZFMjJE?=
 =?utf-8?B?MlVtbWhyV2R2QThQUHhSTy9KMUpKSzJuNWdrVTMyczZQK1BucHQ0MytrenRX?=
 =?utf-8?B?Skk2MVRSVUNTWVpxOTg3OEgxZUViMjZJTTBMenlvY3JDMUpSZndVaDcrMHJM?=
 =?utf-8?Q?dEOFAMAVCoQqUG/sUlf1rFY0M+llqlEVsCUc+cW?=
X-OriginatorOrg: kontron.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 055b2308-538f-485c-2437-08d91060ef21
X-MS-Exchange-CrossTenant-AuthSource: AM0PR10MB2963.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2021 07:31:16.8824
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8c9d3c97-3fd9-41c8-a2b1-646f3942daf1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V3/aZsJBnnISADXe6Qi3mIwl4z+3fqcY19rGQg3e3cACCYRdb/mIoSOS/a9aYwjYr16O0msHf/XcWbHNVy1VpvgE/142fIJsrwZSOGxcFE4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR10MB4132
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06.05.21 06:15, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> The i.MX8MM introduces an IP named BLK_CTL and usually is comprised of
> some GPRs.
> 
> The GPRs has some clock bits and reset bits, but here we take it
> as virtual PDs, because of the clock and power domain A/B lock issue
> when taking it as a clock controller.
> 
> For some bits, it might be good to also make it as a reset controller,
> but to i.MX8MM, we not add that support for now.
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  drivers/soc/imx/Makefile  |   2 +-
>  drivers/soc/imx/blk-ctl.c | 307 ++++++++++++++++++++++++++++++++++++++
>  drivers/soc/imx/blk-ctl.h |  77 ++++++++++
>  3 files changed, 385 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/soc/imx/blk-ctl.c
>  create mode 100644 drivers/soc/imx/blk-ctl.h
> 
> diff --git a/drivers/soc/imx/Makefile b/drivers/soc/imx/Makefile
> index 078dc918f4f3..d3d2b49a386c 100644
> --- a/drivers/soc/imx/Makefile
> +++ b/drivers/soc/imx/Makefile
> @@ -4,4 +4,4 @@ obj-$(CONFIG_ARCH_MXC) += soc-imx.o
>  endif
>  obj-$(CONFIG_HAVE_IMX_GPC) += gpc.o
>  obj-$(CONFIG_IMX_GPCV2_PM_DOMAINS) += gpcv2.o
> -obj-$(CONFIG_SOC_IMX8M) += soc-imx8m.o
> +obj-$(CONFIG_SOC_IMX8M) += soc-imx8m.o blk-ctl.o
> diff --git a/drivers/soc/imx/blk-ctl.c b/drivers/soc/imx/blk-ctl.c
> new file mode 100644
> index 000000000000..e184d862b26b
> --- /dev/null
> +++ b/drivers/soc/imx/blk-ctl.c
> @@ -0,0 +1,307 @@
[...]
> +
> +	blk_ctl->power_count--;
> +
> +	if (!blk_ctl->power_count) {
> +		ret = imx_blk_ctl_enable_hsk(blk_ctl->dev);
> +		if (ret)
> +			dev_err(blk_ctl->dev, "Hankshake failed when power off\n");

You still have a 'k' instead of a 'd' in "Handshake"!

> +	}
> +
> +hsk_fail:
> +	clk_bulk_disable_unprepare(blk_ctl->num_clks, blk_ctl->clks);
> +
> +	mutex_unlock(&blk_ctl->lock);
> +
> +	return ret;
> +}
> +
> +int imx_blk_ctl_power_on(struct generic_pm_domain *domain)
> +{
> +	struct imx_blk_ctl_domain *pd = to_imx_blk_ctl_pd(domain);
> +	struct imx_blk_ctl *blk_ctl = pd->blk_ctl;
> +	struct regmap *regmap = blk_ctl->regmap;
> +	const struct imx_blk_ctl_hw *hw = &blk_ctl->dev_data->pds[pd->id];
> +	int ret;
> +
> +	mutex_lock(&blk_ctl->lock);
> +
> +	ret = clk_bulk_prepare_enable(blk_ctl->num_clks, blk_ctl->clks);
> +	if (ret) {
> +		mutex_unlock(&blk_ctl->lock);
> +		return ret;
> +	}
> +
> +	if (!blk_ctl->power_count) {
> +		ret = imx_blk_ctl_enable_hsk(blk_ctl->dev);
> +		if (ret) {
> +			dev_err(blk_ctl->dev, "Hankshake failed when power on\n");

You still have a 'k' instead of a 'd' in "Handshake"!

> +			goto disable_clk;
> +		}
> +	}
> +
[...]
