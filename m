Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15FCA362EBF
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Apr 2021 11:07:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235956AbhDQJHO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Apr 2021 05:07:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:37376 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235936AbhDQJHL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Apr 2021 05:07:11 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D831B61208;
        Sat, 17 Apr 2021 09:06:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618650405;
        bh=uKdZ9096WedMn0fGdv5esdMCoTBg8marcuGz+RgKCxQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dT+Xot4vHZgRsWTOyfgrKsKult+MKWNjC6AjOKSKFwnj07VtFWO40oFk4LKRnjLZJ
         RZ65c5fXVd/UpmxI72xTuAya7WJxDrJWa57ksx7FRa7yYdYJh171d+9V7ecC4/6eQ3
         3wF6tNGzNwZhnb+YHGeUvshZAI6CsyhVtSQ4QGCjqB9GoGvSbUpfI6BS1+VADVUxy3
         eG3Zqp27X4xxLFPYmEfolKBKs3Ta1sSa0VcelAfA3Hy7NJNjJu/08ARJ/9aOCb5pRv
         p8iN1VUBTWLqWsIUaXt6W+ZS/wPCZ+eDhimjCCrhJSFIORIsSspdqD7tuNSiKAbvAR
         pY2u22Tepm9Ew==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Moti Haimovski <mhaimovski@habana.ai>
Subject: [PATCH 2/7] habanalabs: increase ELBI reset timeout for PLDM
Date:   Sat, 17 Apr 2021 12:06:33 +0300
Message-Id: <20210417090638.9802-2-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210417090638.9802-1-ogabbay@kernel.org>
References: <20210417090638.9802-1-ogabbay@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Moti Haimovski <mhaimovski@habana.ai>

On PLDM, in case of NIC hangs, the ELBI reset to take much longer than
expected. As a result an increase in the ELBI reset timeout is required.

Signed-off-by: Moti Haimovski <mhaimovski@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/common/pci/pci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/misc/habanalabs/common/pci/pci.c b/drivers/misc/habanalabs/common/pci/pci.c
index e941b7eef346..5d07ca53d9ce 100644
--- a/drivers/misc/habanalabs/common/pci/pci.c
+++ b/drivers/misc/habanalabs/common/pci/pci.c
@@ -10,7 +10,7 @@
 
 #include <linux/pci.h>
 
-#define HL_PLDM_PCI_ELBI_TIMEOUT_MSEC	(HL_PCI_ELBI_TIMEOUT_MSEC * 10)
+#define HL_PLDM_PCI_ELBI_TIMEOUT_MSEC	(HL_PCI_ELBI_TIMEOUT_MSEC * 100)
 
 #define IATU_REGION_CTRL_REGION_EN_MASK		BIT(31)
 #define IATU_REGION_CTRL_MATCH_MODE_MASK	BIT(30)
-- 
2.25.1

