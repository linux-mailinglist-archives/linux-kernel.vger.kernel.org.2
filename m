Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 654843B6787
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jun 2021 19:19:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232141AbhF1RWF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Jun 2021 13:22:05 -0400
Received: from smtpbgeu1.qq.com ([52.59.177.22]:45844 "EHLO smtpbgeu1.qq.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231994AbhF1RWE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jun 2021 13:22:04 -0400
X-QQ-mid: bizesmtp54t1624900768trbou2fx
Received: from localhost.localdomain (unknown [182.148.13.55])
        by esmtp6.qq.com (ESMTP) with 
        id ; Tue, 29 Jun 2021 01:19:21 +0800 (CST)
X-QQ-SSF: 01000000002000B0B000B00A0000000
X-QQ-FEAT: q+6/vEh7X6oISGNn5vY48GUO7vC1rbc+rvKLfJf59IqsaDEEsVYJPrEYwedI1
        VYVrkQYpZ/wwyyV+b0nVhcsOLbVry02WNA8uHiBSOVBRwquiIEGw20h7v0JVhbxUFra7yGv
        WoFRyEmMA8L7r7xTEYDyi2ubo6oyYxBVQseczIcbf+vHMFz81TPQoCHS+oMbqqHarMrk6uY
        jqn3ditv6fPc+iWmGFXirWwxCF2RExPhYboMjc/uN4k6U89zHkHSzUkOcd2AGy5ZLbfs2qW
        6lNxii91VQ0A7vI2qI16NzSNz5g4yZd9+Q7hmve6o2HF4gRl3r+AviZ3A=
X-QQ-GoodBg: 0
From:   Jinchao Wang <wjc@cdjrlc.com>
To:     broonie@kernel.org
Cc:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        rafael@kernel.org, Jinchao Wang <wjc@cdjrlc.com>
Subject: [PATCH v2 1/2] regmap: Prefer unsigned int to bare use of unsigned
Date:   Tue, 29 Jun 2021 01:19:06 +0800
Message-Id: <20210628171907.63646-1-wjc@cdjrlc.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybgforeign:qybgforeign2
X-QQ-Bgrelay: 1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix checkpatch warnings:
    WARNING: Prefer 'unsigned int' to bare use of 'unsigned'

Signed-off-by: Jinchao Wang <wjc@cdjrlc.com>
---
-change for v2 1/2:
-Split patch
---
 drivers/base/regmap/regmap-debugfs.c | 2 +-
 drivers/base/regmap/regmap-mmio.c    | 2 +-
 drivers/base/regmap/regmap.c         | 8 ++++----
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/base/regmap/regmap-debugfs.c b/drivers/base/regmap/regmap-debugfs.c
index 211a335a608d..ad684d37c2da 100644
--- a/drivers/base/regmap/regmap-debugfs.c
+++ b/drivers/base/regmap/regmap-debugfs.c
@@ -368,7 +368,7 @@ static ssize_t regmap_reg_ranges_read_file(struct file *file,
 	char *buf;
 	char *entry;
 	int ret;
-	unsigned entry_len;
+	unsigned int entry_len;
 
 	if (*ppos < 0 || !count)
 		return -EINVAL;
diff --git a/drivers/base/regmap/regmap-mmio.c b/drivers/base/regmap/regmap-mmio.c
index f9cd51afb9d2..71f16be7e717 100644
--- a/drivers/base/regmap/regmap-mmio.c
+++ b/drivers/base/regmap/regmap-mmio.c
@@ -15,7 +15,7 @@
 
 struct regmap_mmio_context {
 	void __iomem *regs;
-	unsigned val_bytes;
+	unsigned int val_bytes;
 	bool relaxed_mmio;
 
 	bool attached_clk;
diff --git a/drivers/base/regmap/regmap.c b/drivers/base/regmap/regmap.c
index fe3e38dd5324..b62aedd21312 100644
--- a/drivers/base/regmap/regmap.c
+++ b/drivers/base/regmap/regmap.c
@@ -1126,10 +1126,10 @@ struct regmap *__regmap_init(struct device *dev,
 		/* Make sure, that this register range has no selector
 		   or data window within its boundary */
 		for (j = 0; j < config->num_ranges; j++) {
-			unsigned sel_reg = config->ranges[j].selector_reg;
-			unsigned win_min = config->ranges[j].window_start;
-			unsigned win_max = win_min +
-					   config->ranges[j].window_len - 1;
+			unsigned int sel_reg = config->ranges[j].selector_reg;
+			unsigned int win_min = config->ranges[j].window_start;
+			unsigned int win_max = win_min +
+					       config->ranges[j].window_len - 1;
 
 			/* Allow data window inside its own virtual range */
 			if (j == i)
-- 
2.31.1



