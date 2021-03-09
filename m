Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0DAE331FFD
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Mar 2021 08:39:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229900AbhCIHjU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Mar 2021 02:39:20 -0500
Received: from mail-am6eur05on2114.outbound.protection.outlook.com ([40.107.22.114]:40321
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229701AbhCIHjO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Mar 2021 02:39:14 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N0CijloeiolaZtLrv4zilH+03mXuL7F4uBq3INNUzE2V3DP2NjP/nhHzQtYUAr0kfC+qZGtBsitFkM6Yskv4h2lvAQ9No6TNAw+BHp0XnWYERRt5E4WKxYSzL5jQVHMtNxzpDz6aLJ2xlc24omZdBCjT6rXeSP+KhrVbvUsMvIvGNgpsfIHyUmfpmGIj5+D1vQT2luI/dx8Jz0OoTY2VlMCRaDut2YWe6w3RSixy09thJmbMJ8gWChma5hNTT5WjxW9nZbxGlsZZ8bzOi2A+LTj8s4lGadsp+XcWy7JVByfqmipQjVGQkhcKHMUOExAJTOQp8FRfn4Bzoz5HAuTKkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TCNPoNiXYRiEMcAhU55JndX0LCYWyV6xCV80CC/LEvk=;
 b=UJkWdXOmw8Q7RnKCfRzbmHZjItmRrnYquDO5k4BmEbexRxNahKQSbvpkQd88G6zej/iGwAyXSgjZeeRB80jNM/LeAQ8d+f3i5JYsv3TftEdR8FlCEapoJ6bojJZDXEFtoR7bEeDGG/6pa24AdSmif5tZxlLRAnwYCn6/6NbgScMAaypZ1D/iHf5EbGVuxAqHfydeRlqj8lzxZBLsqYQzsb3fRjQbP52tJ+CP9Tbda+a2rXpe/zfiGt9Z+0IWikY47AeLP6dowX4kors6haq3BYFc9Sd9wRI9VbLDLZGi3pvyfiHiEsY7Dax0fLVkJuTumLtuXXYyO4k2FWN7ybOQ0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TCNPoNiXYRiEMcAhU55JndX0LCYWyV6xCV80CC/LEvk=;
 b=OQqw6YOTq/vVMuu+igDCtXmPlbcHpYMh1G2pP3ZS7He9fwNSfvVwUJSp2nN3d+XUdHnWw0ohIS/ZOG6adG107sC1UfOdciKU87XXGU0bdwBZJjCwpG4OviDOuTz/pI5GrRSgzEFkrfyVu8M/MEFD+TWBcov/ZxD6tEw9FnG/yak=
Authentication-Results: roeck-us.net; dkim=none (message not signed)
 header.d=none;roeck-us.net; dmarc=none action=none header.from=prevas.dk;
Received: from AM0PR10MB1874.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:3f::10)
 by AM0PR10MB2819.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:127::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17; Tue, 9 Mar
 2021 07:39:12 +0000
Received: from AM0PR10MB1874.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::58b2:6a2a:b8f9:bc1a]) by AM0PR10MB1874.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::58b2:6a2a:b8f9:bc1a%3]) with mapi id 15.20.3912.027; Tue, 9 Mar 2021
 07:39:11 +0000
Subject: Re: [PATCH 1/2] dt-bindings: misc: add binding for generic ripple
 counter
To:     Rob Herring <robh@kernel.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>, linux-clk@vger.kernel.org,
        Guenter Roeck <linux@roeck-us.net>
References: <20210226141411.2517368-1-linux@rasmusvillemoes.dk>
 <20210226141411.2517368-2-linux@rasmusvillemoes.dk>
 <20210308172153.GA2505339@robh.at.kernel.org>
 <12be138b-631a-4f82-aae9-6bbdc7bc2bcf@rasmusvillemoes.dk>
 <20210308213834.GA2973251@robh.at.kernel.org>
