Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B319E38E3EE
	for <lists+linux-kernel@lfdr.de>; Mon, 24 May 2021 12:22:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232546AbhEXKXp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 May 2021 06:23:45 -0400
Received: from out30-130.freemail.mail.aliyun.com ([115.124.30.130]:45570 "EHLO
        out30-130.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232433AbhEXKXo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 May 2021 06:23:44 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04400;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0UZvuTug_1621851732;
Received: from j63c13417.sqa.eu95.tbsite.net(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0UZvuTug_1621851732)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 24 May 2021 18:22:13 +0800
From:   Yang Li <yang.lee@linux.alibaba.com>
To:     mturquette@baylibre.com
Cc:     sboyd@kernel.org, palmer@dabbelt.com, paul.walmsley@sifive.com,
        linux-clk@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, Yang Li <yang.lee@linux.alibaba.com>
Subject: [PATCH] clk: sifive: Fix kernel-doc
Date:   Mon, 24 May 2021 18:22:10 +0800
Message-Id: <1621851730-32287-1-git-send-email-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix function name in sifive-prci.c kernel-doc comment
to remove a warning.

drivers/clk/sifive/sifive-prci.c:573: warning: expecting prototype for
sifive_prci_init(). Prototype was for sifive_prci_probe() instead

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 drivers/clk/sifive/sifive-prci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/sifive/sifive-prci.c b/drivers/clk/sifive/sifive-prci.c
index 0d79ba3..80a288c 100644
--- a/drivers/clk/sifive/sifive-prci.c
+++ b/drivers/clk/sifive/sifive-prci.c
@@ -564,7 +564,7 @@ static int __prci_register_clocks(struct device *dev, struct __prci_data *pd,
 }
 
 /**
- * sifive_prci_init() - initialize prci data and check parent count
+ * sifive_prci_probe() - initialize prci data and check parent count
  * @pdev: platform device pointer for the prci
  *
  * Return: 0 upon success or a negative error code upon failure.
-- 
1.8.3.1

