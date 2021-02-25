Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7A18325366
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Feb 2021 17:22:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231950AbhBYQVt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Feb 2021 11:21:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233159AbhBYQUb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Feb 2021 11:20:31 -0500
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on070d.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe0d::70d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE9B9C061574
        for <linux-kernel@vger.kernel.org>; Thu, 25 Feb 2021 08:19:44 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bjfT7gJKQrqBdhL9oQmb7tDKwAe7YN7EV4zhIeJOtw69MHj9QSnjpq4tl/D0PUikipE8fkRqLgnegO2AGF5Quq/rd3FJbuzG+//YuWERfWZosJYrRtniZyjwBdML835aKnnR6rfv4n8i9V2zKjfWY7XTjIp0QUe66mzfAMF/AXX5biLtX82HAahVNx8NplUoA/9JfNttV9I1sqHnPozWj2kCZDas1CXud7yU2K9zu9DwjxGzXmYtJR/W+6s+o/CzMUbqucghu6KpiaCKa+Y+jahdH8Tk0BMglbELYdbhKnKdhhsRTIOW1yowdsfVPhgvyF0llPz+1bI88lb0ElJnww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bFW3NqT3xrfvGegiFlDmbsr58noDI6PkF1W30oQW7EA=;
 b=XTMERsrTDqTdebxbdVzPib2uPZI07idnR41Nu1GrUcdXujzwYpi64SNdxu79FFdlOOP8u68GO/O8M49i49KUmzMmykYefTD2K4lUyxbitr0KQ79PhMWtwRmlE7WH9OZ97xGoeepKnqh7cief5+3XNk1JR9rV8ExdffblxOPLwDw870wh+eedhA9fauVDRsSBuYR0IfWVA39uJ/l0jbfjLbMZPY7FdS9vfHYV1xL8DU08iuAC7Ta3l+IPeot23wQSbbx+m+hVCGmBT9+lrpCD4sQZvXFmjdU0aa5Qc+4NiwYxYCP734oKvmbi7x3sFzKCEZlVIIyvEV9uzmEeiQT52A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bFW3NqT3xrfvGegiFlDmbsr58noDI6PkF1W30oQW7EA=;
 b=ivgL95Na/LfAlgahCh8piPkUkzB45L+dvHl71fF9bPX62E596JfbUh6v0eVBLi+Qei9b+GhmhAmE3HL0oHv/nia7LipwjUe/EpEUu3ASSBEaFF1GAwMZfdICxLKKKzQC2QzJyEttSyjd4MeAeTlGkJsvIKbW3QhQm2Bx+lXxbMY=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=prevas.dk;
Received: from AM0PR10MB1874.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:3f::10)
 by AM8PR10MB4131.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1ca::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.24; Thu, 25 Feb
 2021 16:19:28 +0000
Received: from AM0PR10MB1874.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::58b2:6a2a:b8f9:bc1a]) by AM0PR10MB1874.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::58b2:6a2a:b8f9:bc1a%3]) with mapi id 15.20.3890.020; Thu, 25 Feb 2021
 16:19:28 +0000
Subject: Re: [GIT PULL] Modules updates for v5.12
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Jessica Yu <jeyu@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Christoph Hellwig <hch@lst.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        =?UTF-8?Q?=ef=bf=bcMiroslav_Benes?= <mbenes@suse.cz>,
        Emil Velikov <emil.l.velikov@gmail.com>
