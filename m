Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0012E36E724
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Apr 2021 10:39:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239967AbhD2Ihl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Apr 2021 04:37:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:47856 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239916AbhD2Ihi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Apr 2021 04:37:38 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 67951613B4;
        Thu, 29 Apr 2021 08:36:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619685411;
        bh=2qAnuZ0glq7AD0WdQxX0rOeTrE+qvGfHUxQ2lCXNL8s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=N5z99kBzrOrO5N3XTumPMUpPZExJtOdotoLhGXf3C20gqEqJ256d5oK7P5uXcGKLS
         ohvR7hBUHcGkALFvgWY90FCamd5G+EevWmbnVOQOzFi2DHn/mkA1bob8KDHb3epsnf
         DGckQ6/iwtqKn66b+ZxR0sAtjlGVEbdZpYVS5/4u+Y9iFDjz6wUTmZFa+KgkBZN4Rq
         CEdnXwToC2xePL1NRXbPWiKxPUeqji5RZ8sr2LjbkywAoBelXx5NbR5jkvqXrQVCYh
         ygjkli9u4EYqhKDm8w6qBdSNRlJr9fKLaz9M+OFgCvNzepXH0M3SZJoWKHzmRO/B2a
         VsT4BdsSq1NlQ==
Received: by pali.im (Postfix)
        id 693FDA43; Thu, 29 Apr 2021 10:36:49 +0200 (CEST)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     Gregory CLEMENT <gregory.clement@bootlin.com>,
        Andrew Lunn <andrew@lunn.ch>
Cc:     =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 mvebu + mvebu/dt64 3/6] firmware: turris-mox-rwtm: fail probing when firmware does not support hwrng
Date:   Thu, 29 Apr 2021 10:36:33 +0200
Message-Id: <20210429083636.22560-3-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210429083636.22560-1-pali@kernel.org>
References: <20210308153703.23097-1-kabel@kernel.org>
 <20210429083636.22560-1-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When Marvell's rWTM firmware, which does not support the GET_RANDOM
command, is used, kernel prints an error message
  hwrng: no data available
every 10 seconds.

Fail probing of this driver if the rWTM firmware does not support the
GET_RANDOM command.

This makes it possible to put this driver's compatible into generic
armada-37xx device tree, to be available for other Armada 3720 devices
besides Turris MOX. If they use the rWTM firmware from CZ.NIC, they will
have HWRNG available, and if not, the driver won't be complaining.

Signed-off-by: Pali Rohár <pali@kernel.org>
Fixes: 389711b37493 ("firmware: Add Turris Mox rWTM firmware driver")
Signed-off-by: Marek Behún <kabel@kernel.org>
---
 drivers/firmware/turris-mox-rwtm.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/drivers/firmware/turris-mox-rwtm.c b/drivers/firmware/turris-mox-rwtm.c
index d7e3489e4bf2..3ef9687dddca 100644
--- a/drivers/firmware/turris-mox-rwtm.c
+++ b/drivers/firmware/turris-mox-rwtm.c
@@ -260,6 +260,27 @@ static int mox_get_board_info(struct mox_rwtm *rwtm)
 	return 0;
 }
 
+static int check_get_random_support(struct mox_rwtm *rwtm)
+{
+	struct armada_37xx_rwtm_tx_msg msg;
+	int ret;
+
+	msg.command = MBOX_CMD_GET_RANDOM;
+	msg.args[0] = 1;
+	msg.args[1] = rwtm->buf_phys;
+	msg.args[2] = 4;
+
+	ret = mbox_send_message(rwtm->mbox, &msg);
+	if (ret < 0)
+		return ret;
+
+	ret = wait_for_completion_timeout(&rwtm->cmd_done, HZ / 2);
+	if (ret < 0)
+		return ret;
+
+	return mox_get_status(MBOX_CMD_GET_RANDOM, rwtm->reply.retval);
+}
+
 static int mox_hwrng_read(struct hwrng *rng, void *data, size_t max, bool wait)
 {
 	struct mox_rwtm *rwtm = (struct mox_rwtm *) rng->priv;
@@ -497,6 +518,13 @@ static int turris_mox_rwtm_probe(struct platform_device *pdev)
 	if (ret < 0)
 		dev_warn(dev, "Cannot read board information: %i\n", ret);
 
+	ret = check_get_random_support(rwtm);
+	if (ret < 0) {
+		dev_notice(dev,
+			   "Firmware does not support the GET_RANDOM command\n");
+		goto free_channel;
+	}
+
 	rwtm->hwrng.name = DRIVER_NAME "_hwrng";
 	rwtm->hwrng.read = mox_hwrng_read;
 	rwtm->hwrng.priv = (unsigned long) rwtm;
-- 
2.20.1

