Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07027374F7C
	for <lists+linux-kernel@lfdr.de>; Thu,  6 May 2021 08:43:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232521AbhEFGoX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 May 2021 02:44:23 -0400
Received: from mail-db8eur05on2139.outbound.protection.outlook.com ([40.107.20.139]:30171
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229844AbhEFGoU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 May 2021 02:44:20 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PNtr3VuPC+TU9mEYU0yzelny9gQn4A2c8W7xNcN+46nhYBO8lieTZTzpADvcTEQcBJA7v+2IPknx0UJyRivO9ikDhF2ZsNGFp+oXTJCFKvbwYVDjjv6sn7sjMoGXTucbQ3HDIWVKjzanoYjnJ2J+Ep3pOxnNjYTJOVLsaoeik4GYgjWglljhfpgM2GJN1ZNdPkgwKqzPf52v0oOptbcDsapQmk28AhGc/URo4EVIC2rMUIvt+BKT3+yVpCc0AS3llvpQhxDAXJyxNzcn7gyB1GdKt6EdvKt+AHiC+3geXZeD7Hqt+GV2plShxW8stMSFE+oOV95+aEy0PhJn9nLesw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2gJig5OKQ410qXG6xMwgFUwfaeueiNjE1bWZIxx7dkk=;
 b=D0EcbyRsR9WyrXcSZUL67dt6GY7t4IqKxvbIS6mHmeyP0Ev+LEN/+1VNPfsO5E+4WjtAdO+VbUrObqPoxt1BBeDCFoGqGUBtXqxzm3447uxtl60RnJnifBiPX4u1/s3Z3fCKL2A0MEYhIcqjiuSmsEFmBIgQ6Eewzthq8wQVpElX95k0sjIA9nMY7C1kunKaiKH6PXT6lLNC/2WDp2MzhQIavBBPKFyqU8zSiPQwQc/PxG08d5xTFkqzsYTNtXPnmn6ZyndFFAlewgp0eVsuZDSJJ096yvFoBc9HN+2X0/yd/zQnzvBuPiCDlTOt/MjNKfffGGTVwT7fn8p8uBi5Ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kontron.de; dmarc=pass action=none header.from=kontron.de;
 dkim=pass header.d=kontron.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mysnt.onmicrosoft.com;
 s=selector2-mysnt-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2gJig5OKQ410qXG6xMwgFUwfaeueiNjE1bWZIxx7dkk=;
 b=SzNhmoGepKXqFYFjfHvw1yylhJgZwrjtQl0rV8OB3pfCThinkdAA2qrTN/laoeTh/MNHcZ0lTR8ii4oJqu2YUBFLsAyj6hTfKSuWJkjVkKk9A5xr/hAhLDlHvHExvKGEaqi92eFthRhsixnCq+Lyki+hW1Gg1uVBdP+nnyJayYE=
Authentication-Results: nxp.com; dkim=none (message not signed)
 header.d=none;nxp.com; dmarc=none action=none header.from=kontron.de;
Received: from AM0PR10MB2963.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:157::14)
 by AM0PR10MB2866.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:158::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25; Thu, 6 May
 2021 06:43:20 +0000
Received: from AM0PR10MB2963.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::3d8a:f56b:3a0c:8a87]) by AM0PR10MB2963.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::3d8a:f56b:3a0c:8a87%7]) with mapi id 15.20.4108.026; Thu, 6 May 2021
 06:43:20 +0000
Subject: Re: [PATCH V2 08/13] dt-bindings: imx: gpcv2: add support for
 optional resets
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>, robh+dt@kernel.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        p.zabel@pengutronix.de, l.stach@pengutronix.de, krzk@kernel.org,
        agx@sigxcpu.org, marex@denx.de, andrew.smirnov@gmail.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, ping.bai@nxp.com, aford173@gmail.com,
        abel.vesa@nxp.com, Peng Fan <peng.fan@nxp.com>
References: <20210506010440.7016-1-peng.fan@oss.nxp.com>
 <20210506010440.7016-9-peng.fan@oss.nxp.com>
From:   Frieder Schrempf <frieder.schrempf@kontron.de>
Message-ID: <a6554ae1-75d4-e471-6371-d9ad2246599f@kontron.de>
Date:   Thu, 6 May 2021 08:43:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
In-Reply-To: <20210506010440.7016-9-peng.fan@oss.nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [89.244.180.42]
X-ClientProxiedBy: AM7PR03CA0030.eurprd03.prod.outlook.com
 (2603:10a6:20b:130::40) To AM0PR10MB2963.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:157::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.10.27] (89.244.180.42) by AM7PR03CA0030.eurprd03.prod.outlook.com (2603:10a6:20b:130::40) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25 via Frontend Transport; Thu, 6 May 2021 06:43:19 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c95b4104-c24f-4276-3ad5-08d9105a3d01
