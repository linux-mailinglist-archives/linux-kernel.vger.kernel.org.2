Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A84B339E20
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Mar 2021 14:14:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233680AbhCMNNb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Mar 2021 08:13:31 -0500
Received: from mail-am6eur05on2122.outbound.protection.outlook.com ([40.107.22.122]:44513
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229615AbhCMNNM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Mar 2021 08:13:12 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bdBozgC8gQn4svIqe9XeyUBlGDsQbWpe2E/aedx3JVqIS802ac9dvc28ufwiqA4hovxr7cKhRmfRJtezBy3oHvUgNmcqPJeEs3jRjGW98i11RMjbbd3FUxk9N4S+TRv0sl0UOo0yV+RWYUq38+gejXTDolcPEkLVUyQFhQ/Xv4vqhID4MWL5JS8+3UrCGqnQ1txUSWuYkkR9mP4ZGTxpC+cYaTAW8yoAZlq39571/LeR13AyziwVXizhrJjO83g54347S3Rf5Y/lrPcPoZ7pztLIJLd4aht1Z0L1kUGcb6SOx0gO/EIe9diOtdA8hubO9lJ9PGJUrmtifyfhP3Zb/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g758mwFYZkiJ1TW2rI8ywdTOp0suHlkiA8R0ghEkeXc=;
 b=OwyZDXfpZHNSHL+16D4EoGdxg+eMCLCYW8rEKEqZUFJWIfVsuaSpMAkNxYNH61sPZIhM1gufS486mMwdQyFU/BTnFNvDBDGEp131FNpJdxZh7GPTHThwii/jbEUqRMvBZM+MCXRc8Tt+Q83BTWUD0DlOqnpmz7QzNF11ViZpSz1trnfGqsu4RcvX15ceKsnBcq78DB+2Iwh5NcDa/ketsov/DxCL8Mu7Czj2Z4vR7jptyaK2Gh3XST6/JD7M91cEg/FoUUbRg0pNlr1wC9bN27tFD3hBCLUDo83pQ7qPW/TcqUVgykxk11PEbMm+jm76IvotiTaabILVA0sbMkgxOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g758mwFYZkiJ1TW2rI8ywdTOp0suHlkiA8R0ghEkeXc=;
 b=NTmeicCyujX5dYlBrK7fEOe+utcokBhJLvi1wZJ1kIJPNgelkO7kXdtx4IupdeX1XA+d0EyWdKWXSWikQhL0dzsERACNQg78jENwzvTqk5egO7mQnnC8U5/yMC6gQhFiWH6n0lbJEF613Sv/GbikXAnCf75XWQUplEt3shCp0aY=
Authentication-Results: google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=none action=none header.from=prevas.dk;
Received: from AM0PR10MB1874.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:3f::10)
 by AM0PR10MB2628.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:12f::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17; Sat, 13 Mar
 2021 13:13:10 +0000
Received: from AM0PR10MB1874.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::58b2:6a2a:b8f9:bc1a]) by AM0PR10MB1874.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::58b2:6a2a:b8f9:bc1a%3]) with mapi id 15.20.3933.032; Sat, 13 Mar 2021
 13:13:10 +0000
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
 <CAHk-=wgfMQyYSkdRkCuHOQEcvoyw=fN7q+0cU-s9dNqDHkSmrw@mail.gmail.com>
 <2a33d478-b7a8-5b3c-7bc5-f33eb27b44fa@rasmusvillemoes.dk>
 <2a8c6ceb-9dda-f8b6-1a96-6e75dd3b4eea@rasmusvillemoes.dk>
 <CAHk-=wjiNDC9QAnVGS9w9enXiErHJLdm6982VJAZFmNoPH-AEg@mail.gmail.com>
From:   Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Message-ID: <91cbb883-661b-8772-bcb1-4079a88bb324@prevas.dk>
Date:   Sat, 13 Mar 2021 14:13:08 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
In-Reply-To: <CAHk-=wjiNDC9QAnVGS9w9enXiErHJLdm6982VJAZFmNoPH-AEg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [80.208.71.248]
X-ClientProxiedBy: AM3PR07CA0078.eurprd07.prod.outlook.com
 (2603:10a6:207:6::12) To AM0PR10MB1874.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:3f::10)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.149] (80.208.71.248) by AM3PR07CA0078.eurprd07.prod.outlook.com (2603:10a6:207:6::12) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.10 via Frontend Transport; Sat, 13 Mar 2021 13:13:09 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 93d025f5-5061-4f7a-6d81-08d8e621bfa1
