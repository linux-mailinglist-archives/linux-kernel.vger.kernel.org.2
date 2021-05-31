Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 720A9396792
	for <lists+linux-kernel@lfdr.de>; Mon, 31 May 2021 20:04:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231722AbhEaSFr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 May 2021 14:05:47 -0400
Received: from m12-13.163.com ([220.181.12.13]:51626 "EHLO m12-13.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230322AbhEaSFk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 May 2021 14:05:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=Subject:From:Message-ID:Date:MIME-Version; bh=QVlp2
        KPq4nHytbJlZ9eqCGWbTYp33N2mu88aDRD1aNk=; b=fQD4Px9kyuoIGxPvfSj25
        l1EaEc1oaT8hyIWKJG1Yxf6YkxOpUgbatHB8MDjbR7rd5qMkvAfAXvC4Dn8RMt5C
        qni5Wwz6NaFUeCE5oIkex07gS+FFEeDQKQiXUKBnkHBnbasxW39lzG5GG5XW+0A5
        8j3y9l57WMfjQrREaIPghg=
Received: from [192.168.31.187] (unknown [36.170.33.212])
        by smtp9 (Coremail) with SMTP id DcCowAC3m80g7rRg+sUNDw--.7273S2;
        Mon, 31 May 2021 22:09:38 +0800 (CST)
Subject: Re: [PATCH] sched/debug:fix stale comments of sched_debug
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
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
From:   Hailong Liu <liuhailongg6@163.com>
Message-ID: <48a36f92-e8cf-d62b-e4d5-bf6911bcbbcf@163.com>
Date:   Mon, 31 May 2021 22:09:36 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <YLSUw2Kkq946LQam@smile.fi.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: DcCowAC3m80g7rRg+sUNDw--.7273S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7CFyDKw15Wr4xuw4UXF43ZFb_yoW8GFy3pa
        4kWw1UCFyDGF1rtr1Iy34xXryfAr93Ar1jqFyUZryjy345C3ySqrZ8KFZruF4xXws5Ary8
        XFWY93srXwn8A3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jROJOUUUUU=
X-Originating-IP: [36.170.33.212]
X-CM-SenderInfo: xolxxtxlor0wjjw6il2tof0z/1tbi8AKjYFuocAJlEwAAsG
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/31/21 3:48 PM, Andy Shevchenko wrote:
> On Sun, May 30, 2021 at 10:51:45AM +0800, Hailong Liu wrote:
>> From: Hailong Liu <liu.hailong6@zte.com.cn>
>>
>> Now /proc/sched_debug has been moved to debugfs, so make the comments
>> consistent with it.
> 
> Have you checked if the very same Kconfig option is used for something
> slightly different as well?

Do you mean that I need to check whether SCHED_DEBUG is also related to
other features? 

>> Signed-off-by: Hailong Liu <liu.hailong6@zte.com.cn>
> 
> Missed SoB tag of the submitter.

In fact the exiting SoB tag of this patch is the actual submitter. 

I'm sorry that the inconsistency between the submission email and the SoB
email address caused you to feel confused. 

For some personal reasons, I had to use an email at home and mark another
email address as the submitter. 

> 
>> --- a/lib/Kconfig.debug
>> +++ b/lib/Kconfig.debug
>> @@ -1166,7 +1166,7 @@ config SCHED_DEBUG
>>  	depends on DEBUG_KERNEL && PROC_FS
> 
> Are the dependencies correct?

Based on your suggestion, I checked and it turned out that PROC_FS is not
the correct dependency, but DEBUG_FS. 

Shoud I change it to DEBUG_FS? 

>>  	default y
>>  	help
>> -	  If you say Y here, the /proc/sched_debug file will be provided
>> +	  If you say Y here, the debugfs/sched/debug file will be provided
>>  	  that can help debug the scheduler. The runtime overhead of this
>>  	  option is minimal.
> 

Thanks,

Hailong

