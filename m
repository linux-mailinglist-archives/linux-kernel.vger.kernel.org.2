Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D68993187F7
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Feb 2021 11:20:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229938AbhBKKTp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Feb 2021 05:19:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229628AbhBKKSD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Feb 2021 05:18:03 -0500
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on0709.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe0d::709])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 571ADC061574;
        Thu, 11 Feb 2021 02:17:17 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TboWdKa16Eplk6u+3982XNzbYvjF5pntEvt3MZZ6u9kUnhYyDAgWUz0cjLGWuMVKHDPq7fSbLps6/OUVwmN7I5KiPGAuFm8wUBjaS5b0MowpWVHM7exkr1kMY/asoFwFUr7J7uOLrxiolfLn9W8kOYHMfzRGg/QPIuvSL4YvtYYh8hsmdFbN6GaKjRpdWO+3TMU2hle+dS/5FnFbGedtnqIZahyFFsd1b3ftgnuNC6iwjLXuCqm1Qu6cWjr6fbuMtN3NMlu+/NJutKOm8vXaNFT7d49DC855yKcPtYLf052le5bN14tq+7PYf/nHR0PF+OAkV/hvUdf+nvqHozGeng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g1aPLsbaZUi871oTOu3PeqWR71NS+qyIG+Cjp+Mn/EU=;
 b=NNSk5lFCCgnJAGFa3Wt6kGsPQsfZsYWCn3xj1Bh53GPtvfg18zHOe1vgnnSVoE8FZ6ZPkzja8MVNgAERe7xmNnyKrhm5Yh1jcBWIEHQ7gGu8O6ZFtf1Ow5JLdwFzqp+pMMqAwUc4VQG10lgLMmW3itM8dAUpCJV429qxfcGSuZWwlNQn2K4hdAe4c3epPRgnXarYz76ZCqu8MeHkEH1r5sVIo1tfH/v7VvgL0BUMAbbHdIaJp0go3HxXEad0qj0St0f6n3t3iAAtRr45BJNbfR0vxYBzyK/PK8IMk6wYOq/KDE5Snwcnup4vuqm278/INpcXEd9/IK9i44a+ekb0wA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kontron.de; dmarc=pass action=none header.from=kontron.de;
 dkim=pass header.d=kontron.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mysnt.onmicrosoft.com;
 s=selector2-mysnt-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g1aPLsbaZUi871oTOu3PeqWR71NS+qyIG+Cjp+Mn/EU=;
 b=lfoHDAtyQBntgm51ygXpnZpZdT7vCUIXcyuI+MYgItG0IVAUpZAsk54eXqqIpJDk5C3oZZks5rFbJ07yhceegjcMXYtRSZ0b537h3CU7diE93AGWsNd3ZcPc80d+1hrePWfkq9rksQYfR7KJ2toIOsrjmW9um4km92PI7kq+dZM=
Authentication-Results: denx.de; dkim=none (message not signed)
 header.d=none;denx.de; dmarc=none action=none header.from=kontron.de;
Received: from AM0PR10MB2963.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:157::14)
 by AM8PR10MB4083.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1e8::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.26; Thu, 11 Feb
 2021 10:17:15 +0000
Received: from AM0PR10MB2963.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::bc4f:2b48:88cd:f90f]) by AM0PR10MB2963.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::bc4f:2b48:88cd:f90f%7]) with mapi id 15.20.3825.030; Thu, 11 Feb 2021
 10:17:15 +0000
Subject: Re: [PATCH] pinctrl: imx: imx8mm: fix pad offset of SD1_DATA0 pin
To:     Claudius Heine <ch@denx.de>, Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
Cc:     Marek Vasut <marex@denx.de>
References: <20210211095413.1043102-1-ch@denx.de>
From:   Frieder Schrempf <frieder.schrempf@kontron.de>
Message-ID: <03ac353d-e7a1-5235-a787-21014d0c7607@kontron.de>
Date:   Thu, 11 Feb 2021 11:17:13 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20210211095413.1043102-1-ch@denx.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [109.250.136.36]
X-ClientProxiedBy: AM0PR03CA0025.eurprd03.prod.outlook.com
 (2603:10a6:208:14::38) To AM0PR10MB2963.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:157::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.10.27] (109.250.136.36) by AM0PR03CA0025.eurprd03.prod.outlook.com (2603:10a6:208:14::38) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.25 via Frontend Transport; Thu, 11 Feb 2021 10:17:14 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: af5e7023-01da-4b35-8077-08d8ce76340f