X-MS-TrafficTypeDiagnostic: AM0PR10MB2628:
X-Microsoft-Antispam-PRVS: <AM0PR10MB26281FA25660D4D007D00E87936E9@AM0PR10MB2628.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vc4dSj4Qs7mfpexQMi/jOPEH+48Q5ZfzVuZfHOjgw/pUw+1ZbOA/RgOHjoQWs8vZjXEChdVisR4LoVEb4+fMjzhRj8Ua5PAGJzyxqut6cijYqeqpBgIfKAma2sx1QF2nBrrxYKKWDGwf9cZJ09XQdKlAtU5X+GlXI8L5ez1zfTDRIM7H/GJiI2h1KBNuC1Y0eu1NQghBvEplyFfCogVQVDpUWs1x39/eAwR/YgAy8fVmeVgjj6kdr6/dxpJjtVLrh+it+nAVI7/Uwc7AKhk/xLmKUEm7zwOhi1850G8P0I+lIxS+WAgaaXiNJCfYjjvKCmvysqEYQ4ERK5ViQir7IaiLuTJTRE2JwDxNRv9LoOfxQ6yvd/C0g3JPyZ7jOKcQJY6xMQFZKeRNR5JDfTXjM9eVxZHsCruDO5jPa4Ohe1AhLvktbRS8DA2czqDLqQ7HODb1ROCkrA4dBHZqHgkGiUf1+OFDJ1Qftiv99yTn2eX1l8zQCpwRro7NycouLKOi+rTllH2t6b6mhH9E/MbnnRxtDVnUO4pqukSIzTYrGqpc7VwjEk61OwO9TYCc/BX1VvH0xvFjW8E8+R8njUXeg5xitVyhBkwEnFNcdkDHPSU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR10MB1874.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(39830400003)(376002)(346002)(396003)(366004)(136003)(7416002)(8976002)(31686004)(8676002)(8936002)(16526019)(36756003)(44832011)(4326008)(66556008)(66476007)(86362001)(478600001)(956004)(316002)(53546011)(54906003)(5660300002)(110136005)(16576012)(26005)(2906002)(31696002)(186003)(6486002)(66946007)(2616005)(52116002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?RW5uMjVlejluRlV6QlltWTBRNjVZbVpYaWtTekpUejdGMnoxQTMxWE5TRS9N?=
 =?utf-8?B?WDZMeC9kTnVzeXgvU1FDdkgzMlczQmFqeTlPUmNzdDJNeHlSM041ZjQ5YnlK?=
 =?utf-8?B?Y3lDR3BOd3hXcFRDZ2ZUUXJsQ2d2OEp0MHJRdENUZkUreUhIdWdIdnNvK292?=
 =?utf-8?B?WEg0bzBJcE5QZ28yK3FibUxyWG9aWlQ2MTFCSGI0c0s1cktDWmt1ZGpXTVM3?=
 =?utf-8?B?c0tzcVNPYW9ReDYxMnJHTUlpOGxGbWFkOHdOUnV5K3F0VUFLcVZaaWptdXFj?=
 =?utf-8?B?NWwycGxKNEpGRk85c2pzdDJCSW1mLytEVEJXYkJib2RJQVQ3UlhFd3FRQnBp?=
 =?utf-8?B?bWsxNWw0MDlwby9zSnhzd1JUU3p2ek1VV1NTTklOWVFnMGxZV1Q4L3pEWXJM?=
 =?utf-8?B?cmFUaGVDazZpZlRhREVLY0JyWmNBZXo3bDRXeURKWkRUZVlMRmRuRzhSUWVk?=
 =?utf-8?B?YzM3cjVBSXl1eGVLWFNHWSs0SlNDRUZrZFJzcFJGMGd3VFZlZFpiMDJaMHRK?=
 =?utf-8?B?OVFuN2g0SE4xb1h1bk11RWZ3N2FGWDl1cXdqR2lpaHh3L0dLblBMSS9zV0Yw?=
 =?utf-8?B?TlUwN0VTRWRDMHhuZHBxUXM2WUNpbERYejZQenMzS0dLSytxdDBTQXpQSGdq?=
 =?utf-8?B?V3JyQnhmaDNhdGVIWXFEZng2OFdLNW9lbUZTa1RPZS9GYnpseGx0SUtsVkZG?=
 =?utf-8?B?QTNSZkJIUCtnOGhGZVBTSU45d25UNHhIOFlpMEhMRmd5NkFrcE93K0ttQW9Y?=
 =?utf-8?B?TnErNyt1S0ZlY3lCVHhhSTQ3ME5EV2xRbk5MUWZZM214d2x4bFI3eFpyN01V?=
 =?utf-8?B?NTM2SDBlVFVYMDl6UC9zTUpyZHllV3BjM0dTS3JMYWp4MmZkQnZGQVorSWM5?=
 =?utf-8?B?MGYzZjYrTzhTdWZXeUtoRmVtZG5HT1J5WDRlamdpa1puc0xZb01oaEgzL0RN?=
 =?utf-8?B?Rlpnb3BPZTJmaVJMRVNNK09NeTNEZU5QMXYrOGdWc1o5MnB3RVJ4TUZacllH?=
 =?utf-8?B?RjRsS244Z1FrNGJuc3dzdERJNkZRQzVML0JrODdUeVJtVnltZ2FRZzBDUnlF?=
 =?utf-8?B?SGc2VzVLbEt3SHVBRkdRWm5Cc3BJY0JxKy8rWDB3Q085ZnBMMVZORnhWWEtH?=
 =?utf-8?B?em1HcjdSbTZsandZcWlITUdpZTRCUjYyMGZzNUt6NU9USlBQY2hza0NtcEdp?=
 =?utf-8?B?VW1TcUJnWmhxYWJFc0ZFNS8vdnQ3aWtKcHRXQ0tTOUhISVk2Q0pOWXJyNndL?=
 =?utf-8?B?aWY2OXJCNDgrSEt2ekRMc3U0eHkyUnRiV0R6S1hiUUUxVzhGRmp2WVhQa1pD?=
 =?utf-8?B?NWRGaEh6UGtXSmQzMlRodXRiY3M4a0U5dnN2SkJTdmQ0bUZjR2M3S01rbXEw?=
 =?utf-8?B?c3ovRUtHekNaYllUOEpHWXJFNENYd25MQ2lFbU1JYUFrRHhQdkNXeXRYdngr?=
 =?utf-8?B?K09HY0piVkt2T3IvQTVXdndyVExteWRGZGc2aXZhUjdwQlBKczc5NGpQL2FI?=
 =?utf-8?B?OWF6N1hERjdIK01YczRKdzVseHJNMkc0c3JGQmYvU1c4KzF5azl4ek93bDg5?=
 =?utf-8?B?RnVYWldtbEMwR01oZTJoeS9OenN3RTBROUxuK0hycUdXakloMHVxZWFGbDl0?=
 =?utf-8?B?bEc3R3IwN2pqSUxMbkVKOW1LTXI5VWo3M0xrbStWc2F3d2VpQnY2akNkY3N6?=
 =?utf-8?B?Q1hsY3lYanEzdnFiVnVwaXNic204WHN5MFhLOE0vN0lZY0pvZE9GMklzWFRF?=
 =?utf-8?Q?QTJvWfiuFz2CJtWhNAA7JKhjwUpSKMrtc2pXtPu?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: 93d025f5-5061-4f7a-6d81-08d8e621bfa1
X-MS-Exchange-CrossTenant-AuthSource: AM0PR10MB1874.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2021 13:13:09.9440
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dynoxCoBb7RUDv1spalbvT8CXdVleCAMD0vgJunSeduODpqSivjl6pzgDVDh51ZFHFy0UfP/ZSA04aoJTde9NThjUrApyV/xh5U0HWSleuA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR10MB2628
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/03/2021 19.02, Linus Torvalds wrote:
> On Wed, Mar 10, 2021 at 5:45 PM Rasmus Villemoes
> <linux@rasmusvillemoes.dk> wrote:
>>
>> Hm, gcc does elide the test of the return value, but jumps back to a
>> place where it always loads state from its memory location and does the
>> whole switch(). To get it to jump directly to the code implementing the
>> various do_* helpers it seems one needs to avoid that global variable
>> and instead return the next state explicitly. The below boots, but I
>> still can't see any measurable improvement on ppc.
> 
> Ok. That's definitely the right way to do efficient statemachines that
> the compiler can actually generate ok code for, but if you can't
> measure the difference I guess it isn't even worth doing.

Just for good measure, I now got around to test on x86 as well, where I
thought the speculation stuff might make a difference. However, the
indirect calls through the actions[] array don't actually hurt due to
__noinitretpoline, and even removing that from the __init definition, I
only see about 1.5% difference with that state machine patch applied.

So it doesn't seem worth pursuing. I'll send v3 of the async patches
shortly.

Rasmus
