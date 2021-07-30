Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91C483DBAEA
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jul 2021 16:42:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239552AbhG3Omq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jul 2021 10:42:46 -0400
Received: from smtp-relay-canonical-0.canonical.com ([185.125.188.120]:44828
        "EHLO smtp-relay-canonical-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239403AbhG3Om2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jul 2021 10:42:28 -0400
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com [209.85.208.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPS id 218943F22C
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jul 2021 14:42:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1627656143;
        bh=1znQCNoqUlEMI5poOw0ZjBZ5wK7z3hvmMB9nUaNmREA=;
        h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=Hav506M527rF1uej7TjkJ8UP6XjrBEcMkYU3+xfl2AcWXPOSbpusPuu5azveTV6CR
         /I4v4odL3K+pL+RnlznEPSJxlx40xN01+LT9nf03M73xcvq9Owue6JAf/sfYJlAbs5
         y7WYZKjby1bftCDvf62q+pIcINTottvdDLkpOeUCROiQaTJ1sxUnaDoXT4u5LXVgXt
         6jB1D4Fy6gJl3p1lY5daD9LruJZG7h91BPiTau3Gwxt2CO2CbSqtJm+uMfF/kp9qdk
         p/xZu+DEqeigpG6hpmXdTZxKmgyuMo6WqrfSDUl2sxop3Z/5T/URzUze8AR6WESY5O
         rbozLX3Ry0J+g==
Received: by mail-ed1-f70.google.com with SMTP id b88-20020a509f610000b02903ab1f22e1dcso4730582edf.23
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jul 2021 07:42:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1znQCNoqUlEMI5poOw0ZjBZ5wK7z3hvmMB9nUaNmREA=;
        b=WnecV8EwhfwcBuEWrRKXif7B+V/6/s77MZ6hisQEt/Xk6j18DqHIv+GU0x6I1+BdZc
         cgfDPe+HWiFt3Z3vQyE4SCTKVEqAv21l+BLN5tT99Pat/SmhoQoSeKiHCgosi1qC+wlX
         9gJ1Ih1KvKsLeM3RafNdDPOy6TK84TYAkCUDE7nbM6loQe7BDFcdEW302DP5xayWzzm4
         D6JJS14TqFRkcgbSd0oJvk2h5oyvZimX8uV2GB9ODQd2CvPXnVwuUvpjUXgGPlX5GOti
         3GLHrcC5DJ0DWR3Q3C9XRKyFQ7HPqY/+nXebzYVWnkPUVJSE9kBTDmlX3z4C8go2RQ+b
         RgbA==
X-Gm-Message-State: AOAM531JP4JTgD1bVc95Tz+5DmYwTORZehBwx3lzHh0FA6Zbh3ZD/sxz
        hZtOjoAHl7GgVBZeEE00eTkqbNz8ogU+17DL/TmjoJN3F6FLn+kHt7V5sJ/CD7U3QL1wt92/SbE
        BtPDVXqBjVqf7I1jBVeRgUM1sfdcrHxjrJxsxNfWLLQ==
X-Received: by 2002:a50:d698:: with SMTP id r24mr3405024edi.316.1627656141873;
        Fri, 30 Jul 2021 07:42:21 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyR7m5xILM6A60J/5SHUYH5rQvCwRRECUJKkYnyp+ryMs1/2V3FrotgTyAKsGYvnx0cVFsAUQ==
X-Received: by 2002:a50:d698:: with SMTP id r24mr3405014edi.316.1627656141770;
        Fri, 30 Jul 2021 07:42:21 -0700 (PDT)
Received: from localhost.localdomain ([86.32.47.9])
        by smtp.gmail.com with ESMTPSA id z8sm626325ejd.94.2021.07.30.07.42.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jul 2021 07:42:20 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, linux-nfc@lists.01.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 7/7] nfc: hci: cleanup unneeded spaces
Date:   Fri, 30 Jul 2021 16:42:02 +0200
Message-Id: <20210730144202.255890-8-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210730144202.255890-1-krzysztof.kozlowski@canonical.com>
References: <20210730144202.255890-1-krzysztof.kozlowski@canonical.com>
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
index 774ddf957388..80a5c2a8e9fa 100644
--- a/net/nfc/nci/core.c
+++ b/net/nfc/nci/core.c
@@ -409,7 +409,7 @@ static void nci_send_data_req(struct nci_dev *ndev, unsigned long opt)
 static void nci_nfcc_loopback_cb(void *context, struct sk_buff *skb, int err)
 {
 	struct nci_dev *ndev = (struct nci_dev *)context;
-	struct nci_conn_info    *conn_info;
+	struct nci_conn_info *conn_info;
 
 	conn_info = nci_get_conn_info_by_conn_id(ndev, ndev->cur_conn_id);
 	if (!conn_info) {
@@ -1006,7 +1006,7 @@ static int nci_transceive(struct nfc_dev *nfc_dev, struct nfc_target *target,
 {
 	struct nci_dev *ndev = nfc_get_drvdata(nfc_dev);
 	int rc;
-	struct nci_conn_info    *conn_info;
+	struct nci_conn_info *conn_info;
 
 	conn_info = ndev->rf_conn_info;
 	if (!conn_info)
@@ -1271,7 +1271,7 @@ EXPORT_SYMBOL(nci_register_device);
  */
 void nci_unregister_device(struct nci_dev *ndev)
 {
-	struct nci_conn_info    *conn_info, *n;
+	struct nci_conn_info *conn_info, *n;
 
 	nci_close_device(ndev);
 
@@ -1443,7 +1443,7 @@ int nci_core_ntf_packet(struct nci_dev *ndev, __u16 opcode,
 static void nci_tx_work(struct work_struct *work)
 {
 	struct nci_dev *ndev = container_of(work, struct nci_dev, tx_work);
-	struct nci_conn_info    *conn_info;
+	struct nci_conn_info *conn_info;
 	struct sk_buff *skb;
 
 	conn_info = nci_get_conn_info_by_conn_id(ndev, ndev->cur_conn_id);
diff --git a/net/nfc/nci/hci.c b/net/nfc/nci/hci.c
index 71a306b29735..a8ff794a8084 100644
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
@@ -714,7 +714,7 @@ static int nci_hci_dev_connect_gates(struct nci_dev *ndev,
 
 int nci_hci_dev_session_init(struct nci_dev *ndev)
 {
-	struct nci_conn_info    *conn_info;
+	struct nci_conn_info *conn_info;
 	struct sk_buff *skb;
 	int r;
 
diff --git a/net/nfc/nci/ntf.c b/net/nfc/nci/ntf.c
index d6251363b72b..c5eacaac41ae 100644
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
index dbb0b55a1757..a2e72c003805 100644
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

