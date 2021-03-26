Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14B6334A2CD
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 08:57:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230059AbhCZH5h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Mar 2021 03:57:37 -0400
Received: from m12-18.163.com ([220.181.12.18]:46363 "EHLO m12-18.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229798AbhCZH5M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Mar 2021 03:57:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=d3l6H
        qGdyJXY93wZ73zXzrAiqfPlJxIIN1klaPDJxw8=; b=PQmvp/ojhEwMfGvFMP27Y
        v79+PgqiivEL5jBs9TYlnLEx70KDHRGyc5eqnIHwh3p5+Xsh+Zsto4/4Slbtiv3B
        GMC1KXoGgaUEzcIeOV09PWLnA25iqAWSc4NMu2L8JUwcPSdB0mBUo6KGg6XXVHmZ
        bWdOv0LU6PbhdmkqjzjDLQ=
Received: from COOL-20201210PM.ccdomain.com (unknown [218.94.48.178])
        by smtp14 (Coremail) with SMTP id EsCowACnpfOZk11gDMb7ag--.3852S2;
        Fri, 26 Mar 2021 15:56:12 +0800 (CST)
From:   zuoqilin1@163.com
To:     mpe@ellerman.id.au, benh@kernel.crashing.org, paulus@samba.org
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        zuoqilin <zuoqilin@yulong.com>
Subject: [PATCH] arch/powerpc: Remove unneeded variable: "ret"
Date:   Fri, 26 Mar 2021 15:56:19 +0800
Message-Id: <20210326075619.48-1-zuoqilin1@163.com>
X-Mailer: git-send-email 2.28.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: EsCowACnpfOZk11gDMb7ag--.3852S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrur43XF48Aw47Ar1xAFyrJFb_yoWftFXEyw
        n7Gw48Canaqrs3AFnrAr13CFnaqr4kGrs8KFnF9a47X3s8Ja98WwsrGrW7JF48Xw1FyrW3
        WFn8KrnIka4SkjkaLaAFLSUrUUUUnb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUYtKsUUUUUU==
X-Originating-IP: [218.94.48.178]
X-CM-SenderInfo: 52xr1xpolqiqqrwthudrp/xtbBRRxhiVPAKukWbAAAsb
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: zuoqilin <zuoqilin@yulong.com>

Remove unneeded variable: "ret".

Signed-off-by: zuoqilin <zuoqilin@yulong.com>
---
 arch/powerpc/platforms/pseries/cmm.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/cmm.c b/arch/powerpc/platforms/pseries/cmm.c
index 45a3a30..95ebb0c 100644
--- a/arch/powerpc/platforms/pseries/cmm.c
+++ b/arch/powerpc/platforms/pseries/cmm.c
@@ -475,8 +475,6 @@ static int cmm_reboot_notifier(struct notifier_block *nb,
 static int cmm_memory_cb(struct notifier_block *self,
 			unsigned long action, void *arg)
 {
-	int ret = 0;
-
 	switch (action) {
 	case MEM_GOING_OFFLINE:
 		mutex_lock(&hotplug_mutex);
@@ -493,7 +491,7 @@ static int cmm_memory_cb(struct notifier_block *self,
 		break;
 	}
 
-	return notifier_from_errno(ret);
+	return notifier_from_errno(0);
 }
 
 static struct notifier_block cmm_mem_nb = {
-- 
1.9.1


