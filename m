Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3541932AC16
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 22:09:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1449446AbhCBVIe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Mar 2021 16:08:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352106AbhCBSLM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 13:11:12 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87A23C06178A
        for <linux-kernel@vger.kernel.org>; Tue,  2 Mar 2021 09:45:19 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id u17so23535883ybi.10
        for <linux-kernel@vger.kernel.org>; Tue, 02 Mar 2021 09:45:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:reply-to:date:message-id:mime-version:subject:from:to:cc;
        bh=+FgfbaNP4qKe3T+vQ4msuqXB+2/NXQnJfdms8ShT6I0=;
        b=FVskI8P6Yra7bRyPGNt+PrHSTrU6A4Ip0NS0xkRYRbVXSgE4BIQeMbhAXdWQhj62jh
         wo1Jc1oh4GqQ8EP3jQf/7egvJ/jFKTGVdaiySjDZ8PSG/ikqrr0OFUqDq5hTI9u7jLOv
         Q22Ti/Uq4a9ok3DGKUv1SSQpK10ZHcfPlyeEC12f0XcedcfGwmHKpaUd60N44OHeJ2uu
         ba4pxlS6odCGBu+Lh5fmdoOILO1NkKkF3YA/MFqxj+NUargrZbHtmcdwJNUUBzBr4M/X
         iQR/QMfVn9i1uvf7yw/VrUDnw4TQmqCLPgKgN46vgkmiSu3F258xOL02MzRj11LtOdBS
         O1kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:reply-to:date:message-id:mime-version
         :subject:from:to:cc;
        bh=+FgfbaNP4qKe3T+vQ4msuqXB+2/NXQnJfdms8ShT6I0=;
        b=A2DGGaaNqoBinhMAj+f1Kq0yovJyuUG9QuaMGlRGEuurwD+XAdE9ewWht7dqlz9Tny
         0pxeXJkwjzLFWq+Y1yKKJ44SzORKw0sPD4NojvpqnS1cUDBp8ggVfVa5777QQZYInVFz
         3kMs5yoqFpyNMm5q5p94OcNMgqyN6rBjLYYGtNo4JjuuTOaCD0Isf/FeS0IGoGvsgNba
         vM6CXLSCMdlXmO8OvP6YLuy0N+POEtPHhJLelbxa4tKPIPNSmZ6PKl0gDX4kFWpb4z0M
         qb0CrRK5mU1MjzRfLmhP7yjWuRw0KHMWArvhQbVTXdsIccNiGj5Wiuiiav35aMsRmvbP
         Np1g==
X-Gm-Message-State: AOAM530efWjtPQoO/XSV6j3uwuhu1rgT4UAs2lB8u8ZLyE0TAqIzQSZc
        zHWFWwBdjR2Vc4lXPYg/bPtafalkirg=
X-Google-Smtp-Source: ABdhPJzOzWEdI3l+JnK7sFOIJQO6rTqrm7cqSSfRt/RV55qIVqQRHOCk3cinH1ruUkxiOKub23tpFfcuQ6s=
Sender: "seanjc via sendgmr" <seanjc@seanjc798194.pdx.corp.google.com>
X-Received: from seanjc798194.pdx.corp.google.com ([2620:15c:f:10:805d:6324:3372:6183])
 (user=seanjc job=sendgmr) by 2002:a25:40d8:: with SMTP id n207mr31016590yba.3.1614707118830;
 Tue, 02 Mar 2021 09:45:18 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Tue,  2 Mar 2021 09:45:13 -0800
Message-Id: <20210302174515.2812275-1-seanjc@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.30.1.766.gb4fecdf3b7-goog
Subject: [PATCH 0/2] KVM: x86: Emulate L2 triple fault without killing L1
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If KVM (L0) intercepts #GP, but L1 does not, then L2 can kill L1 by
triggering triple fault.  On both VMX and SVM, if the CPU hits a fault
while vectoring an injected #DF (or I supposed any #DF), any intercept
from the hypervisor takes priority over triple fault.  #PF is unlikely to
be intercepted by L0 but not L1.  The bigger problem is #GP, which is
intercepted on both VMX and SVM if enable_vmware_backdoor=1, and is also
now intercepted for the lovely VMRUN/VMLOAD/VMSAVE errata.

Based on kvm/queue, commit fe5f0041c026 ("KVM/SVM: Move vmenter.S exception
fixups out of line").  x86.c and svm/nested.c conflict with kvm/master.
They are minor and straighforward, but let me know if you want me to post
a version based on kvm/master for easier inclusion into 5.12.

Sean Christopherson (2):
  KVM: x86: Handle triple fault in L2 without killing L1
  KVM: nSVM: Add helper to synthesize nested VM-Exit without collateral

 arch/x86/include/asm/kvm_host.h |  1 +
 arch/x86/kvm/lapic.c            |  2 +-
 arch/x86/kvm/svm/nested.c       | 57 ++++++++-------------------------
 arch/x86/kvm/svm/svm.c          |  6 +---
 arch/x86/kvm/svm/svm.h          |  9 ++++++
 arch/x86/kvm/vmx/nested.c       |  9 ++++++
 arch/x86/kvm/x86.c              | 29 +++++++++++++----
 arch/x86/kvm/x86.h              |  2 ++
 8 files changed, 60 insertions(+), 55 deletions(-)

-- 
2.30.1.766.gb4fecdf3b7-goog

