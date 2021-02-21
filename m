Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3CF2320A8B
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Feb 2021 14:25:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229908AbhBUNZX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Feb 2021 08:25:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229588AbhBUNZT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Feb 2021 08:25:19 -0500
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D61FC061786
        for <linux-kernel@vger.kernel.org>; Sun, 21 Feb 2021 05:24:39 -0800 (PST)
Received: by mail-lj1-x232.google.com with SMTP id r23so48388276ljh.1
        for <linux-kernel@vger.kernel.org>; Sun, 21 Feb 2021 05:24:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=B8GAmfaPSIsKJ3KPNf6WDO+qOltP+zM0QMocmHGYNng=;
        b=hBzdKXPTk/0IW0OB4DO34awMibvrjRkm3f+6WXxhD+v2YuZfDdGv9ib0KaGGhyCe04
         4V8jHDAYs4BAnT+XHO9iTv3mQ6KsBbKmYC26OFd5XknULGCVKvKWMMfcacIhS0Jf8swn
         OHhLkRlLgqPMaQObXOCNxmZrbuvTysuLuOt1AybFVGQOeO7WkjDOYO4Li7Dkg+2JAvyN
         w6QFSM7zAkOkUO72j0VEUBN4IeXUYB+ij7fQ5NlKs0bUxsNj70Q+QLVj568hHYZZNJMu
         92k0iO0GdvvPAr0LeFF3p3Co2i2xWgh2ZgW339G1A1SHVS2qdD/hhS844dBAvkLmzfTm
         wcNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=B8GAmfaPSIsKJ3KPNf6WDO+qOltP+zM0QMocmHGYNng=;
        b=VFg0+ma5OgzmqcUJ6ze4zVsm8HG0RtrBwUShr3TyC5IRqIKRLm4f6q89kC3/UHnxQc
         Sna0mwbPg+iEzvjFrsDa9ONyiyxBbKZBxZv/pTdpVL0hlYVXpJJziRDMMPFifm48PPIo
         ekiKCLOgNo6fD6IYKwyviQTF1i6DkoexhldaQUR76uCGW5KwJjNkZyI37FLdxGkGF2C/
         i/0mdgsHgN+oWwXQR6K8DEevTc/LMbrTMAuk4/c6XUYY5Aryx/gYAKvKB68ZGwKdJeZo
         Xz6M1ARHDbcd6q8ExYtVOeuwBtVIB2FHz8e9ddJBy+NP94U9YEgJcDzuSbgZgd6NIwqK
         mphA==
X-Gm-Message-State: AOAM530cdyK6qnmiHjR/yNcb8BhBsxsEUuOBNNWnRaRSAAWWScMna9mC
        rNSBStbzbCAgrwSWUJ1fEUE=
X-Google-Smtp-Source: ABdhPJwWHTJUIreIp07AO7VPMa5Rdy4v/DwO9Sm4hFglzCamG2iCltOxiYXpF1XVcDzMNPdsZpysww==
X-Received: by 2002:a2e:854d:: with SMTP id u13mr6577195ljj.99.1613913877666;
        Sun, 21 Feb 2021 05:24:37 -0800 (PST)
Received: from msi.localdomain (vmpool.ut.mephi.ru. [85.143.112.90])
        by smtp.gmail.com with ESMTPSA id s10sm1684637ljo.115.2021.02.21.05.24.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Feb 2021 05:24:37 -0800 (PST)
From:   Nikolay Kyx <knv418@gmail.com>
To:     gregkh@linuxfoundation.org, sergiu.cuciurean@analog.com
Cc:     Nikolay Kyx <knv418@gmail.com>, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 01/02] staging: kpc2000: code style: match alignment with open parenthesis
Date:   Sun, 21 Feb 2021 16:22:45 +0300
Message-Id: <20210221132246.1154-1-knv418@gmail.com>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <YDJaHNsT9zta2up2@kroah.com>
References: <YDJaHNsT9zta2up2@kroah.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes the following checkpatch.pl check:

CHECK: Alignment should match open parenthesis

in files kpc2000_i2c.c kpc2000_spi.c

Signed-off-by: Nikolay Kyx <knv418@gmail.com>
---

Additionally some style warnings remain valid here and could be fixed by
another patch.

v2: Edited changelog, as suggested by Greg KH <gregkh@linuxfoundation.org>
v3: Splitted patch in two parts, as suggested by Greg KH <gregkh@linuxfoundation.org>
v4: Changed patch subject line, as suggested by Greg KH <gregkh@linuxfoundation.org>

 drivers/staging/kpc2000/kpc2000_i2c.c | 2 +-
 drivers/staging/kpc2000/kpc2000_spi.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/kpc2000/kpc2000_i2c.c b/drivers/staging/kpc2000/kpc2000_i2c.c
index 25bb5c97dd21..3f1f833d3b51 100644
--- a/drivers/staging/kpc2000/kpc2000_i2c.c
+++ b/drivers/staging/kpc2000/kpc2000_i2c.c
@@ -269,7 +269,7 @@ static int i801_block_transaction_by_block(struct kpc_i2c *priv,
 	}
 
 	status = i801_transaction(priv,
-			I801_BLOCK_DATA | ENABLE_INT9 | I801_PEC_EN * hwpec);
+				  I801_BLOCK_DATA | ENABLE_INT9 | I801_PEC_EN * hwpec);
 	if (status)
 		return status;
 
diff --git a/drivers/staging/kpc2000/kpc2000_spi.c b/drivers/staging/kpc2000/kpc2000_spi.c
index 44017d523da5..16ca18b8aa15 100644
--- a/drivers/staging/kpc2000/kpc2000_spi.c
+++ b/drivers/staging/kpc2000/kpc2000_spi.c
@@ -465,7 +465,7 @@ kp_spi_probe(struct platform_device *pldev)
 	}
 
 	kpspi->base = devm_ioremap(&pldev->dev, r->start,
-					   resource_size(r));
+				   resource_size(r));
 
 	status = spi_register_master(master);
 	if (status < 0) {
-- 
2.30.1

