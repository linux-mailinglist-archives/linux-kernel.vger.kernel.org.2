Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D3D54175EA
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Sep 2021 15:34:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345594AbhIXNfa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Sep 2021 09:35:30 -0400
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:37882
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1346709AbhIXNfG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Sep 2021 09:35:06 -0400
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com [209.85.221.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 2219A4019A
        for <linux-kernel@vger.kernel.org>; Fri, 24 Sep 2021 13:33:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1632490412;
        bh=XKzcwZuGjS/78EnzwfC5NLVDtJ4nskm07UNCWnFZuVI=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=vGBJYhCRiA7zVmNnSG0ktqTG3xgW4SN9ZyiulTA5inQ/1YPM+AmmdD+YnEa2QAvxN
         0AExaOdRY4rnhp6GnG8oymNhAMRj94w4liJQiPsIaBoLmSiiMaXi4MkvgRuaMyPMqD
         IO1WjdTqfFMmSItio2BQI2/XuaU6e0Qy2TC56Jic7dO4nd9bblW/fPF+P5Sh8SUrJq
         +v89xKglXwYjw8bNT2jVdPv7E1Pfhuixvm4/pZIKsmjmyH/puSEWKFWf34lPJpYwtk
         y8T/2Er8uyNkCYz9y2D7cD6Sj7gQupvfwmtG6/C0+fx39NSzQxpnBE4nYMhSRyT901
         kfQI2tcrp9H2g==
Received: by mail-wr1-f72.google.com with SMTP id c2-20020adfa302000000b0015e4260febdso8047983wrb.20
        for <linux-kernel@vger.kernel.org>; Fri, 24 Sep 2021 06:33:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XKzcwZuGjS/78EnzwfC5NLVDtJ4nskm07UNCWnFZuVI=;
        b=gmIFkV9FAfJS2/hbANqMABzjGcEujDpBmyG+++RI7mXsAgv48PyxO2WvsMMcIZDLd6
         6ivv1LCXpKGRsaJF3S378ApMRSSLVOFMpeDAoHtfBgsXS3c5BUWe8M2hPbEGOlzbmQ/r
         sh/ByTBsAeUrzKrRVR1ladz2lBGIXZuzH++wn8OD6wPPL/+ALBPv+4Phg8s6X4swfY9f
         4ISPbC90zHYBUeK9iFymHdeXjR6O2ZHqozv5R16cyJNDOJNdjLBVt/VwsFOXavjG8Nxu
         pLFmP8MDxbg63Vh0EYCAA3H973SHoqSxAm/kPk0hRg+A+o54JxtNsw5fSQPAEpESmCeK
         q43w==
X-Gm-Message-State: AOAM531c4+p9OcGaFVT+ILGyeTFse85esJGlMcuIGaet7LmphllkC+xj
        kcKIM/sd8ugoia4hr99cFuoPPqvSBlt1j6ftX0k2RRuXuyPErO+YOy30B0UT71sgrUVT5H40d1a
        l7z5GirDvci4kE8rB3/vJYsNgNCxEWeYfLFVOCd1h0g==
X-Received: by 2002:a05:6000:1567:: with SMTP id 7mr11418484wrz.84.1632490411880;
        Fri, 24 Sep 2021 06:33:31 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwejRfNkpbo05/gq3EhCAin4mt4r31Piv7+agmXlRHuJktohhgGDajWxZvlAJGT9ZJUgdgE0g==
X-Received: by 2002:a05:6000:1567:: with SMTP id 7mr11418468wrz.84.1632490411764;
        Fri, 24 Sep 2021 06:33:31 -0700 (PDT)
Received: from localhost.localdomain (lk.84.20.244.219.dc.cable.static.lj-kabel.net. [84.20.244.219])
        by smtp.gmail.com with ESMTPSA id n7sm8259677wra.37.2021.09.24.06.33.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Sep 2021 06:33:31 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org
Subject: [PATCH] mmc: sdhci-s3c: Describe driver in KConfig
Date:   Fri, 24 Sep 2021 15:32:57 +0200
Message-Id: <20210924133257.112017-1-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Describe better which driver applies to which SoC, to make configuring
kernel for Samsung SoC easier.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 drivers/mmc/host/Kconfig | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
index 71313961cc54..e4c1648e364e 100644
--- a/drivers/mmc/host/Kconfig
+++ b/drivers/mmc/host/Kconfig
@@ -315,15 +315,17 @@ config MMC_SDHCI_TEGRA
 	  If unsure, say N.
 
 config MMC_SDHCI_S3C
-	tristate "SDHCI support on Samsung S3C SoC"
+	tristate "SDHCI support on Samsung S3C/S5P/Exynos SoC"
 	depends on MMC_SDHCI
 	depends on PLAT_SAMSUNG || ARCH_S5PV210 || ARCH_EXYNOS || COMPILE_TEST
 	help
 	  This selects the Secure Digital Host Controller Interface (SDHCI)
 	  often referrered to as the HSMMC block in some of the Samsung S3C
-	  range of SoC.
+	  (S3C2416, S3C2443, S3C6410), S5Pv210 and Exynos (Exynso4210,
+	  Exynos4412) SoCs.
 
-	  If you have a controller with this interface, say Y or M here.
+	  If you have a controller with this interface (thereforeyou build for
+	  such Samsung SoC), say Y or M here.
 
 	  If unsure, say N.
 
-- 
2.30.2

