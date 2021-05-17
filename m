Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6038A386CA9
	for <lists+linux-kernel@lfdr.de>; Mon, 17 May 2021 23:53:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245688AbhEQVy3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 May 2021 17:54:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244209AbhEQVy2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 May 2021 17:54:28 -0400
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C7E3C061573
        for <linux-kernel@vger.kernel.org>; Mon, 17 May 2021 14:53:11 -0700 (PDT)
Received: by mail-io1-xd2e.google.com with SMTP id z24so7351855ioj.7
        for <linux-kernel@vger.kernel.org>; Mon, 17 May 2021 14:53:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=7HA4LMLlQ5q/6D2Vdk9TNJnSmvrOTaQXJriY7IT/AeI=;
        b=Y73pck7vVslJjEBWPGAM3mtXgjWznARz9+nh6wzjpWucLfnLSDQWo41DWjFJm8wzNp
         Db/pxz7egup1xXBu/JRxLqVovylHUSGge44ltwwgpy8Q1wscsiQ0O55cs6ojtkt//Civ
         4iI2bq+617e4hjxi7WPvjZ7ZjyTuerYsJ7bbAZUoSaqJ1Q2xxRRbvV6oPmJwftPhPhkk
         JE+fq8yBZCqMpLw0HKEws3TxXXhp6Wo1ugf+VXqdpAZsl93Ba+82ScFd10eTC0/gKIVm
         89h5CNsr33p1aPEd2xa88KEmEvp5hb5Y+dzVw+8TQny9luRaf+4SLJ2hy+aAC/1yrzGB
         D7tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=7HA4LMLlQ5q/6D2Vdk9TNJnSmvrOTaQXJriY7IT/AeI=;
        b=M9lpDJgJ/k/+HTWFW6Y5ElK3i2phoIOpliwKqHrcbVoeqoqdszIjbI41T3RNVqpDfY
         vCBIEn8XzlYM1YWv8Ngzt/nNHDUVFcJLeDaB75iKPlrhjmqgE5e1hbrtNoAc2VP80h8K
         5FFk6nrCSya1UKo+sHZL3EuBEZFkRzguQRcshBlfGnT4Q8DUyLnmiGJYQa7bAqBBaI83
         de7ozfUo6dpHNydhegScFNcma204Tz7xR7/IGAwlsYsSJdj/KBftRSpkbebGdcA7jxXU
         A0ta4yEyeIMjwhy7gCwrUt4aHwkT3jsiR0sCUkOS5Bi/owZhnS/XTS3lHSobnLwJ0Jd9
         8P5Q==
X-Gm-Message-State: AOAM533s+7NeYdGtbWtmWBNT9DuZdH8yKmDCfnU/Jqj1E16FH8xkQe+L
        yHQeT+lkjRd9H7BVtVL+KJM16jV/Vx05GHtp0B8=
X-Google-Smtp-Source: ABdhPJwxtlUEji4n4amL39e+oRwUQOEppAlkWEqCgGbA3D4ACTn2WBn2qwgvLx68jVBbssgQMN63AVrAgR7NH5Kh93g=
X-Received: by 2002:a6b:690c:: with SMTP id e12mr1685762ioc.69.1621288390997;
 Mon, 17 May 2021 14:53:10 -0700 (PDT)
MIME-Version: 1.0
From:   John Stultz <john.stultz@linaro.org>
Date:   Mon, 17 May 2021 14:52:59 -0700
Message-ID: <CANcMJZDOMZVj6WVEe+7b--Rwkdg1-WVFfHkVm4KR-ykS4LxQFQ@mail.gmail.com>
Subject: REGRESSION: kernel BUG at arch/arm64/kernel/alternative.c:157!
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Kees Cook <keescook@chromium.org>
Cc:     Will Deacon <will@kernel.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        YongQin Liu <yongqin.liu@linaro.org>,
        Amit Pundir <amit.pundir@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With v5.13-rc2, I've been seeing an odd boot regression with the
DragonBoard 845c:

Unfortunately, trying to bisect it down (v5.13-rc1 works ok) is giving
me inconsistent results so far. It feels a bit like maybe some config
option gets enabled moving forward, and then sticks around when we go
back.  I'll take another swing at bisecting it later today, but I have
to move on to some other work right now, so I figured I'd share (with
folks who better know the recent __apply_alternatives changes) in case
folks have a better idea:

