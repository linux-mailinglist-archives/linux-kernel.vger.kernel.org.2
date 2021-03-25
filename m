Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04441348784
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Mar 2021 04:31:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231235AbhCYDao (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 23:30:44 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:13690 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231488AbhCYDaV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 23:30:21 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4F5Vsq3ntbznVW3;
        Thu, 25 Mar 2021 11:27:43 +0800 (CST)
Received: from [10.174.187.80] (10.174.187.80) by
 DGGEMS412-HUB.china.huawei.com (10.3.19.212) with Microsoft SMTP Server id
 14.3.498.0; Thu, 25 Mar 2021 11:30:04 +0800
From:   wangjian <wangjian161@huawei.com>
To:     <tglx@linutronix.de>, <fweisbec@gmail.com>, <mingo@kernel.org>,
        <akpm@linux-foundation.org>
CC:     <linux-kernel@vger.kernel.org>, <kenel-bugs@openeuler.org>,
        <dev@openeuler.org>, <eric.fangyi@huawei.com>
Subject: [question] kernel panic at timerqueue_add+32
Message-ID: <912acd9b-5639-ddef-a394-c02dc82923e6@huawei.com>
Date:   Thu, 25 Mar 2021 11:29:56 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
Content-Type: text/plain; charset="gbk"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.187.80]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On the x86 platform, we encountered the following problems. The kernel version we are using is 3.10. The following is our analysis process, hoping to get your help.

kernel panic at timerqueue_add+32.The stack information is as follows.

crash> bt -c 3
PID: 27797  TASK: ffff9f9e28805f40  CPU: 3   COMMAND: "ipmi_sim"
#0 [ffff9f9ec0ac3dd0] die at ffffffffac82f97b
#1 [ffff9f9ec0ac3e00] do_general_protection at ffffffffacf3211e
#2 [ffff9f9ec0ac3e30] general_protection at ffffffffacf31718
    [exception RIP: timerqueue_add+32]
    RIP: ffffffffacb67340  RSP: ffff9f9ec0ac3ee0  RFLAGS: 00010006
    RAX: 7401f88348078b48  RBX: ffff9f9ec0ad3fa0  RCX: 0000000000000000
    RDX: ffffffffac8d4395  RSI: ffff9f9ec0ad3fa0  RDI: ffffffffac8d4395
    RBP: ffff9f9ec0ac3ef0   R8: 00405b31f6958080   R9: ffff9f9ec0ac3de0
    R10: 0000000000000002  R11: ffff9f9ec0ac3de8  R12: ffffffffac8d4395
    R13: ffffffffac8d4385  R14: 0000000000000001  R15: ffff9f9ec0ad3b58
    ORIG_RAX: ffffffffffffffff  CS: 0010  SS: 0018
#3 [ffff9f9ec0ac3ef8] enqueue_hrtimer at ffffffffac8c32f5
#4 [ffff9f9ec0ac3f20] __hrtimer_run_queues at ffffffffac8c3c7d
#5 [ffff9f9ec0ac3f78] hrtimer_interrupt at ffffffffac8c41af
#6 [ffff9f9ec0ac3fc0] local_apic_timer_interrupt at ffffffffac85aeeb
#7 [ffff9f9ec0ac3fd8] smp_apic_timer_interrupt at ffffffffacf3f0a3
#8 [ffff9f9ec0ac3ff0] apic_timer_interrupt at ffffffffacf3b7ba
--- <IRQ stack> ---
bt: cannot transition from IRQ stack to current process stack:
        IRQ stack pointer: ffff9f9ec0ac3dd0
    process stack pointer: ffff9f708e693df8
       current stack base: ffff9f9e25764000

We first parse timerqueue_add+32

crash> dis -l timerqueue_add+32
/usr/src/debug/kernel-3.10.0/linux-3.10.0-862.14.1.6_110.x86_64/lib/timerqueue.c: 52
0xffffffffacb67340 <timerqueue_add+32>: mov    0x18(%rax),%rsi

39 void timerqueue_add(struct timerqueue_head *head, struct timerqueue_node *node)
40 {
41         struct rb_node **p = &head->head.rb_node;
42         struct rb_node *parent = NULL;
43         struct timerqueue_node  *ptr;
44
45         /* Make sure we don't add nodes that are already added */
46         WARN_ON_ONCE(!RB_EMPTY_NODE(&node->node));
47
48         while (*p) {
49                 parent = *p;
50                 ptr = rb_entry(parent, struct timerqueue_node, node);
51                 if (node->expires.tv64 < ptr->expires.tv64)
52                         p = &(*p)->rb_left; //at here, the p is the invalid address
53                 else
54                         p = &(*p)->rb_right;
55         }
56         rb_link_node(&node->node, parent, p);
57         rb_insert_color(&node->node, &head->head);
58
59         if (!head->next || node->expires.tv64 < head->next->expires.tv64)
60                 head->next = node;
61 }
62 EXPORT_SYMBOL_GPL(timerqueue_add);


