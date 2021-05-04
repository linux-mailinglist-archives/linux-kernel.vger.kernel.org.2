Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 564CC3726F4
	for <lists+linux-kernel@lfdr.de>; Tue,  4 May 2021 10:10:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230037AbhEDILV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 May 2021 04:11:21 -0400
Received: from m12-15.163.com ([220.181.12.15]:44827 "EHLO m12-15.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229931AbhEDILU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 May 2021 04:11:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id; bh=qXd3KOHGykNe9UQ2GV
        4mvLZdqFscC0bSZBnAA0rY8f4=; b=YRGLDI/pYDyR1EcnIOVcnkYfpfOvjUIY6F
        JLjhpxDUg5KL7/Ucal2Y2QkUi9B5mHuoGW7Uw9tNkxeEYg+nOG4GH6c8YoEETiuA
        9MbHnrpG/bPlKKOm5nW51nNl4JvHTANtXfqeQvXvKEDjqfx66wz1f/nd1Ja9H8/O
        pSFN0h3jA=
Received: from ubuntu.localdomain (unknown [144.12.67.163])
        by smtp11 (Coremail) with SMTP id D8CowAAHctQ+AZFgSuNyBw--.41S2;
        Tue, 04 May 2021 16:09:42 +0800 (CST)
From:   Kailong Wang <Wkailong1993@163.com>
To:     jiaxun.yang@flygoat.com, chenhc@lemote.com
Cc:     ralf@linux-mips.org, paul.burton@mips.com, jhogan@kernel.org,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        Kailong Wang <Wkailong1993@163.com>
Subject: [PATCH] MIPS:Loongson2F:delete mutex defined but not used
Date:   Tue,  4 May 2021 01:09:33 -0700
Message-Id: <1620115773-5662-1-git-send-email-Wkailong1993@163.com>
X-Mailer: git-send-email 2.7.4
X-CM-TRANSID: D8CowAAHctQ+AZFgSuNyBw--.41S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7XFyxtF4xCFykZrW5try8uFg_yoWxArX_KF
        y2kw48WrWrArn3C3srZF15Kw42934ruF13CF93Cr9Yv3WFvF9rCF48ZryUWrn8WFZIv34r
        WF4rWr1ruFsrtjkaLaAFLSUrUUUU1b8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUbxpnJUUUUU==
X-Originating-IP: [144.12.67.163]
X-CM-SenderInfo: pzndxz5rqjimizt6il2tof0z/xtbBZwOIY1et2fkshgABs+
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

mutex "clock_list_sem" defined in arch/mips/loongson64/lemote-2f/clock.c 
never be used.

Signed-off-by: Kailong Wang <Wkailong1993@163.com>
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

