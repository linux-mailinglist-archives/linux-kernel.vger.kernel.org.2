Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 187E03AF5C0
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jun 2021 20:59:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231386AbhFUTBv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Jun 2021 15:01:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230189AbhFUTBt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jun 2021 15:01:49 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A859C061756
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jun 2021 11:59:34 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id i94so20826829wri.4
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jun 2021 11:59:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tDnzs4S5mWCJVykG1gJ2TrxiTAKGRBG0mNiuKKTkJDc=;
        b=IQZsErqzy0GD9BWUQSt0y7ojPiV79nkjcR0kDron5cYD9Prlnll6+uKAgSinS6BxCq
         wbd3Xhdz/kHPMBUqpr63I6CIdVMO4TJfQvx0Ji2YypFcd6QpzNPPI+h62pqXlvki9XbR
         CmbBAoEVcnKTZaFpO0ZujR/yV3r39AOG1YcDYI865wT3i2qR1VxJ6cP1VO4VrnAt9s9j
         WKZAlwh4SAdvqrRZxjwvqcQp9uazkFd0Uht6WrDoSKTocQqI7rH3J6LdXvR8KLzKMqqX
         dk3oFK+rNgEtDKTqV/B58tDy3Etkj98Anynkh8czotG46uDpBZuYqChfgr7M6It13SK9
         Z/TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tDnzs4S5mWCJVykG1gJ2TrxiTAKGRBG0mNiuKKTkJDc=;
        b=sl5SGAS6jRCvVTuE/SfZqYa1wHFyWWpeelWS0bOlGMgwg1XUrbM08V0eVnThgxZjKW
         Q6gHTlpUH4V9TO3GHQ8T2hLPEc0B1sMbAl1kD6kr7Y9xvEAMR+Q8fqelgECxIvXN220V
         IBTmFl6tUEj8oYVte52twhF+G736jFvE/zPoDVfP8g7nAKU90I5wOvJMIkZyNHpBv9H0
         U8wx6Pbl+iwik/clvicCr5+Qp6eaqeG1q9Nl/8kaN36ZsCKh1FXAax+4iup6+V7rYaaT
         DWP/Gr7CnB9dcICSIFoOBMg9EEppVWWsLrMU+nzw4MjmEFAdni7BBHtWf82BVeBv3BFs
         ii8A==
X-Gm-Message-State: AOAM530iBR9FLhWg/ycVSNCXzKD6QVqNTENbMKA4XzZRu1MPJGlXGtFO
        tRoxQftMT24Fz1V8N3i6tgtfAQ==
X-Google-Smtp-Source: ABdhPJzWBDHT4D757byXSDoPav1GnjgxtqgyBjgjRQ96BEfuZx3DWW6os8cshh4J3zQ0QMTS3s0PEQ==
X-Received: by 2002:a5d:59ae:: with SMTP id p14mr29381043wrr.188.1624301973014;
        Mon, 21 Jun 2021 11:59:33 -0700 (PDT)
Received: from localhost.localdomain (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id 9sm458818wmf.3.2021.06.21.11.59.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jun 2021 11:59:32 -0700 (PDT)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     davem@davemloft.net, herbert@gondor.apana.org.au,
        linus.walleij@linaro.org, ulli.kroll@googlemail.com
Cc:     linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, lkp@intel.com,
        Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH] crypto: sl3516: depends on HAS_IOMEM
Date:   Mon, 21 Jun 2021 18:59:26 +0000
Message-Id: <20210621185926.4181785-1-clabbe@baylibre.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The sl3516 driver need to depend on HAS_IOMEM.
This fixes a build error:
ERROR: modpost: "devm_platform_ioremap_resource" [drivers/crypto/gemini/sl3516-ce.ko] undefined!

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
 drivers/crypto/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/crypto/Kconfig b/drivers/crypto/Kconfig
index 99b090790178..4f3b7da24495 100644
--- a/drivers/crypto/Kconfig
+++ b/drivers/crypto/Kconfig
@@ -268,6 +268,7 @@ config CRYPTO_DEV_NIAGARA2
 
 config CRYPTO_DEV_SL3516
 	tristate "Stormlink SL3516 crypto offloader"
+	depends on HAS_IOMEM
 	select CRYPTO_SKCIPHER
 	select CRYPTO_ENGINE
 	select CRYPTO_ECB
-- 
2.31.1

