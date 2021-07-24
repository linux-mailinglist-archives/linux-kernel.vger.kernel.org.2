Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05A2D3D4A54
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Jul 2021 23:50:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230430AbhGXVJZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Jul 2021 17:09:25 -0400
Received: from smtp-relay-canonical-1.canonical.com ([185.125.188.121]:43982
        "EHLO smtp-relay-canonical-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230282AbhGXVJU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Jul 2021 17:09:20 -0400
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com [209.85.208.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPS id 36A023F350
        for <linux-kernel@vger.kernel.org>; Sat, 24 Jul 2021 21:49:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1627163391;
        bh=ydfFaHKHi19ltLLH8d1w1IAXq4hz0eleT+vI32JJiWk=;
        h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=leM0wxQ2r7FPy/IBWitd7f2svw6xPL/mONdJUG+skUR6tFlnPyj95r51X0Aw12xGa
         jHWxXrcqLk5zstjOCt1nTb3dUHoT5F6M2IscayF9wT6028Wyr8c770efx5EmpJ2bpa
         HS7pzFDKarHF+AOcBz5l/UzxwzZ8geVNgwSwPtnHNGg2ChZyNQRO2YKwDeLKmMIYG4
         qV9/h/psR3ySyybUa9pBwiiJqU0EpATR8p+K9HaRccbs/Om+fwDoHfVkRbAib4foR+
         MHFAS5mdbRnd6q1uoaJQsXZZEK5E5aZuAssP8zDtei12UFLPkWBJ2Cc+RsTeAiHRod
         E5XgymLxayACA==
Received: by mail-ed1-f69.google.com with SMTP id p2-20020a50c9420000b02903a12bbba1ebso2786282edh.6
        for <linux-kernel@vger.kernel.org>; Sat, 24 Jul 2021 14:49:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ydfFaHKHi19ltLLH8d1w1IAXq4hz0eleT+vI32JJiWk=;
        b=kLdcdOqAUlmajJJfbcUJ4hRZ7eQZvU/u2QCEF/G4wTMdxPYSM/fTG7Jk9cnnGR6BLw
         jBY8R6bh+Agan7gNPsFuVgYxDl49bP7Furg7IwCdavD2f1gBTZk59J7Vt+vvrqTNintz
         gFjTcKa1v/s0Tsa30eg5FT+ESxztODZQl6hA/jaHXlUFZYk5sPHXKADzvAfl0jerqrFF
         Dc76pW+p9sA44UQnU5cjRIxiVuBuJoyINsm3VXwGFHA6GWu+D9/zrOd0NZOMYMWQAEVf
         rmHc/IJMFjcihQfglKoilZTIEVUtOsqFiyjUgwaD4rfJCaNxDEHbRNWEAnUuUReP9l6J
         ShDA==
X-Gm-Message-State: AOAM533UlCozGX/KmeiHszH6Mm7LPNzELAigKFKaSxRT0UdGMkjILAGa
        tLFllzDTkzmUW1hSUXEprUsIyUCpl210rn3uckz8vbSjp/832J/jP8JHV5PybmsKW/5HV32zjlu
        pUpLIe6bSmlK/ZWlhW492EepjaV4fyjZ9phL3EcgikQ==
X-Received: by 2002:a05:6402:2319:: with SMTP id l25mr7064706eda.383.1627163390852;
        Sat, 24 Jul 2021 14:49:50 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzVmroArzmZZewaThv5NERtSr6DdqGjVj6PwhmXYk16ol5TEWO2j+oQ71hzjvO1anxFeNOqpw==
X-Received: by 2002:a05:6402:2319:: with SMTP id l25mr7064689eda.383.1627163390689;
        Sat, 24 Jul 2021 14:49:50 -0700 (PDT)
Received: from localhost.localdomain ([86.32.47.9])
        by smtp.gmail.com with ESMTPSA id s10sm12821908ejc.39.2021.07.24.14.49.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Jul 2021 14:49:50 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Charles Gorand <charles.gorand@effinnov.com>,
        Krzysztof Opasiak <k.opasiak@samsung.com>,
        Mark Greer <mgreer@animalcreek.com>,
        Bongsu Jeon <bongsu.jeon@samsung.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        linux-wireless@vger.kernel.org
Subject: [PATCH 08/12] nfc: constify nfc_hci_gate
Date:   Sat, 24 Jul 2021 23:49:24 +0200
Message-Id: <20210724214928.122096-3-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210724214743.121884-1-krzysztof.kozlowski@canonical.com>
References: <20210724214743.121884-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Neither the core nor the drivers modify the passed pointer to struct
nfc_hci_gate, so make it a pointer to const for correctness and safety.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 drivers/nfc/microread/microread.c | 2 +-
 drivers/nfc/pn544/pn544.c         | 2 +-
 drivers/nfc/st21nfca/core.c       | 2 +-
 net/nfc/hci/core.c                | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/nfc/microread/microread.c b/drivers/nfc/microread/microread.c
index a5d5c3ec65f9..151a0631ec72 100644
--- a/drivers/nfc/microread/microread.c
+++ b/drivers/nfc/microread/microread.c
@@ -131,7 +131,7 @@
 #define MICROREAD_ELT_ID_SE2 0x04
 #define MICROREAD_ELT_ID_SE3 0x05
 
-static struct nfc_hci_gate microread_gates[] = {
+static const struct nfc_hci_gate microread_gates[] = {
 	{MICROREAD_GATE_ID_ADM, MICROREAD_PIPE_ID_ADMIN},
 	{MICROREAD_GATE_ID_LOOPBACK, MICROREAD_PIPE_ID_HDS_LOOPBACK},
 	{MICROREAD_GATE_ID_IDT, MICROREAD_PIPE_ID_HDS_IDT},
diff --git a/drivers/nfc/pn544/pn544.c b/drivers/nfc/pn544/pn544.c
index 23faa46bb486..f4d09ebba5c8 100644
--- a/drivers/nfc/pn544/pn544.c
+++ b/drivers/nfc/pn544/pn544.c
@@ -86,7 +86,7 @@ enum pn544_state {
 #define PN544_HCI_CMD_ATTREQUEST		0x12
 #define PN544_HCI_CMD_CONTINUE_ACTIVATION	0x13
 
-static struct nfc_hci_gate pn544_gates[] = {
+static const struct nfc_hci_gate pn544_gates[] = {
 	{NFC_HCI_ADMIN_GATE, NFC_HCI_INVALID_PIPE},
 	{NFC_HCI_LOOPBACK_GATE, NFC_HCI_INVALID_PIPE},
 	{NFC_HCI_ID_MGMT_GATE, NFC_HCI_INVALID_PIPE},
diff --git a/drivers/nfc/st21nfca/core.c b/drivers/nfc/st21nfca/core.c
index 583c36d4ff67..675f8a342869 100644
--- a/drivers/nfc/st21nfca/core.c
+++ b/drivers/nfc/st21nfca/core.c
@@ -72,7 +72,7 @@
 
 static DECLARE_BITMAP(dev_mask, ST21NFCA_NUM_DEVICES);
 
-static struct nfc_hci_gate st21nfca_gates[] = {
+static const struct nfc_hci_gate st21nfca_gates[] = {
 	{NFC_HCI_ADMIN_GATE, NFC_HCI_ADMIN_PIPE},
 	{NFC_HCI_LINK_MGMT_GATE, NFC_HCI_LINK_MGMT_PIPE},
 	{ST21NFCA_DEVICE_MGNT_GATE, ST21NFCA_DEVICE_MGNT_PIPE},
diff --git a/net/nfc/hci/core.c b/net/nfc/hci/core.c
index 3481941be70b..e37d30302b06 100644
--- a/net/nfc/hci/core.c
+++ b/net/nfc/hci/core.c
@@ -447,7 +447,7 @@ static void nfc_hci_cmd_timeout(struct timer_list *t)
 }
 
 static int hci_dev_connect_gates(struct nfc_hci_dev *hdev, u8 gate_count,
-				 struct nfc_hci_gate *gates)
+				 const struct nfc_hci_gate *gates)
 {
 	int r;
 	while (gate_count--) {
-- 
2.27.0

