Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D8D5370DB6
	for <lists+linux-kernel@lfdr.de>; Sun,  2 May 2021 17:52:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232331AbhEBPwi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 May 2021 11:52:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:42720 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230110AbhEBPwi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 May 2021 11:52:38 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E1BA960FE8;
        Sun,  2 May 2021 15:51:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619970706;
        bh=7pTUUplkZtil7djM3/ENcjlIfF7dz9jOahcRXy1juS8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lYsXtACSUm6Iw4zyUQ53jIRHGCXJLJhRNGNwdWXGOKSUtS/3ooYIXeUznaF14h2Jq
         OFaPYgwW/JkGz9MtH+MQt8HQLng+dnz1Od2yLJdP1An8cAvP0Jboe7QePMQpIZl/9K
         PCza/ouuuM+XUCime+zPB4SSDXBbi+RGkh4EiYs82cjcv0zN42kL39+L//FFWTXvXQ
         vijuieLClFgcA86bJWrE+AeH/ztLQabnLrKsnb14hi0RLK0jmq4jV2nxs8fgYe9Dxq
         Kzaupj/08I1BvbnObPxd7GlKjwmNIpYnWFu80Lc7Whg9jOsxxDjRDCBimqYFmi0FY8
         BIEqBiMV66i1Q==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Omer Shpigelman <oshpigelman@habana.ai>
Subject: [PATCH 2/4] habanalabs: add missing space after casting
Date:   Sun,  2 May 2021 18:51:38 +0300
Message-Id: <20210502155140.4359-2-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210502155140.4359-1-ogabbay@kernel.org>
References: <20210502155140.4359-1-ogabbay@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Omer Shpigelman <oshpigelman@habana.ai>

Change casting code according to kernel coding style.

Signed-off-by: Omer Shpigelman <oshpigelman@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/common/habanalabs_ioctl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/misc/habanalabs/common/habanalabs_ioctl.c b/drivers/misc/habanalabs/common/habanalabs_ioctl.c
index 33841c272eb6..6604d30246e6 100644
--- a/drivers/misc/habanalabs/common/habanalabs_ioctl.c
+++ b/drivers/misc/habanalabs/common/habanalabs_ioctl.c
@@ -95,7 +95,7 @@ static int hw_ip_info(struct hl_device *hdev, struct hl_info_args *args)
 	hw_ip.first_available_interrupt_id =
 			prop->first_available_user_msix_interrupt;
 	return copy_to_user(out, &hw_ip,
-		min((size_t)size, sizeof(hw_ip))) ? -EFAULT : 0;
+		min((size_t) size, sizeof(hw_ip))) ? -EFAULT : 0;
 }
 
 static int hw_events_info(struct hl_device *hdev, bool aggregate,
-- 
2.25.1

