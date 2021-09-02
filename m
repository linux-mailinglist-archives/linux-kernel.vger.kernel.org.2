Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 549003FF201
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Sep 2021 19:02:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346486AbhIBRC4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Sep 2021 13:02:56 -0400
Received: from mail-bn1nam07on2050.outbound.protection.outlook.com ([40.107.212.50]:44290
        "EHLO NAM02-BN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1346410AbhIBRCy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Sep 2021 13:02:54 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WuWPl+ZCkAZ0n11SMqeuGs/BVqQ2yTlySxBhYOnZroCzt/y7Zuroe0+hrVkdcvi63irUgYk4JvcYZjLHGi1Nc9f8imbucNEaTKzU9UPuJd5nCdjJwZ59G3utlKnL+gGkKAIAaKOQDamqJrk/o8gHpzTkuomoPpALDPc4j5/APrgDVWr6SkZliemoJ5pSBJbV0echnYU5NEWmvZMlqSiNOGxIZvhg0qIASIm00XT2VTcavv0RreTvaRTSXX58O/3mtPhVweK57LBxMgaD7xDEU7ESGuE+zCemz9HpFdDEEqs4/7/9qkQAcefTjN11nklpSQypWbUt6RwitdH1BCLKmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=kKGQm527LlPqlORHawsc/oNfKKH/KNnznhPBRt0fISc=;
 b=GM+neem0wtGq9wtU5BBD8Z8BN4Fy6HHtvMRX6x4O0ztmoplILlJxp7cB4ofkCUHh+RFrXljPpQOJOIK0o6FVgevGgm9EVCvXuR2QpKjgiualTUXVy/aLf7K5TG+85O/6YI7WfSttOMwv9qlm+1Cm6wtjL2ds+ztYOtDvjHNnjfE3EJ6Fu9jCz46odiiQKjFX+8paDTQMf31MqQW6TZ5dAolrfEPvTqVWqQsbZGJHBeasuwjZypmjuTCG3W2EEd2kfZpAyA4mtCgWFtDEjNU1Kf8g2G2XSPW11z0PCHRmnD5W76+bjW4H9ltzheGxCXPDS545/ScEBQ5BNEooXZ0Yag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kKGQm527LlPqlORHawsc/oNfKKH/KNnznhPBRt0fISc=;
 b=mMKuGxQQ6z6j+Hpw3MbVG19QfoZS0sSacxQDcDB41WRp/hglK3B5ONJAF3HQN+xVVxcVVh8FzVhtTMoMsjcrZWotYOrtV74+u612WdykW8G89R9xEtO+DPpOoDG8RB6ckzHuIKBxW42tqVaO/2uqhebAyGY4Rw6/2IrBTQOMCHQ=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5136.namprd12.prod.outlook.com (2603:10b6:5:393::23)
 by DM8PR12MB5493.namprd12.prod.outlook.com (2603:10b6:8:3d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.19; Thu, 2 Sep
 2021 17:01:54 +0000
Received: from DM4PR12MB5136.namprd12.prod.outlook.com
 ([fe80::555a:2980:a5c2:8d29]) by DM4PR12MB5136.namprd12.prod.outlook.com
 ([fe80::555a:2980:a5c2:8d29%8]) with mapi id 15.20.4478.019; Thu, 2 Sep 2021
 17:01:54 +0000
Subject: Re: [PATCH 1/1] debugfs: use IS_ERR to check for error
To:     Greg KH <gregkh@linuxfoundation.org>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Cc:     rafael@kernel.org, linux-kernel@vger.kernel.org,
        Nirmoy Das <nirmoy.aiemd@gmail.com>
References: <20210902102917.2233-1-nirmoy.das@amd.com>
 <YTCpuo00wM7jGSIc@kroah.com> <5ab7739d-15a4-2e84-0320-fee8d5df1e83@amd.com>
 <YTDBfO/byKzGWV8G@kroah.com> <c918f1a5-7c88-bf47-14b6-b6e892695951@amd.com>
 <YTD8+tLP7KeGRXEc@kroah.com>
From:   "Das, Nirmoy" <nirmoy.das@amd.com>
Message-ID: <a6817cbd-b43d-5334-3e1e-62c1cd99e8fc@amd.com>
Date:   Thu, 2 Sep 2021 19:01:49 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <YTD8+tLP7KeGRXEc@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: PR3P191CA0007.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:102:54::12) To DM4PR12MB5136.namprd12.prod.outlook.com
 (2603:10b6:5:393::23)
MIME-Version: 1.0
Received: from [IPv6:2003:c5:8f1d:d000:ad20:9749:da12:5f0e] (2003:c5:8f1d:d000:ad20:9749:da12:5f0e) by PR3P191CA0007.EURP191.PROD.OUTLOOK.COM (2603:10a6:102:54::12) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.20 via Frontend Transport; Thu, 2 Sep 2021 17:01:53 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 18062e31-656f-4ef6-89c1-08d96e335dad
X-MS-TrafficTypeDiagnostic: DM8PR12MB5493:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM8PR12MB549324D49078F19203BBC8628BCE9@DM8PR12MB5493.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:386;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mjnWfqRMzHGlFLtzMOc0XhXAYvKcaerHoznO2lBGtFFCTih24msjmvgAIddoWEYKTszobpTKXGBK0/2dIi5HXoU+Nyz/F0C/k1bXdEnYLZquQNcOxQTaXmIHVvk/9DhaYKwgKue8GSv940nH2syaCtNHdtadm/flbfKfVDOJ7LJCNK8NF06rFRjmk1n+GfJt8i+pZADKAbX9udlW/cHqNJZ48thb4pEJv3R1FLRCUo/NZIxfIVIgu/UBg0acb3jawpt8A8S6e9b4vIWu8pD7hWiyKHptjFKUEhb8ktV+NEpU/CZ5pEL14z6xV7g35cIhYaf5VSb+ldtY0pXIZ5bVqx7HOsSZ6XayB5xhcEDtRjB8TUDjVBohUg6k59DkD7WJnkpPj+goyYDbAuw1QUC5Zy5590h0XVzZtarqpLUkGtXxUs5+N6TeFpkpEfTtES0QTJlKUm8MyQ/ppWBTfj0wXpXLd09zwib3KZ4edDDr24wXTRSn7yYGhCs+yj97dpGKjVYb1mvxXgGGhbx1uM1Aw8ZeqZQ3coE0yjkKLsFSzoBht55tcBNwlnURMvjx5bYkVkcH0TWiqfxt+YfS6OPYN/Hk+nr2v+duJpT/lswFGYwK7Tdkc+wJLQ+wC2nhVAXA8zj1R5dGPuhDL4uNnkxY67DKtJO5zntRzXTC4V7BOG5B8g+Ihz04iJnzcjr9Iq3sy8vw/hTYXbyvG6BEqAJ9+jAe+OQOIBCqUskf/TQAZ48=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5136.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(39860400002)(396003)(346002)(366004)(376002)(6636002)(86362001)(2616005)(52116002)(36756003)(4326008)(186003)(66946007)(66476007)(6486002)(110136005)(66556008)(38100700002)(2906002)(316002)(6666004)(31696002)(5660300002)(478600001)(66574015)(45080400002)(8676002)(83380400001)(966005)(8936002)(31686004)(53546011)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U0l5MjRTTXZyczE4WSszMlJqTTJWM0tiVU54ejVJL2lzSGRsS3JZRzdOL216?=
 =?utf-8?B?WS9OeUl2QXJUbCtpOENEYUtXVThuVHdxSnl0RmVhcTV0OXN6RDJ1d2FJV2Qy?=
 =?utf-8?B?WlFBOUVtOUN0bkNST2N6STltOTRYbWlJcWtqSFBxdXZaV1dXYjROVXh1OEh0?=
 =?utf-8?B?Z3A5L2tzNDV5dEtWOFdIQkY1TVc4dzB3VklHMzIrWHdxcFkzWmkrQUNac0Jp?=
 =?utf-8?B?dDg1dDBuSTlMRGZSbkdyenBQUnNpTVpYRU9yUFlnM2xOd1lEb25Sd3JMQ1V2?=
 =?utf-8?B?MzRmQ1NmeGZtUEdGMjlrUTlYM09VRGljOFF0a1UwcTJ4NkNqbmNBMTJGQXVJ?=
 =?utf-8?B?ZHVTd2tkS3B6RkRNZ1VuZ2NRMnRKY2NDa1E0L0xYK0RZTWZxaGVSYUExY051?=
 =?utf-8?B?aVg5cmVrazUwVzN3dnUvYWxJM3NaSjdVb09rY1M4U1JIcXpFb0RRdEhpU0ll?=
 =?utf-8?B?TmhaRXlGL1RKOHFLVGlQZkRwV2pUejZ4cmlZS2VnNU9Gck1SY0p0Z0hydWdK?=
 =?utf-8?B?SXEvR28yS3Y1Q0Z6Z3BhSm0vaHFKRmRHRDhCZDZsVWttVVhEaTlybTgyMmdC?=
 =?utf-8?B?dnpwTUd5WW5rc1hKSndWNXlMRHBjMXEwN3FmT1JtcDZkOWlzYmQzeHFZQVZj?=
 =?utf-8?B?OUtQQTZQaXdQUGw3NDJOeTBYM3k3UnNoMzd1QWFZTzg2OTBjZWZaMysxUkN0?=
 =?utf-8?B?L05RanNXREl4bWdaZWo2eU51Rkh6dUdnREJ4MlVTck4rVXhrUDdocEMyVy92?=
 =?utf-8?B?ZHU3YTlpNUQyMGw2RUNUUVVxVWZvbVBzSURHZm5XTFRUUm1KQm1WSjhsNmVw?=
 =?utf-8?B?QjFacTNxTzZPNDVoamhRbFVhMmREdE5JSFBmNUM0SmtTQm9hZi8wOFBseVRK?=
 =?utf-8?B?TzZFT3pEaHN6Mjk3dzNLa0tCdUxGZUtRSys5ZzFhU0VRRmFNVEZsWUZSZUhn?=
 =?utf-8?B?Qzh1NmthcEJUL2VlclZrZjlONmNyb3UzLzhxeXZoQVlHQU1xbFoxMFJ0M01k?=
 =?utf-8?B?S09GWEMvOE45SXdQakUzYkhTd1dtd0szNy9nTHBoZndTbk1adThrTXhIREVJ?=
 =?utf-8?B?VHp4UHpKNUV6aXdqdzNaaHAwZnpwOXUzTmRmaEF0dHBTREdpVGJlc1EzVjVI?=
 =?utf-8?B?WGwwelBxdVNYUHJlTHB5VTdBWHNHZWN3VGpQMExNZmtkazVyOW50WGhpeTIz?=
 =?utf-8?B?THVCSU0ySUxqSzNkd0ZSa0RYRjBOQXRkdWkxS084Tk5lUFhYam5wVlJTYjBG?=
 =?utf-8?B?ZTltWEllT1JobkkxejR4SXVRZzJpMXNKOHJZU0lFK05Xd25GVDdPRHhBVjJy?=
 =?utf-8?B?ZFE0bkdtU2dnNjZqUmJjRlFIdGxHb2l3MlBxaUZ0bk5nNjhBV3ByTWNpdHpw?=
 =?utf-8?B?dnN6N3hUb1k2UHlERGpLWXRPdzF5QlA0Vmw3aEpNREdwNEQ2aFBJVC9pZlc3?=
 =?utf-8?B?dXVxTVNQeklJcndlRW4wVGZiUTFyb2ZaekRWWWxTakJYOFRlcHZLUUtGd0lP?=
 =?utf-8?B?K2JXMFRwZCtrbFRBWllqTUJqNzB5NzZpOUJoalJvNUVXRElucWJJTDlaQ0Ru?=
 =?utf-8?B?M2t1OEVucE1OOWw5SXZESDhaY3RndGt1cG1zU09MTC9kMzA0NU4xSVl4Z1ky?=
 =?utf-8?B?WEhVNlV6Q0ZyY0JTMVlVdFBUQVg0aFlWSEhjWnJyNlVjbS9TMDJ0YTJUZ1Bz?=
 =?utf-8?B?Rnd5UmlIdEtVOEdhQmpadVNIWmVWSkp2aWNHZnJNU0xaRG9uNGZkYm55eUZY?=
 =?utf-8?B?VWtKa25xWjlmU3FUSS9rNjBOb210aWlPRWx5TGVaNEFmYUdrdVJGODZncGg1?=
 =?utf-8?B?UDRhb2laRktOSVJNMUFkMUYrb0g3TEhFdE9IMkpqcFZHRmY2MldpQVBoWEtV?=
 =?utf-8?Q?7cMN/aoUiZOEa?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 18062e31-656f-4ef6-89c1-08d96e335dad
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5136.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2021 17:01:54.4981
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iXZZlTFAajEeXaqZpQ2zCfHxwXS2LKBoMT58UDkxVjN1hGXjnPparvWAKNuZhAeWhYhek0OfGJGbDVoKXwzlZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR12MB5493
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 9/2/2021 6:34 PM, Greg KH wrote:
> On Thu, Sep 02, 2021 at 05:10:24PM +0200, Christian König wrote:
>> Am 02.09.21 um 14:20 schrieb Greg KH:
>>> On Thu, Sep 02, 2021 at 02:03:12PM +0200, Christian König wrote:
>>>> Am 02.09.21 um 12:38 schrieb Greg KH:
>>>>> On Thu, Sep 02, 2021 at 12:29:17PM +0200, Nirmoy Das wrote:
>>>>>> debugfs_create_file() returns encoded error so
>>>>>> use IS_ERR for checking return value.
>>>>>>
>>>>>> References: https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgitlab.freedesktop.org%2Fdrm%2Famd%2F-%2Fissues%2F1686&amp;data=04%7C01%7Cnirmoy.das%40amd.com%7C7a1f1095c0d64416576c08d96e2f7b38%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637661973378236086%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&amp;sdata=g9BQRJG8gvjGFq6oj5vk9PCemQ39U19CLmkMNHVUafg%3D&amp;reserved=0
>>>>>> Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
>>>>>> ---
>>>>>>     fs/debugfs/inode.c | 2 +-
>>>>>>     1 file changed, 1 insertion(+), 1 deletion(-)
>>>>>>
>>>>>> diff --git a/fs/debugfs/inode.c b/fs/debugfs/inode.c
>>>>>> index 8129a430d789..2f117c57160d 100644
>>>>>> --- a/fs/debugfs/inode.c
>>>>>> +++ b/fs/debugfs/inode.c
>>>>>> @@ -528,7 +528,7 @@ void debugfs_create_file_size(const char *name, umode_t mode,
>>>>>>     {
>>>>>>     	struct dentry *de = debugfs_create_file(name, mode, parent, data, fops);
>>>>>> -	if (de)
>>>>>> +	if (!IS_ERR(de))
>>>>>>     		d_inode(de)->i_size = file_size;
>>>>>>     }
>>>>>>     EXPORT_SYMBOL_GPL(debugfs_create_file_size);
>>>>>> -- 
>>>>>> 2.32.0
>>>>>>
>>>>> Ah, good catch, I'll queue this up after 5.15-rc1 is out, thanks!
>>>> Thinking more about this if I'm not completely mistaken
>>>> debugfs_create_file() returns -ENODEV when debugfs is disabled and NULL on
>>>> any other error.
>>> How can this function be called if debugfs is not enabled in the system
>>> configuration?  This _is_ the debugfs core code.
>> Well, that's what I meant. The original code is correct and Nirmoy's patch
>> here is breaking it.
> Ah, yes, sorry, you are right.  This function can not return an error
> value, if something went wrong, the result will always be NULL.


I just realized that we don't return NULL on error anymore:

commit ff9fb72bc07705c00795ca48631f7fffe24d2c6b
Author: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Date:   Wed Jan 23 11:28:14 2019 +0100

     debugfs: return error values, not NULL


and the current doc also says "If an error occurs, ERR_PTR(-ERROR) will 
be returned."

If I am not missing anything, this patch should be fine.


Regards,

Nirmoy

>
>> Nirmoys other patch is for a driver and there the function can indeed return
>> both error code and NULL.
> You should never be checking this stuff in a caller anyway, so no, don't
> do it there either.
>
> thanks,
>
> greg k-h
