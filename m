Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 069353D88F2
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jul 2021 09:38:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234924AbhG1HiG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jul 2021 03:38:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234420AbhG1HiF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jul 2021 03:38:05 -0400
Received: from mail-qk1-x74a.google.com (mail-qk1-x74a.google.com [IPv6:2607:f8b0:4864:20::74a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9CEAC061765
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jul 2021 00:38:02 -0700 (PDT)
Received: by mail-qk1-x74a.google.com with SMTP id bm25-20020a05620a1999b02903a9c3f8b89fso1108125qkb.2
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jul 2021 00:38:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=5eg2+Tx3JvGw0D/CoMC3TdXMf/9Gd8U3krkUaz50BE4=;
        b=YjWoCulCWdRiMh559k1gu53KFjE25x7ITIVRM+Gpcau0BRGejZjppdXq5wQaUqptvS
         2wS23MNxzuEs81183XFX7azhFf47Vzg7uYsocxqGIbAJdMYRClw3xBDIr/f2Z5vZnxk3
         iCfFEIXsxb7L6EWlmPBmgo7NUJI29kr4co+0d1oOX8Mv7LT+SHu85iZ3g956uur+90E8
         rWDYm9PSk53uLesp8hrWItMDdG64S/FzO6OfqZSCmPAEkqAdX5a+FI1N8XjBJTVDCjN6
         5Ulh84g53ek4VkBLTIrvYGbo5mLQr5jzAaSDAIlptYY15jMBW2bbbtyCAuijI9sPnMCJ
         zQFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=5eg2+Tx3JvGw0D/CoMC3TdXMf/9Gd8U3krkUaz50BE4=;
        b=feznMdQLbTtwH8K4O1UHoaBX/8X15+RBY3oHdHMNikjcA5KSE46YvqJOa/mXSoGPoZ
         CoZlLDiaBTM8FUS4hQ/vzL88VhwnMqR8hiq2UcHkL9W2VUK6nu0w6jTFfDTlIwyMRcUV
         zpmasEB97mxcCwqGuRZzZI7ek41oQpsDdvFSfgwJHSApbEr/0lCMrpcD8waD0+k0a6VJ
         jEQCDPu9WkrzSEncLjRv7+CzR1OzPmq6JR3Wi39Q0RH0dA2r4Pwvlj4S6xxTjNg+dMt+
         adPKRebIH0jN1gs2r0biQrNfjWR2Ks7iBn/6SFRdUS1BXlekd+ishljikPiw83kr5Mj6
         ypJw==
X-Gm-Message-State: AOAM533ljB3T+RQB7MgGEWna4qkBHLNySM+ZbJX9AZYYOSRJtI8wmcJm
        soGvjBUQKHBx0lwiWTeg/IJ5esoRdLmWBA==
X-Google-Smtp-Source: ABdhPJys6zaKFkNkcgZz61eDoAjNFYsOdhgGTnIoso4z5MQI9WOLafpDTKq3TC2DOZIFLhhZ9NPox/A7RtRx+A==
X-Received: from suleiman1.tok.corp.google.com ([2401:fa00:8f:203:44f4:48a1:aec5:6e5b])
 (user=suleiman job=sendgmr) by 2002:a05:6214:10c8:: with SMTP id
 r8mr27013812qvs.28.1627457882078; Wed, 28 Jul 2021 00:38:02 -0700 (PDT)
Date:   Wed, 28 Jul 2021 16:36:58 +0900
Message-Id: <20210728073700.120449-1-suleiman@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.32.0.432.gabb21c7263-goog
Subject: [RFC PATCH 0/2] KVM: Support Heterogeneous RT VCPU Configurations.
From:   Suleiman Souhlal <suleiman@google.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>
Cc:     ssouhlal@FreeBSD.org, joelaf@google.com, senozhatsky@chromium.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        Suleiman Souhlal <suleiman@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

This series attempts to solve some issues that arise from
having some VCPUs be real-time while others aren't.

We are trying to play media inside a VM on a desktop environment
(Chromebooks), which requires us to have some tasks in the guest
be serviced at real-time priority on the host so that the media
can be played smoothly.

To achieve this, we give a VCPU real-time priority on the host
and use isolcpus= to ensure that only designated tasks are allowed
to run on the RT VCPU.
In order to avoid priority inversions (for example when the RT
VCPU preempts a non-RT that's holding a lock that it wants to
acquire), we dedicate a host core to the RT vcpu: Only the RT
VCPU is allowed to run on that CPU, while all the other non-RT
cores run on all the other host CPUs.

This approach works on machines that have a large enough number
of CPUs where it's possible to dedicate a whole CPU for this,
but we also have machines that only have 2 CPUs and doing this
on those is too costly.

This patch series makes it possible to have a RT VCPU without
having to dedicate a whole host core for it.
It does this by making it so that non-RT VCPUs can't be
preempted if they are in a critical section, which we
approximate as having interrupts disabled or non-zero
preempt_count. Once the VCPU is found to not be in a critical
section anymore, it will give up the CPU.
There measures to ensure that preemption isn't delayed too
many times.

(I realize that the hooks in the scheduler aren't very
tasteful, but I couldn't figure out a better way.
SVM support will be added when sending the patch for
inclusion.)

Feedback or alternatives are appreciated.

Thanks,
-- Suleiman


Suleiman Souhlal (2):
  kvm,x86: Support heterogeneous RT VCPU configurations.
  kvm,x86: Report preempt_count to host.

 arch/x86/Kconfig                     | 11 +++++
 arch/x86/include/asm/kvm_host.h      |  7 +++
 arch/x86/include/uapi/asm/kvm_para.h |  2 +
 arch/x86/kernel/kvm.c                | 10 ++++
 arch/x86/kvm/Kconfig                 | 13 ++++++
 arch/x86/kvm/cpuid.c                 |  3 ++
 arch/x86/kvm/vmx/vmx.c               | 15 ++++++
 arch/x86/kvm/x86.c                   | 70 +++++++++++++++++++++++++++-
 arch/x86/kvm/x86.h                   |  2 +
 include/linux/kvm_host.h             |  4 ++
 include/linux/preempt.h              |  7 +++
 kernel/sched/core.c                  | 30 ++++++++++++
 virt/kvm/Kconfig                     |  3 ++
 virt/kvm/kvm_main.c                  | 13 ++++++
 14 files changed, 189 insertions(+), 1 deletion(-)

-- 
2.32.0.432.gabb21c7263-goog

