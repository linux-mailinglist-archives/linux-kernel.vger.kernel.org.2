Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A943D3221F5
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Feb 2021 23:10:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231429AbhBVWJl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Feb 2021 17:09:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:42824 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231301AbhBVWI4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Feb 2021 17:08:56 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id ABEA364E31
        for <linux-kernel@vger.kernel.org>; Mon, 22 Feb 2021 22:08:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614031696;
        bh=84akbg0ktj0V1VCqotQrjbm985DrQPR99JQBFqPSdD8=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=s0yLLyN/n/aHxzeMTvvqLC0jB+B8fsH2wN8eQaXNEvIzmA1HlUdQEDJT+E6MSTsn5
         fPEjDK3c+F6JZFcP9u/l0sXhxxLLp7bQ2H/NdKHijXz1nyfq3Ys9GsuqVMgMpiZqxa
         A9gELctPZW/67J2DKFZ6598SPJxBacVB2GaGwaoYPu5wdvV9jthGlxtNR57oSthGH1
         U3clusPFa9FL93RM3UawO4QVqie+IGo3CqIGhWnngAjGUjAR+Ouifqx8WJHpdLUiWr
         /nvcKbZ5TM8eZH6ODVvSpNWDluChgtar0pRVj+e26glfPcxAetC0Mg8O+4LKOXv3KA
         sPb7eb/qVMDlQ==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Subject: [PATCH 5/5] habanalabs: print if device is used on FD close
Date:   Tue, 23 Feb 2021 00:08:06 +0200
Message-Id: <20210222220806.9311-5-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210222220806.9311-1-ogabbay@kernel.org>
References: <20210222220806.9311-1-ogabbay@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Notify to the user that although he closed the FD, the device is
still in use because there are live CS and/or memory mappings (mmaps).

Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/common/device.c     | 8 +++++---
 drivers/misc/habanalabs/common/habanalabs.h | 2 +-
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/misc/habanalabs/common/device.c b/drivers/misc/habanalabs/common/device.c
index 48d301a03d62..6948a1c54083 100644
--- a/drivers/misc/habanalabs/common/device.c
+++ b/drivers/misc/habanalabs/common/device.c
@@ -80,9 +80,9 @@ void hl_hpriv_get(struct hl_fpriv *hpriv)
 	kref_get(&hpriv->refcount);
 }
 
-void hl_hpriv_put(struct hl_fpriv *hpriv)
+int hl_hpriv_put(struct hl_fpriv *hpriv)
 {
-	kref_put(&hpriv->refcount, hpriv_release);
+	return kref_put(&hpriv->refcount, hpriv_release);
 }
 
 /*
@@ -103,7 +103,9 @@ static int hl_device_release(struct inode *inode, struct file *filp)
 
 	filp->private_data = NULL;
 
-	hl_hpriv_put(hpriv);
+	if (!hl_hpriv_put(hpriv))
+		dev_warn(hdev->dev,
+			"Device is still in use because there are live CS and/or memory mappings\n");
 
 	return 0;
 }
diff --git a/drivers/misc/habanalabs/common/habanalabs.h b/drivers/misc/habanalabs/common/habanalabs.h
index 9ba48f322964..046bb44f70f9 100644
--- a/drivers/misc/habanalabs/common/habanalabs.h
+++ b/drivers/misc/habanalabs/common/habanalabs.h
@@ -2182,7 +2182,7 @@ int hl_device_resume(struct hl_device *hdev);
 int hl_device_reset(struct hl_device *hdev, bool hard_reset,
 			bool from_hard_reset_thread);
 void hl_hpriv_get(struct hl_fpriv *hpriv);
-void hl_hpriv_put(struct hl_fpriv *hpriv);
+int hl_hpriv_put(struct hl_fpriv *hpriv);
 int hl_device_set_frequency(struct hl_device *hdev, enum hl_pll_frequency freq);
 uint32_t hl_device_utilization(struct hl_device *hdev, uint32_t period_ms);
 
-- 
2.25.1

