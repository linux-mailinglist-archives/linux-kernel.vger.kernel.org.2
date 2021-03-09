Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4263333319E
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Mar 2021 23:40:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232048AbhCIWkL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Mar 2021 17:40:11 -0500
Received: from mail-db8eur05on2092.outbound.protection.outlook.com ([40.107.20.92]:19169
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232105AbhCIWjv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Mar 2021 17:39:51 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W/A5doroGB7RnGU30mhsxZdJeNLOjDBSLn/jRzxR7SLuYdLVArEYG2cXX499aPD2LIaJg7nMHpHlwKV61If06jPUdxw4CxjhshlO23SOLj6fcQim0Lhxqih/oLOw4EN+Y1UrbJNSTLyEAa7W5qlUpQhZQp72FehPcHFF6UOILttTClpSuhO2kDu71tPfxp6v/FKRX65dAjfPs6s6qQ3A+kqxL2cXnLzuvksTc3Vr5UggfXjqDNKekLf8c5n1//iYliEw6ogXptQON/Dxb888y1SbVxwq0F7F/36xWWPiImaonJqjBeenqdi31yd/u+ywh/dEkkfqLtXABrkvdBdEGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+SoVSSw8plixkKF93nX724ftorWOafU+fz+WeV61+zM=;
 b=mXUPHjxJfRQHuJYitYJ2fpBgOQcA6NdNu1XaIoIY8sNor5cwaQPx7zfW3Ou9cLTYYO+ZN8rNgR2jMQwQJSzACgJAsDKPjymjH0AVXgsbrZV1aIz+xxeLhXA+pqcvov0Bn0j7e8AHozV/zrCL0MCCdjwg1x8dy3RnbwtamBnpzOvvMsMlFamnRXpGJwqQfU2sxt9H+wq0Sf6gIAhEn7Fids99Lmhr5zA8CE0OwEEf8O7AkWrS+ELbnCCqBki695LRieG1sTRj4uGVZK9Kb1oQ8xCHyp37nAaEfZkWFAhFoc7ZoJasO3DaR+QRXtONCdMNIws4Vf7dC5VuSt9uJTRA8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+SoVSSw8plixkKF93nX724ftorWOafU+fz+WeV61+zM=;
 b=K3ReZtrJpYPPnMffMNv04djAyatp2Wbr+Q0sYuHPKnb8p6oo1qXw3xkW9AtF3B2KDdgqYHewloJQnrVjNp7beHvkzhvcz+Bd8iJKiOIZHH5bmiieOg4Wc8kYmfAlxLbDU8dRdl9T5k1imGa3pSQfCN44g0lL6BPagib5S9BXg0g=
Authentication-Results: google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=none action=none header.from=prevas.dk;
Received: from AM0PR10MB1874.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:3f::10)
 by AM8PR10MB4241.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1ee::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17; Tue, 9 Mar
 2021 22:39:50 +0000
Received: from AM0PR10MB1874.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::58b2:6a2a:b8f9:bc1a]) by AM0PR10MB1874.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::58b2:6a2a:b8f9:bc1a%3]) with mapi id 15.20.3912.027; Tue, 9 Mar 2021
 22:39:49 +0000
Subject: Re: [PATCH v2 1/2] init/initramfs.c: allow asynchronous unpacking
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jessica Yu <jeyu@kernel.org>, Borislav Petkov <bp@alien8.de>,
        Jonathan Corbet <corbet@lwn.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>
References: <20210224142909.2092914-1-linux@rasmusvillemoes.dk>
 <20210309211700.2011017-1-linux@rasmusvillemoes.dk>
 <20210309211700.2011017-2-linux@rasmusvillemoes.dk>
 <CAHk-=wiK_0RATa3AnRSODtSN2X5Cc0RfudLpr16aLhwxoU1yEA@mail.gmail.com>
