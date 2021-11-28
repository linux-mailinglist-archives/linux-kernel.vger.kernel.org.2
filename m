Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8016C46097B
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Nov 2021 20:37:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359342AbhK1Tka (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Nov 2021 14:40:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240225AbhK1TiN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Nov 2021 14:38:13 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C6BBC061756
        for <linux-kernel@vger.kernel.org>; Sun, 28 Nov 2021 11:34:57 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2A10DB80D63
        for <linux-kernel@vger.kernel.org>; Sun, 28 Nov 2021 19:34:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 084A5C004E1;
        Sun, 28 Nov 2021 19:34:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638128095;
        bh=R8pL+uk+a2lIAKlx/R55fWu0qSIieBQ7zGB4nhMRKuM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qfI63raXGr7R2e6X+Hj8QPYBLoyKDyHR0BUoYkDNZn+F/to2CLi/wZ7bqIArcN21X
         cAc6gmN22umtFRPgdryav3U9btAxE4yN9T4pRJdJy3nAyAHf+Wd0Dycx2uZG7Oz6q6
         9BbowN6ggk6j29IutQsjrG5i9JN3WPwfFMXIJEGbt7DAMqRBGWthym5VkqyMh3HptO
         zgdf2a+xs63hRrDuZZimsuo5qs4jb2QrxoonN3FaKLe0lixn5ODAFDGO21u1WAdVEo
         n/6oNECvylFRoI1iaX+itl2qZA4O45m/KIV37AB+Q4sP2PMTrIjFt0Nqm1yDNxNJM8
         +DBdOXwKJrasg==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Dani Liberman <dliberman@habana.ai>
Subject: [PATCH 12/12] habanalabs: enable access to info ioctl during hard reset
Date:   Sun, 28 Nov 2021 21:34:35 +0200
Message-Id: <20211128193435.266534-12-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211128193435.266534-1-ogabbay@kernel.org>
References: <20211128193435.266534-1-ogabbay@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dani Liberman <dliberman@habana.ai>

Because info ioctl is used to retrieve data, some of its opcodes may be
used during hard reset.
Other ioctls should be blocked while device is not operational.

Signed-off-by: Dani Liberman <dliberman@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/common/command_submission.c | 5 +----
 drivers/misc/habanalabs/common/habanalabs_ioctl.c   | 7 -------
 2 files changed, 1 insertion(+), 11 deletions(-)

diff --git a/drivers/misc/habanalabs/common/command_submission.c b/drivers/misc/habanalabs/common/command_submission.c
index 7a277f442207..8be547b0926c 100644
--- a/drivers/misc/habanalabs/common/command_submission.c
+++ b/drivers/misc/habanalabs/common/command_submission.c
@@ -1146,9 +1146,6 @@ static int hl_cs_sanity_checks(struct hl_fpriv *hpriv, union hl_cs_args *args)
 	enum hl_cs_type cs_type;
 
 	if (!hl_device_operational(hdev, &status)) {
-		dev_warn_ratelimited(hdev->dev,
-			"Device is %s. Can't submit new CS\n",
-			hdev->status[status]);
 		return -EBUSY;
 	}
 
@@ -2997,7 +2994,7 @@ int hl_wait_ioctl(struct hl_fpriv *hpriv, void *data)
 	 * user interrupt
 	 */
 	if (!hl_device_operational(hpriv->hdev, NULL))
-		return -EPERM;
+		return -EBUSY;
 
 	if (flags & HL_WAIT_CS_FLAGS_INTERRUPT)
 		rc = hl_interrupt_wait_ioctl(hpriv, data);
diff --git a/drivers/misc/habanalabs/common/habanalabs_ioctl.c b/drivers/misc/habanalabs/common/habanalabs_ioctl.c
index 15797d55b4e8..6c7339978bae 100644
--- a/drivers/misc/habanalabs/common/habanalabs_ioctl.c
+++ b/drivers/misc/habanalabs/common/habanalabs_ioctl.c
@@ -774,7 +774,6 @@ static long _hl_ioctl(struct file *filep, unsigned int cmd, unsigned long arg,
 		const struct hl_ioctl_desc *ioctl, struct device *dev)
 {
 	struct hl_fpriv *hpriv = filep->private_data;
-	struct hl_device *hdev = hpriv->hdev;
 	unsigned int nr = _IOC_NR(cmd);
 	char stack_kdata[128] = {0};
 	char *kdata = NULL;
@@ -783,12 +782,6 @@ static long _hl_ioctl(struct file *filep, unsigned int cmd, unsigned long arg,
 	u32 hl_size;
 	int retcode;
 
-	if (hdev->hard_reset_pending) {
-		dev_crit_ratelimited(dev,
-			"Device HARD reset pending! Please close FD\n");
-		return -ENODEV;
-	}
-
 	/* Do not trust userspace, use our own definition */
 	func = ioctl->func;
 
-- 
2.25.1

