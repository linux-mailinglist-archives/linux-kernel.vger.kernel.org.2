Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5D74432D15
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Oct 2021 07:17:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233465AbhJSFUC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Oct 2021 01:20:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233046AbhJSFTx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Oct 2021 01:19:53 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 854CEC061745
        for <linux-kernel@vger.kernel.org>; Mon, 18 Oct 2021 22:17:41 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id e5-20020a17090a804500b001a116ad95caso1723981pjw.2
        for <linux-kernel@vger.kernel.org>; Mon, 18 Oct 2021 22:17:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HIWifdFtsZCMlF9MJRNHELTpmRN02JIWAlERjU7jQ5Y=;
        b=QUBaOlT+jrgHVggmj+IGPPg2CAKdPsL0o3eFo0K4Ci3h2E9Zp3y6PM46WiDMojLHnq
         6dwA3OTfdEefjACzQ/NTXyiwD//uoFrK2LipPGQ+usaVxtauF+KlowARmUO/ViAsbaFL
         9que41BUW8HqPnzXV9u2bqA9fQTR0+3PeWmEuEC9buQyUlxtY8G4xvv/c6yAsir1Faty
         6QYUVNb8hvgs7IJymNJREw3z6qTnlnVICGCeIkciL3AeVsRs9etgRsEpoLyL9C+BwIgx
         JX6KdkOM8V3st+pikHbO1kA8L/RMctNzv+Fc1KW7rjCTyNl5XvSSE+pE/c7PhXjOnqjb
         zgGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HIWifdFtsZCMlF9MJRNHELTpmRN02JIWAlERjU7jQ5Y=;
        b=phKWk9wd7i/n6rmgLc+Art3g6K09+3v3wSLL/FKdLeaYXZww4SKhFOulE9HOe7a/yT
         G7KFf7JEWF/aQGMm0qmCF++HPKnkP5ub2l+SF+fNQGdG2HB6pJDpemb8apiVSyHwy0B9
         w9tIQwJbx5U0rROSlNSg3bw1mvMm1vCQ9qfH1/lTOtrITh46kOeiPDWN3zCDl9VWmSjX
         hyVCh3RGMJf9DYeupH9tWemNmm+6GMaSzlDvtnNS9FUYlfgpqGqjC3GMWKZylyVGyoj6
         BoPe/CU5uNb8SECumIokMaNVBcj6YtkvLqBRl7pL+9SE0BkWrCQc6o6YemdiYO05NcaH
         O/eg==
X-Gm-Message-State: AOAM530HYbPjVhNHLKXRnFvL/AIHgSrM0Z/kIalTKVwRsjWcAzylHxQ6
        CNa+uHAe168pAMcncdjPnAE=
X-Google-Smtp-Source: ABdhPJxGNFWFnjPgQdF7UPnArASEGql/UE6P6u1vatRDAr4IndOEzVMyFAqt42XmOOJrn49O3201zw==
X-Received: by 2002:a17:90b:350f:: with SMTP id ls15mr4048691pjb.220.1634620661051;
        Mon, 18 Oct 2021 22:17:41 -0700 (PDT)
Received: from octofox.hsd1.ca.comcast.net ([2601:641:401:1d20:4171:83c2:8384:24c5])
        by smtp.gmail.com with ESMTPSA id me12sm1168844pjb.27.2021.10.18.22.17.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Oct 2021 22:17:40 -0700 (PDT)
From:   Max Filippov <jcmvbkbc@gmail.com>
To:     linux-xtensa@linux-xtensa.org
Cc:     Chris Zankel <chris@zankel.net>, linux-kernel@vger.kernel.org,
        Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH 05/10] xtensa: definitions for call0 ABI
Date:   Mon, 18 Oct 2021 22:17:11 -0700
Message-Id: <20211019051716.4173-6-jcmvbkbc@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20211019051716.4173-1-jcmvbkbc@gmail.com>
References: <20211019051716.4173-1-jcmvbkbc@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add assembly macros for calls, call arguments, preserved registers,
function entry and return for windowed and call0 ABIs.

Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
---
 arch/xtensa/include/asm/asmmacro.h  | 65 +++++++++++++++++++++++++++++
 arch/xtensa/include/asm/core.h      | 11 +++++
 arch/xtensa/include/asm/processor.h | 32 +++++++++++---
 3 files changed, 102 insertions(+), 6 deletions(-)

diff --git a/arch/xtensa/include/asm/asmmacro.h b/arch/xtensa/include/asm/asmmacro.h
index bfc89e11f469..809c507d1825 100644
--- a/arch/xtensa/include/asm/asmmacro.h
+++ b/arch/xtensa/include/asm/asmmacro.h
@@ -194,6 +194,12 @@
 #define XTENSA_STACK_ALIGNMENT		16
 
 #if defined(__XTENSA_WINDOWED_ABI__)
+
+/* Assembly instructions for windowed kernel ABI. */
+#define KABI_W
+/* Assembly instructions for call0 kernel ABI (will be ignored). */
+#define KABI_C0 #
+
 #define XTENSA_FRAME_SIZE_RESERVE	16
 #define XTENSA_SPILL_STACK_RESERVE	32
 
@@ -206,8 +212,34 @@
 #define abi_ret(frame_size) retw
 #define abi_ret_default retw
 
