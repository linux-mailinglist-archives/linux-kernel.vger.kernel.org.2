Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAF6F389EF3
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 09:31:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230507AbhETHdO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 03:33:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230484AbhETHdN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 03:33:13 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4A63C061760
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 00:31:48 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id v12so16507944wrq.6
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 00:31:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AX9UJdkScEdnsuqA+e3cbBPgNM6jgDtJcxN/2LdsVjY=;
        b=NXNdoEChth+QHQQusotYXDdQSrZeyuu2Ac7f0XklNEL6PRynGLj4yBCnsE17osQ2ED
         PLX5QY+M58Qo2KOla6PeAKJwiBv9Mq0Qenzh2kHuMT8bLAqVEBkHZpYdTdXE7hV7i9I8
         kzErqDcXYhYeAQVbJRwns7AcoKx0aKje5kXC+G74BoUIOnI92+44wPxDdbCM/2Tariv/
         mqizsHpbet77RQbuMBM20ma8X4IMfryFFTRayzhkABYjeKn1Q5iHGQc/gWHQChYKTAM7
         4Ct6/ZTsgp2+TYf7Y2kD1Cv6f8ficIhOb4PDbkAMU2cZQ8334dYuXzhz5MffUPJ1Wa0p
         Wzcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AX9UJdkScEdnsuqA+e3cbBPgNM6jgDtJcxN/2LdsVjY=;
        b=hT4HgSvyJ/Zx2nZ6eC8t5/KCi+2aT3Ys65EYlPfdiuOyZKWS7XMvpGKcp4QRF15gnP
         qLU9S3/KXX8Cq7kkKJ+BT7w/t0wNLkJIzaYlFOoZaqqQVUjZPVuL52lC00PLaLz48dHb
         8XZp5WshqV/MTF8C6jPJ9HKtOizzJt4+EQiZqo4iUN5jYILOPtUUMwmBbQfUP9uc0Bi+
         NS1BTojq1PG6f83SsYfu8fWNEy5OZg2I8aiS/OpvER9XeTgGZ81d45lmQSUVczSQBLEv
         rcRFhu0gpTtU5GG2i7+rlveqbUc6zh0DgL1x4EmUQLm3/bYe0Z+16ab4YmlBGiA0L4T7
         6+6g==
X-Gm-Message-State: AOAM532NhXbIkvabJNvKfAOeWyhnRF18yfrAtmvydERYDJwEQrqnumqz
        Up4T0RSVMDsDdQQFfo0rsZPTqOnJAfkqXA==
X-Google-Smtp-Source: ABdhPJyQX1KBfytXyZKHPcLunFU+XbTr8fHcoxEqDTKSWfzltphYDK+CFHr3Jaqjsouy9IyHXiMbIw==
X-Received: by 2002:a05:6000:186a:: with SMTP id d10mr2810801wri.41.1621495907520;
        Thu, 20 May 2021 00:31:47 -0700 (PDT)
Received: from jackdaw.baylibre.com (82-65-169-74.subs.proxad.net. [82.65.169.74])
        by smtp.googlemail.com with ESMTPSA id u19sm1637050wmq.7.2021.05.20.00.31.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 May 2021 00:31:47 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] clk: meson: axg-audio: improve deferral handling
Date:   Thu, 20 May 2021 09:31:36 +0200
Message-Id: <20210520073136.272925-1-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use dev_err_probe() for clock and reset resources to indicate the deferral
reason through sysfs when waiting for the resource to come up.

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 This is a follow up on
 https://lore.kernel.org/r/20210429090516.61085-1-jbrunet@baylibre.com

 drivers/clk/meson/axg-audio.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/meson/axg-audio.c b/drivers/clk/meson/axg-audio.c
index 7c8d02164443..bfe36bd41339 100644
--- a/drivers/clk/meson/axg-audio.c
+++ b/drivers/clk/meson/axg-audio.c
@@ -1665,8 +1665,7 @@ static int devm_clk_get_enable(struct device *dev, char *id)
 	clk = devm_clk_get(dev, id);
 	if (IS_ERR(clk)) {
 		ret = PTR_ERR(clk);
-		if (ret != -EPROBE_DEFER)
-			dev_err(dev, "failed to get %s", id);
+		dev_err_probe(dev, ret, "failed to get %s", id);
 		return ret;
 	}
 
@@ -1811,7 +1810,7 @@ static int axg_audio_clkc_probe(struct platform_device *pdev)
 
 	ret = device_reset(dev);
 	if (ret) {
-		dev_err(dev, "failed to reset device\n");
+		dev_err_probe(dev, ret, "failed to reset device\n");
 		return ret;
 	}
 
-- 
2.31.1

