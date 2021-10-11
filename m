Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DA38428E4A
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Oct 2021 15:39:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237203AbhJKNlk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Oct 2021 09:41:40 -0400
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:42386
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237144AbhJKNl3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Oct 2021 09:41:29 -0400
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com [209.85.167.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id B5EEF3FFFE
        for <linux-kernel@vger.kernel.org>; Mon, 11 Oct 2021 13:39:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1633959568;
        bh=Caod7f/lk82yPL9l72YPa9/xdZxrVhuurClzVai7YFo=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=jJUAZSjsmDAE0kL5aiPuGE709vSLqwUiWLkGDVZMRMYdkcKMuAMSqlwKWW2LPAOJP
         WUcJihliJQEJTl9+jDmOdBguCgxs9kSLhw5L0CdC+3kRvF4Nmeq5gSKW3NA1vHaMIP
         MSW1GMm5IzWAopbmhCjB01Qy39gHDhXlwSsutpQvfdyNIbXTwjGELdf163QLeNrw1L
         ONzvNRRmWEzBgcTNWNOvJRvTZ2UtKcGL4VKlY9BJZeoTjnzB/BlZM3TLVn6qVwNknO
         331kqSYsWjQtEyyloJ/Zw3hN5S3hjtB/Ub3e9I3lxAOhIB++KYXg79jKscJo0spvRL
         DQvKrI4vgMe0Q==
Received: by mail-lf1-f69.google.com with SMTP id bt36-20020a056512262400b003fd7e6a96e8so4219018lfb.19
        for <linux-kernel@vger.kernel.org>; Mon, 11 Oct 2021 06:39:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Caod7f/lk82yPL9l72YPa9/xdZxrVhuurClzVai7YFo=;
        b=sry0EaciiX6Vb+u+htWbiEKc2qirkFfw6aSceP61rwHTURYLa9VxVZMPvxPZbabPSR
         CGhR8eicPVYljg9c5noB3XRq2SBDEH81J2jXD1lOjFOb0YqYtEyzZ4F5YS81gbHkXzW3
         dSBBjg9kHj3nOsWPSg0zJTmV8rkl3gnSX05Ay9jxFP06YRmsT/Svcj+wmOOoMTl6CChS
         rmY6QQWX/LcqGCUsrbgNgt7cZDjJSH8v/WX4ygryLspgEf1pHbeESJhgCAASOnaLaa9M
         e1r2X3j/qY/8OAyqbtBJHD1HaequCLRMoq5KYi3ESQvs9tGL6hHQpGGjYsrnw2R8P0sV
         O81A==
X-Gm-Message-State: AOAM532t0/igMOU73/hQkCQqm02A5EsHPm2efCSxDy4aqWqVfhtSvS8d
        8rflj/9kmusTmeIqLXREQ3epWmdAbJKHZ4dV3oaFDd8nufGWqHuRmZaptKV9N70nUlpVA5alIt/
        bxRgUvMmPhotVVouGs4nSZFoK9D44M7kJtOtMQhO4Aw==
X-Received: by 2002:a05:6512:23a0:: with SMTP id c32mr28315071lfv.166.1633959568233;
        Mon, 11 Oct 2021 06:39:28 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxZiDLQW+5zqCPlBUX+HccXn6LAIXSmaJCIzfqIdMJzGyKW6xXiv/0sl+AlXYBAwxKOQrbchw==
X-Received: by 2002:a05:6512:23a0:: with SMTP id c32mr28315053lfv.166.1633959568082;
        Mon, 11 Oct 2021 06:39:28 -0700 (PDT)
Received: from localhost.localdomain (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id a21sm738971lff.37.2021.10.11.06.39.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Oct 2021 06:39:25 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Krzysztof Opasiak <k.opasiak@samsung.com>,
        Mark Greer <mgreer@animalcreek.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, linux-nfc@lists.01.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-wireless@vger.kernel.org
Cc:     joe@perches.com
Subject: [PATCH v3 7/7] nfc: microread: drop unneeded debug prints
Date:   Mon, 11 Oct 2021 15:38:35 +0200
Message-Id: <20211011133835.236347-8-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211011133835.236347-1-krzysztof.kozlowski@canonical.com>
References: <20211011133835.236347-1-krzysztof.kozlowski@canonical.com>
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

