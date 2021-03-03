Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 901C932BE51
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Mar 2021 23:44:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385542AbhCCRU1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 12:20:27 -0500
Received: from out30-42.freemail.mail.aliyun.com ([115.124.30.42]:34466 "EHLO
        out30-42.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233874AbhCCNmt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 08:42:49 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01424;MF=xlpang@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0UQGHx3l_1614778477;
Received: from xunleideMacBook-Pro.local(mailfrom:xlpang@linux.alibaba.com fp:SMTPD_---0UQGHx3l_1614778477)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 03 Mar 2021 21:34:38 +0800
Reply-To: xlpang@linux.alibaba.com
Subject: Re: [PATCH v2 0/3] mm/slub: Fix count_partial() problem
To:     Shu Ming <sming56@gmail.com>, xlpang@linux.alibaba.com
Cc:     Pekka Enberg <penberg@gmail.com>, Vlastimil Babka <vbabka@suse.cz>,
        Christoph Lameter <cl@linux.com>,
        Wen Yang <wenyang@linux.alibaba.com>,
        Roman Gushchin <guro@fb.com>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        David Rientjes <rientjes@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>
References: <1597061872-58724-1-git-send-email-xlpang@linux.alibaba.com>
 <CAOJsxLE9SkLY5V=D=Ot1oyLkbAORagfozYqxk1iNDW6b7QZrwg@mail.gmail.com>
 <f0355157-d70a-893b-5b85-b8cb90e03361@linux.alibaba.com>
 <CANt8P=sOsYUsvJk-KfL8FvxuZm0aoJG6YM5foiierphM3Qjf2Q@mail.gmail.com>
From:   Xunlei Pang <xlpang@linux.alibaba.com>
Message-ID: <cd83c2a6-bc0b-d58b-fc20-a8e027f05cb3@linux.alibaba.com>
Date:   Wed, 3 Mar 2021 21:34:37 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:78.0)
 Gecko/20100101 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <CANt8P=sOsYUsvJk-KfL8FvxuZm0aoJG6YM5foiierphM3Qjf2Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/1/21 6:31 PM, Shu Ming wrote:
> Any progress on this?  The problem addressed by this patch has also
> made jitters to our online apps which are quite annoying.
> 

Thanks for the attention.

There's some further improvements on v2, I'm gonna send v3 out later.

> On Mon, Aug 24, 2020 at 6:05 PM xunlei <xlpang@linux.alibaba.com> wrote:
>>
>> On 2020/8/20 下午10:02, Pekka Enberg wrote:
>>> On Mon, Aug 10, 2020 at 3:18 PM Xunlei Pang <xlpang@linux.alibaba.com> wrote:
>>>>
>>>> v1->v2:
>>>> - Improved changelog and variable naming for PATCH 1~2.
>>>> - PATCH3 adds per-cpu counter to avoid performance regression
>>>>   in concurrent __slab_free().
>>>>
>>>> [Testing]
>>>> On my 32-cpu 2-socket physical machine:
>>>> Intel(R) Xeon(R) CPU E5-2650 v2 @ 2.60GHz
>>>> perf stat --null --repeat 10 -- hackbench 20 thread 20000
>>>>
>>>> == original, no patched
>>>>       19.211637055 seconds time elapsed                                          ( +-  0.57% )
>>>>
>>>> == patched with patch1~2
>>>>  Performance counter stats for 'hackbench 20 thread 20000' (10 runs):
>>>>
>>>>       21.731833146 seconds time elapsed                                          ( +-  0.17% )
>>>>
>>>> == patched with patch1~3
>>>>  Performance counter stats for 'hackbench 20 thread 20000' (10 runs):
>>>>
>>>>       19.112106847 seconds time elapsed                                          ( +-  0.64% )
>>>>
>>>>
>>>> Xunlei Pang (3):
>>>>   mm/slub: Introduce two counters for partial objects
>>>>   mm/slub: Get rid of count_partial()
>>>>   mm/slub: Use percpu partial free counter
>>>>
>>>>  mm/slab.h |   2 +
>>>>  mm/slub.c | 124 +++++++++++++++++++++++++++++++++++++++++++-------------------
>>>>  2 files changed, 89 insertions(+), 37 deletions(-)
>>>
>>> We probably need to wrap the counters under CONFIG_SLUB_DEBUG because
>>> AFAICT all the code that uses them is also wrapped under it.
>>
>> /sys/kernel/slab/***/partial sysfs also uses it, I can wrap it with
>> CONFIG_SLUB_DEBUG or CONFIG_SYSFS for backward compatibility.
>>
>>>
>>> An alternative approach for this patch would be to somehow make the
>>> lock in count_partial() more granular, but I don't know how feasible
>>> that actually is.
>>>
>>> Anyway, I am OK with this approach:
>>>
>>> Reviewed-by: Pekka Enberg <penberg@kernel.org>
>>
>> Thanks!
>>
>>>
>>> You still need to convince Christoph, though, because he had
>>> objections over this approach.
>>
>> Christoph, what do you think, or any better suggestion to address this
>> *in production* issue?
>>
>>>
>>> - Pekka
>>>
