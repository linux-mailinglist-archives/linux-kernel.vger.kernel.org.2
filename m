Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB69B3458C0
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 08:32:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229943AbhCWHcX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 03:32:23 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:14069 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229622AbhCWHb4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 03:31:56 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4F4NKW5BxVzNqX2;
        Tue, 23 Mar 2021 15:29:19 +0800 (CST)
Received: from huawei.com (10.175.103.91) by DGGEMS413-HUB.china.huawei.com
 (10.3.19.213) with Microsoft SMTP Server id 14.3.498.0; Tue, 23 Mar 2021
 15:31:40 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     <catalin.marinas@arm.com>, <will@kernel.org>,
        <guohanjun@huawei.com>, <yangyingliang@huawei.com>
Subject: [PATCH 1/3] arm64: lib: introduce ldp2/stp2 macro
Date:   Tue, 23 Mar 2021 15:34:30 +0800
Message-ID: <20210323073432.3422227-2-yangyingliang@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210323073432.3422227-1-yangyingliang@huawei.com>
References: <20210323073432.3422227-1-yangyingliang@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.91]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce ldp2/stp2 to load/store without add src/dst.

Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
 arch/arm64/include/asm/asm-uaccess.h | 16 ++++++++++++++++
 arch/arm64/lib/copy_from_user.S      |  8 ++++++++
 arch/arm64/lib/copy_in_user.S        |  8 ++++++++
 arch/arm64/lib/copy_to_user.S        |  8 ++++++++
 arch/arm64/lib/memcpy.S              |  8 ++++++++
 5 files changed, 48 insertions(+)

diff --git a/arch/arm64/include/asm/asm-uaccess.h b/arch/arm64/include/asm/asm-uaccess.h
index ccedf548dac9..129c08621df1 100644
--- a/arch/arm64/include/asm/asm-uaccess.h
+++ b/arch/arm64/include/asm/asm-uaccess.h
@@ -72,6 +72,14 @@ alternative_else_nop_endif
 		_asm_extable	8889b,\l;
 	.endm
 
+	.macro user_ldp2 l, reg1, reg2, addr, post_inc1, post_inc2
+8888:		ldtr	\reg1, [\addr, \post_inc1];
+8889:		ldtr	\reg2, [\addr, \post_inc2];
+
+		_asm_extable	8888b,\l;
+		_asm_extable	8889b,\l;
+	.endm
+
 	.macro user_stp l, reg1, reg2, addr, post_inc
 8888:		sttr	\reg1, [\addr];
 8889:		sttr	\reg2, [\addr, #8];
@@ -81,6 +89,14 @@ alternative_else_nop_endif
 		_asm_extable	8889b,\l;
 	.endm
 
+	.macro user_stp2 l, reg1, reg2, addr, post_inc1, post_inc2
+8888:		sttr	\reg1, [\addr, \post_inc1];
+8889:		sttr	\reg2, [\addr, \post_inc2];
+
+		_asm_extable	8888b,\l;
+		_asm_extable	8889b,\l;
+	.endm
+
 	.macro user_ldst l, inst, reg, addr, post_inc
 8888:		\inst		\reg, [\addr];
 		add		\addr, \addr, \post_inc;
diff --git a/arch/arm64/lib/copy_from_user.S b/arch/arm64/lib/copy_from_user.S
index 95cd62d67371..37308bcb338e 100644
--- a/arch/arm64/lib/copy_from_user.S
+++ b/arch/arm64/lib/copy_from_user.S
@@ -48,10 +48,18 @@
 	user_ldp 9998f, \reg1, \reg2, \ptr, \val
 	.endm
 
+	.macro ldp2 reg1, reg2, ptr, val1, val2
+	user_ldp2 9998f, \reg1, \reg2, \ptr, \val1, \val2
+	.endm
+
 	.macro stp1 reg1, reg2, ptr, val
 	stp \reg1, \reg2, [\ptr], \val
 	.endm
 
+	.macro stp2 reg1, reg2, ptr, val1, val2
+	stp \reg1, \reg2, [\ptr, \val1]
+	.endm
+
 end	.req	x5
 SYM_FUNC_START(__arch_copy_from_user)
 	add	end, x0, x2
diff --git a/arch/arm64/lib/copy_in_user.S b/arch/arm64/lib/copy_in_user.S
index 1f61cd0df062..5654f7098102 100644
--- a/arch/arm64/lib/copy_in_user.S
+++ b/arch/arm64/lib/copy_in_user.S
@@ -49,10 +49,18 @@
 	user_ldp 9998f, \reg1, \reg2, \ptr, \val
 	.endm
 
+	.macro ldp2 reg1, reg2, ptr, val1, val2
+	user_ldp2 9998f, \reg1, \reg2, \ptr, \val1, \val2
+	.endm
+
 	.macro stp1 reg1, reg2, ptr, val
 	user_stp 9998f, \reg1, \reg2, \ptr, \val
 	.endm
 
+	.macro stp2 reg1, reg2, ptr, val1, val2
+	user_stp2 9998f, \reg1, \reg2, \ptr, \val1, \val2
+	.endm
+
 end	.req	x5
 
 SYM_FUNC_START(__arch_copy_in_user)
diff --git a/arch/arm64/lib/copy_to_user.S b/arch/arm64/lib/copy_to_user.S
index 043da90f5dd7..a1f95169ce04 100644
--- a/arch/arm64/lib/copy_to_user.S
+++ b/arch/arm64/lib/copy_to_user.S
@@ -47,10 +47,18 @@
 	ldp \reg1, \reg2, [\ptr], \val
 	.endm
 
+	.macro ldp2 reg1, reg2, ptr, val1, val2
+	ldp \reg1, \reg2, [\ptr, \val1]
+	.endm
+
 	.macro stp1 reg1, reg2, ptr, val
 	user_stp 9998f, \reg1, \reg2, \ptr, \val
 	.endm
 
+	.macro stp2 reg1, reg2, ptr, val1, val2
+	user_stp2 9998f, \reg1, \reg2, \ptr, \val1, \val2
+	.endm
+
 end	.req	x5
 SYM_FUNC_START(__arch_copy_to_user)
 	add	end, x0, x2
diff --git a/arch/arm64/lib/memcpy.S b/arch/arm64/lib/memcpy.S
index dc8d2a216a6e..9e0bfefd2673 100644
--- a/arch/arm64/lib/memcpy.S
+++ b/arch/arm64/lib/memcpy.S
@@ -52,10 +52,18 @@
 	ldp \reg1, \reg2, [\ptr], \val
 	.endm
 
+	.macro ldp2 reg1, reg2, ptr, val1, val2
+	ldp \reg1, \reg2, [\ptr, \val1]
+	.endm
+
 	.macro stp1 reg1, reg2, ptr, val
 	stp \reg1, \reg2, [\ptr], \val
 	.endm
 
+	.macro stp2 reg1, reg2, ptr, val1, val2
+	stp \reg1, \reg2, [\ptr, \val1]
+	.endm
+
 SYM_FUNC_START_ALIAS(__memcpy)
 SYM_FUNC_START_WEAK_PI(memcpy)
 #include "copy_template.S"
-- 
2.25.1