From:   Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Message-ID: <9cf7863f-742b-1cfd-1027-04e314467e01@prevas.dk>
Date:   Tue, 9 Mar 2021 23:39:47 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
In-Reply-To: <CAHk-=wiK_0RATa3AnRSODtSN2X5Cc0RfudLpr16aLhwxoU1yEA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [80.208.71.248]
X-ClientProxiedBy: AM0PR02CA0126.eurprd02.prod.outlook.com
 (2603:10a6:20b:28c::23) To AM0PR10MB1874.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:3f::10)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.149] (80.208.71.248) by AM0PR02CA0126.eurprd02.prod.outlook.com (2603:10a6:20b:28c::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.18 via Frontend Transport; Tue, 9 Mar 2021 22:39:48 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 99180e08-e74c-4ffe-c446-08d8e34c3f06
X-MS-TrafficTypeDiagnostic: AM8PR10MB4241:
X-Microsoft-Antispam-PRVS: <AM8PR10MB4241DD6675DF05B92933032B93929@AM8PR10MB4241.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9QeazzLqpGrSdtj4G5+4+vgL/PEDzIHBiNeWgh02nS2Cwbo9d3j/OUuVSJtV4JqMimYpji2r3C0XTyJAexxBdyWGcdf38III8q5jMFyv41ZfyXR5ooTpmmvqAxeNrdTAMgjQ3VF62hxQTHylIjEfnFa1S3Mew2yboqU7vnVwqYO/lZGba42B2GnjPtdKjCRPjJxp3ZtvUgUD94w5H3on3Rj4p0b9lPkBNcRUi3sgTxiPegLAzUId695BACZwgv6tCjplV9x7NWlnboO8Gyjcy/dIjVJynUjMYvkofTiWetgHdT8IC7NsQZOFc7mtCDFc+heTyPQDKN0JBm6lD+ewsScjzZKjPh9CrQShizZU70mRZD7awnxXaNtTtwO2lqz4Pw41amz8iVEALhik+gLFgVqTNi3DjxbmkOnzqxzq34QYrtFrVN+zZX82TtgFX6XW61xWbSo/scChKiUG14kZzi2AyS9Vur2RP3JOQNVoAsv3gO6i9C0HM8Qs22O0AwyzX4NrWNOdMm+qS9anPezg46Pjlva7w2EbiaP8DRFn78CcaJ4eWmC41c3iDpYs+q7H/+SZzHERGDDiCLiigVr/zHnhyzn7It7QttCZCxZc+7EdT8PTweMe+BJut9n8XsnKfLREIAZU/66IxnX6EUvcQEfJ69FeIOKzeyG7dLpVPeE3Ouw4jNPWqDdBjoQCTNdl
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR10MB1874.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(136003)(366004)(39840400004)(346002)(396003)(376002)(52116002)(478600001)(66556008)(186003)(2906002)(316002)(54906003)(31686004)(4326008)(66476007)(53546011)(5660300002)(110136005)(86362001)(36756003)(16576012)(8676002)(26005)(16526019)(31696002)(8976002)(8936002)(6486002)(2616005)(44832011)(956004)(66946007)(7416002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?QkRYQUl5ZVhuOXhYU3hlaUh4SW96Tkh2VHZnUTZlVVJrenJGQWlvSXczTW5T?=
 =?utf-8?B?MWllckZkT2NVemdjekJZUHpnSDNkSUdMK3poVGp2ZW82R0RNN0dEMUxvZGNZ?=
 =?utf-8?B?RzAyM05ueDIrYzk4dGZqdFJNa3k0Q1Q2bjAxRHM2aEQ1ZThIY05xaWpDNzh1?=
 =?utf-8?B?L2hRbWUwK0NEUUVnaG5QUGF2bm50a3ZoYWJwclRHOGNLZENXZzF0TjNkYWl2?=
 =?utf-8?B?VjFNUVJzOHJJZ2wyQnphb3MzNHZLOFlkZVpiU1hxRWhVSVc3a1N6bTB2ZkI0?=
 =?utf-8?B?V0cyZ01kRGJ3akZnU3RoTXFQdmhrVSs0aE9xOGUxQVhCR2E5eDBuK3JmNzdm?=
 =?utf-8?B?Mkh0alVRdTdDc1dVUmt1dW9lcWZiUGMvcEt3d0JQUlNsRHhSV0JWL1JuNEpJ?=
 =?utf-8?B?YTdDNVJKUll5WWQxeC9RTnFSRkNGK1BUbVBpa3ppTTljUnZGY0M1a1ZTL3FH?=
 =?utf-8?B?dVZqc2tEc09Xbkx4bnFVMVR1L1FabkppTjlseGVCYStKMk9VWXZsV3ZScE9P?=
 =?utf-8?B?UVR4K1hNeFhRd3c4Qnd5L2E0czhEZm1BbXZ1RFBzZjFaMTQ5bVhGNVVPVzk0?=
 =?utf-8?B?RVo3WGtjUWcyRjl3YkRQcjBSUzRmRER2bTZuSEFKa1owRmNZNmxYbWlGb1dq?=
 =?utf-8?B?MHRtNlBxTmFNK1IxRU1LZWtsWFhlbTR2Zyt2akhTTERzR0hGTU1uY0FkWXhR?=
 =?utf-8?B?em40UDI1MVdYY1cxUndOQ3hzV3BMTGVqdmFVWXVCaWlyUW82MmZnS1p1S05V?=
 =?utf-8?B?eFo2UGhCcUJndlJuaEgweTVDTS8zT2NlOHlGZnRwMzRhM05HM0RPWTA1S2dH?=
 =?utf-8?B?Z3B1cmc5eWREOEhCdVhqSzh3VkZtcGswak54NVhkWW1Uak9FcElYSi9CR3hw?=
 =?utf-8?B?T3RGL1d0K1dDY3JxWDF4N1Evb21QZ29UN1RWd2lmcXYyaW1NYUtydHFKSUFO?=
 =?utf-8?B?NHBtV3RhOE9QQzBkZmw4aU5aVzN4Y0pMUzEyWWhDSkhNWjRITi9WYVZJVmpE?=
 =?utf-8?B?N3YvN1BWNU1UaDdaN24yejlvZmc0aU1VdDhDUUREbWk3NnVSSXo1TEMyOFJa?=
 =?utf-8?B?SlFTdmR0YlhNSUR5UFIwZFhsbWNiRU43MGpiSEtqMzhhaWxUbUNraFRkQy9s?=
 =?utf-8?B?SFZFOXE4am5WdVpiT1MxcVF0RFcrZlRsUmZXTmswYVNTVENYWFBiQll0a0hu?=
 =?utf-8?B?ekNRcnUzMDFsNnp0OGw2SGZJYWNuV2RMenlCOUE1Y2UwaFhFUlA1YW5vdzJV?=
 =?utf-8?B?dEUrVnF1bitQWUZpbjNFc2c1bTIrenFaZHd1bmE1dFhIaDcvcWNqd1I5U2hN?=
 =?utf-8?B?NU5WaXF4ZTcrano3ZkJzYTI0ZHZ2UkFjVkNqOGJ3YkJqcHIyejhHd0t0a3M5?=
 =?utf-8?B?Y0VadWlZaTdGOTRnUDVSU0xNMUFlWVVqejV4R004REZVbFBuUGRPaUpleDV2?=
 =?utf-8?B?Uzc2djgvV29mbHlmU0dnMDl6S09XYUF4MHNnd1dna0dWdTdvTEkrS0xEM2RL?=
 =?utf-8?B?SC9rdUVpQW1XcHJnUEFFbkhHK1pSNlVtOGp1RU9QQUwvNXpqMjliQ3VZYXVC?=
 =?utf-8?B?SHFremQvRW1MMnErNk1aREY0RFpPdlhpajZTamtyc0laM1gwMC9od0cycmJB?=
 =?utf-8?B?VHhLNzJXbTVKL1VJOFlTQ1dyNGlsd3dKamwrcWtsYUJaU3NqS2xFN3k5Q2Zl?=
 =?utf-8?B?RnlFUVdNYTFocXVNTXc2bUdXM05xTEg3SkVKc0xWSGhHTGNaRm1RTFRNYXFT?=
 =?utf-8?Q?ljdAJiOoX9bn9gnfzJIHocNL1bePlbE9LuD1Caz?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: 99180e08-e74c-4ffe-c446-08d8e34c3f06
X-MS-Exchange-CrossTenant-AuthSource: AM0PR10MB1874.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2021 22:39:49.8166
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xWGFBMZS4n0oy6nCaJF/cPQdm5hCPip5MfocDMJ7B63wteebMLs8Re7nhq78lWFJrfFV1hCckD2GNS62xLnXmbNKRtwFamJuboyQHeFCNss=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR10MB4241
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/03/2021 23.07, Linus Torvalds wrote:
> On Tue, Mar 9, 2021 at 1:17 PM Rasmus Villemoes
> <linux@rasmusvillemoes.dk> wrote:
>>
>> So add an initramfs_async= kernel parameter, allowing the main init
>> process to proceed to handling device_initcall()s without waiting for
>> populate_rootfs() to finish.
> 
> I like this smaller second version of the patch, but am wondering why
> we even need the parameter.
> 
> It sounds mostly like a "maybe I didn't think of all cases" thing -

That's exactly what it is.

> and one that will mean that this code will not see a lot of actual
> test coverage..

Yeah, that's probably true.

> And because of the lack of test coverage, I'd rather reverse the
> meaning, and have the async case on by default (without even the
> Kconfig option), and have the kernel command line purely as a "oops,
> it's buggy, easy to ask people to test if this is what ails them".

Well, I wasn't bold enough to make it "default y" by myself, but I can
certainly do that and nuke the config option.

> What *can* happen early boot outside of firmware loading and usermodehelpers?

Well, that was what I tried to get people to tell me when I sent the
first version as RFC, and also before that
(https://lore.kernel.org/lkml/19574912-44b4-c1dc-44c3-67309968d465@rasmusvillemoes.dk/).
That you can't think of anything suggests that I have covered the
important cases - which does leave random drivers that poke around the
filesystem on their own, but (a) it would probably be a good thing to
have this flush those out and (b) there's the command line option to
make it boot anyway.

Rasmus
