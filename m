Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CA393519FE
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Apr 2021 20:04:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235771AbhDAR5e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Apr 2021 13:57:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235055AbhDARmJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Apr 2021 13:42:09 -0400
Received: from EUR02-HE1-obe.outbound.protection.outlook.com (mail-he1eur02on062a.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe05::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9863C05BD2F;
        Thu,  1 Apr 2021 06:02:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TBet6B8oWMV3SzfO/28o6dh+GYNTBrBPKV6QdGVKxnsj7DDS2Wq+Zj0xbfPvqp1rxlSGwfdbRbm5hDJYiZWCsBYehgdK0iVt4mJ/DAYVJY+oezMgnEyq2YbZlljHOXOqFFW38xorpf3Px7wKgQbw810ZgtOv8GgLsQpxPq7Mm2msvXS9zLEmqziZKkOOG5tFocOPGqJ701DbIctlPvExKxZPjqV4pLktinIrxJ2l0d1xEiwxO3lP7epPReZtVqny0x5VGkbiAuO1EbuAn6HN0A0lCMdJU9tqA5uwx/d/cx8pfMPr/I8klZk9YAwevTDekeltsm0m85MpyucsTRS7BQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oM8pup9HZnersTNG4Zf7j5pD01vFQUAtb7lX2uqFDoY=;
 b=i5DylKz9di48kqQNYSSCUlImUQ4JzEvX8+mG6AHegz7FEHKDbP+1LgFacC1kGme/Y/Yb4yknVYUamSz6pxsnf4Av09NZR7F9Yu8YJZopr6KXL4CnH0ackTJhm7zRXw7B5QO1az81XzkeOgRw5bQJSNvIdB3KJraN/b0cFWQfwSoi9lv4PqSyuPxIvfdQbD7X3i0U8EfVqIPudejPFNxfTJu+iHmsx2hP9IyyuHH/YmpLKUokm0gQwBPoM154S1lypZQ2sYdJYFy0aPVs7N4P0UFAlzKXRBlwc/uEJUvtnmqCn/APGbe0JhLRi2ctGF46hrBKYQ61Vxn25Nx6Doz4BQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oM8pup9HZnersTNG4Zf7j5pD01vFQUAtb7lX2uqFDoY=;
 b=oq9F5fOOWVjxo9ljcU2bEVa4onNEj2f0TPMwN2/Fr6YrRfQHOcW4xNmIIeFZZbZmwg0xOjWdk9Y3ALV1hcvkvNbVYiLyWDgMnPgBhltBvp+LixVebAy7nou3hNNaKcCwh5/TCjwdlhFhrZ2pkqdrp6nr1+a33sHBepaD5yTN1yk=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=nxp.com;
Received: from VI1PR0402MB3405.eurprd04.prod.outlook.com (2603:10a6:803:3::26)
 by VI1PR04MB4238.eurprd04.prod.outlook.com (2603:10a6:803:4e::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.28; Thu, 1 Apr
 2021 12:32:51 +0000
Received: from VI1PR0402MB3405.eurprd04.prod.outlook.com
 ([fe80::d68:ed11:c239:892b]) by VI1PR0402MB3405.eurprd04.prod.outlook.com
 ([fe80::d68:ed11:c239:892b%7]) with mapi id 15.20.3999.027; Thu, 1 Apr 2021
 12:32:51 +0000
Subject: Re: [PATCH 04/32] MAINTAINERS: update fsl,dpaa2-console.yaml
 reference
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Ionut-robert Aron <ionut-robert.aron@nxp.com>,
        Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org
References: <cover.1617279355.git.mchehab+huawei@kernel.org>
 <188e930100ecb7d4bd476681f3cc29fa536bdcde.1617279355.git.mchehab+huawei@kernel.org>
From:   Laurentiu Tudor <laurentiu.tudor@nxp.com>
Message-ID: <a0bf8d46-3079-6246-647f-f92accbd3402@nxp.com>
Date:   Thu, 1 Apr 2021 15:32:48 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
In-Reply-To: <188e930100ecb7d4bd476681f3cc29fa536bdcde.1617279355.git.mchehab+huawei@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [78.96.81.175]
X-ClientProxiedBy: AM0PR10CA0062.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:15::15) To VI1PR0402MB3405.eurprd04.prod.outlook.com
 (2603:10a6:803:3::26)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.0.27] (78.96.81.175) by AM0PR10CA0062.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:15::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.26 via Frontend Transport; Thu, 1 Apr 2021 12:32:50 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 58bb9e97-93b7-4b7f-387f-08d8f50a4417
