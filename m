Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59BF23716B9
	for <lists+linux-kernel@lfdr.de>; Mon,  3 May 2021 16:38:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229828AbhECOi7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 May 2021 10:38:59 -0400
Received: from mail-db8eur05on2119.outbound.protection.outlook.com ([40.107.20.119]:53857
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229739AbhECOi4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 May 2021 10:38:56 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DLWLLG9nT5Cm2Hl/tUH641NBz+p5mrhiXla6BOcLDLgD0C7gLIpMd3Hmf9Lh43Zo1Dhn+m7qEZA96j2GsX3kiMvvnG0MZlnETm5GGhnCTxWMRIZgvB/bmMjHyJTssYidqXZpqiFOWY8zhZ1734ExmaoJLcwZLsvuL2CbYimPuZSkX3ojzeE5LsvFRbqmN+RWmmJf0CKwv0mkuPjJRyc75Ppo/Z6liX4e5sqcS/IctSHwl9yRGxjjH8G4ZLCKKXmLVEeseyrcYRExZrn4kd9Pu9J+5J4RjFk0Q1VRLH75aROo6pOMLI0ciX8Z5XJ8zNgirHn0c2FmhwMUqLkXz0Hpbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hSmTbq13nBpAj7Tow0TyCokob/7qXkJIujO7RIME9nw=;
 b=i2zYsY7+5wUOWsMq69QQGi+B+iuyGmnqOxrEsIwpTwaLcr6raNtmY3blgbm5rAdjpkZeFmmZDy45iJmw7Dyeakjw2f0UFm4hXuJ5nEfHGDc1XGxhUlqBcuUZnDRMTlmR78ZpCznqSisuFufbrJVzMi1p3n5UKEyXw5Rtnc0NPR98FDNG+cAR7c/i2eg5Do7woLME/055CRWQiRqB1B+sU/koGTddXLAR00IVH1rtH7cCVtzmkdjhdxwq/UpnKlJTz21Ay8+AmlkQnEVobGcNy0lGgnnZ6AZ/eahr2rYnlca4PDdFA14kFxQGyv6CSFv7Po0dWXQj8CQqEbNJIlOHBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kontron.de; dmarc=pass action=none header.from=kontron.de;
 dkim=pass header.d=kontron.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mysnt.onmicrosoft.com;
 s=selector2-mysnt-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hSmTbq13nBpAj7Tow0TyCokob/7qXkJIujO7RIME9nw=;
 b=PoLDstwSMRi/fg49cqMf2jvv8poGSlF22w2a/koSnhMOjTByqoLXJ4RLUdcSO4xlwUzutzz5zPJGyyF+YWvgx8mvCHeGqU7OVn7RW0y4Bgnut8jsZRa/j5vljJ6GqlknUUqtF5RSxqs7oxqEliy+97RIIelSooRhLXuNEoOK1FE=
Authentication-Results: nxp.com; dkim=none (message not signed)
 header.d=none;nxp.com; dmarc=none action=none header.from=kontron.de;
Received: from AM0PR10MB2963.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:157::14)
 by AM0PR10MB1873.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:48::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.43; Mon, 3 May
 2021 14:38:01 +0000
Received: from AM0PR10MB2963.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::3d8a:f56b:3a0c:8a87]) by AM0PR10MB2963.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::3d8a:f56b:3a0c:8a87%7]) with mapi id 15.20.4087.044; Mon, 3 May 2021
 14:38:01 +0000
Subject: Re: [PATCH 11/16] soc: imx: gpcv2: add support for i.MX8MM power
 domains
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>, robh+dt@kernel.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        p.zabel@pengutronix.de, l.stach@pengutronix.de, krzk@kernel.org,
        agx@sigxcpu.org, marex@denx.de, andrew.smirnov@gmail.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, ping.bai@nxp.com, aford173@gmail.com,
        abel.vesa@nxp.com
References: <20210429073050.21039-1-peng.fan@oss.nxp.com>
 <20210429073050.21039-12-peng.fan@oss.nxp.com>
From:   Frieder Schrempf <frieder.schrempf@kontron.de>
Message-ID: <48aed4cc-448e-7452-cce8-ffce929bca3a@kontron.de>
Date:   Mon, 3 May 2021 16:37:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
In-Reply-To: <20210429073050.21039-12-peng.fan@oss.nxp.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [109.250.134.29]
X-ClientProxiedBy: AM5PR0701CA0068.eurprd07.prod.outlook.com
 (2603:10a6:203:2::30) To AM0PR10MB2963.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:157::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.10.27] (109.250.134.29) by AM5PR0701CA0068.eurprd07.prod.outlook.com (2603:10a6:203:2::30) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.8 via Frontend Transport; Mon, 3 May 2021 14:38:00 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d3d00cfe-9485-416e-630b-08d90e410d7d
