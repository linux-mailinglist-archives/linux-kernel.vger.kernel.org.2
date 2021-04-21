Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 266A9366ECE
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 17:10:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243854AbhDUPKs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 11:10:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243949AbhDUPJO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 11:09:14 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8395C06138A
        for <linux-kernel@vger.kernel.org>; Wed, 21 Apr 2021 08:08:39 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id i190so29104651pfc.12
        for <linux-kernel@vger.kernel.org>; Wed, 21 Apr 2021 08:08:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sslab.ics.keio.ac.jp; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6tJWCygQYXpyjmta5WwDxPI/i/SiGWVTOjHzOmEYKlE=;
        b=C1PVVj6GicJZ2pct0tdsal9RHi3mTrSgwF8Perq6B7IXO9c6YWeePyMrncWjx9dX5c
         4wbHBbiVh9evi6zxlz+viHBjFYkU/JgnXxXMGXTCKx2V8pb3vawpkwRCVALFs8jiBRDJ
         rSffYnzLVqokcFKXrrza+WO2+Q15zJ+Ylckh4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6tJWCygQYXpyjmta5WwDxPI/i/SiGWVTOjHzOmEYKlE=;
        b=Z5Yfu2GMHDG4qzg0Im3je8l2KrKLVL0JYUsLvKA1paNPHooBc0C9oolc2ufeB65AVT
         Y6Mjek7BKaKa+4ZaSQSkYDCiuPP30xtYINqZwEZiNp6PlTG4S4QKVDivey2oZ/yru032
         cZR91CzrTbPwgBgHhCpMt7UI0a9JLZY8r5cw3qqlgncUyqWThh7Uc2GaOO2gB0aBnsLi
         oe3bbHaPcH2k4dtEIDQYkHldh0sewVlrIa8/eqyTHOx8lx33XSSWSnmgjLUpAeqw44A8
         FUTgAsZILNKdGup5bN9frjT5jySmJNkEXxz2AmDLgDdAXehl90Yicq2t9JKzZE5hWmHd
         9rUA==
X-Gm-Message-State: AOAM531JYDo7HwuyxwhePdlLIr3VZcUEzytLAUK9y8Q4GjKJatc82H5X
        1HqOA3PMfbRneJACdXYf/HVmYQ==
X-Google-Smtp-Source: ABdhPJz1WE6GD3g5TmO4Eb0xaKhSpVZkOqP/gqcFkJCrrmxOYw5FpUQvy3ylfWfox/xr2V5sf2Zomg==
X-Received: by 2002:a17:90a:a895:: with SMTP id h21mr11920590pjq.13.1619017718934;
        Wed, 21 Apr 2021 08:08:38 -0700 (PDT)
Received: from haraichi.dnlocal (113x36x239x145.ap113.ftth.ucom.ne.jp. [113.36.239.145])
        by smtp.googlemail.com with ESMTPSA id f3sm5432553pjo.3.2021.04.21.08.08.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Apr 2021 08:08:38 -0700 (PDT)
From:   Kenta Ishiguro <kentaishiguro@sslab.ics.keio.ac.jp>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        David Hildenbrand <david@redhat.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, pl@sslab.ics.keio.ac.jp,
        kono@sslab.ics.keio.ac.jp,
        Kenta Ishiguro <kentaishiguro@sslab.ics.keio.ac.jp>
Subject: [RFC PATCH 0/2] Mitigating Excessive Pause-Loop Exiting in VM-Agnostic KVM
Date:   Thu, 22 Apr 2021 00:08:29 +0900
Message-Id: <20210421150831.60133-1-kentaishiguro@sslab.ics.keio.ac.jp>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear KVM developers and maintainers,

In our research work presented last week at the VEE 2021 conference [1], we
found out that a lot of continuous Pause-Loop-Exiting (PLE) events occur
due to three problems we have identified: 1) Linux CFS ignores hints from
KVM; 2) IPI receiver vCPUs in user-mode are not boosted; 3) IPI-receiver
that has halted is always a candidate for boost.  We have intoduced two
mitigations against the problems.

To solve problem (1), patch 1 increases the vruntime of yielded vCPU to
pass the check `if (cfs_rq->next && wakeup_preempt_entity(cfs_rq->next,
left) < 1)` in `struct sched_entity * pick_next_entity()` if the cfs_rq's
skip and next are both vCPUs in the same VM. To keep fairness it does not
prioritize the guest VM which causes PLE, however it improves the
performance by eliminating unnecessary PLE. Also we have confirmed
`yield_to_task_fair` is called only from KVM.

To solve problems (2) and (3), patch 2 monitors IPI communication between
vCPUs and leverages the relationship between vCPUs to select boost
candidates.  The "[PATCH] KVM: Boost vCPU candidiate in user mode which is
delivering interrupt" patch
(https://lore.kernel.org/kvm/CANRm+Cy-78UnrkX8nh5WdHut2WW5NU=UL84FRJnUNjsAPK+Uww@mail.gmail.com/T/)
seems to be effective for (2) while it only uses the IPI receiver
information.

Our approach reduces the total number of PLE events by up to 87.6 % in four
8-vCPU VMs in over-subscribed scenario with the Linux kernel 5.6.0. Please
find the patch below.

We would greatly appreciate your valuable feedback on our approach and
patch.

Thank you very much for your consideration
Kenta Ishiguro

[1] Kenta Ishiguro, Naoki Yasuno, Pierre-Louis Aublin, and Kenji Kono.
    "Mitigating excessive vCPU spinning in VM-agnostic KVM".
    In Proceedings of the 17th ACM SIGPLAN/SIGOPS International Conference
    on Virtual Execution Environments (VEE 2021).
    Association for Computing Machinery, New York,
    NY, USA, 139--152.  https://dl.acm.org/doi/abs/10.1145/3453933.3454020

Kenta Ishiguro (2):
  Prevent CFS from ignoring boost requests from KVM
  Boost vCPUs based on IPI-sender and receiver information

 arch/x86/kvm/lapic.c     | 14 ++++++++++++++
 arch/x86/kvm/vmx/vmx.c   |  2 ++
 include/linux/kvm_host.h |  5 +++++
 kernel/sched/fair.c      | 31 +++++++++++++++++++++++++++++++
 virt/kvm/kvm_main.c      | 26 ++++++++++++++++++++++++--
 5 files changed, 76 insertions(+), 2 deletions(-)

-- 
2.30.2

