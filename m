Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E96E345628
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 04:19:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230051AbhCWDSg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 23:18:36 -0400
Received: from mail-m17637.qiye.163.com ([59.111.176.37]:45470 "EHLO
        mail-m17637.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229870AbhCWDSU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 23:18:20 -0400
Received: from wanjb-virtual-machine.localdomain (unknown [36.152.145.182])
        by mail-m17637.qiye.163.com (Hmail) with ESMTPA id 1E210980293;
        Tue, 23 Mar 2021 11:17:54 +0800 (CST)
From:   Wan Jiabing <wanjiabing@vivo.com>
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     kael_w@yeah.net, Wan Jiabing <wanjiabing@vivo.com>
Subject: [PATCH] include: linux: mtd: Remove duplicate include of nand.h
Date:   Tue, 23 Mar 2021 11:17:37 +0800
Message-Id: <20210323031737.259365-1-wanjiabing@vivo.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZS1VLWVdZKFlBSE83V1ktWUFJV1kPCR
        oVCBIfWUFZGEpOGkNNQhkZGBgaVkpNSk1PTUJPQ09OTElVEwETFhoSFyQUDg9ZV1kWGg8SFR0UWU
        FZT0tIVUpKS0hKQ1VLWQY+
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6OlE6Kzo4Tz8LMDoLFT1JVkgD
        KU4aChFVSlVKTUpNT01CT0NOTENCVTMWGhIXVQwaFRESGhkSFRw7DRINFFUYFBZFWVdZEgtZQVlI
        TVVKTklVSk9OVUpDSVlXWQgBWUFKTUlLNwY+
X-HM-Tid: 0a785d16dcb1d992kuws1e210980293
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

linux/mtd/nand.h has been included at line 17.
So we remove the duplicate one at line 21.

Signed-off-by: Wan Jiabing <wanjiabing@vivo.com>
---
 include/linux/mtd/rawnand.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/linux/mtd/rawnand.h b/include/linux/mtd/rawnand.h
index 6b3240e44310..93e8f72beba6 100644
--- a/include/linux/mtd/rawnand.h
+++ b/include/linux/mtd/rawnand.h
@@ -18,7 +18,6 @@
 #include <linux/mtd/flashchip.h>
 #include <linux/mtd/bbm.h>
 #include <linux/mtd/jedec.h>
-#include <linux/mtd/nand.h>
 #include <linux/mtd/onfi.h>
 #include <linux/mutex.h>
 #include <linux/of.h>
-- 
2.25.1

