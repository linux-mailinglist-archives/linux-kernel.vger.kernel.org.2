Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48AF53F5370
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Aug 2021 00:39:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233232AbhHWWke (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Aug 2021 18:40:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233182AbhHWWkc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Aug 2021 18:40:32 -0400
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8498AC061575
        for <linux-kernel@vger.kernel.org>; Mon, 23 Aug 2021 15:39:49 -0700 (PDT)
Received: by mail-pf1-x449.google.com with SMTP id q15-20020a056a0002af00b003e2840527ceso9264887pfs.11
        for <linux-kernel@vger.kernel.org>; Mon, 23 Aug 2021 15:39:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=ZlrjGTozy+/BVVtSpbg+B9Oe1UkUPbISjCvvFGrqXlg=;
        b=i32J3rbMQ0H5p2G8SzukcQI43bhJ5ntJGGf9D1umNfUcjm8W8qmAUff5q99knxxmhM
         cOrfyLMTACMwCnr6/JTNAYsZOB+Z6zMT+JI7rp4n4CFLa96AaRVdRaM1hSOxh/QEA7vV
         TaB7c92L+cqN71A0+ry5+uV+4wwINpFXM60CyBmcu002rbGSDfSD4ue8iDsutymBWUa4
         lKHK7r+J5l4ypKAL7ngZ8TxdJuow7jMseZYFdQ7R6px8OHRVbrA57nnxDuwLaNLpdGaM
         92/7NEYOVBRIXntdNFYGN+oo4DC1jHue7z544/aAFko6812mFMK7Ot5FwbU1PmbPrkLd
         oYOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=ZlrjGTozy+/BVVtSpbg+B9Oe1UkUPbISjCvvFGrqXlg=;
        b=WqTRtk46IgBQz6m2ez0xWvYoL/Q6jHWj+m/U+QaH4C+FFs/jaRhlYWubvfmFuhAQNj
         6vMp/g3fbctIWIerS9QB4W6rzY9b1E8BhaDad+B/Kvww/UkX2iK0t5PQDW4JsMBViKDZ
         WlFSdG2Z71mrCAmawYsc1EnV3DtG0SkP/JsziFD2M7CXsc8MBp1t/sYJ14XEcMlviJOp
         Moq5Zs467oxw++g/ZGWlhFOkmzMUFzx8dvFtnYlKiSdCSqu53Ymt41MdfofueVCURUJ5
         FX6Y62bf2ouvkqyj60XgIcVkjIpVGcojMG8TsUqJdpiT/1xC9FyvrnVX91tyXT/zUKdp
         HbQw==
X-Gm-Message-State: AOAM5326iDEFYIUl6blyXg+CBShgVZvVEiNKpXJfiINNtswwGBsCSugK
        c5sdo6/TT+jyR3vKzNW+P6b8iPr9AtYr
X-Google-Smtp-Source: ABdhPJxASietCIf57TllHwMPHW6IS8WL5h/EM1B0OToCNPzrClc7aA47+ufW1g4K95UEciNGRGi3rYMtLrzn
X-Received: from rananta-virt.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:1bcc])
 (user=rananta job=sendgmr) by 2002:a17:90a:f10:: with SMTP id
 16mr867207pjy.80.1629758388829; Mon, 23 Aug 2021 15:39:48 -0700 (PDT)
Date:   Mon, 23 Aug 2021 22:39:40 +0000
Message-Id: <20210823223940.1878930-1-rananta@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.33.0.rc2.250.ged5fa647cd-goog
Subject: [PATCH] KVM: arm64: Trim guest debug exception handling
From:   Raghavendra Rao Ananta <rananta@google.com>
To:     Marc Zyngier <maz@kernel.org>, James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Peter Shier <pshier@google.com>,
        Ricardo Koller <ricarkol@google.com>,
        Oliver Upton <oupton@google.com>,
        Reiji Watanabe <reijiw@google.com>,
        Jing Zhang <jingzhangos@google.com>,
        Raghavendra Rao Anata <rananta@google.com>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The switch-case for handling guest debug exception covers
all the debug exception classes, but functionally, doesn't
do anything with them other than ESR_ELx_EC_WATCHPT_LOW.
Moreover, even though handled well, the 'default' case
could be confusing from a security point of view, stating
that the guests' actions can potentially flood the syslog.
But in reality, the code is unreachable.

Hence, trim down the function to only handle the case with
ESR_ELx_EC_WATCHPT_LOW with a simple 'if' check.

Suggested-by: Marc Zyngier <maz@kernel.org>
Signed-off-by: Raghavendra Rao Ananta <rananta@google.com>
---
 arch/arm64/kvm/handle_exit.c | 20 +++-----------------
 1 file changed, 3 insertions(+), 17 deletions(-)

diff --git a/arch/arm64/kvm/handle_exit.c b/arch/arm64/kvm/handle_exit.c
index 04ebab299aa4..275a27368a04 100644
--- a/arch/arm64/kvm/handle_exit.c
+++ b/arch/arm64/kvm/handle_exit.c
@@ -113,34 +113,20 @@ static int kvm_handle_wfx(struct kvm_vcpu *vcpu)
  * guest and host are using the same debug facilities it will be up to
  * userspace to re-inject the correct exception for guest delivery.
  *
- * @return: 0 (while setting vcpu->run->exit_reason), -1 for error
+ * @return: 0 (while setting vcpu->run->exit_reason)
  */
 static int kvm_handle_guest_debug(struct kvm_vcpu *vcpu)
 {
 	struct kvm_run *run = vcpu->run;
 	u32 esr = kvm_vcpu_get_esr(vcpu);
-	int ret = 0;
 
 	run->exit_reason = KVM_EXIT_DEBUG;
 	run->debug.arch.hsr = esr;
 
-	switch (ESR_ELx_EC(esr)) {
-	case ESR_ELx_EC_WATCHPT_LOW:
+	if (ESR_ELx_EC(esr) == ESR_ELx_EC_WATCHPT_LOW)
 		run->debug.arch.far = vcpu->arch.fault.far_el2;
-		fallthrough;
-	case ESR_ELx_EC_SOFTSTP_LOW:
-	case ESR_ELx_EC_BREAKPT_LOW:
-	case ESR_ELx_EC_BKPT32:
-	case ESR_ELx_EC_BRK64:
-		break;
-	default:
-		kvm_err("%s: un-handled case esr: %#08x\n",
-			__func__, (unsigned int) esr);
-		ret = -1;
-		break;
-	}
 
-	return ret;
+	return 0;
 }
 
 static int kvm_handle_unknown_ec(struct kvm_vcpu *vcpu)
-- 
2.33.0.rc2.250.ged5fa647cd-goog

