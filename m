Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 681B244F1B2
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Nov 2021 06:59:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232789AbhKMGCQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Nov 2021 01:02:16 -0500
Received: from smtpbg587.qq.com ([113.96.223.105]:48086 "EHLO smtpbg587.qq.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229487AbhKMGCP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Nov 2021 01:02:15 -0500
X-QQ-mid: bizesmtp45t1636783146tdepwoms
Received: from localhost.localdomain (unknown [125.69.41.88])
        by esmtp6.qq.com (ESMTP) with 
        id ; Sat, 13 Nov 2021 13:59:05 +0800 (CST)
X-QQ-SSF: 01000000000000C0F000B00A0000000
X-QQ-FEAT: B0D4DPF8NcThOjwWqVcGFATOcwUCVabIoSnFsXK16GjD1pduTZuEyipegriBQ
        gbIHGoqY6r3zC+4cPd8mntnUsAWP7HU9vGE+nTTycKKNmlthVeWxNkd7oGlkrz/7oruXp1F
        ONVEVm4yT9WA7gvXxDCrbpqXdZy06ZIDI1m1LQnJHCQYnQsYblD6jnIh5AypDdlzNeua2os
        R2cP+mZ3fjVtqFFDqWZbW8cvZ7XyaksOO5wn+LjZf7DTB/gjiUWef63AYkwV6aCbBKNQrUd
        Qf7EEIQYFTYzGvJn3s5daYyFdeNo6c/4In9Pj8tIQcmUJAtYPqOCig00TCs8KnspWx6Lp6d
        NJnrFiJzWqBUUu+xBxZ/RTfmRUf/ex97/4DXrWv
X-QQ-GoodBg: 0
From:   Jason Wang <wangborong@cdjrlc.com>
To:     leoyang.li@nxp.com
Cc:     qiang.zhao@nxp.com, linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Jason Wang <wangborong@cdjrlc.com>
Subject: [PATCH] soc: fsl: qe: Fix typo in a comment
Date:   Sat, 13 Nov 2021 13:59:00 +0800
Message-Id: <20211113055900.212568-1-wangborong@cdjrlc.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybgspam:qybgspam3
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The double `is' in a comment is repeated, thus one of them
should be removed.

Signed-off-by: Jason Wang <wangborong@cdjrlc.com>
---
 drivers/soc/fsl/qe/qe.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/soc/fsl/qe/qe.c b/drivers/soc/fsl/qe/qe.c
index 4d38c80f8be8..b3c226eb5292 100644
--- a/drivers/soc/fsl/qe/qe.c
+++ b/drivers/soc/fsl/qe/qe.c
@@ -147,7 +147,7 @@ EXPORT_SYMBOL(qe_issue_cmd);
  * memory mapped space.
  * The BRG clock is the QE clock divided by 2.
  * It was set up long ago during the initial boot phase and is
- * is given to us.
+ * given to us.
  * Baud rate clocks are zero-based in the driver code (as that maps
  * to port numbers). Documentation uses 1-based numbering.
  */
@@ -421,7 +421,7 @@ static void qe_upload_microcode(const void *base,
 
 	for (i = 0; i < be32_to_cpu(ucode->count); i++)
 		iowrite32be(be32_to_cpu(code[i]), &qe_immr->iram.idata);
-	
+
 	/* Set I-RAM Ready Register */
 	iowrite32be(QE_IRAM_READY, &qe_immr->iram.iready);
 }
-- 
2.33.0