Let's disassemble the timerqueue_add function, the following is the part of the disassembled code of the timerqueue_add function
crash> dis -l timerqueue_add
/usr/src/debug/kernel-3.10.0/linux-3.10.0-862.14.1.6_110.x86_64/lib/timerqueue.c: 40
0xffffffffacb67320 <timerqueue_add>:    push   %rbp
0xffffffffacb67321 <timerqueue_add+1>:  mov    %rsp,%rbp
0xffffffffacb67324 <timerqueue_add+4>:  push   %r12
0xffffffffacb67326 <timerqueue_add+6>:  mov    %rdi,%r12
0xffffffffacb67329 <timerqueue_add+9>:  push   %rbx
/usr/src/debug/kernel-3.10.0/linux-3.10.0-862.14.1.6_110.x86_64/lib/timerqueue.c: 46
0xffffffffacb6732a <timerqueue_add+10>: cmp    (%rsi),%rsi
/usr/src/debug/kernel-3.10.0/linux-3.10.0-862.14.1.6_110.x86_64/lib/timerqueue.c: 40
0xffffffffacb6732d <timerqueue_add+13>: mov    %rsi,%rbx
/usr/src/debug/kernel-3.10.0/linux-3.10.0-862.14.1.6_110.x86_64/lib/timerqueue.c: 46
0xffffffffacb67330 <timerqueue_add+16>: jne    0xffffffffacb6739e <timerqueue_add+126>
/usr/src/debug/kernel-3.10.0/linux-3.10.0-862.14.1.6_110.x86_64/lib/timerqueue.c: 41
0xffffffffacb67332 <timerqueue_add+18>: mov    %r12,%rdx
/usr/src/debug/kernel-3.10.0/linux-3.10.0-862.14.1.6_110.x86_64/lib/timerqueue.c: 42
0xffffffffacb67335 <timerqueue_add+21>: xor    %ecx,%ecx
/usr/src/debug/kernel-3.10.0/linux-3.10.0-862.14.1.6_110.x86_64/lib/timerqueue.c: 48
0xffffffffacb67337 <timerqueue_add+23>: jmp    0xffffffffacb67357 <timerqueue_add+55>
0xffffffffacb67339 <timerqueue_add+25>: nopl   0x0(%rax)
/usr/src/debug/kernel-3.10.0/linux-3.10.0-862.14.1.6_110.x86_64/lib/timerqueue.c: 52
0xffffffffacb67340 <timerqueue_add+32>: mov    0x18(%rax),%rsi  //rax is the p
0xffffffffacb67344 <timerqueue_add+36>: cmp    %rsi,0x18(%rbx)
0xffffffffacb67348 <timerqueue_add+40>: lea    0x8(%rax),%rcx
0xffffffffacb6734c <timerqueue_add+44>: lea    0x10(%rax),%rdx
0xffffffffacb67350 <timerqueue_add+48>: cmovge %rcx,%rdx
0xffffffffacb67354 <timerqueue_add+52>: mov    %rax,%rcx
/usr/src/debug/kernel-3.10.0/linux-3.10.0-862.14.1.6_110.x86_64/lib/timerqueue.c: 48
0xffffffffacb67357 <timerqueue_add+55>: mov    (%rdx),%rax
0xffffffffacb6735a <timerqueue_add+58>: test   %rax,%rax
0xffffffffacb6735d <timerqueue_add+61>: jne    0xffffffffacb67340 <timerqueue_add+32>

Through the disassembly code of the timerqueue_add function, you can see that rdi is the first parameter of the timerqueue_add function (struct timerqueue_head *head),
and rsi is the second parameter of the timerqueue_add function (struct timerqueue_node *node).


We go to parse rdi (ffffffffac8d4395) and rsi(ffff9f9ec0ad3fa0) to get the value of the parameter. The result is as follows.
crash> struct timerqueue_head -ox
struct timerqueue_head {
   [0x0] struct rb_root head;
   [0x8] struct timerqueue_node *next;
}
SIZE: 0x10
crash> struct timerqueue_head  ffffffffac8d4395
struct timerqueue_head {
  head = {
    rb_node = 0x7401f88348078b48 //the invalid address p
  },
  next = 0x415541e58948556e
}
From the above, We can see that the first parameter (struct timerqueue_head *head) passed into the timerqueue_add function is an incorrect address ffffffffac8d4395(rdi).

Let me see the code of the enqueue_hrtimer function and the corresponding part of disassembly code. The result is as follows.
851 static int enqueue_hrtimer(struct hrtimer *timer,
852                            struct hrtimer_clock_base *base)
853 {
854         debug_activate(timer);
855
856         timerqueue_add(&base->active, &timer->node);
857         base->cpu_base->active_bases |= 1 << base->index;
858
859         /*
860          * HRTIMER_STATE_ENQUEUED is or'ed to the current state to preserve the
861          * state of a possibly running callback.
862          */
863         timer->state |= HRTIMER_STATE_ENQUEUED;
864
865         return (&timer->node == base->active.next);
866 }

crash>  dis -l enqueue_hrtimer
/usr/src/debug/kernel-3.10.0/linux-3.10.0-862.14.1.6_110.x86_64/kernel/hrtimer.c: 853
0xffffffffac8c32d0 <enqueue_hrtimer>:   nopl   0x0(%rax,%rax,1) [FTRACE NOP]
0xffffffffac8c32d5 <enqueue_hrtimer+5>: push   %rbp
0xffffffffac8c32d6 <enqueue_hrtimer+6>: mov    %rsp,%rbp
0xffffffffac8c32d9 <enqueue_hrtimer+9>: push   %r13
0xffffffffac8c32db <enqueue_hrtimer+11>:        mov    %rsi,%r13
0xffffffffac8c32de <enqueue_hrtimer+14>:        push   %r12
0xffffffffac8c32e0 <enqueue_hrtimer+16>:        mov    %rdi,%r12
0xffffffffac8c32e3 <enqueue_hrtimer+19>:        push   %rbx
0xffffffffac8c32e4 <enqueue_hrtimer+20>:        nopl   0x0(%rax,%rax,1)
/usr/src/debug/kernel-3.10.0/linux-3.10.0-862.14.1.6_110.x86_64/kernel/hrtimer.c: 856
0xffffffffac8c32e9 <enqueue_hrtimer+25>:        lea    0x10(%r13),%rdi
0xffffffffac8c32ed <enqueue_hrtimer+29>:        mov    %r12,%rsi
0xffffffffac8c32f0 <enqueue_hrtimer+32>:        callq  0xffffffffacb67320 <timerqueue_add>

As can be seen from the above, r13 is ffffffffac8d4385 (0xffffffffac8d4395-0x10), so the second input parameter struct hrtimer_clock_base *base of the enqueue_hrtimer function is ffffffffac8d4385. r12 is ffff9f9ec0ad3fa0, so the first input parameter of enqueue_hrtimer function struct hrtimer *timer and the second input parameter of timerqueue_add are both ffff9f9ec0ad3fa0.

Then we analyze the first input parameter struct hrtimer *timer of the enqueue_hrtimer function, that is, the second input parameter of timerqueue_add. The result is as follows
crash> struct hrtimer -ox
struct hrtimer {
   [0x0] struct timerqueue_node node;
  [0x20] ktime_t _softexpires;
  [0x28] enum hrtimer_restart (*function)(struct hrtimer *);
  [0x30] struct hrtimer_clock_base *base;
  [0x38] unsigned long state;
  [0x40] int start_pid;
  [0x48] void *start_site;
  [0x50] char start_comm[16];
}
SIZE: 0x60
crash> struct hrtimer ffff9f9ec0ad3fa0
struct hrtimer {
  node = {
    node = {
      __rb_parent_color = 18446638102919069600,  //0xffff9f9ec0ad3fa0
      rb_right = 0x0,
      rb_left = 0x0
    },
    expires = {
      tv64 = 18114668659000000
    }
  },
  _softexpires = {
    tv64 = 18114668659000000
  },
  function = 0xffffffffac9083f0,  //tick_sched_timer function
  base = 0xffff9f9ec0ad3a60, //correct struct hrtimer_clock_base
  state = 2,
  start_pid = 0,
  start_site = 0x0,
  start_comm = "\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000"
}
It can be seen from the above that hrtimer(struct hrtimer ffff9f9ec0ad3fa0) is correct.
At the same time base = 0xffff9f9ec0ad3a60 is the correct struct hrtimer_clock_base, which we will prove below.

