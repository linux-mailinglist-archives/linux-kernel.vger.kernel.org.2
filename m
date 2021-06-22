Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A7DF3AFA8C
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jun 2021 03:19:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230249AbhFVBVq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Jun 2021 21:21:46 -0400
Received: from mail.loongson.cn ([114.242.206.163]:33754 "EHLO loongson.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229663AbhFVBVp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jun 2021 21:21:45 -0400
Received: from [10.130.0.135] (unknown [113.200.148.30])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9DxP0OZOtFgIJoVAA--.3536S3;
        Tue, 22 Jun 2021 09:19:22 +0800 (CST)
Subject: Re: [RFC PATCH 1/2] ftrace: Introduce cmdline argument
 ftrace_disabled
To:     Steven Rostedt <rostedt@goodmis.org>
References: <1624084160-3342-1-git-send-email-yangtiezhu@loongson.cn>
 <1624084160-3342-2-git-send-email-yangtiezhu@loongson.cn>
 <20210619112202.0a2c7196@gandalf.local.home>
 <6847bf76-698d-a314-0825-803b48cb8740@loongson.cn>
 <20210621100004.7c1505be@oasis.local.home>
Cc:     Ingo Molnar <mingo@redhat.com>, Jonathan Corbet <corbet@lwn.net>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Xuefeng Li <lixuefeng@loongson.cn>
From:   Tiezhu Yang <yangtiezhu@loongson.cn>
Message-ID: <db070d1c-9320-378e-52b5-a7d551e0f1a6@loongson.cn>
Date:   Tue, 22 Jun 2021 09:19:21 +0800
User-Agent: Mozilla/5.0 (X11; Linux mips64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <20210621100004.7c1505be@oasis.local.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: AQAAf9DxP0OZOtFgIJoVAA--.3536S3
X-Coremail-Antispam: 1UD129KBjvJXoW7AFW8Kw1xtw4DAF4DXrW5Wrg_yoW8Zr1Upa
        9rtw1ayFZ7Xan0va13Zr48J34aya1kXrZ3AF1jkrW0vws8Gr4fXrWktw42gasrJ34Igrya
        v3W0y34UZFs8Zw7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvG14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
        6r4UJwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r
        4UJVWxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2Wl
        Yx0E2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbV
        WUJVW8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc7I2V7IY0VAS07Al
        zVAYIcxG8wCY02Avz4vE14v_KwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJV
        W8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF
        1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6x
        IIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6rW3Jr0E3s1lIxAI
        cVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa
        73UjIFyTuYvjfUFVyIUUUUU
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/21/2021 10:00 PM, Steven Rostedt wrote:
> On Mon, 21 Jun 2021 09:21:31 +0800
> Tiezhu Yang <yangtiezhu@loongson.cn> wrote:
>
>>> You have no rationale for this change. What's the purpose of this?
>> The "System Benchmarks Index Score" of UnixBench under FUNCTION_TRACER
>> is lower than !FUNCTION_TRACER, I want to use this new cmdline argument
>> ftrace_disabled to test it, this is the original intention.
>>
>> I see the following help info of "config FUNCTION_TRACER":
>>
>> [If it's runtime disabled (the bootup default), then the overhead of the
>> instructions is very small and not measurable even in micro-benchmarks.]
> Those benchmarks were done a long time ago, and they may be measurable today :-/
>
>> I am not quite understand the above description, could you tell me how to
>> avoid the runtime performance overhead under FUNCTION_TRACER?
> Anyway, your patch wont do anything to change the benchmarks.
>
> When CONFIG_FUNCTION_TRACER is enabled, on x86_64, most functions will
> start with a call to fentry. At boot up, these functions will be
> converted over to become a nop. And thinking about it, "ftrace_disable"
> stops all conversions, so if you add that to the kernel command line,
> those calls to fentry, wont be converted to nops, and you'll make
> things much worse!
>
> Now, some versions of gcc (and perhaps clang) can do the conversion to
> nops at compile time (in which case, your patch would keep the nops and
> not the calls to fentry).
>
> The overhead that FUNCTION_TRACER adds is the 5 byte nop at the start
> of most functions. This causes a slight hit to instruction cache, and a
> minuscule amount of time in the instruction pipeline of the CPU. This
> is the "overhead" that is talked about. Your patch doesn't do anything
> to address it. The only way to remove that overhead is to compile the
> kernel without CONFIG_FUNCTION_TRACER.
>
> -- Steve

OK, I see, thank you very much.

Thanks,
Tiezhu

