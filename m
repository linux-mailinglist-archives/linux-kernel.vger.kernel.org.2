Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95F153BC23E
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jul 2021 19:23:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229753AbhGER0d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jul 2021 13:26:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229686AbhGER0c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jul 2021 13:26:32 -0400
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84FBEC061574
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jul 2021 10:23:55 -0700 (PDT)
Received: by mail-ot1-x335.google.com with SMTP id x22-20020a9d6d960000b0290474a76f8bd4so17350898otp.5
        for <linux-kernel@vger.kernel.org>; Mon, 05 Jul 2021 10:23:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=HK/j4d+RdrjL73sp1HcqPM525Lt1IOo95Vk46yCTN+g=;
        b=QgOtcqAqqpUGnttxt5+V1ZWDq6C4Q1wD13Oc2CZuqraX66DY5n4H1EG0MYgOMVLmtG
         YTRmXIYh/X9ge9ve4XEeS1g1jQRpSMcYYVGkX1C+G9KiF4R9pZruahY6TI8AG9jn166i
         7QKgMHbRf575znBWu/9wiIcGV5R7HWBqwz/ihpv0I7qF4PE67ml29VL6nizYgQty6R70
         XmyBD0qW8mvKDgD9ygXdqxwQsbaht4vtPxi/iLyiI4VY6BTHf+rudR9sc+SMOye5fAXT
         CnvvXQKfOk/0C5udInt2B/5uPR+hiswHOsCiQySuTyvrXxKqKUqwDGRPz8Q2/1Sg0qaP
         8t1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=HK/j4d+RdrjL73sp1HcqPM525Lt1IOo95Vk46yCTN+g=;
        b=mLEkwljvDwXUY7BiBA12m2omZFAyNda4vkesCDgnHF5PhNvdKAhGR6HYYVa7JSYJZB
         07JSmKjy3Oz4BUFjUQjFpiU6oFnJYARI0mz/4ZdD44Ben6vE4/EtnllmlVBhrXwzvOZK
         VABv3of71I8VaCD5ZcnonOcbLAsOx+1w61swkuGWOOYN+y8i6QOjrfIjE/Ybdu4DqpQB
         kSv9yvbkoi/5iS/MEptiJ+KDXVn7/G3O0Y7e6HEMo5jx349Z7EyxTgO4VyR5+z4QueBp
         SaXlA+IAeH19B0JyE0LxK0kF1y0eoR/mk52qWHf/XQ9X/CCMewl233T9xG8KBNt7d/6f
         gaZA==
X-Gm-Message-State: AOAM530xV8oQQDKIdJ2b4EWcbpuI6TsOpUNVGLLdUrjEhgGjY5L86qqZ
        49uatpn3MJcV6AQopF0Z5wh5ZJDsPPQ=
X-Google-Smtp-Source: ABdhPJwGPBLu/mnsf/mx87fJRTobJvkLLBW4FqNkUD4HOMdah7y0g85ZqzYom2M3K9cC3YflknF90g==
X-Received: by 2002:a9d:2d82:: with SMTP id g2mr12001374otb.30.1625505834460;
        Mon, 05 Jul 2021 10:23:54 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id y6sm2826349oiy.18.2021.07.05.10.23.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jul 2021 10:23:53 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Mon, 5 Jul 2021 10:23:52 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     linux-kernel@vger.kernel.org
Cc:     Marc Zyngier <maz@kernel.org>, tglx@linutronix.de
Subject: Re: [irqchip: irq/irqchip-next] irqdomain: Protect the linear revmap
 with RCU
Message-ID: <20210705172352.GA56304@roeck-us.net>
References: <162341967699.19906.3242958007782554792.tip-bot2@tip-bot2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <162341967699.19906.3242958007782554792.tip-bot2@tip-bot2>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Jun 11, 2021 at 01:54:36PM -0000, irqchip-bot for Marc Zyngier wrote:
> The following commit has been merged into the irq/irqchip-next branch of irqchip:
> 
> Commit-ID:     d4a45c68dc81f9117ceaff9f058d5fae674181b9
> Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/d4a45c68dc81f9117ceaff9f058d5fae674181b9
> Author:        Marc Zyngier <maz@kernel.org>
> AuthorDate:    Mon, 05 Apr 2021 12:57:27 +01:00
> Committer:     Marc Zyngier <maz@kernel.org>
> CommitterDate: Thu, 10 Jun 2021 13:09:18 +01:00
> 
> irqdomain: Protect the linear revmap with RCU
> 
> It is pretty odd that the radix tree uses RCU while the linear
> portion doesn't, leading to potential surprises for the users,
> depending on how the irqdomain has been created.
> 
> Fix this by moving the update of the linear revmap under
> the mutex, and the lookup under the RCU read-side lock.
> 
> The mutex name is updated to reflect that it doesn't only
> cover the radix-tree anymore.
> 
> Signed-off-by: Marc Zyngier <maz@kernel.org>