Next, we need to reason from top to bottom in accordance with the function call process. The call flow of the function is like this: hrtimer_interrupt -> __hrtimer_run_queues -> __run_hrtimer (optimized by the compiler) -> enqueue_hrtimer ->enqueue_hrtimer

Let's look at the hrtimer_interrupt function first, the following is part of the code of the hrtimer_interrupt function.

void hrtimer_interrupt(struct clock_event_device *dev)
{
        struct hrtimer_cpu_base *cpu_base = this_cpu_ptr(&hrtimer_bases);
        ktime_t expires_next, now, entry_time, delta;
        int retries = 0;

        BUG_ON(!cpu_base->hres_active);
        cpu_base->nr_events++;
        dev->next_event.tv64 = KTIME_MAX;

        raw_spin_lock(&cpu_base->lock);
        entry_time = now = hrtimer_update_base(cpu_base);
retry:
        cpu_base->in_hrtirq = 1;
        /*
         * We set expires_next to KTIME_MAX here with cpu_base->lock
         * held to prevent that a timer is enqueued in our queue via
         * the migration code. This does not affect enqueueing of
         * timers which run their callback and need to be requeued on
         * this CPU.
         */
        cpu_base->expires_next.tv64 = KTIME_MAX;

        __hrtimer_run_queues(cpu_base, now);

        /* Reevaluate the clock bases for the next expiry */
        expires_next = __hrtimer_get_next_event(cpu_base);
        ......
}

We can see that hrtimer_bases is a per_cpu variable, let's parse hrtimer_bases. The result is as follows.
crash> p hrtimer_bases
PER-CPU DATA TYPE:
  struct hrtimer_cpu_base hrtimer_bases;
PER-CPU ADDRESSES:
  [0]: ffff9f9ec0a13a20
  [1]: ffff9f9ec0a53a20
  [2]: ffff9f9ec0a93a20
  [3]: ffff9f9ec0ad3a20
  [4]: ffff9f9ec0b13a20

The problem occurs on cpu3, so for cpu3, the address of struct hrtimer_cpu_base is ffff9f9ec0ad3a20. Let's take a look at the structure of struct hrtimer_cpu_base.
crash> struct hrtimer_cpu_base -ox
struct hrtimer_cpu_base {
    [0x0] raw_spinlock_t lock;
    [0x4] unsigned int active_bases;
    [0x8] unsigned int clock_was_set;
   [0x10] ktime_t expires_next;
   [0x18] int hres_active;
   [0x1c] int hang_detected;
   [0x20] unsigned long nr_events;
   [0x28] unsigned long nr_retries;
   [0x30] unsigned long nr_hangs;
   [0x38] ktime_t max_hang_time;
   [0x40] struct hrtimer_clock_base clock_base[4];
  [0x140] int cpu;
  [0x144] int in_hrtirq;
}

You can see that the offset of struct hrtimer_clock_base clock_base[0] in struct hrtimer_cpu_base is 0x40, so the address of struct hrtimer_clock_base clock_base[0] is 0xffff9f9ec0ad3a60 = 0xffff9f9ec0ad3a20 + 0x40.
0xffff9f9ec0ad3a60 is just the struct hrtimer_clock_base *base in the struct hrtimer mentioned above.

struct hrtimer_clock_base clock_base[0] is
crash> struct hrtimer_clock_base 0xffff9f9ec0ad3a60
struct hrtimer_clock_base {
  cpu_base = 0xffff9f9ec0ad3a20,
  index = 0,
  clockid = 1,
  active = {
    head = {
      rb_node = 0xffff9f9e6308fcc8
    },
    next = 0xffff9f9e5b8af8d8
  },
  resolution = {
    tv64 = 1
  },
  get_time = 0xffffffffac8ff970,
  rh_reserved_softirq_time = {
    tv64 = 0
  },
  offset = {
    tv64 = 0
  }
}

struct hrtimer_clock_base clock_base[1] is
crash> struct hrtimer_clock_base 0xffff9f9ec0ad3aa0
struct hrtimer_clock_base {
  cpu_base = 0xffff9f9ec0ad3a20,
  index = 1,
  clockid = 0,
  active = {
    head = {
      rb_node = 0x0
    },
    next = 0x0
  },
  resolution = {
    tv64 = 1
  },
  get_time = 0xffffffffac8ffdf0,
  rh_reserved_softirq_time = {
    tv64 = 0
  },
  offset = {
    tv64 = 1596550100169477875
  }
}

struct hrtimer_clock_base clock_base[2] is
crash> struct hrtimer_clock_base 0xffff9f9ec0ad3ae0
struct hrtimer_clock_base {
  cpu_base = 0xffff9f9ec0ad3a20,
  index = 2,
  clockid = 7,
  active = {
    head = {
      rb_node = 0x0
    },
    next = 0x0
  },
  resolution = {
    tv64 = 1
  },
  get_time = 0xffffffffac8fff70,
  rh_reserved_softirq_time = {
    tv64 = 0
  },
  offset = {
    tv64 = 0
  }
}

struct hrtimer_clock_base clock_base[3] is
crash> struct hrtimer_clock_base 0xffff9f9ec0ad3b20
struct hrtimer_clock_base {
  cpu_base = 0xffff9f9ec0ad3a20,
  index = 3,
  clockid = 11,
  active = {
    head = {
      rb_node = 0x0
    },
    next = 0x0
  },
  resolution = {
    tv64 = 1
  },
  get_time = 0xffffffffac8ffc10,
  rh_reserved_softirq_time = {
    tv64 = 0
  },
  offset = {
    tv64 = 1596550100169477875
  }
}

From the above, we can see that only the first clock_base is valid.

