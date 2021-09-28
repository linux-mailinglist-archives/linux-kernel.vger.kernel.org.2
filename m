Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F15D41AB87
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Sep 2021 11:09:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239858AbhI1JLU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Sep 2021 05:11:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239795AbhI1JLQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Sep 2021 05:11:16 -0400
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFF8DC061575
        for <linux-kernel@vger.kernel.org>; Tue, 28 Sep 2021 02:09:36 -0700 (PDT)
Received: by mail-ot1-x32a.google.com with SMTP id r43-20020a05683044ab00b0054716b40005so21215987otv.4
        for <linux-kernel@vger.kernel.org>; Tue, 28 Sep 2021 02:09:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=lubeOMe06ElGBawefRYKAXVTA24IW08hr7PtPpVm+i4=;
        b=Pn0osy597Xd/0Cl1POHrl7nDv2YMTz672fqfrqUCAEKGWqjRIFwmTxquIsO+IhSeIK
         Fk1Ozkeg1Jo480pHe6/HSmBeXifcWhbt6iwGNlChjgAKHVuitO9pZJt7sRb1KVTonGOU
         avxm3NjGD2W+qLDGtNAlohpiFFyI9oPor+Bv1eQO7qgr9WGWqjae8TtCIcqaP9J7alwl
         A5GN0jKFsnl7KQWX4XwKOc/1yzHRZIOSjMxtyQRvS4iqFt2Df29XCbbmkFF0QPrOlQRX
         3kwvNCySvYBeZziQBjQVzD/VFuh+a1mbBsR2eN6R0AeC4DZxJUC2MnlcLdm4JNBjS89H
         +2rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=lubeOMe06ElGBawefRYKAXVTA24IW08hr7PtPpVm+i4=;
        b=MqxH8WdNU5T9ckVwiBpDlZ4QWVC/BoF0+rtWCR2ryhC00a7ZvR4q+EN6eQo9XGsKuc
         6rnWyWRgGbjEwVbX/3uv6QgsTTIee8UKQdtowMqmMJyr8WWc2HqsRvp9m2qE4w/fCeX9
         N83m+uG1gu65/bRBmPDzg1yXONR/y/ZdAYv/G1O4EbtJP8ZtiD6sYiJCaCo7xIiJ4Nfu
         SmJYMkoZbv4KvUB4/gGL4LVAkIGL0si3et19g/0v8evj3fGTfcO0wPuCFC9qAygicnkg
         jODQD+l8dKIHcuxJMSH031c6nyRNOXthjOFlNoIFlRNeFcHLEgfRW1lxUc+wavs8ZqyU
         xABw==
X-Gm-Message-State: AOAM530jsfQTiJm3jL7Eztx2kTu6MZB43/MojMfrAGM7CmgnMUVNRJKz
        w2qHPZqTt2Xao2QYpNriPVfRAlFBc4UWKoQHtVJXww==
X-Google-Smtp-Source: ABdhPJwiMChGhBVboJWynOdTMaByjMEhRfdx2lrzuDtyfOuxQnAuxXB3FNqbm6wwWhlyGL7hcU85KP1voKb8Wcd4TZU=
X-Received: by 2002:a9d:2f28:: with SMTP id h37mr4112755otb.196.1632820175845;
 Tue, 28 Sep 2021 02:09:35 -0700 (PDT)
MIME-Version: 1.0
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Tue, 28 Sep 2021 11:09:24 +0200
Message-ID: <CACT4Y+bgzorbDgYw=cguZ4WuZeLbqsdyKUeGiyQq3Vo9jyjs6Q@mail.gmail.com>
Subject: rseq with syscall as the last instruction
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi rseq maintainers,

I wonder if rseq can be used in the following scenario (or extended to be used).
I want to pass extra arguments to syscalls using a kind of
side-channel, for example, to say "do fault injection for the next
system call", or "trace the next system call". But what is "next"
system call should be atomic with respect to signals.
Let's say there is shared per-task memory location known to the kernel
where these arguments can be stored:

__thread struct trace_descriptor desk;
prctl(REGISTER_PER_TASK_TRACE_DESCRIPTOR, &desk);

then before a system call I can setup the descriptor to enable tracing:

desk = ...
SYSCALL;

The problem is that if a signal arrives in between we setup desk and
SYSCALL instruction, we will actually trace some unrelated syscall in
the signal handler.
Potentially the kernel could switch/restore 'desk' around syscall
delivery, but it becomes tricky/impossible for signal handlers that do
longjmp or mess with PC in other ways; and also would require
extending ucontext to include the desc information (not sure if it's
feasible).

So instead the idea is to protect this sequence with rseq that will be
restarted on signal delivery:

enter rseq critical section with end right after SYSCALL instruction;
desk = ...
SYSCALL;

Then, the kernel can simply clear 'desc', on syscall delivery.

rseq docs seem to suggest that this can work:

https://lwn.net/Articles/774098/
+Restartable sequences are atomic with respect to preemption (making it
+atomic with respect to other threads running on the same CPU), as well
+as signal delivery (user-space execution contexts nested over the same
+thread). They either complete atomically with respect to preemption on
+the current CPU and signal delivery, or they are aborted.

But the doc also says that the sequence must not do syscalls:

+Restartable sequences must not perform system calls. Doing so may result
+in termination of the process by a segmentation fault.

The question is:
Can this restriction be weakened to allow syscalls as the last instruction?
For flags in this case we would pass
RSEQ_CS_FLAG_NO_RESTART_ON_PREEMPT and
RSEQ_CS_FLAG_NO_RESTART_ON_MIGRATE, but no
RSEQ_CS_FLAG_NO_RESTART_ON_SIGNAL.

I don't see any fundamental reasons why this couldn't work b/c if we
restart only on signals, then once we reach the syscall, rseq critical
section is committed, right?

Do you have any feeling of how hard it would be to support or if there
can be some implementation issues?

Thank you