This patch results in various RCU warnings when booting mipsel images
in qemu. I can not revert the patch due to subsequent changes, so I
don't know if a simple revert fixes the problem. Log messages and
bisect log see below.

Guenter

---

...
=============================
WARNING: suspicious RCU usage
5.13.0-09882-ga180bd1d7e16 #1 Not tainted
-----------------------------
include/trace/events/lock.h:13 suspicious rcu_dereference_check() usage!

other info that might help us debug this:


rcu_scheduler_active = 2, debug_locks = 1
RCU used illegally from extended quiescent state!
no locks held by swapper/0/0.

stack backtrace:
CPU: 0 PID: 0 Comm: swapper/0 Not tainted 5.13.0-09882-ga180bd1d7e16 #1
Stack : 00000000 00000000 00000047 801b2c84 80cd0000 00000004 00000000 00000000
        8209fe9c 3bdd5c9d 80fb0000 810f9930 80fb0000 00000001 8209fe38 820fcec0
        00000000 00000000 80ecfc64 8209fcc0 fffffbff 00000148 00000000 00000000
        00000000 00000064 00000002 80fb0000 80fb0000 00000001 80ecfc64 00000000
        80fb0000 80faea08 00000000 80fb1858 00000000 00000000 00000000 81100000
        ...
Call Trace:
[<8010a2ec>] show_stack+0x38/0x118
[<80c490ac>] dump_stack_lvl+0xac/0x104
[<801a4164>] lock_acquire+0x418/0x498
[<801c0d80>] __irq_resolve_mapping+0x60/0x1f0
[<807275a8>] plat_irq_dispatch+0x84/0x114
[<801038c0>] handle_int+0x160/0x16c
[<80103720>] __r4k_wait+0x20/0x40
[<80c600a4>] default_idle_call+0x9c/0x2e0
[<80173024>] do_idle+0x10c/0x1cc
[<801734b8>] cpu_startup_entry+0x24/0x3c
[<8106cf54>] start_kernel+0x790/0x7d8
[<80c55f50>] kernel_entry+0x0/0xa8


=============================
WARNING: suspicious RCU usage
5.13.0-09882-ga180bd1d7e16 #1 Not tainted
-----------------------------
include/linux/rcupdate.h:688 rcu_read_lock() used illegally while idle!

other info that might help us debug this:


rcu_scheduler_active = 2, debug_locks = 1
RCU used illegally from extended quiescent state!
1 lock held by swapper/0/0:
 #0: 80fd43cc (rcu_read_lock){....}-{1:2}, at: __irq_resolve_mapping+0x28/0x1f0

stack backtrace:
CPU: 0 PID: 0 Comm: swapper/0 Not tainted 5.13.0-09882-ga180bd1d7e16 #1
Stack : 00000080 00000000 00000047 801b2c84 80cd0000 00000004 00000000 00000000
        8209ff1c 3bdd5c9d 80fb0000 810f9930 80fb0000 00000001 8209feb8 820fcec0
        00000000 00000000 80ecfc64 8209fd40 fffffbff 00000169 00000000 00000000
        81349a50 00000064 00000002 80fb0000 80fb0000 00000001 80ecfc64 80fd0000
        81730000 80fb0000 00000080 80fb1858 00000000 00000000 00000000 81100000
        ...
Call Trace:
[<8010a2ec>] show_stack+0x38/0x118
[<80c490ac>] dump_stack_lvl+0xac/0x104
[<801c0ee8>] __irq_resolve_mapping+0x1c8/0x1f0
[<807275a8>] plat_irq_dispatch+0x84/0x114
[<801038c0>] handle_int+0x160/0x16c
[<80103720>] __r4k_wait+0x20/0x40
[<80c600a4>] default_idle_call+0x9c/0x2e0
[<80173024>] do_idle+0x10c/0x1cc
[<801734b8>] cpu_startup_entry+0x24/0x3c
[<8106cf54>] start_kernel+0x790/0x7d8
[<80c55f50>] kernel_entry+0x0/0xa8


=============================
WARNING: suspicious RCU usage
5.13.0-09882-ga180bd1d7e16 #1 Not tainted
-----------------------------
kernel/irq/irqdomain.c:920 suspicious rcu_dereference_check() usage!

