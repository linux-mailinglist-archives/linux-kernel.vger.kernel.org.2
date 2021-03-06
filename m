Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1EB832FDB1
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Mar 2021 23:14:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229960AbhCFWNe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Mar 2021 17:13:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229872AbhCFWMy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Mar 2021 17:12:54 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63FC1C06174A
        for <linux-kernel@vger.kernel.org>; Sat,  6 Mar 2021 14:12:43 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id f2-20020a17090a4a82b02900c67bf8dc69so1017392pjh.1
        for <linux-kernel@vger.kernel.org>; Sat, 06 Mar 2021 14:12:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2bcl5+AurQSgRcbj7Yms06zqNQhuPyePfjam/kIHgAw=;
        b=bDML/VAvIqHiDN6m3e/VdLawIdC5JWjuEnppYJcH/ZyZT7jV1CMuX5SygqULF2gqvs
         h9i4HndSOyM/6575rfIXKgSTuGKjmrHI+OOBabQpDClvaN6YANFzsWLMf8NlT//zD2nb
         Lxe662d8GMnjJhTGf/W8n8X5WqDay6lLuDCk8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2bcl5+AurQSgRcbj7Yms06zqNQhuPyePfjam/kIHgAw=;
        b=taD6oeBO10IrFZ1a7jDdPPPOZvR7aqh8SO6DyBFHfQ4n1TI2lhch2Y67Pn725mB0lv
         OxRlIbtRfZ8GBVLV+PjwEcoOJWvwAJ9ROh4ZS/nXZwzfzoIhMDSEPx7/A7Thy0c64rgZ
         tnOcJGcUWcQG+XEj+QCLGabHHqarJoAZQ58DdxuqiALDxtihHwcIow7199T/NsWAIqN1
         dlfN6SnpwkqVrHNAKk0am/1ixpP+JXLtLONMCR/KnsapqgvRyUme5nHzteMPFxtOeiR+
         L/Ic0oBPwhNZ5MjWE8Q07ObiwozGAQn6p8pPizZJCpNQVsM3evbFeLw2gJRjx/PnBSgU
         6m0g==
X-Gm-Message-State: AOAM530dtVEEywjJosIXcK33CFe4SeiALWYDnPlB264SLI3jrwkzboxi
        2WSbFHcrZMthlKaOFG/Az1CUOg==
X-Google-Smtp-Source: ABdhPJyiodb5Px1FihIdQnDiVPlTzMncBanKsJIH3Vm8vx+bWweJr02Asj7bzUEN/WoyxDRy6eBj+g==
X-Received: by 2002:a17:90a:db01:: with SMTP id g1mr17363202pjv.127.1615068762140;
        Sat, 06 Mar 2021 14:12:42 -0800 (PST)
Received: from grundler-glapstation.lan ([2600:1700:3ec2:905f:9c5:ceb0:502e:f28d])
        by smtp.gmail.com with ESMTPSA id n125sm5763198pfn.21.2021.03.06.14.12.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Mar 2021 14:12:40 -0800 (PST)
From:   Grant Grundler <grundler@chromium.org>
To:     Oliver Neukum <oneukum@suse.com>, Jakub Kicinski <kuba@kernel.org>
Cc:     Roland Dreier <roland@kernel.org>, nic_swsd <nic_swsd@realtek.com>,
        netdev <netdev@vger.kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrew Lunn <andrew@lunn.ch>,
        Grant Grundler <grundler@chromium.org>
Subject: [PATCH net-next] net: usb: cdc_ncm: emit dev_err on error paths
Date:   Sat,  6 Mar 2021 14:12:31 -0800
Message-Id: <20210306221232.3382941-1-grundler@chromium.org>
X-Mailer: git-send-email 2.30.1.766.gb4fecdf3b7-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Several error paths in bind/probe code will only emit
output using dev_dbg. But if we are going to fail the
bind/probe, emit related output with "err" priority.

Signed-off-by: Grant Grundler <grundler@chromium.org>
---
 drivers/net/usb/cdc_ncm.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

Reposting to net-next per instructions in https://www.spinics.net/lists/netdev/msg715496.html

I've applied this patch to most chromeos kernels:
    https://chromium-review.googlesource.com/q/hashtag:usbnet-rtl8156-support

diff --git a/drivers/net/usb/cdc_ncm.c b/drivers/net/usb/cdc_ncm.c
index 5a78848db93f..25498c311551 100644
--- a/drivers/net/usb/cdc_ncm.c
+++ b/drivers/net/usb/cdc_ncm.c
@@ -849,17 +849,17 @@ int cdc_ncm_bind_common(struct usbnet *dev, struct usb_interface *intf, u8 data_
 
 	/* check if we got everything */
 	if (!ctx->data) {
-		dev_dbg(&intf->dev, "CDC Union missing and no IAD found\n");
+		dev_err(&intf->dev, "CDC Union missing and no IAD found\n");
 		goto error;
 	}
 	if (cdc_ncm_comm_intf_is_mbim(intf->cur_altsetting)) {
 		if (!ctx->mbim_desc) {
-			dev_dbg(&intf->dev, "MBIM functional descriptor missing\n");
+			dev_err(&intf->dev, "MBIM functional descriptor missing\n");
 			goto error;
 		}
 	} else {
 		if (!ctx->ether_desc || !ctx->func_desc) {
-			dev_dbg(&intf->dev, "NCM or ECM functional descriptors missing\n");
+			dev_err(&intf->dev, "NCM or ECM functional descriptors missing\n");
 			goto error;
 		}
 	}
@@ -868,7 +868,7 @@ int cdc_ncm_bind_common(struct usbnet *dev, struct usb_interface *intf, u8 data_
 	if (ctx->data != ctx->control) {
 		temp = usb_driver_claim_interface(driver, ctx->data, dev);
 		if (temp) {
-			dev_dbg(&intf->dev, "failed to claim data intf\n");
+			dev_err(&intf->dev, "failed to claim data intf\n");
 			goto error;
 		}
 	}
@@ -924,7 +924,7 @@ int cdc_ncm_bind_common(struct usbnet *dev, struct usb_interface *intf, u8 data_
 	if (ctx->ether_desc) {
 		temp = usbnet_get_ethernet_addr(dev, ctx->ether_desc->iMACAddress);
 		if (temp) {
-			dev_dbg(&intf->dev, "failed to get mac address\n");
+			dev_err(&intf->dev, "failed to get mac address\n");
 			goto error2;
 		}
 		dev_info(&intf->dev, "MAC-Address: %pM\n", dev->net->dev_addr);
-- 
2.29.2

