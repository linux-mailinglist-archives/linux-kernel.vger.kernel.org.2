Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5E0E403E83
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Sep 2021 19:45:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352531AbhIHRrE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Sep 2021 13:47:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352053AbhIHRq4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Sep 2021 13:46:56 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41EA1C0613CF
        for <linux-kernel@vger.kernel.org>; Wed,  8 Sep 2021 10:45:47 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id q68so3390476pga.9
        for <linux-kernel@vger.kernel.org>; Wed, 08 Sep 2021 10:45:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=FnDMp1ofQ25bYz/7RSGb8GTJdDeWHokyAKow2uosXiE=;
        b=KovysMadsgNvWL5q/YHQnGrTzrMspxZfa+uuwZTx2mprioUTi6IwDPm0fFVZ2516Mi
         RUG+W/tL4Cg3/X7HYvtuHhRSDsYZhPZBDbfQ0T6LoPhZJwLboMii2rgE2lDutJfug/Wg
         q/270wwm8pCquUQThvgF7WgHQqvwaUOkjC7DWRpjxh41ruoC0cT8wHRgV5vzVd5P1mn7
         6k5+j0n5HJ5aPmPNG6QOKTHliZIKZQbm5snzjh+kLW2D9DEepUM60FX47xYBpsDZkSn1
         xdAVbjPxJFe+CM/fxOZ6gUfHsa9Vz3WNNwR2gWyAzxajF6E9Np11teUm3W4E4XDJbUO4
         OybQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FnDMp1ofQ25bYz/7RSGb8GTJdDeWHokyAKow2uosXiE=;
        b=8DSsf2SKFREvujyQtVygFl+DL/ltBPqVHfELy3pcXkmCNFsWu0W0RX08yjO2ldi83/
         VzFasf3fEPqtxS4e9/pOuvefJV+bNJfhvOtSm4Xx2bDmcAq5wsYmcHHwyLVkqenPLFBe
         Mk3RErYyW+3gs+hetKkbucOX1Sx7ORXMddh0I9Xc1wp/T31qU38EMWeWaq+2ndIN1MHv
         mDLstBXVSBduxRi1TLC2m1fVWKB1OArthy5HQDA3CwUY+QGdNT31y8dNS/X3UVUjAXRs
         eDwalwrckSEeAnWFBNjCD24g67siQatKY/ByclHRFCRmP0AUeOJEi1amG6YpZ5+LJtez
         ztbA==
X-Gm-Message-State: AOAM531aG+YTEdLdmjt2d8PEXMCqu2/iD82kdSmgxQ6U13AM1A37mCVK
        9gddbkbb3LuZvcdtF1rT2Q7m/A==
X-Google-Smtp-Source: ABdhPJywSFVOWB8Dr1GKJgtf0k10iC73xTmYZfDxYYFTe6OCRO9dwD/WAfK8Ey/r1TxFYLZiiIQpPg==
X-Received: by 2002:a63:1861:: with SMTP id 33mr4849899pgy.406.1631123146858;
        Wed, 08 Sep 2021 10:45:46 -0700 (PDT)
Received: from hsinchu16.internal.sifive.com (59-124-168-89.hinet-ip.hinet.net. [59.124.168.89])
        by smtp.gmail.com with ESMTPSA id b5sm3108466pfr.26.2021.09.08.10.45.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Sep 2021 10:45:46 -0700 (PDT)
From:   Greentime Hu <greentime.hu@sifive.com>
To:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        aou@eecs.berkeley.edu, palmer@dabbelt.com,
        paul.walmsley@sifive.com, vincent.chen@sifive.com
Subject: [RFC PATCH v8 07/21] riscv: Reset vector register
Date:   Thu,  9 Sep 2021 01:45:19 +0800
Message-Id: <6419a6326a5569987c4b3c5afb4b775887b2ca12.1631121222.git.greentime.hu@sifive.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1631121222.git.greentime.hu@sifive.com>
References: <cover.1631121222.git.greentime.hu@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Guo Ren <guoren@linux.alibaba.com>

Reset vector registers at boot-time and disable vector instructions
execution for kernel mode.

