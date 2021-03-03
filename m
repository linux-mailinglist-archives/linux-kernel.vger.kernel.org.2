Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BD1A32BC9F
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Mar 2021 23:06:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381252AbhCCOUJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 09:20:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1842946AbhCCKWw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 05:22:52 -0500
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on20612.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe5a::612])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 056E2C0698D9
        for <linux-kernel@vger.kernel.org>; Wed,  3 Mar 2021 01:22:07 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g1YOl0cCSP1M2olSnJnghQ8fXM09apMVUuLsGqZxJB/Urjh5/HafUPuw6jYjsHgDZl/F/yMyEMSFbBbYZ1DAQBHMl7ZgPm1qm061Ciq3BERqm1TvgWLI5Mf1yI3alvtiiK061Rb83lAB/Ps5wLdy4t4Yryo4mnjO2FRD1+K5muCbKF6HT8mgtmF2QqAUsikkyya4HVko/zhG6r8p0rxxuuREz0g68KrNknJYGGeZmOUHvsSoUzt3EGDErYfqZcZWHc621Kdgl8BZHXemOt3ryLMf9KVJzSEZRhXlH66/wx8MuHfQFKP9TH7xxSOtbUc2RkSYz1Cazn8Ax3o4fSCVvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S7zj4GP8CuRWxkflXuRHVlM6xKYDf16VMnEVGlaSw0o=;
 b=b7wq2GQShc4WGq1GrHXA637f2SvQJiGJyAl0Xt1Ourbl0yYRDm5bfgEddHPOyeXOxQvDGnvn3SDeN24bMKAInHgpI7u6px9UC7s8bUfpATpHhAPABZXz8sGtybYCcx3bxoEQbCxtPRZmbqbQlxz3VLluHU917sLz3jhT2Ox6s6La60tWZyKt1wbtQ0tDizeotN+fgFmJfx2HYUY76KiFL+0j3sfpfo4n3ZELtAuJeibDYMBTBDXlCFpOwZNF1WyrtC3CWFxTwTSv4NLETAyoo/1UCFFy2s8DQyG43R4uoc7YKTfZ2eo/+XLHVIs2sBAmIqo/HN8pZBr8PZIdDrS7gA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S7zj4GP8CuRWxkflXuRHVlM6xKYDf16VMnEVGlaSw0o=;
 b=T078XbvddUrBR9rU60ZiTyP7HER/5Xii6/zwYVE4TfADxfDMsCVb/yOgmNRKTxSqeAgy0HoqwISfdDi0r3IxbTdgQlcLNjAgKFnp2WCBzMWRa3e8uY4pDfA6nsJCWMCwjqygJocxoZ2P/luL8t8B9orCmLPm3di+guXisfmEzMw=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=windriver.com;
