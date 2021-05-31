Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DFDB395642
	for <lists+linux-kernel@lfdr.de>; Mon, 31 May 2021 09:36:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230424AbhEaHh0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 May 2021 03:37:26 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:60546 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230397AbhEaHhV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 May 2021 03:37:21 -0400
Received: from mail-ej1-f69.google.com ([209.85.218.69])
        by youngberry.canonical.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <krzysztof.kozlowski@canonical.com>)
        id 1lncSb-0002k8-1J
        for linux-kernel@vger.kernel.org; Mon, 31 May 2021 07:35:41 +0000
Received: by mail-ej1-f69.google.com with SMTP id j16-20020a1709062a10b02903ba544485d0so2157829eje.3
        for <linux-kernel@vger.kernel.org>; Mon, 31 May 2021 00:35:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aZ/yEEfClIlXQJ5jqul7RvuQr6Fao3s7oVlySYMna4M=;
        b=f3z2nzkCK2Qm2sQoKYxvZiZ14ITjteLvvi9Kgj4qvnwNbg/YzKqj0UA4R+Ymdrix3F
         V3Jq5+7Oa1JIczi00QgPEYEvJFj8PxHrv3GZylkwQcNweq8JPRuHybGCE9vDBXZSuKl0
         bJcZzwZDBvLzlAMKVP900+KzBjjapF3HiTblR+qoBTlcejKVryeGUTs05lr+4pP9NJu3
         aS9nqGOsEiwci9pWgOGtNCpePXB1yWtZO37k5uOHPv+gGNIoYm6TA2s8YeundPpcLjAM
         aHSxDuUWbMDKtRZmC5/jBLFeFGY23hZUa2+aAlDJPFPEJrrNLeiZN002kFrEv1xa2loU
         7DUw==
X-Gm-Message-State: AOAM532xK7aXvyCzeQIWSJgG24VgCLqEU9ltmjkfCQRz0q99mRNnV4Ht
        yO46SLpaxqERMkJvuk+QFK8yJpaaT2Yxkw1mqGI1PbV/B46L3kVncbnJ/Zu6QB/WF6kobQb2uyt
        MfpmNwmfCkkme/A2t37mFbu2KywTsQzugwMAdBUripQ==
X-Received: by 2002:a17:906:a2d0:: with SMTP id by16mr10820287ejb.37.1622446540588;
        Mon, 31 May 2021 00:35:40 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx+Tjd38dgYDCjWZAbxLIql+xzbe6YJpMcx4uGiK1i65n63byVeYJmdFScIYhnsVbjRxpSXzw==
X-Received: by 2002:adf:8bc9:: with SMTP id w9mr19323503wra.378.1622446530398;
        Mon, 31 May 2021 00:35:30 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-185-9.adslplus.ch. [188.155.185.9])
        by smtp.gmail.com with ESMTPSA id g10sm17217780wrq.12.2021.05.31.00.35.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 May 2021 00:35:29 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, linux-nfc@lists.01.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RESEND PATCH 02/11] nfc: mei_phy: drop ftrace-like debugging messages
Date:   Mon, 31 May 2021 09:35:13 +0200
Message-Id: <20210531073522.6720-2-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210531073522.6720-1-krzysztof.kozlowski@canonical.com>
References: <20210531073522.6720-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that the kernel has ftrace, any debugging calls that just do "made
it to this function!" and "leaving this function!" can be removed.
Better to use standard debugging tools.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 drivers/nfc/mei_phy.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/nfc/mei_phy.c b/drivers/nfc/mei_phy.c
index 0f43bb389566..e56cea716cd2 100644
--- a/drivers/nfc/mei_phy.c
+++ b/drivers/nfc/mei_phy.c
@@ -98,8 +98,6 @@ static int mei_nfc_if_version(struct nfc_mei_phy *phy)
 	size_t if_version_length;
 	int bytes_recv, r;
 
-	pr_info("%s\n", __func__);
-
 	memset(&cmd, 0, sizeof(struct mei_nfc_cmd));
 	cmd.hdr.cmd = MEI_NFC_CMD_MAINTENANCE;
 	cmd.hdr.data_size = 1;
@@ -146,8 +144,6 @@ static int mei_nfc_connect(struct nfc_mei_phy *phy)
 	size_t connect_length, connect_resp_length;
 	int bytes_recv, r;
 
-	pr_info("%s\n", __func__);
-
 	connect_length = sizeof(struct mei_nfc_cmd) +
 			sizeof(struct mei_nfc_connect);
 
@@ -320,8 +316,6 @@ static int nfc_mei_phy_enable(void *phy_id)
 	int r;
 	struct nfc_mei_phy *phy = phy_id;
 
-	pr_info("%s\n", __func__);
-
 	if (phy->powered == 1)
 		return 0;
 
@@ -363,8 +357,6 @@ static void nfc_mei_phy_disable(void *phy_id)
 {
 	struct nfc_mei_phy *phy = phy_id;
 
-	pr_info("%s\n", __func__);
-
 	mei_cldev_disable(phy->cldev);
 
 	phy->powered = 0;
-- 
2.27.0

