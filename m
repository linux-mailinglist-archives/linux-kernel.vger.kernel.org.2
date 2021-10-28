Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7691843E40B
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Oct 2021 16:43:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231283AbhJ1Opu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Oct 2021 10:45:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231249AbhJ1Opq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Oct 2021 10:45:46 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 890BAC0613B9
        for <linux-kernel@vger.kernel.org>; Thu, 28 Oct 2021 07:43:19 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id n7so11148147ljp.5
        for <linux-kernel@vger.kernel.org>; Thu, 28 Oct 2021 07:43:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=O53AHUgACpwOyqnjRAL2GRxe71zIKofdn1555ZmaTgk=;
        b=uDm1ThkqYSTH37pvAeBSIac3/jrGqvTNFtAPZ0KSPpEx1wpOgN4s1YquOXvOcDpCey
         8s77v6r3YHA23g8jGZUQgdyafiNoJWFN5E6w9PjSGhnyaku2qjsKqkmsVnv+f+hRk69i
         tx4FkijDrj7xrzfnNFrn33GpzlSsisfvClxbjMZUsuCdEunfSFkAQ/QQfJwlliI0ihy5
         7W0EbDR7Clw7smY+qe3YGJGSMJEWS89ZiBqGfoyEqKyGc+yPpJYLS/X+jRr/jtZKNiTu
         6GPIEVfwU02OcWI1dJhMe0y1Bq+lwBwrRF0lZwdZaSM06TFsYiTiR4zLGA3yqXAXg321
         oztg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=O53AHUgACpwOyqnjRAL2GRxe71zIKofdn1555ZmaTgk=;
        b=VffqVXIVfS8Os7InrNbEkjCPBR2Z/BXKkVqp+Yt1RH/pW/j6MGELv+1A1A+QYpmGcG
         DOcQuX7F6W0z1dxwbOTk1PGOjKyoqYCumi97DJCiY0O9eYPO5/D1ucbb4qWjAq3+A3bk
         UieQF4MoiFEzRjaD2v49aPEyVsZHf+b6DBN0QPimsqGrG+mmFUMaczBzKQtdubgKR+eX
         pul52ioxYhTBascq8Bh9YZYjIXQuxMb2DKEzuMIOU5JXaU4FzHQiY4Uh9N4xVEzfMEd9
         bDHhlaHwtkODYXGUm+K47Jm6APnXj3oXES8kVklv3ZTRTuhCVSYAodFNT6ZVpGi8ee9g
         Qbiw==
X-Gm-Message-State: AOAM533oArIsJ19OJnfao3BXmYfs8zzT8etLtWsDWt+EzSVY0pJ/4//3
        lXl5AMJ6v7OUD2qTV6Q/E+YR5Q==
X-Google-Smtp-Source: ABdhPJwmFDPA7CH5Ie55u0g0CIVwKuzI6JmcYwigAWJx30oJsS8kwg3hYpdWKSFo18/72ymQXXTK7w==
X-Received: by 2002:a2e:bd09:: with SMTP id n9mr3482129ljq.40.1635432196435;
        Thu, 28 Oct 2021 07:43:16 -0700 (PDT)
Received: from localhost ([31.134.121.151])
        by smtp.gmail.com with ESMTPSA id y3sm28967ljg.47.2021.10.28.07.43.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Oct 2021 07:43:15 -0700 (PDT)
From:   Sam Protsenko <semen.protsenko@linaro.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] soc: samsung: exynos-pmu: Add Exynos850 support
Date:   Thu, 28 Oct 2021 17:43:13 +0300
Message-Id: <20211028144313.9444-2-semen.protsenko@linaro.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211028144313.9444-1-semen.protsenko@linaro.org>
References: <20211028144313.9444-1-semen.protsenko@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Exynos850 SoC can reuse PMU driver functionality. Add corresponding
compatible string.

Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
---
 drivers/soc/samsung/exynos-pmu.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/soc/samsung/exynos-pmu.c b/drivers/soc/samsung/exynos-pmu.c
index a18c93a4646c..732c86ce2be8 100644
--- a/drivers/soc/samsung/exynos-pmu.c
+++ b/drivers/soc/samsung/exynos-pmu.c
@@ -94,6 +94,8 @@ static const struct of_device_id exynos_pmu_of_device_ids[] = {
 		.compatible = "samsung,exynos5433-pmu",
 	}, {
 		.compatible = "samsung,exynos7-pmu",
+	}, {
+		.compatible = "samsung,exynos850-pmu",
 	},
 	{ /*sentinel*/ },
 };
-- 
2.30.2

