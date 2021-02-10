Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 123BC315FE8
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 08:17:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231440AbhBJHQv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 02:16:51 -0500
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:15747 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230357AbhBJHQt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 02:16:49 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B602388380001>; Tue, 09 Feb 2021 23:16:08 -0800
Received: from DRHQMAIL107.nvidia.com (10.27.9.16) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 10 Feb
 2021 07:16:08 +0000
Received: from [10.2.50.67] (172.20.145.6) by DRHQMAIL107.nvidia.com
 (10.27.9.16) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 10 Feb
 2021 07:16:08 +0000
Subject: Re: [PATCH v2] mm: cma: support sysfs
To:     Minchan Kim <minchan@kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>, <surenb@google.com>,
        <joaodias@google.com>, <willy@infradead.org>
References: <43cd6fc4-5bc5-50ec-0252-ffe09afd68ea@nvidia.com>
 <YCIoHBGELFWAyfMi@kroah.com>
 <7cc229f4-609c-71dd-9361-063ef1bf7c73@nvidia.com>
 <cd33f8b9-89e0-05bd-2b16-85855f7541bb@nvidia.com>
 <YCIyHuOX3E+tP+AO@kroah.com> <YCKwjz0uDPBhbFr5@google.com>
 <YCLLKDEQ4NYqb5Y5@kroah.com>
 <09e60732-6a46-dd00-f9d5-4ef17ee685c8@nvidia.com>
 <YCL67QzPiyRhhbor@google.com> <YCOAmXqt6dZkCQYs@kroah.com>
 <YCOHRAAijtCbN+pr@google.com>
From:   John Hubbard <jhubbard@nvidia.com>
Message-ID: <e7ea55b9-a5f6-0daf-843b-e25d8c70e980@nvidia.com>
Date:   Tue, 9 Feb 2021 23:16:07 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:85.0) Gecko/20100101
 Thunderbird/85.0
MIME-Version: 1.0
In-Reply-To: <YCOHRAAijtCbN+pr@google.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.20.145.6]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 DRHQMAIL107.nvidia.com (10.27.9.16)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1612941368; bh=K1GI4vzcTOKbODiCg0dBY8yviaMSJzmK4ha7JjEbmZg=;
        h=Subject:To:CC:References:From:Message-ID:Date:User-Agent:
         MIME-Version:In-Reply-To:Content-Type:Content-Language:
         Content-Transfer-Encoding:X-Originating-IP:X-ClientProxiedBy;
        b=YO1EF6tByPwoH8IQQQ31SmU472GYHZiEnMBSvDdt7ll1DVTo+JJr2GvJpd/0h770L
         FvduHtjjdW143cQYhBwU1tjv8e4RL6VhdaSiPMN+424A0C0NgK8/TNZac9QRJB04Th
         rYooHFbl1MLO2HOiPmjRLyw14TCF69GsBx4xPmMv1tUaZMEQJP7e9o2s3k4Yqo3v/p
         wZp4C/TJ4exjMXZ696JdfezlL3JADUAKjJCNWM4COj/H2QReq8OwdL2gFZ8L1GNnKI
         NkcYFFBkJPB41wHpVcKyf6dIj1yk2/6+vSSlQFnA+BniRTqf/CJLtNn0JfWSHECiEC
         HISFltoCNMKbA==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/9/21 11:12 PM, Minchan Kim wrote:
...
>>> Agreed. How about this for the warning part?
>>>
>>> +
>>> +/*
>>> + * note: kobj_type should provide a release function to free dynamically
>>> + * allocated object since kobject is responsible for controlling lifespan
>>> + * of the object. However, cma_area is static object so technially, it
>>> + * doesn't need release function. It's very exceptional case so pleaes
>>> + * do not follow this model.
>>> + */
>>>   static struct kobj_type cma_ktype = {
>>>          .sysfs_ops = &kobj_sysfs_ops,
>>>          .default_groups = cma_groups
>>> +       .release = NULL, /* do not follow. See above */
>>>   };
>>>
>>
>> No, please no.  Just do it the correct way, what is the objection to
>> creating a few dynamic kobjects from the heap?  How many of these are
>> you going to have that it will somehow be "wasteful"?
>>
>> Please do it properly.
> 
> Oh, I misunderstood your word "don't provide a release function for the
> kobject" so thought you agreed on John. If you didn't, we are stuck again:
> IIUC, the objection from John was the cma_stat lifetime should be on parent
> object, which is reasonable and make code simple.
> Frankly speaking, I don't have strong opinion about either approach.
> John?
> 

We should do it as Greg requests, now that it's quite clear that he's insisting
on this. Not a big deal.

I just am not especially happy about the inability to do natural, efficient
things here, such as use a statically allocated set of things with sysfs. And
I remain convinced that the above is not "improper"; it's a reasonable
step, given the limitations of the current sysfs design. I just wanted to say
that out loud, as my proposal sinks to the bottom of the trench here. haha :)


thanks,
-- 
John Hubbard
NVIDIA