[    0.254384] CPU features: detected: RAS Extension Support
[    0.259928] CPU: All CPU(s) started at EL1
[    0.264127] alternatives: patching kernel code
[    0.268635] ------------[ cut here ]------------
[    0.273303] kernel BUG at arch/arm64/kernel/alternative.c:157!
[    0.279192] Internal error: Oops - BUG: 0 [#1] PREEMPT SMP
[    0.284736] Modules linked in:
[    0.287833] CPU: 0 PID: 14 Comm: migration/0 Not tainted
5.13.0-rc2-mainline #4501
[    0.295472] Hardware name: Thundercomm Dragonboard 845c (DT)
[    0.301182] Stopper: multi_cpu_stop+0x0/0x1a0 <-
stop_machine_cpuslocked+0x128/0x160
[    0.309020] pstate: 204000c5 (nzCv daIF +PAN -UAO -TCO BTYPE=--)
[    0.315086] pc : __apply_alternatives+0x1f0/0x270
[    0.319847] lr : __apply_alternatives+0xf4/0x270
[    0.324515] sp : ffffffc01020bca0
[    0.327874] x29: ffffffc01020bca0 x28: 00000000000000a0 x27: ffffffd7f5c11124
[    0.335086] x26: ffffffd7f5c11128 x25: 00000000001b0020 x24: ffffffd7f700ab90
[    0.342297] x23: 0000000000000000 x22: ffffffc01020bd20 x21: ffffffd7f7bea374
[    0.349508] x20: ffffffc01020bd30 x19: ffffffd7f72194fc x18: ffffffffffffffff
[    0.356718] x17: ffffffd7f7bdce40 x16: 000000005c8e1b43 x15: ffffffd7f76d9d10
[    0.363929] x14: ffffffc09020b967 x13: ffffffc01020b975 x12: ffffffd7f76d9e30
[    0.371140] x11: 0000000005f5e0ff x10: ffffffc01020b8c0 x9 : 00000000ffffffd0
[    0.378350] x8 : 6b20676e69686374 x7 : ffffffd7f79b9238 x6 : c0000000ffff7fff
[    0.385560] x5 : 0000000000000000 x4 : ffffffd7f5c22898 x3 : 0000000000000010
[    0.392771] x2 : 0000000000000004 x1 : 0000000000000000 x0 : 000000000000003f
[    0.399982] Call trace:
[    0.402461]  __apply_alternatives+0x1f0/0x270
[    0.406873]  __apply_alternatives_multi_stop+0xc0/0xe0
[    0.412062]  multi_cpu_stop+0xb8/0x1a0
[    0.415851]  cpu_stopper_thread+0xac/0x120
[    0.419997]  smpboot_thread_fn+0x200/0x238
[    0.424146]  kthread+0x14c/0x158
[    0.427423]  ret_from_fork+0x10/0x1c
[    0.431045] Code: 39402e61 39402a62 6b01005f 54fff500 (d4210000)
[    0.437199] ---[ end trace 523e13d9d60a992d ]---
[    0.441868] note: migration/0[14] exited with preempt_count 2
[    0.447739] migration/0 (14) used greatest stack depth: 12448 bytes left
[    0.454543] ------------[ cut here ]------------
[    0.459211] WARNING: CPU: 0 PID: 0 at kernel/rcu/tree.c:638
rcu_eqs_enter.isra.62+0x98/0x138
[    0.467734] Modules linked in:
[    0.470826] CPU: 0 PID: 0 Comm: swapper/0 Tainted: G      D
  5.13.0-rc2-mainline #4501
[    0.479594] Hardware name: Thundercomm Dragonboard 845c (DT)
[    0.485303] pstate: 204003c5 (nzCv DAIF +PAN -UAO -TCO BTYPE=--)
[    0.491366] pc : rcu_eqs_enter.isra.62+0x98/0x138
[    0.496122] lr : rcu_eqs_enter.isra.62+0x10/0x138
[    0.500878] sp : ffffffd7f76d3e70
[    0.504236] x29: ffffffd7f76d3e70 x28: ffffffd7f76e9780 x27: 0000000000000000
[    0.511448] x26: 0000000000000000 x25: ffffffd7f707a480 x24: ffffffd7f72c14f0
[    0.518660] x23: ffffffd7f76d9000 x22: ffffffd7f7d4c000 x21: ffffffd7f76d9000
[    0.525871] x20: ffffffd7f76e9780 x19: ffffff80fd6a1380 x18: ffffffffffffffff
[    0.533082] x17: 0000000000000000 x16: 000000000000000e x15: ffffffd7f76d9d10
[    0.540293] x14: ffffffc09020b5f7 x13: ffffffd7f70130b0 x12: ffffffd7f76d9e30
[    0.547504] x11: 0000000005f5e0ff x10: 0000000000000a10 x9 : ffffffd7f76d3e00
[    0.554715] x8 : ffffffd7f76ea1f0 x7 : 0000000000000000 x6 : 00000000fffedb36
[    0.561926] x5 : 00000000ffffffff x4 : ffffffa9063de000 x3 : 0000000000000001
[    0.569136] x2 : 4000000000000000 x1 : ffffffd7f76da768 x0 : 4000000000000002
[    0.576347] Call trace:
[    0.578825]  rcu_eqs_enter.isra.62+0x98/0x138
[    0.583236]  rcu_idle_enter+0x14/0x20
[    0.586941]  default_idle_call+0x44/0x1b8
[    0.591003]  do_idle+0x200/0x2a0
[    0.594279]  cpu_startup_entry+0x2c/0x50
[    0.598251]  rest_init+0xd4/0xe0
[    0.601524]  arch_call_rest_init+0x14/0x1c
[    0.605680]  start_kernel+0x504/0x538
[    0.609382] ---[ end trace 523e13d9d60a992e ]---