References: <YDUibKAt5tpA1Hxs@gunter>
 <CAHk-=wipCbbXswcFvnrGae01H54dY1+XoaL+9YaiU71zGzko3Q@mail.gmail.com>
 <CAHk-=wh8vHL43v7GWK9MWrWitSmOmrEw1B0AJD9CrhBc4FvpxA@mail.gmail.com>
 <CAHk-=wiuoRKa=F3txoVHvnca+H=7gJyL3SFYwd3549v-sa0+QQ@mail.gmail.com>
 <20210223200130.GA8059@lst.de>
 <CAHk-=wj27tmZBzFRTZTAEPd6eRBzP5xCkQM+1cuSx7vzv8K4=g@mail.gmail.com>
 <YDYPWAtoDpyD9D4Z@gunter>
 <CAK7LNAQUL4qEgk97z0WfagVDgGAARzj8hqFyrC2wnPjiLduEoQ@mail.gmail.com>
 <cb28abc8-5c4c-90c2-e3f2-a939ff507a8b@prevas.dk>
 <CAK7LNASv-pWVdztiD1-VCHCnOqZ6j=J6ra5cEdiUkmM9E8fHWQ@mail.gmail.com>
From:   Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Message-ID: <a2d84bf6-f753-92f6-7613-38391e65af85@prevas.dk>
Date:   Thu, 25 Feb 2021 17:19:27 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <CAK7LNASv-pWVdztiD1-VCHCnOqZ6j=J6ra5cEdiUkmM9E8fHWQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [80.208.71.141]
X-ClientProxiedBy: AM0PR01CA0179.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:aa::48) To AM0PR10MB1874.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:3f::10)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.149] (80.208.71.141) by AM0PR01CA0179.eurprd01.prod.exchangelabs.com (2603:10a6:208:aa::48) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.19 via Frontend Transport; Thu, 25 Feb 2021 16:19:28 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ad57e5bf-a3ad-4536-ce3c-08d8d9a92002
X-MS-TrafficTypeDiagnostic: AM8PR10MB4131:
X-Microsoft-Antispam-PRVS: <AM8PR10MB4131990101E89C9B0F2192CA939E9@AM8PR10MB4131.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FiBK4Xdy1Y9Xk78Ei3+TKEyUhtRLtK2TFQBoEnz54UOym68UL/TGKua++ElPPpGxvGB/K0+TRK9FUwaFs+g10Tfea0npX1Nen6mKL0gPipR+GqiyUOqu0VCI/JoDxkGLigh++OtJViHI2+eP1xEUmpk2aAt2hFe7aVZDNiY8UR1HbTpShGG22b3t2fMLUfsmkQoIzZGfrrTFNAXUeTW0XTWlIqiH0CzEKYoYvBY1t53v8/sKYSY+0SvfiWEK2/vxv0WklmU4QCpWOsOcZ4Pe++lq+gkI3oaOB5eailwoJ3gDN7Qyilnnwl6BrvCwt37hd86cc5Ebwv/4HSn6IUySAm4zHcdSrnXB46UYr5R7oOViLi7h/vpgUezO6TbafTgXXUov2Pu+ticocg/WcBD6AvA9vA04RTwj0v1cA0lYsx2TYm8ExYw2qPSpVfoJEhh2meI4t486iS8b3h0e72x8ihQuSWl+xw4/CH3WSTRxt/KRkJ0cOdtTleR4g0enLmOufDBysilYvTabnFyqujYXv4g2QHSNbaWBZdQOv0HhTaMyn4heWZp9nSN8GPx5k8CxmS2z/QQmH0+AbPU98mI3yw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR10MB1874.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(136003)(376002)(346002)(396003)(39850400004)(366004)(316002)(6486002)(478600001)(66946007)(86362001)(26005)(5660300002)(4326008)(186003)(52116002)(8936002)(956004)(8976002)(2906002)(6916009)(83380400001)(53546011)(2616005)(66556008)(36756003)(31696002)(66476007)(16576012)(31686004)(54906003)(8676002)(44832011)(16526019)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?QzZqb3Job3liK0t1UTd2aHgrKzVjRHBzNGhYV2xPSk5abUNZejZiTDJGcTc0?=
 =?utf-8?B?ekN1MHNFVmxjQ1ovRjMvWlJGbUIyRHhmNGhPcUxNdTZoTmErUUZKOFFYaXdi?=
 =?utf-8?B?S1RvWVZsSCtkQlRidjl3VDdWakpjTUNIOGRXczJ5TWNHM1p2MUlOVWRRUzY0?=
 =?utf-8?B?dnpZaU51amlwM25HMjNwNlk5UzBtNjlZZm5EU0QrUUJWOWwzT1d2Zm1sdVFp?=
 =?utf-8?B?b2VuZlozTlBYSmw4R2Zpd2Y4WmdBTFlPNm1QYTNNTkxvU1RITjU3ZU1xVHhl?=
 =?utf-8?B?QzdzVEtFZmNxdFg0ZEFXU1gwM01KLzJlSVR6Q2pwRG1NQUZ1VGNaRzZscVhm?=
 =?utf-8?B?MXVWV1NMYjBCZXYzYXczTUpwM2lkb2hmVGQ2MDBIUFlKbTZUNVFuTmM4dmFo?=
 =?utf-8?B?NkZMVnR5bDhzOUlFOEJTdStxSElmcm82K1hkdEJvRE1TS1Jaczg5b2dNK093?=
 =?utf-8?B?aTZwS1dsWW84RlVPT0dORVpua0RhOFltSmdkMjVjRUJ3Q3NaMWlocStJc2ZX?=
 =?utf-8?B?dWRVT0YrUkwwdDBpNkNYUnlaZTEyNloyOHVJdFpEZFlUTDhObmczbTRSNFdr?=
 =?utf-8?B?NzdTeXQraWNoN2x1T3FTWHRIcVp1bEt0YWUrblkzQmZraEFCYngwVGdxQTF0?=
 =?utf-8?B?K3l2NXhNYm5zVXlQMllZcE14ckc5SU5YeFZNbFQ1MVBDeDFaMkpVNzU4dnRD?=
 =?utf-8?B?d2FhYUV1R1V1MHVqZFk1Mk5zMFBVNmVZYlVTTzJLQ0pBVmdBL1lPVlc2WUZY?=
 =?utf-8?B?RVFPU2NrU3orQ3pNM014a09DeHhuNjd2OUZxa1c2TnhYb2VuTzdBTWFidXJG?=
 =?utf-8?B?MHRseWxKcEdaem9zNHduMHZEUkdQUGlGd0lBWCtoUTVpS2g2YjVIQjZDdkxY?=
 =?utf-8?B?THlwRmQ1SXlNbHNueFpNNitjRUtNNnZ3OXVxa0lCN0lvTVBTTzVWNnFYOXdN?=
 =?utf-8?B?TjcyUHI3WHdJV0VnZk1IeU5ybTRjcVQyZS9Pczd0WXFpZ1htTXJ6bFllWWky?=
 =?utf-8?B?OVBmRzNSeXk0aFp4R1h4N2lYL2ZQakRMQkN4WU5kdGE2bVdMUUZXZzdsekdT?=
 =?utf-8?B?VkFhdGg3SlJDYnRZRzVObW9sWSt0TnNGQ1BTZk50TmpqaU40N0gybytGR3JW?=
 =?utf-8?B?YzJmOG13ZG1CeWtKYkhvVmJXNjZjSzlEK1NqVXROUWxuc0FrRHRNbnBKakhl?=
 =?utf-8?B?azBKUjh5czZ5dno2c3N6ckU1TTV2eHg4SWtFL2tWOGVOT2JydHJUbGJ2MUti?=
 =?utf-8?B?RGNNbjZrNkNBUVdNbGlURVh6NkxoelREYk9JbC9ESUNHeDVyaUxYODJ2VGJs?=
 =?utf-8?B?YmYwellNVy96T2thT3h6UlZUQ1JxQzZ4dU41MEV1b2pZZFpVYmUxZ0hhem9s?=
 =?utf-8?B?aS9VQTZEMXBEWUljOW0xVFgwZzVud3h2U3lXYTJvYWI3WFpkY2ozeFJ3TnhK?=
 =?utf-8?B?dEI1bVdpSExRT042dk4xc3J1bTBIL0NxekFUUW0yeDZXczhGMG9tTHZidjdV?=
 =?utf-8?B?Wi85eDM0Nys0bkVJN0cwNEIyN1Bvb0o0MHdHZ1dRdzQ3eTkydHpUaWhXR2ZG?=
 =?utf-8?B?N0kzWlJQQzIwRjA0dFVLbURuREpvellwUVpnejlBK3lpUTBJYzZpcjNxUTNo?=
 =?utf-8?B?Q3VXTTlEelRkUGI1ZHdkMjRiMEx1SlRtY3lIbHFrODBMZTUrMSsvMEZJR1Bi?=
 =?utf-8?B?SUthMDZSL3Izc05hanZzcTd4Ump1eDZ3NXJYb3l0cFRLYnBPNHdSWGxJdXdx?=
 =?utf-8?Q?HAuzwTj637QYExlOxzCJ5hXRNHVVcMt3LaeZMGf?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: ad57e5bf-a3ad-4536-ce3c-08d8d9a92002
