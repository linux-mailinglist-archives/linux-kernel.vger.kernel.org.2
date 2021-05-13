Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1199737F0EE
	for <lists+linux-kernel@lfdr.de>; Thu, 13 May 2021 03:31:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231479AbhEMBch (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 May 2021 21:32:37 -0400
Received: from m15112.mail.126.com ([220.181.15.112]:40944 "EHLO
        m15112.mail.126.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231340AbhEMBce (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 May 2021 21:32:34 -0400
X-Greylist: delayed 1839 seconds by postgrey-1.27 at vger.kernel.org; Wed, 12 May 2021 21:32:33 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
        s=s110527; h=From:Subject:Date:Message-Id; bh=aWTqk9qaeGXH32vJ/g
        Z3P1BB4JMTwymlIi6j9cZku9A=; b=ag79YP2ANFT5UV1KbQOwEiy8/L1G7VRDkw
        QT+lwNyVwbCNyKGigUwbOFGvNoOaUQ4SRXYrCqSfcR34xb0dfMoRz15rlZDvwClT
        mtjVuJaqz/QAIG2wBOvBDBNReMW6sk8DLfhQiqUmKTGQchY/Q1UmldcQ/UubODY6
        FQuyNlEh4=
Received: from ubuntu.localdomain (unknown [49.93.244.153])
        by smtp2 (Coremail) with SMTP id DMmowABHrQEkepxgkU5_BQ--.53222S2;
        Thu, 13 May 2021 09:00:21 +0800 (CST)
From:   Kailong Wang <wkailong1993@126.com>
To:     jiaxun.yang@flygoat.com, chenhc@lemote.com
Cc:     ralf@linux-mips.org, paul.burton@mips.com, jhogan@kernel.org,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        Kailong Wang <wkailong1993@126.com>
Subject: [PATCH] MIPS:Loongson2F:delete mutex defined but not used
Date:   Wed, 12 May 2021 17:58:51 -0700
Message-Id: <1620867531-66587-1-git-send-email-wkailong1993@126.com>
X-Mailer: git-send-email 2.7.4
X-CM-TRANSID: DMmowABHrQEkepxgkU5_BQ--.53222S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7Wr4UKrWrWry8WryxZFWDJwb_yoWxCrc_KF
        y2kw48WrWrAr1fC3srXr15Kw4j9348uF43CF93Cr9Yv3WFvF9rCF48ZryUWrn8WrsIv34r
        GF4rWr1ruF47tjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUn8wIDUUUUU==
X-Originating-IP: [49.93.244.153]
X-CM-SenderInfo: pzndxz5rqjimizt6ij2wof0z/1tbiYwOR31x5cU9ApAAAsR
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For 4.19.X, mutex clock_list_sem defined in arch/mips/loongson64/lemote-2f/clock.c
never be used.

Signed-off-by: Kailong Wang <wkailong1993@126.com>
---
 arch/mips/loongson64/lemote-2f/clock.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/mips/loongson64/lemote-2f/clock.c b/arch/mips/loongson64/lemote-2f/clock.c
index 8281334..5f1cdcf 100644
--- a/arch/mips/loongson64/lemote-2f/clock.c
+++ b/arch/mips/loongson64/lemote-2f/clock.c
@@ -19,7 +19,6 @@
 
 static LIST_HEAD(clock_list);
 static DEFINE_SPINLOCK(clock_lock);
-static DEFINE_MUTEX(clock_list_sem);
 
 /* Minimum CLK support */
 enum {
-- 
2.7.4

