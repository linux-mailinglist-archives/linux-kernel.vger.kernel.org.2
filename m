Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5065D427FFB
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Oct 2021 10:03:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231192AbhJJIFW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Oct 2021 04:05:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:52198 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230370AbhJJIFN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Oct 2021 04:05:13 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 529AC60F43
        for <linux-kernel@vger.kernel.org>; Sun, 10 Oct 2021 08:03:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633852995;
        bh=4j3Q3Q67m4z5ngZKKw7lXQHB2NcDv4iKWt3iXtCd4tY=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=RwuDdbG1Eh48nb1rh5yJPZxbOF/XREAi6f3PvFlp7gbroSAxA/IoNlaVpzOU/X8KB
         9YEuY9i68y/fNB/V1678A2XK2WfV+KcBbDZDQDLIXCbfqKWDsSIqT/74KXoG63Rqko
         L8cv68SyG/VXPNRzPJ4vAzgT769mBE9SZoQWdfYVyyiEPiYwAT8J8tumUZaz/pLQfd
         8o9ukxTTVsXt5kKFU7n8+3JIHF7Sll+j1I+rE4LviGjKYiBLRpo+1sHPEih1Z1do7X
         BK3VtUBP5BHk+K+MXG4OQlyROGC0L/Prx0mBHbD7CjSpY2ZvaiWYyV/xL8vo80GVdn
         w0eq6rwfwCroA==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Subject: [PATCH 3/5] habanalabs: use only u32
Date:   Sun, 10 Oct 2021 11:03:05 +0300
Message-Id: <20211010080307.153420-3-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211010080307.153420-1-ogabbay@kernel.org>
References: <20211010080307.153420-1-ogabbay@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the kernel it is common to use u32 and not uint32_t.

Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/gaudi/gaudi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/misc/habanalabs/gaudi/gaudi.c b/drivers/misc/habanalabs/gaudi/gaudi.c
index 70a668951ec4..654f7959c5ad 100644
--- a/drivers/misc/habanalabs/gaudi/gaudi.c
+++ b/drivers/misc/habanalabs/gaudi/gaudi.c
@@ -2616,7 +2616,7 @@ static void gaudi_init_e2e(struct hl_device *hdev)
 
 static void gaudi_init_hbm_cred(struct hl_device *hdev)
 {
-	uint32_t hbm0_wr, hbm1_wr, hbm0_rd, hbm1_rd;
+	u32 hbm0_wr, hbm1_wr, hbm0_rd, hbm1_rd;
 
 	if (hdev->asic_prop.fw_security_enabled)
 		return;
-- 
2.25.1

