Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CF3C410AE9
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Sep 2021 11:31:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237626AbhISJct (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Sep 2021 05:32:49 -0400
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:36382
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237587AbhISJcs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Sep 2021 05:32:48 -0400
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com [209.85.208.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id A721C40293
        for <linux-kernel@vger.kernel.org>; Sun, 19 Sep 2021 09:31:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1632043882;
        bh=l8YXmTXMZ/iKcjkLim6IYDwfujCxIJBCjNW3dt7zqMc=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=JScp05qFjaXB2fKc4KbEReBcD28QIxTqWSAjTSaM4m5oQGCRROhq0dssfDCWy/xsk
         4HAMY5juPN2/IJMggyBhlx8ZE5X5NovGR815oGqWmHoC4po7GOk8UAIAzbsAjSUMKe
         DavpTAbLIHxUVG5rZnl2ek4Xd+Xpy1HwccFSoKaiYXw/kOVynbKWOE6TwzlJoz84Il
         hHsHyAcEuBmUIoFrj8V9dpk9FDgRSrrbG8GLR+yOfko/rhVj1aIJs+KFZbkeIpLUzi
         Kzi/4dvILp25RgVlKWeHf4epv4997iqNhNQLF5ATDnYIBHuCZd4taRjhF+xfrS+2ks
         SvD07zSYLBKcQ==
Received: by mail-ed1-f70.google.com with SMTP id d1-20020a50f681000000b003d860fcf4ffso350776edn.22
        for <linux-kernel@vger.kernel.org>; Sun, 19 Sep 2021 02:31:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=l8YXmTXMZ/iKcjkLim6IYDwfujCxIJBCjNW3dt7zqMc=;
        b=DBDBFc8W2hvxXVSFL7xzD8QVj+S/lHM1DeraF0iyq/gi7Vph4KPPWk84nOiSNRdfN7
         ohkF0JQe3XWU4f1w52WBMbMt/kucue/viQMaQ0is3ANYjRM8gPAs+aEYuJjHgsfBg/9q
         M0TAi0FiwRr0vysm1G9/tebjGu8OapLzGCEcs1JWnVCuyWOpNOSpru8Q6xYVUeJwhi/T
         4vHAMoVm2/JHlMuJu5CqFxQ1z4NACutAgxxy+WplkfNdaZGOehW4yxTtodRaBWwhmB3r
         ZObWLUNTHRJkVRbE1wfQ73RlyvauvwMZMD4CvSqz9dUV5rzFBp6zEbiim7Bb7exXMAbc
         9i8w==
X-Gm-Message-State: AOAM530Ly30sLZLNQeXdcZauvF9yrM4bzGWMIYW7poYt+fxAouZtL7t8
        hZtzTP7TDbaoupzfwzkijxIfdJcL/o0kj7plc5PY5v95C6uqulhuku7+rkqyRoU3zax7ThkgkLe
        RQ/ULuqe6JFWcEjhXJmRLxvq36xxwxssJpSgT7FoKxA==
X-Received: by 2002:a17:906:38db:: with SMTP id r27mr22326045ejd.338.1632043882303;
        Sun, 19 Sep 2021 02:31:22 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwYvfoLSFre+KE2ZP+ET/ZNmRuRODsi3g4LGtgTi3G5DkG0kV48HP/d374F2ehLDbB/piMRvA==
X-Received: by 2002:a17:906:38db:: with SMTP id r27mr22326024ejd.338.1632043882150;
        Sun, 19 Sep 2021 02:31:22 -0700 (PDT)
Received: from kozik-lap.lan (lk.84.20.244.219.dc.cable.static.lj-kabel.net. [84.20.244.219])
        by smtp.gmail.com with ESMTPSA id p24sm514111edq.27.2021.09.19.02.31.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Sep 2021 02:31:21 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Russell King <linux@armlinux.org.uk>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Sylwester Nawrocki <snawrocki@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Pankaj Dubey <pankaj.dubey@samsung.com>
Subject: [PATCH v2 1/3] soc: samsung: exynos-chipid: avoid soc_device_to_device()
Date:   Sun, 19 Sep 2021 11:31:12 +0200
Message-Id: <20210919093114.35987-2-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210919093114.35987-1-krzysztof.kozlowski@canonical.com>
References: <20210919093114.35987-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

soc_device_to_device() seems to be discouraged [1] so remove it in favor
of printing info message with platform device.  This will only change
the prefix in theh info message from "soc soc0: " to "exynos-chipid
10000000.chipid:".

[1] https://lore.kernel.org/lkml/20191111052741.GB3176397@kroah.com/

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 drivers/soc/samsung/exynos-chipid.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/soc/samsung/exynos-chipid.c b/drivers/soc/samsung/exynos-chipid.c
index 5c1d0f97f766..dcd9a08ce706 100644
--- a/drivers/soc/samsung/exynos-chipid.c
+++ b/drivers/soc/samsung/exynos-chipid.c
@@ -104,8 +104,7 @@ static int exynos_chipid_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, soc_dev);
 
-	dev_info(soc_device_to_device(soc_dev),
-		 "Exynos: CPU[%s] PRO_ID[0x%x] REV[0x%x] Detected\n",
+	dev_info(&pdev->dev, "Exynos: CPU[%s] PRO_ID[0x%x] REV[0x%x] Detected\n",
 		 soc_dev_attr->soc_id, product_id, revision);
 
 	return 0;
-- 
2.30.2

