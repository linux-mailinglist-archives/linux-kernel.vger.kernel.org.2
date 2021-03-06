Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8730F32F8B2
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Mar 2021 08:12:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229651AbhCFHMK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Mar 2021 02:12:10 -0500
Received: from m12-13.163.com ([220.181.12.13]:51489 "EHLO m12-13.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229626AbhCFHL5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Mar 2021 02:11:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=B6X83
        bcQNaeUonLObXxqgdndMgL+qs4wIAmEBJKgktY=; b=YF2V0kHRjFtCugbvt2I6d
        HHhA5Wcc4XPJ/phCXxiEHoIuZgDUabIZk6vTOajR+f9Dhhy8JhpVzCwn+2el/zrk
        OyD29mBW/2YoVwMMHMwMgLUesXxHNIOjL1aCWI4Je2p1KY/1TD2tw4ZlINx62V8J
        xsVW6OFdlFwFH8YIvxA/QA=
Received: from yangjunlin.ccdomain.com (unknown [218.17.89.92])
        by smtp9 (Coremail) with SMTP id DcCowACXczmV9UJgoPQoiA--.4S2;
        Sat, 06 Mar 2021 11:23:03 +0800 (CST)
From:   angkery <angkery@163.com>
To:     guoren@kernel.org
Cc:     linux-csky@vger.kernel.org, linux-kernel@vger.kernel.org,
        Junlin Yang <yangjunlin@yulong.com>
Subject: [PATCH] csky: fix typos
Date:   Sat,  6 Mar 2021 11:23:14 +0800
Message-Id: <20210306032314.3186-1-angkery@163.com>
X-Mailer: git-send-email 2.24.0.windows.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: DcCowACXczmV9UJgoPQoiA--.4S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7WF1fuw4kXr45XryDJrWkZwb_yoW8urW8pF
        4Dur95GrZ5urWFyrnrAr1q9F98Ga1kKF13KrWjgryjyr1aqr1jvr4DKr1DCrykXayvqa40
        9FWak3s8Zw1vqaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jP9NsUUUUU=
X-Originating-IP: [218.17.89.92]
X-CM-SenderInfo: 5dqjyvlu16il2tof0z/xtbBRhdNI13l+znGfAAAs-
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Junlin Yang <yangjunlin@yulong.com>

fixes three typos found by codespell.

Signed-off-by: Junlin Yang <yangjunlin@yulong.com>
---
 arch/csky/include/asm/asid.h    | 2 +-
 arch/csky/include/asm/barrier.h | 2 +-
 arch/csky/include/asm/vdso.h    | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/csky/include/asm/asid.h b/arch/csky/include/asm/asid.h
index ac08b0f..6ff205a 100644
--- a/arch/csky/include/asm/asid.h
+++ b/arch/csky/include/asm/asid.h
@@ -37,7 +37,7 @@ void asid_new_context(struct asid_info *info, atomic64_t *pasid,
  * Check the ASID is still valid for the context. If not generate a new ASID.
  *
  * @pasid: Pointer to the current ASID batch
- * @cpu: current CPU ID. Must have been acquired throught get_cpu()
+ * @cpu: current CPU ID. Must have been acquired through get_cpu()
  */
 static inline void asid_check_context(struct asid_info *info,
 				      atomic64_t *pasid, unsigned int cpu,
diff --git a/arch/csky/include/asm/barrier.h b/arch/csky/include/asm/barrier.h
index 84fc600c..f4045dd 100644
--- a/arch/csky/include/asm/barrier.h
+++ b/arch/csky/include/asm/barrier.h
@@ -64,7 +64,7 @@
 
 /*
  * sync:        completion barrier, all sync.xx instructions
- *              guarantee the last response recieved by bus transaction
+ *              guarantee the last response received by bus transaction
  *              made by ld/st instructions before sync.s
  * sync.s:      inherit from sync, but also shareable to other cores
  * sync.i:      inherit from sync, but also flush cpu pipeline
diff --git a/arch/csky/include/asm/vdso.h b/arch/csky/include/asm/vdso.h
index eb5142f..bdce581 100644
--- a/arch/csky/include/asm/vdso.h
+++ b/arch/csky/include/asm/vdso.h
@@ -16,7 +16,7 @@ struct vdso_data {
  * offset of 0, but since the linker must support setting weak undefined
  * symbols to the absolute address 0 it also happens to support other low
  * addresses even when the code model suggests those low addresses would not
- * otherwise be availiable.
+ * otherwise be available.
  */
 #define VDSO_SYMBOL(base, name)							\
 ({										\
-- 
1.9.1


