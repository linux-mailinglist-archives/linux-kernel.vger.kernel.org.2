Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB6FA33BEFF
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Mar 2021 15:53:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241158AbhCOOwq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 10:52:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239354AbhCOOgU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 10:36:20 -0400
Received: from mail-qt1-x84a.google.com (mail-qt1-x84a.google.com [IPv6:2607:f8b0:4864:20::84a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDDB5C0613DA
        for <linux-kernel@vger.kernel.org>; Mon, 15 Mar 2021 07:35:59 -0700 (PDT)
Received: by mail-qt1-x84a.google.com with SMTP id l13so10039104qtu.6
        for <linux-kernel@vger.kernel.org>; Mon, 15 Mar 2021 07:35:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=5gECdo6+gVpy2qvozqlXR6PUtKBMsle+/Zgc7UvkHv0=;
        b=F6uMc+hMpw4VLGPF9NTRDu+LdGxIDc5HjtcM8WRnxh3ScSrimxPFJ8sROFX45P4pg1
         JmKpv4t3OdhMMD1rD42FdVpY0nEJAoRijZeuc6XU4OQvA59ZyQxfyr0qDRKD/308XlSu
         GtE3wxUSyfb25W4uzOCsrOe5Gz8y99R58gB7S8UUDaBldWuJIXLaBmhNPaJ/vKydMMY8
         zwb7ZyKBCvbdIzU6JlCaKl+MWnelk9vD079p4XknDargVMkyKtys5O6uF8B/DFtO5GoX
         flMCr2I5LT93MAOZ2Tk6x0IVz3I51BnGEi+d4LeZo/e2ZL6cBxPmFQHbgFvYR5rSsdkk
         Cmwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=5gECdo6+gVpy2qvozqlXR6PUtKBMsle+/Zgc7UvkHv0=;
        b=gvioiAg40lVtTWoUUpk+ZatjNxcHGHwxeDp1htethI4CCEcArUQMphOyngrao43Z2S
         X0QJO880fugFc/UgCmwyerT10KX+m/jqOxB7pr5TGLp3NCxBaA8sFZVnbiyrNvO6buWc
         APzVR3859V/Q5VjyjwUhXB+85S1SQTSb6/3b4WTJeIoY75sgWyF5gcbmgUi4LOnsTcsp
         9dwA0CxxkyhJyZ5QKmmmT4jlw6Gzc1X7KYv7TTlYKfHYX7sVHUdY9K13VI3pdPtajWr/
         7NPXQlDwx7sBkYun5Ap22J/vsr9IRMaf5DKITU/zG5F8j3PKyBDCttdinvgfMuYshMWR
         krzQ==
X-Gm-Message-State: AOAM532vxQZNyrw7bZO0gmtHkAXw2KvLVSpyHUB6mFEXdP1k2oTMW7v6
        s4nidheHFuC4whZ54LiX7hFan/nXT4UA
X-Google-Smtp-Source: ABdhPJzILFMnnIcNzXWLGq9AyilWMOsS/EW0A6wAdtIdRIIp52i92tMZijgx57Eo/Cv4bAqU/TEpxiSbd/MZ
X-Received: from r2d2-qp.c.googlers.com ([fda3:e722:ac3:10:28:9cb1:c0a8:1652])
 (user=qperret job=sendgmr) by 2002:ad4:5144:: with SMTP id
 g4mr25100542qvq.26.1615818959065; Mon, 15 Mar 2021 07:35:59 -0700 (PDT)
Date:   Mon, 15 Mar 2021 14:35:09 +0000
In-Reply-To: <20210315143536.214621-1-qperret@google.com>
Message-Id: <20210315143536.214621-10-qperret@google.com>
Mime-Version: 1.0
References: <20210315143536.214621-1-qperret@google.com>
X-Mailer: git-send-email 2.31.0.rc2.261.g7f71774620-goog
Subject: [PATCH v5 09/36] KVM: arm64: Allow using kvm_nvhe_sym() in hyp code
From:   Quentin Perret <qperret@google.com>
To:     catalin.marinas@arm.com, will@kernel.org, maz@kernel.org,
        james.morse@arm.com, julien.thierry.kdev@gmail.com,
        suzuki.poulose@arm.com
Cc:     android-kvm@google.com, seanjc@google.com, mate.toth-pal@arm.com,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        linux-arm-kernel@lists.infradead.org, kernel-team@android.com,
        kvmarm@lists.cs.columbia.edu, tabba@google.com, ardb@kernel.org,
        mark.rutland@arm.com, dbrazdil@google.com, qperret@google.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to allow the usage of code shared by the host and the hyp in
static inline library functions, allow the usage of kvm_nvhe_sym() at
EL2 by defaulting to the raw symbol name.

Acked-by: Will Deacon <will@kernel.org>
Signed-off-by: Quentin Perret <qperret@google.com>
---
 arch/arm64/include/asm/hyp_image.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/include/asm/hyp_image.h b/arch/arm64/include/asm/hyp_image.h
index 78cd77990c9c..b4b3076a76fb 100644
--- a/arch/arm64/include/asm/hyp_image.h
+++ b/arch/arm64/include/asm/hyp_image.h
@@ -10,11 +10,15 @@
 #define __HYP_CONCAT(a, b)	a ## b
 #define HYP_CONCAT(a, b)	__HYP_CONCAT(a, b)
 
+#ifndef __KVM_NVHE_HYPERVISOR__
 /*
  * KVM nVHE code has its own symbol namespace prefixed with __kvm_nvhe_,
  * to separate it from the kernel proper.
  */
 #define kvm_nvhe_sym(sym)	__kvm_nvhe_##sym
+#else
+#define kvm_nvhe_sym(sym)	sym
+#endif
 
 #ifdef LINKER_SCRIPT
 
-- 
2.31.0.rc2.261.g7f71774620-goog

