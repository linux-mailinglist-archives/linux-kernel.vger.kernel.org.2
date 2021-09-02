Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B9D43FF143
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Sep 2021 18:22:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346218AbhIBQXY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Sep 2021 12:23:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346137AbhIBQXX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Sep 2021 12:23:23 -0400
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22232C061575
        for <linux-kernel@vger.kernel.org>; Thu,  2 Sep 2021 09:22:25 -0700 (PDT)
Received: by mail-il1-x129.google.com with SMTP id u7so2391274ilk.7
        for <linux-kernel@vger.kernel.org>; Thu, 02 Sep 2021 09:22:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=TseH8xVhWOOp+bpzRkCyDdLN8bmoeYU2hdmJSnbKHa8=;
        b=zI0aXj9S1Jl5AemUMQ/5UklCaEUxXZrxcQZL/OE2Fb6n1tcRr4W/VirWkdEriWHT5y
         syWlzg6zQrN7P8Rk8ItLibZxRipyE8dufAvaM00oy/flcDFkbH2UrEmOQTm3Bf2OTF1V
         I3AK1hcfeIITdZvcdpinuk4/ZlOE9HDlmx8UFuKqE67hZIXUzm2sa8Jz5OBxYJRyMVbl
         98+BJwcblFusF1sZ+vcxI5akpsSYJJAnM+/38kCQOtGX+l+Qi9VMJQiCvjiPCVq4aQEH
         +Kex/n/029LbMhIWbBBUXEtbD3doR1mOfZlLbz2pYqV3xsMmrEj6+BFUAjRhfpovcaRL
         swcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=TseH8xVhWOOp+bpzRkCyDdLN8bmoeYU2hdmJSnbKHa8=;
        b=ct7HFOdjBYd8Fnr1W6RgX65RzgBw/pkM215Gbw/pHhFQ1oNTc47rlgyAUZdPus8cvy
         tRE3RTXYDMFiuYU/o70PyDx4gJVacCHVdifswvBAM1WdBCtuW+IQpm7kUMQUqaEqwtbM
         0b4a+JS8GxzTJpyU+8QWPcg/QSjHwBux0wQm5JTMvpLAWgfJl8YhpnFLEN9jwbgJdkuW
         L/MB0rLvgAhXNgeCjZGi2DfJglWurooSoX8kCFqpPEUguK3ijUeUu1wN1I4T+R8C+9Pp
         sJ7hhsv2x7lu9JN2JgavoXyg8kdOdRyjtqQKzEwNP+WA97Bi3fTBEOK3o465PRpVH8s/
         iwMw==
X-Gm-Message-State: AOAM532J6Bg24QgUQOCmSXZ1L0qz8Xj05I7+YoD0L7usNUD/T1RM6Lvl
        gLUi28lt91UfDiNMep1oOlc3CA==
X-Google-Smtp-Source: ABdhPJzWn873+2HdlozMaD10vkYiARwcb2eP7Om4ChnTNblJ5rBBFeifA6/TLLOfzGOW2aRFjvSz0Q==
X-Received: by 2002:a05:6e02:1905:: with SMTP id w5mr2892263ilu.165.1630599744535;
        Thu, 02 Sep 2021 09:22:24 -0700 (PDT)
Received: from [192.168.1.30] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id c5sm502785ilk.48.2021.09.02.09.22.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Sep 2021 09:22:24 -0700 (PDT)
To:     LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Christoph Lameter <cl@linux.com>,
        Linux Memory Management List <linux-mm@kvack.org>
From:   Jens Axboe <axboe@kernel.dk>
Subject: slub: BUG: Invalid wait context
Message-ID: <3b7661a1-dbde-ea54-f880-99777c95ae22@kernel.dk>
Date:   Thu, 2 Sep 2021 10:22:23 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Booting current -git yields the below splat. I'm assuming this is
related to the new RT stuff, where spin_lock() can sleep. This obviously
won't fly off IPI.

I'll leave the actual fix to others.

