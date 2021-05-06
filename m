Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 791A4374F9F
	for <lists+linux-kernel@lfdr.de>; Thu,  6 May 2021 08:53:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232840AbhEFGye (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 May 2021 02:54:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:49082 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230382AbhEFGyd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 May 2021 02:54:33 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 947C4610E7;
        Thu,  6 May 2021 06:53:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620284015;
        bh=AKgpspAqV8j/WiHK4jcuJFKka5jReeDMAUoRlLosmjI=;
        h=From:To:Cc:Subject:Date:From;
        b=jITTV+sd/3uPXBNUTNJMIdDibQ+TO3hA3lMGC9h7m+ZOvYRrzLqJiY3CHFJFIVthe
         iLPxzDoDOuNCl/tuOBDNMRpzCSfLX1bIUcggK62qkGJaUygG2dSmAsoj+g4jmmVYLR
         Ei1E6DaNH9govtR8qwWnhEKl+bfEAqtOU5NcXtwA0QT12bcTIYJhs4EdrSRHR7+QXN
         YfaMxQN4jlXl24Mreh09b2t7eAlW2Qrk+AbJLinbbUMLOGAQdWaDDPCV6w02ILNbbN
         kdBnil8wA/WRL0OlMvYmQxa1yGnOnQfJq/9lFXsoRDl4xurc4rvNN6TvPGko5NEX+t
         w9Jpt+jyKx5xw==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ohad Sharabi <osharabi@habana.ai>
Subject: [PATCH 1/3] habanalabs: avoid using uninitialized pointer
Date:   Thu,  6 May 2021 09:53:28 +0300
Message-Id: <20210506065330.9626-1-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ohad Sharabi <osharabi@habana.ai>

When attempting to read FW component's version we should break if input
FW component is invalid in order to avoid using uninitialized
destination pointer.

Signed-off-by: Ohad Sharabi <osharabi@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/common/firmware_if.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/misc/habanalabs/common/firmware_if.c b/drivers/misc/habanalabs/common/firmware_if.c
index 5ab755a2e95f..ad9bfa096bf9 100644
--- a/drivers/misc/habanalabs/common/firmware_if.c
+++ b/drivers/misc/habanalabs/common/firmware_if.c
@@ -1565,6 +1565,7 @@ static void hl_fw_dynamic_read_device_fw_version(struct hl_device *hdev,
 		break;
 	default:
 		dev_warn(hdev->dev, "Undefined FW component: %d\n", fwc);
+		return;
 	}
 
 	strscpy(dest, fw_version, VERSION_MAX_LEN);
-- 
2.25.1