Received: from BN8PR11MB3586.namprd11.prod.outlook.com (2603:10b6:408:84::30)
 by BN6PR11MB1347.namprd11.prod.outlook.com (2603:10b6:404:48::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.28; Wed, 3 Mar
 2021 09:21:50 +0000
Received: from BN8PR11MB3586.namprd11.prod.outlook.com
 ([fe80::382b:3030:cdf0:f4da]) by BN8PR11MB3586.namprd11.prod.outlook.com
 ([fe80::382b:3030:cdf0:f4da%7]) with mapi id 15.20.3890.029; Wed, 3 Mar 2021
 09:21:50 +0000
Subject: Re: [PATCH] vt: keyboard, fix uninitialized variables warning
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Greg KH <gregkh@linuxfoundation.org>
Cc:     jirislaby@kernel.org, dmitry.torokhov@gmail.com,
        linux-kernel@vger.kernel.org
References: <1614747572-3295-1-git-send-email-li.wang@windriver.com>
 <YD83RFqtKVB2pA9H@kroah.com>
 <5f05c3c2-6c72-140f-fd56-cd9ec1c7c4a1@windriver.com>
 <YD89HVVBREVdqdpJ@kroah.com> <YD9HufAwwxK2jZwD@smile.fi.intel.com>
From:   "Wang, Li" <li.wang@windriver.com>
Message-ID: <2973260e-2405-5a70-f9bd-398d3d45346e@windriver.com>
Date:   Wed, 3 Mar 2021 17:21:40 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
In-Reply-To: <YD9HufAwwxK2jZwD@smile.fi.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [60.247.85.82]
X-ClientProxiedBy: HK2PR02CA0176.apcprd02.prod.outlook.com
 (2603:1096:201:21::12) To BN8PR11MB3586.namprd11.prod.outlook.com
 (2603:10b6:408:84::30)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [128.224.155.135] (60.247.85.82) by HK2PR02CA0176.apcprd02.prod.outlook.com (2603:1096:201:21::12) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17 via Frontend Transport; Wed, 3 Mar 2021 09:21:48 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9b680dce-66e6-4898-3286-08d8de25c6d1
X-MS-TrafficTypeDiagnostic: BN6PR11MB1347:
X-Microsoft-Antispam-PRVS: <BN6PR11MB13471C10E74855B48EED45F4EF989@BN6PR11MB1347.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3GTiJ//Q+Af0HCIHDxg09EHwPWufmSPdR7ntLFg8TT4Qy0y+aBZyyrdE/slMc5ECW/+52y6b5G5GWUsNkiwF7a8CNEMImXCXVvdNLvq1c/7H9yaDSyaQ3MoLroGCYR5Z8mIIbvVpLkhblko50cTVIl+QMDl9WnLZqJ//6g8woL0/AxEYU4/xpjzzlRM6UzoSb7OE8CY6KIxCxQx6enji9+eygsGi77ANIs9m4O8wH60P3VdzwakwuhC3Xt48Q+4PDo1qSbaCE7ERhwo/RXpJlxKI3NAzKZSyoX7sG2LY/CjrjxV59LloO890iAHatkbakB8poIJzEHFx8wrbKh67ghfPQlqQvZjxv9il1Y5MNbJyRaQ4bhCACWF3h/Mo4PUeLnDUlAxtLY8qW/Z05+3qpwj5k8GGtlJRKv41xASe4/Boykas4eElfg/lPoAx12Qn0PjVf76n809I3+SkhGR31rkSTUP5B0C/+hwQGdgGsd8CkRRVHrXzJ0hbO+Na1moWbaGzB27AARq2VfetnsmB61H+abFAibJ6aldSABLA3715iJIUoDBPigUEbVG0fl5pPlpPnQwWSrJxaArOMIZ0ZOIChZ86ITsxEL0TRTnA0gq0fP+Yxi/r7BV5bo8PQ8Uf
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR11MB3586.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(366004)(396003)(376002)(346002)(39840400004)(4326008)(6706004)(66476007)(5660300002)(956004)(2616005)(53546011)(31696002)(16576012)(316002)(2906002)(6666004)(52116002)(110136005)(86362001)(31686004)(66946007)(66556008)(478600001)(16526019)(36756003)(8936002)(83380400001)(8676002)(26005)(186003)(6486002)(78286007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?TURGSzh1Wk9TeFFnYW9LeDZJQUZmd01HZWllUks4ak1TUFkxSG1WanRtYjRY?=
 =?utf-8?B?ZEVJT2tJbXU2a3gyQXlGZEExeWk5dHZxOG0wWnJkYlB1NGNPeG1LR1lreEJh?=
 =?utf-8?B?RUcxd1VjY2xPUVlFLzhVYngxdnVNV2F0N1BXUW1PcmFvK2djc2lGQkVQemhW?=
 =?utf-8?B?SndaVVBRcDJhNVFFYnFUNjVIY1FzNjlYbTdhdHhRekhzMUtzUnNSNWhFQ3ZC?=
 =?utf-8?B?S2ZzQ0JsR0pYKzJRUUVPRFFkSjNYZkhuNDZNNjBGOG9NL3F6SGdzZEpVRlk2?=
 =?utf-8?B?UVJEK0lpa3VPUk40dWpmd21PQnk1YkJpVUtKYk9obHJNblNUTmZFMUNieXlR?=
 =?utf-8?B?d1VtVlIzZld2a3JJcEE0YmU2RVZJZkozVlB4T2ZuZHI0QzZqdS9jZDJ6dXJN?=
 =?utf-8?B?WEFBYlIzNlpHblJ3MTVCck0yWnZ0SzlxTExzVUxuOFVyaU1HNUhpR1NlN200?=
 =?utf-8?B?QlR4aUpuSVdlenBEd1BuTEhxZjFwdGtYN0p1SXFucG5LMTBPbFNEeXpwWkZE?=
 =?utf-8?B?VnlyWFJOdGMwcEo3NnNEaHF3eFBwTTFOTGFGVlY5NjVac0JQU2dVVS9reXpJ?=
 =?utf-8?B?aDhvRG5UaWJYQSt4MGlMTE80dHhnSFRqd2dGTjFVbnJwdnpvRitVL29jcVE1?=
 =?utf-8?B?UmFQVzZObG01TVpHbzNvTGpHS0lpWldXVVRxSlFKVzBMaWdOSTNvL1ZYL01t?=
 =?utf-8?B?eHdqWnJLU0hYMzNsZm43ZnBQY2xtVWhHMTYyMkd5SkNjZTdXREZLNUEvbCtG?=
 =?utf-8?B?U244RXZNK1g4cHVTT3hKSGp4M3RtSkxqTXVIVzJQSTFjaUJHTktyUk95TGl2?=
 =?utf-8?B?RWh1eHFGc08wMURpV1dTcUNwblhiSDZZRjdUZVB5ejNUVzVVSVNEa0hBM3I1?=
 =?utf-8?B?LzZvRkhyU1lKc1VGWDRza2I4eElGN0w5bmovSkZGZ01JTG9tM2o4NGRvaGJu?=
 =?utf-8?B?ZDl0Z2dtTSs3WDRkTFNhYm1SYitmZ09zVjBMZFBDTlM3eUtVajVxMUp1NEln?=
 =?utf-8?B?Qzh0d3ZlM0U0RjZGUEVGWTdSTGVZTzJTa3lPbXlEY21xbERpWHp4bzNzVzhn?=
 =?utf-8?B?K2xSSjJ1N2U2Y0hJT0JpWFdNMEVEVHk1SXpzQzQ4SVJEbzJoeDFQQmtjVkRu?=
 =?utf-8?B?N2ZCTmMvZWZtRnRobkRVMUFpNkVPdEdLUjFwalFnQkF3VWF2K1ZJUVlwOUlD?=
 =?utf-8?B?ckFpSytVSG53aDJKQmt1a2N0c3dkNWhZRkdvUzJ2Z0k1MU5qcDIrcFZZTWZi?=
 =?utf-8?B?YlZXeklVQUVacG0yUFcyc3NobFFPVU9hSG5ySWliMnI2ZHlScUd5MWxPaWFY?=
 =?utf-8?B?SFBJWWQvUGJlZXN2MlU4bTliY3NtdWtEa2RkeTBCbllVTDBSaEJVR1ljQnhO?=
 =?utf-8?B?aGJVbVlHdTIxTGZDRmhFNE9MaWhaS3p5cVdxcFF6bGVoUS9NcEhhODk2Nmwr?=
 =?utf-8?B?YkRSSzM2NVdNZjNhclFxWVl2TUE2dWtsa3ZQNERnaUdDaHFLNERLN1NDZDdn?=
 =?utf-8?B?LzVNKzdncjB2blRzWnU2QWg1dlh3WWlrenp4K2dSdlYycVhTcXJqeXV4NG1N?=
 =?utf-8?B?eUJ2ZkxXK1BhMUwvRDdlWHhjc0dleHZDT3pnTU9CWnF2UktuTm9ROFBtVFIv?=
 =?utf-8?B?Mm95RGEwbHpCWnlPb0pRbkNiWTgwd2pOeFRSaTFybnVwUENhc0pYQ05mUml0?=
 =?utf-8?B?UkhHK3BHS3pXazVYS1luSXVnd3NnMVJrT1NBUWllZmtHOWtnMUR6N0FKVXZE?=
 =?utf-8?Q?uomD6vPKGEplsObdoqKHA51osU78IEzE6nsbtv2?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b680dce-66e6-4898-3286-08d8de25c6d1
X-MS-Exchange-CrossTenant-AuthSource: BN8PR11MB3586.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2021 09:21:50.4749
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rFyVpBaEt21Kd23aZCrhDxsMVPd+K06K+hyCqz3CA5z/TaT0sQRJuEPAl47K1r/7X4bxPBrZAvA7OeJL4h9Yfg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB1347
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 3/3/2021 4:24 PM, Andy Shevchenko wrote:
> On Wed, Mar 03, 2021 at 08:39:09AM +0100, Greg KH wrote:
>> On Wed, Mar 03, 2021 at 03:33:23PM +0800, Wang, Li wrote:
>>> On 3/3/2021 3:14 PM, Greg KH wrote:
>>>> On Wed, Mar 03, 2021 at 12:59:32PM +0800, Li Wang wrote:
>>>>> drivers/tty/vt/keyboard.c: In function 'vt_do_kdgkb_ioctl':
>>>>> drivers/tty/vt/keyboard.c: warning: 'ret' may be used uninitialized in this function [-Wmaybe-uninitialized]
>>>>>     return ret;
>>>>>            ^~~
>>>>> kernel-source/drivers/tty/vt/keyboard.c: warning: 'kbs' may be used uninitialized in this function [-Wmaybe-uninitialized]
>>>>>     kfree(kbs);
>>>>>     ^~~~~~~~~~
>>>>>
>>>>> Signed-off-by: Li Wang <li.wang@windriver.com>
>>>>> ---
>>>>>    drivers/tty/vt/keyboard.c | 4 ++--
>>>>>    1 file changed, 2 insertions(+), 2 deletions(-)
>>>>>
>>>>> diff --git a/drivers/tty/vt/keyboard.c b/drivers/tty/vt/keyboard.c
>>>>> index 7763862..3e73d55 100644
>>>>> --- a/drivers/tty/vt/keyboard.c
>>>>> +++ b/drivers/tty/vt/keyboard.c
>>>>> @@ -2049,8 +2049,8 @@ int vt_do_kdgkb_ioctl(int cmd, struct kbsentry __user *user_kdgkb, int perm)
>>>>>    {
>>>>>    	unsigned char kb_func;
>>>>>    	unsigned long flags;
>>>>> -	char *kbs;
>>>>> -	int ret;
>>>>> +	char *kbs = NULL;
>>>>> +	int ret = -EINVAL;
>>>>>    	if (get_user(kb_func, &user_kdgkb->kb_func))
>>>>>    		return -EFAULT;
>>>> What compiler is providing these "warnings"?
>>>>
>>>> Turns out it is impossible to hit, so this isn't actually fixing
>>>> anything...
>>> I tested it with gcc 8.2 for arm
>>>
>>> for runtime codes view, indeed it is impossible to hit.
>>>
>>> but for compiler view, gcc should give 'used uninitialized' warning, too.
>> Odd that no other compiler version does this right now, perhaps upgrade
>> to a newer version of gcc?  8.2 is really old :(
> But it's still supported. I think I can see why. We have a switch case without
> default, and probably that's how it makes that happen. So, the proper fix is to
> add default section AFAICT.

Hi all,

I tried the latest gcc and linux, these warnings disappear.
it is not gcc issue, the issue is that I do not use the latest linux.

linux disables the 'used uninitialized' warning in the below commit,
but mentioned by description, if want to debug kernel warning, use 
option to open.
and 'great ... code ... never confuses the compiler'

I will according to Andy's suggest, send V2.
Thanks,
LiWang.

=====

 From 78a5255ffb6a1af189a83e493d916ba1c54d8c75 Mon Sep 17 00:00:00 2001
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sat, 9 May 2020 13:57:10 -0700
Subject: [PATCH] Stop the ad-hoc games with -Wno-maybe-initialized

We have some rather random rules about when we accept the
"maybe-initialized" warnings, and when we don't.

For example, we consider it unreliable for gcc versions < 4.9, but also
if -O3 is enabled, or if optimizing for size.  And then various kernel
config options disabled it, because they know that they trigger that
warning by confusing gcc sufficiently (ie PROFILE_ALL_BRANCHES).

And now gcc-10 seems to be introducing a lot of those warnings too, so
it falls under the same heading as 4.9 did.

At the same time, we have a very straightforward way to _enable_ that
warning when wanted: use "W=2" to enable more warnings.

So stop playing these ad-hoc games, and just disable that warning by
default, with the known and straight-forward "if you want to work on the
extra compiler warnings, use W=123".

Would it be great to have code that is always so obvious that it never
confuses the compiler whether a variable is used initialized or not?
Yes, it would.  In a perfect world, the compilers would be smarter, and
our source code would be simpler.

That's currently not the world we live in, though.

Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>

