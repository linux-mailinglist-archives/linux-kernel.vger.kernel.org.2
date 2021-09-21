Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E21B2412B2F
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Sep 2021 04:08:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245167AbhIUCJv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Sep 2021 22:09:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238061AbhIUB5D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Sep 2021 21:57:03 -0400
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com [IPv6:2607:f8b0:4864:20::849])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F27E2C06B669
        for <linux-kernel@vger.kernel.org>; Mon, 20 Sep 2021 17:03:06 -0700 (PDT)
Received: by mail-qt1-x849.google.com with SMTP id 13-20020ac8560d000000b0029f69548889so198951133qtr.3
        for <linux-kernel@vger.kernel.org>; Mon, 20 Sep 2021 17:03:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=reply-to:date:message-id:mime-version:subject:from:to:cc;
        bh=cTtFFhZS/6D7sjIC0eSf55DYdfH2WRALnDh/1lgXOGA=;
        b=mPqGGYBZfXTozJoaH1j0ZOMMlLdWJDzCpOwa+X82RZz074i6YgQpzxGhrQFIPEFRRI
         YFQaGAOP7zUtK2jVdorV3ra3hxOyVpDHLrruS8b2lVYRJlOGIEikgUd6czhd7G0z+Uv3
         f83X75swRZUSwCc/5GAlKfA/na135JDNxISFfqEzJ5YtaW9rSmc3SPaT87uhB/OOkdLC
         vTOfsWhmen8iYa1ykUqdlqUarrCmb3z5yktQl2dirpvsrUN98SC0uuGS0gj89yK24Eos
         HuJ5yOFPvX/X0v4CyF75c3xnJFay0OiW6aiGAc9vuJUTmklKJ84CJ6bgio0msPA9beAj
         rRww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:reply-to:date:message-id:mime-version:subject
         :from:to:cc;
        bh=cTtFFhZS/6D7sjIC0eSf55DYdfH2WRALnDh/1lgXOGA=;
        b=CY7fLrWj67SQJov6DgeD7Lsl4c41oFDLPbu58Sc9Mdv5KbLdQaMnL+zLvHpbMy65oS
         G8k0ZCSENQxzO0eZgqNdc0jatL8Vd3YXfj5YrIHJ5YwG+fw4/LKJ4t/gC3V4zhAXDl1O
         R2ceKZEFnFp//T32hC+NUWrw2MEB3tbJvB/T3R+lIHOdgXGbtH5E4sF3kJpuUr3YWPn1
         JB0J7mjVHzhPpx+sY5yCzY7xLafNV1NFLNJ7S3bGatLaqnkkZmXlLrj0+M+tnZ1sZpPv
         FWTvuzNW3hXycAbdo10PxR/WS+onnwxuGpi5andTfV7sJ2scH1dgldkqwh3UnJNUqV6g
         NlwA==
X-Gm-Message-State: AOAM532jzvUk6rcG/FikJ6CkawMxMsm7FanR1oLF+E6vb9kD1aEcv9WD
        eYRnShb+ryTm6k3g0TR38Qj+nl2vJ0Q=
X-Google-Smtp-Source: ABdhPJxsmXE/uShIuD0GALsHqgqcgBkSBOtoRXS6l2OVCLHiZ6n7yYUsZnXjmlZ4mGcvDBrJ/LMx86sZ5C0=
X-Received: from seanjc798194.pdx.corp.google.com ([2620:15c:90:200:e430:8766:b902:5ee3])
 (user=seanjc job=sendgmr) by 2002:a05:6214:13cd:: with SMTP id
 cg13mr28202964qvb.51.1632182586086; Mon, 20 Sep 2021 17:03:06 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Mon, 20 Sep 2021 17:02:53 -0700
Message-Id: <20210921000303.400537-1-seanjc@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.33.0.464.g1972c5931b-goog
Subject: [PATCH v2 00/10] KVM: x86: Clean up RESET "emulation"
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Reiji Watanabe <reijiw@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add dedicated helpers to emulate RESET (or at least, the parts of RESET
that KVM actually emulates) instead of having the relevant code scattered
throughout vcpu_create() and vcpu_reset().

Vitaly's innocuous suggestion to WARN on non-zero CR0 led to a wonderful
bit of git archaeology after, to my complete surprise, it fired on RESET
due to fx_init() setting CR0.ET (and XCR0.FP).

v2:
 - Add patches to drop defunct fx_init() code.
 - Add patch to zero CR3 at RESET/INIT. 
 - Add patch to mark all regs avail/dirty at creation, not at RESET/INIT.
 - Add patch to WARN if CRs are non-zero at RESET. [Vitaly]

v1: https://lkml.kernel.org/r/20210914230840.3030620-1-seanjc@google.com

Sean Christopherson (10):
  KVM: x86: Mark all registers as avail/dirty at vCPU creation
  KVM: x86: Clear KVM's cached guest CR3 at RESET/INIT
  KVM: x86: Do not mark all registers as avail/dirty during RESET/INIT
  KVM: x86: Remove defunct setting of CR0.ET for guests during vCPU
    create
  KVM: x86: Remove defunct setting of XCR0 for guest during vCPU create
  KVM: x86: Fold fx_init() into kvm_arch_vcpu_create()
  KVM: VMX: Drop explicit zeroing of MSR guest values at vCPU creation
  KVM: VMX: Move RESET emulation to vmx_vcpu_reset()
  KVM: SVM: Move RESET emulation to svm_vcpu_reset()
  KVM: x86: WARN on non-zero CRs at RESET to detect improper
    initalization

 arch/x86/kvm/svm/sev.c |  6 ++--
 arch/x86/kvm/svm/svm.c | 29 ++++++++++--------
 arch/x86/kvm/svm/svm.h |  2 +-
 arch/x86/kvm/vmx/vmx.c | 68 ++++++++++++++++++++----------------------
 arch/x86/kvm/x86.c     | 44 +++++++++++++--------------
 5 files changed, 76 insertions(+), 73 deletions(-)

-- 
2.33.0.464.g1972c5931b-goog

