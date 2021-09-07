Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F8EE402889
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Sep 2021 14:19:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344785AbhIGMUb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Sep 2021 08:20:31 -0400
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:33700
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1344336AbhIGMTv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Sep 2021 08:19:51 -0400
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com [209.85.128.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id DE4514079B
        for <linux-kernel@vger.kernel.org>; Tue,  7 Sep 2021 12:18:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1631017116;
        bh=vC5ZeeYLEo1QgnDozyJaTYMB8bYZWzk5ZY30xgpVgcM=;
        h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=tTyMQxiqTAGMXRkmo9aHy0Xh+NsYkcZDhsUaVu85+4GuPOu9SaUXKoB2Iyx/MHECt
         JghnYmR3Fx7/fYl/JhRoZiDqs/+/CpB026Q6ZS7On+U67bQEM7KVlat4H5qoHfL0lv
         dQGOleE7W5aYRGU3H6P1c18o4PgigX9xzN6zByLmOUuhB44uwsuKSZ1SI5yT5bgOv9
         /PmIszq/E4HIPhCSdDdMiB4FPIvhT5scRHX4U5Er1slOAmB45HEcu5o2jSelxEktTi
         Hmo+ydRKBS23PPyvSV9RBC6rrqHxm3JWGEIfNOcx6j2Om3olCEiLwstCOT7wVZ0JXI
         444hpHS4Gw4uA==
Received: by mail-wm1-f71.google.com with SMTP id c2-20020a7bc8420000b0290238db573ab7so1113236wml.5
        for <linux-kernel@vger.kernel.org>; Tue, 07 Sep 2021 05:18:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vC5ZeeYLEo1QgnDozyJaTYMB8bYZWzk5ZY30xgpVgcM=;
        b=VmwvqETHLXuqxs0PB5Zj/1Fxh/IlKLnxPDj4X9coBKDvEyEGIM287Sww9JVfn/EDMB
         LgXFeRtg7lgjCZVzusI+viAPE/0gkrPX1atN8t0qmb/87R1plwgJXuNPxMMDR6GkckHE
         6+hj4QHnOZWEWOgdoyq2EP0jX/XeT4sOeHlzrdy9lCz44NBsjnYqLBav8ZXNbBLiE0sx
         dhO/26h3YDdu79DBYLH5OrMzuBfQhswMi8eFgP+cQ8gppftzxXN9Nt3devsIQvLNzLXd
         H7XDHVbtn+qBlkzKwHpXcLnVR22ZXwiaF/jDCELMAww3hmTqX4j1HG4xEddNpXQarhhf
         Zasw==
X-Gm-Message-State: AOAM531/33EohCNqtTbqwCB1GrZt6lvECtg31e6ZkvNO2P+TZf49tVX8
        8Rr9pjrOtDmr+7cLZiJJH3MpkWBR/pZKZGsrQ1MNxwWm08BYfOCZMU/xDM8UHPqvHNHibCOxObj
        9MPNNT3K9L36rY3hnVZGDZMD/5eCi+p47TodYDTxhvQ==
X-Received: by 2002:a05:600c:350b:: with SMTP id h11mr3654656wmq.101.1631017116588;
        Tue, 07 Sep 2021 05:18:36 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz1nc8FfA3NegAiSteStJpWLEeZZ3ZcnTr4pnxkPwnCbeOusix2fXAFJixkw6WN/2ypjZQRhw==
X-Received: by 2002:a05:600c:350b:: with SMTP id h11mr3654639wmq.101.1631017116468;
        Tue, 07 Sep 2021 05:18:36 -0700 (PDT)
Received: from kozik-lap.lan ([79.98.113.47])
        by smtp.gmail.com with ESMTPSA id m3sm13525216wrg.45.2021.09.07.05.18.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Sep 2021 05:18:36 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Krzysztof Opasiak <k.opasiak@samsung.com>,
        Mark Greer <mgreer@animalcreek.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, linux-nfc@lists.01.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-wireless@vger.kernel.org
Subject: [PATCH 12/15] nfc: trf7970a: drop unneeded debug prints
Date:   Tue,  7 Sep 2021 14:18:13 +0200
Message-Id: <20210907121816.37750-13-krzysztof.kozlowski@canonical.com>
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
 drivers/nfc/trf7970a.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/nfc/trf7970a.c b/drivers/nfc/trf7970a.c
index 8890fcd59c39..29ca9c328df2 100644
--- a/drivers/nfc/trf7970a.c
+++ b/drivers/nfc/trf7970a.c
@@ -2170,8 +2170,6 @@ static int trf7970a_suspend(struct device *dev)
 	struct spi_device *spi = to_spi_device(dev);
 	struct trf7970a *trf = spi_get_drvdata(spi);
 
-	dev_dbg(dev, "Suspend\n");
-
 	mutex_lock(&trf->lock);
 
 	trf7970a_shutdown(trf);
@@ -2187,8 +2185,6 @@ static int trf7970a_resume(struct device *dev)
 	struct trf7970a *trf = spi_get_drvdata(spi);
 	int ret;
 
-	dev_dbg(dev, "Resume\n");
-
 	mutex_lock(&trf->lock);
 
 	ret = trf7970a_startup(trf);
@@ -2206,8 +2202,6 @@ static int trf7970a_pm_runtime_suspend(struct device *dev)
 	struct trf7970a *trf = spi_get_drvdata(spi);
 	int ret;
 
-	dev_dbg(dev, "Runtime suspend\n");
-
 	mutex_lock(&trf->lock);
 
 	ret = trf7970a_power_down(trf);
@@ -2223,8 +2217,6 @@ static int trf7970a_pm_runtime_resume(struct device *dev)
 	struct trf7970a *trf = spi_get_drvdata(spi);
 	int ret;
 
-	dev_dbg(dev, "Runtime resume\n");
-
 	ret = trf7970a_power_up(trf);
 	if (!ret)
 		pm_runtime_mark_last_busy(dev);
-- 
2.30.2