Let us continue to look at the __hrtimer_run_queues function and __run_hrtimer function.
static void __hrtimer_run_queues(struct hrtimer_cpu_base *cpu_base, ktime_t now)
{
        int i;

        for (i = 0; i < HRTIMER_MAX_CLOCK_BASES; i++) {
                struct hrtimer_clock_base *base;
                struct timerqueue_node *node;
                ktime_t basenow;

                if (!(cpu_base->active_bases & (1 << i)))
                        continue;

                base = cpu_base->clock_base + i;
                basenow = ktime_add(now, base->offset);

                while ((node = timerqueue_getnext(&base->active))) {
                        struct hrtimer *timer;

                        timer = container_of(node, struct hrtimer, node);

                        /*
                         * The immediate goal for using the softexpires is
                         * minimizing wakeups, not running timers at the
                         * earliest interrupt after their soft expiration.
                         * This allows us to avoid using a Priority Search
                         * Tree, which can answer a stabbing querry for
                         * overlapping intervals and instead use the simple
                         * BST we already have.
                         * We don't add extra wakeups by delaying timers that
                         * are right-of a not yet expired timer, because that
                         * timer will have to trigger a wakeup anyway.
                         */
                        if (basenow.tv64 < hrtimer_get_softexpires_tv64(timer))
                                break;

                        __run_hrtimer(cpu_base, base, timer, &basenow);
                }
        }
}

static void __run_hrtimer(struct hrtimer_cpu_base *cpu_base,
                          struct hrtimer_clock_base *base,
                          struct hrtimer *timer, ktime_t *now)
{
        enum hrtimer_restart (*fn)(struct hrtimer *);
        int restart;

        WARN_ON(!irqs_disabled());

        debug_deactivate(timer);
        __remove_hrtimer(timer, base, HRTIMER_STATE_CALLBACK, 0);
        fn = timer->function;

        /*
         * Because we run timers from hardirq context, there is no chance
         * they get migrated to another cpu, therefore its safe to unlock
         * the timer base.
         */
        raw_spin_unlock(&cpu_base->lock);
        trace_hrtimer_expire_entry(timer, now);
        restart = fn(timer);
        trace_hrtimer_expire_exit(timer);
        raw_spin_lock(&cpu_base->lock);

        /*
         * Note: We clear the CALLBACK bit after enqueue_hrtimer and
         * we do not reprogramm the event hardware. Happens either in
         * hrtimer_start_range_ns() or in hrtimer_interrupt()
         *
         * Note: Because we dropped the cpu_base->lock above,
         * hrtimer_start_range_ns() can have popped in and enqueued the timer
         * for us already.
         */
        if (restart != HRTIMER_NORESTART &&
            !(timer->state & HRTIMER_STATE_ENQUEUED))
                enqueue_hrtimer(timer, base);

        WARN_ON_ONCE(!(timer->state & HRTIMER_STATE_CALLBACK));

        timer->state &= ~HRTIMER_STATE_CALLBACK;
}

In the __hrtimer_run_queues function, you can see that struct hrtimer *timer is obtained by struct hrtimer_clock_base *base. The timer is correct, indicating that the base is correct at this moment. That is, the input parameter base of the __run_hrtimer function is correct, but the base passed in by calling enqueue_hrtimer by __run_hrtimer is wrong. At the same time, there is no code to modify the base in the __run_hrtimer function. This is very strange.

Since the __run_hrtimer function is optimized by the compiler, let's analyze the disassembly code of the __hrtimer_run_queues function. The result is as follows.

