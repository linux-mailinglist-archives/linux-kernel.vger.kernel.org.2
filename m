Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8157A3DBAE1
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jul 2021 16:42:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239354AbhG3Om2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jul 2021 10:42:28 -0400
Received: from smtp-relay-canonical-1.canonical.com ([185.125.188.121]:32820
        "EHLO smtp-relay-canonical-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239387AbhG3OmY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jul 2021 10:42:24 -0400
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com [209.85.208.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPS id 065003F243
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jul 2021 14:42:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1627656139;
        bh=y9Uo/os+3OziqdNdxRl0CGuCizZoyhHNVP1pooBGgac=;
        h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=SvmNlYfO1T9YpcWhHz55l6E2AKU5Vwq+wL3UTYyhBlzikGj5kii+hg/tRlTYDjrkZ
         6hKIDXQoJ9a7he3I+i6tLykgAJIuTjCyJP9DWvnfFXD4ToVV532BUjPBmTakkF6ZIE
         IksZ1zAank8t0af1rS5vUzI17UopCLp2w+aRbWtL6K5PnivWZ/V3qt8BqFegZ21T18
         k6qIoVLL0gUUj+QfFiT4KCe6DX69n2Ek+vIPBDEyaNK0DcY9l6pSxhK5UM1DIfqWoa
         FwgaphuTCu9Oy7wxnL642ibJ+M7E4hqCZ7ODKjwTGR64lM0P7ml10rBspcacZY7FmD
         Nrcc6RImxvCxg==
Received: by mail-ed1-f70.google.com with SMTP id l3-20020aa7c3030000b02903bccf1897f9so1117103edq.19
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jul 2021 07:42:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=y9Uo/os+3OziqdNdxRl0CGuCizZoyhHNVP1pooBGgac=;
        b=R8/QQGfm1WRNX9KIUCYgVBRXDaNVAb1XVyjCohvcbsx0NFFo2t5UQNH5BtSlxT53ET
         pnvFvXlw4EecOFsnoSVi0EXnhr34l/lHr3Hw3k1I4f6NPR454rQjVnhQ2yIFhBhkBGRM
         8uN3hKzkMyk6RQ4rM5SlpDGPBYNlUCRE29HhI1chOuhjfd1H8AOJYv67H5tD67h/zwCT
         slRDlyLuaopwOIamODmYoZinRdwTXzddX/km3BoKAcZIOZBKM6U69+sHN5JHkCQI9uHs
         UZ+Lk+EpNLLU1jevcgED39B/t9R+iDWHj6/iWmeI6mNv8A1rH3HU0Xqfaev33Ej2ST0k
         ZzKw==
X-Gm-Message-State: AOAM532FyIONFKruAsfxPaA7MSBXRHkBriWEKruP9DSpeCvOixfiMOY5
        caFIuMc6cJSD6b5DgBE0VeZ07r6+vUOErbiHf0wQ0AlaZrJGSqywDOBadtTpHqkE0/+ANRTNobU
        S9Q0CY9OiJGmw9t/WfSiWe1aHeumDccQ3Vq3u1qe1Fg==
X-Received: by 2002:a17:907:2d28:: with SMTP id gs40mr2904570ejc.193.1627656138735;
        Fri, 30 Jul 2021 07:42:18 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwYC1VofAfZY3hhBV10+K4sh3QRT8py2x7b+JMzQrNK6xJ2n3VaOY7deB9lkFNxeE52DKW/7g==
X-Received: by 2002:a17:907:2d28:: with SMTP id gs40mr2904558ejc.193.1627656138597;
        Fri, 30 Jul 2021 07:42:18 -0700 (PDT)
Received: from localhost.localdomain ([86.32.47.9])
        by smtp.gmail.com with ESMTPSA id z8sm626325ejd.94.2021.07.30.07.42.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jul 2021 07:42:18 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, linux-nfc@lists.01.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 5/7] nfc: constify local pointer variables
Date:   Fri, 30 Jul 2021 16:42:00 +0200
Message-Id: <20210730144202.255890-6-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210730144202.255890-1-krzysztof.kozlowski@canonical.com>
References: <20210730144202.255890-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Few pointers to struct nfc_target and struct nfc_se can be made const.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 drivers/nfc/pn544/pn544.c | 4 ++--
 net/nfc/core.c            | 2 +-
 net/nfc/hci/core.c        | 8 ++++----
 net/nfc/netlink.c         | 2 +-
 4 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/nfc/pn544/pn544.c b/drivers/nfc/pn544/pn544.c
index c2b4555ab4b7..092f03b80a78 100644
--- a/drivers/nfc/pn544/pn544.c
+++ b/drivers/nfc/pn544/pn544.c
@@ -809,7 +809,7 @@ static int pn544_hci_discover_se(struct nfc_hci_dev *hdev)
 #define PN544_SE_MODE_ON	0x01
 static int pn544_hci_enable_se(struct nfc_hci_dev *hdev, u32 se_idx)
 {
-	struct nfc_se *se;
+	const struct nfc_se *se;
 	u8 enable = PN544_SE_MODE_ON;
 	static struct uicc_gatelist {
 		u8 head;
@@ -864,7 +864,7 @@ static int pn544_hci_enable_se(struct nfc_hci_dev *hdev, u32 se_idx)
 
 static int pn544_hci_disable_se(struct nfc_hci_dev *hdev, u32 se_idx)
 {
-	struct nfc_se *se;
+	const struct nfc_se *se;
 	u8 disable = PN544_SE_MODE_OFF;
 
 	se = nfc_find_se(hdev->ndev, se_idx);
diff --git a/net/nfc/core.c b/net/nfc/core.c
index 08182e209144..3c645c1d99c9 100644
--- a/net/nfc/core.c
+++ b/net/nfc/core.c
@@ -824,7 +824,7 @@ EXPORT_SYMBOL(nfc_targets_found);
  */
 int nfc_target_lost(struct nfc_dev *dev, u32 target_idx)
 {
-	struct nfc_target *tg;
+	const struct nfc_target *tg;
 	int i;
 
 	pr_debug("dev_name %s n_target %d\n", dev_name(&dev->dev), target_idx);
diff --git a/net/nfc/hci/core.c b/net/nfc/hci/core.c
index ff94ac774937..ceb87db57cdb 100644
--- a/net/nfc/hci/core.c
+++ b/net/nfc/hci/core.c
@@ -128,7 +128,7 @@ static void nfc_hci_msg_rx_work(struct work_struct *work)
 	struct nfc_hci_dev *hdev = container_of(work, struct nfc_hci_dev,
 						msg_rx_work);
 	struct sk_buff *skb;
-	struct hcp_message *message;
+	const struct hcp_message *message;
 	u8 pipe;
 	u8 type;
 	u8 instruction;
@@ -182,9 +182,9 @@ void nfc_hci_cmd_received(struct nfc_hci_dev *hdev, u8 pipe, u8 cmd,
 			  struct sk_buff *skb)
 {
 	u8 status = NFC_HCI_ANY_OK;
-	struct hci_create_pipe_resp *create_info;
-	struct hci_delete_pipe_noti *delete_info;
-	struct hci_all_pipe_cleared_noti *cleared_info;
+	const struct hci_create_pipe_resp *create_info;
+	const struct hci_delete_pipe_noti *delete_info;
+	const struct hci_all_pipe_cleared_noti *cleared_info;
 	u8 gate;
 
 	pr_debug("from pipe %x cmd %x\n", pipe, cmd);
diff --git a/net/nfc/netlink.c b/net/nfc/netlink.c
index 70467a82be8f..49089c50872e 100644
--- a/net/nfc/netlink.c
+++ b/net/nfc/netlink.c
@@ -530,7 +530,7 @@ int nfc_genl_se_transaction(struct nfc_dev *dev, u8 se_idx,
 
 int nfc_genl_se_connectivity(struct nfc_dev *dev, u8 se_idx)
 {
-	struct nfc_se *se;
+	const struct nfc_se *se;
 	struct sk_buff *msg;
 	void *hdr;
 
-- 
2.27.0

