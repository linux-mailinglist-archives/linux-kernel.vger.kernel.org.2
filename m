Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6A31358821
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 17:22:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232039AbhDHPWw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 11:22:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:45332 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231995AbhDHPWv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 11:22:51 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 21E3961107;
        Thu,  8 Apr 2021 15:22:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617895360;
        bh=feiMcp+0J41KM6/0gN99D/MZvYMUvvktLMGVt6srsgE=;
        h=From:To:Cc:Subject:Date:From;
        b=OjX9F5HWXED/UMlTzRcJCvvcYPTkF+peYbtLhWv9ZB15tr83iLhmEShfWWufOAWOD
         GySy5tfL294KP2rudk4UXMV3TVk8xWio6BAX3SV0OdCQzkhUTLRBWPJRTqQCKPJ74g
         cpjyS3ZdSG4loP3G6NsxsGpY7+RWwbc7p3vTXGyP1WTIYNKEXeL+PEzAgXIIH3pNKq
         /3ZTg4qJcN59cUD5xuDjfR+CA+DIoR5vX1x6hrSrJk+lHTM5K8avJnK5zpNDcRBWMG
         4Yugh4N8ubIb07RAyHQammVbuWesHFnknNJr7rdMRJ9UYQU6dzv3EAdrKgfT470YKe
         0XZLqb/r5X4zw==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Tomer Tayar <ttayar@habana.ai>
Subject: [PATCH 1/7] habanalabs/gaudi: clear QM errors only if not in stop_on_err mode
Date:   Thu,  8 Apr 2021 18:22:28 +0300
Message-Id: <20210408152234.15383-1-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tomer Tayar <ttayar@habana.ai>

Clearing QM errors by the driver will prevent these H/W blocks from
stopping in case they are configured to stop on errors, so perform this
clearing only if this mode is not in use.

Signed-off-by: Tomer Tayar <ttayar@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/gaudi/gaudi.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/misc/habanalabs/gaudi/gaudi.c b/drivers/misc/habanalabs/gaudi/gaudi.c
index 03d3fb643e79..791434278904 100644
--- a/drivers/misc/habanalabs/gaudi/gaudi.c
+++ b/drivers/misc/habanalabs/gaudi/gaudi.c
@@ -7086,7 +7086,8 @@ static void gaudi_handle_qman_err_generic(struct hl_device *hdev,
 		}
 
 		/* Write 1 clear errors */
-		WREG32(glbl_sts_addr + 4 * i, glbl_sts_clr_val);
+		if (!hdev->stop_on_err)
+			WREG32(glbl_sts_addr + 4 * i, glbl_sts_clr_val);
 	}
 
 	arb_err_val = RREG32(arb_err_addr);
-- 
2.25.1

