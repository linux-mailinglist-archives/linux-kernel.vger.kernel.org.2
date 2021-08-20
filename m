Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49BAC3F36AC
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Aug 2021 00:50:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234317AbhHTWvE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Aug 2021 18:51:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230527AbhHTWvD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Aug 2021 18:51:03 -0400
Received: from mail-qt1-x84a.google.com (mail-qt1-x84a.google.com [IPv6:2607:f8b0:4864:20::84a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7FA6C061575
        for <linux-kernel@vger.kernel.org>; Fri, 20 Aug 2021 15:50:24 -0700 (PDT)
Received: by mail-qt1-x84a.google.com with SMTP id t35-20020a05622a1823b02902647b518455so5659082qtc.3
        for <linux-kernel@vger.kernel.org>; Fri, 20 Aug 2021 15:50:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=reply-to:date:message-id:mime-version:subject:from:to:cc;
        bh=gyS/18bxD5Ot3om3ClN1RHHdw6uDm46TAPmhFRClN7E=;
        b=c0x2Ekl31aHgoUr6bS0aBngW8SrcCyXGQ6Eg5RkenHrpLPuk61rKOt6P1SLL5kGpCV
         7Q/hwVqrOW+gQ/v3K19SjHlrik6vUlVurzVNjzrPZuy8yaIJYuxpQBictxecVo5Nq+kp
         75zG8M002Kjp/q5WlQpL9i9sO4ZrKNxIQavsXfw2HehYTn5oog/nQS8x/qaEbhMPUOUM
         ccXmKxYBcJpZ+gmTSFvQXJWzizQ+B84f2u2Q9D1+hN2pszPtrQntT2CFvtwN7i4kDteh
         N7lB2iyqekXxnNmmaDxg+oJ9mOUY3XV5hIyhddm0GtJ4OgnYpsgomnp8ihDtrwm3h+GE
         x/ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:date:message-id:mime-version:subject
         :from:to:cc;
        bh=gyS/18bxD5Ot3om3ClN1RHHdw6uDm46TAPmhFRClN7E=;
        b=rLPoxWTc+aME4NMOSqLJfJnaIJ4WKHpuZDGtq5PS6wQdUk6MbtYs26UZxZp52G7lYa
         lduNilQbG5WVwBAP97LQlYiXwqOf/Udb6pe96ph7WrXC8dZvMm9nhksHPChF9RJl9reJ
         H5ZK0xdf5pwpAKZFz2vkTzlG0qVdYtQhw1NOiuOOUK3tKetiMI4iVM268eMGqGKIWV3g
         YU1ayNST4tvezxwVrAXb1Pm3xMzB2vM0X9yPp3A6tfzxAmVOm3JNwbrdTdA/dxAzQNPC
         BNcp4G+Br6DAkEoOny7UaixWZOi0AFGTucMe0O1EsGBTQcGtWv9FABr+Ab4A9SIl6lMN
         naLg==
X-Gm-Message-State: AOAM5313sodXWFmxwOUIalQIhqneYYEYfYat8SyHIRS0JOaQd/yUDCsR
        mZ2YjTU2/x079pjB/UPxqFmq9AJ5F/M=
X-Google-Smtp-Source: ABdhPJx4goZRGT6Tb8tV1HHxrF56PXshejmS+qu7yC6GJihmWv/bHnUoawuFayGttP22JtXzBIs2h2vWzkY=
X-Received: from seanjc798194.pdx.corp.google.com ([2620:15c:90:200:f11d:a281:af9b:5de6])
 (user=seanjc job=sendgmr) by 2002:a05:6214:ca2:: with SMTP id
 s2mr22615169qvs.35.1629499824082; Fri, 20 Aug 2021 15:50:24 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Fri, 20 Aug 2021 15:49:57 -0700
Message-Id: <20210820225002.310652-1-seanjc@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.33.0.rc2.250.ged5fa647cd-goog
Subject: [PATCH v2 0/5] KVM: rseq: Fix and a test for a KVM+rseq bug
From:   Sean Christopherson <seanjc@google.com>
To:     Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Guo Ren <guoren@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Shuah Khan <shuah@kernel.org>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-csky@vger.kernel.org, linux-mips@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        kvm@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Peter Foley <pefoley@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        Sean Christopherson <seanjc@google.com>,
        Ben Gardon <bgardon@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Patch 1 fixes a KVM+rseq bug where KVM's handling of TIF_NOTIFY_RESUME,
e.g. for task migration, clears the flag without informing rseq and leads
to stale data in userspace's rseq struct.

Patch 2 is a cleanup to try and make future bugs less likely.  It's also
a baby step towards moving and renaming tracehook_notify_resume() since
it has nothing to do with tracing.

Patch 3 is a fix/cleanup to stop overriding x86's unistd_{32,64}.h when
the include path (intentionally) omits tools' uapi headers.  KVM's
selftests do exactly that so that they can pick up the uapi headers from
the installed kernel headers, and still use various tools/ headers that
mirror kernel code, e.g. linux/types.h.  This allows the new test in
patch 4 to reference __NR_rseq without having to manually define it.

Patch 4 is a regression test for the KVM+rseq bug.

Patch 5 is a cleanup made possible by patch 3.

v2:
  - Don't touch rseq_cs when handling KVM case so that rseq_syscall() will
    still detect a naughty userspace. [Mathieu]
  - Use a sequence counter + retry in the test to ensure the process isn't
    migrated between sched_getcpu() and reading rseq.cpu_id, i.e. to
    avoid a flaky test. [Mathieu]
  - Add Mathieu's ack for patch 2.
  - Add more comments in the test.

v1: https://lkml.kernel.org/r/20210818001210.4073390-1-seanjc@google.com

Sean Christopherson (5):
  KVM: rseq: Update rseq when processing NOTIFY_RESUME on xfer to KVM
    guest
  entry: rseq: Call rseq_handle_notify_resume() in
    tracehook_notify_resume()
  tools: Move x86 syscall number fallbacks to .../uapi/
  KVM: selftests: Add a test for KVM_RUN+rseq to detect task migration
    bugs
  KVM: selftests: Remove __NR_userfaultfd syscall fallback

 arch/arm/kernel/signal.c                      |   1 -
 arch/arm64/kernel/signal.c                    |   1 -
 arch/csky/kernel/signal.c                     |   4 +-
 arch/mips/kernel/signal.c                     |   4 +-
 arch/powerpc/kernel/signal.c                  |   4 +-
 arch/s390/kernel/signal.c                     |   1 -
 include/linux/tracehook.h                     |   2 +
 kernel/entry/common.c                         |   4 +-
 kernel/rseq.c                                 |  14 +-
 .../x86/include/{ => uapi}/asm/unistd_32.h    |   0
 .../x86/include/{ => uapi}/asm/unistd_64.h    |   3 -
 tools/testing/selftests/kvm/.gitignore        |   1 +
 tools/testing/selftests/kvm/Makefile          |   3 +
 tools/testing/selftests/kvm/rseq_test.c       | 154 ++++++++++++++++++
 14 files changed, 175 insertions(+), 21 deletions(-)
 rename tools/arch/x86/include/{ => uapi}/asm/unistd_32.h (100%)
 rename tools/arch/x86/include/{ => uapi}/asm/unistd_64.h (83%)
 create mode 100644 tools/testing/selftests/kvm/rseq_test.c

-- 
2.33.0.rc2.250.ged5fa647cd-goog

