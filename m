Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52C1C39753E
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jun 2021 16:18:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234187AbhFAOUP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Jun 2021 10:20:15 -0400
Received: from m12-16.163.com ([220.181.12.16]:50664 "EHLO m12-16.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233797AbhFAOUM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jun 2021 10:20:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=Subject:From:Message-ID:Date:MIME-Version; bh=y7aHk
        AUo+jSHYQrkZ0j0+dywE+8/NT/eFr5f0mbX19w=; b=I8pMx1xQwT5AeQ0FtD3fX
        Xk8tuAwfhe5FqAwOKuXnk1j8oFPpc57VMiuQ1XfsyqfxaTcKTo3aVnjVldZ3zINo
        3tjmynJIkuwSYmvqZETMj4EXV67ww+R0JdA/4rLSCv0ilDXMPNXrml98YxWVPrBB
        D4BLE2TbrDQxkaaFR57C1o=
Received: from [192.168.31.187] (unknown [36.170.33.212])
        by smtp12 (Coremail) with SMTP id EMCowAB3DEZGQbZgPyF6ug--.19144S2;
        Tue, 01 Jun 2021 22:16:40 +0800 (CST)
Subject: Re: [PATCH] sched/debug:fix stale comments of sched_debug
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Vitor Massaru Iha <vitor@massaru.org>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Wei Yang <richard.weiyang@gmail.com>,
        linux-kernel@vger.kernel.org, Hailong Liu <liu.hailong6@zte.com.cn>
References: <20210530025145.13527-1-liuhailongg6@163.com>
 <YLSUw2Kkq946LQam@smile.fi.intel.com>
 <48a36f92-e8cf-d62b-e4d5-bf6911bcbbcf@163.com>
 <YLUJQp4fdEAW4GzY@smile.fi.intel.com>
 <YLXoQzcUwSO775Z6@hirez.programming.kicks-ass.net>
 <YLYu9YpBDre5BO3F@smile.fi.intel.com>
From:   Hailong Liu <liuhailongg6@163.com>
Message-ID: <a896975e-87f7-d892-4290-d80cfa65cf56@163.com>
Date:   Tue, 1 Jun 2021 22:16:38 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <YLYu9YpBDre5BO3F@smile.fi.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: EMCowAB3DEZGQbZgPyF6ug--.19144S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7tF4DtryfurW7WF18KrW8Crg_yoW8WrWxpa
        s5Xa1qkFnrJryxKrn2yryxGrySqr9a9ry5Xr98WrWUZr98tr1SqFZ7KF429a4kuFWrAF10
        vayrWFnxur1kA37anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jROJOUUUUU=
X-Originating-IP: [36.170.33.212]
X-CM-SenderInfo: xolxxtxlor0wjjw6il2tof0z/1tbi8AikYFuocBD3HQAAsF
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/1/21 8:58 PM, Andy Shevchenko wrote:
> On Tue, Jun 01, 2021 at 09:56:51AM +0200, Peter Zijlstra wrote:
>> On Mon, May 31, 2021 at 07:05:22PM +0300, Andy Shevchenko wrote:
>>>>>> --- a/lib/Kconfig.debug
>>>>>> +++ b/lib/Kconfig.debug
>>>>>> @@ -1166,7 +1166,7 @@ config SCHED_DEBUG
>>>>>>  	depends on DEBUG_KERNEL && PROC_FS
>>>>>
>>>>> Are the dependencies correct?
>>>>
>>>> Based on your suggestion, I checked and it turned out that PROC_FS is not
>>>> the correct dependency, but DEBUG_FS. 
>>>
>>> I guess you missed something.
>>>
>>>> Shoud I change it to DEBUG_FS?
>>>
>>> Please, double check.
>>
>> Thing is that proc_sched_show_task() still wants PROC_FS, i've not yet
>> found a suitable debugfs based location for that.
>>
>> And DEBUG_FS doesn't need a dependency; it has complete DEBUG_FS=n
>> wrappers and will build fine. Arguably selecting SCHED_DEBUG without
>> DEBUG_FS is daft, but it should work.
> 
> Yep, my point here is that we have several files (in procfs and debugfs) which
> are enabled by the same option. Changing help text as it's done in the patch
> seems a half baked solution, i.e. it needs more, like describing what the files
> are visible in different configurations.
> 

Big thanks to Andy and Peter for the views and suggestions.

Personally, neither DEBUG_FS nor RPOC_FS are the building dependencies of
SCHED_DEBUG. However, The visibility of the files(in procfs and debugfs) depends
on both.

So, can I make a compromise and add both PROC_FS and DEBUG_FS as dependencies in
Kconfig; at the same time, add more descriptions of the two situations in the
help text? 

