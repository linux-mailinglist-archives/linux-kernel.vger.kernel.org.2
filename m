Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D64D633C592
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Mar 2021 19:27:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231663AbhCOS1G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 14:27:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232013AbhCOS0t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 14:26:49 -0400
Received: from mail-qk1-x74a.google.com (mail-qk1-x74a.google.com [IPv6:2607:f8b0:4864:20::74a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4ED98C06175F
        for <linux-kernel@vger.kernel.org>; Mon, 15 Mar 2021 11:26:49 -0700 (PDT)
Received: by mail-qk1-x74a.google.com with SMTP id b78so25079413qkg.13
        for <linux-kernel@vger.kernel.org>; Mon, 15 Mar 2021 11:26:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=Mx5f7S+/5wRWBEBjRnHorBN6dS5pzBj5+cDT45N3twk=;
        b=PlpPMKkm7qu6wCcvrEVc6KzFMMrjwWRJ198xVmPtC9vIbZPfK6/sbqEIkegXWp8Btu
         MuIQ892Ph6/RTX7ffhra72wj5jtXEQuuBFixDZKDxr+zuyxADYTvREp3L5e5OodF94AT
         lJOhmjpkoeqmxNVRhGJ1hDxkMLk6kujS/9hJsmDQGmqUAMICEn1cY3LZCFyQrcnEhFjC
         okjVPg9vp712MltmkyLQGkoMeCtT4u99CMNjOupbhTJNiAs05rhfyB099QZpl71tRl3R
         6frsQawZnyoA3mdDyxlLQWcSkSJ3nEgD5sCr26s7oxJTLMq717hCj0SqxMVzHHJjuoL7
         l7Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=Mx5f7S+/5wRWBEBjRnHorBN6dS5pzBj5+cDT45N3twk=;
        b=OU6UkdbsEHrdnrkQGqKcSmgQnsvWzFBWg1RbDXACxpuY97LOsyPziRVsNeFXcjWa0v
         l7zSmwP5LZDJqvbFR5BalX8bJkK3/tipoWSwCdj+trXUTh6fkfnzWmQk5pIrPkUWxfdT
         X7e9IKdlpWsLo794d3cZGG2Hc8GVH0eQ8GSOAFTrvnDRdOuGPT+7JOeDkPttpRpKIG3e
         7czufhPDzqzhWaDluUnY+kFushm3fGKSXtPRBlh1sVq5etSY+9BijjVrC4Nm0Th4epOO
         lOXHyUJMOGqU88ishOMcw7zak+PsVBB3HgeTJNOomNFeVykyHe/Yd6UK4tn24SIqDVRa
         uuMg==
X-Gm-Message-State: AOAM532y0PBQBRY8F6tnkphW03pEmhn1wsfdPCd50C0ZBGGy9K/Wnm6f
        n+QjTx3stImoBR+//wBwvbVOzD+pE6UTx2d57KAOBnzJ/rFo6FQqTNZIAotIi10mwN3eui1c8iR
        Brnq44HXA1q7l4zPG69ngb5OZY2M8Dx7i0RI8nxz4lt6M9LRcAHWQH1y1i1XgoDQ0gkPgXPLg
X-Google-Smtp-Source: ABdhPJyPnuqH28GMfLvsE6fntxec4xEAKml+R1kWf48drQz3przzmYm9EipdFRGFMISS6+0jw9PngSrS0NY1
X-Received: from bgardon.sea.corp.google.com ([2620:15c:100:202:888a:4e22:67:844a])
 (user=bgardon job=sendgmr) by 2002:ad4:5ec9:: with SMTP id
 jm9mr12014461qvb.56.1615832808291; Mon, 15 Mar 2021 11:26:48 -0700 (PDT)
Date:   Mon, 15 Mar 2021 11:26:39 -0700
Message-Id: <20210315182643.2437374-1-bgardon@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.31.0.rc2.261.g7f71774620-goog
Subject: [PATCH v2 0/4] Fix RCU warnings in TDP MMU
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

Tested by compiling as suggested in the test robot report and confirmed
that the warnings go away with this series applied. Also ran
kvm-unit-tests on an Intel Skylake machine with the TDP MMU enabled and
confirmed that the series introduced no new failures.

Ben Gardon (4):
  KVM: x86/mmu: Fix RCU usage in handle_removed_tdp_mmu_page
  KVM: x86/mmu: Fix RCU usage when atomically zapping SPTEs
  KVM: x86/mmu: Factor out tdp_iter_return_to_root
  KVM: x86/mmu: Store the address space ID in the TDP iterator

 arch/x86/kvm/mmu/mmu_internal.h |  5 +++++
 arch/x86/kvm/mmu/tdp_iter.c     | 30 +++++++++++++++----------
 arch/x86/kvm/mmu/tdp_iter.h     |  4 +++-
 arch/x86/kvm/mmu/tdp_mmu.c      | 40 +++++++++++++--------------------
 4 files changed, 41 insertions(+), 38 deletions(-)

-- 
2.31.0.rc2.261.g7f71774620-goog