crash> dis -l __hrtimer_run_queues
/usr/src/debug/kernel-3.10.0/linux-3.10.0-862.14.1.6_110.x86_64/kernel/hrtimer.c: 1216
0xffffffffac8c3b80 <__hrtimer_run_queues>:      nopl   0x0(%rax,%rax,1) [FTRACE NOP]
0xffffffffac8c3b85 <__hrtimer_run_queues+5>:    push   %rbp
0xffffffffac8c3b86 <__hrtimer_run_queues+6>:    mov    %rsp,%rbp
0xffffffffac8c3b89 <__hrtimer_run_queues+9>:    push   %r15
0xffffffffac8c3b8b <__hrtimer_run_queues+11>:   push   %r14
0xffffffffac8c3b8d <__hrtimer_run_queues+13>:   push   %r13
0xffffffffac8c3b8f <__hrtimer_run_queues+15>:   lea    0x40(%rdi),%r13
0xffffffffac8c3b93 <__hrtimer_run_queues+19>:   push   %r12
0xffffffffac8c3b95 <__hrtimer_run_queues+21>:   mov    %rdi,%r12
0xffffffffac8c3b98 <__hrtimer_run_queues+24>:   push   %rbx
0xffffffffac8c3b99 <__hrtimer_run_queues+25>:   sub    $0x20,%rsp
0xffffffffac8c3b9d <__hrtimer_run_queues+29>:   mov    %rsi,-0x48(%rbp)
/usr/src/debug/kernel-3.10.0/linux-3.10.0-862.14.1.6_110.x86_64/kernel/hrtimer.c: 1219
0xffffffffac8c3ba1 <__hrtimer_run_queues+33>:   movl   $0x0,-0x3c(%rbp)
/usr/src/debug/kernel-3.10.0/linux-3.10.0-862.14.1.6_110.x86_64/kernel/hrtimer.c: 1216
0xffffffffac8c3ba8 <__hrtimer_run_queues+40>:   mov    %gs:0x28,%rax
0xffffffffac8c3bb1 <__hrtimer_run_queues+49>:   mov    %rax,-0x30(%rbp)
0xffffffffac8c3bb5 <__hrtimer_run_queues+53>:   xor    %eax,%eax
/usr/src/debug/kernel-3.10.0/linux-3.10.0-862.14.1.6_110.x86_64/kernel/hrtimer.c: 1224
0xffffffffac8c3bb7 <__hrtimer_run_queues+55>:   movzbl -0x3c(%rbp),%ecx
0xffffffffac8c3bbb <__hrtimer_run_queues+59>:   mov    $0x1,%eax
0xffffffffac8c3bc0 <__hrtimer_run_queues+64>:   shl    %cl,%eax
0xffffffffac8c3bc2 <__hrtimer_run_queues+66>:   test   %eax,0x4(%r12)
0xffffffffac8c3bc7 <__hrtimer_run_queues+71>:   je     0xffffffffac8c3d30 <__hrtimer_run_queues+432>
/usr/src/debug/kernel-3.10.0/linux-3.10.0-862.14.1.6_110.x86_64/kernel/hrtimer.c: 1228
0xffffffffac8c3bcd <__hrtimer_run_queues+77>:   mov    -0x48(%rbp),%rax
0xffffffffac8c3bd1 <__hrtimer_run_queues+81>:   add    0x38(%r13),%rax
0xffffffffac8c3bd5 <__hrtimer_run_queues+85>:   mov    %rax,-0x38(%rbp)
/usr/src/debug/kernel-3.10.0/linux-3.10.0-862.14.1.6_110.x86_64/kernel/hrtimer.c: 1230
0xffffffffac8c3bd9 <__hrtimer_run_queues+89>:   jmp    0xffffffffac8c3bf0 <__hrtimer_run_queues+112>
0xffffffffac8c3bdb <__hrtimer_run_queues+91>:   nopl   0x0(%rax,%rax,1)
/usr/src/debug/kernel-3.10.0/linux-3.10.0-862.14.1.6_110.x86_64/kernel/hrtimer.c: 1210
0xffffffffac8c3be0 <__hrtimer_run_queues+96>:   test   $0x2,%al
0xffffffffac8c3be2 <__hrtimer_run_queues+98>:   je     0xffffffffac8c3d76 <__hrtimer_run_queues+502>
/usr/src/debug/kernel-3.10.0/linux-3.10.0-862.14.1.6_110.x86_64/kernel/hrtimer.c: 1212
0xffffffffac8c3be8 <__hrtimer_run_queues+104>:  and    $0xfffffffffffffffd,%rax
0xffffffffac8c3bec <__hrtimer_run_queues+108>:  mov    %rax,0x38(%rbx)
/usr/src/debug/kernel-3.10.0/linux-3.10.0-862.14.1.6_110.x86_64/kernel/hrtimer.c: 1230
0xffffffffac8c3bf0 <__hrtimer_run_queues+112>:  mov    0x18(%r13),%rbx
0xffffffffac8c3bf4 <__hrtimer_run_queues+116>:  test   %rbx,%rbx
0xffffffffac8c3bf7 <__hrtimer_run_queues+119>:  je     0xffffffffac8c3d30 <__hrtimer_run_queues+432>
/usr/src/debug/kernel-3.10.0/linux-3.10.0-862.14.1.6_110.x86_64/kernel/hrtimer.c: 1247
0xffffffffac8c3bfd <__hrtimer_run_queues+125>:  mov    0x20(%rbx),%rax
0xffffffffac8c3c01 <__hrtimer_run_queues+129>:  cmp    %rax,-0x38(%rbp)
0xffffffffac8c3c05 <__hrtimer_run_queues+133>:  jl     0xffffffffac8c3d30 <__hrtimer_run_queues+432>
/usr/src/debug/kernel-3.10.0/linux-3.10.0-862.14.1.6_110.x86_64/arch/x86/include/asm/paravirt.h: 785
0xffffffffac8c3c0b <__hrtimer_run_queues+139>:  pushfq
0xffffffffac8c3c0c <__hrtimer_run_queues+140>:  pop    %rax
0xffffffffac8c3c0d <__hrtimer_run_queues+141>:  nopl   0x0(%rax,%rax,1)
/usr/src/debug/kernel-3.10.0/linux-3.10.0-862.14.1.6_110.x86_64/kernel/hrtimer.c: 1180
0xffffffffac8c3c12 <__hrtimer_run_queues+146>:  test   $0x2,%ah
0xffffffffac8c3c15 <__hrtimer_run_queues+149>:  jne    0xffffffffac8c3d60 <__hrtimer_run_queues+480>
0xffffffffac8c3c1b <__hrtimer_run_queues+155>:  nopl   0x0(%rax,%rax,1)
/usr/src/debug/kernel-3.10.0/linux-3.10.0-862.14.1.6_110.x86_64/kernel/hrtimer.c: 1183
0xffffffffac8c3c20 <__hrtimer_run_queues+160>:  mov    %rbx,%rdi
0xffffffffac8c3c23 <__hrtimer_run_queues+163>:  xor    %ecx,%ecx
0xffffffffac8c3c25 <__hrtimer_run_queues+165>:  mov    $0x2,%edx
0xffffffffac8c3c2a <__hrtimer_run_queues+170>:  mov    %r13,%rsi
0xffffffffac8c3c2d <__hrtimer_run_queues+173>:  callq  0xffffffffac8c3730 <__remove_hrtimer>
/usr/src/debug/kernel-3.10.0/linux-3.10.0-862.14.1.6_110.x86_64/kernel/hrtimer.c: 1184
0xffffffffac8c3c32 <__hrtimer_run_queues+178>:  mov    0x28(%rbx),%r14
/usr/src/debug/kernel-3.10.0/linux-3.10.0-862.14.1.6_110.x86_64/arch/x86/include/asm/paravirt.h: 675
0xffffffffac8c3c36 <__hrtimer_run_queues+182>:  mov    %r12,%rdi
0xffffffffac8c3c39 <__hrtimer_run_queues+185>:  movb   $0x0,(%rdi)
0xffffffffac8c3c3c <__hrtimer_run_queues+188>:  nopl   0x0(%rax)
/usr/src/debug/kernel-3.10.0/linux-3.10.0-862.14.1.6_110.x86_64/include/linux/spinlock_api_smp.h: 154
0xffffffffac8c3c40 <__hrtimer_run_queues+192>:  nopl   0x0(%rax,%rax,1)
/usr/src/debug/kernel-3.10.0/linux-3.10.0-862.14.1.6_110.x86_64/kernel/hrtimer.c: 1193
0xffffffffac8c3c45 <__hrtimer_run_queues+197>:  mov    %rbx,%rdi
0xffffffffac8c3c48 <__hrtimer_run_queues+200>:  callq  0xffffffffacb6d3b0 <__x86_indirect_thunk_r14>
0xffffffffac8c3c4d <__hrtimer_run_queues+205>:  mov    %eax,%r14d
0xffffffffac8c3c50 <__hrtimer_run_queues+208>:  nopl   0x0(%rax,%rax,1)
/usr/src/debug/kernel-3.10.0/linux-3.10.0-862.14.1.6_110.x86_64/kernel/hrtimer.c: 1195
0xffffffffac8c3c55 <__hrtimer_run_queues+213>:  mov    %r12,%rdi
0xffffffffac8c3c58 <__hrtimer_run_queues+216>:  callq  0xffffffffacf303e0 <_raw_qspin_lock>
/usr/src/debug/kernel-3.10.0/linux-3.10.0-862.14.1.6_110.x86_64/kernel/hrtimer.c: 1206
0xffffffffac8c3c5d <__hrtimer_run_queues+221>:  test   %r14d,%r14d
/usr/src/debug/kernel-3.10.0/linux-3.10.0-862.14.1.6_110.x86_64/kernel/hrtimer.c: 1207
0xffffffffac8c3c60 <__hrtimer_run_queues+224>:  mov    0x38(%rbx),%rax
/usr/src/debug/kernel-3.10.0/linux-3.10.0-862.14.1.6_110.x86_64/kernel/hrtimer.c: 1206
0xffffffffac8c3c64 <__hrtimer_run_queues+228>:  je     0xffffffffac8c3be0 <__hrtimer_run_queues+96>
0xffffffffac8c3c6a <__hrtimer_run_queues+234>:  test   $0x1,%al
0xffffffffac8c3c6c <__hrtimer_run_queues+236>:  jne    0xffffffffac8c3be0 <__hrtimer_run_queues+96>
/usr/src/debug/kernel-3.10.0/linux-3.10.0-862.14.1.6_110.x86_64/kernel/hrtimer.c: 1208
0xffffffffac8c3c72 <__hrtimer_run_queues+242>:  mov    %r13,%rsi
0xffffffffac8c3c75 <__hrtimer_run_queues+245>:  mov    %rbx,%rdi
0xffffffffac8c3c78 <__hrtimer_run_queues+248>:  callq  0xffffffffac8c32d0 <enqueue_hrtimer>
0xffffffffac8c3c7d <__hrtimer_run_queues+253>:  mov    0x38(%rbx),%rax
0xffffffffac8c3c81 <__hrtimer_run_queues+257>:  jmpq   0xffffffffac8c3be0 <__hrtimer_run_queues+96>
0xffffffffac8c3c86 <__hrtimer_run_queues+262>:  nopw   %cs:0x0(%rax,%rax,1)
/usr/src/debug/kernel-3.10.0/linux-3.10.0-862.14.1.6_110.x86_64/include/trace/events/timer.h: 242
0xffffffffac8c3c90 <__hrtimer_run_queues+272>:  mov    0xc54c59(%rip),%r15        # 0xffffffffad5188f0
0xffffffffac8c3c97 <__hrtimer_run_queues+279>:  test   %r15,%r15
0xffffffffac8c3c9a <__hrtimer_run_queues+282>:  je     0xffffffffac8c3cb8 <__hrtimer_run_queues+312>
0xffffffffac8c3c9c <__hrtimer_run_queues+284>:  mov    (%r15),%rdx
0xffffffffac8c3c9f <__hrtimer_run_queues+287>:  nop
0xffffffffac8c3ca0 <__hrtimer_run_queues+288>:  mov    0x8(%r15),%rdi
0xffffffffac8c3ca4 <__hrtimer_run_queues+292>:  add    $0x10,%r15
0xffffffffac8c3ca8 <__hrtimer_run_queues+296>:  mov    %rbx,%rsi
0xffffffffac8c3cab <__hrtimer_run_queues+299>:  callq  0xffffffffacb6d270 <__x86_indirect_thunk_rdx>
0xffffffffac8c3cb0 <__hrtimer_run_queues+304>:  mov    (%r15),%rdx
0xffffffffac8c3cb3 <__hrtimer_run_queues+307>:  test   %rdx,%rdx
0xffffffffac8c3cb6 <__hrtimer_run_queues+310>:  jne    0xffffffffac8c3ca0 <__hrtimer_run_queues+288>
/usr/src/debug/kernel-3.10.0/linux-3.10.0-862.14.1.6_110.x86_64/include/linux/rcupdate.h: 952
0xffffffffac8c3cb8 <__hrtimer_run_queues+312>:  jmp    0xffffffffac8c3c55 <__hrtimer_run_queues+213>
0xffffffffac8c3cba <__hrtimer_run_queues+314>:  nopw   0x0(%rax,%rax,1)
/usr/src/debug/kernel-3.10.0/linux-3.10.0-862.14.1.6_110.x86_64/include/trace/events/timer.h: 196
0xffffffffac8c3cc0 <__hrtimer_run_queues+320>:  mov    0xc54c69(%rip),%r15        # 0xffffffffad518930
0xffffffffac8c3cc7 <__hrtimer_run_queues+327>:  test   %r15,%r15
0xffffffffac8c3cca <__hrtimer_run_queues+330>:  je     0xffffffffac8c3cec <__hrtimer_run_queues+364>
0xffffffffac8c3ccc <__hrtimer_run_queues+332>:  mov    (%r15),%rcx
0xffffffffac8c3ccf <__hrtimer_run_queues+335>:  nop
0xffffffffac8c3cd0 <__hrtimer_run_queues+336>:  mov    0x8(%r15),%rdi
0xffffffffac8c3cd4 <__hrtimer_run_queues+340>:  add    $0x10,%r15
0xffffffffac8c3cd8 <__hrtimer_run_queues+344>:  lea    -0x38(%rbp),%rdx
0xffffffffac8c3cdc <__hrtimer_run_queues+348>:  mov    %rbx,%rsi
0xffffffffac8c3cdf <__hrtimer_run_queues+351>:  callq  0xffffffffacb6d250 <__x86_indirect_thunk_rcx>
0xffffffffac8c3ce4 <__hrtimer_run_queues+356>:  mov    (%r15),%rcx
0xffffffffac8c3ce7 <__hrtimer_run_queues+359>:  test   %rcx,%rcx
0xffffffffac8c3cea <__hrtimer_run_queues+362>:  jne    0xffffffffac8c3cd0 <__hrtimer_run_queues+336>
/usr/src/debug/kernel-3.10.0/linux-3.10.0-862.14.1.6_110.x86_64/include/linux/rcupdate.h: 952
0xffffffffac8c3cec <__hrtimer_run_queues+364>:  jmpq   0xffffffffac8c3c45 <__hrtimer_run_queues+197>
0xffffffffac8c3cf1 <__hrtimer_run_queues+369>:  nopl   0x0(%rax)
/usr/src/debug/kernel-3.10.0/linux-3.10.0-862.14.1.6_110.x86_64/include/trace/events/timer.h: 253
0xffffffffac8c3cf8 <__hrtimer_run_queues+376>:  mov    0xc54bb1(%rip),%r14        # 0xffffffffad5188b0
0xffffffffac8c3cff <__hrtimer_run_queues+383>:  test   %r14,%r14
0xffffffffac8c3d02 <__hrtimer_run_queues+386>:  je     0xffffffffac8c3d28 <__hrtimer_run_queues+424>
0xffffffffac8c3d04 <__hrtimer_run_queues+388>:  mov    (%r14),%rax
0xffffffffac8c3d07 <__hrtimer_run_queues+391>:  nopw   0x0(%rax,%rax,1)
0xffffffffac8c3d10 <__hrtimer_run_queues+400>:  mov    0x8(%r14),%rdi
0xffffffffac8c3d14 <__hrtimer_run_queues+404>:  add    $0x10,%r14
0xffffffffac8c3d18 <__hrtimer_run_queues+408>:  mov    %rbx,%rsi
0xffffffffac8c3d1b <__hrtimer_run_queues+411>:  callq  0xffffffffacb6d210 <__x86_indirect_thunk_rax>
0xffffffffac8c3d20 <__hrtimer_run_queues+416>:  mov    (%r14),%rax
0xffffffffac8c3d23 <__hrtimer_run_queues+419>:  test   %rax,%rax
0xffffffffac8c3d26 <__hrtimer_run_queues+422>:  jne    0xffffffffac8c3d10 <__hrtimer_run_queues+400>
/usr/src/debug/kernel-3.10.0/linux-3.10.0-862.14.1.6_110.x86_64/include/linux/rcupdate.h: 952
0xffffffffac8c3d28 <__hrtimer_run_queues+424>:  jmpq   0xffffffffac8c3c20 <__hrtimer_run_queues+160>
0xffffffffac8c3d2d <__hrtimer_run_queues+429>:  nopl   (%rax)
/usr/src/debug/kernel-3.10.0/linux-3.10.0-862.14.1.6_110.x86_64/kernel/hrtimer.c: 1219
0xffffffffac8c3d30 <__hrtimer_run_queues+432>:  addl   $0x1,-0x3c(%rbp)
0xffffffffac8c3d34 <__hrtimer_run_queues+436>:  add    $0x40,%r13
0xffffffffac8c3d38 <__hrtimer_run_queues+440>:  cmpl   $0x4,-0x3c(%rbp)
0xffffffffac8c3d3c <__hrtimer_run_queues+444>:  jne    0xffffffffac8c3bb7 <__hrtimer_run_queues+55>
/usr/src/debug/kernel-3.10.0/linux-3.10.0-862.14.1.6_110.x86_64/kernel/hrtimer.c: 1253
0xffffffffac8c3d42 <__hrtimer_run_queues+450>:  mov    -0x30(%rbp),%rax
0xffffffffac8c3d46 <__hrtimer_run_queues+454>:  xor    %gs:0x28,%rax
0xffffffffac8c3d4f <__hrtimer_run_queues+463>:  jne    0xffffffffac8c3da4 <__hrtimer_run_queues+548>
0xffffffffac8c3d51 <__hrtimer_run_queues+465>:  add    $0x20,%rsp
0xffffffffac8c3d55 <__hrtimer_run_queues+469>:  pop    %rbx
0xffffffffac8c3d56 <__hrtimer_run_queues+470>:  pop    %r12
0xffffffffac8c3d58 <__hrtimer_run_queues+472>:  pop    %r13
0xffffffffac8c3d5a <__hrtimer_run_queues+474>:  pop    %r14
0xffffffffac8c3d5c <__hrtimer_run_queues+476>:  pop    %r15
0xffffffffac8c3d5e <__hrtimer_run_queues+478>:  pop    %rbp
0xffffffffac8c3d5f <__hrtimer_run_queues+479>:  retq
/usr/src/debug/kernel-3.10.0/linux-3.10.0-862.14.1.6_110.x86_64/kernel/hrtimer.c: 1180
0xffffffffac8c3d60 <__hrtimer_run_queues+480>:  mov    $0x49c,%esi
0xffffffffac8c3d65 <__hrtimer_run_queues+485>:  mov    $0xffffffffad270f96,%rdi
0xffffffffac8c3d6c <__hrtimer_run_queues+492>:  callq  0xffffffffac896070 <warn_slowpath_null>
0xffffffffac8c3d71 <__hrtimer_run_queues+497>:  jmpq   0xffffffffac8c3c1b <__hrtimer_run_queues+155>
/usr/src/debug/kernel-3.10.0/linux-3.10.0-862.14.1.6_110.x86_64/kernel/hrtimer.c: 1210
0xffffffffac8c3d76 <__hrtimer_run_queues+502>:  cmpb   $0x0,0xc534a7(%rip)        # 0xffffffffad517224
0xffffffffac8c3d7d <__hrtimer_run_queues+509>:  jne    0xffffffffac8c3be8 <__hrtimer_run_queues+104>
0xffffffffac8c3d83 <__hrtimer_run_queues+515>:  mov    $0x4ba,%esi
0xffffffffac8c3d88 <__hrtimer_run_queues+520>:  mov    $0xffffffffad270f96,%rdi
0xffffffffac8c3d8f <__hrtimer_run_queues+527>:  callq  0xffffffffac896070 <warn_slowpath_null>
0xffffffffac8c3d94 <__hrtimer_run_queues+532>:  movb   $0x1,0xc53489(%rip)        # 0xffffffffad517224
0xffffffffac8c3d9b <__hrtimer_run_queues+539>:  mov    0x38(%rbx),%rax
0xffffffffac8c3d9f <__hrtimer_run_queues+543>:  jmpq   0xffffffffac8c3be8 <__hrtimer_run_queues+104>
/usr/src/debug/kernel-3.10.0/linux-3.10.0-862.14.1.6_110.x86_64/kernel/hrtimer.c: 1253
0xffffffffac8c3da4 <__hrtimer_run_queues+548>:  callq  0xffffffffac895ca0 <__stack_chk_fail>
0xffffffffac8c3da9 <__hrtimer_run_queues+553>:  nopl   0x0(%rax)