other info that might help us debug this:


rcu_scheduler_active = 2, debug_locks = 1
RCU used illegally from extended quiescent state!
1 lock held by swapper/0/0:
 #0: 80fd43cc (rcu_read_lock){....}-{1:2}, at: __irq_resolve_mapping+0x28/0x1f0

stack backtrace:
CPU: 0 PID: 0 Comm: swapper/0 Not tainted 5.13.0-09882-ga180bd1d7e16 #1
Stack : 00000080 00000000 00000047 801b2c84 80cd0000 00000004 00000000 00000000
        8209ff1c 3bdd5c9d 80fb0000 810f9930 80fb0000 00000001 8209feb8 820fcec0
        00000000 00000000 80ecfc64 8209fd40 fffffbff 00000189 00000000 00000000
        81349a50 00000064 00000002 80fb0000 80fb0000 00000001 80ecfc64 80fd0000
        81730000 80fb0000 00000080 80fb1858 00000000 00000000 00000000 81100000
        ...
Call Trace:
[<8010a2ec>] show_stack+0x38/0x118
[<80c490ac>] dump_stack_lvl+0xac/0x104
[<801c0e68>] __irq_resolve_mapping+0x148/0x1f0
[<807275a8>] plat_irq_dispatch+0x84/0x114
[<801038c0>] handle_int+0x160/0x16c
[<80103720>] __r4k_wait+0x20/0x40
[<80c600a4>] default_idle_call+0x9c/0x2e0
[<80173024>] do_idle+0x10c/0x1cc
[<801734b8>] cpu_startup_entry+0x24/0x3c
[<8106cf54>] start_kernel+0x790/0x7d8
[<80c55f50>] kernel_entry+0x0/0xa8


=============================
WARNING: suspicious RCU usage
5.13.0-09882-ga180bd1d7e16 #1 Not tainted
-----------------------------
include/linux/rcupdate.h:716 rcu_read_unlock() used illegally while idle!

other info that might help us debug this:


rcu_scheduler_active = 2, debug_locks = 1
RCU used illegally from extended quiescent state!
1 lock held by swapper/0/0:
 #0: 80fd43cc (rcu_read_lock){....}-{1:2}, at: __irq_resolve_mapping+0x28/0x1f0

stack backtrace:
CPU: 0 PID: 0 Comm: swapper/0 Not tainted 5.13.0-09882-ga180bd1d7e16 #1
Stack : 00000080 00000000 00000047 801b2c84 80cd0000 00000004 00000000 00000000
        8209ff1c 3bdd5c9d 80fb0000 810f9930 80fb0000 00000001 8209feb8 820fcec0
        00000000 00000000 80ecfc64 8209fd40 fffffbff 000001a9 00000000 00000000
        81349a50 00000064 00000002 80fb0000 80fb0000 00000001 80ecfc64 80fd0000
        81730000 80fb0000 00000080 80fb1858 00000000 00000000 00000000 81100000
        ...
Call Trace:
[<8010a2ec>] show_stack+0x38/0x118
[<80c490ac>] dump_stack_lvl+0xac/0x104
[<801c0ea8>] __irq_resolve_mapping+0x188/0x1f0
[<807275a8>] plat_irq_dispatch+0x84/0x114
[<801038c0>] handle_int+0x160/0x16c
[<80103720>] __r4k_wait+0x20/0x40
[<80c600a4>] default_idle_call+0x9c/0x2e0
[<80173024>] do_idle+0x10c/0x1cc
[<801734b8>] cpu_startup_entry+0x24/0x3c
[<8106cf54>] start_kernel+0x790/0x7d8
[<80c55f50>] kernel_entry+0x0/0xa8


=============================
WARNING: suspicious RCU usage
5.13.0-09882-ga180bd1d7e16 #1 Not tainted
-----------------------------
include/trace/events/lock.h:58 suspicious rcu_dereference_check() usage!

other info that might help us debug this:


rcu_scheduler_active = 2, debug_locks = 1
RCU used illegally from extended quiescent state!
1 lock held by swapper/0/0:
 #0: 80fd3c4c ((console_sem).lock){-...}-{2:2}, at: down_trylock+0x18/0x4c

stack backtrace:
CPU: 0 PID: 0 Comm: swapper/0 Not tainted 5.13.0-09882-ga180bd1d7e16 #1
Stack : 817924dc 8209fcfc 817924f0 00001fec 80ee11b8 80fb0000 81061e40 8071e768
        00000000 3bdd5c9d 80fb0000 810f9930 000001ec 00000001 8209fc98 820fcec0
        00000000 00000000 80ecfc64 00000001 0000000a 00000003 00000001 6d6f4320
        00000000 817926e9 817944dc 00000001 80fb0000 00000001 80ecfc64 81061e20
        80faea08 80e92708 00000000 80fb0000 00000000 00000000 00000000 81100000
        ...
