Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BAEF13DB41D
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jul 2021 08:57:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238043AbhG3G5Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jul 2021 02:57:25 -0400
Received: from smtp-relay-canonical-1.canonical.com ([185.125.188.121]:55424
        "EHLO smtp-relay-canonical-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237882AbhG3G5L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jul 2021 02:57:11 -0400
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com [209.85.218.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPS id 2E0CC3F0FF
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jul 2021 06:57:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1627628226;
        bh=5b3rss93r6uC6jUz7YubdbFbPL2TEspADlSTT09MqGw=;
        h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=ETOKA9NdVVe8EuDYJogobE+zooAahC1ISTfysfG7tbKXBTIKmnRqjsERZ0zZBe9lW
         5YQtMOdcby3VBPukgXwvYB1bVto+cZEsFrozPfMqHhDYdteWZL/W2be7Yx2tV6IzSa
         jewPT4qMw2dSaePmw0U/nphE+ea/k8tmY657t6pGhPrbyaZ8dtGH/FUMsPT+k2KcvN
         OGM1xqpIF1Mh2G0edR8ejo7qYhQPubCSW+pbBU4WiY3tJZ5WI9l60uDsiaQ7TtD18B
         OPL16wqCwkXU//47yycgUEsz1BtoN4quLBeGrJ+tctwvVIgwuwuwTlnW4dHc9oajkl
         u2mDKMq/Be8fw==
Received: by mail-ej1-f70.google.com with SMTP id e8-20020a1709060808b02904f7606bd58fso2767322ejd.11
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jul 2021 23:57:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5b3rss93r6uC6jUz7YubdbFbPL2TEspADlSTT09MqGw=;
        b=B5yS89WG4YTqDUf5+JiypUh2B1pE7Uz4I99fJiOUt13XgigThTvwjDaADxRYr1keHH
         jMEzXH5hOg+NzH6oKJYzKYnyYg2uVGsgAe2g+Xmz8wpYOK12oWKwOA4Zs2c1p5uqQvcK
         Jyudu/UOK9ASWvbnGcs70o5rOsTyqaho3vYIleYn+Zym6yYtct7mkgS6tSJn77luyvUz
         oyglQIEiW8FNT4+PLVP6b50VsfC1D4HvWASdmKbCCxgu7vDKFeFMn/JH0l05fqd+oEID
         duM3rb1n+cLJ6yMVj88w/GZbIaiJVf06tNj7KiZlVu/hC7GU+n9G5s7/iGFlZAcXqwaN
         AylA==
X-Gm-Message-State: AOAM533VxTThvjoSw5jyrgHFsmDm3VFe2JeOVp04Qv818eKEi+Cnp6+O
        c2K+BRImWSTU6EBMNFHR5GsewvqjmWSLIm02VQ6qf46ad48mmcc3/t9c6QZtMdwIFNhfJ3R9CC7
        /LdvNuLLSVceCeI9Zjns+BJc/dpGlBChBt/Xw+wAQdQ==
X-Received: by 2002:aa7:d543:: with SMTP id u3mr1245837edr.37.1627628225923;
        Thu, 29 Jul 2021 23:57:05 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxiJap9ybScNT/kQPO1gcfMiMFm+GxDuzgoLKlnRe/HtgPIUDUczUTDj2ceRfGZO+8KskWdcQ==
X-Received: by 2002:aa7:d543:: with SMTP id u3mr1245823edr.37.1627628225803;
        Thu, 29 Jul 2021 23:57:05 -0700 (PDT)
Received: from localhost.localdomain ([86.32.47.9])
        by smtp.gmail.com with ESMTPSA id m9sm238518ejn.91.2021.07.29.23.57.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jul 2021 23:57:05 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, linux-nfc@lists.01.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 8/8] nfc: hci: cleanup unneeded spaces
Date:   Fri, 30 Jul 2021 08:56:25 +0200
Message-Id: <20210730065625.34010-9-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210730065625.34010-1-krzysztof.kozlowski@canonical.com>
References: <20210730065625.34010-1-krzysztof.kozlowski@canonical.com>
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

