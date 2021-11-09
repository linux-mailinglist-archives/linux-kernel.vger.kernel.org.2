Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D871644B4F0
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Nov 2021 22:53:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244284AbhKIV4C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Nov 2021 16:56:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241983AbhKIVz7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Nov 2021 16:55:59 -0500
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DD01C061764
        for <linux-kernel@vger.kernel.org>; Tue,  9 Nov 2021 13:53:13 -0800 (PST)
Received: by mail-pg1-x549.google.com with SMTP id w13-20020a63934d000000b002a2935891daso264351pgm.15
        for <linux-kernel@vger.kernel.org>; Tue, 09 Nov 2021 13:53:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=reply-to:date:message-id:mime-version:subject:from:to:cc;
        bh=vm1/z3g+vC5w97J0eeG7Qsh9oIK8ruQ0iTlwWy8IP/o=;
        b=nhL/yS0M61GJlon3p6dXxcIr4UVG+0uj1/At1dwAiHCoqBacwzrP2P0dLop0ZpsrZC
         nFboVlEnVXLv3Rui8x9TdT7WMd+3X4uHT1cdJIif3/drVrPAKH4fPqvRsBpil1GasrFu
         N+AWCyLhVhUdq9BEvEaAjEcpOLpmF9A0ffbkUpWHjzGqup5BBtQtabu0cF5CR8yqDjPa
         GzHfk5jM4NyFJ9QPnTvOpPicpW1OKbdOO5DZ4W+FSPVyBeH5lDPBuwQJFM1raQ7DU96V
         jsw2ToHIjvAWMRiF1x1jnti21gQz0b0oXWOqJH3yasMTxayEucOjiTYaLykxoYo60Yld
         4bow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:reply-to:date:message-id:mime-version:subject
         :from:to:cc;
        bh=vm1/z3g+vC5w97J0eeG7Qsh9oIK8ruQ0iTlwWy8IP/o=;
        b=jwDZKJ195Yv++6tTyfhN2M2yvtZLGswEYvhsa2UbdywjbOxarY5AlIEWnZdgyYYm5G
         BUw1ieus8obs8B5nlXfpXfbSgrMPSC4YLsca5Ie1R0afGudPg4fj2Km+rgiWefE3i0cC
         X8dBuTjcI242J8NZMMdjWbzVboUzq5oHKW8r1yKU2SePVxS6az1DLkCZHlgvCL/hv9Rx
         Ppim42UP1qQIP2N6/cbayCYtnVPdxPggpyJaEAhA04awtkgrQF9NV2WQrU/3nbJS/+tx
         NBUkfHWKFUCpT44NH/CXNtxWGZa6KEoXAiTLu8vPG5DFKQq+ovtefJFNSJUesXq32oes
         WR6A==
X-Gm-Message-State: AOAM533iZNySg+z7WL0L7gsQ2P/Voe/Q9Vd+Wdkvip4esOfZIOT5P1cz
        5c4IbwMrmzyiL01NO85xJUoNmk/SqVw=
X-Google-Smtp-Source: ABdhPJyDUdDMkIA9Rexpi4xCcoy4cvsHlm4kiDyB4KxpLmnrUwx9UalA3ivmLSsUuphJn7dJqv71a2GxVRo=
X-Received: from seanjc.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3e5])
 (user=seanjc job=sendgmr) by 2002:a17:90a:284f:: with SMTP id
 p15mr119733pjf.1.1636494792437; Tue, 09 Nov 2021 13:53:12 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Tue,  9 Nov 2021 21:50:55 +0000
Message-Id: <20211109215101.2211373-1-seanjc@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.34.0.rc0.344.g81b53c2807-goog
Subject: [PATCH 0/6] KVM: SEV: Bug fix, cleanups and enhancements
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Peter Gonda <pgonda@google.com>,
        Marc Orr <marcorr@google.com>,
        Nathan Tempelman <natet@google.com>,
        Brijesh Singh <brijesh.singh@amd.com>,
        Tom Lendacky <thomas.lendacky@amd.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Bug fix for COPY_ENC_CONTEXT_FROM that IIRC is very belated feedback (git
says its been sitting in my local repo since at least early September).

The other patches are tangentially related cleanups and enhancements for
the SEV and SEV-ES info, e.g. active flag, ASID, etc...

Booted an SEV guest, otherwise it's effectively all compile-tested only.

Sean Christopherson (6):
  KVM: SEV: Disallow COPY_ENC_CONTEXT_FROM if target has created vCPUs
  KVM: SEV: Explicitly document that there are no TOCTOU races in copy
    ASID
  KVM: SEV: Set sev_info.active after initial checks in sev_guest_init()
  KVM: SEV: WARN if SEV-ES is marked active but SEV is not
  KVM: SEV: Drop a redundant setting of sev->asid during initialization
  KVM: SEV: Fix typo in and tweak name of cmd_allowed_from_miror()

 arch/x86/kvm/svm/sev.c | 42 +++++++++++++++++++++++++++---------------
 arch/x86/kvm/svm/svm.h |  2 +-
 2 files changed, 28 insertions(+), 16 deletions(-)

-- 
2.34.0.rc0.344.g81b53c2807-goog

