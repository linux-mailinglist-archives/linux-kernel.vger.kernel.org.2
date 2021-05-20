Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CAC3738ACE1
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 13:50:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243730AbhETLu5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 07:50:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:57172 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241766AbhETLgy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 07:36:54 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D1F3861358;
        Thu, 20 May 2021 11:35:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621510533;
        bh=0xNLSYCl73+5TMdOcS37E3N3QjdxqB/4vABPgh30trU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=J8+vnwFKcu8A3o70Wy21ipeJY2buUiNqdfH9UMmIhelxA5Mj8rnYXUGEmXUA3zJFv
         rhquoXbB9KRNHhwxAes8II/QjSNCXip1mypxA4Wm8Bn1PgevjUc8/5yCouUwxeHCbU
         EkNBBHS9jAT+uJ1XJ49z7KLLsr0Fj/LtnER2jF0BcHBXNrOh/f6VuTw17ze5AjPlet
         EPKZQm5+2oy5zhm5kJCGT9HZYkd9cOFTSZWbLyBNCPw7X58rZZrvzK0kDadjw/qgUY
         UxtcdyL0ZFF8bGILbi0Hp1N+i8e2ziBxCMG27x1jXkqwdFZwa67SUixLAwlMHwNErS
         LWV/KUihoadGA==
Received: by pali.im (Postfix)
        id 9415D9D1; Thu, 20 May 2021 13:35:32 +0200 (CEST)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     Gregory CLEMENT <gregory.clement@bootlin.com>,
        Andrew Lunn <andrew@lunn.ch>
Cc:     =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 mvebu 3/4] firmware: turris-mox-rwtm: fail probing when firmware does not support hwrng
Date:   Thu, 20 May 2021 13:35:19 +0200
Message-Id: <20210520113520.32240-4-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210520113520.32240-1-pali@kernel.org>
References: <20210308153703.23097-1-kabel@kernel.org>
 <20210520113520.32240-1-pali@kernel.org>
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

Signed-off-by: Pali Rohár <pali@kernel.org>
Signed-off-by: Marek Behún <kabel@kernel.org>
Fixes: 389711b37493 ("firmware: Add Turris Mox rWTM firmware driver")
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

