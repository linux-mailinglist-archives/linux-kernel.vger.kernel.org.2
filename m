Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1D3B354DD3
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Apr 2021 09:28:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233621AbhDFH2F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Apr 2021 03:28:05 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:15606 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbhDFH2E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Apr 2021 03:28:04 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4FDzZx15dzz19Kn3;
        Tue,  6 Apr 2021 15:25:45 +0800 (CST)
Received: from [10.67.110.108] (10.67.110.108) by
 DGGEMS413-HUB.china.huawei.com (10.3.19.213) with Microsoft SMTP Server id
 14.3.498.0; Tue, 6 Apr 2021 15:27:51 +0800
Subject: Re: [PATCH] riscv: keep interrupts disabled for BREAKPOINT exception
To:     Jisheng Zhang <jszhang3@mail.ustc.edu.cn>
CC:     Masami Hiramatsu <mhiramat@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Guo Ren <guoren@linux.alibaba.com>,
        <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>
References: <20210330021624.2b776386@xhacker>
 <20210330183316.942215efe8e6e8455ad14113@kernel.org>
 <20210331222244.45a5807c@xhacker>
 <096752a7-21f9-8339-2e76-8c65859fa1d7@huawei.com>
 <20210402213206.7db93785@xhacker>
From:   "liaochang (A)" <liaochang1@huawei.com>
Message-ID: <a00d3c12-bbb9-1849-47ce-75c320ed5900@huawei.com>
Date:   Tue, 6 Apr 2021 15:27:51 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.3
MIME-Version: 1.0
In-Reply-To: <20210402213206.7db93785@xhacker>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.110.108]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jisheng,

在 2021/4/2 21:32, Jisheng Zhang 写道:
> On Thu, 1 Apr 2021 16:49:47 +0800
> "liaochang (A)" <liaochang1@huawei.com> wrote:
> 
>> Hi Jisheng,
> 
> Hi,
> 
>>
>> 在 2021/3/31 22:22, Jisheng Zhang 写道:
>>> On Tue, 30 Mar 2021 18:33:16 +0900
>>> Masami Hiramatsu <mhiramat@kernel.org> wrote:
>>>   
>>>> Hi Jisheng,  
>>>
>>> Hi Masami,
>>>   
>>>>
>>>> On Tue, 30 Mar 2021 02:16:24 +0800
>>>> Jisheng Zhang <jszhang3@mail.ustc.edu.cn> wrote:
>>>>  
>>>>> From: Jisheng Zhang <jszhang@kernel.org>
>>>>>
>>>>> Current riscv's kprobe handlers are run with both preemption and
>>>>> interrupt enabled, this violates kprobe requirements. Fix this issue
>>>>> by keeping interrupts disabled for BREAKPOINT exception.    
>>>>
>>>> Not only while the breakpoint exception but also until the end of
>>>> the single step (maybe you are using __BUG_INSN_32 ??) need to be
>>>> disable interrupts. Can this do that?
>>>>  
>>>
>>> interrupt is disabled during "single step" by kprobes_save_local_irqflag()
>>> and kprobes_restore_local_irqflag(). The code flow looks like: 
>>>
>>> do_trap_break()   // for bp
>>>   kprobe_breakpoint_handler()
>>>     setup_singlestep()
>>>       kprobes_restore_local_irqflag()
>>>
>>> do_trap_break()  // for ss
>>>   kprobe_single_step_handler()
>>>     kprobes_restore_local_irqflag()  
>>
>> Recently, kernel hit BUG_ON() on QEMU after I install a probe at "sys_read" via kprobe,
> 
> TIPS: Each line should not exceed 80 chars
> 
>> accoriding to my debugging and analysis it looks like caused by the "irq disable" operation for single-stepping.
>>
>> I present a detailed description about this problem in the mail with title "[PATCH] riscv/kprobe: fix kernel panic when invoking sys_read traced by kprobe".
>> Looking forward to some feedback,Thanks.
>>
> 
> I will comment that patch.

Thanks for your reminder.

> 
> thanks
> 
> .
> 
