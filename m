Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDB3437330F
	for <lists+linux-kernel@lfdr.de>; Wed,  5 May 2021 02:27:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231367AbhEEA2m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 May 2021 20:28:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231134AbhEEA2l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 May 2021 20:28:41 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC4D3C061574
        for <linux-kernel@vger.kernel.org>; Tue,  4 May 2021 17:27:45 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id d89-20020a25a3620000b02904dc8d0450c6so485880ybi.2
        for <linux-kernel@vger.kernel.org>; Tue, 04 May 2021 17:27:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=reply-to:date:message-id:mime-version:subject:from:to:cc;
        bh=VKgVRByPslcwTvLjOdYrGp82XaC2KrJ5pPY9xex0Ink=;
        b=RZJ5s5vgHmlGIa5GRi9aBd1ACKmDRhWI1rFQ8DWxOR+x8CwUwwgOGzgTAd8Af0z/TD
         QVA/g9wiHqDQ+UkkRiUMGXVzYQbv/cDCfaErKFOga/u+10X9DVW7yG3Pdu22fqrjPflG
         aQKvZF2huCCbeUddmJeikoZAHwS4qi+VgqYZ+vhdBd2EeDbNfd/WPZd1Q6uIEXXneA0B
         l8iO9Z9mweUvuGwF1kdknf07tKK7AvO+7p4gCcfcD9KqNYCKUGDvQjiEi0y3Bzhey4my
         CnbFozb3ZOqAb7ZPND7BRSObRAFTfK8LgUJ5PQxMTmk+5BkrqPVN7iaF52NIDUsBdzJz
         U3hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:date:message-id:mime-version:subject
         :from:to:cc;
        bh=VKgVRByPslcwTvLjOdYrGp82XaC2KrJ5pPY9xex0Ink=;
        b=hxl1nMpVIzULuB7vXdcW0q5ZtlDlJqADxbaKUO+RrKiqqABDLT6EJwDeyl7twmmnaJ
         Yiumr/DD/h7cOW0Th6qAl7XvIBgbPMQp3xvXWuTbzQkkDuICBE0pr0k6m7SLzkmKjfvM
         ZIRvAqIgjlMftg2yZrzjRmErV4rYmLJ+OwTF52qD9O/J3d9ekxYmT6REysF1pWUl3XCW
         0etrvkUnMcPr+Cgnsvc8UiZyqpaJwVZ2EAqSQlU+H3HcryoDc9tKoXMSh+SGfu+ih3Lq
         3q55tbYyFwmH5Cv6UpTv8CWNRmDvZv6mb6Ub8AUC7Gl1Fa3m7q0nTb9Fyl6DTDF+XzwI
         cwKw==
X-Gm-Message-State: AOAM533IIf48iurxytbMWxVhzcwG1+h5ZvDTkNwZUOL4PNffrnMXjMGT
        Pjbsbmmr4ebRCgYDnXZwtSJFM20wvc8=
X-Google-Smtp-Source: ABdhPJwV3cL8E3VbRB9iH5Ir/bfVm4wFsBBev6rxSscrx4ENE8zNzsNhqOGUZkwj5qcHec+NcEyrbDLhZrk=
X-Received: from seanjc798194.pdx.corp.google.com ([2620:15c:f:10:df57:48cb:ea33:a156])
 (user=seanjc job=sendgmr) by 2002:a25:880c:: with SMTP id c12mr38649622ybl.399.1620174465152;
 Tue, 04 May 2021 17:27:45 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Tue,  4 May 2021 17:27:27 -0700
Message-Id: <20210505002735.1684165-1-seanjc@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.31.1.527.g47e6f16901-goog
Subject: [PATCH v4 0/8] KVM: Fix tick-based accounting for x86 guests
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Michael Tokarev <mjt@tls.msk.ru>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Frederic Weisbecker <frederic@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix tick-based accounting for x86 guests, and do additional cleanups to
further disentangle guest time accounting and to deduplicate code.

v4:
  - Add R-b's (dropped one due to code change). [Christian]
  - Drop instrumentation annotation shuffling since s390 may be gaining
    support. [Christian].
  - Drop "irqs_off" from context_tracking_guest_exit(). [Frederic]
  - Account guest time after enabling IRQs, even when using context
    tracking to precisely account time. [Frederic]

v3 (delta from Wanpeng's v2):
  - https://lkml.kernel.org/r/20210415222106.1643837-1-seanjc@google.com
  - s/context_guest/context_tracking_guest, purely to match the existing
    functions.  I have no strong opinion either way.
  - Split only the "exit" functions.
  - Partially open code vcpu_account_guest_exit() and
    __vtime_account_guest_exit() in x86 to avoid churn when segueing into
    my cleanups (see above).

older:
  - https://lkml.kernel.org/r/1618298169-3831-1-git-send-email-wanpengli@tencent.com
  - https://lkml.kernel.org/r/20210413182933.1046389-1-seanjc@google.com


Sean Christopherson (5):
  sched/vtime: Move vtime accounting external declarations above inlines
  sched/vtime: Move guest enter/exit vtime accounting to vtime.h
  context_tracking: Consolidate guest enter/exit wrappers
  context_tracking: KVM: Move guest enter/exit wrappers to KVM's domain
  KVM: x86: Consolidate guest enter/exit logic to common helpers

Wanpeng Li (3):
  context_tracking: Move guest exit context tracking to separate helpers
  context_tracking: Move guest exit vtime accounting to separate helpers
  KVM: x86: Defer vtime accounting 'til after IRQ handling

 arch/x86/kvm/svm/svm.c           |  39 +--------
 arch/x86/kvm/vmx/vmx.c           |  39 +--------
 arch/x86/kvm/x86.c               |   9 ++
 arch/x86/kvm/x86.h               |  45 ++++++++++
 include/linux/context_tracking.h |  92 ++++-----------------
 include/linux/kvm_host.h         |  45 ++++++++++
 include/linux/vtime.h            | 138 +++++++++++++++++++------------
 7 files changed, 205 insertions(+), 202 deletions(-)

-- 
2.31.1.527.g47e6f16901-goog