From:   Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Message-ID: <11a604cc-6f81-7d26-06a4-3e338b051c5a@prevas.dk>
Date:   Tue, 9 Mar 2021 08:39:10 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
In-Reply-To: <20210308213834.GA2973251@robh.at.kernel.org>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [80.208.71.141]
X-ClientProxiedBy: AM5PR0201CA0006.eurprd02.prod.outlook.com
 (2603:10a6:203:3d::16) To AM0PR10MB1874.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:3f::10)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.149] (80.208.71.141) by AM5PR0201CA0006.eurprd02.prod.outlook.com (2603:10a6:203:3d::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17 via Frontend Transport; Tue, 9 Mar 2021 07:39:11 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8f0e3077-9a19-404a-d939-08d8e2ce6e57
X-MS-TrafficTypeDiagnostic: AM0PR10MB2819:
X-Microsoft-Antispam-PRVS: <AM0PR10MB28190F52E22A7F9339CBD80593929@AM0PR10MB2819.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vXk7N96OoClVEGQMC+nDPK9gFkfuOGFFbaaN4WdRktjje52C9U+x56EWZnAEoONQVg/hkdt6f18Xa2OlU8S537rSYRDXS0wN/EZuJ2rW1X5WROplWQhmoQviiUPuPSlyvQMn4d92MsWTm4L6F6SAVRg3ORcgQxpM7xer3kVumzYgufeXPoqkAtIvWUyKurdUf8GE34wIH8ncv2lq/5m00fV2iQ/RpT4E+aPXguzZVFknfKTx1WpTBfWhcHdwcq/CpivJJhLr8hGAwkP6QnAglbs9f5BQX3HHCxJUZ294RbvMGgpfuJvyblf7cHCWjaekb1nB09Mlf9nfE9VFfAbxOvcStPaUQY1nglE5VbAbl6uAvjLWDIbIMR4KaYyWH+jxTAU2gQWWpidou/H8HbAYT+nWzhtKvDeIH7otCdIBUWWPL/tV+QaKj5gWkfkhamswIU8PDjM5wo5ZGE/t6lMXHUCavSXuj8eb0qDWocAlTobREvsFEOuvSQOpmHlzqysSKOx0qB0le0nmW2g8oPqDUYFD2vJboUpOafDEL13bVtSVlTNLbKwO1qixOsm2XSGpLSUMnz1kxrcoAjAWWDFpCewtz/kZZUvHJqaVbmByoFvsLTe2vjfapO2kwAUGtUkTN3730gOT66/5KOxatNawOstgSonV3IjJBM1zQDwCRLfj1tY1PS1Wofen09dCoDsK49j5osINLA556LS6LPkL8Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR10MB1874.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(366004)(346002)(396003)(39840400004)(376002)(136003)(52116002)(2616005)(54906003)(478600001)(66476007)(966005)(4326008)(2906002)(316002)(16576012)(44832011)(5660300002)(6486002)(8936002)(8676002)(66946007)(110136005)(31696002)(16526019)(8976002)(36756003)(186003)(66556008)(956004)(83380400001)(26005)(86362001)(31686004)(41533002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?Windows-1252?Q?TOukCCpE/cHa09Hf9CXurgbSlA+N+6gqfXrEPTlAeIq5gig1psQThlcq?=
 =?Windows-1252?Q?dxJPhc+qpTwBXbVIQ9Y3SOtWR/bfZq7eJPLjTgBaC64pPe8MfM31kwFE?=
 =?Windows-1252?Q?V4H5D3mp5oSantJF/8cMV8RhGbqsLADEJqPKbTs7xjuUXxMyxf43wLeM?=
 =?Windows-1252?Q?jnHY4m1iz6eU3318dv+8NRPAm1FahD+uz2PUGmK+usG6Cw8SA3uK35n0?=
 =?Windows-1252?Q?xF/4rYH0fnE894rXOtdeuANS2LCNOLCOQMxWoW07yad/99bC0KvJgewo?=
 =?Windows-1252?Q?JM5V48bzUBx4SqSs0QTTQX0jmbPsdVwxwad/0eMsnLotAAWBqxNiqPON?=
 =?Windows-1252?Q?JI97i7hYqL1yn/SVp4mbNCmc4/QGxAVwQEDIwxnIK5SzVfU2xJ5b6Ic8?=
 =?Windows-1252?Q?s5E59Va76TMklMFuEqPhFA2WHy1a4hdfs8K6o97V89+ICONG+3hdB7Qs?=
 =?Windows-1252?Q?Qr0tBxMEPzKqzFBW949HmiCvY9xbm3YViOetZ4T/XCqI77YYeIv/qjWK?=
 =?Windows-1252?Q?kiIG8zjWZeepkGpz+29ciSp8rSFv4XQAFUI0cLP5kHeXHGaxYGltiCAr?=
 =?Windows-1252?Q?2Eg32uocgMXk5wiAQgQpRfEDOquHOrXlDazu9Vi3fd27Oa7U8R0QsZdj?=
 =?Windows-1252?Q?Di+Y0278qDm1l8qGLHoIKmyMT64H5s6aIAviXqCmx6+Wd4QFJfP1w5cK?=
 =?Windows-1252?Q?ktQFUJiCVajdy1iax0EbleSyYiDF8CsOZFwBLBYypirkX2G0u4kndKK0?=
 =?Windows-1252?Q?eulF6xsylLQjjIHQYorcV4hY9Sfv2Z3/CG5DdlUZsiFAW3b4FJLmKHeG?=
 =?Windows-1252?Q?wyS4cNZ3itlWKOOoM5OsQwsLI89XGVt749ro1kDKTbuKAidK5HjXwSI4?=
 =?Windows-1252?Q?9hq93pUjTA1U4w0QLI6KCoK19o4CQAIQDQwNjTb8lIntRSEleXgSldS4?=
 =?Windows-1252?Q?s2cdQvTx41pzriS0vdsQ5jOVOqc0xdXvKve/+f0IqYJMW1I9ViIU+dKV?=
 =?Windows-1252?Q?sHkBxwBOrN2Fgdthwz5IPs8+FnA1feTYOzuGgXCOvd5VPy7BHcva04cC?=
 =?Windows-1252?Q?4CD+wTAQs5ozbuMZuFu0uqa80igNePMCVntPyl/n61dv8zD2ysBd0qa3?=
 =?Windows-1252?Q?sP07cKa5tKDCFTMp03y/Ig21YSfDbRTiUFXf4yiUu+XZoVVwULXym1P1?=
 =?Windows-1252?Q?ZO5j1KuLrhSZv57/YWkcD9UDpbNOtlXoRpAIXp7HRK2b5vx5PRh9nfZD?=
 =?Windows-1252?Q?PflYRW3bzeC/bgsrD8CDLxTnryoubzOciCA6aKHO+TO/AP6r8SCgBsNy?=
 =?Windows-1252?Q?j/HwIMGffiAGEwucOChhXJtifK6FBmkg0r0GpVQy6+Q7cKXScUSJwNMN?=
 =?Windows-1252?Q?sqqJ/Q1OUm95dxwnC1/6O4wPFFinpaAIumNq/OE8O/Axug5v923+Gkn5?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f0e3077-9a19-404a-d939-08d8e2ce6e57
X-MS-Exchange-CrossTenant-AuthSource: AM0PR10MB1874.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2021 07:39:11.7625
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m1pfayS2Dk8Jm8x0fnbfwgB6FhP7wVKL4DC/Hn2neqoxw1CxEZH9Wo3URL5vf0Q2K7s9Bra+DQK2s0Q/jI6M3viRfby1pKI8ovzNPqfGINQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR10MB2819
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/03/2021 22.38, Rob Herring wrote:
> On Mon, Mar 08, 2021 at 09:02:29PM +0100, Rasmus Villemoes wrote:
>> On 08/03/2021 18.21, Rob Herring wrote:
>>> On Fri, Feb 26, 2021 at 03:14:10PM +0100, Rasmus Villemoes wrote:
>>>> While a ripple counter can not usually be interfaced with (directly)
>>>> from software, it may still be a crucial component in a board
>>>> layout. To prevent its input clock from being disabled by the clock
>>>> core because it apparently has no consumer, one needs to be able to
>>>> represent that consumer in DT.
>>>
>>> I'm okay with this as it is describing h/w, but we already 
>>> 'protected-clocks' property which should work.
>>
>> Hm. Unless
>> https://lore.kernel.org/lkml/20200903040015.5627-2-samuel@sholland.org/
>> gets merged, I don't see how this would work out-of-the-box.
> 
> Hum, no really clear what the hold up is there given it seems it was 
> asked for. Letting it sit for 5 months is certainly not the way 
> to get it merged. Anyways, that's the kernel's problem, not mine as far 
> as DT bindings are concerned.
> 
>>
>> Note that I sent a completely different v2, which made the gpio-wdt the
>> clock consumer based on feedback from Guenter and Arnd, but that v2
>> isn't suitable for our case because it post-poned handling of the
>> watchdog till after i2c is ready, which is too late. Somewhat similar to
>> https://lore.kernel.org/lkml/20210222171247.97609-2-sebastian.reichel@collabora.com/
>> it seems.
> 
> Now at that one in my queue... I think 'protected-clocks' is the best 
> way to avoid any driver probe ordering issues. It's the only thing that 
> really captures don't turn off this clock. 

Agreed, and I did start by looking for a generic way to mark the clock
as either "hands off, kernel" (relying on the bootloader to enable it),
or better "make sure it's enabled". The closest I found was
of_clk_detect_critical(), but the comment above that one says not to use
it, so adding a call to some random RTC driver to support the
clock-critical property just for my use case didn't seem like the right
way to go.

I didn't know about protected-clocks until you mentioned it, and it does
seem to be the right way to handle these situations (which are
apparently more common than I thought).

The ripple counter binding
> doesn't really capture that or what it is related to.

Agreed, it was a "hail mary" and why I explained what I was really
trying to achieve in the cover letter.

Also, the
> ripple-counter driver could be a module and you'd still have the same 
> issue as v2.

Well, not quite. First of all, for a board like this, one always uses a
tailor-made .config, where one would never set that to be a module (and
even more obviously one wouldn't make the gpio-wdt driver a module).
Second, it wouldn't be the same issue as v2. Rather, if the clock only
gets enabled later when the ripple counter module would get loaded,
there would be a period of time where the watchdog was rendered useless
- the problem with v2 was that the watchdog wouldn't be petted in time,
so the board would be reset before it booted completely.

>>>> +Required properties:
>>>> +- compatible: Must be "linux,ripple-ctr".
>>>
>>> Nothing linux specific about this.
>>
>> True, but I was following the lead of the existing gpio-wdt binding. Is
>> there some other "vendor" name one can and should use for completely
>> generic and simple components like these? "generic"?
> 
> Most 'generic' and GPIO based interfaces have no vendor prefix.

Ah, I see. Can we add just plain "wdt-gpio" to the gpio-wdt binding, and
deprecate the "linux,wdt-gpio"? It's a little awkward to handle a
"linux,wdt-gpio" compatible in a U-Boot driver.

Rasmus
