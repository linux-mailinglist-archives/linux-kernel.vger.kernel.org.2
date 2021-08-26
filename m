Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA1793F878B
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Aug 2021 14:32:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241003AbhHZMdk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Aug 2021 08:33:40 -0400
Received: from smtp-relay-canonical-0.canonical.com ([185.125.188.120]:40546
        "EHLO smtp-relay-canonical-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233929AbhHZMdj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Aug 2021 08:33:39 -0400
Received: from localhost (1.general.cking.uk.vpn [10.172.193.212])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 2F7133F110;
        Thu, 26 Aug 2021 12:32:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1629981171;
        bh=W0lg45bTtebDuSNmM32sWa9HP+79TQBsgPJFOHIQ2uA=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type;
        b=lD8wEaKfd529nx3M+PD9i8bBdLU0hteBGTOkJRJEqiRpfvALsaEmHWHs2vNN5efWA
         B7K9PyKQ++bcdodbEYVNw488anAvj16XN6eYkcisLF6fSMiZ3nIfLLevCDjrg+7f5q
         pRqjr3k/zIKCd6O3/tEdfTW60ulUpqEhM9I26084WrEnYumgQUfwJr5NDYPImwOqZn
         yI4V5f0BKKAu/3AEwdG25pNxi83n/1hdy/XFVPmL3PsVJm6wJ7c79E1Kj4mEaDgFBu
         WnCBYuFajap2OScCYcK2XInKY8L0BoIdftkOqMMVbD7WWuaalIILGEYrJv/5tSkpmW
         Hujs2aQAkK7Tw==
From:   Colin King <colin.king@canonical.com>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] mfd: ti_am335x_tscadc: Fix spelling mistake "atleast" -> "at least"
Date:   Thu, 26 Aug 2021 13:32:50 +0100
Message-Id: <20210826123250.14234-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

There is a spelling mistake in a dev_err message. Fix it.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/mfd/ti_am335x_tscadc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mfd/ti_am335x_tscadc.c b/drivers/mfd/ti_am335x_tscadc.c
index 55adc379f94b..825bd5884a18 100644
--- a/drivers/mfd/ti_am335x_tscadc.c
+++ b/drivers/mfd/ti_am335x_tscadc.c
@@ -158,7 +158,7 @@ static	int ti_tscadc_probe(struct platform_device *pdev)
 		return -EINVAL;
 	}
 	if (total_channels == 0) {
-		dev_err(&pdev->dev, "Need atleast one channel.\n");
+		dev_err(&pdev->dev, "Need at least one channel.\n");
 		return -EINVAL;
 	}
 
-- 
2.32.0

