Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D27A64175FB
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Sep 2021 15:35:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346521AbhIXNhM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Sep 2021 09:37:12 -0400
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:37956
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1346428AbhIXNgt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Sep 2021 09:36:49 -0400
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com [209.85.221.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 894E14027C
        for <linux-kernel@vger.kernel.org>; Fri, 24 Sep 2021 13:35:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1632490515;
        bh=v0f97v842v9qYVokMipR6acxJb0mTvy8VEiat1GXDFk=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=ce8C7P9jVwUn+jtdegCxntPN8raVAx3eLU09lsXvfwRuarIIXKHLOF6DlkkOFzXhp
         J6DLCXvw5qkCBLrf4qefcTB0wzmYzsAuRca/pmCx379cp6tCAMhIGc8zKkYoO+NPl3
         SBn+369iVUIrdjjn7n3dt9BS9MFyybJirxTod0RJjNxYF5yiFSdFWnALdoXgRmEnOT
         e1biCM0AnkdOtM2eo5Y/dYjgz8jra0yfJL7BvH2zjZcDB4NHYZkmTIlqJ6KO2MjKfL
         pqlkq+sK0PyqEZrrhEKEd8/clI0CiwL3KSAGwyjaBokKwCvbnHXyJUowmsjzlQdUom
         OnK00eDMkbAYw==
Received: by mail-wr1-f71.google.com with SMTP id a17-20020adfed11000000b00160525e875aso568578wro.23
        for <linux-kernel@vger.kernel.org>; Fri, 24 Sep 2021 06:35:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=v0f97v842v9qYVokMipR6acxJb0mTvy8VEiat1GXDFk=;
        b=trSQFPYVJx7Jvm1Xg+2+i7gF68ZSFj4cMkgpfkYqkp7prkC7tisCqC66MDGEpwl+JA
         Clwt5hwW870PgHNRCEX6VkjPm2Lm6sq6JJCDwuLyC4UoOdrEspp4KC3/Yu0yF+gjaAnX
         sIMygwbYSmpJk/WaXBrvYSnQ0MZfRcxDO7GwxrJtalGqoHbqGlhHdmJlUaLBWlJbbcma
         MnS1+1tbWSPIOYRkp4YBWNasNOe8LXcsirnFT6TyN//ZjyGcXPb2D1FDZ2FCrU7K9tVj
         wiW8buvrdjV9IcBQH4AR5rBSul/HmDayt+G9pBogqG5+dDVIO8BXbBvIF+T8IE5V6USK
         uYow==
X-Gm-Message-State: AOAM5319VqM8XUXDeWvOdctz7sAg7QwKA8WCLjW76S8nQhz+1PoHMbhV
        K+SPvAxtg6MLfkXoCML4Juc4/Vcx16BzMd+kWcd6i0EQ9W9dnN76QkEY6R8LcP6KKl3Efqbgiem
        2WO9VfvEtWqjRa6mbVZPW4rvqvyIk8CFIQv9YgRJvog==
X-Received: by 2002:adf:f4c6:: with SMTP id h6mr866974wrp.397.1632490515240;
        Fri, 24 Sep 2021 06:35:15 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwi7xEv8Tz6BmCOASozjNG+54R6CSmRxyu2Kax3cZe6Cg23rAYqOmgddnFPEdP4Opy5ulirIw==
X-Received: by 2002:adf:f4c6:: with SMTP id h6mr866952wrp.397.1632490515106;
        Fri, 24 Sep 2021 06:35:15 -0700 (PDT)
Received: from localhost.localdomain (lk.84.20.244.219.dc.cable.static.lj-kabel.net. [84.20.244.219])
        by smtp.gmail.com with ESMTPSA id 5sm8709997wmb.37.2021.09.24.06.35.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Sep 2021 06:35:14 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        =?UTF-8?q?Artur=20=C5=9Awigo=C5=84?= <a.swigon@samsung.com>,
        Georgi Djakov <djakov@kernel.org>, linux-pm@vger.kernel.org
Subject: [PATCH] interconnect: samsung: describe drivers in KConfig
Date:   Fri, 24 Sep 2021 15:34:40 +0200
Message-Id: <20210924133441.112263-1-krzysztof.kozlowski@canonical.com>
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
 drivers/interconnect/samsung/Kconfig | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/interconnect/samsung/Kconfig b/drivers/interconnect/samsung/Kconfig
index 6820e4f772cc..fbee87e379d0 100644
--- a/drivers/interconnect/samsung/Kconfig
+++ b/drivers/interconnect/samsung/Kconfig
@@ -6,8 +6,10 @@ config INTERCONNECT_SAMSUNG
 	  Interconnect drivers for Samsung SoCs.
 
 config INTERCONNECT_EXYNOS
-	tristate "Exynos generic interconnect driver"
+	tristate "Exynos SoC generic interconnect driver"
 	depends on INTERCONNECT_SAMSUNG
 	default y if ARCH_EXYNOS
 	help
-	  Generic interconnect driver for Exynos SoCs.
+	  Generic interconnect driver for Samsung Exynos SoCs (e.g. Exynos3250,
+	  Exynos4210, Exynos4412, Exynos542x, Exynos5433).
+	  Choose Y here only if you build for such Samsung SoC.
-- 
2.30.2

