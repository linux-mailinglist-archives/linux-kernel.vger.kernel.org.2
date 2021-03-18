Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E765B341076
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 23:44:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232649AbhCRWnx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 18:43:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230480AbhCRWnP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 18:43:15 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1BA4C06175F
        for <linux-kernel@vger.kernel.org>; Thu, 18 Mar 2021 15:43:15 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id u1so50337820ybu.14
        for <linux-kernel@vger.kernel.org>; Thu, 18 Mar 2021 15:43:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=reply-to:date:message-id:mime-version:subject:from:to:cc;
        bh=0DUdG6+uWcR80QCYp/6dg/L+XaUC6ThjbkuOe9VdQD4=;
        b=rAO86R5j7uv4k/gpsuCAsovgD5YfUhw4FLglkgm4h7+p85RHSq/nnDXbxvuRXggadC
         BhBBZEmGhaHL+67IutzvTP6EtzLXXsZaeuFsUkCZgli5NUv2jLmkH6lg4E21PpyvysaG
         KGbwfNrO+0clC0HPUZmed5uQrPxzZGVKNu2eqXfvvg1dpPzVLJ+bEjMNQPvYIGewY9+Z
         Pp/YP0CXLj+BhhIn6sZvC8lKusbU8LrJ72HIc4mqBg0pYNNnn4fsWgaFpTN7X5Wf0nnV
         Kg9O2wQ+6Al9VfEBv0JaCix/A/zW2G5aNUpVNJpdhBebPLbM8sB0nw1CYKVjCXYJPbsz
         SBWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:date:message-id:mime-version:subject
         :from:to:cc;
        bh=0DUdG6+uWcR80QCYp/6dg/L+XaUC6ThjbkuOe9VdQD4=;
        b=A/NV9Zlh5dktRc0aBtfGv3kwpwa5RJecyWRNNnojzHqQmd5ksgysrvYd4nHT9sWnWd
         Nrk5QiDP6MTYiMgIJHAo67+SbRlKyzzp4oja5BhCc29EGd2933+EtMklu4UDBctaNcc9
         8EKNUoL0pQd071pGAnNUtyb3eLQaT5l50KRuJ74JAVnMfBhh9FT6S9hAcAjkxKPQEfZ1
         qEi3V59b3ju/cBMjMiY5BaB/qVlu6+Sy8TvBrrkR+gpLUZpatPwGE5LSKcX+cqDR/9/f
         +rwtO/6QKk+JVEUsD8fcGQkCMwTC9sEL39zEY/0ldqdD+j5ZgIWjT2MAVisDem+R7+DT
         AG6g==
X-Gm-Message-State: AOAM533qJF3/W/U2RMsfMfSFJcV7VGEQN/n6xNu9kg+oX7vr0uUJhWb8
        sRd+LlVycjHC+wqXAFQL84VSClMcbJE=
X-Google-Smtp-Source: ABdhPJyvkQoAFfVRCK5CJFRkWxaQyuTnUU/i5AYciu9HvCGCvlfImdoL2rAEO67g0ZMcWGsMZnS7Sssob3M=
X-Received: from seanjc798194.pdx.corp.google.com ([2620:15c:f:10:25e0:6b8b:f878:23d1])
 (user=seanjc job=sendgmr) by 2002:a25:bb41:: with SMTP id b1mr2306208ybk.249.1616107393323;
 Thu, 18 Mar 2021 15:43:13 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Thu, 18 Mar 2021 15:43:06 -0700
Message-Id: <20210318224310.3274160-1-seanjc@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.31.0.rc2.261.g7f71774620-goog
Subject: [PATCH v2 0/4] KVM: x86: MSR filtering and related fixes
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Alexander Graf <graf@amazon.com>,
        Yuan Yao <yaoyuan0329os@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rework the MSR filtering implementation to treat a given filter instance
as an atomic unit, and to properly protect it with SRCU.

Fix two nVMX bugs related to MSR filtering (one directly, one indirectly),
and additional cleanup on top.

Regarding the macro insanity in patch 03, I verified the before and after
binary output for vmx_set_intercept_for_msr() was identical, again.  This
required wrapping "if (msr <= 0x1fff)" with (un)likely in both the before
and after versions; gcc made seemingly random choices without forcing it
to favor a specific branch.

v2:
  - Collect R-b. [Paolo, Alex].
  - Make the macro insanity slightly less insane. [Paolo]

v1: https://lkml.kernel.org/r/20210316184436.2544875-1-seanjc@google.com

Sean Christopherson (4):
  KVM: x86: Protect userspace MSR filter with SRCU, and set
    atomically-ish
  KVM: nVMX: Handle dynamic MSR intercept toggling
  KVM: VMX: Macrofy the MSR bitmap getters and setters
  KVM: nVMX: Clean up x2APIC MSR handling for L2

 Documentation/virt/kvm/api.rst  |   6 +-
 arch/x86/include/asm/kvm_host.h |  17 ++--
 arch/x86/kvm/vmx/nested.c       | 161 +++++++++++++-------------------
 arch/x86/kvm/vmx/vmx.c          |  67 +------------
 arch/x86/kvm/vmx/vmx.h          |  28 ++++++
 arch/x86/kvm/x86.c              | 109 ++++++++++++---------
 6 files changed, 172 insertions(+), 216 deletions(-)

-- 
2.31.0.rc2.261.g7f71774620-goog

