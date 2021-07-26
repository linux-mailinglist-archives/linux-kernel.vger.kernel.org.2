Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24B3E3D5C37
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jul 2021 16:53:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234955AbhGZONL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jul 2021 10:13:11 -0400
Received: from smtp-relay-canonical-0.canonical.com ([185.125.188.120]:60992
        "EHLO smtp-relay-canonical-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234763AbhGZOMM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jul 2021 10:12:12 -0400
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com [209.85.218.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPS id 40DE03F35C
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jul 2021 14:52:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1627311159;
        bh=5b3rss93r6uC6jUz7YubdbFbPL2TEspADlSTT09MqGw=;
        h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=g35ewAaVg/CtSND+S31jhKbSaNllysu30YVwy9dw1PdhiHu9a5EWs2C12rFl2yIkI
         A2055YjwTUfSx6BwB2/P5c2L10VUIz90M/z/j91zeQyCGGfJWxMOuATotceVFeEf80
         247EfKFBMkN9SiWBIKOqyQxP8ixLH/IaZCVyr6h6jyjz0OeQkIM5Bqh3+hpdpQBgIz
         ju6dWnmMw6Z8dIuJz4ZptQNuo0AfOmWD7XZrw6sMY2AaVIxbNQybMXWwIGdM+EcVC2
         B2Fnr3bRs2tmTRR49qgkUpc7Ul6D+loF9JnJpyIXEFgtWijJVaac3mszQV9Z+ZWrTa
         skEQT1kSHPnQQ==
Received: by mail-ej1-f72.google.com with SMTP id i4-20020a1709064ec4b0290504bafdd58dso2177117ejv.4
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jul 2021 07:52:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5b3rss93r6uC6jUz7YubdbFbPL2TEspADlSTT09MqGw=;
        b=VJYUbnzpIQsL4GkLPPYut8wGiwhKEBKq/N82ZLZ97jXdGe26laiDJJ/ir/fRxAOQHX
         XIuT9RFDXzBapy1ckncz8PFGbRuKLu5OYZcb6StAMIkQJX45IrpcCJL68GIcbCFru7o7
         Epz0PZTHGqib7LTUTeiVfR9XcmI0wg6nC40kpcWR1aGGQlnEfGWQOPTnEyyaYddBDees
         9jRvfBQ+I+hev2/DOhkOcoIXawggaHCozMI2WRQgAHGT4TMy3qPeSrtv9ARkUufPSeQQ
         ylwGq3SrELrFJScOwzPSUwnk8lrDnckXQGsz0LvUXtYjEbxkmmxB0bzdtZSnce6NRq4W
         jqRg==
X-Gm-Message-State: AOAM532BevPOWUPf0RqkpV6jXl7XMSr9CydhpuYKQ3teIqFnb1JJtZoI
        oEQNT4U2XomhJ8lmxOZksvj3QF5Lpn1OOmny8Dkap49yPEgsxoGe2vMFXM5VPqWntJL2wncc73G
        t+e98J0c747FKGy5JsXx7C6MmwgIIXiM3dK5n9Tl6aA==
X-Received: by 2002:a05:6402:1a4c:: with SMTP id bf12mr6279906edb.137.1627311159029;
        Mon, 26 Jul 2021 07:52:39 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxrj1BgSzsm9Nd+//wNQlONHgA+v5wYQ6KqdbNX9S818CW0TcSDZVSEFoCFwo9vfDzbOA09Dw==
X-Received: by 2002:a05:6402:1a4c:: with SMTP id bf12mr6279892edb.137.1627311158913;
        Mon, 26 Jul 2021 07:52:38 -0700 (PDT)
Received: from localhost.localdomain ([86.32.47.9])
        by smtp.gmail.com with ESMTPSA id l16sm12750753eje.67.2021.07.26.07.52.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jul 2021 07:52:38 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Bongsu Jeon <bongsu.jeon@samsung.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 7/7] nfc: hci: cleanup unneeded spaces
Date:   Mon, 26 Jul 2021 16:52:24 +0200
Message-Id: <20210726145224.146006-8-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210726145224.146006-1-krzysztof.kozlowski@canonical.com>
References: <20210726145224.146006-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No need for multiple spaces in variable declaration (the code does not
use them in other places).  No functional change.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 net/nfc/nci/core.c |  8 ++++----
 net/nfc/nci/hci.c  | 14 +++++++-------
 net/nfc/nci/ntf.c  |  4 ++--
 net/nfc/nci/rsp.c  |  2 +-
 4 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/net/nfc/nci/core.c b/net/nfc/nci/core.c
index a17635612bcc..b814d92da7a5 100644
--- a/net/nfc/nci/core.c
+++ b/net/nfc/nci/core.c
@@ -405,7 +405,7 @@ static void nci_send_data_req(struct nci_dev *ndev, const void *opt)
 static void nci_nfcc_loopback_cb(void *context, struct sk_buff *skb, int err)
 {
 	struct nci_dev *ndev = (struct nci_dev *)context;
-	struct nci_conn_info    *conn_info;
+	struct nci_conn_info *conn_info;
 
 	conn_info = nci_get_conn_info_by_conn_id(ndev, ndev->cur_conn_id);
 	if (!conn_info) {
@@ -1002,7 +1002,7 @@ static int nci_transceive(struct nfc_dev *nfc_dev, struct nfc_target *target,
 {
 	struct nci_dev *ndev = nfc_get_drvdata(nfc_dev);
 	int rc;
-	struct nci_conn_info    *conn_info;
+	struct nci_conn_info *conn_info;
 
 	conn_info = ndev->rf_conn_info;
 	if (!conn_info)
@@ -1267,7 +1267,7 @@ EXPORT_SYMBOL(nci_register_device);
  */
 void nci_unregister_device(struct nci_dev *ndev)
 {
-	struct nci_conn_info    *conn_info, *n;
+	struct nci_conn_info *conn_info, *n;
 
 	nci_close_device(ndev);
 
@@ -1439,7 +1439,7 @@ int nci_core_ntf_packet(struct nci_dev *ndev, __u16 opcode,
 static void nci_tx_work(struct work_struct *work)
 {
 	struct nci_dev *ndev = container_of(work, struct nci_dev, tx_work);
-	struct nci_conn_info    *conn_info;
+	struct nci_conn_info *conn_info;
 	struct sk_buff *skb;
 
 	conn_info = nci_get_conn_info_by_conn_id(ndev, ndev->cur_conn_id);
diff --git a/net/nfc/nci/hci.c b/net/nfc/nci/hci.c
index 163e5de7eda6..e199912ee1e5 100644
--- a/net/nfc/nci/hci.c
+++ b/net/nfc/nci/hci.c
@@ -16,11 +16,11 @@
 #include <linux/nfc.h>
 
 struct nci_data {
-	u8              conn_id;
-	u8              pipe;
-	u8              cmd;
-	const u8        *data;
-	u32             data_len;
+	u8 conn_id;
+	u8 pipe;
+	u8 cmd;
+	const u8 *data;
+	u32 data_len;
 } __packed;
 
 struct nci_hci_create_pipe_params {
@@ -363,7 +363,7 @@ static void nci_hci_cmd_received(struct nci_dev *ndev, u8 pipe,
 static void nci_hci_resp_received(struct nci_dev *ndev, u8 pipe,
 				  struct sk_buff *skb)
 {
-	struct nci_conn_info    *conn_info;
+	struct nci_conn_info *conn_info;
 
 	conn_info = ndev->hci_dev->conn_info;
 	if (!conn_info)
@@ -712,7 +712,7 @@ static int nci_hci_dev_connect_gates(struct nci_dev *ndev,
 
 int nci_hci_dev_session_init(struct nci_dev *ndev)
 {
-	struct nci_conn_info    *conn_info;
+	struct nci_conn_info *conn_info;
 	struct sk_buff *skb;
 	int r;
 
diff --git a/net/nfc/nci/ntf.c b/net/nfc/nci/ntf.c
index 0a2ed25b9797..dde36e19f652 100644
--- a/net/nfc/nci/ntf.c
+++ b/net/nfc/nci/ntf.c
@@ -48,7 +48,7 @@ static void nci_core_conn_credits_ntf_packet(struct nci_dev *ndev,
 					     struct sk_buff *skb)
 {
 	struct nci_core_conn_credit_ntf *ntf = (void *) skb->data;
-	struct nci_conn_info	*conn_info;
+	struct nci_conn_info *conn_info;
 	int i;
 
 	pr_debug("num_entries %d\n", ntf->num_entries);
@@ -528,7 +528,7 @@ static int nci_store_general_bytes_nfc_dep(struct nci_dev *ndev,
 static void nci_rf_intf_activated_ntf_packet(struct nci_dev *ndev,
 					     const struct sk_buff *skb)
 {
-	struct nci_conn_info    *conn_info;
+	struct nci_conn_info *conn_info;
 	struct nci_rf_intf_activated_ntf ntf;
 	const __u8 *data = skb->data;
 	int err = NCI_STATUS_OK;
diff --git a/net/nfc/nci/rsp.c b/net/nfc/nci/rsp.c
index ebed2a7a0071..8539a39a8e1d 100644
--- a/net/nfc/nci/rsp.c
+++ b/net/nfc/nci/rsp.c
@@ -185,7 +185,7 @@ static void nci_rf_disc_map_rsp_packet(struct nci_dev *ndev,
 static void nci_rf_disc_rsp_packet(struct nci_dev *ndev,
 				   const struct sk_buff *skb)
 {
-	struct nci_conn_info    *conn_info;
+	struct nci_conn_info *conn_info;
 	__u8 status = skb->data[0];
 
 	pr_debug("status 0x%x\n", status);
-- 
2.27.0

