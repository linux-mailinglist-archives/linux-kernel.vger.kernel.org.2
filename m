Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1E9B31C2AA
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Feb 2021 20:54:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230021AbhBOTx7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Feb 2021 14:53:59 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:57244 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229919AbhBOTx4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Feb 2021 14:53:56 -0500
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1lBjvl-0006Fu-9X; Mon, 15 Feb 2021 19:53:13 +0000
From:   Colin King <colin.king@canonical.com>
To:     Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Ben Widawsky <ben.widawsky@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        linux-cxl@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] cxl/mem: remove redundant initialization of variable rc
Date:   Mon, 15 Feb 2021 19:53:13 +0000
Message-Id: <20210215195313.90231-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

The variable rc is being initialized with a value that is never read
and it is being updated later with a new value.  The initialization is
redundant and can be removed.

Addresses-Coverity: ("Unused value")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/cxl/mem.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
index 3bca8451348a..81e557a54fa4 100644
--- a/drivers/cxl/mem.c
+++ b/drivers/cxl/mem.c
@@ -383,8 +383,8 @@ static int __cxl_mem_mbox_send_cmd(struct cxl_mem *cxlm,
 static int cxl_mem_mbox_get(struct cxl_mem *cxlm)
 {
 	struct device *dev = &cxlm->pdev->dev;
-	int rc = -EBUSY;
 	u64 md_status;
+	int rc;
 
 	mutex_lock_io(&cxlm->mbox_mutex);
 
-- 
2.30.0

