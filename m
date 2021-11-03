Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CC374449FC
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Nov 2021 21:59:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231663AbhKCVCC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Nov 2021 17:02:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230172AbhKCVCB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Nov 2021 17:02:01 -0400
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD650C061714
        for <linux-kernel@vger.kernel.org>; Wed,  3 Nov 2021 13:59:24 -0700 (PDT)
Received: by mail-pf1-x449.google.com with SMTP id k63-20020a628442000000b004812ea67c34so2054517pfd.2
        for <linux-kernel@vger.kernel.org>; Wed, 03 Nov 2021 13:59:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=BMHD8eN/O84RgpdWn1MOyBM5EFOHI83uTO00cZyWAQg=;
        b=bitU5eJ0Kmr+2sMFWR6KiGanApf+TfANTZ4UIqGCuZAu4cCIiFg11yEBfRTnxj1p9f
         qTJOohwMSHAqmldQfCNXUqcpsGOKlt9Ng/ZlKXmZ7iacrqxVrgEx6UcuNY1WCdea3U4Z
         yJNW7y4KeI8bhJBpDhCPwTfamRrs3FQdyULOP9bcG+ffz2ZMFEBSwQjb8t1rThTu5xU1
         7tTgBIw2pWaZ8Od+4mQtRbcMJqqosp8eNt2WLXCh3yDKYGNtiqnA0YrR3KFAWHCVSLO8
         yjr/DGC8uFS5IP22MFYLeaKRVgJs1bSG1WKijR4rG/VELDVOcEy79QE67RDlEAmdpxw2
         VBvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=BMHD8eN/O84RgpdWn1MOyBM5EFOHI83uTO00cZyWAQg=;
        b=cAsml2Uy/sj+2Vvrt+GfBgW8K3bCV1hodD2xpPL6zlage2YdQjzc7xMG12TCSGYyL5
         Z4mf4kitBdSfKIbkpuCuVVzy8L8LvV6NOL2o7nVqySb1PnJY8WBcrdpq+/F9RX89qXY4
         2X6gUmktPNm2Bnt5BAmQ9AWPfcIvN3CHYAJNy8OgRukkrzVkYeQn1VIWliR2tlZAsqsT
         V/FmLAx5wQuY8g9/OnFWj66MejJXrPDexKAoUWJ7m6F1vHgazaOfvCWU0SgB78xkgo+S
         6AtBvHpysNmqchMtn+8+tzjqG+b/09WpCo9n3BCP4k6zBKfCQ0Uxh+gfVwDAlZ9FRNZx
         zTqA==
X-Gm-Message-State: AOAM531u5PPEH7j5LGlqltWnF9NDaeR3Kr1G+Oe6DCQQ63FKtFugcl+N
        tXMxN+34OK7AMKNd1/7mBwfXWtV4bwrA
X-Google-Smtp-Source: ABdhPJycohYurV0YgV4j0h4Pa3cBGqvA0DposxHWAUB3TD0QVjBIO//mFQ1hqfqBPAJA+AQe+SHpkIKVD89O
X-Received: from vipinsh.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:36b0])
 (user=vipinsh job=sendgmr) by 2002:a05:6a00:26cd:b0:493:ff3f:8083 with SMTP
 id p13-20020a056a0026cd00b00493ff3f8083mr1378391pfw.19.1635973164192; Wed, 03
 Nov 2021 13:59:24 -0700 (PDT)
Date:   Wed,  3 Nov 2021 20:59:09 +0000
Message-Id: <20211103205911.1253463-1-vipinsh@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.33.1.1089.g2158813163f-goog
Subject: [PATCH v3 0/2] Add wrapper to read GPR of INVPCID, INVVPID, and INVEPT
From:   Vipin Sharma <vipinsh@google.com>
To:     pbonzini@redhat.com, seanjc@google.com, jmattson@google.com
Cc:     dmatlack@google.com, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Vipin Sharma <vipinsh@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

v3 is similar to v2 except that the commit message of "PATCH v3 2/2" is now
clearer and detailed.

VMX code to handle INVPCID, INVVPID, and INVEPT read the same GPR index
in VM exit info. This patch series improves that handling by adding a
common wrapper function for them.

Patch 2 makes a sublte change in INVPCID type check. Unlike INVVPID and
INVEPT, INVPCID is not explicitly documented to check the type before
reading the operand from memory. So, this patch moves INVPCID type check
to the common switch statement instead of VMX and SVM validating it
individually.

Changes in v3:
- Patch 2's commit message is more detailed now.

Changes in v2:
- Keeping the register read visible in the functions.
- Removed INVPCID type check hardcoding and moved error condition to common 
  function.

[v2] https://lore.kernel.org/lkml/20211103183232.1213761-1-vipinsh@google.com/
[v1] https://lore.kernel.org/lkml/20211011194615.2955791-1-vipinsh@google.com/

Vipin Sharma (2):
  KVM: VMX: Add a wrapper to read index of GPR for INVPCID, INVVPID, and
    INVEPT
  KVM: Move INVPCID type check from vmx and svm to the common
    kvm_handle_invpcid()

 arch/x86/kvm/svm/svm.c    |  5 -----
 arch/x86/kvm/vmx/nested.c | 10 ++++++----
 arch/x86/kvm/vmx/vmx.c    |  9 +++------
 arch/x86/kvm/vmx/vmx.h    |  5 +++++
 arch/x86/kvm/x86.c        |  3 ++-
 5 files changed, 16 insertions(+), 16 deletions(-)

-- 
2.33.1.1089.g2158813163f-goog

