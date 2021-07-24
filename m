Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AACD73D4A2F
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Jul 2021 23:48:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230218AbhGXVHs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Jul 2021 17:07:48 -0400
Received: from smtp-relay-canonical-0.canonical.com ([185.125.188.120]:58394
        "EHLO smtp-relay-canonical-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229601AbhGXVHm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Jul 2021 17:07:42 -0400
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com [209.85.218.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPS id 04C303F35D
        for <linux-kernel@vger.kernel.org>; Sat, 24 Jul 2021 21:48:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1627163292;
        bh=Cafb+vZCXBE2r3BRcaIZ4Rw/4xen96i9AebcqjRz32w=;
        h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=kJKJf19RJqX7J9TmqfkgbVXsCqPW9jDLKd8ktE8YebmMuRnezdaPYG7gvKbU9ChDY
         GdpJla2sWtwBHbI+QqP9OfTZBc4x4n1UDiq7hbDokSk+Rsu28LM5Iv9xqo1c1Lbo7s
         ra8mIKNBr7rMTp6htL7sxUgSpB134TLtczOeEvhuZM0wpzjFm+rnHiWlN4+oA4Q5t5
         v7JgjYz7+bTRSo+bxQ5JQ97YvYZrr4S/SNLSsO0LKUWl6aFXJ4Ero0QDavnD1stq9W
         SaZ+nm6NZOn74y4JYNK0IbGjD/OqgO3iAhGdbOHEMXSIJfqmUIbsaI1j7QuOIp9cfQ
         yMdIvglTNj03w==
Received: by mail-ej1-f71.google.com with SMTP id yl23-20020a17090693f7b029051a448bab28so1044776ejb.17
        for <linux-kernel@vger.kernel.org>; Sat, 24 Jul 2021 14:48:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Cafb+vZCXBE2r3BRcaIZ4Rw/4xen96i9AebcqjRz32w=;
        b=p5DWOb6wQxHgQ4D6DIx20G0NKOvj44AqgYZ6ZIWc1MC57ZsYI6uIb6v1fVtbfG/G2j
         MdBKC6Kc0vXOuVvGz2oy6sdbZxMeRfR0k5IVk7k9dDndnA/RXGrhA1XcviTwOcebMz1U
         c6UVzgROonWja42rKK5+2Wsbbm7AG0pa3v3V0XQs+y9cZyRB+YXpSdQec6UsXMkxVtwG
         bTclnZocPK/mTvvxpxeLDriki7naUPgeTOV6cCNOW7cbJIAOjORKe9eKG+ccr7g1prQU
         Pa1yNtWcOIHJNT5x8WJOxuPV7wjU1sfcLVktidfNXFcm5K5//ZB7NBIzpdzMeDsoYQHs
         kKZg==
X-Gm-Message-State: AOAM532u0za5RqavhEJaG0oRMtzYlGBzvybwgcXqVMo2z6IEcSJmhV9s
        Sz0h+rf5JsJDhhsh0f/HGzemZFJkRQuxtSC8p7EaT00Kx9taQ8ZWJUu7YUsgJWAm2z5M9twVLn9
        ix24QA/zmWL4mP1W1druYIPIN7sm3Sc4OrNa9gSH65Q==
X-Received: by 2002:a05:6402:1a3c:: with SMTP id be28mr13064452edb.15.1627163289663;
        Sat, 24 Jul 2021 14:48:09 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyFUM58aGKaHxO58kMsTBI7SVyFqHtKLuVZn+D1yBUPCbhbairNSRS8WTZxryZ7vHJNqJ3THg==
X-Received: by 2002:a05:6402:1a3c:: with SMTP id be28mr13064438edb.15.1627163289515;
        Sat, 24 Jul 2021 14:48:09 -0700 (PDT)
Received: from localhost.localdomain ([86.32.47.9])
        by smtp.gmail.com with ESMTPSA id j5sm8383005edv.10.2021.07.24.14.48.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Jul 2021 14:48:09 -0700 (PDT)
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
Subject: [PATCH 02/12] nfc: constify nci_ops
Date:   Sat, 24 Jul 2021 23:47:33 +0200
Message-Id: <20210724214743.121884-3-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210724214743.121884-1-krzysztof.kozlowski@canonical.com>
References: <20210724214743.121884-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The struct nci_ops is modified by NFC core in only one case:
nci_allocate_device() receives too many proprietary commands (prop_ops)
to configure.  This is a build time known constrain, so a graceful
handling of such case is not necessary.

Instead, fail the nci_allocate_device() and add BUILD_BUG_ON() to places
which set these.

This allows to constify the struct nci_ops (consisting of function
pointers) for correctness and safety.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 drivers/nfc/fdp/fdp.c        | 3 ++-
 drivers/nfc/nfcmrvl/main.c   | 2 +-
 drivers/nfc/nxp-nci/core.c   | 2 +-
 drivers/nfc/st-nci/core.c    | 3 ++-
 drivers/nfc/virtual_ncidev.c | 2 +-
 include/net/nfc/nci_core.h   | 4 ++--
 net/nfc/nci/core.c           | 5 ++---
 7 files changed, 11 insertions(+), 10 deletions(-)

diff --git a/drivers/nfc/fdp/fdp.c b/drivers/nfc/fdp/fdp.c
index 528745862738..73f51848a693 100644
--- a/drivers/nfc/fdp/fdp.c
+++ b/drivers/nfc/fdp/fdp.c
@@ -675,7 +675,7 @@ static struct nci_driver_ops fdp_prop_ops[] = {
 	},
 };
 
-static struct nci_ops nci_ops = {
+static const struct nci_ops nci_ops = {
 	.open = fdp_nci_open,
 	.close = fdp_nci_close,
 	.send = fdp_nci_send,
@@ -718,6 +718,7 @@ int fdp_nci_probe(struct fdp_i2c_phy *phy, struct nfc_phy_ops *phy_ops,
 		    NFC_PROTO_NFC_DEP_MASK |
 		    NFC_PROTO_ISO15693_MASK;
 
+	BUILD_BUG_ON(ARRAY_SIZE(fdp_prop_ops) > NCI_MAX_PROPRIETARY_CMD);
 	ndev = nci_allocate_device(&nci_ops, protocols, tx_headroom,
 				   tx_tailroom);
 	if (!ndev) {
diff --git a/drivers/nfc/nfcmrvl/main.c b/drivers/nfc/nfcmrvl/main.c
index a4620b480c4f..6e9e7ce8792c 100644
--- a/drivers/nfc/nfcmrvl/main.c
+++ b/drivers/nfc/nfcmrvl/main.c
@@ -81,7 +81,7 @@ static int nfcmrvl_nci_fw_download(struct nci_dev *ndev,
 	return nfcmrvl_fw_dnld_start(ndev, firmware_name);
 }
 
-static struct nci_ops nfcmrvl_nci_ops = {
+static const struct nci_ops nfcmrvl_nci_ops = {
 	.open = nfcmrvl_nci_open,
 	.close = nfcmrvl_nci_close,
 	.send = nfcmrvl_nci_send,
diff --git a/drivers/nfc/nxp-nci/core.c b/drivers/nfc/nxp-nci/core.c
index 2b0c7232e91f..518e2afb43a8 100644
--- a/drivers/nfc/nxp-nci/core.c
+++ b/drivers/nfc/nxp-nci/core.c
@@ -83,7 +83,7 @@ static int nxp_nci_send(struct nci_dev *ndev, struct sk_buff *skb)
 	return r;
 }
 
-static struct nci_ops nxp_nci_ops = {
+static const struct nci_ops nxp_nci_ops = {
 	.open = nxp_nci_open,
 	.close = nxp_nci_close,
 	.send = nxp_nci_send,
diff --git a/drivers/nfc/st-nci/core.c b/drivers/nfc/st-nci/core.c
index 110ff1281e5f..f6fce34a77da 100644
--- a/drivers/nfc/st-nci/core.c
+++ b/drivers/nfc/st-nci/core.c
@@ -94,7 +94,7 @@ static struct nci_driver_ops st_nci_prop_ops[] = {
 	},
 };
 
-static struct nci_ops st_nci_ops = {
+static const struct nci_ops st_nci_ops = {
 	.init = st_nci_init,
 	.open = st_nci_open,
 	.close = st_nci_close,
@@ -131,6 +131,7 @@ int st_nci_probe(struct llt_ndlc *ndlc, int phy_headroom,
 		| NFC_PROTO_ISO15693_MASK
 		| NFC_PROTO_NFC_DEP_MASK;
 
+	BUILD_BUG_ON(ARRAY_SIZE(st_nci_prop_ops) > NCI_MAX_PROPRIETARY_CMD);
 	ndlc->ndev = nci_allocate_device(&st_nci_ops, protocols,
 					phy_headroom, phy_tailroom);
 	if (!ndlc->ndev) {
diff --git a/drivers/nfc/virtual_ncidev.c b/drivers/nfc/virtual_ncidev.c
index f73ee0bf3593..b914ab2c2109 100644
--- a/drivers/nfc/virtual_ncidev.c
+++ b/drivers/nfc/virtual_ncidev.c
@@ -65,7 +65,7 @@ static int virtual_nci_send(struct nci_dev *ndev, struct sk_buff *skb)
 	return 0;
 }
 
-static struct nci_ops virtual_nci_ops = {
+static const struct nci_ops virtual_nci_ops = {
 	.open = virtual_nci_open,
 	.close = virtual_nci_close,
 	.send = virtual_nci_send
diff --git a/include/net/nfc/nci_core.h b/include/net/nfc/nci_core.h
index bf573eca07ca..5dae7e2cbc49 100644
--- a/include/net/nfc/nci_core.h
+++ b/include/net/nfc/nci_core.h
@@ -194,7 +194,7 @@ struct nci_hci_dev {
 /* NCI Core structures */
 struct nci_dev {
 	struct nfc_dev		*nfc_dev;
-	struct nci_ops		*ops;
+	const struct nci_ops	*ops;
 	struct nci_hci_dev	*hci_dev;
 
 	int			tx_headroom;
@@ -267,7 +267,7 @@ struct nci_dev {
 };
 
 /* ----- NCI Devices ----- */
-struct nci_dev *nci_allocate_device(struct nci_ops *ops,
+struct nci_dev *nci_allocate_device(const struct nci_ops *ops,
 				    __u32 supported_protocols,
 				    int tx_headroom,
 				    int tx_tailroom);
diff --git a/net/nfc/nci/core.c b/net/nfc/nci/core.c
index 09967b836361..a7d26f2791b0 100644
--- a/net/nfc/nci/core.c
+++ b/net/nfc/nci/core.c
@@ -1129,7 +1129,7 @@ static struct nfc_ops nci_nfc_ops = {
  * @tx_headroom: Reserved space at beginning of skb
  * @tx_tailroom: Reserved space at end of skb
  */
-struct nci_dev *nci_allocate_device(struct nci_ops *ops,
+struct nci_dev *nci_allocate_device(const struct nci_ops *ops,
 				    __u32 supported_protocols,
 				    int tx_headroom, int tx_tailroom)
 {
@@ -1152,8 +1152,7 @@ struct nci_dev *nci_allocate_device(struct nci_ops *ops,
 	if (ops->n_prop_ops > NCI_MAX_PROPRIETARY_CMD) {
 		pr_err("Too many proprietary commands: %zd\n",
 		       ops->n_prop_ops);
-		ops->prop_ops = NULL;
-		ops->n_prop_ops = 0;
+		goto free_nci;
 	}
 
 	ndev->tx_headroom = tx_headroom;
-- 
2.27.0

