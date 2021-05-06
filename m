Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0E69375143
	for <lists+linux-kernel@lfdr.de>; Thu,  6 May 2021 11:08:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234078AbhEFJJh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 May 2021 05:09:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:46146 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234026AbhEFJJ1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 May 2021 05:09:27 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0A36F613B5;
        Thu,  6 May 2021 09:08:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620292109;
        bh=2qAnuZ0glq7AD0WdQxX0rOeTrE+qvGfHUxQ2lCXNL8s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=InnKih16wgbo7uvL8fVAgljGJ7Fuq274vMkcZmlj5XQ2kIIFHn0o4IMz6Zi2Y0vY7
         PbbX+4+6Mv5ayp+Rr1zMeopl/R588ZwD9VX0Pm0toZj+21PA72keO0kAhCmZ6T58vK
         S4CG69a/e8WiwITj6Gc34DN5RtDUMFhHOhO5EtAaVm6bqmhFBok73DKr1iyhX39BYH
         IT4aT249gdHfyR+ZTO2sXoz1JfV262R9fZ6Ulwii0O7uTCC+QUn+VF10pZujRvqQC+
         Tf+/n876A7NyixeAnshMoIDIBqWc3BKHyvUTQz1jN2w+r5aP31Zfnvd8enKSGGTkBz
         R3LKi4fFoR2Hg==
Received: by pali.im (Postfix)
        id 16F96865; Thu,  6 May 2021 11:08:27 +0200 (CEST)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     Gregory CLEMENT <gregory.clement@bootlin.com>,
        Andrew Lunn <andrew@lunn.ch>
Cc:     =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 mvebu + mvebu/dt64 3/6] firmware: turris-mox-rwtm: fail probing when firmware does not support hwrng
Date:   Thu,  6 May 2021 11:07:59 +0200
Message-Id: <20210506090802.14268-3-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210506090802.14268-1-pali@kernel.org>
References: <20210308153703.23097-1-kabel@kernel.org>
 <20210506090802.14268-1-pali@kernel.org>
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

