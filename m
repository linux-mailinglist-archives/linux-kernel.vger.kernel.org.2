Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5F93408DE1
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Sep 2021 15:29:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240915AbhIMNab (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Sep 2021 09:30:31 -0400
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:57994
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240900AbhIMNXm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Sep 2021 09:23:42 -0400
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com [209.85.128.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 50F514026C
        for <linux-kernel@vger.kernel.org>; Mon, 13 Sep 2021 13:20:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1631539254;
        bh=NBr1U4LAwKajfkWi8d66f/F7DJmWNcP01ndf/w7qpqs=;
        h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=eKne7l7JsWA9Oyqv1ej25m2CyAPojw00ksawllNBhUEzH0ZbiNYz83s/f9tfqky5F
         nIdM5nruK+ENQJgamMXhOKzqvqbmCXZ0H7gNdv623agZNW7W2TuB96pz0byZuS9kyg
         1gIsNpbQ/fU/u2CvHGQ7E4mmq4mZF83AJeCB6w2dhSVcMdPe8ZpB4/rbC/mVA9BAH3
         jRY1ekDZCtXtrgeMFeSLZzbPulME9H2eq2URilg78BcpkGrFBSPkCj3QHpTJIw+OJb
         fpCvjHdVDEuROrY95Re+jRus9/7YOom1q421gYqjLlWq7zNYRyfRgH8AR48iUwxE9P
         KRmlgh5GimozA==
Received: by mail-wm1-f72.google.com with SMTP id m22-20020a7bca56000000b002e7508f3faeso4916609wml.2
        for <linux-kernel@vger.kernel.org>; Mon, 13 Sep 2021 06:20:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NBr1U4LAwKajfkWi8d66f/F7DJmWNcP01ndf/w7qpqs=;
        b=q/NnhApe7sGyfUCvSu3gXOgeQa+tKrkUSlPqtnCIAtLdCSkWwuhPHqQzj6hLF0BzBq
         WPI8TFb6787ptAjg4WNZcs8xd/yHGL0rlpp+Ero+Obx3ezlr6d/Jb9CpmpulmunzzuDZ
         KeufBdlfEyScimn0szaof5KJd8ITcD6aMNTNHKt/kfrK5NDx1vHr+6C1VLtT3wl/cPtW
         JHT+U3bOPA9dU2LzTOnT5vCaUd3m3lUSMdzWyKLDIrCj/GWj0BA78UUKJQeVfONkqfgp
         Xsc7Z2qJdbK4KQB+vOxD7lz9FZOvngXmG614gqJZYBcB+Y7i1Utwa4CmFDTfOA10Nz/z
         ktqA==
X-Gm-Message-State: AOAM532ihiPvUUHlGN517NHexE7E385VxFc60v5i1WiAAz+vUjYiu9u3
        CzSqytf8gjfFsGQI+O0sxMaoMoIYGANRXptzLTiSocs3SHeeLqakiOkf/Ry8fQqBJo0IPCgvcpD
        VmsobjvHHnQYdeXvp3JGfJdQ4DZOBFGdjgrZIyCGkPw==
X-Received: by 2002:a1c:f60c:: with SMTP id w12mr11300812wmc.3.1631539253784;
        Mon, 13 Sep 2021 06:20:53 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw4mhlijtrqBRrwe325QIJTV+NH9oRbw4vOfFD3MMxQ/lm7QV3e8395RpL+PFPpNFF13sZ40A==
X-Received: by 2002:a1c:f60c:: with SMTP id w12mr11300790wmc.3.1631539253600;
        Mon, 13 Sep 2021 06:20:53 -0700 (PDT)
Received: from kozik-lap.lan (lk.84.20.244.219.dc.cable.static.lj-kabel.net. [84.20.244.219])
        by smtp.gmail.com with ESMTPSA id n3sm7195888wmi.0.2021.09.13.06.20.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Sep 2021 06:20:53 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Krzysztof Opasiak <k.opasiak@samsung.com>,
        Mark Greer <mgreer@animalcreek.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, linux-nfc@lists.01.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-wireless@vger.kernel.org
Subject: [PATCH v2 07/15] nfc: pn544: drop unneeded debug prints
Date:   Mon, 13 Sep 2021 15:20:27 +0200
Message-Id: <20210913132035.242870-8-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210913132035.242870-1-krzysztof.kozlowski@canonical.com>
References: <20210913132035.242870-1-krzysztof.kozlowski@canonical.com>
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

