Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A9BD3D8DB7
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jul 2021 14:26:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236342AbhG1M0h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jul 2021 08:26:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235102AbhG1M0Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jul 2021 08:26:24 -0400
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C05BC061765;
        Wed, 28 Jul 2021 05:26:21 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id k7so1919295qki.11;
        Wed, 28 Jul 2021 05:26:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ggW256M3SIcZiGvGqGuspKz5dguh2TkojKgtWRP6iJo=;
        b=HSmAocoULMxqdBe+Mx9uXxKQ44OgPTgw7kvx+SHAGhr4/9dAqyMGgpcmq1mRetpVvx
         CXcABsudaaeuf+JB29+OKe4cn71JOzr3Ecobv/L6PKM1lv99VpS2iqTu0WNLJIZF3SvQ
         HdUhsMNN/ZiMya2WeSAW18mExVKEBjm9qP7tnO90431gM2s8qLFGRdXWw9ECD0n8Guxa
         hakJzONVvCpc+18DmsRbv1wdWYX5a0PgRapWfeYj9P6zfdGEFonkIElCOTqvu8+suHp0
         0MPAs/Q48yAczoK5GZzCG/TIJBxc0d63gjKAP4Npm/9IUTQ9WJjzza2tY5lkMxqhVMio
         eBpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ggW256M3SIcZiGvGqGuspKz5dguh2TkojKgtWRP6iJo=;
        b=EBzQy6VqwnrMpDCLm9nAVYQP1NNA7qokumYFe+fSgt5Cy+HHqBJvUeeAzqLcD1KYvr
         9hHGf2eCG69Z5fEPTWjvntjnNrk7DkbJ8vy5DAxz+mjgg1/D7X3ESH2szJp+Glyoeq4S
         bcNMnmOleSYsb3wOHlHJtYprQwYzVuvmHvrD3fB/0DXXPPAXBW3qNq3wrfLjBR8omOkK
         CbWQDY9q0yT0a9Yb88XAPLBAcsNSEPbjEMbNPiUHv26AUbJH462InNFIDm4X8cMdKXDt
         0voex31QqyC+8g6RH3W/eOfaM6MKeAvqidq941DbYVjIF8MsxJveOyH3tDLc60iyogEv
         tg1A==
X-Gm-Message-State: AOAM530+lZzB8JANhEKUieyXxf+vfnbgx2ZiGRQtJhlWCppF+E1uWLt6
        vJQAR6ESxNj8oOUVSCGQaMg=
X-Google-Smtp-Source: ABdhPJwG8Ql+7RxbtSJJqgwHW1eAPquMhI4GLv3UHYkGkUDR486INGiDbWaRkvdgXxBr43JSUT2LaA==
X-Received: by 2002:a37:dcc2:: with SMTP id v185mr27461633qki.167.1627475180767;
        Wed, 28 Jul 2021 05:26:20 -0700 (PDT)
Received: from master-laptop.sparksnet ([2601:153:980:85b1:b58:2ae8:d75f:660a])
        by smtp.gmail.com with ESMTPSA id z9sm2842972qtn.54.2021.07.28.05.26.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jul 2021 05:26:20 -0700 (PDT)
From:   Peter Geis <pgwipeout@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-phy@lists.infradead.org, Peter Geis <pgwipeout@gmail.com>
Subject: [RFC PATCH 4/9] phy: phy-rockchip-inno-usb2: support #address_cells = 2
Date:   Wed, 28 Jul 2021 08:26:01 -0400
Message-Id: <20210728122606.697619-5-pgwipeout@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210728122606.697619-1-pgwipeout@gmail.com>
References: <20210728122606.697619-1-pgwipeout@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

New Rockchip devices have the usb phy nodes as standalone devices.
These nodes have register nodes with #address_cells = 2, but only use 32
bit addresses.

Adjust the driver to check if the returned address is "0", and adjust
the index in that case.

Signed-off-by: Peter Geis <pgwipeout@gmail.com>
---
 drivers/phy/rockchip/phy-rockchip-inno-usb2.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/phy/rockchip/phy-rockchip-inno-usb2.c b/drivers/phy/rockchip/phy-rockchip-inno-usb2.c
index beacac1dd253..5d2916143df7 100644
--- a/drivers/phy/rockchip/phy-rockchip-inno-usb2.c
+++ b/drivers/phy/rockchip/phy-rockchip-inno-usb2.c
@@ -1098,12 +1098,21 @@ static int rockchip_usb2phy_probe(struct platform_device *pdev)
 		rphy->usbgrf = NULL;
 	}
 
-	if (of_property_read_u32(np, "reg", &reg)) {
+	if (of_property_read_u32_index(np, "reg", 0, &reg)) {
 		dev_err(dev, "the reg property is not assigned in %pOFn node\n",
 			np);
 		return -EINVAL;
 	}
 
+	/* support address_cells=2 */
+	if (reg == 0) {
+		if (of_property_read_u32_index(np, "reg", 1, &reg)) {
+			dev_err(dev, "the reg property is not assigned in %pOFn node\n",
+				np);
+			return -EINVAL;
+		}
+	}
+
 	rphy->dev = dev;
 	phy_cfgs = match->data;
 	rphy->chg_state = USB_CHG_STATE_UNDEFINED;
-- 
2.25.1

