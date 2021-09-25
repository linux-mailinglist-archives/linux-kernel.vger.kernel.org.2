Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5601A418385
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Sep 2021 19:17:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229584AbhIYRTX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Sep 2021 13:19:23 -0400
Received: from smtp-relay-canonical-0.canonical.com ([185.125.188.120]:42470
        "EHLO smtp-relay-canonical-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229511AbhIYRTW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Sep 2021 13:19:22 -0400
Received: from localhost (1.general.cking.uk.vpn [10.172.193.212])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id BBAD640CE6;
        Sat, 25 Sep 2021 17:17:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1632590263;
        bh=ziAcocGSVqGXW27YqpXhhwM0YAMQ6EikLPC0ewIk9tc=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type;
        b=XfDqICqra0sQV9rnAxO73553HALDp4+lCfvExSa4mkmYtbojiAIavu/uVb4hD4JlH
         hpFoR1eV9ToSn2izRf+W1OKku+0Yu8ym/0NJdSEf+op3u3azII8ZkMoWuqpNZVZiLG
         p8KV9RokijZVRRXY39G0T6XQRs2j96xPD+mI6gHPAsD9jKVJYPdLqnywQTqNRp3nAg
         cRFkuXGMupitsF/RvDKlbd4hljeblyhcecwQDpIbfqDhg2qAHpqZInYWbfef2orKTd
         2ZZ1kBHq3TYkfN+Boi3m16xjXW3wHLiublc5wMTvkGrmJ7mn9QhiZJ6QxtAAitsGpb
         VzMTUZIpd/B4g==
From:   Colin King <colin.king@canonical.com>
To:     Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] platform/chrome: cros_ec: Fix spelling mistake "responsed" -> "response"
Date:   Sat, 25 Sep 2021 18:17:43 +0100
Message-Id: <20210925171743.173219-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

There are spelling mistakes in dev_warn messages. Fix them.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/platform/chrome/cros_ec_lpc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/platform/chrome/cros_ec_lpc.c b/drivers/platform/chrome/cros_ec_lpc.c
index 1f7861944044..d6306d2a096f 100644
--- a/drivers/platform/chrome/cros_ec_lpc.c
+++ b/drivers/platform/chrome/cros_ec_lpc.c
@@ -156,7 +156,7 @@ static int cros_ec_pkt_xfer_lpc(struct cros_ec_device *ec,
 	cros_ec_lpc_ops.write(EC_LPC_ADDR_HOST_CMD, 1, &sum);
 
 	if (ec_response_timed_out()) {
-		dev_warn(ec->dev, "EC responsed timed out\n");
+		dev_warn(ec->dev, "EC response timed out\n");
 		ret = -EIO;
 		goto done;
 	}
@@ -238,7 +238,7 @@ static int cros_ec_cmd_xfer_lpc(struct cros_ec_device *ec,
 	cros_ec_lpc_ops.write(EC_LPC_ADDR_HOST_CMD, 1, &sum);
 
 	if (ec_response_timed_out()) {
-		dev_warn(ec->dev, "EC responsed timed out\n");
+		dev_warn(ec->dev, "EC response timed out\n");
 		ret = -EIO;
 		goto done;
 	}
-- 
2.32.0

