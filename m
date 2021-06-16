Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57B533AA150
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 18:29:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235398AbhFPQbk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Jun 2021 12:31:40 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:47566 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234654AbhFPQbi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jun 2021 12:31:38 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <colin.king@canonical.com>)
        id 1ltYPh-0003ld-IQ; Wed, 16 Jun 2021 16:29:13 +0000
From:   Colin King <colin.king@canonical.com>
To:     Corey Minyard <minyard@acm.org>, Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        openipmi-developer@lists.sourceforge.net,
        linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] ipmi: kcs_bmc_aspeed: Fix less than zero comparison of a unsigned int
Date:   Wed, 16 Jun 2021 17:29:13 +0100
Message-Id: <20210616162913.15259-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

The comparisons of the unsigned int hw_type to less than zero always
false because it is unsigned. Fix this by using an int for the
assignment and less than zero check.

Addresses-Coverity: ("Unsigned compared against 0")
Fixes: 9d2df9a0ad80 ("ipmi: kcs_bmc_aspeed: Implement KCS SerIRQ configuration")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/char/ipmi/kcs_bmc_aspeed.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/char/ipmi/kcs_bmc_aspeed.c b/drivers/char/ipmi/kcs_bmc_aspeed.c
index 0401089f8895..92a37b33494c 100644
--- a/drivers/char/ipmi/kcs_bmc_aspeed.c
+++ b/drivers/char/ipmi/kcs_bmc_aspeed.c
@@ -301,13 +301,15 @@ static inline int aspeed_kcs_map_serirq_type(u32 dt_type)
 static int aspeed_kcs_config_upstream_irq(struct aspeed_kcs_bmc *priv, u32 id, u32 dt_type)
 {
 	unsigned int mask, val, hw_type;
+	int ret;
 
 	if (id > 15)
 		return -EINVAL;
 
-	hw_type = aspeed_kcs_map_serirq_type(dt_type);
-	if (hw_type < 0)
-		return hw_type;
+	ret = aspeed_kcs_map_serirq_type(dt_type);
+	if (ret < 0)
+		return ret;
+	hw_type = ret;
 
 	priv->upstream_irq.mode = aspeed_kcs_irq_serirq;
 	priv->upstream_irq.id = id;
-- 
2.31.1

