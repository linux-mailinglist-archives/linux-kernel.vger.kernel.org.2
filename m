Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 998613F4BCD
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Aug 2021 15:39:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229550AbhHWNkJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Aug 2021 09:40:09 -0400
Received: from mail-eopbgr80074.outbound.protection.outlook.com ([40.107.8.74]:56718
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229477AbhHWNkI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Aug 2021 09:40:08 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fVBR7dHq94ACAZrKBGZMTTMLyY8xN8xzrmMhfrSexrrvO6en37r8cblf78yCG9CJq8eADndQF8voa+XFS2tMCMlC1DTWLIZOY+/3utv8nf5tGER4SnZ7cBq5DLc2T2nUJy9RZNssor+L6yirr4K8vhg0d3db+VgANOdHQxHWTJBv74uMmPWmzeAz6Gu8IYGMLLg4TW8Uz1O9eqiOe+0AcJl3MMWpB6T28BtRicW6G0A1HCsvi29/30SS7B6pG8STIfuY0OqJxqPcxWdZl54qs2t0mq4h6layhvuqAWGRa2COX33qMYiYea+lBL6GsiauPWvyFKVVHxZm9husb7dt2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D1phw0WWeFM397+f4/fW0+3Z4T2un16SyZhEpTTQzKg=;
 b=QuacutatG7Q6dUdfNoVuM9Y9oVhdRvk+uHxdLUtfBhgB1bNKIQcfC3uiIE2Zi8y+lLc9c26qNDQ8nM5Bt7UE8dOZ4c3DR9EQEwKwYJcWOxG4N0DiT1zQrev1v7IvQp0H1K3thnqIogLV8onGIUbPhTfA8/izLc+CcUv8a8gJvesxrsXwWLdHp9QW0qs4gAQpec04dk8eSvA/BiedTUCf7RF6KskaBk9b9M1glyZzWx75UD7mZ6UxNCi5heQJxht7Txl/kFO8jDM9/Y+nFLRMlodG1fnpQJ5rSocNsV5+Ye22bSOYAs9JdNTap71I7Iftb3+jeCJP3fGlw5jVXF/KTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wolfvision.net; dmarc=pass action=none
 header.from=wolfvision.net; dkim=pass header.d=wolfvision.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wolfvision.net;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D1phw0WWeFM397+f4/fW0+3Z4T2un16SyZhEpTTQzKg=;
 b=UKyiIwNO3l3TGTyYHSeX3evPFNIx7lJJh5woeFWBeyTNQ3yd4PEnzWegbPNWt1JZeLrvePQVm0LWEVDSaIcPZpUfYYKsJw0g5oGuOmvu9MeJQIiq6MgdEzzqHvhtgNtSoCv42MdpUgORxogsQUbvvCpstxdEWG1QeOmdEiElmBI=
Authentication-Results: rock-chips.com; dkim=none (message not signed)
 header.d=none;rock-chips.com; dmarc=none action=none
 header.from=wolfvision.net;
Received: from DBBPR08MB4523.eurprd08.prod.outlook.com (2603:10a6:10:c8::19)
 by DBBPR08MB5223.eurprd08.prod.outlook.com (2603:10a6:10:f6::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19; Mon, 23 Aug
 2021 13:39:15 +0000
Received: from DBBPR08MB4523.eurprd08.prod.outlook.com
 ([fe80::ade3:93e2:735c:c10b]) by DBBPR08MB4523.eurprd08.prod.outlook.com
 ([fe80::ade3:93e2:735c:c10b%7]) with mapi id 15.20.4436.024; Mon, 23 Aug 2021
 13:39:15 +0000
Subject: Re: [PATCH 1/1] arm64: dts: rockchip: add missing rockchip,grf
 property to rk356x
To:     Peter Geis <pgwipeout@gmail.com>
Cc:     devicetree <devicetree@vger.kernel.org>,
        arm-mail-list <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Liang Chen <cl@rock-chips.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Simon Xue <xxm@rock-chips.com>
References: <20210823123911.12095-1-michael.riesch@wolfvision.net>
 <20210823123911.12095-2-michael.riesch@wolfvision.net>
 <CAMdYzYr4ZTXvfJaeMejuRHBkBAVKcEUseskhEVqLMSYR+Dv4uw@mail.gmail.com>
From:   Michael Riesch <michael.riesch@wolfvision.net>
Organization: WolfVision GmbH
Message-ID: <426f77fb-f0ca-9431-45e4-66b885516c76@wolfvision.net>
Date:   Mon, 23 Aug 2021 15:39:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
In-Reply-To: <CAMdYzYr4ZTXvfJaeMejuRHBkBAVKcEUseskhEVqLMSYR+Dv4uw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR0701CA0034.eurprd07.prod.outlook.com
 (2603:10a6:800:90::20) To DBBPR08MB4523.eurprd08.prod.outlook.com
 (2603:10a6:10:c8::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.125] (91.118.163.37) by VI1PR0701CA0034.eurprd07.prod.outlook.com (2603:10a6:800:90::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.6 via Frontend Transport; Mon, 23 Aug 2021 13:39:14 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8a2bced0-935e-41d1-575d-08d9663b65e6
X-MS-TrafficTypeDiagnostic: DBBPR08MB5223:
X-Microsoft-Antispam-PRVS: <DBBPR08MB52232A13976A04445991C748F2C49@DBBPR08MB5223.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:486;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wwdplM2pfN32uA2yYuuD1ProZ78EWX1y3YOliFIXodujz/+deaGHkp5whdQrcCm0nllB8yKDW2UNoIZO5QNT+Jlk+Jn0s2uIwqtSLn1FZyHdCrpEE/kuaTB+grl6IYizs+PK2e2/MGqdkhiPE8w3uhb0rq+8pP0qBtLTX+M5QUonGj9nqYLG5R1Iq89XZWe45PpU/pO/RZZHleRZMDcF9wamWL+ABJFoX7hPOQKPnurs+tYuc+/eftoDu9t/wIYb44MjbO7LxWpf/+JtMVgBzAfGCBh8UQ0x7Bh9z4W4nPfEe3q5J1rkx6ozAJcCPFTZ2fNNXoYpwzgFAX/RTG5bGO+Mok/2Wl7VGM0DG/pHFA06o/mX4IUUrcaeRf9LAoo7g1QbUxBk4eXzXBvOHoYNfhhwqAAdb8RDb+NzVmPk89oKRyWkKttOme/5XQ3vccNYYwmnBqZVa1mArUh0ERGSOR1kXQE+ZWponEuBMxWVg26QiZI/Z5YOCYofnf5o9BL8ouaYCTfqy/HmePurBJNxKKuApRP4qldgg/hxq6zjrPC6uduM+KOazLFjJiLqEoD8apsmKG/0eNFGits54DL+dF+W/iMSIau/OAVsQD1pqf2R2WT4CYkxSLY8/16alSwt7l+aZC7eB6qRPkPj3fqoII9ZvUB9YLvWI1UMRavqMjM0K9jMalwCmuUnZGSmM/eLFvIgMt2150DuMUPmQ6WWYckQkP+58bi/D7Pt3DWX7ND4VqPkmShA08c7ys8LKJqNAvcpcSU6oRTsGwNLvxE5NQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBPR08MB4523.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(39840400004)(346002)(396003)(376002)(366004)(52116002)(7416002)(31686004)(36916002)(38350700002)(83380400001)(956004)(36756003)(2906002)(53546011)(2616005)(5660300002)(6486002)(86362001)(31696002)(66556008)(478600001)(8676002)(16576012)(66476007)(186003)(66946007)(26005)(54906003)(8936002)(4326008)(6916009)(44832011)(38100700002)(316002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MnRCQzRvSlQ3WlE0d00vTU12UEhKeldXMHZ1VXdUejJrWHNUOThxT2hmK2Ry?=
 =?utf-8?B?b3hPczNzMzRlQmd2OTZPM1JncEpHWUVwWWhGaXk4Q0w5bkFBU2wydjI1ZWM1?=
 =?utf-8?B?cXBhWDVldWNpckRuVkk2MHZmVzVvaDNITTNQY3FXb09xSG1TUTVWQlhidDNM?=
 =?utf-8?B?bkRpOXNRdzdLblRKYVdSTzNlZUN2WEZJVmVpZE53OWQxUTAxR3VQcTMwWEZl?=
 =?utf-8?B?V1B0MEYrM2xUUUdEUENMMkRwSDZJMUlobWlXTjVBYitqZ052ZzIxRVZpbnhk?=
 =?utf-8?B?S1pHd2NVNzNvYzlGRjNWMUw2NEsvMFpyUlA3TnFYQU5QQ2dzTWN0TEJGc1Z2?=
 =?utf-8?B?VUZUVCtRSzl1RC8zYk94ektuZDFkemZjelBRb3dKSHhFZ0dVNGwwK3B2a0ZW?=
 =?utf-8?B?WkFrdDlCbjZVUDl5QWF6bDJxVDBUb2w3ZFNPYlV1L1FPVG5EZEoybC96ZUw0?=
 =?utf-8?B?cXVUa0RybWgyMWsyRmlhQWs3Rmx5L1p4L1FSdUpYQ3hWTE02RGFQYTh2djB4?=
 =?utf-8?B?ZHk3akc5eGxGbEZCTjZXUUdnbHltN0JCZVVLYVJKZnJqZGd4R2lPSUREa0Nm?=
 =?utf-8?B?Mk93VHdIUFZhd080UkFxVlhGYXZEcXJ6Q1FyRDF1b3RjRVVNTkkyTkwzV1hv?=
 =?utf-8?B?Q0NuSVBIMzU3MjJqOEg2VFc0MWdHaGVaajVPd3N3N3lqZXB1K0dGVmRMWmVI?=
 =?utf-8?B?eTVHWFRleVNUTHFaQ3l4djg3dGcwSjgwTDJ6czBLdlZOVldaTDBMRkt4SDBW?=
 =?utf-8?B?TVl4cnkwS1lHUFhCWTZtQWJzWHoyZUd2MXhxdWMwY040ZGcxMFFKaWwxK3pn?=
 =?utf-8?B?K1hnVEdEQk5FSUNNTnhJVEw0QzRZeE9oQmo3VnVDbEcyb0Z4emYxOW9KOFRH?=
 =?utf-8?B?TFF0SDBIbjJLcEJSL2xDMWVCVGI0VWlpdTBFY3kzZUxZZXhLT0pWdG1ReWVB?=
 =?utf-8?B?Sy94eVk3ZEhvbVB2VWxGYVpEdFVEa0FIbktlUzRnQmZ3SVM1NzFHbTdlSjgx?=
 =?utf-8?B?Y1k4dDVpZ1JTOE56SGZQWU5abkRSM2xOL1dUSnY4dkwzV2N5cUVnVDN2elJ1?=
 =?utf-8?B?b2x3ZEQ1VVhrVEh6OUpLUFU0VUkyUWdLTTQxWDdPbDdYMVRVQkg2ZlppaFdv?=
 =?utf-8?B?V2liM1dRRTBFbDJtdU5ZSnl5OUFjeldHUkdNVklUcTdDQzVBZFJYbVV1clJw?=
 =?utf-8?B?RkVLajlhWU45NE9zWFNQZC90NnJIU0k1cFp1Yk9scGJrTHBHelpzVnNpd2ox?=
 =?utf-8?B?bC9Gb0hVRXk0d05ML1BEYkJqTXlvSG5mS0NSbXlTM3ZsUzRQNDMrZ1pMMjJD?=
 =?utf-8?B?ZUs5TTk2Q0FKMGFHK0kzbTFBTFVCUTVaYnM2RFUrR3JaYWNFY2xudEtLWHNU?=
 =?utf-8?B?cXB1WTVBYzJyZXJBMW5QSE40QU9OWnUxb0tFQzd3N3M5ZnVzWlAxT0RqcllW?=
 =?utf-8?B?MkY2SktIcEQyOE9hYnZmbWF2U0pWd3drZ21FcDZkbm9rV3hwaHFoTmo2bXRZ?=
 =?utf-8?B?Q0J6eng2Y2tpb1BHSFh0LzNGQXZ0c011eHJmL1FlKzc0NmxCbUtDSk9xYnJn?=
 =?utf-8?B?emZYTlMzYlZJSGY1dkE0R091OThMZ01FMTJ3a0VVam1OK25hNFQzN09LSGpr?=
 =?utf-8?B?MGVoUG5STzk3SkRqUGxwdVFrR1o1R1ZWSGpTQ1FocjNqbzM2UTFOOERQQ1VB?=
 =?utf-8?B?RmNML0g4N1d4RlBmbXU5ZFpKMHNyU040QnBlYnZwdU9ySy92TzZZcnZqT2FY?=
 =?utf-8?Q?ONPccWgtKf1NUMBOXxiTS+KiI0oslpHxk/KXhM1?=
X-OriginatorOrg: wolfvision.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a2bced0-935e-41d1-575d-08d9663b65e6
X-MS-Exchange-CrossTenant-AuthSource: DBBPR08MB4523.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2021 13:39:14.9843
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e94ec9da-9183-471e-83b3-51baa8eb804f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0t7UnKpdF/Wn9zop+3JKGUg507gUtSkovBI2M1Dr9phHGBOIg9qQvd93GdF89hYu8fzt1YeBxHbSnblicZ7+tGw0ur6uoMUk3Zz1oCl3Skg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR08MB5223
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

On 8/23/21 3:12 PM, Peter Geis wrote:
> On Mon, Aug 23, 2021 at 8:39 AM Michael Riesch
> <michael.riesch@wolfvision.net> wrote:
>>
>> This commit fixes the error messages
>>
>>   rockchip_clk_register_muxgrf: regmap not available
>>   rockchip_clk_register_branches: failed to register clock clk_ddr1x: -524
>>
>> during boot by providing the missing rockchip,grf property.
> 
> Good Morning,
> 
> This was fixed by commit: 6fffe52fb336 clk: rockchip: drop GRF
> dependency for rk3328/rk3036 pll types
> which was merged in -next. I don't believe it's going to be backported
> to 5.14 due to 5.14 not being able to fully boot.

Unfortunately not, I am afraid. I am working on Heiko's current -next
and the commit you mentioned is present. Nevertheless I got these error
messages.

They can be traced down to "rockchip_clk_register_muxgrf", which fails
as the passed argument regmap is invalid due to the missing device tree
property. The clock "clk_ddr1x" is added in clk-rk3568.c as "MUXGRF",
which leads me to believe that the grf property is actually required.

Best regards,
Michael

> 
> Very Respectfully,
> Peter Geis
> 
>>
>> Signed-off-by: Michael Riesch <michael.riesch@wolfvision.net>
>> ---
>>  arch/arm64/boot/dts/rockchip/rk356x.dtsi | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/arch/arm64/boot/dts/rockchip/rk356x.dtsi b/arch/arm64/boot/dts/rockchip/rk356x.dtsi
>> index 23949e79d8ce..0a1d07c96b2e 100644
>> --- a/arch/arm64/boot/dts/rockchip/rk356x.dtsi
>> +++ b/arch/arm64/boot/dts/rockchip/rk356x.dtsi
>> @@ -233,6 +233,7 @@
>>                 #reset-cells = <1>;
>>                 assigned-clocks = <&cru PLL_GPLL>, <&pmucru PLL_PPLL>;
>>                 assigned-clock-rates = <1200000000>, <200000000>;
>> +               rockchip,grf = <&grf>;
>>         };
>>
>>         i2c0: i2c@fdd40000 {
>> --
>> 2.17.1
>>