+	/* direct call */
+#define abi_call call4
+	/* indirect call */
+#define abi_callx callx4
+	/* outgoing call argument registers */
+#define abi_arg0 a6
+#define abi_arg1 a7
+#define abi_arg2 a8
+#define abi_arg3 a9
+#define abi_arg4 a10
+#define abi_arg5 a11
+	/* return value */
+#define abi_rv a6
+	/* registers preserved across call */
+#define abi_saved0 a2
+#define abi_saved1 a3
+
+	/* none of the above */
+#define abi_tmp0 a4
+#define abi_tmp1 a5
+
 #elif defined(__XTENSA_CALL0_ABI__)
 
+/* Assembly instructions for windowed kernel ABI (will be ignored). */
+#define KABI_W #
+/* Assembly instructions for call0 kernel ABI. */
+#define KABI_C0
+
 #define XTENSA_SPILL_STACK_RESERVE	0
 
 #define abi_entry(frame_size) __abi_entry (frame_size)
@@ -233,10 +265,43 @@
 
 #define abi_ret_default ret
 
+	/* direct call */
+#define abi_call call0
+	/* indirect call */
+#define abi_callx callx0
+	/* outgoing call argument registers */
+#define abi_arg0 a2
+#define abi_arg1 a3
+#define abi_arg2 a4
+#define abi_arg3 a5
+#define abi_arg4 a6
+#define abi_arg5 a7
+	/* return value */
+#define abi_rv a2
+	/* registers preserved across call */
+#define abi_saved0 a12
+#define abi_saved1 a13
+
+	/* none of the above */
+#define abi_tmp0 a8
+#define abi_tmp1 a9
+
 #else
 #error Unsupported Xtensa ABI
 #endif
 
+#if defined(USER_SUPPORT_WINDOWED)
+/* Assembly instructions for windowed user ABI. */
+#define UABI_W
+/* Assembly instructions for call0 user ABI (will be ignored). */
+#define UABI_C0 #
+#else
+/* Assembly instructions for windowed user ABI (will be ignored). */
+#define UABI_W #
+/* Assembly instructions for call0 user ABI. */
+#define UABI_C0
+#endif
+
 #define __XTENSA_HANDLER	.section ".exception.text", "ax"
 
 #endif /* _XTENSA_ASMMACRO_H */
diff --git a/arch/xtensa/include/asm/core.h b/arch/xtensa/include/asm/core.h
index 5590b0f68837..9138077e567d 100644
--- a/arch/xtensa/include/asm/core.h
+++ b/arch/xtensa/include/asm/core.h
@@ -26,4 +26,15 @@
 #define XCHAL_SPANNING_WAY 0
 #endif
 
+#if XCHAL_HAVE_WINDOWED
+#if defined(CONFIG_USER_ABI_DEFAULT) || defined(CONFIG_USER_ABI_CALL0_PROBE)
+/* Whether windowed ABI is supported in userspace. */
+#define USER_SUPPORT_WINDOWED
+#endif
+#if defined(__XTENSA_WINDOWED_ABI__) || defined(USER_SUPPORT_WINDOWED)
+/* Whether windowed ABI is supported either in userspace or in the kernel. */
+#define SUPPORT_WINDOWED
+#endif
+#endif
+
 #endif
diff --git a/arch/xtensa/include/asm/processor.h b/arch/xtensa/include/asm/processor.h
index 7f63aca6a0d3..aeec2916030c 100644
--- a/arch/xtensa/include/asm/processor.h
+++ b/arch/xtensa/include/asm/processor.h
@@ -18,12 +18,6 @@
 #include <asm/types.h>
 #include <asm/regs.h>
 
-/* Assertions. */
-
-#if (XCHAL_HAVE_WINDOWED != 1)
-# error Linux requires the Xtensa Windowed Registers Option.
-#endif
-
 /* Xtensa ABI requires stack alignment to be at least 16 */
 
 #define STACK_ALIGN (XCHAL_DATA_WIDTH > 16 ? XCHAL_DATA_WIDTH : 16)
@@ -105,8 +99,18 @@
 #define WSBITS  (XCHAL_NUM_AREGS / 4)      /* width of WINDOWSTART in bits */
 #define WBBITS  (XCHAL_NUM_AREGS_LOG2 - 2) /* width of WINDOWBASE in bits */
 
+#if defined(__XTENSA_WINDOWED_ABI__)
+#define KERNEL_PS_WOE_MASK PS_WOE_MASK
+#elif defined(__XTENSA_CALL0_ABI__)
+#define KERNEL_PS_WOE_MASK 0
+#else
+#error Unsupported xtensa ABI
+#endif
+
 #ifndef __ASSEMBLY__
 
+#if defined(__XTENSA_WINDOWED_ABI__)
+
 /* Build a valid return address for the specified call winsize.
  * winsize must be 1 (call4), 2 (call8), or 3 (call12)
  */
@@ -117,6 +121,22 @@
  */
 #define MAKE_PC_FROM_RA(ra,sp)    (((ra) & 0x3fffffff) | ((sp) & 0xc0000000))
 
+#elif defined(__XTENSA_CALL0_ABI__)
+
+/* Build a valid return address for the specified call winsize.
+ * winsize must be 1 (call4), 2 (call8), or 3 (call12)
+ */
+#define MAKE_RA_FOR_CALL(ra, ws)   (ra)
+
+/* Convert return address to a valid pc
+ * Note: We assume that the stack pointer is in the same 1GB ranges as the ra
+ */
+#define MAKE_PC_FROM_RA(ra, sp)    (ra)
+
+#else
+#error Unsupported Xtensa ABI
+#endif
+
 /* Spill slot location for the register reg in the spill area under the stack
  * pointer sp. reg must be in the range [0..4).
  */
-- 
2.20.1