X-MS-Exchange-CrossTenant-AuthSource: AM0PR10MB1874.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2021 16:19:28.7387
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1/e7omZD6TayqFBHi+OTjwMXamojHMrruzOOWkwDy81w4elssppRKKVVY1mOjQiYTGCcYKejdCvrPcku/AjMmJHMWyalNeVTdbO9xoOBU/0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR10MB4131
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/02/2021 16.49, Masahiro Yamada wrote:
> On Thu, Feb 25, 2021 at 4:36 AM Rasmus Villemoes
> <rasmus.villemoes@prevas.dk> wrote:
>>
>> On 24/02/2021 15.40, Masahiro Yamada wrote:
> 
> 
> Good insight.
> Actually, I came up with the same idea last night, and had started
> the implementation background.
> I needed sleep before completing the patch set, but
> now it is working as far as I tested.
> 
> BTW,
> KEEP(*(SORT(___ksymtab+foo ___ksymtab+bar ___ksymtab+baz))
> is a syntax error.
> 

ah, ok, didn't test anything, just threw it out there in case somebody
wanted to see if it was doable.

Is that a limitation of SORT? The ld docs say

   There are two ways to include more than one section:
     *(.text .rdata)
     *(.text) *(.rdata)
The difference between these is the order in which the '.text' and
'.rdata' input sections will appear in the output section.

so there shouldn't be a problem mentioning more than one section name?

>> If LD_DEAD_CODE_DATA_ELIMINATION was more widely supported (and I was
>> surprised to see that it's not even available on arm or x86) one could
>> also play another game, dropping the KEEP()s and instead create a linker
>> script snippet containing EXTERN(__ksymtab_foo __ksymtab_bar ...),
>> referencing the "struct kernel_symbol" elements themselves rather than
>> the singleton sections they reside in.
> 
> Do you mean LD_DEAD_CODE_DATA_ELIMINATION must be enabled by default
> to do this?
> 

No, but without LD_DEAD_CODE_DATA_ELIMINATION, I don't see much point of
the TRIM_UNUSED_KSYMS. Yes, the export_symbol metadata itself vanishes,
but the actual functions remain in the image. Conversely, with modules
enabled, LD_DEAD_CODE_DATA_ELIMINATION can't do much when almost all of
the kernel can be built modular so almost extern interface is an
EXPORT_SYMBOL. At least, that's what I see for a ppc target with a
somewhat trimmed-down .config, combining the two gives much more space
saving than the sum of what each option does:

$ size vmlinux.{vanilla,trim,dead,trim-dead}
   text    data     bss     dec     hex filename
6197380 1159488  121732 7478600  721d48 vmlinux.vanilla
6045906 1159440  121732 7327078  6fcd66 vmlinux.trim
6087316 1137284  120476 7345076  7013b4 vmlinux.dead
5675370 1101964  115180 6892514  692be2 vmlinux.trim-dead

Anyway, that was just an aside, probably the above ___ksymtab+foo thing
will work just fine.

Rasmus
