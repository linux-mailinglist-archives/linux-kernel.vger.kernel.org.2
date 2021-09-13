Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A69C408E41
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Sep 2021 15:34:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240666AbhIMNc2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Sep 2021 09:32:28 -0400
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:34140
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241732AbhIMNZ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Sep 2021 09:25:27 -0400
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com [209.85.128.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id A1DC340277
        for <linux-kernel@vger.kernel.org>; Mon, 13 Sep 2021 13:20:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1631539255;
        bh=alAZCnXDBZFqFGCWdjT1NtYwVcFPW4mHC6+AQVNQmag=;
        h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=DiHvUSDj8TvjNvAVoX5U6pEsOSih/KSUNCG94ei+WC8RkKpZl/xZuWDgoh3cMY/Ep
         JKdnaO7seOPk3NEYLvXEllNk09mTGa/X9dk+40bPkX9bwGG8Rpp1o6blGAF7oSPcvm
         4tHHFYNln/ws1PvF6kFez6nI6iFXfg5T+Jw5bBjD+v79hgkKKoNhSPMqb3FiLMXSti
         yKHievZQXsE2WxPMQrw+pa7mcNQkOvUS2OUFJcnbHC3YOPrwjklgu8brVt+ZP0wCF8
         SYNODSTLNCKDHMQ7mymSdbm5+Ni49s9rzyAJdi9Yyf2XoUVqe3sTz8qss+41jocfkg
         aYpBH/RrjLQfA==
Received: by mail-wm1-f71.google.com with SMTP id m16-20020a7bca50000000b002ee5287d4bfso1653473wml.7
        for <linux-kernel@vger.kernel.org>; Mon, 13 Sep 2021 06:20:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=alAZCnXDBZFqFGCWdjT1NtYwVcFPW4mHC6+AQVNQmag=;
        b=o3ztkaDyqsGnBgIqypB1nGWQTHBBaiR/LmCHRVFfv7Kr0jCZEmcC0bqqKYKIFWDCle
         +S0X2jjvwY/B9E71UgFHzPc4+XlCx8hm5yWlQtSHyYGFNAfpWXbdYojVBrsb6AlYorp5
         7C3ado04GKb1OVQXFItFbqesRFGSMDs1bHMcKYIMjJr16jm9QSeBfuxg/rCZzcm6nfUv
         fp49lvOAEGZpkAYX/bEoaa3mT9sb73zW5aisxUtjYJAxB3vRVbyIWkI2VBQLKMsfP5xw
         opI41CQa/hkPM9ceSRp1T2GxSSsqM2bagUjI2dhZgjOowrUuJPaq/D2udaAUhukC0TcY
         88QQ==
X-Gm-Message-State: AOAM532xf9/sol/cdnZPNsmfTAtFUG7jztgrGnU5xCXeTw3+Jpv1snEF
        ly0qn/P4HJYQGiBQ8MWL7+Np+5znB9acS9i/Ne2VX71u/oj6CqvtokpL5re6OlS3VSqhPZM1XMs
        w9Cynob6jKMGURd9dxXqPxn6T+9dLB4pIy2WxxY7GxA==
X-Received: by 2002:a5d:6792:: with SMTP id v18mr12576735wru.416.1631539255419;
        Mon, 13 Sep 2021 06:20:55 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwY6LXmCoBiMxgVg0ZBqajR5G6WaCpegfR/vq0xViC/Z1KjH8g67spH4c6MeVe7uNeK0A2zmQ==
X-Received: by 2002:a5d:6792:: with SMTP id v18mr12576720wru.416.1631539255299;
        Mon, 13 Sep 2021 06:20:55 -0700 (PDT)
Received: from kozik-lap.lan (lk.84.20.244.219.dc.cable.static.lj-kabel.net. [84.20.244.219])
        by smtp.gmail.com with ESMTPSA id n3sm7195888wmi.0.2021.09.13.06.20.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Sep 2021 06:20:54 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Krzysztof Opasiak <k.opasiak@samsung.com>,
        Mark Greer <mgreer@animalcreek.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, linux-nfc@lists.01.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-wireless@vger.kernel.org
Subject: [PATCH v2 08/15] nfc: pn544: drop unneeded memory allocation fail messages
Date:   Mon, 13 Sep 2021 15:20:28 +0200
Message-Id: <20210913132035.242870-9-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210913132035.242870-1-krzysztof.kozlowski@canonical.com>
References: <20210913132035.242870-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

nfc_mei_phy_alloc() already prints an error message on memory allocation
failure.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 drivers/nfc/pn544/mei.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/nfc/pn544/mei.c b/drivers/nfc/pn544/mei.c
index a519fa0a53e2..c493f2dbd0e2 100644
--- a/drivers/nfc/pn544/mei.c
+++ b/drivers/nfc/pn544/mei.c
@@ -23,10 +23,8 @@ static int pn544_mei_probe(struct mei_cl_device *cldev,
 	int r;
 
 	phy = nfc_mei_phy_alloc(cldev);
-	if (!phy) {
-		pr_err("Cannot allocate memory for pn544 mei phy.\n");
+	if (!phy)
 		return -ENOMEM;
-	}
 
 	r = pn544_hci_probe(phy, &mei_phy_ops, LLC_NOP_NAME,
 			    MEI_NFC_HEADER_SIZE, 0, MEI_NFC_MAX_HCI_PAYLOAD,
-- 
2.30.2

