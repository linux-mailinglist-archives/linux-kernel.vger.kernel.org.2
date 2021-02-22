Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E4D23221ED
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Feb 2021 23:06:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230426AbhBVWF7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Feb 2021 17:05:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:42454 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229967AbhBVWFy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Feb 2021 17:05:54 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id B010964DA8;
        Mon, 22 Feb 2021 22:05:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614031513;
        bh=3DBporj5bgL5GQOIf53BNFynYl1VAF4WTalHirbOcnw=;
        h=From:To:Cc:Subject:Date:From;
        b=XPwiQ7z35DRTOPAYen015g4tgDNdsMj7fzMJnA9MQ5UGmziKvrQqX1CQxMj3hiQbB
         50PchCdgzb0xR/lNL7k9jdXgxnPXr3rN8HsRBSLtChMBcPug3qX8ig2ENtD0dsmo7z
         4NdzUm4zLwSO0Y2hIEwYYDWNyRbzS3fVZAwmBIVi8K04W852DoAA2pwrZ3doLqtndw
         rVqiDFDEIOcBxAo+U1cOScF2sxtoWtpX+dFPdpNPfRYFZ1Sx989DDeiYFNzpgUEVzx
         TXOvuxrCVlJrOICl9Z6JHvAMGx0wY8MKTkbQGNKyQn/+yzo0BSWgz5fK0/elo3f2yk
         p32PlYBwaoBsw==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Tomer Tayar <ttayar@habana.ai>
Subject: [PATCH 1/2] habanalabs: Call put_pid() when releasing control device
Date:   Tue, 23 Feb 2021 00:05:07 +0200
Message-Id: <20210222220508.4659-1-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tomer Tayar <ttayar@habana.ai>

The refcount of the "hl_fpriv" structure is not used for the control
device, and thus hl_hpriv_put() is not called when releasing this
device.
This results with no call to put_pid(), so add it explicitly in
hl_device_release_ctrl().

Signed-off-by: Tomer Tayar <ttayar@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/common/device.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/misc/habanalabs/common/device.c b/drivers/misc/habanalabs/common/device.c
index 15fcb5c31c4b..9ecd805f0e88 100644
--- a/drivers/misc/habanalabs/common/device.c
+++ b/drivers/misc/habanalabs/common/device.c
@@ -117,6 +117,8 @@ static int hl_device_release_ctrl(struct inode *inode, struct file *filp)
 	list_del(&hpriv->dev_node);
 	mutex_unlock(&hdev->fpriv_list_lock);
 
+	put_pid(hpriv->taskpid);
+
 	kfree(hpriv);
 
 	return 0;
-- 
2.25.1