X-MS-TrafficTypeDiagnostic: VI1PR04MB4238:
X-Microsoft-Antispam-PRVS: <VI1PR04MB42388F6A7E3B0475CBBA29C3EC7B9@VI1PR04MB4238.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:497;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GhuaI7gG8vrlAerSvtNk6M8ErXg2L93ns4UWOsKlt2JVyTJZ1WJ7Y5eN3bUob2huGl3IepXLcVemGY9yGX+4N1sWc2xhkmWq2WrJFBi/IyL4fOnVbeGzh60OOFjs18n5EF341taH+buV6tum8zaqa+GALf1ngZv89WVuoxvmRDpMhpRocVxEYN9Ka/b2tnLdNSW4kBjfjvGDeEmnJskrBSur7+xKEIULRf5R11fNR2nv/HfWDvfJPYeLjYj4btABk4Di2DFJDp6Nrdu92ayHE6lmnDeBX7Z5ogN39GUgCk5uTgej+BSo8ZBt29C+ogkP2PWxdO3cjmf6xe2Le/f1OMRlJR88bs4r1eXY+3/Q5gTCFR4mDdE0hGorDjsO1IcKsv+LcxUa10t9pxHuV7AflUygrNsLnjJX3c7oLImYd5A1UrItpZO88zPDmcj0AF+H62nuBfuqoW4pNKuvsVHUoeyAVHmoggagYffMAwqD0k9w0U7pwRh2xsxJf8z3xeTEU8jjdPWwd/tskc1NExFyxrBB170x+YFzveo4kzuIqHyql3u+3wwQFHI2ryyeT6pybp6MaKfkth4w8upUGW9KXf9DQYKgEYqIwnT2/E1IuICJYcBdixfpzAFnHzGbJ7KUpqnjxiAAUq0VaZgjiGovmtI95xT6eZxN7QiGYsyHvbqmYPubIEoEoC1OWnUiVZT/MYVFSxRwJ6j+FV8bNsDNfQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0402MB3405.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(366004)(376002)(346002)(396003)(39850400004)(86362001)(110136005)(16576012)(54906003)(6486002)(66946007)(52116002)(66476007)(36756003)(31696002)(66556008)(26005)(8936002)(44832011)(15650500001)(186003)(478600001)(5660300002)(8676002)(53546011)(956004)(2616005)(4326008)(38100700001)(83380400001)(16526019)(2906002)(31686004)(316002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?c21Jd3c3eWIvZnk5U1IzdThsazZIUEpnc3RyQVJQNHN6WjRVUnQ1bmZlWDNC?=
 =?utf-8?B?L29DamU0ZFQ4b2dlbFdINWN5dkZpTEJ3UmlFNHczdWpCZjY1T2F2Vm5NUTBI?=
 =?utf-8?B?Z2xSeFlYbEtkM05yWlBtUVcwTGc2ZnJOZE4xVFE2L2ZQUFZ4SnkzM2F4Y3hZ?=
 =?utf-8?B?VXQ5RXRuS0VvdHlmNU1XNEgzQ2pDb1dGbzNtWnBBY05VNksyWWhCejk3TmNY?=
 =?utf-8?B?STdWTzZNRldOTHBVSjJXMGN4SUVoSEFOV3RNclFYeWRaK1NJdkthR2duSlNs?=
 =?utf-8?B?SW5TQ3JYL0U3WTl1VHBqNW5uU3VCYi9SSGFoVXNxRzBJZ1RiVEJCUWtUNmxG?=
 =?utf-8?B?cWR4NzN4RXlGMzlPRENWNXc0ZEZOZEdiUnY5RUJMbkh4Mnc2ZFo5aExmaTQx?=
 =?utf-8?B?SDRQR3crMzd0YVl2ZEVnYVVwZGNJVmhMWlg2OVlvUnF4aUphVWdVTUtNMFNL?=
 =?utf-8?B?di9uc040aW1BYXFyQzV2TCt0a29Ib3A1WDlvS3Z1U01SZDdpcm9ac0ttZGJ4?=
 =?utf-8?B?a1VwZ2s2bCt0WVpwWFRyYlV1R3RxNWRPQVJuUDhqRTFVQS9iSXVFbzMySklt?=
 =?utf-8?B?cm50NVV4R0ZtTWxnRk10YllqTGxGUFlXZ3RvL0tDSTZRZnZ0VkdWUkhIczRE?=
 =?utf-8?B?WkE4cTlUMU8wS21TS0dZNDROMitlQU92UG9BZFN3R2hyQmhQb3dtOXE1THA2?=
 =?utf-8?B?YlU3S3cvVFIyVDFsUVZYNVhZME9GTklQQzZsNkgxVDNXdTBvOW5XdU5CUG05?=
 =?utf-8?B?ZjAzb2FMNG5PcHR4ZEpNcHJxT1hIMnFWTjFRQURPV0w1WkFBVnQwMjlQdk5E?=
 =?utf-8?B?N3V0clYrdE5zMW4vVlhaaWlpK00wU3VEZTM4MVg2WU5RQXVNRTFmUWYyOTNM?=
 =?utf-8?B?UzQvSVk3eUtHV2hUWEtzblBmcEg1TWl0ZUVablFNRTVnQmJEWUlzQ0ZVamVG?=
 =?utf-8?B?QklNamNJOUhINVE4NTNXMzJzcTloVm1ySTN6bDJlK1NMMTljZ1dCMjZ3cDI0?=
 =?utf-8?B?dXBlNHVUL0thbFN6cUFhK3NzcWpFWVcxWEMrd1A3NHpFYnYrVHNTUVpnZ0VG?=
 =?utf-8?B?b0ZWdm9HM29XaFFnZ2NMYXBtZWp1R3lCOWdxMWRUbVF4UVN5cHRlT2d1Q2Fr?=
 =?utf-8?B?bWowWlhmcW0xYlJYb1BEa0hGRXlVZzZkKzg4T2VrazJ6U2VyaUgzdDF3ZzVZ?=
 =?utf-8?B?aU9HcnpJMXJSc0RPQUxhcjdrQUpLV25ZL1dhS3dQNEYvSi9hY2d6cVJ0MXdX?=
 =?utf-8?B?QlE3NkRGcW93WkNKZU82SSszVE84ZW9qMnYzSkNvWEEzTUl0Y2tGNUIrTnBI?=
 =?utf-8?B?dXNYMFM5QjhIQjlvMEh4S2V2NzhzRGRmUWlsajBROWNENUY2UWw4Nll0MnNw?=
 =?utf-8?B?cXVROElXL3kweXZ5d2FCbmhUcEVNd2JLSVFDanFHaDNPNHBWRWRCblZUUHpt?=
 =?utf-8?B?d25ETEs1MFNXWjUvUE1OMGd3T253T3JlM1YrREpqdkphTzVmYVl5QW4wb2tz?=
 =?utf-8?B?dnc3bWprWXVRaG1naHMzVEpOYTFKeXV6c0tQbTVLU0x6MTJLbXRzK1Nmblpu?=
 =?utf-8?B?c0NWQ0JwdU1nYmN6OXc4ajFVZnlESThlYnFoK3o3c2MwaklIUmJ2YVZrYS9h?=
 =?utf-8?B?RGdRRG9lZXAycHhNYVlMUXY2YU5RWWl2YjlRNFRXYU1Fb0RTcWxMVjE4cUFN?=
 =?utf-8?B?MTNtSytwWUJYdG9Ua0dSL1FuNFoyNkJEZTg4am53VGdZTm5EeThBTVlRT3Zh?=
 =?utf-8?Q?GYp7m0lvxpYEhlRh0oCDxBy5ybQDeYxmfDckA/4?=
X-MS-Exchange-Transport-Forked: True
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 58bb9e97-93b7-4b7f-387f-08d8f50a4417
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0402MB3405.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2021 12:32:51.5941
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9H3JiV+iCMogfuFu3AfvCe7IYMWiUh8jhamf7c+QP04ZJYU/PjQUO4df2s+2trkqy7PxAFOZ/ak7x5V4xMwNJA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4238
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/1/2021 3:17 PM, Mauro Carvalho Chehab wrote:
> Changeset 616fde2dd60f ("dt-bindings: misc: convert fsl,dpaa2-console from txt to YAML")
> renamed: Documentation/devicetree/bindings/misc/fsl,dpaa2-console.txt
> to: Documentation/devicetree/bindings/misc/fsl,dpaa2-console.yaml.
> 
> Update its cross-reference accordingly.
> 
> Fixes: 616fde2dd60f ("dt-bindings: misc: convert fsl,dpaa2-console from txt to YAML")
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

Reviewed-by: Laurentiu Tudor <laurentiu.tudor@nxp.com>

---
Best Regards, Laurentiu

> ---
>  MAINTAINERS | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 53c66a6908b7..de9637196526 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -7274,7 +7274,7 @@ M:	Li Yang <leoyang.li@nxp.com>
>  L:	linuxppc-dev@lists.ozlabs.org
>  L:	linux-arm-kernel@lists.infradead.org
>  S:	Maintained
> -F:	Documentation/devicetree/bindings/misc/fsl,dpaa2-console.txt
> +F:	Documentation/devicetree/bindings/misc/fsl,dpaa2-console.yaml
>  F:	Documentation/devicetree/bindings/soc/fsl/
>  F:	drivers/soc/fsl/
>  F:	include/linux/fsl/
> 
