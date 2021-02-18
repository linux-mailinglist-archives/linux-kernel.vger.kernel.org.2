Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A42B831E93A
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Feb 2021 12:50:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232187AbhBRLpE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Feb 2021 06:45:04 -0500
Received: from out30-133.freemail.mail.aliyun.com ([115.124.30.133]:35800 "EHLO
        out30-133.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232256AbhBRJ5l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Feb 2021 04:57:41 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R261e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04420;MF=shile.zhang@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0UOtYhDk_1613641232;
Received: from e18g09479.et15sqa.tbsite.net(mailfrom:shile.zhang@linux.alibaba.com fp:SMTPD_---0UOtYhDk_1613641232)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 18 Feb 2021 17:40:38 +0800
From:   Shile Zhang <shile.zhang@linux.alibaba.com>
To:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Shile Zhang <shile.zhang@linux.alibaba.com>
Subject: [PATCH] misc/pvpanic: Export module FDT device table
Date:   Thu, 18 Feb 2021 17:40:24 +0800
Message-Id: <20210218094024.69354-1-shile.zhang@linux.alibaba.com>
X-Mailer: git-send-email 2.24.0.rc2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Export the module FDT device table to ensure the FDT compatible strings
are listed in the module alias. This help the pvpanic driver can be
loaded on boot automatically not only the ACPI device, but also the FDT
device.

Signed-off-by: Shile Zhang <shile.zhang@linux.alibaba.com>
---
 drivers/misc/pvpanic.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/misc/pvpanic.c b/drivers/misc/pvpanic.c
index 41cab297d66e..2356d621967e 100644
--- a/drivers/misc/pvpanic.c
+++ b/drivers/misc/pvpanic.c
@@ -92,6 +92,7 @@ static const struct of_device_id pvpanic_mmio_match[] = {
 	{ .compatible = "qemu,pvpanic-mmio", },
 	{}
 };
+MODULE_DEVICE_TABLE(of, pvpanic_mmio_match);
 
 static const struct acpi_device_id pvpanic_device_ids[] = {
 	{ "QEMU0001", 0 },
-- 
2.24.0.rc2