We can see that in the line 0xffffffffac8c3b8f <__hrtimer_run_queues+15>: lea 0x40(%rdi),%r13, the value of base is put into r13.
In the 0xffffffffac8c3c72 <__hrtimer_run_queues+242>: mov %r13,%rsi line before calling the enqueue_hrtimer function, the value of base is copied from the r13 register to the rsi register.
The r13 register is not modified elsewhere. Therefore, we suspect that the stack may be destroyed during the call to the __remove_hrtimer function or the fn=tick_sched_timer function, resulting in that when the function returns, the value of the r13 register
The value is overwritten with the wrong value ffffffffac8d4385. Currently we have no evidence to prove.

Two phenomena can indirectly prove the above suspicion.
First, ffffffffac8d4385 is the address of a function, let's parse it. The results are as follows.

crash> dis -l ffffffffac8d4385
/usr/src/debug/kernel-3.10.0/linux-3.10.0-862.14.1.6_110.x86_64/kernel/sched/core.c: 1934
0xffffffffac8d4385 <wake_up_process+21>:        pop    %rbp

1931 int wake_up_process(struct task_struct *p)
1932 {
1933         return try_to_wake_up(p, TASK_NORMAL, 0);
1934 }

Second, we looked at the function stack. The result is as follows, you can see ffffffffac8d4385 on the stack, In the line ffff9f9ec0ac3f10.
crash> bt -c 3 -f
PID: 27797  TASK: ffff9f9e28805f40  CPU: 3   COMMAND: "ipmi_sim"
#0 [ffff9f9ec0ac3dd0] die at ffffffffac82f97b
    ffff9f9ec0ac3dd8: ffff9f708e673f80 ffff9f9ec0ac3e38
    ffff9f9ec0ac3de8: 0000000000000000 0000000000000000
    ffff9f9ec0ac3df8: ffff9f9ec0ac3e28 ffffffffacf3211e
 #1 [ffff9f9ec0ac3e00] do_general_protection at ffffffffacf3211e
    ffff9f9ec0ac3e08: 0000000000000001 ffffffffac8d4395
    ffff9f9ec0ac3e18: ffffffffac8d4385 0000000000000001
    ffff9f9ec0ac3e28: ffff9f9ec0ac3ef0 ffffffffacf31718
 #2 [ffff9f9ec0ac3e30] general_protection at ffffffffacf31718
    [exception RIP: timerqueue_add+32]
    RIP: ffffffffacb67340  RSP: ffff9f9ec0ac3ee0  RFLAGS: 00010006
    RAX: 7401f88348078b48  RBX: ffff9f9ec0ad3fa0  RCX: 0000000000000000
    RDX: ffffffffac8d4395  RSI: ffff9f9ec0ad3fa0  RDI: ffffffffac8d4395
    RBP: ffff9f9ec0ac3ef0   R8: 00405b31f6958080   R9: ffff9f9ec0ac3de0
    R10: 0000000000000002  R11: ffff9f9ec0ac3de8  R12: ffffffffac8d4395
    R13: ffffffffac8d4385  R14: 0000000000000001  R15: ffff9f9ec0ad3b58
    ORIG_RAX: ffffffffffffffff  CS: 0010  SS: 0018
    ffff9f9ec0ac3e38: ffff9f9ec0ad3b58 0000000000000001
    ffff9f9ec0ac3e48: ffffffffac8d4385 ffffffffac8d4395
    ffff9f9ec0ac3e58: ffff9f9ec0ac3ef0 ffff9f9ec0ad3fa0
    ffff9f9ec0ac3e68: ffff9f9ec0ac3de8 0000000000000002
    ffff9f9ec0ac3e78: ffff9f9ec0ac3de0 00405b31f6958080
    ffff9f9ec0ac3e88: 7401f88348078b48 0000000000000000
    ffff9f9ec0ac3e98: ffffffffac8d4395 ffff9f9ec0ad3fa0
    ffff9f9ec0ac3ea8: ffffffffac8d4395 ffffffffffffffff
    ffff9f9ec0ac3eb8: ffffffffacb67340 0000000000000010
    ffff9f9ec0ac3ec8: 0000000000010006 ffff9f9ec0ac3ee0
    ffff9f9ec0ac3ed8: 0000000000000018 ffff9f9ec0ad3fa0
    ffff9f9ec0ac3ee8: ffff9f9ec0ad3fa0 ffff9f9ec0ac3f18
    ffff9f9ec0ac3ef8: ffffffffac8c32f5
 #3 [ffff9f9ec0ac3ef8] enqueue_hrtimer at ffffffffac8c32f5
    ffff9f9ec0ac3f00: ffff9f9ec0ad3fa0 ffff9f9ec0ad3a20
    ffff9f9ec0ac3f10: ffffffffac8d4385 ffff9f9ec0ac3f70
    ffff9f9ec0ac3f20: ffffffffac8c3c7d
 #4 [ffff9f9ec0ac3f20] __hrtimer_run_queues at ffffffffac8c3c7d
    ffff9f9ec0ac3f28: 00405b31f695867a 00000000c0ad3b58
    ffff9f9ec0ac3f38: 00405b31f695867a f8fbe5c575ba6923
    ffff9f9ec0ac3f48: 0000000000000003 ffff9f9ec0ad3a20
    ffff9f9ec0ac3f58: ffff9f9ec0ad3ad8 ffff9f9ec0ad3a60
    ffff9f9ec0ac3f68: ffff9f9ec0ad3b58 ffff9f9ec0ac3fb8
    ffff9f9ec0ac3f78: ffffffffac8c41af
 #5 [ffff9f9ec0ac3f78] hrtimer_interrupt at ffffffffac8c41af
    ffff9f9ec0ac3f80: 00405b31f695867a ffff9f9ec0ad3a28
    ffff9f9ec0ac3f90: ffff9f9ec0ad1200 0000000000000003
    ffff9f9ec0ac3fa0: ffff9f708e690000 ffff9f708e690000
    ffff9f9ec0ac3fb0: ffff9f708e690000 ffff9f9ec0ac3fd0
    ffff9f9ec0ac3fc0: ffffffffac85aeeb
 #6 [ffff9f9ec0ac3fc0] local_apic_timer_interrupt at ffffffffac85aeeb
    ffff9f9ec0ac3fc8: 0000000000000000 ffff9f9ec0ac3fe8
    ffff9f9ec0ac3fd8: ffffffffacf3f0a3
 #7 [ffff9f9ec0ac3fd8] smp_apic_timer_interrupt at ffffffffacf3f0a3
    ffff9f9ec0ac3fe0: ffffffffad543a20 ffff9f708e693ea8
    ffff9f9ec0ac3ff0: ffffffffacf3b7ba
 #8 [ffff9f9ec0ac3ff0] apic_timer_interrupt at ffffffffacf3b7ba
--- <IRQ stack> ---
bt: cannot transition from IRQ stack to current process stack:
        IRQ stack pointer: ffff9f9ec0ac3dd0
    process stack pointer: ffff9f708e693df8
       current stack base: ffff9f9e25764000

Has anyone encountered a similar problem? Hope to get your help.

--wangjian
