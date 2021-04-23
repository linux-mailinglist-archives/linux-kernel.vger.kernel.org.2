Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47342368EAE
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Apr 2021 10:15:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241548AbhDWIPd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Apr 2021 04:15:33 -0400
Received: from mail-m118208.qiye.163.com ([115.236.118.208]:27228 "EHLO
        mail-m118208.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241376AbhDWIPb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Apr 2021 04:15:31 -0400
Received: from ubuntu.localdomain (unknown [36.152.145.182])
        by mail-m118208.qiye.163.com (Hmail) with ESMTPA id 0785DE0104;
        Fri, 23 Apr 2021 16:14:53 +0800 (CST)
From:   zhouchuangao <zhouchuangao@vivo.com>
To:     Wei Xu <xuwei5@hisilicon.com>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     zhouchuangao <zhouchuangao@vivo.com>
Subject: [PATCH] arm/mach-hisi: Use BUG_ON instead of if condition followed by BUG
Date:   Fri, 23 Apr 2021 01:14:45 -0700
Message-Id: <1619165686-69955-1-git-send-email-zhouchuangao@vivo.com>
X-Mailer: git-send-email 2.7.4
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZS1VLWVdZKFlBSE83V1ktWUFJV1kPCR
        oVCBIfWUFZQxoeGVYYHUpKSklOShgeGENVEwETFhoSFyQUDg9ZV1kWGg8SFR0UWUFZT0tIVUpKS0
        hKTFVLWQY+
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6OAg6Egw6Fz8XMA0eDRAhHxNM
        HjEKCzVVSlVKTUpCSk1OTUJITUtCVTMWGhIXVQETFA4YEw4aFRwaFDsNEg0UVRgUFkVZV1kSC1lB
        WUhNVUpOSVVKT05VSkNJWVdZCAFZQUlIQ0I3Bg++
X-HM-Tid: 0a78fdcbc4ec2c17kusn0785de0104
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

BUG_ON uses unlikely in if(). Through disassembly, we can see that
brk #0x800 is compiled to the end of the function.
As you can see below:
    ......
    ffffff8008660bec:   d65f03c0    ret
    ffffff8008660bf0:   d4210000    brk #0x800

Usually, the condition in if () is not satisfied. For the
multi-stage pipeline, we do not need to perform fetch decode
and excute operation on brk instruction.

In my opinion, this can improve the efficiency of the
multi-stage pipeline.

Signed-off-by: zhouchuangao <zhouchuangao@vivo.com>
---
 arch/arm/mach-hisi/hotplug.c  | 3 +--
 arch/arm/mach-hisi/platmcpm.c | 4 ++--
 2 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-hisi/hotplug.c b/arch/arm/mach-hisi/hotplug.c
index c517941..b9ced60 100644
--- a/arch/arm/mach-hisi/hotplug.c
+++ b/arch/arm/mach-hisi/hotplug.c
@@ -193,8 +193,7 @@ void hix5hd2_set_cpu(int cpu, bool enable)
 	u32 val = 0;
 
 	if (!ctrl_base)
-		if (!hix5hd2_hotplug_init())
-			BUG();
+		BUG_ON(!hix5hd2_hotplug_init());
 
 	if (enable) {
 		/* power on cpu1 */
diff --git a/arch/arm/mach-hisi/platmcpm.c b/arch/arm/mach-hisi/platmcpm.c
index 96a4840..6c90039 100644
--- a/arch/arm/mach-hisi/platmcpm.c
+++ b/arch/arm/mach-hisi/platmcpm.c
@@ -82,8 +82,8 @@ static void hip04_set_snoop_filter(unsigned int cluster, unsigned int on)
 {
 	unsigned long data;
 
-	if (!fabric)
-		BUG();
+	BUG_ON(!fabric);
+
 	data = readl_relaxed(fabric + FAB_SF_MODE);
 	if (on)
 		data |= 1 << cluster;
-- 
2.7.4

