Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58A55390D65
	for <lists+linux-kernel@lfdr.de>; Wed, 26 May 2021 02:38:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232533AbhEZAkA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 May 2021 20:40:00 -0400
Received: from mail-ej1-f51.google.com ([209.85.218.51]:36704 "EHLO
        mail-ej1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230106AbhEZAj7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 May 2021 20:39:59 -0400
Received: by mail-ej1-f51.google.com with SMTP id c20so50154874ejm.3
        for <linux-kernel@vger.kernel.org>; Tue, 25 May 2021 17:38:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SN1n3KmUQF/CJQe15RgbxrBoOLPLb/jSDiUbBOw0t74=;
        b=WeLe53qbER8deddz4MwfAHoXQbuJan5JOsBbGVachLQuK+RHCn73APw01l8VBmV1Pq
         /xPL0AXKiq+BRNU3ADmsyaG/jdNBZDKK+HGN89me7Ncq/8sCNKbpNxkH5t94aDNSexXN
         1i9rIi6pUINwS6auNKZs7ddVK8X4n8/cr7sTtdO/0VQktVydnmFNuN2k3AX8QFN7d56c
         sVJiiV9p122chgQzCvXzZJckbV3yYXe83zgMzaIdFu5Cnvu5+ZZXh3sjOpp0Yye13IBH
         8N+MoX130l3ZnwdVVWIqbfRSd8B6uJYeYirSTg1zuzcwOdDzoVH4WJOFvSeunDYJbjmF
         qtRg==
X-Gm-Message-State: AOAM532MYvJUXP89PhlPq4a4bdZr8XuWp7Tuu2PJZoHnXtp0altkJgq8
        y+xjxPkvLEQM8pcvlZNJ6JhE1tny41rMSJMGB/o=
X-Google-Smtp-Source: ABdhPJxhJb/FaHTg7NMgBnNwYOutQjXmHhLof8/CcGe18d9CFjr7qb/27e+LqbcZiw5A1U9bVgrtbSlJ5eLRRtcbMmE=
X-Received: by 2002:a17:906:2dca:: with SMTP id h10mr30719387eji.507.1621989507375;
 Tue, 25 May 2021 17:38:27 -0700 (PDT)
MIME-Version: 1.0
References: <20210523193259.26200-1-chang.seok.bae@intel.com>
 <20210523193259.26200-16-chang.seok.bae@intel.com> <CAJvTdKnrFSS0fvhNz5mb9v8epEVtphUesEUV0hhNErMBK5HNHQ@mail.gmail.com>
In-Reply-To: <CAJvTdKnrFSS0fvhNz5mb9v8epEVtphUesEUV0hhNErMBK5HNHQ@mail.gmail.com>
From:   Len Brown <lenb@kernel.org>
Date:   Tue, 25 May 2021 20:38:16 -0400
Message-ID: <CAJvTdKmzN0VMyH8VU_fdzn2UZqmR=_aNrJW01a65BhyLm6YRPg@mail.gmail.com>
Subject: Re: [PATCH v5 15/28] x86/arch_prctl: Create ARCH_GET_XSTATE/ARCH_PUT_XSTATE
To:     "Chang S. Bae" <chang.seok.bae@intel.com>
Cc:     Borislav Petkov <bp@suse.de>, Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, X86 ML <x86@kernel.org>,
        "Brown, Len" <len.brown@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        "Liu, Jing2" <jing2.liu@intel.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After today's discussion, I believe we are close to consensus on this plan:

1. Kernel sets XCR0.AMX=1 at boot, and leaves it set, always.

2. Kernel arms XFD for all tasks, by default.

3. New prctl() system call allows any task in a process to ask for AMX
permission for all tasks in that process. Permission is granted for
the lifetime of that process, and there is no interface for a process
to "un-request" permission.

4. If a task touches AMX without permission, #NM/signal kills the process

5. If a task touches AMX with permission, #NM handler will
transparently allocate a context switch buffer, and disarm XFD for
that task. (MSR_XFD is context switched per task)

6. If the #NM handler can not allocate the 8KB buffer, the task will
receive a signal at the instruction that took the #NM fault, likely
resulting in program exit.

7. In addition, a 2nd system call to request that buffers be
pre-allocated is available. This is a per task system call. This
synchronous allocate system call will return an error code if it
fails, which will also likely result in program exit.

8. NEW TODAY: Linux will exclude the AMX 8KB region from the XSTATE on
the signal stack for tasks in process that do not have AMX permission.

9. For tasks in processes that have requested and received AMX
permission, Linux will XSAVE/XRESTOR directly to/from the signal
stack, and the stack will always include the 8KB space for AMX. (we do
have a manual optimization to in place to skip writing zeros to the
stack frame if AMX=INIT)

10. Linux reserves the right to plumb the new permission syscall into
cgroup administrative interface in the future.

Comments:

Legacy software will not see signal stack growth on AMX hardware.

New AMX software will see AMX state on the signal stack.

If new AMX software uses an alternative signal stack, it should be
built using the signal.h ABI in glibc 2.34 or later, so that it can
calculate the appropriate size for the current hardware.  Note that
non-AMX software that is newly built will get the same answer from the
ABI, which would handle the case if it does use AMX.

Today it is possible for an application to calculate the uncompressed
XSTATE size from XCR0 and CPUID, allocate buffers of that size, and
use XSAVE and XRESTOR on those buffers in user-space.  Applications
can also XRESTOR from (and XSAVE back to) the signal stack, if they
choose.  Now, this capability can break for non-AMX programs, because
their XSAVE will be 8KB  larger than the buffer that they XRESTOR.
Andy L questions whether such applications actually exist, and Thomas
states that even if they do, that is a much smaller problem than 8KB
signal stack growth would be for legacy applications.

Unclear if we have consensus on the need for a synchronous allocation
system call (#7 above).  Observe that this system call does not
improve the likelihood of failure or the timing of failure.  An
#NM-based allocation and be done at exactly the same spot by simply
touching a TMM register.  The benefit of this system call is that it
returns an error code to the caller, versus the program being
delivered a SIGSEGV at the offending instruction pointer.  Both will
likely result in the program exiting, and at the same point in
execution.

A future mechanism to lazy harvest not-recently-used context switchy
buffers has been discussed.  Eg. the kernel under low memory could
re-arm XFD for all AMX tasks, and if their buffers are clean, free
them.  If that mechanism is implemented, and we also implement the
synchronous allocation system call, that mechanism must respect the
guarantee made by that system call and not harvest
system-call-allocated buffers.

Len Brown, Intel Open Source Technology Center