X-MS-TrafficTypeDiagnostic: AM0PR10MB1873:
X-Microsoft-Antispam-PRVS: <AM0PR10MB1873BC542A5F1EBA228B2B99E95B9@AM0PR10MB1873.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QFJLTYkuMpT5eIWUjo1mjEKYBgYY1uwWn2SC2BrGmCkoBl8Kml2vwEWMlsK1+IBhp8uBuew1GY0rlx4HUaNk286xTqyVbj7uTx+RSPuWim24XqYpOpQzT4UqXjraYo6h5fh+6kgN6VVNRryCEp/RKTR4EQb8jHNEnXaQBcDSoPpiB46OMR4VfxCOb73cBKFIrWyBItFCtzSArI7/MNA78MTBKOhOZzgh5xjN+Aso6Rq+d48NJF5N5gpCrBV38GdHIPOztEfShNDWu8RcLqP6f5JvD45XocowZf0rmf0yZrdUWR0mIIYqtOwQ5sHbkTjdZKVXpr1g9OZ9YrPmc65/aGBjoa9iXNh66dqdNgEFCAJgI4TshlUyZStRmXVAs0ioQeo4mI5xq+ZMZi7Cx4QAjN+Mkbj33LVl7wH4J37jkxbIXdqNyUlfH/nk3bCEjcJJvz2y+C2MzoSF/Bl7Tdc+IFpIS5QknqWiEa/fFIdWweqCY/4l8Usex/FyKhvRNmIZ0EpfbFI10tpTAFeAGpjxGaCugi/Q5ohEBvfHB30YsP5+nUhn7i9wognmFIE4flGzyWZhXPw4WxR7jjcTN2yW2iXpmgWUZiH/+MPJL8blD7+F56Hp6q4Xh0S7ssqyS+rBHguqdU39zFBRkIAiNEde3M2w8k2XeJu6pl8i1w7cu3O6wme7vitpgaajHRWo60ne
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR10MB2963.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(136003)(346002)(376002)(39850400004)(366004)(396003)(66476007)(66946007)(66556008)(8676002)(5660300002)(26005)(38100700002)(7416002)(478600001)(6486002)(36756003)(31686004)(2906002)(186003)(4326008)(2616005)(86362001)(44832011)(956004)(316002)(16576012)(8936002)(31696002)(16526019)(53546011)(83380400001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?ODBiVzlIUzlUbFg2NDlxSDQwK2dWMmRaMklSelNBQXZPN2Y0RFRXRDBVdThl?=
 =?utf-8?B?Ukk0bXptVWFncXBXQWk0SGdscVdBS0liWWRGZ2hpL243Yng4bVN5dDl6cjZD?=
 =?utf-8?B?UTNNRFJBSDhobzZOYXZyT1NxMk81cEVjREdGREl5SVhNRXV1N0xOd2xHNTh5?=
 =?utf-8?B?SkZVUWJRelYyenRScm4zYVRMc2JBU1FCUFphdG9pQUN5YVdjTGJCYlB6Snll?=
 =?utf-8?B?VUhnRVJxWXYwNmkrelNpbDh3N1NNVkVsckZkQmVnTzFpOExHMG80d2piWTd2?=
 =?utf-8?B?U1ZWUzR1N2U4WmRIUllLd1d3WmgwM0pwNzVJY1JLWFhmZFNBR2hwVVNxSVZU?=
 =?utf-8?B?eGQ5eWU3eUNyeDhnSHJaZkh3ZFdHZWxGNUdqVm04eGRjUDdJdzgyMG1uY0wy?=
 =?utf-8?B?K1lSMlFrV01HUGFWa0c2TzZnQUoreENwUCtwZFZtSkUzdUFMUUloVE5TVVdI?=
 =?utf-8?B?L25SUnM4eTAyRVNmZ0dsRGhrZkttS0taN0FtSnowZzRsZ1FyOWRiUmVydFdJ?=
 =?utf-8?B?eGp2NWQ4Ujd5ZTdWRERabHI3ZXZYU3BHaloxT29KbGsrQUE0NTI2Uk0zQU51?=
 =?utf-8?B?ekN5ZHRzUzlWNlRqRmRQbnZ5VXlUN1hub3BUaGZSR3BvSkJJajRvbWErd2ZD?=
 =?utf-8?B?bDBjRVJJNXNhbFRhMEh5T2dmaEpDeW10Uk9JRzZDV0FjL1QyUFFOc1NNQnNz?=
 =?utf-8?B?TXp6WWNMekNJdzY0VEVFcXh0M0dDMmtqOU96KzF6N3JySUtlVk1DVzBiZVU2?=
 =?utf-8?B?SlMzKzUvTmhtdmlEMmFqNWNBaENoYXh0NFdXakpYVjc4SEdVRWRVWUNsbmFs?=
 =?utf-8?B?QUhvMWcrRnVpMHorUitoM1VWeHJKSUpaVVNrbTI1dlEzeGZ0Y29UKzBuWElw?=
 =?utf-8?B?QWtXb2xGRWlVWVZCZGtFTHdHRXUxblpFUm52Rzl3KzNORWljM2lBSzM0Sk4y?=
 =?utf-8?B?Qk1mL0k0angzM2duNjF6NHhna1RvWElOVUtEazdqcWtTWkd1RVhpQmV6VExz?=
 =?utf-8?B?NkhpK25DUFgrb2RvekRtZFJZdmFWN1g3UW5wbVd3ZXFYbGdvcGRGYVFFVTEv?=
 =?utf-8?B?Mlc5Y2hGcjM0bVVYU09keUdiN05QYnJHUW54SElIMDJrK2lPNy80eVB0Q2Y1?=
 =?utf-8?B?em1TN0R4RVE1NzM3NFdJd202aUpubXZXVi9lVUdXam01eU1ZY2xaTzRhY0Z1?=
 =?utf-8?B?WWpHcWJ0Y3ZUQW8xTHozRmlkWW9MakZuMyt5Rk5UYndTV1ozZk8vZzBYak93?=
 =?utf-8?B?bnB2K3VqdXJNb21kTjB0cHppVlcvZU5PQXJIOFVhV1N3U09kcEF5WTVqYm1u?=
 =?utf-8?B?NzNZTmg1aFA5cmhPRm5QWjA3ZjgvNDJYS1JSRlIydGRiMWtqZUZ2QVZjeGV0?=
 =?utf-8?B?U0htdDdjZFJwNGJuM0tqL21hUUEveVZWNUVMRFJpYXhZRDVOS3k2eFRabElv?=
 =?utf-8?B?STU0TndoY0I1dEUzK3FUZFJwZWliTSs4U0h6RG4zQ2xCSTgrNS9PWithSWR2?=
 =?utf-8?B?UTlJbmJYZVpGcUU0eEhjSFRkYXdWbmpqekxrQVdHdlZ3MWlWaE9tZGRrdklI?=
 =?utf-8?B?NDhhcWEyZGUwTmJHc1orZlpSa09ReHFTd0U0QWFNZnAzbjM1c0lJYnZlSmJm?=
 =?utf-8?B?WXlvbSt5eFdpdHh5MFhDU1ZPa1I4WVdmK0hrS2dnNTF0LytnQmY2L3ZpOFNT?=
 =?utf-8?B?dlJLbjJPUGFLSzNLWlQrdzE4VnNiNlZWLzhmSXFveCtRSmp0NzJRNUo4VG1U?=
 =?utf-8?Q?t/2BbXuJqmCAtNHuqTluqKnTyOxs3CBJ1ARQS2M?=
X-OriginatorOrg: kontron.de
X-MS-Exchange-CrossTenant-Network-Message-Id: d3d00cfe-9485-416e-630b-08d90e410d7d
X-MS-Exchange-CrossTenant-AuthSource: AM0PR10MB2963.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2021 14:38:01.3359
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8c9d3c97-3fd9-41c8-a2b1-646f3942daf1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PFZRGDZceDGOeTjSEsi5fDtEwH1IB6QUu4JXk/RMsvTnnlAXDpu2u7bL6A9i2wGEYx95eRyTvLD1QAwEPlNGNvQi3Rod7lUnejlTdKda3VY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR10MB1873
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29.04.21 09:30, Peng Fan (OSS) wrote:
> From: Lucas Stach <l.stach@pengutronix.de>
> 
> This adds support for the power domains founds on i.MX8MM. The 2D and 3D

s/founds/found/

> GPU domains are abstracted as a single domain in the driver, as they can't
> be powered up/down individually due to a shared reset.
> 
> Signed-off-by: Lucas Stach <l.stach@pengutronix.de>

Reviewed-by: Frieder Schrempf <frieder.schrempf@kontron.de>

> ---
>   drivers/soc/imx/gpcv2.c | 168 ++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 168 insertions(+)
> 
> diff --git a/drivers/soc/imx/gpcv2.c b/drivers/soc/imx/gpcv2.c
> index 4a2c2a255d1a..5642dd236c10 100644
> --- a/drivers/soc/imx/gpcv2.c
> +++ b/drivers/soc/imx/gpcv2.c
> @@ -19,6 +19,7 @@
>   #include <linux/sizes.h>
>   #include <dt-bindings/power/imx7-power.h>
>   #include <dt-bindings/power/imx8mq-power.h>
> +#include <dt-bindings/power/imx8mm-power.h>
>   
>   #define GPC_LPCR_A_CORE_BSC			0x000
>   
> @@ -44,6 +45,19 @@
>   #define IMX8M_PCIE1_A53_DOMAIN			BIT(3)
>   #define IMX8M_MIPI_A53_DOMAIN			BIT(2)
>   
> +#define IMX8MM_VPUH1_A53_DOMAIN			BIT(15)
> +#define IMX8MM_VPUG2_A53_DOMAIN			BIT(14)
> +#define IMX8MM_VPUG1_A53_DOMAIN			BIT(13)
> +#define IMX8MM_DISPMIX_A53_DOMAIN		BIT(12)
> +#define IMX8MM_VPUMIX_A53_DOMAIN		BIT(10)
> +#define IMX8MM_GPUMIX_A53_DOMAIN		BIT(9)
> +#define IMX8MM_GPU_A53_DOMAIN			(BIT(8) | BIT(11))
> +#define IMX8MM_DDR1_A53_DOMAIN			BIT(7)
> +#define IMX8MM_OTG2_A53_DOMAIN			BIT(5)
> +#define IMX8MM_OTG1_A53_DOMAIN			BIT(4)
> +#define IMX8MM_PCIE_A53_DOMAIN			BIT(3)
> +#define IMX8MM_MIPI_A53_DOMAIN			BIT(2)
> +
>   #define GPC_PU_PGC_SW_PUP_REQ		0x0f8
>   #define GPC_PU_PGC_SW_PDN_REQ		0x104
>   
> @@ -67,6 +81,19 @@
>   #define IMX8M_PCIE1_SW_Pxx_REQ			BIT(1)
>   #define IMX8M_MIPI_SW_Pxx_REQ			BIT(0)
>   
> +#define IMX8MM_VPUH1_SW_Pxx_REQ			BIT(13)
> +#define IMX8MM_VPUG2_SW_Pxx_REQ			BIT(12)
> +#define IMX8MM_VPUG1_SW_Pxx_REQ			BIT(11)
> +#define IMX8MM_DISPMIX_SW_Pxx_REQ		BIT(10)
> +#define IMX8MM_VPUMIX_SW_Pxx_REQ		BIT(8)
> +#define IMX8MM_GPUMIX_SW_Pxx_REQ		BIT(7)
> +#define IMX8MM_GPU_SW_Pxx_REQ			(BIT(6) | BIT(9))
> +#define IMX8MM_DDR1_SW_Pxx_REQ			BIT(5)
> +#define IMX8MM_OTG2_SW_Pxx_REQ			BIT(3)
> +#define IMX8MM_OTG1_SW_Pxx_REQ			BIT(2)
> +#define IMX8MM_PCIE_SW_Pxx_REQ			BIT(1)
> +#define IMX8MM_MIPI_SW_Pxx_REQ			BIT(0)
> +
>   #define GPC_M4_PU_PDN_FLG		0x1bc
>   
>   #define GPC_PU_PWRHSK			0x1fc
> @@ -78,6 +105,17 @@
>   #define IMX8M_VPU_HSK_PWRDNREQN			BIT(5)
>   #define IMX8M_DISP_HSK_PWRDNREQN		BIT(4)
>   
> +
> +#define IMX8MM_GPUMIX_HSK_PWRDNACKN		BIT(29)
> +#define IMX8MM_GPU_HSK_PWRDNACKN		(BIT(27) | BIT(28))
> +#define IMX8MM_VPUMIX_HSK_PWRDNACKN		BIT(26)
> +#define IMX8MM_DISPMIX_HSK_PWRDNACKN		BIT(25)
> +#define IMX8MM_HSIO_HSK_PWRDNACKN		(BIT(23) | BIT(24))
> +#define IMX8MM_GPUMIX_HSK_PWRDNREQN		BIT(11)
> +#define IMX8MM_GPU_HSK_PWRDNREQN		(BIT(9) | BIT(10))
> +#define IMX8MM_VPUMIX_HSK_PWRDNREQN		BIT(8)
> +#define IMX8MM_DISPMIX_HSK_PWRDNREQN		BIT(7)
> +#define IMX8MM_HSIO_HSK_PWRDNREQN		(BIT(5) | BIT(6))
>   /*
>    * The PGC offset values in Reference Manual
>    * (Rev. 1, 01/2018 and the older ones) GPC chapter's
> @@ -100,6 +138,20 @@
>   #define IMX8M_PGC_MIPI_CSI2		28
>   #define IMX8M_PGC_PCIE2			29
>   
> +#define IMX8MM_PGC_MIPI			16
> +#define IMX8MM_PGC_PCIE			17
> +#define IMX8MM_PGC_OTG1			18
> +#define IMX8MM_PGC_OTG2			19
> +#define IMX8MM_PGC_DDR1			21
> +#define IMX8MM_PGC_GPU2D		22
> +#define IMX8MM_PGC_GPUMIX		23
> +#define IMX8MM_PGC_VPUMIX		24
> +#define IMX8MM_PGC_GPU3D		25
> +#define IMX8MM_PGC_DISPMIX		26
> +#define IMX8MM_PGC_VPUG1		27
> +#define IMX8MM_PGC_VPUG2		28
> +#define IMX8MM_PGC_VPUH1		29
> +
>   #define GPC_PGC_CTRL(n)			(0x800 + (n) * 0x40)
>   #define GPC_PGC_SR(n)			(GPC_PGC_CTRL(n) + 0xc)
>   
> @@ -523,6 +575,121 @@ static const struct imx_pgc_domain_data imx8m_pgc_domain_data = {
>   	.reg_access_table = &imx8m_access_table,
>   };
>   
> +static const struct imx_pgc_domain imx8mm_pgc_domains[] = {
> +	[IMX8MM_POWER_DOMAIN_HSIOMIX] = {
> +		.genpd = {
> +			.name = "hsiomix",
> +		},
> +		.bits  = {
> +			.pxx = 0, /* no power sequence control */
> +			.map = 0, /* no power sequence control */
> +			.hskreq = IMX8MM_HSIO_HSK_PWRDNREQN,
> +			.hskack = IMX8MM_HSIO_HSK_PWRDNACKN,
> +		},
> +	},
> +
> +	[IMX8MM_POWER_DOMAIN_PCIE] = {
> +		.genpd = {
> +			.name = "pcie",
> +		},
> +		.bits  = {
> +			.pxx = IMX8MM_PCIE_SW_Pxx_REQ,
> +			.map = IMX8MM_PCIE_A53_DOMAIN,
> +		},
> +		.pgc   = IMX8MM_PGC_PCIE,
> +	},
> +
> +	[IMX8MM_POWER_DOMAIN_OTG1] = {
> +		.genpd = {
> +			.name = "usb-otg1",
> +		},
> +		.bits  = {
> +			.pxx = IMX8MM_OTG1_SW_Pxx_REQ,
> +			.map = IMX8MM_OTG1_A53_DOMAIN,
> +		},
> +		.pgc   = IMX8MM_PGC_OTG1,
> +	},
> +
> +	[IMX8MM_POWER_DOMAIN_OTG2] = {
> +		.genpd = {
> +			.name = "usb-otg2",
> +		},
> +		.bits  = {
> +			.pxx = IMX8MM_OTG2_SW_Pxx_REQ,
> +			.map = IMX8MM_OTG2_A53_DOMAIN,
> +		},
> +		.pgc   = IMX8MM_PGC_OTG2,
> +	},
> +
> +	[IMX8MM_POWER_DOMAIN_GPUMIX] = {
> +		.genpd = {
> +			.name = "gpumix",
> +		},
> +		.bits  = {
> +			.pxx = IMX8MM_GPUMIX_SW_Pxx_REQ,
> +			.map = IMX8MM_GPUMIX_A53_DOMAIN,
> +			.hskreq = IMX8MM_GPUMIX_HSK_PWRDNREQN,
> +			.hskack = IMX8MM_GPUMIX_HSK_PWRDNACKN,
> +		},
> +		.pgc   = IMX8MM_PGC_GPUMIX,
> +	},
> +
> +	[IMX8MM_POWER_DOMAIN_GPU] = {
> +		.genpd = {
> +			.name = "gpu",
> +		},
> +		.bits  = {
> +			.pxx = IMX8MM_GPU_SW_Pxx_REQ,
> +			.map = IMX8MM_GPU_A53_DOMAIN,
> +			.hskreq = IMX8MM_GPU_HSK_PWRDNREQN,
> +			.hskack = IMX8MM_GPU_HSK_PWRDNACKN,
> +		},
> +		.pgc   = IMX8MM_PGC_GPU2D,
> +	},
> +};
> +
> +static const struct regmap_range imx8mm_yes_ranges[] = {
> +		regmap_reg_range(GPC_LPCR_A_CORE_BSC,
> +				 GPC_PU_PWRHSK),
> +		regmap_reg_range(GPC_PGC_CTRL(IMX8MM_PGC_MIPI),
> +				 GPC_PGC_SR(IMX8MM_PGC_MIPI)),
> +		regmap_reg_range(GPC_PGC_CTRL(IMX8MM_PGC_PCIE),
> +				 GPC_PGC_SR(IMX8MM_PGC_PCIE)),
> +		regmap_reg_range(GPC_PGC_CTRL(IMX8MM_PGC_OTG1),
> +				 GPC_PGC_SR(IMX8MM_PGC_OTG1)),
> +		regmap_reg_range(GPC_PGC_CTRL(IMX8MM_PGC_OTG2),
> +				 GPC_PGC_SR(IMX8MM_PGC_OTG2)),
> +		regmap_reg_range(GPC_PGC_CTRL(IMX8MM_PGC_DDR1),
> +				 GPC_PGC_SR(IMX8MM_PGC_DDR1)),
> +		regmap_reg_range(GPC_PGC_CTRL(IMX8MM_PGC_GPU2D),
> +				 GPC_PGC_SR(IMX8MM_PGC_GPU2D)),
> +		regmap_reg_range(GPC_PGC_CTRL(IMX8MM_PGC_GPUMIX),
> +				 GPC_PGC_SR(IMX8MM_PGC_GPUMIX)),
> +		regmap_reg_range(GPC_PGC_CTRL(IMX8MM_PGC_VPUMIX),
> +				 GPC_PGC_SR(IMX8MM_PGC_VPUMIX)),
> +		regmap_reg_range(GPC_PGC_CTRL(IMX8MM_PGC_GPU3D),
> +				 GPC_PGC_SR(IMX8MM_PGC_GPU3D)),
> +		regmap_reg_range(GPC_PGC_CTRL(IMX8MM_PGC_DISPMIX),
> +				 GPC_PGC_SR(IMX8MM_PGC_DISPMIX)),
> +		regmap_reg_range(GPC_PGC_CTRL(IMX8MM_PGC_VPUG1),
> +				 GPC_PGC_SR(IMX8MM_PGC_VPUG1)),
> +		regmap_reg_range(GPC_PGC_CTRL(IMX8MM_PGC_VPUG2),
> +				 GPC_PGC_SR(IMX8MM_PGC_VPUG2)),
> +		regmap_reg_range(GPC_PGC_CTRL(IMX8MM_PGC_VPUH1),
> +				 GPC_PGC_SR(IMX8MM_PGC_VPUH1)),
> +};
> +
> +static const struct regmap_access_table imx8mm_access_table = {
> +	.yes_ranges	= imx8mm_yes_ranges,
> +	.n_yes_ranges	= ARRAY_SIZE(imx8mm_yes_ranges),
> +};
> +
> +static const struct imx_pgc_domain_data imx8mm_pgc_domain_data = {
> +	.domains = imx8mm_pgc_domains,
> +	.domains_num = ARRAY_SIZE(imx8mm_pgc_domains),
> +	.reg_access_table = &imx8mm_access_table,
> +};
> +
>   static int imx_pgc_domain_probe(struct platform_device *pdev)
>   {
>   	struct imx_pgc_domain *domain = pdev->dev.platform_data;
> @@ -707,6 +874,7 @@ static int imx_gpcv2_probe(struct platform_device *pdev)
>   
>   static const struct of_device_id imx_gpcv2_dt_ids[] = {
>   	{ .compatible = "fsl,imx7d-gpc", .data = &imx7_pgc_domain_data, },
> +	{ .compatible = "fsl,imx8mm-gpc", .data = &imx8mm_pgc_domain_data, },
>   	{ .compatible = "fsl,imx8mq-gpc", .data = &imx8m_pgc_domain_data, },
>   	{ }
>   };
> 
