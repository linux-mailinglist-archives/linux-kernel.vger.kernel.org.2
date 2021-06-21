Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17E253AE147
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jun 2021 03:21:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230075AbhFUBXw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Jun 2021 21:23:52 -0400
Received: from mail.loongson.cn ([114.242.206.163]:53046 "EHLO loongson.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229877AbhFUBXv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Jun 2021 21:23:51 -0400
Received: from [10.130.0.135] (unknown [113.200.148.30])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9Dxn0Cb6c9gjvkUAA--.2660S3;
        Mon, 21 Jun 2021 09:21:32 +0800 (CST)
Subject: Re: [RFC PATCH 1/2] ftrace: Introduce cmdline argument
 ftrace_disabled
To:     Steven Rostedt <rostedt@goodmis.org>
References: <1624084160-3342-1-git-send-email-yangtiezhu@loongson.cn>
 <1624084160-3342-2-git-send-email-yangtiezhu@loongson.cn>
 <20210619112202.0a2c7196@gandalf.local.home>
Cc:     Ingo Molnar <mingo@redhat.com>, Jonathan Corbet <corbet@lwn.net>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Xuefeng Li <lixuefeng@loongson.cn>
From:   Tiezhu Yang <yangtiezhu@loongson.cn>
Message-ID: <6847bf76-698d-a314-0825-803b48cb8740@loongson.cn>
Date:   Mon, 21 Jun 2021 09:21:31 +0800
User-Agent: Mozilla/5.0 (X11; Linux mips64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <20210619112202.0a2c7196@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: AQAAf9Dxn0Cb6c9gjvkUAA--.2660S3
X-Coremail-Antispam: 1UD129KBjvJXoW7Zr15tF4kXF48JFWfKFWfZrb_yoW8KF43pa
        4xtasrtF4UXF4q9asru348Jry5J3ykXFWxta4DC3y5tws8Crn5Xrs2kr4qg3Z7Kr18G34a
        vF18Ar1Uur4xZFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvl14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
        6r4UJwA2z4x0Y4vEx4A2jsIE14v26F4j6r4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr
        1j6F4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv
        7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r
        1j6r4UM4x0Y48IcVAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCYjI0SjxkI62AI1cAE
        67vIY487MxkIecxEwVAFwVWkMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r
        4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF
        67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2I
        x0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_WFyUJVCq3wCI42IY
        6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvj
        DU0xZFpf9x0JUHpB-UUUUU=
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/19/2021 11:22 PM, Steven Rostedt wrote:
> On Sat, 19 Jun 2021 14:29:19 +0800
> Tiezhu Yang <yangtiezhu@loongson.cn> wrote:
>
>> If set CONFIG_FUNCTION_TRACER=y, we can use the following command to
>> disable ftrace after boot up:
>> echo 0 > /proc/sys/kernel/ftrace_enabled
> I'd love to just remove that. It's original purpose was to stop function
> tracing when the latency tracers were active. That's now done via a tracefs
> option. The "ftrace_enabled" really has no use anymore.
>
>> ftrace_disabled is much stronger than ftrace_enabled, introduce a new
>> cmdline argument ftrace_disabled for user to control whether to disable
>> ftrace when boot up.
> "ftrace_disabled" is triggered when an anomaly is detected, and for the
> safety of the system, ftrace shuts down. It was never meant to be a user
> triggered event.

Thanks for your explanation.

>
> You have no rationale for this change. What's the purpose of this?

The "System Benchmarks Index Score" of UnixBench under FUNCTION_TRACER
is lower than !FUNCTION_TRACER, I want to use this new cmdline argument
ftrace_disabled to test it, this is the original intention.

I see the following help info of "config FUNCTION_TRACER":

[If it's runtime disabled (the bootup default), then the overhead of the
instructions is very small and not measurable even in micro-benchmarks.]

I am not quite understand the above description, could you tell me how to
avoid the runtime performance overhead under FUNCTION_TRACER?

Thanks,
Tiezhu

>
> -- Steve
>
>
>> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
>> ---
>>   kernel/trace/ftrace.c | 8 ++++++++
>>   1 file changed, 8 insertions(+)
>>
>> diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
>> index 72ef4dc..a015699 100644
>> --- a/kernel/trace/ftrace.c
>> +++ b/kernel/trace/ftrace.c
>> @@ -5517,6 +5517,14 @@ static char ftrace_filter_buf[FTRACE_FILTER_SIZE] __initdata;
>>   /* Used by function selftest to not test if filter is set */
>>   bool ftrace_filter_param __initdata;
>>   
>> +static int __init set_ftrace_disabled(char *str)
>> +{
>> +	pr_info("Set ftrace_disabled to disable ftrace\n");
>> +	ftrace_disabled = 1;
>> +	return 1;
>> +}
>> +__setup("ftrace_disabled", set_ftrace_disabled);
>> +
>>   static int __init set_ftrace_notrace(char *str)
>>   {
>>   	ftrace_filter_param = true;

