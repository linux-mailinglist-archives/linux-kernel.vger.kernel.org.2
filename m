Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 009B4425461
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Oct 2021 15:38:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241802AbhJGNki (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Oct 2021 09:40:38 -0400
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:51988
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241756AbhJGNkZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Oct 2021 09:40:25 -0400
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com [209.85.208.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 8E55B4000D
        for <linux-kernel@vger.kernel.org>; Thu,  7 Oct 2021 13:38:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1633613907;
        bh=Caod7f/lk82yPL9l72YPa9/xdZxrVhuurClzVai7YFo=;
        h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=wNNOXXlUwtFaXTccXUa4tqqTzfXMxsemp87Xwj23vUQ5ne22j84qPlN6VGN4iZOqY
         qLtwj+0JrpLosbJGup63J5OKwLm0QXilUxALXquwHarMmHj+6s8EDjztpTaiRQ+FpG
         BrfHzOBQ6lEz22HK7tK7I92K1gTkEmFDmYxG45jVurM9Cjq+2aRTJ1KQ1chqE/Rs6j
         qrYuHO48O5dLXQKbhZ3aHYQLW3CLJBn9U2LV0uNTgmfUxCwO9s67CGru28dDDaQL+E
         NnVLbU9h9sOIXmwDzUwQw/KdoWq2aqzQF00rB332BRyke3aVpmhT1cj9bMYFp29ur6
         Noiza3ShjE0Aw==
Received: by mail-ed1-f72.google.com with SMTP id d11-20020a50cd4b000000b003da63711a8aso5866628edj.20
        for <linux-kernel@vger.kernel.org>; Thu, 07 Oct 2021 06:38:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Caod7f/lk82yPL9l72YPa9/xdZxrVhuurClzVai7YFo=;
        b=GMbzkburgqQJUGPV2lATGan2SH+xbAWED4PUI0U3n54ewgkePjjJ8uUGZFYNlzS3Bb
         m70jSn7Dmab+5MOfBhciMxIdlfkLX4VHETOdB8fEy6KdL7Qd87W49s89Rl8hxB4E0hAq
         hoIAQn1ONKbmodavi6ZJbgg6gK+MSeFMWA4r/zN4Euwg3lBGOUXZFOdlP3vGJBdOZBeG
         kFNJNOdPDeLgjz6GLWyleklQlkrBOkuwAOhCuX6dG2hwmUwv01m6IjIshlj0q4KhPyDX
         OlkJn4YFMW4nfbgqBwbXMI2F8nbxITKR4KqJ+oJ2zFhkaOQApn/GyGBcnrls45Yp1nvs
         pcoA==
X-Gm-Message-State: AOAM533sV2eQliYMFXKhJLUaNkBdqfq9KPSDU+p6a3dTPE6AIrdSnKPp
        o8Cb3OJX6/SJB3kXLE5NN02zXQ55pMxoVnBvubmjE2cXLyCdeZqr95XqvQ/WCRQ6WMsIPLn8tUj
        U3+2XpvnyDzHelgWlMoCsu66I1N11fIIiKqc3207ViA==
X-Received: by 2002:a17:906:ae14:: with SMTP id le20mr5850198ejb.89.1633613906949;
        Thu, 07 Oct 2021 06:38:26 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwhM44QMJ2eosub/50WjbhCTf/eolBEhiGbo3QX3lfBJRMrgvITyIbkdtt7+Q73mJANGS4yFA==
X-Received: by 2002:a17:906:ae14:: with SMTP id le20mr5850180ejb.89.1633613906761;
        Thu, 07 Oct 2021 06:38:26 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-186-13.adslplus.ch. [188.155.186.13])
        by smtp.gmail.com with ESMTPSA id ay19sm8585613edb.20.2021.10.07.06.38.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Oct 2021 06:38:26 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Krzysztof Opasiak <k.opasiak@samsung.com>,
        Mark Greer <mgreer@animalcreek.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, linux-nfc@lists.01.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-wireless@vger.kernel.org
Subject: [RESEND PATCH v2 7/7] nfc: microread: drop unneeded debug prints
Date:   Thu,  7 Oct 2021 15:30:21 +0200
Message-Id: <20211007133021.32704-8-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211007133021.32704-1-krzysztof.kozlowski@canonical.com>
References: <20211007133021.32704-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ftrace is a preferred and standard way to debug entering and exiting
functions so drop useless debug prints.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 drivers/nfc/microread/i2c.c | 4 ----
 drivers/nfc/microread/mei.c | 2 --
 2 files changed, 6 deletions(-)

diff --git a/drivers/nfc/microread/i2c.c b/drivers/nfc/microread/i2c.c
index 86f593c73ed6..067295124eb9 100644
--- a/drivers/nfc/microread/i2c.c
+++ b/drivers/nfc/microread/i2c.c
@@ -237,8 +237,6 @@ static int microread_i2c_probe(struct i2c_client *client,
 	struct microread_i2c_phy *phy;
 	int r;
 
-	dev_dbg(&client->dev, "client %p\n", client);
-
 	phy = devm_kzalloc(&client->dev, sizeof(struct microread_i2c_phy),
 			   GFP_KERNEL);
 	if (!phy)
@@ -262,8 +260,6 @@ static int microread_i2c_probe(struct i2c_client *client,
 	if (r < 0)
 		goto err_irq;
 
-	nfc_info(&client->dev, "Probed\n");
-
 	return 0;
 
 err_irq:
diff --git a/drivers/nfc/microread/mei.c b/drivers/nfc/microread/mei.c
index 00689e18dc46..e2a77a5fc887 100644
--- a/drivers/nfc/microread/mei.c
+++ b/drivers/nfc/microread/mei.c
@@ -23,8 +23,6 @@ static int microread_mei_probe(struct mei_cl_device *cldev,
 	struct nfc_mei_phy *phy;
 	int r;
 
-	pr_info("Probing NFC microread\n");
-
 	phy = nfc_mei_phy_alloc(cldev);
 	if (!phy)
 		return -ENOMEM;
-- 
2.30.2

