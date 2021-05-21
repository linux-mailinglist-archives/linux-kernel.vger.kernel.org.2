Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B35C38CB88
	for <lists+linux-kernel@lfdr.de>; Fri, 21 May 2021 19:07:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237957AbhEURI2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 May 2021 13:08:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:44030 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237928AbhEURIY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 May 2021 13:08:24 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 45EA16023D;
        Fri, 21 May 2021 17:07:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621616821;
        bh=hYtJDG6j8nlWJUfJ2mZDNahCQw+QjbJBxSf2h8zRwfI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oOQY3NadA1iGj9wLi2W5KmAYeCKUafE3HsLD06L6lVd8TDVgR00/RH+9SapAo2sHK
         X+HJ4Dfb+mM8EoTVel2kPpM2kQzHq6JA+9f65nsprBZVKfvWBwM1PfTnzSNigXeITk
         GEWA+70KXGP8faGLYkf0rQ6oNq1RoNk8iQkuku+/yKxlRQY8gfcDyn4ut08Ex85v67
         Mk3W/i79bG1tc9P0D5Ms+ZM26+0XNAOlAA4Ntlp6e2Q0RU4uN70avmITBrpCh4CmZe
         3u63CeWCSD7MwkbFbEIbMUf6ZmwlX2M9xSBRjRsqzhXki812zr5RnWeM8R9MYg/Oo/
         O0BkEjgbQ6cCw==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Koby Elbaz <kelbaz@habana.ai>
Subject: [PATCH 3/4] habanalabs: read preboot status bits in an earlier stage
Date:   Fri, 21 May 2021 20:06:52 +0300
Message-Id: <20210521170653.4700-3-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210521170653.4700-1-ogabbay@kernel.org>
References: <20210521170653.4700-1-ogabbay@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Koby Elbaz <kelbaz@habana.ai>

On newer releases, host won't be able to trigger an interrupt directly
to the ASIC GIC controller.
To be able to decide whether GIC can/not be used, we must read device's
preboot status bits in a stage that precedes the possible first use of
GIC (when device is in dirty state).

Signed-off-by: Koby Elbaz <kelbaz@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/common/firmware_if.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/drivers/misc/habanalabs/common/firmware_if.c b/drivers/misc/habanalabs/common/firmware_if.c
index 17173020ff53..cdec7212f377 100644
--- a/drivers/misc/habanalabs/common/firmware_if.c
+++ b/drivers/misc/habanalabs/common/firmware_if.c
@@ -1159,8 +1159,6 @@ static int hl_fw_static_read_preboot_status(struct hl_device *hdev)
 	if (rc)
 		return rc;
 
-	hl_fw_preboot_update_state(hdev);
-
 	return 0;
 }
 
@@ -1189,6 +1187,8 @@ int hl_fw_read_preboot_status(struct hl_device *hdev, u32 cpu_boot_status_reg,
 	if (rc)
 		return rc;
 
+	hl_fw_preboot_update_state(hdev);
+
 	/* no need to read preboot status in dynamic load */
 	if (hdev->asic_prop.dynamic_fw_load)
 		return 0;
@@ -1864,9 +1864,6 @@ static int hl_fw_dynamic_load_image(struct hl_device *hdev,
 		hl_fw_boot_fit_update_state(hdev,
 				le32_to_cpu(dyn_regs->cpu_boot_dev_sts0),
 				le32_to_cpu(dyn_regs->cpu_boot_dev_sts1));
-	} else {
-		/* update state during preboot handshake */
-		hl_fw_preboot_update_state(hdev);
 	}
 
 	/* copy boot fit to space allocated by FW */
@@ -2097,9 +2094,6 @@ static int hl_fw_dynamic_init_cpu(struct hl_device *hdev,
 	}
 
 	if (!(hdev->fw_components & FW_TYPE_BOOT_CPU)) {
-		/* update the preboot state */
-		hl_fw_preboot_update_state(hdev);
-
 		rc = hl_fw_dynamic_request_descriptor(hdev, fw_loader, 0);
 		if (rc)
 			goto protocol_err;
-- 
2.25.1

