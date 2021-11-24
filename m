Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 143B845CF69
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Nov 2021 22:44:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245266AbhKXVro (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Nov 2021 16:47:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245006AbhKXVrm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Nov 2021 16:47:42 -0500
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4441C061574
        for <linux-kernel@vger.kernel.org>; Wed, 24 Nov 2021 13:44:30 -0800 (PST)
Received: by mail-pl1-x64a.google.com with SMTP id s16-20020a170902ea1000b00142728c2ccaso1283544plg.23
        for <linux-kernel@vger.kernel.org>; Wed, 24 Nov 2021 13:44:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=reply-to:date:message-id:mime-version:subject:from:to:cc;
        bh=Ok5W2zC2Qy8edZ8sCypy5xZAEqEbZ3krPlmsI3nnu4A=;
        b=kvsHwmtd0Jycx9oNKaqbcp5xS2Du7sltDiaZYx+mtSjX+dbDuvzlnc+6H61LKeKVTp
         AC/IxF58K2YgM8bvhxTo7fcuXlkOoMBykSsUiPiKCiju3c8vj2Y/PQBFdaA01NNWCyvy
         qwSq5s0t+zhoa577H3BMX5Uywh+2FuXY1f9/ZOozeIczcEMLUU4sUDj3pa93nR9iub5T
         qB2ZswTC5ryTBHWm4QyAYYZQLoSjnilsHy1JR2Nm02gfREgZ+7KUyB9hfx2H3WiOX2Vx
         dwW/oG6+PXzyrk/6CHkx/hAkkUxSN+PE7aAoU1RqnRpHrBCCp1tB3KjkFvqsHlxa2Qu1
         oU5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:reply-to:date:message-id:mime-version:subject
         :from:to:cc;
        bh=Ok5W2zC2Qy8edZ8sCypy5xZAEqEbZ3krPlmsI3nnu4A=;
        b=LIBDXetmQgLXLFj5E77mPLUWtYTefpB8WcOycHM1IigkrTQZzkhWU9xFOJimJmMcY7
         y7hZh0zghvJ9MNCUnyG083aVSl4xfkIXy/5SpFrqMLaq7gQDkMsjF5j+umvxbdS6mGY8
         oGV4E2ToUQBl62Us3GxY9VMzwEnyb5VYaWaRzB6PigsurlwbBJwueB2m3W9dHR6LKwo7
         9JcH+M5jG2tVGFB0trA7bvmsYZX/tDbuJlrjc6RSmAt+vodxoMKpunDiYT4VCb+7Kp83
         8rKXAtY4BIzaRaoKjtKyIl857OvkVa9S5ASJRWaFeYqgYBfIsxDx1xj4dN9kxZvLWKNy
         L/Rw==
X-Gm-Message-State: AOAM531UNBo+HmRBL+oB+5cN9ea+K1XNKdOpsUyfInTAc00t11F0vPEl
        A6yReDTtNEg8B6o7IvTOyYq6hapau5MX
X-Google-Smtp-Source: ABdhPJwZBYK/p1mHoASj8Iy8hBROOKPmnT3FvwXaf9uY2ps+0CJrCzWtSt8VfyAMA+lNUnqcULTyWupq1slV
X-Received: from mizhang-super.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:1071])
 (user=mizhang job=sendgmr) by 2002:a17:90b:3849:: with SMTP id
 nl9mr265300pjb.145.1637790270164; Wed, 24 Nov 2021 13:44:30 -0800 (PST)
Reply-To: Mingwei Zhang <mizhang@google.com>
Date:   Wed, 24 Nov 2021 21:44:19 +0000
Message-Id: <20211124214421.458549-1-mizhang@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.34.0.rc2.393.gf8c9666880-goog
Subject: [PATCH 0/2] optimize spte zapping in zap_gfn_range()
From:   Mingwei Zhang <mizhang@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ben Gardon <bgardon@google.com>,
        David Matlack <dmatlack@google.com>,
        Mingwei Zhang <mizhang@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

TDP MMU SPTE zapping process currently uses two levels of iterations. The
first level iteration happens at the for loop within the zap_gfn_range()
with the purpose of calibrating the accurate range for zapping. The second
level itreration start at tdp_mmu_set_spte{,_atomic}() that tears down the
whole paging structures (leaf and non-leaf SPTEs) within the range. The
former iteration is yield safe, while the second one is not.

In many cases, zapping SPTE process could be optimized since the non-leaf
SPTEs could most likely be retained for the next allocation. On the other
hand, for large scale SPTE zapping scenarios, we may end up zapping too
many SPTEs and use excessive CPU time that causes the RCU stall warning.

The follow selftest reproduces the warning:

        (env: kvm.tdp_mmu=Y)
        ./dirty_log_perf_test -v 64 -b 8G

This patch set revert a previous optimization and create a helper
__zap_gfn_range() to help optimize the zapping process.

In particular, it does the following two things:
 - optimize the zapping by retaining some non-leaf SPTEs.
 - avoid RCU stall warning when zapping too many SPTEs.

Mingwei Zhang (2):
  Revert "KVM: x86/mmu: Don't step down in the TDP iterator when zapping
    all SPTEs"
  KVM: mmu/x86: optimize zapping by retaining non-leaf SPTEs and avoid
    rcu stall

 arch/x86/kvm/mmu/tdp_mmu.c | 66 +++++++++++++++++++++++---------------
 1 file changed, 41 insertions(+), 25 deletions(-)

--
2.34.0.rc2.393.gf8c9666880-goog

