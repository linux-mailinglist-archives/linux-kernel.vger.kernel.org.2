Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9291644A41B
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Nov 2021 02:40:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238283AbhKIBnO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Nov 2021 20:43:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237370AbhKIBnK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Nov 2021 20:43:10 -0500
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B521C079266
        for <linux-kernel@vger.kernel.org>; Mon,  8 Nov 2021 17:30:51 -0800 (PST)
Received: by mail-pl1-x649.google.com with SMTP id l3-20020a170902f68300b00142892d0a86so1371534plg.13
        for <linux-kernel@vger.kernel.org>; Mon, 08 Nov 2021 17:30:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=reply-to:date:message-id:mime-version:subject:from:to:cc;
        bh=qt5BufFWkbGduR/rMeWkzOBAWPaRlKIbVuIeH4pJKxg=;
        b=noUyGZqR1gFUOMo1lxXgnpP34XC2r0nSsdZqc2PxF2e4+cuAjlNVHdHHlS9iG/yuZR
         Qz/jcFAYdFyqpKbieL/Ae5bJ+OWpiQ3B1sr2VzFcGY/ztb9EB7s7FQ4ivvOEzUFmWKdc
         053BOd8FPCHmIRCrtECZF483wKpQPJLzGeNKi77kOpvXY9PZIjIdTCtdwTRBGt2cSDIZ
         V77WmxQsYHf7cfPYjo8JM2XPL86E3s3KiuumgePtnOi91etxaxuDJRbQ7ud4/J0xvx84
         E0D14GyJ6+VDC6C5pALGFKJKdLC5Nc1sjP2N1WXW0qFk9tcBz+EyLMJo79CWKCl5T7d/
         y4sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:reply-to:date:message-id:mime-version:subject
         :from:to:cc;
        bh=qt5BufFWkbGduR/rMeWkzOBAWPaRlKIbVuIeH4pJKxg=;
        b=jASDu3s7E13BmiapJEbC2wHBEEA+dGF2WLSMtgjTTPGb1zvBZQ81Tn3KM+TVUEc6Rp
         gr6cOXXjlWRmrSoBVDJcacGnDysDVP9QVwsNEoyHCDoa4aqeOOFhHiD8D2NlYM3BQlKx
         wTNToQKBHu+STulD7NJAQoXs1jcoYjbB3OZas4Y/4lRSgJL1AELQIgrv3Cf/PKUtaMC2
         DoO8CTxRjYIxJthRSe33RscNzdsGF1R83TDGLntTYsHSUu9xvZv+W4JjOGK14jkH81cY
         WfB5hQz1KDgDJBj3lkCyGbrIuSp25vbvxkjbOWSPaeew/+8SXGUdanKSNjil3/XddP6y
         3+OA==
X-Gm-Message-State: AOAM531lhr2c8kBOIKvhbEvGa0t6ZZg3cXajKwwrc30TlMlDAy9W4mFN
        CRdMXsVyAa2aKXvzisfUVgzp/dbRFAg=
X-Google-Smtp-Source: ABdhPJyp7ZqayU2E5gePhJ4RoRfdutOIzcfWtm8uiFUPgE1MTuJaoI1zv96mJPJQge6Qj6u1SywnjaJ0Fhw=
X-Received: from seanjc.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3e5])
 (user=seanjc job=sendgmr) by 2002:a17:902:9303:b029:12c:29c:43f9 with SMTP id
 bc3-20020a1709029303b029012c029c43f9mr3640541plb.5.1636421451073; Mon, 08 Nov
 2021 17:30:51 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Tue,  9 Nov 2021 01:30:43 +0000
Message-Id: <20211109013047.2041518-1-seanjc@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.34.0.rc0.344.g81b53c2807-goog
Subject: [PATCH v4 0/4] KVM: x86: MSR filtering and related fixes
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Alexander Graf <graf@amazon.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix a nVMX MSR interception check bug, fix two intertwined nVMX bugs bugs
related to MSR filtering (one directly, one indirectly), and additional
cleanup on top.  The main SRCU fix from the original series was merged,
but these got left behind (luckily, becaues the main fix was buggy).

Side topic, getting a VM to actually barf on RDMSR(SPEC_CTRL) is comically
difficult: -spec-ctrl,-stibp,-ssbd,-ibrs-all,-ibpb,-amd-stibp,-amd-ssbd.
QEMU and KVM really, really want to expose SPEC_CTRL to the guest :-)

v4:
  - Rebase to 0d7d84498fb4 ("KVM: x86: SGX must obey the ... protocol")
  - Fix inverted passthrough check for SPEC_CTRL. [Vitaly] 
  - Add patch to fix MSR bitmap enabling check in helper.

v3:
  - Rebase to 9f6090b09d66 ("KVM: MMU: make spte .... in make_spte")

v2:
  - https://lkml.kernel.org/r/20210318224310.3274160-1-seanjc@google.com
  - Make the macro insanity slightly less insane. [Paolo]

v1: https://lkml.kernel.org/r/20210316184436.2544875-1-seanjc@google.com

Sean Christopherson (4):
  KVM: nVMX: Query current VMCS when determining if MSR bitmaps are in
    use
  KVM: nVMX: Handle dynamic MSR intercept toggling
  KVM: VMX: Macrofy the MSR bitmap getters and setters
  KVM: nVMX: Clean up x2APIC MSR handling for L2

 arch/x86/kvm/vmx/nested.c | 164 +++++++++++++++-----------------------
 arch/x86/kvm/vmx/vmx.c    |  61 ++------------
 arch/x86/kvm/vmx/vmx.h    |  28 +++++++
 3 files changed, 97 insertions(+), 156 deletions(-)

-- 
2.34.0.rc0.344.g81b53c2807-goog