Call Trace:
[<8010a2ec>] show_stack+0x38/0x118
[<80c490ac>] dump_stack_lvl+0xac/0x104
[<801a834c>] lock_release+0x3d0/0x46c
[<80c6080c>] _raw_spin_unlock_irqrestore+0x24/0xa0
[<80198854>] down_trylock+0x34/0x4c
[<801aef18>] __down_trylock_console_sem+0x44/0x120
[<801af370>] console_trylock+0x1c/0x88
[<801b2ccc>] vprintk_emit+0x124/0x404
[<801b2fcc>] vprintk_default+0x20/0x2c
[<80c3e6ac>] printk+0x34/0x58
[<80c3d884>] lockdep_rcu_suspicious+0x40/0x114
[<801a4164>] lock_acquire+0x418/0x498
[<801c0d80>] __irq_resolve_mapping+0x60/0x1f0
[<807275a8>] plat_irq_dispatch+0x84/0x114
[<801038c0>] handle_int+0x160/0x16c
[<80103720>] __r4k_wait+0x20/0x40
[<80c600a4>] default_idle_call+0x9c/0x2e0
[<80173024>] do_idle+0x10c/0x1cc
[<801734b8>] cpu_startup_entry+0x24/0x3c
[<8106cf54>] start_kernel+0x790/0x7d8
[<80c55f50>] kernel_entry+0x0/0xa8

---
bisect log:

# bad: [007b350a58754a93ca9fe50c498cc27780171153] Merge tag 'dlm-5.14' of git://git.kernel.org/pub/scm/linux/kernel/git/teigland/linux-dlm
# good: [62fb9874f5da54fdb243003b386128037319b219] Linux 5.13
git bisect start '007b350a5875' '62fb9874f5da'
# good: [36824f198c621cebeb22966b5e244378fa341295] Merge tag 'for-linus' of git://git.kernel.org/pub/scm/virt/kvm/kvm
git bisect good 36824f198c621cebeb22966b5e244378fa341295
# good: [122fa8c588316aacafe7e5a393bb3e875eaf5b25] Merge tag 'for-5.14-tag' of git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux
git bisect good 122fa8c588316aacafe7e5a393bb3e875eaf5b25
# bad: [3563f55ce65462063543dfa6a8d8c7fbfb9d7772] Merge tag 'pm-5.14-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm
git bisect bad 3563f55ce65462063543dfa6a8d8c7fbfb9d7772
# good: [c54b245d011855ea91c5beff07f1db74143ce614] Merge branch 'for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/ebiederm/user-namespace
git bisect good c54b245d011855ea91c5beff07f1db74143ce614
# bad: [21edf50948728f55b685ad95f196ba46196eb767] Merge tag 'irq-core-2021-06-29' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip
git bisect bad 21edf50948728f55b685ad95f196ba46196eb767
# bad: [c64638d5091a5630d0f5f5ab7001bdee1ad194f2] Merge branch irq/generic_handle_domain_irq-core into irq/irqchip-next
git bisect bad c64638d5091a5630d0f5f5ab7001bdee1ad194f2
# bad: [d4a45c68dc81f9117ceaff9f058d5fae674181b9] irqdomain: Protect the linear revmap with RCU
git bisect bad d4a45c68dc81f9117ceaff9f058d5fae674181b9
# good: [13a9a5d17d07cec8181ea0843674ce48c191628e] powerpc: Add missing linux/{of.h,irqdomain.h} include directives
git bisect good 13a9a5d17d07cec8181ea0843674ce48c191628e
# good: [1da027362a7db422243601e895e6f8288389f435] irqdomain: Reimplement irq_linear_revmap() with irq_find_mapping()
git bisect good 1da027362a7db422243601e895e6f8288389f435
# good: [4f86a06e2d6ece5316e4c42fbf946ee22acb30f3] irqdomain: Make normal and nomap irqdomains exclusive
git bisect good 4f86a06e2d6ece5316e4c42fbf946ee22acb30f3
# good: [48b15a7921d60680babe59f64e127816585a585c] irqdomain: Cache irq_data instead of a virq number in the revmap
git bisect good 48b15a7921d60680babe59f64e127816585a585c
# first bad commit: [d4a45c68dc81f9117ceaff9f058d5fae674181b9] irqdomain: Protect the linear revmap with RCU