X-MS-TrafficTypeDiagnostic: AM8PR10MB4083:
X-Microsoft-Antispam-PRVS: <AM8PR10MB4083284DFE2EB23F1214C8F2E98C9@AM8PR10MB4083.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ycZwcHqIGm1GpZcjlQyCqeHdVZIDwkKVhs4nlZ3YGHhVB+A+gmeWLDJmXTEymX5IpKhXSOyvsxRP5obAkQ84VYXqc+CgV6ORIXEqJ7fNywUK0l6fpH6/+2BbcVQGdW/aonnGBRUssfor6E0L+mN4uKxD4VOOECwLPaHZEa3C/KNxIO1dA78UyyjHmN2yjlyEIdEeRv4cZ7NefVwe1VGtr9YiEBaM4CSNYWN4xbFT1nLwFMdXzdrx/SuWd1rR+tDujsHA0SRUDHs6/vsGP9FEknxAOahP5SkdZA+VNzUHhTM8XGOnJZL41Q3DIqaz/o3IesvS2qvFBjf0VNHvffxxRnrvU3nhys/qP1B2LPGD52KIEyj/rc6i1ROLBjeVF/1+n2XFRp+ipguHlm9fDhpOjDjcQFEZR05cVQwzAmwO/cx1157BFJbO6IW4I1+ydRGi+FibZxysGcGCTSfumsVI0nvrX8Rx2m+yVNvl4D6BjzlPQYy/P+MQ3lXeDqlyHk9qN0nM6sp8nJamOHybwHYAKcANb4/KZr8XI1q6Z1SS9yHEUfF8stY8Jwk8VddXwx/K79xfQoOuTeAvk77ZxyOPF4/ixP1lQJT1w+VIQU1El+hSJTybr5kWEtVKvkkCsooR/Cmzpau2nar4z5MY4D/+BQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR10MB2963.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(376002)(39860400002)(136003)(396003)(346002)(366004)(86362001)(31696002)(2906002)(8936002)(31686004)(316002)(66556008)(110136005)(4326008)(7416002)(83380400001)(52116002)(36756003)(921005)(16526019)(44832011)(186003)(478600001)(5660300002)(8676002)(66476007)(66946007)(956004)(16576012)(2616005)(26005)(53546011)(6486002)(32563001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?VFVCNlRLTHgzQzZpOTRwZ2tmdFkxZVMxTVhteW9hYndkRnZDaHdDQy9LYVlN?=
 =?utf-8?B?cmxGODAwUHZzOW1YNG0weXN2d1VkZFdhOUJQbloxMlNEd1UzY1dHTmNpTlBm?=
 =?utf-8?B?THpHU2oyeEdBV1RwbTJVMnE2NlBFbWRJV2pXZUxqWFpQWXBnbmZ2T2c5WXZS?=
 =?utf-8?B?amVqS09WajMwMnUyR1daL255RURtdUZmUWRwcmdCcUhXMVpuM3JPYWdsdktk?=
 =?utf-8?B?bFhCZFV2UVJUWEdpYzZIL3ZkUTBPd2JhdmxOYWpaU20wejNTbTFmM0o5emdh?=
 =?utf-8?B?QXlyTVBIVmJkNVRhUXJ2VG11UkdDTFByZU8vVjhUSnRGS2tZUkl2MFB3WXMw?=
 =?utf-8?B?V0JQUFlkOWxtUUkraWxGRllkREw0bTdCdS8rOGxNcUEwNDF5WUZNNGxYdDlt?=
 =?utf-8?B?ck9KUTgyQXg2TWhsd0dDTUlYd3c3bUx5dkZTTzY0ZDh3Y2ozRTFYcDZ1N3Jm?=
 =?utf-8?B?aHd4S292UGVqeGlSRk9qZ1RxVFljdlJndXE5WE1oYlNqUGtHRVRVQU9oc3hS?=
 =?utf-8?B?NmRKNzJQLzgwQTk5VDd6OVpJNDV6QmZpTHBYR2xDbHUwbmxIRUFJeW95VDg1?=
 =?utf-8?B?VWZhV0JMeDE0RlFlaFNNcVdlYTNyUVg0a3RocFVVMkh4NlVIVXRBeThQU1Vk?=
 =?utf-8?B?ZnNpNmxXZmtuWUFjZXdBNG9LTWg3cXhqaml5RWdzV0l4cE9Eclc1OEl0S2kz?=
 =?utf-8?B?QXphR1RrNUJEdjNmblllVUZiSDhlMnJXQzA2bkxCMlhibjFQVWZ1ZUFicmRw?=
 =?utf-8?B?MFhnekowc2t2NjJGYk9sbVpIcTRDTm5QRlpZWFFQVTIzUXVqUDNDM1lnY3Bv?=
 =?utf-8?B?SXJCaVJRNWtQUStBcjNlYnBRenBPbi81enc5b0tjd25BT0Q1dENzTy9KVXZI?=
 =?utf-8?B?Z05HeWpXejFkcklucGFtYTJUNGcwWXRuRDd5ekNNRTdDYkRMTzVNMmg0NUZ5?=
 =?utf-8?B?cHVKL2E5QnBFY1dPNkRyeGd3eG9XRXhMS1ozWjFJeDVBZjgyVGg0SjdYcTdX?=
 =?utf-8?B?SEtzM01YdHFBNDVySnBBSlJwMGZtN3E0RkdwSnZhbDBBWXYzWmUvcE9GR2hX?=
 =?utf-8?B?eXVCK0doRVVjYkJBUzloZ2cyZTliak9XbjBGM0wwWUVJTVo2SE12TXp3bTRs?=
 =?utf-8?B?TEhicFh5dHFmMFFBWUxQelhITmNIb0RDYTA2KzRJLzJPcXIxM3VOeGM1d3FB?=
 =?utf-8?B?b2ZvN21SaktaaTNzZ0c5OHBUNDVFMmkwSnU2QUppZmFFQ2VNZnFYWkFzUWRM?=
 =?utf-8?B?M0NkNnprZUZ3cVZpa3djZ3lZd01iUFVJVmN0VEtCbXpaK2Y4K25qNmxTMlpp?=
 =?utf-8?B?MW1RUFBWdWhCRDNJZE1FYitodmt5aXZhaHFFMHdYRFBrQU40cmlza2Y5NEJ3?=
 =?utf-8?B?dk4xeXZyWUhMSWQ4NHczRGFFWDhvRlBJYnVaTGp0L1dqaCsybW1JMmMvSWFV?=
 =?utf-8?B?UkFZME1LVEdLd2hIRjg0eVdQNU9Zcmx1TzFLU3hRL292aGw4b204R0hZQmQ1?=
 =?utf-8?B?TS8wODN1WFVOSTZnTDVRRThiYmIzVXU2VVRLWWtyR05RMHErTitWbTNLS3B4?=
 =?utf-8?B?c3VHNE9Pd0ZSOFY4KzFKZzl3UmVwUUZzbEdLYXIwNFZETGZ6aVN1TU9BM21l?=
 =?utf-8?B?TFVZZGdnRHVLeHBxRHRMamdvQklhaDF2SEpZMmNDblM0bS85MGNDS045aUYy?=
 =?utf-8?B?SmNOWWxmc1lIMlV1TXhIb0tmcVJkRVhja0d1cXExQjU4MWFyRmkwSjh3MTd4?=
 =?utf-8?Q?jWe9UDlUXAVbcQ2S6FckGSwc+VeYOP7SYvOhS/8?=
X-OriginatorOrg: kontron.de
X-MS-Exchange-CrossTenant-Network-Message-Id: af5e7023-01da-4b35-8077-08d8ce76340f
X-MS-Exchange-CrossTenant-AuthSource: AM0PR10MB2963.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2021 10:17:15.0807
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8c9d3c97-3fd9-41c8-a2b1-646f3942daf1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AT1n+qPcR79lJ7QbTyPaY8GTZg5C4pBu6Iw7lC5fv/3dJkep9eDpP/RlG/hLnQABf7EEjyQRQ5HNCuM3wSRLtSvBEDrXp28MlwbjjOKOZd4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR10MB4083
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11.02.21 10:54, Claudius Heine wrote:
> There is a 0 missing in the pad register offset. This patch adds it.
> 
> Signed-off-by: Claudius Heine <ch@denx.de>

I think this should rather be prefixed by "arm64: dts: imx8mm:" as this 
is no change in the pinctrl driver, but only in the devicetree.

And I guess this deserves a "Fixes" and "Cc: stable" tag, so:

Fixes: c1c9d41319c3 ("dt-bindings: imx: Add pinctrl binding doc for imx8mm")
Cc: stable@vger.kernel.org
Reviewed-by: Frieder Schrempf <frieder.schrempf@kontron.de>

> ---
>   arch/arm64/boot/dts/freescale/imx8mm-pinfunc.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/freescale/imx8mm-pinfunc.h b/arch/arm64/boot/dts/freescale/imx8mm-pinfunc.h
> index 5ccc4cc91959d..a003e6af33533 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mm-pinfunc.h
> +++ b/arch/arm64/boot/dts/freescale/imx8mm-pinfunc.h
> @@ -124,7 +124,7 @@
>   #define MX8MM_IOMUXC_SD1_CMD_USDHC1_CMD                                     0x0A4 0x30C 0x000 0x0 0x0
>   #define MX8MM_IOMUXC_SD1_CMD_GPIO2_IO1                                      0x0A4 0x30C 0x000 0x5 0x0
>   #define MX8MM_IOMUXC_SD1_DATA0_USDHC1_DATA0                                 0x0A8 0x310 0x000 0x0 0x0
> -#define MX8MM_IOMUXC_SD1_DATA0_GPIO2_IO2                                    0x0A8 0x31  0x000 0x5 0x0
> +#define MX8MM_IOMUXC_SD1_DATA0_GPIO2_IO2                                    0x0A8 0x310 0x000 0x5 0x0
>   #define MX8MM_IOMUXC_SD1_DATA1_USDHC1_DATA1                                 0x0AC 0x314 0x000 0x0 0x0
>   #define MX8MM_IOMUXC_SD1_DATA1_GPIO2_IO3                                    0x0AC 0x314 0x000 0x5 0x0
>   #define MX8MM_IOMUXC_SD1_DATA2_USDHC1_DATA2                                 0x0B0 0x318 0x000 0x0 0x0
> 
