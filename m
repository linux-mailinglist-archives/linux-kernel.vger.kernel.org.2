Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EC353FECE0
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Sep 2021 13:24:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245263AbhIBLZh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Sep 2021 07:25:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:34470 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233850AbhIBLZg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Sep 2021 07:25:36 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3AB1F610D2;
        Thu,  2 Sep 2021 11:24:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630581878;
        bh=FZ0cdgkDqG4n8DtLfCxM148cobtlQDmbbN+RENhk6bw=;
        h=From:To:Cc:Subject:Date:From;
        b=FvHVidk1R5rSq9wC2Q72M09Yc75Y8PyqxEItXNAbmpYxo8roBRQSoVUmkArPV4jSO
         WmiVuk7+RBC6//2PIm+xVPZxpo86FsiWI1zaszbnoGdmmIW+thi2nZQ7jggr0D5h1o
         0Qyo4Z4VIpPMIV7iMZQDdAXK3bQPBfvSnK8NRxV8je8u4uRbpXlaAEqVZmp3v7OwOs
         wWJvsvCgABYJ4fE48GhpYdaS/wlkRE9qPzJhLs7156Bnkh0ej9n3wtKWHRpH1tm8wP
         5gQ4oTJRGBuOnh1msshp2OLrAYrKb+e8llOtyD1nRgQUQwCR6DlFoDO9GPnWNPkbAJ
         c4JF2fTlIiF7Q==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ofir Bitton <obitton@habana.ai>
Subject: [PATCH] habanalabs: fail collective wait when not supported
Date:   Thu,  2 Sep 2021 14:24:33 +0300
Message-Id: <20210902112433.115139-1-ogabbay@kernel.org>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ofir Bitton <obitton@habana.ai>

As collective wait operation is required only when NIC ports are
available, we disable the option to submit a CS in case all the ports
are disabled, which is the current situation in the upstream driver.

Signed-off-by: Ofir Bitton <obitton@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/common/command_submission.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/misc/habanalabs/common/command_submission.c b/drivers/misc/habanalabs/common/command_submission.c
index deb080830ecb..5b7de857fbc1 100644
--- a/drivers/misc/habanalabs/common/command_submission.c
+++ b/drivers/misc/habanalabs/common/command_submission.c
@@ -1995,6 +1995,15 @@ static int cs_ioctl_signal_wait(struct hl_fpriv *hpriv, enum hl_cs_type cs_type,
 			goto free_cs_chunk_array;
 		}
 
+		if (!hdev->nic_ports_mask) {
+			atomic64_inc(&ctx->cs_counters.validation_drop_cnt);
+			atomic64_inc(&cntr->validation_drop_cnt);
+			dev_err(hdev->dev,
+				"Collective operations not supported when NIC ports are disabled");
+			rc = -EINVAL;
+			goto free_cs_chunk_array;
+		}
+
 		collective_engine_id = chunk->collective_engine_id;
 	}
 
-- 
2.17.1