[greentime.hu@sifive.com: add comments]
Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
Co-developed-by: Vincent Chen <vincent.chen@sifive.com>
Signed-off-by: Vincent Chen <vincent.chen@sifive.com>
Co-developed-by: Greentime Hu <greentime.hu@sifive.com>
Signed-off-by: Greentime Hu <greentime.hu@sifive.com>
---
 arch/riscv/kernel/entry.S |  6 ++---
 arch/riscv/kernel/head.S  | 49 +++++++++++++++++++++++++++++++++++++--
 2 files changed, 50 insertions(+), 5 deletions(-)

diff --git a/arch/riscv/kernel/entry.S b/arch/riscv/kernel/entry.S
index 98f502654edd..ad0fa80ada81 100644
--- a/arch/riscv/kernel/entry.S
+++ b/arch/riscv/kernel/entry.S
@@ -77,10 +77,10 @@ _save_context:
 	 * Disable user-mode memory access as it should only be set in the
 	 * actual user copy routines.
 	 *
-	 * Disable the FPU to detect illegal usage of floating point in kernel
-	 * space.
+	 * Disable the FPU/Vector to detect illegal usage of floating point
+	 * or vector in kernel space.
 	 */
-	li t0, SR_SUM | SR_FS
+	li t0, SR_SUM | SR_FS | SR_VS
 
 	REG_L s0, TASK_TI_USER_SP(tp)
 	csrrc s1, CSR_STATUS, t0
diff --git a/arch/riscv/kernel/head.S b/arch/riscv/kernel/head.S
index fce5184b22c3..cf331f138142 100644
--- a/arch/riscv/kernel/head.S
+++ b/arch/riscv/kernel/head.S
@@ -241,10 +241,10 @@ pmp_done:
 .option pop
 
 	/*
-	 * Disable FPU to detect illegal usage of
+	 * Disable FPU & VECTOR to detect illegal usage of
 	 * floating point in kernel space
 	 */
-	li t0, SR_FS
+	li t0, SR_FS | SR_VS
 	csrc CSR_STATUS, t0
 
 #ifdef CONFIG_SMP
@@ -432,6 +432,51 @@ ENTRY(reset_regs)
 	csrw	fcsr, 0
 	/* note that the caller must clear SR_FS */
 #endif /* CONFIG_FPU */
+
+#ifdef CONFIG_VECTOR
+	csrr	t0, CSR_MISA
+	li	t1, (COMPAT_HWCAP_ISA_V >> 16)
+	slli	t1, t1, 16
+	and	t0, t0, t1
+	beqz	t0, .Lreset_regs_done
+
+	li	t1, SR_VS
+	csrs	CSR_STATUS, t1
+	vmv.v.i v0, 0
+	vmv.v.i v1, 0
+	vmv.v.i v2, 0
+	vmv.v.i v3, 0
+	vmv.v.i v4, 0
+	vmv.v.i v5, 0
+	vmv.v.i v6, 0
+	vmv.v.i v7, 0
+	vmv.v.i v8, 0
+	vmv.v.i v9, 0
+	vmv.v.i v10, 0
+	vmv.v.i v11, 0
+	vmv.v.i v12, 0
+	vmv.v.i v13, 0
+	vmv.v.i v14, 0
+	vmv.v.i v15, 0
+	vmv.v.i v16, 0
+	vmv.v.i v17, 0
+	vmv.v.i v18, 0
+	vmv.v.i v19, 0
+	vmv.v.i v20, 0
+	vmv.v.i v21, 0
+	vmv.v.i v22, 0
+	vmv.v.i v23, 0
+	vmv.v.i v24, 0
+	vmv.v.i v25, 0
+	vmv.v.i v26, 0
+	vmv.v.i v27, 0
+	vmv.v.i v28, 0
+	vmv.v.i v29, 0
+	vmv.v.i v30, 0
+	vmv.v.i v31, 0
+	/* note that the caller must clear SR_VS */
+#endif /* CONFIG_VECTOR */
+
 .Lreset_regs_done:
 	ret
 END(reset_regs)
-- 
2.31.1

