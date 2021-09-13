Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42FCA408E37
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Sep 2021 15:31:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242334AbhIMNcR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Sep 2021 09:32:17 -0400
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:34278
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241742AbhIMNZ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Sep 2021 09:25:29 -0400
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com [209.85.221.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 1716D4027C
        for <linux-kernel@vger.kernel.org>; Mon, 13 Sep 2021 13:21:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1631539261;
        bh=dm7SJ/bHwjEDyQ2RFr3SYt5wwlTFgyi3tJxfnWGO4aU=;
        h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=TMNZbVo/ucn+tm2cE6ewKpKu1dOdxN+bJ4vpN2WG9IG4Z13hspFtogObidA4p/1KA
         V8EuHGqNih+eIh6uZcR8mxLfGazJcT7QuTj79uuJtlIPffmRtmX1iJEOOLk9moueji
         wR+vmwd82wLrHb7556CMHWFH1vEGVtZ2++5UZE+z2TWO1+eCYhM5VWldsPXarY4s3v
         +cslvJKrfd1Y89sXqsSOFWtsm6RQAziqPvkEyWYffwWCqOO46V6ZVibhB3Qy0Wp2jJ
         lvHuIcWi+vvS9e3v/2d7k/lzJtoZp769B9bjXvMxk1JJm5zelMMFu+7QRtEET1Yy/E
         YxIa3AmY81z3g==
Received: by mail-wr1-f72.google.com with SMTP id u30-20020adfa19e000000b00159aba4fe42so2659139wru.9
        for <linux-kernel@vger.kernel.org>; Mon, 13 Sep 2021 06:21:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dm7SJ/bHwjEDyQ2RFr3SYt5wwlTFgyi3tJxfnWGO4aU=;
        b=AEt3s6sRXaJRo7J9W5wiMCviuDeAuCh9/8di1xs9xtHid2W8CI86XcHoafL3aZLngV
         cGoFitwNZkRZNhbKuYoi2RuMYPVQgyD5XzFFwbwrpj6ngtt9sG2DnnBCuEi2q5sv6Rbu
         EJtn3IL5nWnKppUSdfbq4deVMEFBxuZAd92OJw79RCY8gMcl2VYgYEqaBYK/oPbRMWA+
         jVozralf6A4rSF7Jq+kZnESbxYVHhG+M9DSYtcXBmrRPh9l6ic7OC6QsvIs5KW8SpRqX
         eO3ugiuxMZdnjAsVIQe4HfHyjCqYKYzr1YpkY8HJpI9qoyqAl+CrkXT1h49VjGH4RU/1
         3X/g==
X-Gm-Message-State: AOAM531NqmXrMW2GxlaBJjaOAJ842Dldc2GQCStocV6d8xEg164pks3t
        +DHbQTxxiCzfKF8ZVFUdsCVFB2j0f7aX2f54jNSoUKnFd3jrm+pbbZ3NtZsgW+0q1pgwikUawIj
        0DfC146haJk3gAvDc+H9RS8GqwdtRGymYHGJAOj819g==
X-Received: by 2002:a5d:4388:: with SMTP id i8mr6660939wrq.340.1631539260783;
        Mon, 13 Sep 2021 06:21:00 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw9b4kSBhCL6DUt+xU/J4y6fvbkwU0tPTRSWx11ig4nLHeusihi+/2ld4uYaI4hNRQ5P+6GUw==
X-Received: by 2002:a5d:4388:: with SMTP id i8mr6660910wrq.340.1631539260586;
        Mon, 13 Sep 2021 06:21:00 -0700 (PDT)
Received: from kozik-lap.lan (lk.84.20.244.219.dc.cable.static.lj-kabel.net. [84.20.244.219])
        by smtp.gmail.com with ESMTPSA id n3sm7195888wmi.0.2021.09.13.06.20.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Sep 2021 06:20:57 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Krzysztof Opasiak <k.opasiak@samsung.com>,
        Mark Greer <mgreer@animalcreek.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, linux-nfc@lists.01.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-wireless@vger.kernel.org
Subject: [PATCH v2 10/15] nfc: st-nci: drop unneeded debug prints
Date:   Mon, 13 Sep 2021 15:20:30 +0200
Message-Id: <20210913132035.242870-11-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210913132035.242870-1-krzysztof.kozlowski@canonical.com>
References: <20210913132035.242870-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ftrace is a preferred and standard way to debug entering and exiting
functions so drop useless debug prints.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 drivers/nfc/st-nci/i2c.c  | 4 ----
 drivers/nfc/st-nci/ndlc.c | 4 ----
 drivers/nfc/st-nci/se.c   | 6 ------
 drivers/nfc/st-nci/spi.c  | 4 ----
 4 files changed, 18 deletions(-)

diff --git a/drivers/nfc/st-nci/i2c.c b/drivers/nfc/st-nci/i2c.c
index ccf6152ebb9f..cbd968f013c7 100644
--- a/drivers/nfc/st-nci/i2c.c
+++ b/drivers/nfc/st-nci/i2c.c
@@ -157,7 +157,6 @@ static int st_nci_i2c_read(struct st_nci_i2c_phy *phy,
 static irqreturn_t st_nci_irq_thread_fn(int irq, void *phy_id)
 {
 	struct st_nci_i2c_phy *phy = phy_id;
-	struct i2c_client *client;
 	struct sk_buff *skb = NULL;
 	int r;
 
@@ -166,9 +165,6 @@ static irqreturn_t st_nci_irq_thread_fn(int irq, void *phy_id)
 		return IRQ_NONE;
 	}
 
-	client = phy->i2c_dev;
-	dev_dbg(&client->dev, "IRQ\n");
-
 	if (phy->ndlc->hard_fault)
 		return IRQ_HANDLED;
 
diff --git a/drivers/nfc/st-nci/ndlc.c b/drivers/nfc/st-nci/ndlc.c
index e9dc313b333e..755460a73c0d 100644
--- a/drivers/nfc/st-nci/ndlc.c
+++ b/drivers/nfc/st-nci/ndlc.c
@@ -239,8 +239,6 @@ static void ndlc_t1_timeout(struct timer_list *t)
 {
 	struct llt_ndlc *ndlc = from_timer(ndlc, t, t1_timer);
 
-	pr_debug("\n");
-
 	schedule_work(&ndlc->sm_work);
 }
 
@@ -248,8 +246,6 @@ static void ndlc_t2_timeout(struct timer_list *t)
 {
 	struct llt_ndlc *ndlc = from_timer(ndlc, t, t2_timer);
 
-	pr_debug("\n");
-
 	schedule_work(&ndlc->sm_work);
 }
 
diff --git a/drivers/nfc/st-nci/se.c b/drivers/nfc/st-nci/se.c
index 5fd89f72969d..7764b1a4c3cf 100644
--- a/drivers/nfc/st-nci/se.c
+++ b/drivers/nfc/st-nci/se.c
@@ -638,8 +638,6 @@ int st_nci_se_io(struct nci_dev *ndev, u32 se_idx,
 {
 	struct st_nci_info *info = nci_get_drvdata(ndev);
 
-	pr_debug("\n");
-
 	switch (se_idx) {
 	case ST_NCI_ESE_HOST_ID:
 		info->se_info.cb = cb;
@@ -671,8 +669,6 @@ static void st_nci_se_wt_timeout(struct timer_list *t)
 	u8 param = 0x01;
 	struct st_nci_info *info = from_timer(info, t, se_info.bwi_timer);
 
-	pr_debug("\n");
-
 	info->se_info.bwi_active = false;
 
 	if (!info->se_info.xch_error) {
@@ -692,8 +688,6 @@ static void st_nci_se_activation_timeout(struct timer_list *t)
 	struct st_nci_info *info = from_timer(info, t,
 					      se_info.se_active_timer);
 
-	pr_debug("\n");
-
 	info->se_info.se_active = false;
 
 	complete(&info->se_info.req_completion);
diff --git a/drivers/nfc/st-nci/spi.c b/drivers/nfc/st-nci/spi.c
index a620c34790e6..af1f04c306cc 100644
--- a/drivers/nfc/st-nci/spi.c
+++ b/drivers/nfc/st-nci/spi.c
@@ -169,7 +169,6 @@ static int st_nci_spi_read(struct st_nci_spi_phy *phy,
 static irqreturn_t st_nci_irq_thread_fn(int irq, void *phy_id)
 {
 	struct st_nci_spi_phy *phy = phy_id;
-	struct spi_device *dev;
 	struct sk_buff *skb = NULL;
 	int r;
 
@@ -178,9 +177,6 @@ static irqreturn_t st_nci_irq_thread_fn(int irq, void *phy_id)
 		return IRQ_NONE;
 	}
 
-	dev = phy->spi_dev;
-	dev_dbg(&dev->dev, "IRQ\n");
-
 	if (phy->ndlc->hard_fault)
 		return IRQ_HANDLED;
 
-- 
2.30.2

