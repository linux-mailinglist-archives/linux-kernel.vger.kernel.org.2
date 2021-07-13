Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DD4B3C6BC3
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jul 2021 09:52:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234492AbhGMHzd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jul 2021 03:55:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:40678 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234438AbhGMHzZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jul 2021 03:55:25 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 69FB661288
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jul 2021 07:52:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626162756;
        bh=Ze+aESCgA4jSep9yldh+YdEvJoyKEyQW7x0NKCvJlQI=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=nF6vE6qHn44vkPixIYYVEKbk6qv74PdnpVXpc2fQNUqbhLWSlSJ7a8v17Zf/cjT1H
         fxey9q8uyl7Caz1lThfsIr7xFgNk/pNhFNbw3m4GXzSoLXAoC79vQqgNnZJ+t7stpP
         kmE+WgAgR4TbQr66bOPazQCj/dthWLa74OflbnXPgB+I8pXlXfc+rPDi97PEtAuGcF
         ENlPvhvwRjrhSu2R8VqcTfnbzgZDiRiSJpUl8PA+MAZfzuhwszprHg5qRW/L0t11wy
         CdvsRCk53ivsb1MQOQRywKIe7SVRKIWkUW1oqNNEoDWL1PWp3degc/kPS3A8cLLWa/
         DWBoqGa257qog==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Subject: [PATCH 05/11] habanalabs/goya: add missing initialization
Date:   Tue, 13 Jul 2021 10:52:20 +0300
Message-Id: <20210713075226.11094-5-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210713075226.11094-1-ogabbay@kernel.org>
References: <20210713075226.11094-1-ogabbay@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Need to initialize f/w Linux loaded indication to false to prevent
wrong communication with the f/w.

Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/goya/goya.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/misc/habanalabs/goya/goya.c b/drivers/misc/habanalabs/goya/goya.c
index ae9871928369..c8d58dd2c041 100644
--- a/drivers/misc/habanalabs/goya/goya.c
+++ b/drivers/misc/habanalabs/goya/goya.c
@@ -2496,6 +2496,7 @@ static void goya_init_firmware_loader(struct hl_device *hdev)
 	struct fw_load_mgr *fw_loader = &hdev->fw_loader;
 
 	/* fill common fields */
+	fw_loader->linux_loaded = false;
 	fw_loader->boot_fit_img.image_name = GOYA_BOOT_FIT_FILE;
 	fw_loader->linux_img.image_name = GOYA_LINUX_FW_FILE;
 	fw_loader->cpu_timeout = GOYA_CPU_TIMEOUT_USEC;
-- 
2.25.1