[    1.430398] =============================
[    1.430398] [ BUG: Invalid wait context ]
[    1.430398] 5.14.0+ #11360 Not tainted
[    1.430398] -----------------------------
[    1.430533] swapper/0/0 is trying to lock:
[    1.430743] ffff888100050918 (&n->list_lock){....}-{3:3}, at: deactivate_slab+0x213/0x540
[    1.431171] other info that might help us debug this:
[    1.431430] context-{2:2}
[    1.431567] no locks held by swapper/0/0.
[    1.431774] stack backtrace:
[    1.431923] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 5.14.0+ #11360
[    1.432246] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.14.0-0-g155821a1990b-prebuilt.qemu.org 04/01/2014
[    1.432826] Call Trace:
[    1.432961]  <IRQ>
[    1.433071]  dump_stack_lvl+0x45/0x59
[    1.433273]  __lock_acquire.cold+0x21a/0x34d
[    1.433504]  ? lock_chain_count+0x20/0x20
[    1.433722]  ? lockdep_hardirqs_on_prepare+0x1f0/0x1f0
[    1.433990]  ? __lock_acquire+0x86b/0x30b0
[    1.434206]  lock_acquire+0x157/0x3e0
[    1.434399]  ? deactivate_slab+0x213/0x540
[    1.434615]  ? lock_release+0x410/0x410
[    1.434815]  ? lockdep_hardirqs_on_prepare+0x1f0/0x1f0
[    1.435081]  ? mark_held_locks+0x65/0x90
[    1.435286]  ? lock_is_held_type+0x98/0x110
[    1.435509]  ? lock_is_held_type+0x98/0x110
[    1.435728]  _raw_spin_lock+0x2c/0x40
[    1.435922]  ? deactivate_slab+0x213/0x540
[    1.436136]  deactivate_slab+0x213/0x540
[    1.436341]  ? sched_clock_tick+0x49/0x80
[    1.436556]  ? lock_is_held_type+0x98/0x110
[    1.436774]  flush_cpu_slab+0x34/0x50
[    1.436966]  flush_smp_call_function_queue+0xf6/0x2c0
[    1.437228]  ? slub_cpu_dead+0xe0/0xe0
[    1.437426]  __sysvec_call_function_single+0x6b/0x280
[    1.437691]  sysvec_call_function_single+0x65/0x90
[    1.437940]  </IRQ>
[    1.438053]  asm_sysvec_call_function_single+0xf/0x20
[    1.438314] RIP: 0010:default_idle+0x10/0x20
[    1.438539] Code: ff f0 80 63 02 df 5b 41 5c c3 0f ae f0 0f ae 3b 0f ae f0 eb 90 0f 1f 44 00 00 0f 1f 44 00 00 eb 07 0f 00 2d 92 5d 45 00 fb f4 <c3> cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc 0f 1f 44 00 00 41
[    1.439481] RSP: 0000:ffffffff82a07e60 EFLAGS: 00000206
[    1.439605] RAX: 0000000000001811 RBX: ffffffff82a1f400 RCX: ffffffff81dbddc5
[    1.439605] RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffffffff81dce145
[    1.439605] RBP: 0000000000000000 R08: 0000000000000001 R09: ffff8881f7630b0b
[    1.439605] R10: ffffed103eec6161 R11: 0000000000000000 R12: ffffffff8306c7b0
[    1.439605] R13: 0000000000000000 R14: 0000000000000000 R15: 1ffffffff0540fd1
[    1.439605]  ? rcu_eqs_enter.constprop.0+0xa5/0xc0
[    1.439605]  ? default_idle_call+0x45/0xb0
[    1.439605]  default_idle_call+0x7d/0xb0
[    1.439605]  do_idle+0x31c/0x3d0
[    1.439605]  ? lock_downgrade+0x390/0x390
[    1.439605]  ? arch_cpu_idle_exit+0x40/0x40
[    1.439605]  cpu_startup_entry+0x19/0x20
[    1.439605]  start_kernel+0x38d/0x3ab
[    1.439605]  secondary_startup_64_no_verify+0xb0/0xbb


-- 
Jens Axboe