X-MS-TrafficTypeDiagnostic: AM0PR10MB2866:
X-Microsoft-Antispam-PRVS: <AM0PR10MB286685DA9ECCD906CE2B1393E9589@AM0PR10MB2866.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:3044;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Poj8ge4KQu3J+qp6FDJUAjFybYOXAbT0nmD8V5IFUSSAS5OG5C9DjzKg9UDvUDyy/cBlJtabc/hOieCe+qKlNFwsFOn211OYB9DNS3J5NJOfE+lSZy+cz24wW7Q69XqLt5H32qTMXf/q7bvn40eiZL9zY2mKacaOZ8YPbDY0zxTw+f+NAQeQtGFh1oqRajNvoZz72yDCY7wv+buy/YsS3fyIYup3E3cJVXAgdiNEFPFmn/7DdunJp0J/vMSvCCE1SfE3BXLxToNfVkUsmxkIHTkGXH1T+XW+Xg19OeSMiHtpmhF1kJsZjGKnYYLUZf5MwB8YJ30IKHv4bB2tsWmpazEVLxyyMziPMBW2W/eRXo9ulAdg90AKPvNnrIrT0ES4PreBKJOA0ltgc270OENqLkOAAYNjqO3wuwHBwJnEEx6dbp4mmRcnr2PPyPdlE86Q+3UCJOtfHmjfqIo+l40fWqBcGYLcDO/1X0lSwo3hu9zMF0eElaxM+gUwvNaCMP9kQ7YpNPXIrmbXy/daDIpmtJJf0PbxA7J8kcNo1sHfw87dXlFIZhDcnrQQ15Sia6Rpdpu1zTDGjKZ0LJZWx+/xWxNc74auniuJscDnW2wIS4UInqlPu0ZdRpNyDJigfg9IU+HyI8FODYJQ6O4eXbLFNmURXOPZL+r1AH9u7zaB79NCj9NRNXcNKs3vHHhDrAPa
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR10MB2963.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(136003)(376002)(366004)(346002)(396003)(4326008)(44832011)(31696002)(8936002)(6486002)(31686004)(956004)(2616005)(2906002)(66946007)(83380400001)(66556008)(66476007)(478600001)(7416002)(38100700002)(186003)(16526019)(26005)(36756003)(53546011)(5660300002)(8676002)(16576012)(316002)(86362001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?VFF2ZGVGRDlLQjNXa1NnTUN1MWJPRUl4V0h3MHRDUTkrQ2Jkek96Y3pBT3I2?=
 =?utf-8?B?WFV2UFk3Yk9pMUdXc05VUk00cG1GOC9udkxPMzVPci8rQ2FjcW9DS1dUb1kv?=
 =?utf-8?B?dTh1cWt6RVFpNG11S1VwVXVWcWZRczVyREwzSkZtTlprUEFFQXUwQzIyZFhD?=
 =?utf-8?B?QVVoNWNXL2tDWDRKRGlmaGM4bDZqYmVVOGcrd1ZWYkJ4MUVVN05LWFZnSmY3?=
 =?utf-8?B?TmZ5a2RHOUxkdW9lZ3pKSTM0YTZYYmczdjBRS0wyUEpqbTArS0EyOTBsZDNO?=
 =?utf-8?B?a1JJcUJ0NldhMjdtdjEyZVM3SDhYVHlGczBka29OUDc5MThwRlBQbVNBaGNX?=
 =?utf-8?B?RktVS29VK1pmSGsvampBQlIvN1g4aVpOMVMxOW1rLzhXdlhOSENHY0puL2dx?=
 =?utf-8?B?eVErMW9heFd6MjVYZ0dlK3JUWEV0NE9tMk9NTy80ZU1USVhySXNDVjBSZVpi?=
 =?utf-8?B?WkxKYXJ4RWhiZ0JzbDhwRVVzcU40dDkrTURDWXVKcmNNK0RZQ3YrdlFOOUZo?=
 =?utf-8?B?a2VuaG5SWTJPeFZmT1Y2TllsU1NWOHIvNkYzSWpENEJ2djdUbVRTMWZodEZQ?=
 =?utf-8?B?L0pwVFZBTzAwbVRkZ3V2OGQvc3lEV25lWG9UQ3RIN0VZQ2JlZWpYeWx5QW9X?=
 =?utf-8?B?T2kxUkJVN09NRVpRck5vYzVmMzcxaVBQUTFLT2VDMlFPVmlaR1kyZndIRTlP?=
 =?utf-8?B?MXYwTDZDbnZGWHNDWlpuckhzZkxxQVdSU2RUZVVuYjhXbE9sSWl0cWlQOTJz?=
 =?utf-8?B?S055RU16STBUZGtjL1J2RHJzUFpkVjd1UG5MbDlFdlN4d1l3Mk5mTTd1YzBJ?=
 =?utf-8?B?QVZ6K1NpOHNKendpUWxCMkx4Q1R2WnhZd1h1dzhDTDYzVUNBTmk5WExUNWdY?=
 =?utf-8?B?S1U2QUV0LzF4RGpnMjVYV2ZPcFhaSVlneWVya3JTajNoNjFWS1R3aG5Od29x?=
 =?utf-8?B?ekZvOEtselVRNFJEK0FYNmRRem1DWTZYK1V0VEVGU3ZTRjNWUlUrZTZJdXdL?=
 =?utf-8?B?VUZlMllvMzVqRWh1UDd4RC90Y2F4ZDFWRVJMSUZiM0kvZzkxdWEzYVZrZFE0?=
 =?utf-8?B?QzFOQWJOTzZrY3NkTmhYTk9nOGxuUWlCWFlBL0c0VDNZMzRqVm8xYnVMWnFX?=
 =?utf-8?B?aDEvTUVVbkJOMFNXUEhJMzR0aXQybHpTMWN2Q2VrbWJLTmdORDYreE1vZ0FU?=
 =?utf-8?B?UFN6cHhrRVl4TkdhWlc1dC9SKy9JQlUyUTBjQmNVcEJic09BU3pRK05FM0l2?=
 =?utf-8?B?UzYrdjlpMmRMb0xDZXo2ZVRPNlhLaTdlV0J3aVJxS005MGt2MWZPRU1Va2Y0?=
 =?utf-8?B?MmQ1NEcxekpjL1g0TnI2UmN3SnFPaFRvZGxqdjlSQVhZd0FLQXpxSVlmY0lm?=
 =?utf-8?B?UjhIMU0xM1FnTVJ6eDMrNnZVak1XMk0zYUdFcm5sREFsZk04RmRsakZzNjRQ?=
 =?utf-8?B?a3R1SnFjYW5SUlMxVHZlRjBWdUNvTDJYYWF6dWRoSi8wblVYRS9zOGYzSko2?=
 =?utf-8?B?ck1BRlE4Y1p0bU9MV095TDEvdk9FdDRGWXVnZ2xWdDIrM2c4TUkxZ2dORitl?=
 =?utf-8?B?UGlISjU4UVJIeEI3eVJGUldXNlp4T3kyeDgxRHB4N0F6Y3ZZZzArYTllTjNz?=
 =?utf-8?B?VEZmalNveXRITm9Ib2V2aldCN2RwUXpwYkdoeDc2Y2NYVEVEeHhZSXFlWW5Q?=
 =?utf-8?B?WjgzVnRnZmVYZVlLZDJRYVByeFJzUnlUd01EcEJJbXRaZ2FwYXRrL25FdGIr?=
 =?utf-8?Q?zPCTr0ZBO4xVQsvG+9pxcBzn+ep/Hb0HiR7o+U9?=
X-OriginatorOrg: kontron.de
X-MS-Exchange-CrossTenant-Network-Message-Id: c95b4104-c24f-4276-3ad5-08d9105a3d01
X-MS-Exchange-CrossTenant-AuthSource: AM0PR10MB2963.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2021 06:43:20.8426
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8c9d3c97-3fd9-41c8-a2b1-646f3942daf1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w1uMpWLZMnR7Eqk+Kg3gZmMJcyfhBFuaDK3xbhecs1nSj8ok/cgkmV/tmSbR0Pf8dgLg4XzrHVdQ49RmMFQE6wnhO23B7fiV3PJ3G/4kWps=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR10MB2866
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06.05.21 03:04, Peng Fan (OSS) wrote:
> From: Lucas Stach <l.stach@pengutronix.de>
> 
> For some domains the resets of the devices in the domain are not
> automatically triggered. Add an optional resets property to allow
> the GPC driver to trigger those resets explicitly.
> 
> The resets belong to devices located inside the power domain,
> which need to be held in reset across the power-up sequence. So we
> have no means to specify what each reset is in a generic power-domain
> binding. Same situation as with the clocks in this binding actually.

My understanding was that Rob wanted this explanation to be contained in the binding docs itself and not only in the commit message, but I might be wrong.

> 
> Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  Documentation/devicetree/bindings/power/fsl,imx-gpcv2.yaml | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/power/fsl,imx-gpcv2.yaml b/Documentation/devicetree/bindings/power/fsl,imx-gpcv2.yaml
> index a96e6dbf1858..4330c73a2c30 100644
> --- a/Documentation/devicetree/bindings/power/fsl,imx-gpcv2.yaml
> +++ b/Documentation/devicetree/bindings/power/fsl,imx-gpcv2.yaml
> @@ -66,6 +66,13 @@ properties:
>  
>            power-supply: true
>  
> +          resets:
> +            description: |
> +              A number of phandles to resets that need to be asserted during
> +              power-up sequencing of the domain.
> +            minItems: 1
> +            maxItems: 4
> +
>          required:
>            - '#power-domain-cells'
>            - reg
> 
