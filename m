Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81CE7361554
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Apr 2021 00:21:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236304AbhDOWVm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Apr 2021 18:21:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234969AbhDOWVj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Apr 2021 18:21:39 -0400
Received: from mail-qv1-xf49.google.com (mail-qv1-xf49.google.com [IPv6:2607:f8b0:4864:20::f49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E043BC061756
        for <linux-kernel@vger.kernel.org>; Thu, 15 Apr 2021 15:21:14 -0700 (PDT)
Received: by mail-qv1-xf49.google.com with SMTP id w20-20020a0562140b34b029019c9674180fso2764723qvj.0
        for <linux-kernel@vger.kernel.org>; Thu, 15 Apr 2021 15:21:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=reply-to:date:message-id:mime-version:subject:from:to:cc;
        bh=idyJBHB3aj+yzlWK6cDPev1Rpg8zeSoDNtXngbtjsz4=;
        b=AZh7zKKHUCfrzkZWZ/vE2t7RwQ1yja5O9PUCkcECAY1mEd/FGtO7mtGxl7i/Trs0me
         mNt4tcvic4/HAMsK9m1FuKs88rViIm6MWc4VeQKZMLlsGDDlslg5ZIa0/wMgHOo4/Ozf
         WIDfgqoHY0+CdRlDEz+xAJfUR76aPM4qEbT0LVK/7/Q/UrvBPkQiA0dnTPXUbbxUCTTL
         T+/U28uiY5qkFjV6G3tLJ7P74lu8kTqnMC9Mpb/Gbdxf6ZzR0loNJQIqIL0d6CzkGi8Z
         YkL9Q5Md/3j1vELZNuE+2vV98dK3eVc8yMKVGbAFStESq99YYHoMxLKJxZTn5UKQMcGG
         l6mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:date:message-id:mime-version:subject
         :from:to:cc;
        bh=idyJBHB3aj+yzlWK6cDPev1Rpg8zeSoDNtXngbtjsz4=;
        b=a4Stw2kiDGCg+CW6CperGur5Hc0WMGHTBNhuIRup8MIGrhSKmhUrQ+oZjZtq1GhoRl
         vN5VRe/+tdSVQZ3KFa0krAXdaL2XGAgodHlGRSj3Gh99GZBwhUpMzhys7EVPNE5AEID5
         1FIq4N9eTP5Hz2HEq5Mk5Bz4UKbhDg8dq2kj5iDaqwtOV60pzCm7p9bZBsy+COvaPTmZ
         hJ1FSzs1Y6CaevPcVP6Iq31kT/m2S+FaH8HCfSI1GPOwIgA7KzVv4kvHpA/wvhnwtXKW
         /IF5Qq5jTtSkVSz6YtgF8MZns7CwBBtcFTn1IIVmwx80BJ3JLPJcsS2J5ymJThIfuvh6
         3LHQ==
X-Gm-Message-State: AOAM531VM3apIA52qM9bHKCGU3CuxwPZgpE02u8Thcc1dFvr6Waihrzk
        qU6+rMVcHJCauaXEDN41ITjMAwc/fL0=
X-Google-Smtp-Source: ABdhPJyzq2DFbJV2Asv7A8wZh4pNHIG7vnTBd4k7SUprsKaon5I87ZlHqAwJcVNXzpddgQHCsOALUImGaec=
X-Received: from seanjc798194.pdx.corp.google.com ([2620:15c:f:10:6c93:ada0:6bbf:e7db])
 (user=seanjc job=sendgmr) by 2002:a0c:d605:: with SMTP id c5mr5279271qvj.25.1618525273925;
 Thu, 15 Apr 2021 15:21:13 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Thu, 15 Apr 2021 15:20:57 -0700
Message-Id: <20210415222106.1643837-1-seanjc@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.31.1.368.gbe11c130af-goog
Subject: [PATCH v3 0/9] KVM: Fix tick-based accounting for x86 guests
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Michael Tokarev <mjt@tls.msk.ru>,
        Christian Borntraeger <borntraeger@de.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a continuation of Wanpeng's series[1] to fix tick-based CPU time
accounting on x86, with my cleanups[2] bolted on top.  The core premise of
Wanpeng's patches are preserved, but they are heavily stripped down.
Specifically, only the "guest exit" paths are split, and no code is
consolidated.  The intent is to do as little as possible in the three
patches that need to be backported.  Keeping those changes as small as
possible also meant that my cleanups did not need to unwind much 
refactoring.

On x86, tested CONFIG_VIRT_CPU_ACCOUNTING_GEN =y and =n, and with
CONFIG_DEBUG_ENTRY=y && CONFIG_VALIDATE_STACKS=y.  Compile tested arm64,
MIPS, PPC, and s390, the latter with CONFIG_DEBUG_ENTRY=y for giggles.

One last note: I elected to use vtime_account_guest_exit() in the x86 code
instead of open coding these equivalents:

	if (vtime_accounting_enabled_this_cpu())
		vtime_guest_exit(current);
...
	if (!vtime_accounting_enabled_this_cpu())
		current->flags &= ~PF_VCPU;

With CONFIG_VIRT_CPU_ACCOUNTING_GEN=n, this is a complete non-issue, but
for the =y case it means context_tracking_enabled_this_cpu() is being
checked back-to-back.  The redundant checks bug me, but open coding the
gory details in x86 or providing funky variants in vtime.h felt worse.

Delta from Wanpeng's v2:

  - s/context_guest/context_tracking_guest, purely to match the existing
    functions.  I have no strong opinion either way.
  - Split only the "exit" functions.
  - Partially open code vcpu_account_guest_exit() and
    __vtime_account_guest_exit() in x86 to avoid churn when segueing into
    my cleanups (see above).

[1] https://lkml.kernel.org/r/1618298169-3831-1-git-send-email-wanpengli@tencent.com
[2] https://lkml.kernel.org/r/20210413182933.1046389-1-seanjc@google.com

Sean Christopherson (6):
  sched/vtime: Move vtime accounting external declarations above inlines
  sched/vtime: Move guest enter/exit vtime accounting to vtime.h
  context_tracking: Consolidate guest enter/exit wrappers
  context_tracking: KVM: Move guest enter/exit wrappers to KVM's domain
  KVM: x86: Consolidate guest enter/exit logic to common helpers
  KVM: Move instrumentation-safe annotations for enter/exit to x86 code

Wanpeng Li (3):
  context_tracking: Move guest exit context tracking to separate helpers
  context_tracking: Move guest exit vtime accounting to separate helpers
  KVM: x86: Defer tick-based accounting 'til after IRQ handling

 arch/x86/kvm/svm/svm.c           |  39 +--------
 arch/x86/kvm/vmx/vmx.c           |  39 +--------
 arch/x86/kvm/x86.c               |   8 ++
 arch/x86/kvm/x86.h               |  52 ++++++++++++
 include/linux/context_tracking.h |  92 ++++-----------------
 include/linux/kvm_host.h         |  38 +++++++++
 include/linux/vtime.h            | 138 +++++++++++++++++++------------
 7 files changed, 204 insertions(+), 202 deletions(-)

-- 
2.31.1.368.gbe11c130af-goog

