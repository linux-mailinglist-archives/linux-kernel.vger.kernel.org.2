Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08E2C3C6BC4
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jul 2021 09:52:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234512AbhGMHzf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jul 2021 03:55:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:40684 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234457AbhGMHz0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jul 2021 03:55:26 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 83E0861279
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jul 2021 07:52:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626162757;
        bh=pj9M+aVBOKM7YjcqIYvtzXYVqoWm9hu+44Gn+WTVVho=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=JRXEfoqkxgui2V37UewY2ymMiEIrwZdFhS+ov+BVGvBkB6XFqlGhnMdu8m70tZ8jK
         gPqtmrLrty3vR003u6bdTCU9U/31AhyA0MlHf/88TpWos+9LHGNpNNtjUOmVbDSN2Q
         m9g5Xjb2lb/KgCyuVkA57JhThFYhOVcBHQsb3TYxjtywpCc/aZ8bncXlB1X2XdD2Pt
         0Y+q73+/6Kd4pwpaxCzOTvRFrCL+8lYJ/OgDlyu2qs4RC+rJVGsF/SLU84IBAQZgo/
         ANIHUvKncP5ZHZ1MIjxe9QNtISNkr0Qy1qiZNv917/iLcs46z0z+rbjC2KiUjd2+n3
         FzplUBda7GIXA==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Subject: [PATCH 06/11] habanalabs: revise prints on FD close
Date:   Tue, 13 Jul 2021 10:52:21 +0300
Message-Id: <20210713075226.11094-6-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210713075226.11094-1-ogabbay@kernel.org>
References: <20210713075226.11094-1-ogabbay@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver quietly handles memory mappings that were not freed so no
need to print a warning about that when user closes the FD.

Accordingly, revise the text that is printed in case the device is
still in use after the user process closed the FD.

Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/common/device.c | 4 ++--
 drivers/misc/habanalabs/common/memory.c | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/misc/habanalabs/common/device.c b/drivers/misc/habanalabs/common/device.c
index b09bdd1d462f..4f76c7a51605 100644
--- a/drivers/misc/habanalabs/common/device.c
+++ b/drivers/misc/habanalabs/common/device.c
@@ -129,8 +129,8 @@ static int hl_device_release(struct inode *inode, struct file *filp)
 	hl_ctx_mgr_fini(hdev, &hpriv->ctx_mgr);
 
 	if (!hl_hpriv_put(hpriv))
-		dev_warn(hdev->dev,
-			"Device is still in use because there are live CS and/or memory mappings\n");
+		dev_notice(hdev->dev,
+			"User process closed FD but device still in use\n");
 
 	hdev->last_open_session_duration_jif =
 		jiffies - hdev->last_successful_open_jif;
diff --git a/drivers/misc/habanalabs/common/memory.c b/drivers/misc/habanalabs/common/memory.c
index a05d98db4857..efc460e9db5d 100644
--- a/drivers/misc/habanalabs/common/memory.c
+++ b/drivers/misc/habanalabs/common/memory.c
@@ -2126,7 +2126,7 @@ void hl_vm_ctx_fini(struct hl_ctx *ctx)
 	 * another side effect error
 	 */
 	if (!hdev->hard_reset_pending && !hash_empty(ctx->mem_hash))
-		dev_notice(hdev->dev,
+		dev_dbg(hdev->dev,
 			"user released device without removing its memory mappings\n");
 
 	hash_for_each_safe(ctx->mem_hash, i, tmp_node, hnode, node) {
-- 
2.25.1

