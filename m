Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB0A13F87A5
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Aug 2021 14:37:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242091AbhHZMi3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Aug 2021 08:38:29 -0400
Received: from smtp-relay-canonical-1.canonical.com ([185.125.188.121]:56148
        "EHLO smtp-relay-canonical-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241261AbhHZMiX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Aug 2021 08:38:23 -0400
Received: from localhost (1.general.cking.uk.vpn [10.172.193.212])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id BD0673F245;
        Thu, 26 Aug 2021 12:37:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1629981455;
        bh=8sFGVg+g2UkWDPsJWhC3mA0fD7X/I5c9eQbr5g4WoBs=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type;
        b=vKmFcEbilp8tNcVPatyFCMn1BJvAoxsUhtxrZRVp3WwbGu9UBkoBcu2NTcS84FJta
         YwcAHgHJxwgSc5BiXVoMedGXmTJkEO/7+vShI63pPKYFA/EZsVqlixmOs6yiwyaLzz
         RoOkbN72JKLtoPBGhuXQfCt8MrPChIi5zgz+HX0o2dKbgJZdlhr223MBzPw5jStObQ
         nPTmT/pyIQdlqQh2PMDf+ckQVS0y1rh7KbM4pbGNrvyEcaPUtGT75XkRe9VLD3EaC2
         UhOyr8qXtfBITPpBPOVd7QBaJnHpcHeVgNfTvUcaaaH0WuDN/mtH1f+h62qoTU0XBO
         3H296puhfnZEw==
From:   Colin King <colin.king@canonical.com>
To:     Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        linux-remoteproc@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] remoteproc: Fix spelling mistake "atleast" -> "at least"
Date:   Thu, 26 Aug 2021 13:37:35 +0100
Message-Id: <20210826123735.14650-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

There are spelling mistakes dev_err messages. Fix them.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/remoteproc/ti_k3_dsp_remoteproc.c | 2 +-
 drivers/remoteproc/ti_k3_r5_remoteproc.c  | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/remoteproc/ti_k3_dsp_remoteproc.c b/drivers/remoteproc/ti_k3_dsp_remoteproc.c
index fd4eb67a6681..c352fa277c8d 100644
--- a/drivers/remoteproc/ti_k3_dsp_remoteproc.c
+++ b/drivers/remoteproc/ti_k3_dsp_remoteproc.c
@@ -481,7 +481,7 @@ static int k3_dsp_reserved_mem_init(struct k3_dsp_rproc *kproc)
 		return -EINVAL;
 	}
 	if (num_rmems < 2) {
-		dev_err(dev, "device needs atleast two memory regions to be defined, num = %d\n",
+		dev_err(dev, "device needs at least two memory regions to be defined, num = %d\n",
 			num_rmems);
 		return -EINVAL;
 	}
diff --git a/drivers/remoteproc/ti_k3_r5_remoteproc.c b/drivers/remoteproc/ti_k3_r5_remoteproc.c
index 71615210df3e..6499302d00c3 100644
--- a/drivers/remoteproc/ti_k3_r5_remoteproc.c
+++ b/drivers/remoteproc/ti_k3_r5_remoteproc.c
@@ -876,7 +876,7 @@ static int k3_r5_reserved_mem_init(struct k3_r5_rproc *kproc)
 		return -EINVAL;
 	}
 	if (num_rmems < 2) {
-		dev_err(dev, "device needs atleast two memory regions to be defined, num = %d\n",
+		dev_err(dev, "device needs at least two memory regions to be defined, num = %d\n",
 			num_rmems);
 		return -EINVAL;
 	}
-- 
2.32.0

