Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3325836899A
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Apr 2021 02:06:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239790AbhDWAHS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Apr 2021 20:07:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235691AbhDWAHQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Apr 2021 20:07:16 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24254C061574
        for <linux-kernel@vger.kernel.org>; Thu, 22 Apr 2021 17:06:41 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id n11-20020a25808b0000b02904d9818b80e8so21941972ybk.14
        for <linux-kernel@vger.kernel.org>; Thu, 22 Apr 2021 17:06:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=reply-to:date:message-id:mime-version:subject:from:to:cc;
        bh=v66Jk+gEpeRgxxkcCt+o/qjQEpMd7xAYrLPcmO2p4cI=;
        b=VTxsg4h0oDCx7YbTDXvRJwivIso/3i16ryOJZvE2aLPAXwnNlMyYEX/xjLO65QNGnq
         UAWmt8fAh4j5/dxuDxyFeEP7NHUD2X1W0xTxJFuJ984FLTRQI2v2r29shPH1N66C2uKS
         b5p0PZPRzxa63ZguF4QbBvsH9mXOk5vpkzcYubnxNVrMUa3a1Anr5nS1yN42Q8rwn62m
         1mjb0FxpoDDLkAL1TZXgJzLI++X8PnErigmkdYmXmD7a2wr/egMfDrsllaG+o9jXsU23
         uy1sHv2Js6+L0X9k6abwbNoDVvOCaybixGMHokDHKp9M1sy0pbVZDW5iSnSZAV7x7vk3
         aB7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:date:message-id:mime-version:subject
         :from:to:cc;
        bh=v66Jk+gEpeRgxxkcCt+o/qjQEpMd7xAYrLPcmO2p4cI=;
        b=njNldWITtgTAxZchTNRpVmxT/IIL2WlQzu9vNna3vWVYwwusl+aTLQQoIjCtDxnioe
         VgKDv51mAi0TjhmScYdPczNZs30PI2WNC8tvpT1jM6pvgLrQv2RVKzSGTY5rkc7NUzW8
         c0kJ/S1FTp0d1jqHjFwpLI30+dYOgQJDEelE2AJ2AH/5jUqvQ2CK8mRrDsIziM/xS9dC
         hYo/8mQ7XbTH6cBtX9C0i/p4MJDJ0sEs1Ds6EkK3DPpL3HWr4NTRUMnNsTyqXx6ijT2R
         a10/a475sv3ZPczmPTQJdMMRBYF0ExuDi/e0CHLwJD5FJv6LDbx0F53sPhyJsybOAfGu
         jxSQ==
X-Gm-Message-State: AOAM530+2co83rcR9GR3enRrIY6rdGQVN6ff6Uoql3DZaqa15llpK92R
        qHRLpY3YwGASQhplY72Ykd/Y1g1jNog=
X-Google-Smtp-Source: ABdhPJzadxessdpAjDDbX76aXuVMs4n1pAxeTI8YzDEJJFSYiKh/f16bzz2wlJzDr6iw5UeDcHZHJI7BPzg=
X-Received: from seanjc798194.pdx.corp.google.com ([2620:15c:f:10:e012:374c:592:6194])
 (user=seanjc job=sendgmr) by 2002:a25:680c:: with SMTP id d12mr122727ybc.87.1619136400249;
 Thu, 22 Apr 2021 17:06:40 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Thu, 22 Apr 2021 17:06:33 -0700
Message-Id: <20210423000637.3692951-1-seanjc@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.31.1.498.g6c1eba8ee3d-goog
Subject: [PATCH 0/4] KVM: x86: Kill off pdptrs_changed()
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

Remove pdptrs_changed(), which is mostly dead anyways, and the few bits
that are still thrashing are useless.

This conflicts with Maxim's work to migrate PDPTRs out-of-band, but I
think it will conflict in a good way as the "skip load_pdptrs()"
logic for the out-of-band case won't have to juggle this legacy crud.

Sean Christopherson (4):
  KVM: nVMX: Drop obsolete (and pointless) pdptrs_changed() check
  KVM: nSVM: Drop pointless pdptrs_changed() check on nested transition
  KVM: x86: Always load PDPTRs on CR3 load for SVM w/o NPT and a PAE
    guest
  KVM: x86: Unexport kvm_read_guest_page_mmu()

 arch/x86/include/asm/kvm_host.h |  4 ----
 arch/x86/kvm/svm/nested.c       |  6 ++---
 arch/x86/kvm/vmx/nested.c       |  8 +++----
 arch/x86/kvm/x86.c              | 41 ++++-----------------------------
 4 files changed, 10 insertions(+), 49 deletions(-)

-- 
2.31.1.498.g6c1eba8ee3d-goog

