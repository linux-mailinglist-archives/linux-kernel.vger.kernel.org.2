Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69BF842852E
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Oct 2021 04:38:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233581AbhJKCkm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Oct 2021 22:40:42 -0400
Received: from out30-45.freemail.mail.aliyun.com ([115.124.30.45]:33787 "EHLO
        out30-45.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231872AbhJKCkl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Oct 2021 22:40:41 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R381e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04400;MF=yun.wang@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0UrJKkSy_1633919919;
Received: from testdeMacBook-Pro.local(mailfrom:yun.wang@linux.alibaba.com fp:SMTPD_---0UrJKkSy_1633919919)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 11 Oct 2021 10:38:40 +0800
Subject: Re: [RESEND PATCH v2] trace: prevent preemption in
 perf_ftrace_function_call()
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        open list <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Jiri Olsa <jolsa@redhat.com>
References: <eafba880-c1ae-2b99-c11e-d5041a2f6c3e@linux.alibaba.com>
 <20211008200328.5b88422d@oasis.local.home>
From:   =?UTF-8?B?546L6LSH?= <yun.wang@linux.alibaba.com>
Message-ID: <bcdbccc6-a516-2199-d3be-090a5e9f601d@linux.alibaba.com>
Date:   Mon, 11 Oct 2021 10:38:39 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211008200328.5b88422d@oasis.local.home>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2021/10/9 上午8:03, Steven Rostedt wrote:
> On Tue, 28 Sep 2021 11:12:24 +0800
> 王贇 <yun.wang@linux.alibaba.com> wrote:
> 
>> With CONFIG_DEBUG_PREEMPT we observed reports like:
>>
>>   BUG: using smp_processor_id() in preemptible
>>   caller is perf_ftrace_function_call+0x6f/0x2e0
>>   CPU: 1 PID: 680 Comm: a.out Not tainted
>>   Call Trace:
>>    <TASK>
>>    dump_stack_lvl+0x8d/0xcf
>>    check_preemption_disabled+0x104/0x110
>>    ? optimize_nops.isra.7+0x230/0x230
>>    ? text_poke_bp_batch+0x9f/0x310
>>    perf_ftrace_function_call+0x6f/0x2e0
>>    ...
> 
> It would be useful to see the full backtrace, to know how this
> happened. Please do not shorten back traces.

Here it is, I suppose some where on the path of __text_poke failed to
exempt from ftrace, whose context is allowed to be preempted?

[   18.172274][  T678] BUG: using smp_processor_id() in preemptible [00000000] code: a.out/678
[   18.173734][  T678] caller is perf_ftrace_function_call+0x6f/0x2d0
[   18.174781][  T678] CPU: 0 PID: 678 Comm: a.out Not tainted 5.15.0-rc3-next-20210928+ #637
[   18.176101][  T678] Hardware name: Red Hat KVM, BIOS 0.5.1 01/01/2011
[   18.177137][  T678] Call Trace:
[   18.177696][  T678]  <TASK>
[   18.178197][  T678]  dump_stack_lvl+0x8e/0xd1
[   18.178941][  T678]  check_preemption_disabled+0x103/0x110
[   18.179847][  T678]  ? text_poke_bp_batch+0x95/0x240
[   18.180673][  T678]  ? text_poke_loc_init+0x110/0x110
[   18.181506][  T678]  perf_ftrace_function_call+0x6f/0x2d0
[   18.182394][  T678]  ? 0xffffffffa0106083
[   18.183092][  T678]  ? _find_next_bit+0x10a/0x130
[   18.183881][  T678]  ? find_held_lock+0x2b/0x80
[   18.184648][  T678]  ? exc_int3+0xb/0xd0
[   18.185325][  T678]  0xffffffffa0106083
[   18.185996][  T678]  ? __text_poke+0x580/0x580
[   18.186744][  T678]  ? __text_poke+0x5/0x580
[   18.187471][  T678]  __text_poke+0x5/0x580
[   18.188214][  T678]  text_poke_bp_batch+0x95/0x240
[   18.189071][  T678]  text_poke_flush+0x5d/0x80
[   18.189872][  T678]  ? do_clear_cpu_cap+0x150/0x150
[   18.190732][  T678]  text_poke_queue+0x28/0x90
[   18.191531][  T678]  ftrace_replace_code+0x10f/0x160
[   18.192416][  T678]  ftrace_modify_all_code+0x10d/0x1e0
[   18.193334][  T678]  ? ftrace_ops_test+0xa0/0xa0
[   18.194159][  T678]  ftrace_run_update_code+0x1d/0x80
[   18.195038][  T678]  ftrace_startup.part.0+0x139/0x1b0
[   18.195946][  T678]  register_ftrace_function+0x69/0xb0
[   18.196871][  T678]  perf_ftrace_event_register+0x7c/0xf0
[   18.197811][  T678]  perf_trace_event_init+0x60/0x80
[   18.198689][  T678]  perf_trace_init+0xac/0x120
[   18.199500][  T678]  ? perf_init_event+0x170/0x3a0
[   18.200342][  T678]  perf_tp_event_init+0x2f/0x70
[   18.201185][  T678]  perf_try_init_event+0x56/0x1b0
[   18.202047][  T678]  ? perf_init_event+0x170/0x3a0
[   18.202896][  T678]  perf_init_event+0x13c/0x3a0
[   18.203727][  T678]  perf_event_alloc.part.0+0x47c/0xe50
[   18.204657][  T678]  __do_sys_perf_event_open+0x27b/0x1350
[   18.205624][  T678]  ? do_user_addr_fault+0x2e7/0x8d0
[   18.206539][  T678]  do_syscall_64+0x35/0x80
[   18.207311][  T678]  entry_SYSCALL_64_after_hwframe+0x44/0xae
[   18.208294][  T678] RIP: 0033:0x7ff74a67d4dd
[   18.209068][  T678] Code: 00 c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 6b 89 0c 00 f7 d8 64 89 01 48
[   18.212166][  T678] RSP: 002b:00007ffc36a6bf18 EFLAGS: 00000246 ORIG_RAX: 000000000000012a
[   18.213566][  T678] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007ff74a67d4dd
[   18.214903][  T678] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000020000080
[   18.216232][  T678] RBP: 00007ffc36a6bf20 R08: 0000000000000000 R09: 0000000000401660
[   18.217584][  T678] R10: 00000000ffffffff R11: 0000000000000246 R12: 0000000000401040
[   18.218914][  T678] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
[   18.220283][  T678]  </TASK>
[   18.220910][  T678] BUG: using smp_processor_id() in preemptible [00000000] code: a.out/678
[   18.222362][  T678] caller is perf_ftrace_function_call+0x6f/0x2d0
[   18.223441][  T678] CPU: 0 PID: 678 Comm: a.out Not tainted 5.15.0-rc3-next-20210928+ #637
[   18.224855][  T678] Hardware name: Red Hat KVM, BIOS 0.5.1 01/01/2011
[   18.225946][  T678] Call Trace:
[   18.226552][  T678]  <TASK>
[   18.227102][  T678]  dump_stack_lvl+0x8e/0xd1
[   18.227885][  T678]  check_preemption_disabled+0x103/0x110
[   18.228837][  T678]  ? text_poke_bp_batch+0x95/0x240
[   18.229714][  T678]  ? text_poke_loc_init+0x110/0x110
[   18.230599][  T678]  perf_ftrace_function_call+0x6f/0x2d0
[   18.231541][  T678]  ? 0xffffffffa0106083
[   18.232283][  T678]  ? _find_next_bit+0x10a/0x130
[   18.233118][  T678]  ? find_held_lock+0x2b/0x80
[   18.233926][  T678]  ? exc_int3+0xb/0xd0
[   18.234649][  T678]  0xffffffffa0106083
[   18.235367][  T678]  ? do_sync_core+0x30/0x30
[   18.236153][  T678]  ? __text_poke+0x5/0x580
[   18.236920][  T678]  __text_poke+0x5/0x580
[   18.237666][  T678]  text_poke_bp_batch+0x95/0x240
[   18.238527][  T678]  text_poke_flush+0x5d/0x80
[   18.239321][  T678]  ? do_clear_cpu_cap+0x150/0x150
[   18.240174][  T678]  text_poke_queue+0x28/0x90
[   18.240980][  T678]  ftrace_replace_code+0x10f/0x160
[   18.241859][  T678]  ftrace_modify_all_code+0x10d/0x1e0
[   18.242772][  T678]  ? ftrace_ops_test+0xa0/0xa0
[   18.243593][  T678]  ftrace_run_update_code+0x1d/0x80
[   18.244474][  T678]  ftrace_startup.part.0+0x139/0x1b0
[   18.245376][  T678]  register_ftrace_function+0x69/0xb0
[   18.246290][  T678]  perf_ftrace_event_register+0x7c/0xf0
[   18.247237][  T678]  perf_trace_event_init+0x60/0x80
[   18.248114][  T678]  perf_trace_init+0xac/0x120
[   18.248919][  T678]  ? perf_init_event+0x170/0x3a0
[   18.249767][  T678]  perf_tp_event_init+0x2f/0x70
[   18.250622][  T678]  perf_try_init_event+0x56/0x1b0
[   18.251492][  T678]  ? perf_init_event+0x170/0x3a0
[   18.252336][  T678]  perf_init_event+0x13c/0x3a0
[   18.253167][  T678]  perf_event_alloc.part.0+0x47c/0xe50
[   18.254111][  T678]  __do_sys_perf_event_open+0x27b/0x1350
[   18.255080][  T678]  ? do_user_addr_fault+0x2e7/0x8d0
[   18.256002][  T678]  do_syscall_64+0x35/0x80
[   18.256767][  T678]  entry_SYSCALL_64_after_hwframe+0x44/0xae
[   18.257747][  T678] RIP: 0033:0x7ff74a67d4dd
[   18.258521][  T678] Code: 00 c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 6b 89 0c 00 f7 d8 64 89 01 48
[   18.261620][  T678] RSP: 002b:00007ffc36a6bf18 EFLAGS: 00000246 ORIG_RAX: 000000000000012a
[   18.263025][  T678] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007ff74a67d4dd
[   18.264363][  T678] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000020000080
[   18.265702][  T678] RBP: 00007ffc36a6bf20 R08: 0000000000000000 R09: 0000000000401660
[   18.267050][  T678] R10: 00000000ffffffff R11: 0000000000000246 R12: 0000000000401040
[   18.268383][  T678] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
[   18.269758][  T678]  </TASK>
[   18.270358][  T678] BUG: using smp_processor_id() in preemptible [00000000] code: a.out/678
[   18.271809][  T678] caller is perf_ftrace_function_call+0x6f/0x2d0
[   18.272889][  T678] CPU: 0 PID: 678 Comm: a.out Not tainted 5.15.0-rc3-next-20210928+ #637
[   18.274387][  T678] Hardware name: Red Hat KVM, BIOS 0.5.1 01/01/2011
[   18.275473][  T678] Call Trace:
[   18.276074][  T678]  <TASK>


And this is the way to reproduce:

// autogenerated by syzkaller (https://github.com/google/syzkaller)

#define _GNU_SOURCE

#include <endian.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/syscall.h>
#include <sys/types.h>
#include <unistd.h>

#define BITMASK(bf_off,bf_len) (((1ull << (bf_len)) - 1) << (bf_off))
#define STORE_BY_BITMASK(type,htobe,addr,val,bf_off,bf_len) *(type*)(addr) = htobe((htobe(*(type*)(addr)) & ~BITMASK((bf_off), (bf_len))) | (((type)(val) << (bf_off)) & BITMASK((bf_off), (bf_len))))

int main(void)
{
		syscall(__NR_mmap, 0x1ffff000ul, 0x1000ul, 0ul, 0x32ul, -1, 0ul);
	syscall(__NR_mmap, 0x20000000ul, 0x1000000ul, 7ul, 0x32ul, -1, 0ul);
	syscall(__NR_mmap, 0x21000000ul, 0x1000ul, 0ul, 0x32ul, -1, 0ul);

*(uint32_t*)0x20000080 = 2;
*(uint32_t*)0x20000084 = 0x80;
*(uint8_t*)0x20000088 = 1;
*(uint8_t*)0x20000089 = 0;
*(uint8_t*)0x2000008a = 0;
*(uint8_t*)0x2000008b = 0;
*(uint32_t*)0x2000008c = 0;
*(uint64_t*)0x20000090 = 0;
*(uint64_t*)0x20000098 = 0;
*(uint64_t*)0x200000a0 = 0;
STORE_BY_BITMASK(uint64_t, , 0x200000a8, 0, 0, 1);
STORE_BY_BITMASK(uint64_t, , 0x200000a8, 0, 1, 1);
STORE_BY_BITMASK(uint64_t, , 0x200000a8, 0, 2, 1);
STORE_BY_BITMASK(uint64_t, , 0x200000a8, 0, 3, 1);
STORE_BY_BITMASK(uint64_t, , 0x200000a8, 0, 4, 1);
STORE_BY_BITMASK(uint64_t, , 0x200000a8, 0, 5, 1);
STORE_BY_BITMASK(uint64_t, , 0x200000a8, 0, 6, 1);
STORE_BY_BITMASK(uint64_t, , 0x200000a8, 0, 7, 1);
STORE_BY_BITMASK(uint64_t, , 0x200000a8, 0, 8, 1);
STORE_BY_BITMASK(uint64_t, , 0x200000a8, 0, 9, 1);
STORE_BY_BITMASK(uint64_t, , 0x200000a8, 0, 10, 1);
STORE_BY_BITMASK(uint64_t, , 0x200000a8, 0, 11, 1);
STORE_BY_BITMASK(uint64_t, , 0x200000a8, 0, 12, 1);
STORE_BY_BITMASK(uint64_t, , 0x200000a8, 0, 13, 1);
STORE_BY_BITMASK(uint64_t, , 0x200000a8, 0, 14, 1);
STORE_BY_BITMASK(uint64_t, , 0x200000a8, 0, 15, 2);
STORE_BY_BITMASK(uint64_t, , 0x200000a8, 0, 17, 1);
STORE_BY_BITMASK(uint64_t, , 0x200000a8, 0, 18, 1);
STORE_BY_BITMASK(uint64_t, , 0x200000a8, 0, 19, 1);
STORE_BY_BITMASK(uint64_t, , 0x200000a8, 0, 20, 1);
STORE_BY_BITMASK(uint64_t, , 0x200000a8, 0, 21, 1);
STORE_BY_BITMASK(uint64_t, , 0x200000a8, 0, 22, 1);
STORE_BY_BITMASK(uint64_t, , 0x200000a8, 0, 23, 1);
STORE_BY_BITMASK(uint64_t, , 0x200000a8, 0, 24, 1);
STORE_BY_BITMASK(uint64_t, , 0x200000a8, 0, 25, 1);
STORE_BY_BITMASK(uint64_t, , 0x200000a8, 0, 26, 1);
STORE_BY_BITMASK(uint64_t, , 0x200000a8, 0, 27, 1);
STORE_BY_BITMASK(uint64_t, , 0x200000a8, 0, 28, 1);
STORE_BY_BITMASK(uint64_t, , 0x200000a8, 0, 29, 1);
STORE_BY_BITMASK(uint64_t, , 0x200000a8, 0, 30, 1);
STORE_BY_BITMASK(uint64_t, , 0x200000a8, 0, 31, 1);
STORE_BY_BITMASK(uint64_t, , 0x200000a8, 0, 32, 1);
STORE_BY_BITMASK(uint64_t, , 0x200000a8, 0, 33, 1);
STORE_BY_BITMASK(uint64_t, , 0x200000a8, 0, 34, 1);
STORE_BY_BITMASK(uint64_t, , 0x200000a8, 0, 35, 1);
STORE_BY_BITMASK(uint64_t, , 0x200000a8, 0, 36, 1);
STORE_BY_BITMASK(uint64_t, , 0x200000a8, 0, 37, 1);
STORE_BY_BITMASK(uint64_t, , 0x200000a8, 0, 38, 26);
*(uint32_t*)0x200000b0 = 4;
*(uint32_t*)0x200000b4 = 0;
*(uint64_t*)0x200000b8 = 0;
*(uint64_t*)0x200000c0 = 0;
*(uint64_t*)0x200000c8 = 0;
*(uint64_t*)0x200000d0 = 0;
*(uint32_t*)0x200000d8 = 0;
*(uint32_t*)0x200000dc = 0;
*(uint64_t*)0x200000e0 = 0;
*(uint32_t*)0x200000e8 = 0;
*(uint16_t*)0x200000ec = 0;
*(uint16_t*)0x200000ee = 0;
*(uint32_t*)0x200000f0 = 0;
*(uint32_t*)0x200000f4 = 0;
*(uint64_t*)0x200000f8 = 0;
	syscall(__NR_perf_event_open, 0x20000080ul, 0, 0ul, -1, 0ul);
	return 0;
}

Regards,
Michael Wang

> 
> -- Steve
> 
>>    __text_poke+0x5/0x620
>>    text_poke_bp_batch+0x9f/0x310
>>
>> This telling us the CPU could be changed after task is preempted, and
>> the checking on CPU before preemption will be invalid.
>>
>> This patch just turn off preemption in perf_ftrace_function_call()
>> to prevent CPU changing.
>>
>> Reported-by: Abaci <abaci@linux.alibaba.com>
>> Signed-off-by: Michael Wang <yun.wang@linux.alibaba.com>
>> ---
>>  kernel/trace/trace_event_perf.c | 17 +++++++++++++----
>>  1 file changed, 13 insertions(+), 4 deletions(-)
>>
>> diff --git a/kernel/trace/trace_event_perf.c b/kernel/trace/trace_event_perf.c
>> index 6aed10e..dcbefdf 100644
>> --- a/kernel/trace/trace_event_perf.c
>> +++ b/kernel/trace/trace_event_perf.c
>> @@ -441,12 +441,19 @@ void perf_trace_buf_update(void *record, u16 type)
>>  	if (!rcu_is_watching())
>>  		return;
>>
>> +	/*
>> +	 * Prevent CPU changing from now on. rcu must
>> +	 * be in watching if the task was migrated and
>> +	 * scheduled.
>> +	 */
>> +	preempt_disable_notrace();
>> +
>>  	if ((unsigned long)ops->private != smp_processor_id())
>> -		return;
>> +		goto out;
>>
>>  	bit = ftrace_test_recursion_trylock(ip, parent_ip);
>>  	if (bit < 0)
>> -		return;
>> +		goto out;
>>
>>  	event = container_of(ops, struct perf_event, ftrace_ops);
>>
>> @@ -468,16 +475,18 @@ void perf_trace_buf_update(void *record, u16 type)
>>
>>  	entry = perf_trace_buf_alloc(ENTRY_SIZE, NULL, &rctx);
>>  	if (!entry)
>> -		goto out;
>> +		goto unlock;
>>
>>  	entry->ip = ip;
>>  	entry->parent_ip = parent_ip;
>>  	perf_trace_buf_submit(entry, ENTRY_SIZE, rctx, TRACE_FN,
>>  			      1, &regs, &head, NULL);
>>
>> -out:
>> +unlock:
>>  	ftrace_test_recursion_unlock(bit);
>>  #undef ENTRY_SIZE
>> +out:
>> +	preempt_enable_notrace();
>>  }
>>
>>  static int perf_ftrace_function_register(struct perf_event *event)
