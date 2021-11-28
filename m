Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70FFA460971
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Nov 2021 20:36:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357555AbhK1TkH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Nov 2021 14:40:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237530AbhK1TiC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Nov 2021 14:38:02 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6140C061574
        for <linux-kernel@vger.kernel.org>; Sun, 28 Nov 2021 11:34:45 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 509C7B80D5D
        for <linux-kernel@vger.kernel.org>; Sun, 28 Nov 2021 19:34:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DF9BC53FC7
        for <linux-kernel@vger.kernel.org>; Sun, 28 Nov 2021 19:34:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638128082;
        bh=Y+MTVrHFYx/UtoUYUrIvExeMvnHaULbw8beFAYMmXCI=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=IGK/U2V3IfnfH8tc6W0F8HZG7Nbin8aSX4zs3879rLVElUvpaPkzDXJk42mFyIO1J
         za8KkskhNPOGxOBVLoE7OSu5I11/ufTiT1Wb6KPAca5BK+2v6M+CqxcTr/3QOcrB5E
         jwgK+vmpgMWjt0PGg+i2BilUmrnE19EeWICZNsT7YBjc3mpELZcjTYL+SyzGMvFEA9
         iWL67N00F1wcOjvvEUQLL6W8SEdpaKVyt2Pxm0yD8dkNjwhRXniQhLLbH7MIwN8h3n
         zkK0vpAS4cvfjqgj8VBgCc5Qc0tj1wiB7b+9EdwUS3xwqzm28UqECt4/TByNorKB9o
         Tbwksiu1oxLNQ==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Subject: [PATCH 03/12] habanalabs/gaudi: return EPERM on non hard-reset
Date:   Sun, 28 Nov 2021 21:34:26 +0200
Message-Id: <20211128193435.266534-3-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211128193435.266534-1-ogabbay@kernel.org>
References: <20211128193435.266534-1-ogabbay@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

GAUDI supports only hard-reset. Therefore, this function should
return an error of operation not permitted.

Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/gaudi/gaudi.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/misc/habanalabs/gaudi/gaudi.c b/drivers/misc/habanalabs/gaudi/gaudi.c
index 464d205a26ed..07e03d44930e 100644
--- a/drivers/misc/habanalabs/gaudi/gaudi.c
+++ b/drivers/misc/habanalabs/gaudi/gaudi.c
@@ -7821,12 +7821,8 @@ static void gaudi_print_fw_alive_info(struct hl_device *hdev,
 
 static int gaudi_non_hard_reset_late_init(struct hl_device *hdev)
 {
-	struct gaudi_device *gaudi = hdev->asic_specific;
-
-	/* Unmask all IRQs since some could have been received
-	 * during the soft reset
-	 */
-	return hl_fw_unmask_irq_arr(hdev, gaudi->events, sizeof(gaudi->events));
+	/* GAUDI doesn't support any reset except hard-reset */
+	return -EPERM;
 }
 
 static int gaudi_hbm_read_interrupts(struct hl_device *hdev, int device,
-- 
2.25.1

