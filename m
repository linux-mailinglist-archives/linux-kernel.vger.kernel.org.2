Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15726358829
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 17:23:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232165AbhDHPXL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 11:23:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:45404 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232076AbhDHPW5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 11:22:57 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 02FC261108
        for <linux-kernel@vger.kernel.org>; Thu,  8 Apr 2021 15:22:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617895366;
        bh=GaRbCgCsvK3DfUsZMMjXN8yr4n/ouqYcuPrX1sSqzTA=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=bqhQ3GspRW0MnSaLWxSvxyQxhTd4t6QE+N5AFJo3zs+UGT81yuUFPwH0rSJhb39gf
         NOU7FjiVRpouDxLZz39Wlmi2SE3lvlgtJtiR81eMiuAJqH46/Mi2eh57j0VhiIaFtV
         eAz0rhoHzEydWU56E+G3gNGvIev+7csnaFIF7AuXY3bTcnXolqvshO6tP4h3F8EVZe
         2ld+pN28aY6hd5S+Ham7vY2dcfRvkZrtdVmu+L2h8wkQUP3IpRz+5OSbOQ5DiF3xvD
         DGB4dG3N8K+Uwd1CMCMJlmCV0mZcePZtMXOV2UZmtvRwznMplSOe1ZLNGjGwKSJ/ER
         /uvWU9pQ1pw6Q==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Subject: [PATCH 6/7] habanalabs: print on f/w boot unknown error
Date:   Thu,  8 Apr 2021 18:22:33 +0300
Message-Id: <20210408152234.15383-6-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210408152234.15383-1-ogabbay@kernel.org>
References: <20210408152234.15383-1-ogabbay@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We need to print a message to the kernel log in case we encounter
an unknown error in the f/w boot to help the user understand what
happened.

Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/common/firmware_if.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/misc/habanalabs/common/firmware_if.c b/drivers/misc/habanalabs/common/firmware_if.c
index 652571d3b8e6..4c096b6132b5 100644
--- a/drivers/misc/habanalabs/common/firmware_if.c
+++ b/drivers/misc/habanalabs/common/firmware_if.c
@@ -351,8 +351,12 @@ static int fw_read_errors(struct hl_device *hdev, u32 boot_err0_reg,
 		dev_dbg(hdev->dev, "Device security status %#x\n",
 				security_val);
 
-	if (err_val & ~CPU_BOOT_ERR0_ENABLED)
+	if (err_val & ~CPU_BOOT_ERR0_ENABLED) {
+		dev_err(hdev->dev,
+			"Device boot error - unknown error 0x%08x\n",
+			err_val);
 		return -EIO;
+	}
 
 	return 0;
 }
-- 
2.25.1

