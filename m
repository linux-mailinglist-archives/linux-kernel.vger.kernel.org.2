Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7F633A187D
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 17:05:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234093AbhFIPGC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 11:06:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:38502 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238778AbhFIPFq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 11:05:46 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C5A29613B6;
        Wed,  9 Jun 2021 15:03:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623251031;
        bh=Epw43BF4LFZ/FEJytp7FHyygmZuvMgML8oDthp/kvMU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bED8ji/ohW2OrFOrLxNrIWku6ES7fnDd9m1CU4oyl/1jN/YwznHGLugv1XwJJ/EYa
         GmRW9vLXdjarmBhYZRguHHoAh4Mcby5M8msCtuSWh0/FOR3B6XkQYxv4W50qSn40DR
         tVZUUCOpbov1Jlf5rh4rWVQmg/iEa53AJVM+mc8vFoAFsehdmkLgkchdd+4UFaEMMF
         lV5CHGeWYHkt2VjGBQzDsMq5vLnhrfZWskz3q1sFN4ly0BkbTrlgze6Xva3LbyywCi
         1QEX5V4r+3Dj5TqV/1iG1zjv3BkHKNrKnRZfnLACXJdaBkIXbwBcgRjsJHzVLnhbW3
         ZqIHpmM42E56g==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ofir Bitton <obitton@habana.ai>
Subject: [PATCH 4/7] habanalabs: enable stop on error for all QMANs and engines
Date:   Wed,  9 Jun 2021 18:03:40 +0300
Message-Id: <20210609150343.4712-4-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210609150343.4712-1-ogabbay@kernel.org>
References: <20210609150343.4712-1-ogabbay@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ofir Bitton <obitton@habana.ai>

If there is an error in the QMAN/engine, there is no point of trying
to continue running the workload. It is better to stop to allow the
user to debug the program.

Signed-off-by: Ofir Bitton <obitton@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/common/habanalabs_drv.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/misc/habanalabs/common/habanalabs_drv.c b/drivers/misc/habanalabs/common/habanalabs_drv.c
index b55dd1c55166..3a4233971f2b 100644
--- a/drivers/misc/habanalabs/common/habanalabs_drv.c
+++ b/drivers/misc/habanalabs/common/habanalabs_drv.c
@@ -326,6 +326,7 @@ int create_hdev(struct hl_device **dev, struct pci_dev *pdev,
 	hdev->reset_on_lockup = reset_on_lockup;
 	hdev->memory_scrub = memory_scrub;
 	hdev->boot_error_status_mask = boot_error_status_mask;
+	hdev->stop_on_err = true;
 
 	hdev->pldm = 0;
 
-- 
2.25.1

