Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B21C9402882
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Sep 2021 14:19:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344653AbhIGMUW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Sep 2021 08:20:22 -0400
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:36948
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1344155AbhIGMTh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Sep 2021 08:19:37 -0400
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com [209.85.128.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 959D84018B
        for <linux-kernel@vger.kernel.org>; Tue,  7 Sep 2021 12:18:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1631017110;
        bh=NBr1U4LAwKajfkWi8d66f/F7DJmWNcP01ndf/w7qpqs=;
        h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=PN/OgM3lunGwgycn8et2C4vNacltmKKfNlmUUFbrGWpS3C4ybrYeybVbCB/ociM15
         VLBswpaUVEvRR0gwRmEj3dCotqrvlEyrfcj14XqtadaRbGxwS3qUFo7aICSgeBuCoX
         gFcwDXEiX1EV0u/N5vHhjtIUiBUK57RfB9T/EpYdAKw7Wv23EtsUp3+hM0Z1Sw6gnv
         WlWNQh3kTXj/28whJnw4wecELya0uzowKAHYiScEd67ter83Xv5duSVX1p5ba6qgJp
         g6bXfmpT+fIXZ1toEkaAnobqxkzbD/SFzMvTcVFPTUYNd7kxLZOGBEroQPovrASCbF
         BlAgAQV2cX9dQ==
Received: by mail-wm1-f70.google.com with SMTP id o20-20020a05600c379400b002e755735eedso1052999wmr.0
        for <linux-kernel@vger.kernel.org>; Tue, 07 Sep 2021 05:18:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NBr1U4LAwKajfkWi8d66f/F7DJmWNcP01ndf/w7qpqs=;
        b=ih6zyLj6slb9vpTr626deWKCeAdjVy5+8g6orb0S30jXfmzOWvyg9eGAQyBfuYJfUI
         AVaaKnTNspwlvMfZ5+mluqy8542hBE3yxWdiej27Wwf4VAIKA2QEQpHXySGMzgySj8Rb
         Rvr8MQsQU9MSX95YQv7UKBfvwaiWWdjYAWswhGxK8DTl/mRUVChAOLNnegjzTJZBlXY3
         sgC2hO7NrZB8Tvi6pdB1MmLgCOCjOdrmODtSU4228jQNV834kSECRBxNKfLWKFHPkMjx
         UDLeNmcNX44Bi3MQtongFLpCrbMyV1m1LjzsaHQoLS9xUT8F2vU8i3rtBpsf1Xi+aeAv
         zKkg==
X-Gm-Message-State: AOAM531oS+P5E4mPeHGaZXpVqQQ4MqvTANgfO0R/B6XbRexO1GGaF/oS
        7gk+W4E/riLmdrrV74cPehwfK4qtX29zcaZdyC743HpWhfasI76HCIMEd/efQP+So1q8LHWJof2
        h6372txaytIYEw5FPMLIajxFkniwfzFMiNh9b9zAlMw==
X-Received: by 2002:a05:600c:210a:: with SMTP id u10mr3577104wml.127.1631017110346;
        Tue, 07 Sep 2021 05:18:30 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwpmN+J+nVSHJybMfzx2E98USXqdlKN6XTJk2Iwf0j0Co7NOrQuorgTzMhtPjYxrxKxWVDRvA==
X-Received: by 2002:a05:600c:210a:: with SMTP id u10mr3577088wml.127.1631017110234;
        Tue, 07 Sep 2021 05:18:30 -0700 (PDT)
Received: from kozik-lap.lan ([79.98.113.47])
        by smtp.gmail.com with ESMTPSA id m3sm13525216wrg.45.2021.09.07.05.18.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Sep 2021 05:18:29 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Krzysztof Opasiak <k.opasiak@samsung.com>,
        Mark Greer <mgreer@animalcreek.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, linux-nfc@lists.01.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-wireless@vger.kernel.org
Subject: [PATCH 07/15] nfc: pn544: drop unneeded debug prints
Date:   Tue,  7 Sep 2021 14:18:08 +0200
Message-Id: <20210907121816.37750-8-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210907121816.37750-1-krzysztof.kozlowski@canonical.com>
References: <20210907121816.37750-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ftrace is a preferred and standard way to debug entering and exiting
functions so drop useless debug prints.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 drivers/nfc/pn544/mei.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/nfc/pn544/mei.c b/drivers/nfc/pn544/mei.c
index 5c10aac085a4..a519fa0a53e2 100644
--- a/drivers/nfc/pn544/mei.c
+++ b/drivers/nfc/pn544/mei.c
@@ -22,8 +22,6 @@ static int pn544_mei_probe(struct mei_cl_device *cldev,
 	struct nfc_mei_phy *phy;
 	int r;
 
-	pr_info("Probing NFC pn544\n");
-
 	phy = nfc_mei_phy_alloc(cldev);
 	if (!phy) {
 		pr_err("Cannot allocate memory for pn544 mei phy.\n");
@@ -46,8 +44,6 @@ static void pn544_mei_remove(struct mei_cl_device *cldev)
 {
 	struct nfc_mei_phy *phy = mei_cldev_get_drvdata(cldev);
 
-	pr_info("Removing pn544\n");
-
 	pn544_hci_remove(phy->hdev);
 
 	nfc_mei_phy_free(phy);
-- 
2.30.2

