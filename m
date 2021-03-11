Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06EEA33814E
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 00:18:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230437AbhCKXRo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Mar 2021 18:17:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229796AbhCKXRN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Mar 2021 18:17:13 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91E41C061760
        for <linux-kernel@vger.kernel.org>; Thu, 11 Mar 2021 15:17:12 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id 6so27564169ybq.7
        for <linux-kernel@vger.kernel.org>; Thu, 11 Mar 2021 15:17:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=HNXy5B8I23CRhr7XqbpfLCRG6IQimiugcGx8izW4SRc=;
        b=C1iC40sFWHJwYLLCw6Q5a608UgI6mBY5PH/tc7EDbY/29Ajijl2W53p19aO3Bfx7BP
         oRxbFeLQPqMK1wM17mq42Lm3LmpPyTP6lCIQCHYuSUFhVaRJs4GTfu9y7BCm2Z/PdoTM
         HKDd9tMIXK3YHAwoY2rExk+8cF6hsNBTlyQjFgdYbtEODK8mnmdP20lJDtUgBc91ZqCi
         dq0t9t3/9St3hiTRehWqC/BXl5/MYZ9e26CvqCXNJKlbOGxnJW3tyWaBUuChRh7NYlmR
         vN+d8020Cg8rs1WmbtdQRvX/nSUxgFBjIDNKO+7qcI+V1yOb0WQOc6suRg0jFEXVMDqs
         FzLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=HNXy5B8I23CRhr7XqbpfLCRG6IQimiugcGx8izW4SRc=;
        b=uezTfm0PhDY05z+DJcItM1Olce1VNkXcLEIkM5aq6rpVVkiAC5m+ZesdPTZQaA3Y4U
         5tq779ps0CF0aYeXbj5mM6mckSe+5YlAFybd5XO+P3m8ciBYEXMjiqw/8QAfiZ3Ticcs
         hqvmv/1PiIClmbSl9vEIsF0RJW3QUTJU9tNTqyNTZkBesHNqiMivpvMHzcmPgFvG+6Oq
         c5NvqR202sLBAohBD8TlPplTn54ldr0Fnk77pvhMxj4W6ub0FjV6iOFKEvdMdgx+WiqA
         Mm9e57hMx1dsL028FasGp2xcXounuH4PSfDcmUd+RxudJd+P48vRcY1JzM+xQcY88VrR
         nxaA==
X-Gm-Message-State: AOAM531sYWkHP4JmC2duCXjOVu7QHPSrNhJjF5GcReMzlSv3/BMpGJYf
        7ivmEIfAwE1OcxG/KyhLbghlBL2ITde5LB37XVfVPXiG4QHeK7Aq1TmV+VvslPIXlGEMO0Rz2ZP
        L/WUHYKqdHOLPgoSvOG5EUBy/OS+sFR6jYFTVWNx4f74I7ZaGxAKIpnBSNU3QeXAyS4/mvL2u
X-Google-Smtp-Source: ABdhPJzXCTU3VdHNDCu4f104t/8IMurZCFzfKoN+XugH6azxwOfhBTsz3wqqit5ykIbN4wcdRvNUFzZqA1Ay
X-Received: from bgardon.sea.corp.google.com ([2620:15c:100:202:b4d4:7253:76fa:9c42])
 (user=bgardon job=sendgmr) by 2002:a5b:851:: with SMTP id v17mr15559641ybq.55.1615504631596;
 Thu, 11 Mar 2021 15:17:11 -0800 (PST)
Date:   Thu, 11 Mar 2021 15:16:54 -0800
Message-Id: <20210311231658.1243953-1-bgardon@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.31.0.rc2.261.g7f71774620-goog
Subject: [PATCH 0/4] Fix RCU warnings in TDP MMU
From:   Ben Gardon <bgardon@google.com>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Peter Shier <pshier@google.com>,
        Jim Mattson <jmattson@google.com>,
        Ben Gardon <bgardon@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Linux Test Robot found a few RCU warnings in the TDP MMU:
https://www.spinics.net/lists/kernel/msg3845500.html
https://www.spinics.net/lists/kernel/msg3845521.html

Fix these warnings and cleanup a hack in tdp_mmu_iter_cond_resched.

Tested by compiling as suggested in the test robot report and confirmed that
the warnings go away with this series applied. Also ran kvm-unit-tests on an
Intel Skylake machine with the TDP MMU enabled and confirmed that the series
introduced no new failures.

Ben Gardon (4):
  KVM: x86/mmu: Fix RCU usage in handle_removed_tdp_mmu_page
  KVM: x86/mmu: Fix RCU usage for tdp_iter_root_pt
  KVM: x86/mmu: Fix RCU usage when atomically zapping SPTEs
  KVM: x86/mmu: Factor out tdp_iter_return_to_root

 arch/x86/kvm/mmu/tdp_iter.c | 34 +++++++++++++++++++++++++---------
 arch/x86/kvm/mmu/tdp_iter.h |  3 ++-
 arch/x86/kvm/mmu/tdp_mmu.c  | 19 +++++++++++--------
 3 files changed, 38 insertions(+), 18 deletions(-)

-- 
2.31.0.rc2.261.g7f71774620-goog

