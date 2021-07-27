Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 469093D758F
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jul 2021 15:06:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236577AbhG0NGU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jul 2021 09:06:20 -0400
Received: from smtpbg128.qq.com ([106.55.201.39]:35111 "EHLO smtpbg587.qq.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232106AbhG0NGT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jul 2021 09:06:19 -0400
X-QQ-mid: bizesmtp36t1627391151tb3rx6qe
Received: from ficus.lan (unknown [171.223.99.141])
        by esmtp6.qq.com (ESMTP) with 
        id ; Tue, 27 Jul 2021 21:05:50 +0800 (CST)
X-QQ-SSF: 01000000002000B0C000B00A0000000
X-QQ-FEAT: WKaXkSLX6oMcnFHmi/bUi/JKgOUhJWvHZy4rPPiea5kL3CmU6xw7gYJmM+CGb
        WbPyvFq9FjHxXiDbY9f2t5EbshO0k2bn+6YY3BWzvfmNKcyaWr+vatfNb79AOQPnotbzMVw
        eqKLULw4i/uLXDS/Fky3Ct3rMXskrIj02k6MS2owUdwhtezf7bogjM61ViwE+3zAB6OSHIv
        OzAGAVyeirOTk1/jvJrrG9C66amaxbIlNDq6EVeL/BB/574FLiV2BRDyGn9W7DDy9XbIgrb
        RygyqT1hWNePBw9u020fAu98CYbxMrhIx0/DSdLFKfZFUBfbVYtWm+oDvC3xScK6qIDdMIl
        2xwI1pxFtZ8DvP4LlPgQ5AYYzx6eA==
X-QQ-GoodBg: 0
From:   Jason Wang <wangborong@cdjrlc.com>
To:     linux@armlinux.org.uk
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Jason Wang <wangborong@cdjrlc.com>
Subject: [PATCH] ARM: scoop: move EXPORT_SYMBOLs to follow their funcs
Date:   Tue, 27 Jul 2021 21:05:47 +0800
Message-Id: <20210727130547.141310-1-wangborong@cdjrlc.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybgspam:qybgspam5
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Usually, EXPORT_SYMBOLs should immediately follow their functions or
variables.

Signed-off-by: Jason Wang <wangborong@cdjrlc.com>
---
 arch/arm/common/scoop.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/arm/common/scoop.c b/arch/arm/common/scoop.c
index 6edb961bd6c1..746919c18bb1 100644
--- a/arch/arm/common/scoop.c
+++ b/arch/arm/common/scoop.c
@@ -49,6 +49,7 @@ void reset_scoop(struct device *dev)
 	iowrite16(0x0000, sdev->base + SCOOP_ISR);  /* 1C */
 	iowrite16(0x0000, sdev->base + SCOOP_IRM);
 }
+EXPORT_SYMBOL(reset_scoop);
 
 static void __scoop_gpio_set(struct scoop_dev *sdev,
 			unsigned offset, int value)
@@ -126,15 +127,13 @@ unsigned short read_scoop_reg(struct device *dev, unsigned short reg)
 	struct scoop_dev *sdev = dev_get_drvdata(dev);
 	return ioread16(sdev->base + reg);
 }
+EXPORT_SYMBOL(read_scoop_reg);
 
 void write_scoop_reg(struct device *dev, unsigned short reg, unsigned short data)
 {
 	struct scoop_dev *sdev = dev_get_drvdata(dev);
 	iowrite16(data, sdev->base + reg);
 }
-
-EXPORT_SYMBOL(reset_scoop);
-EXPORT_SYMBOL(read_scoop_reg);
 EXPORT_SYMBOL(write_scoop_reg);
 
 #ifdef CONFIG_PM
-- 
2.32.0

