Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0ABC53F7106
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Aug 2021 10:19:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239301AbhHYIT4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Aug 2021 04:19:56 -0400
Received: from mail-db8eur05on2074.outbound.protection.outlook.com ([40.107.20.74]:61101
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S239005AbhHYITv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Aug 2021 04:19:51 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e5EE/Y2N/iQhv84EVRe+yQ0EQMuaHZA0fEmuuqosiEAOsCE7U6rIIy5g/tL9NcqbLQh7e4NhOJozxEVBdM29Wajvx5tYF6lKFjvBatmNZ3ZhqjB2kiJNc3Pg2DV2kz/O59QAc7kjqTMpX8VoSfOe+P+OT933GDbya8xXkMRJIhA4acUAJ6kuQlSjG29Jjo4O6eWHEpPqW9/jk/7CmTDe/T02+mXcxjxI5NAJvzdWxR7jnCEJ9MOwhrHukz0yS4i1wYVrxW8yhJJgsoRO64SwYCUvyO2J82rIKYSRmqyMM51TVZIM6SJ513PsYaedf70LS6gizF8Y3np0xbOqG8Vpvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HrmDQ3kS8WWnoZfdFgL+KPdQTaJJXEKsvX3Xm/kg+2M=;
 b=AZfEqHYaOBF5JmlKY/2TXU0OjhHPxOWa7BWYSa14KLHoMUpR5Cd6/iqCa8p6HV9PiNjAwfqyilbdf5APbh2M+N85sweQ1JAerZpTAY+HQ8EXjdEQe8VUFDN+x0dNF18GGFGTTKALWFM/9SLWYR1G/lOi8iQMiMRgArJODGycS4nf3F+OXk49GtPZeXoHSDdQgDEkhfT9nLkAY4VvD4Nz1AyfJeFFMp6H5bOOJFrra6gspBxpU7A6g3Xz0mrgTB/0c1pDAPoBU8QNBAbqKZHF1WmhV590bUWLg5vRH+9BaoINW+4U2Zlv4c8HKSLo6Yaytu5KiOPwAo7fUHbUGgviBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wolfvision.net; dmarc=pass action=none
 header.from=wolfvision.net; dkim=pass header.d=wolfvision.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wolfvision.net;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HrmDQ3kS8WWnoZfdFgL+KPdQTaJJXEKsvX3Xm/kg+2M=;
 b=zRlqmrafF9SbsxJOwKDkVOL0b/0WAlU7ALWxtETxpcpAhHNVnGjV5He3pDao2nBUcKzfntR8p+P9TM+FSEupL5TDSSeGUC6EFnGAJWxz2BD+e6nVc/Uw1JLRplOzmYCpBriiPTcEr7YUAaaaCD2u9n+H7rx5TCCqzBbs5Se7eBk=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=wolfvision.net;
Received: from DBBPR08MB4523.eurprd08.prod.outlook.com (2603:10a6:10:c8::19)
 by DB6PR0801MB1719.eurprd08.prod.outlook.com (2603:10a6:4:3a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.23; Wed, 25 Aug
 2021 08:19:04 +0000
Received: from DBBPR08MB4523.eurprd08.prod.outlook.com
 ([fe80::ade3:93e2:735c:c10b]) by DBBPR08MB4523.eurprd08.prod.outlook.com
 ([fe80::ade3:93e2:735c:c10b%7]) with mapi id 15.20.4436.025; Wed, 25 Aug 2021
 08:19:04 +0000
Subject: Re: [PATCH 1/1] arm64: dts: rockchip: add missing rockchip,grf
 property to rk356x
To:     Peter Geis <pgwipeout@gmail.com>
Cc:     devicetree <devicetree@vger.kernel.org>,
        arm-mail-list <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20210823123911.12095-1-michael.riesch@wolfvision.net>
 <20210823123911.12095-2-michael.riesch@wolfvision.net>
 <CAMdYzYr4ZTXvfJaeMejuRHBkBAVKcEUseskhEVqLMSYR+Dv4uw@mail.gmail.com>
 <426f77fb-f0ca-9431-45e4-66b885516c76@wolfvision.net>
 <CAMdYzYpSHkW3NDztmw=CUbYbqQFP+qYdavr6AQZfxwmWJ4eYAw@mail.gmail.com>
From:   Michael Riesch <michael.riesch@wolfvision.net>
Organization: WolfVision GmbH
Message-ID: <fa7e4a0a-8532-dcdf-18ed-ec20bd7411cc@wolfvision.net>
Date:   Wed, 25 Aug 2021 10:19:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
In-Reply-To: <CAMdYzYpSHkW3NDztmw=CUbYbqQFP+qYdavr6AQZfxwmWJ4eYAw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR08CA0152.eurprd08.prod.outlook.com
 (2603:10a6:800:d5::30) To DBBPR08MB4523.eurprd08.prod.outlook.com
 (2603:10a6:10:c8::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.125] (91.118.163.37) by VI1PR08CA0152.eurprd08.prod.outlook.com (2603:10a6:800:d5::30) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19 via Frontend Transport; Wed, 25 Aug 2021 08:19:03 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5eb6687e-9bf9-4c67-55c4-08d967a10031
X-MS-TrafficTypeDiagnostic: DB6PR0801MB1719:
X-Microsoft-Antispam-PRVS: <DB6PR0801MB1719F73AE3303660EB2DD489F2C69@DB6PR0801MB1719.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QvjvJ0ERxvJuc5k77vHtlnLLHUff1Iho0Y8fnDY0qH7DLsC2mF35TO87oFB+b5+VcR4lc3mXQAsKHK6NRwhjY2YKA1dV+zR6wytDUOgytvISUXOVkR9xoGxBQCvbGg7Gas53u10AJ+K2nNwBWyiz88cql8CijYyYBgk1dWEbNC1C1KPJLAOY3++aWVsB9bGD22m4vJKKuk9iJ2gGe2LvhDNyZkv4kHn76q1xAXWxzGzj74fLyN0WILr1b+XgkGKRgeJqJLZJl1EhpbN/AMTLWHBWfx1Xl3q75cwrlJr1MP0BrCVPkWXprGLnoomkkdWgqoe1CqTjJPNyDK9cHRGehrcRKhnZFI/MNLvwwlyFiuyOAfe3Nb7I+kd3Zh3FGR6jiw5dU0AmbO7TMveneVBwx1FjXzGlDx4k9Q1A7E/XvtlKPL4j2NtPYGVia8QFkAr0yR6qEqE053JyppIWflBpAGFWT75DH8VzehpydQ3OmMwtu01zF+qiMLeJvFZ3Uc76BPN6wglYKJY+Q5Cl/T9Z20cOUuqzj8U42UQ2EGT0gH7Mxo+Xwq2yIoB9vQxzNFKXIliH5D+FiDU8Pd8Ewyry0nqYUskvpdQgvyJegnV6eqJqP5kDNAz9ieRLz0LDccuOP2zorCtpEMakEJIHmagB0xXLydrwQNSA381Sy3KhUsCussO4EqLhHUFTcXKmdnU2AXPsEs3VIwyvle2OJOAuQuqEq6ViaDUTwFNMRX3KCd06jB6jEN9rdgqHZosxJTd5GxMvdwDySswJUgoeJUOcL6oh9N/UykpVBYxkSBi2/18=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBPR08MB4523.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(396003)(39840400004)(366004)(376002)(346002)(66946007)(26005)(31686004)(4326008)(38350700002)(66476007)(8676002)(2906002)(38100700002)(5660300002)(956004)(31696002)(36916002)(2616005)(478600001)(86362001)(52116002)(83380400001)(66556008)(44832011)(53546011)(6916009)(36756003)(8936002)(6486002)(16576012)(54906003)(316002)(186003)(43740500002)(45980500001)(357404004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WndOUWh3YnRzL2Z6K0lvemZCTE1US0h6YmkxcGNHZGsxeHpzRnZDd2hSVkxT?=
 =?utf-8?B?b0hXWWRZK3A0Ty83M2IrNWd6cldsNVFFazRIWG9OUVVMb3p4UlJSZFhXMzVn?=
 =?utf-8?B?c29GYnRQRnNaOU4vbUhrYUc0aXhwRUFTMjlIKzJvckIzR0M3VnRKMDBzODg1?=
 =?utf-8?B?NXo5WUdTTzVYbE5PR3pwM0tjM2E3U0pPUXU0ZC94emZnUXZOdFZacE4yMlQ3?=
 =?utf-8?B?OUhxbTQrM1VJMk5ub002dkNBQndXUU5qWm9KWjJ4bXZqSk9NL1Z0UHBiQkly?=
 =?utf-8?B?UmJhSThqUmdPQUwvV0FXUjl1WEFablp6LzdEYVBCYUtmUmhBUFgySzdIZXpr?=
 =?utf-8?B?Szd4UWw0MlphVmtXemVJK0VqM211alF2Y3JjWGhpQng2akk3Sm1VaFUybnQ3?=
 =?utf-8?B?emFyaTN1QTNVbVIxbnhEejgxL001bXd1MU9jSWVUcVdwMk1la05kZEtaWUhX?=
 =?utf-8?B?TVhGdVF6NlVIenpBdlg3TEZ6cUdjUVZZR0NoeFplWFZHOWphTTdvcmhuWk9B?=
 =?utf-8?B?aVMrNHlkd01FVnZ6YXgyYlpvd3dYS1lwNXlPV2pjbFpuYkVXMWFVcWNFZDRw?=
 =?utf-8?B?dnRacHhSTUxxUTUvS1VQbUhyMUVsSVAvRGJrcDNxMW1WZ2pNV1J3N21rRzdH?=
 =?utf-8?B?bXFLYlF5aWlYOE9FbSt2T2dEdXhuQVc5U0NLdGNhSlAxcUFacVZjMXdSWS9l?=
 =?utf-8?B?a3ViV2ZhOGdvK3cwQzlNVysrSis0bE5CSDh1aWhzNVRVMDN5UXdHZitOZmFm?=
 =?utf-8?B?WE5xMmpRM1gvemk2QUEzTGhyQVZpdllHUTFGUkJtbXh6TlN0MDlnYWhlWkVK?=
 =?utf-8?B?Z0piTFAzZGNWMkdJZUpDS0RvUUFYWGNjdVppREhzS0JUZmlaRFQ4ZExObFor?=
 =?utf-8?B?MWNlb0hJd0psNkkyaWNBRGVPZFozMXozNU5pUDNLazg2amdxMHY2MVBIOG8r?=
 =?utf-8?B?UEhmOVFSOEVrcDlGelpreWxZano1aCtvM0RBU2dtbjRjdnQ4MXg3azdXeXUr?=
 =?utf-8?B?ZWpWSkF3L1FFSm9rUjM0OTY5ZzlCZkJWL1hBQUJYamQzNHFOUjN6bGI2cE5Y?=
 =?utf-8?B?a2FhVWwwdC9RNzdydWtZQVV4NmlVdXY2RHY3UE9hdVRLVnIydG9VNER6Wm93?=
 =?utf-8?B?NkRsVXhlcWRtMFM4YmZqeVBxNkZTQSs4bFA2Ni8rNWpUOTViSGdIK01PSFFM?=
 =?utf-8?B?S3V2cHpFdFZ0VTV1SEpIS2wyR1FrUnFKcVY4WFlZNHp6aEtOdThKMUYxbzlz?=
 =?utf-8?B?SEthUTg4aUxjRkFLd0Z0ODFPekxtaEVuQVE2d0R6dVg2ZVpacGtPM1pyNlRK?=
 =?utf-8?B?NVIrOWx3eCt4SE84MURrK1p5TjAwT21UTjZjMkVtbWhxa0NZUjVCUXBuaUtw?=
 =?utf-8?B?OWQweEhLb0ZUVG83c3lWWVNFbWxLdmhYM0hydFVyTElxT0FoMnZoNHowSlQv?=
 =?utf-8?B?aTM0VjNHTWlpYUs5UzhScHBTRDFsVHZueXVZaDg0NmdRdUJXczNseTB2ODF1?=
 =?utf-8?B?aHJWNDJWK1dWclRMcWJJclJqY0Y2MDEwOWtyMUw3VzFyOVVEaVNmQlpNbkNu?=
 =?utf-8?B?Q05IZlhwd3NSZDkxSmVqbVZlczA4eGZLT1g4VTJDN3lyQXVHNlVJTk8wb2Ex?=
 =?utf-8?B?TjlIUUJ1YlBxQ1BLR2ZVdThpVjNZMWdTL0UybXp0eVZuQ1RxSjRmUzRsYSta?=
 =?utf-8?B?bC9kUlVoaU1iR3ZVbDZEQ1QxdGQ3YWY5b0xkVHdLNjdGeUR3cDNYaVYyTW5C?=
 =?utf-8?Q?Y4YjD2te70XxzhVd+0PRFcVRieofqpmjbFn0Ors?=
X-OriginatorOrg: wolfvision.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 5eb6687e-9bf9-4c67-55c4-08d967a10031
X-MS-Exchange-CrossTenant-AuthSource: DBBPR08MB4523.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2021 08:19:04.2003
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e94ec9da-9183-471e-83b3-51baa8eb804f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OLWQBjSuSu+R2XU1Ov2kytsuT1dBNkTq3tW9ZGLUxAyfV+5oB92AJs7uHShIO4V91M8viOzETE0zSDL5hG/joN2v1FuGJoRp+ELOvcM7YNs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0801MB1719
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

On 8/23/21 3:51 PM, Peter Geis wrote:
> On Mon, Aug 23, 2021 at 9:39 AM Michael Riesch
> <michael.riesch@wolfvision.net> wrote:
>>
>> Hi Peter,
>>
>> On 8/23/21 3:12 PM, Peter Geis wrote:
>>> On Mon, Aug 23, 2021 at 8:39 AM Michael Riesch
>>> <michael.riesch@wolfvision.net> wrote:
>>>>
>>>> This commit fixes the error messages
>>>>
>>>>   rockchip_clk_register_muxgrf: regmap not available
>>>>   rockchip_clk_register_branches: failed to register clock clk_ddr1x: -524
>>>>
>>>> during boot by providing the missing rockchip,grf property.
>>>
>>> Good Morning,
>>>
>>> This was fixed by commit: 6fffe52fb336 clk: rockchip: drop GRF
>>> dependency for rk3328/rk3036 pll types
>>> which was merged in -next. I don't believe it's going to be backported
>>> to 5.14 due to 5.14 not being able to fully boot.
>>
>> Unfortunately not, I am afraid. I am working on Heiko's current -next
>> and the commit you mentioned is present. Nevertheless I got these error
>> messages.
>>
>> They can be traced down to "rockchip_clk_register_muxgrf", which fails
>> as the passed argument regmap is invalid due to the missing device tree
>> property. The clock "clk_ddr1x" is added in clk-rk3568.c as "MUXGRF",
>> which leads me to believe that the grf property is actually required.
> 
> Ah, yes it seems you are correct.
> I had inadvertently fixed this a while ago in my own tree.
> Confirmed without the GRF ddr1x clk doesn't register.
> 
> Tested-by: Peter Geis <pgwipeout@gmail.com>

Thanks for testing/your T-B!

> On a related note, are you planning on working on the DVFS driver,
> since it will be the only consumer of this clock?

Until now I was not aware of this, so it is not on my plan. But thanks
for pointing it out, it is definitely something we would like to see
(and maybe could help to implement).

Best regards,
Michael

> 
>>
>> Best regards,
>> Michael
>>
>>>
>>> Very Respectfully,
>>> Peter Geis
>>>
>>>>
>>>> Signed-off-by: Michael Riesch <michael.riesch@wolfvision.net>
>>>> ---
>>>>  arch/arm64/boot/dts/rockchip/rk356x.dtsi | 1 +
>>>>  1 file changed, 1 insertion(+)
>>>>
>>>> diff --git a/arch/arm64/boot/dts/rockchip/rk356x.dtsi b/arch/arm64/boot/dts/rockchip/rk356x.dtsi
>>>> index 23949e79d8ce..0a1d07c96b2e 100644
>>>> --- a/arch/arm64/boot/dts/rockchip/rk356x.dtsi
>>>> +++ b/arch/arm64/boot/dts/rockchip/rk356x.dtsi
>>>> @@ -233,6 +233,7 @@
>>>>                 #reset-cells = <1>;
>>>>                 assigned-clocks = <&cru PLL_GPLL>, <&pmucru PLL_PPLL>;
>>>>                 assigned-clock-rates = <1200000000>, <200000000>;
>>>> +               rockchip,grf = <&grf>;
>>>>         };
>>>>
>>>>         i2c0: i2c@fdd40000 {
>>>> --
>>>> 2.17.1
>>>>
