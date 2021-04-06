Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A08A7354CFF
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Apr 2021 08:38:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244034AbhDFGip (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Apr 2021 02:38:45 -0400
Received: from mail-m17637.qiye.163.com ([59.111.176.37]:13962 "EHLO
        mail-m17637.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238603AbhDFGil (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Apr 2021 02:38:41 -0400
Received: from wanjb-virtual-machine.localdomain (unknown [36.152.145.182])
        by mail-m17637.qiye.163.com (Hmail) with ESMTPA id B776B980348;
        Tue,  6 Apr 2021 14:38:29 +0800 (CST)
From:   Wan Jiabing <wanjiabing@vivo.com>
To:     Richard Weinberger <richard@nod.at>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     kael_w@yeah.net, Wan Jiabing <wanjiabing@vivo.com>
Subject: [PATCH] drivers: mtd: ubi: Remove unnecessary struct declaration
Date:   Tue,  6 Apr 2021 14:37:51 +0800
Message-Id: <20210406063751.522992-1-wanjiabing@vivo.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZS1VLWVdZKFlBSE83V1ktWUFJV1kPCR
        oVCBIfWUFZTEpDHkxDHkxKTR4eVkpNSkxNQkpKS0JCT0xVEwETFhoSFyQUDg9ZV1kWGg8SFR0UWU
        FZT0tIVUpKS0hKQ1VLWQY+
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6NyI6KSo5SD8QAi4zQgEfDAEN
        OS4wCxZVSlVKTUpMTUJKSkpLSUtIVTMWGhIXVQwaFRESGhkSFRw7DRINFFUYFBZFWVdZEgtZQVlI
        TVVKTklVSk9OVUpDSVlXWQgBWUFKTk9MNwY+
X-HM-Tid: 0a78a5e769e6d992kuwsb776b980348
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

struct ubi_wl_entry is defined at 178th line.
The declaration here is unnecessary. Remove it.

Signed-off-by: Wan Jiabing <wanjiabing@vivo.com>
---
 drivers/mtd/ubi/ubi.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/mtd/ubi/ubi.h b/drivers/mtd/ubi/ubi.h
index c2da77163f94..7c083ad58274 100644
--- a/drivers/mtd/ubi/ubi.h
+++ b/drivers/mtd/ubi/ubi.h
@@ -388,8 +388,6 @@ struct ubi_volume_desc {
 	int mode;
 };
 
-struct ubi_wl_entry;
-
 /**
  * struct ubi_debug_info - debugging information for an UBI device.
  *
-- 
2.25.1

