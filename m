Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3315A345814
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 07:59:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229494AbhCWG7V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 02:59:21 -0400
Received: from mail-m17637.qiye.163.com ([59.111.176.37]:49908 "EHLO
        mail-m17637.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230047AbhCWG7P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 02:59:15 -0400
Received: from wanjb-virtual-machine.localdomain (unknown [36.152.145.182])
        by mail-m17637.qiye.163.com (Hmail) with ESMTPA id 96BED9802E7;
        Tue, 23 Mar 2021 14:59:12 +0800 (CST)
From:   Wan Jiabing <wanjiabing@vivo.com>
To:     Russell King <linux@armlinux.org.uk>,
        Mike Rapoport <rppt@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Wan Jiabing <wanjiabing@vivo.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     kael_w@yeah.net
Subject: [PATCH] arch: arm: mach-sa1100: Remove duplicate include
Date:   Tue, 23 Mar 2021 14:58:53 +0800
Message-Id: <20210323065856.501955-1-wanjiabing@vivo.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZS1VLWVdZKFlBSE83V1ktWUFJV1kPCR
        oVCBIfWUFZSh5LQk1LHUpNQkgYVkpNSk1PQ0lMTklDTUtVEwETFhoSFyQUDg9ZV1kWGg8SFR0UWU
        FZT0tIVUpKS0JITlVLWQY+
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Pwg6CSo4Sj8RSzosDzdLDSo5
        DyJPCQxVSlVKTUpNT0NJTE5ISkhMVTMWGhIXVQwaFRESGhkSFRw7DRINFFUYFBZFWVdZEgtZQVlI
        TVVKTklVSk9OVUpDSVlXWQgBWUFKTUlPNwY+
X-HM-Tid: 0a785de1590dd992kuws96bed9802e7
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

linux/tty.h has been included at line 13, so 
remove the duplicate one at line 21.

Signed-off-by: Wan Jiabing <wanjiabing@vivo.com>
---
 arch/arm/mach-sa1100/hackkit.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/mach-sa1100/hackkit.c b/arch/arm/mach-sa1100/hackkit.c
index 3085f1c2e586..3fe34ee7c0ab 100644
--- a/arch/arm/mach-sa1100/hackkit.c
+++ b/arch/arm/mach-sa1100/hackkit.c
@@ -18,7 +18,6 @@
 #include <linux/serial_core.h>
 #include <linux/mtd/mtd.h>
 #include <linux/mtd/partitions.h>
-#include <linux/tty.h>
 #include <linux/gpio.h>
 #include <linux/leds.h>
 #include <linux/platform_device.h>
-- 
2.25.1

