Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F5313D76E9
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jul 2021 15:35:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236723AbhG0Nfq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jul 2021 09:35:46 -0400
Received: from smtpbg128.qq.com ([106.55.201.39]:45000 "EHLO smtpbg587.qq.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232186AbhG0Nfo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jul 2021 09:35:44 -0400
X-QQ-mid: bizesmtp52t1627392894tlx3fh6g
Received: from ficus.lan (unknown [171.223.99.141])
        by esmtp6.qq.com (ESMTP) with 
        id ; Tue, 27 Jul 2021 21:34:52 +0800 (CST)
X-QQ-SSF: 01000000002000B0C000B00A0000000
X-QQ-FEAT: ptz89vG4AG809G2yUsmLkWimg0PzEcjML+fqpthYefsvk60AEjNt/EvUQwwQJ
        K6tp89nvsLrVkYwtj/uFpGbXqGV+8oy41XMhJRoJDjFItbfrKREcDR1aq5ldW9oNsCsw7Vs
        LD9lYEHihJ3rpJcf6TvSG0nSsNUzb0k/06vjDrEGne2W96YtF9AAWdrfuwF5GbIzsDMBzq7
        OkbtjX2RLhmT00bup8YgCu6nUw4gLvdYb2/m8Ln8mdrlo30ZUmMMzpJ+kd9Dwv8hEfljYjM
        uuaGXxC+GgFIbEZF1+unFduEYQya0LVs63uIJfsPJSaS5GP4TqCxFgOLJUD9hw5mAvOf3pZ
        mEngyejXjrejZhH3V8qD4wfol03zQ==
X-QQ-GoodBg: 0
From:   Jason Wang <wangborong@cdjrlc.com>
To:     linusw@kernel.org
Cc:     kaloz@openwrt.org, khalasa@piap.pl, linux@armlinux.org.uk,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Jason Wang <wangborong@cdjrlc.com>
Subject: [PATCH] ARM: PCI: use __func__ in debug messages
Date:   Tue, 27 Jul 2021 21:34:50 +0800
Message-Id: <20210727133450.173749-1-wangborong@cdjrlc.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybgspam:qybgspam5
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Perhaps, the '"%s...", __func__' is more convenient to show current
function in a debug message.

Signed-off-by: Jason Wang <wangborong@cdjrlc.com>
---
 arch/arm/mach-ixp4xx/common-pci.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-ixp4xx/common-pci.c b/arch/arm/mach-ixp4xx/common-pci.c
index 893c19c254e3..deb80fe05c03 100644
--- a/arch/arm/mach-ixp4xx/common-pci.c
+++ b/arch/arm/mach-ixp4xx/common-pci.c
@@ -203,18 +203,18 @@ static u32 local_byte_lane_enable_bits(u32 n, int size)
 static int local_read_config(int where, int size, u32 *value)
 { 
 	u32 n, data;
-	pr_debug("local_read_config from %d size %d\n", where, size);
+	pr_debug("%s from %d size %d\n", __func__, where, size);
 	n = where % 4;
 	crp_read(where & ~3, &data);
 	*value = (data >> (8*n)) & bytemask[size];
-	pr_debug("local_read_config read %#x\n", *value);
+	pr_debug("%s read %#x\n", __func__, *value);
 	return PCIBIOS_SUCCESSFUL;
 }
 
 static int local_write_config(int where, int size, u32 value)
 {
 	u32 n, byte_enables, data;
-	pr_debug("local_write_config %#x to %d size %d\n", value, where, size);
+	pr_debug("%s %#x to %d size %d\n", __func__, value, where, size);
 	n = where % 4;
 	byte_enables = local_byte_lane_enable_bits(n, size);
 	if (byte_enables == 0xffffffff)
@@ -293,8 +293,8 @@ static int abort_handler(unsigned long addr, unsigned int fsr, struct pt_regs *r
 
 	isr = *PCI_ISR;
 	local_read_config(PCI_STATUS, 2, &status);
-	pr_debug("PCI: abort_handler addr = %#lx, isr = %#x, "
-		"status = %#x\n", addr, isr, status);
+	pr_debug("PCI: %s addr = %#lx, isr = %#x, status = %#x\n",
+			__func__, addr, isr, status);
 
 	/* make sure the Master Abort bit is reset */    
 	*PCI_ISR = PCI_ISR_PFE;
-- 
2.32.0

