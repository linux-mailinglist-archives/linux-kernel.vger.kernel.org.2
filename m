Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A76F3A86C7
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 18:45:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230344AbhFOQrp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 12:47:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229993AbhFOQrn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 12:47:43 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38250C06175F
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jun 2021 09:45:39 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id v28-20020a25fc1c0000b0290547fac9371fso20605439ybd.14
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jun 2021 09:45:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=reply-to:date:message-id:mime-version:subject:from:to:cc;
        bh=6HZGdFlUWM4LdlL5+cotm9rGAhlwZSYKVNXCJc52TBE=;
        b=j9bMtMZ1Zel3jGQWMxvx1581g0LAM3fjKvw5SnIg00Xsbe8bVn93dunrjWw2rMq4Cq
         54LEK/RU6P5miLuqCTjGED3cKTaOFH6cujbzfx5TG8ZdK8oHbwmlDEREd9SMOpC/9U1d
         EGizH6qQAYuM4z0uv5FOWe6aus8noEzFaeqk+3QO+BsiC8Y3lJ6HZxTwTlcvCYA7eEdF
         +LQERTO2dF7s5x2EXYjOH3mKHZEWEWch1/IfYT0WbqRXWSJiIgKct4XSNjdcklUbml7y
         u9ZGazlneZshx1D54e8I5se/YmQtztExmgR7VN/TmGVF/I8mSqpQPROmqkxS+6V/xxoS
         GV8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:date:message-id:mime-version:subject
         :from:to:cc;
        bh=6HZGdFlUWM4LdlL5+cotm9rGAhlwZSYKVNXCJc52TBE=;
        b=sZbzQ9oJFhfirSaNw/b+es1Vnkw9+1v1QiTmCuuxEpElxX1+hz4MXPf4f1h7heObpE
         BF7cS3nf0Dyld3SPcqxXiTSYygyVcL26PxbGcm8GOIKcISyssOX8nxGaVGpFHfnYz3Kh
         rxlHNoA1nJ5dYBtu+Ku/OZFBiSZvwIcYRZfsZc9vudHTPWVewhlIoffXq0eUjziddry6
         9RuiBCveWYMrv4tXYw5by/o8lfvOpXkvTMr0hxDK4/izhx3frfqEQoYpAE2R98jw9Lo1
         XrcToubRRQsVfdzAoa+LU+okyKdXbyYORX5pGudXmySEFtkEA0n1OADh9CP+tsZse8+U
         aGvA==
X-Gm-Message-State: AOAM533vCoPlGeW+OUaaq/AxIrLiVM/oW/Q/IYe0fB0KjJS0eaDMu0Bc
        GCYdRH3IxBdooi/aMtVQFSxjg4ugDbM=
X-Google-Smtp-Source: ABdhPJwijPv+0zQjSxRmkTTlgNWU/8MzeoSZ7RLtDFw5X8sp1a318M/0ZuE7ovu43XIh5DcZM4x+lJGK6bI=
X-Received: from seanjc798194.pdx.corp.google.com ([2620:15c:f:10:13fc:a8bd:9d6b:e5])
 (user=seanjc job=sendgmr) by 2002:a25:ec12:: with SMTP id j18mr45215ybh.267.1623775538389;
 Tue, 15 Jun 2021 09:45:38 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Tue, 15 Jun 2021 09:45:31 -0700
Message-Id: <20210615164535.2146172-1-seanjc@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.32.0.272.g935e593368-goog
Subject: [PATCH 0/4] KVM: x86: Require EFER.NX support unless EPT is on
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

KVM has silently required EFER.NX support for shadow paging for well over
a year, and for NPT for roughly the same amount of time.  Attempting to
run any VM with shadow paging on a system without NX support will fail due
to invalid state, while enabling nx_huge_pages with NPT and no NX will
explode due to setting a reserved bit in the page tables.

I really, really wanted to require NX across the board, because the lack
of bug reports for the shadow paging change strongly suggests no one is
running KVM on a CPU that truly doesn't have NX.  But, Intel CPUs let
firmware disable NX via MISC_ENABLES, so it's plausible that there are
users running KVM with EPT and no NX.

Sean Christopherson (4):
  KVM: VMX: Refuse to load kvm_intel if EPT and NX are disabled
  KVM: SVM: Refuse to load kvm_amd if NX support is not available
  KVM: x86: WARN and reject loading KVM if NX is supported but not
    enabled
  KVM: x86: Simplify logic to handle lack of host NX support

 arch/x86/kvm/cpuid.c   | 13 +++++--------
 arch/x86/kvm/svm/svm.c | 13 ++++++++++---
 arch/x86/kvm/vmx/vmx.c |  6 ++++++
 arch/x86/kvm/x86.c     |  3 +++
 4 files changed, 24 insertions(+), 11 deletions(-)

-- 
2.32.0.272.g935e593368-goog

