Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF1D031D1D9
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Feb 2021 22:08:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230248AbhBPVHY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Feb 2021 16:07:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:39014 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230142AbhBPVHW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Feb 2021 16:07:22 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 77FBE64DFF;
        Tue, 16 Feb 2021 21:06:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613509602;
        bh=shEHp5/q7ki/y4rElUTq0ZQrpUqBhc9CTq5LH/U/T3A=;
        h=From:To:Cc:Subject:Date:From;
        b=jgE2WxObCUPnGypO1VSpvNumCF0jtiUWIwgwoKwUWnLJTLO7cDjxvb+OqQrhw4+km
         2JAWQSZcRK0BvX7C7NqbGZMAkSqjCUlytQxxcPgmNi9zAWvwItyAVlR7gCJV7ZMUZf
         MURqyIjUGoC/knb/ci54coF4z6wBbIHM5AIVL6WDtYoVH3o4jzObmV7RLl4U0DOll9
         dxd5VOJBUF8UhdBMrFqxsLzWjrCvuwSytekraXeHav+zgk8llV84r2iBD4Ogt72erN
         1BRl9984YW6LyFhMxrsZcVbO1ZbBXVRx9VcHOMiCGIzdAZzdIM78kLPJkB+I5K+nIJ
         +AZUB39dEVukw==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     farah kassabri <fkassabri@habana.ai>
Subject: [PATCH] habanalabs: set max asid to 2
Date:   Tue, 16 Feb 2021 23:06:36 +0200
Message-Id: <20210216210636.30472-1-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: farah kassabri <fkassabri@habana.ai>

currently we support only 2 asids in all asics.
asid 0 for driver, and asic 1 for user.
no need to setup 1024 asids configurations at init phase.

Signed-off-by: farah kassabri <fkassabri@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/include/gaudi/gaudi.h | 2 +-
 drivers/misc/habanalabs/include/goya/goya.h   | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/misc/habanalabs/include/gaudi/gaudi.h b/drivers/misc/habanalabs/include/gaudi/gaudi.h
index f9ea897ae42c..ffae107b1693 100644
--- a/drivers/misc/habanalabs/include/gaudi/gaudi.h
+++ b/drivers/misc/habanalabs/include/gaudi/gaudi.h
@@ -38,7 +38,7 @@
 
 #define QMAN_PQ_ENTRY_SIZE	16			/* Bytes */
 
-#define MAX_ASID		1024
+#define MAX_ASID		2
 
 #define PROT_BITS_OFFS		0xF80
 
diff --git a/drivers/misc/habanalabs/include/goya/goya.h b/drivers/misc/habanalabs/include/goya/goya.h
index 43d241891e45..1b4ca435021d 100644
--- a/drivers/misc/habanalabs/include/goya/goya.h
+++ b/drivers/misc/habanalabs/include/goya/goya.h
@@ -30,7 +30,7 @@
 
 #define QMAN_PQ_ENTRY_SIZE	16			/* Bytes */
 
-#define MAX_ASID		1024
+#define MAX_ASID		2
 
 #define PROT_BITS_OFFS		0xF80
 
-- 
2.25.1

