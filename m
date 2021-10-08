Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7200426576
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Oct 2021 09:53:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233170AbhJHHzb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Oct 2021 03:55:31 -0400
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:38888
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229868AbhJHHza (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Oct 2021 03:55:30 -0400
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com [209.85.221.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 3A8C53FFE3
        for <linux-kernel@vger.kernel.org>; Fri,  8 Oct 2021 07:53:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1633679614;
        bh=J8tNJvcJVYBu0x9m4fxgROGUMF0K9V2pNV12upjHKNA=;
        h=From:To:Subject:Date:Message-Id:MIME-Version;
        b=LV1zcwrgs09aOGG3958Er5H94jCqrXHEC0YSdqyV6l49mRo+eUAH+5Fs85yhdooZo
         XTsTRk+7sWFmeuIK2vH0kz8W7rKIFWvL3qPBAwoXyKyugoelB7vhuwYH2lUi21uuA9
         gjrviD2yGi3/4OCe26AItyMna6XdvVTeBEgIOB2MlfepMj97dXyNTSrzDCACycXAYP
         9BC1ryL6dcjAACovrzpKcYgKiSHNiJ56DfIxS+0QOw6JSTJL5elr7u1fx1gd4Tse3V
         WrYRXaVv8Jkoh7R4Q7VXVum/mR4lrSbqUKAZqI4pC50xyM+NXxs45nCN6gfRlCggqq
         lV4VcXw4muzhg==
Received: by mail-wr1-f72.google.com with SMTP id o2-20020a5d4a82000000b00160c6b7622aso6545282wrq.12
        for <linux-kernel@vger.kernel.org>; Fri, 08 Oct 2021 00:53:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=J8tNJvcJVYBu0x9m4fxgROGUMF0K9V2pNV12upjHKNA=;
        b=tg0qOW0Ob3QWGD7yJFWJAEdS/kq+4tzBVRqufyEzf11vx0uBalLzy7bdLXEcBWylE1
         AAPmI/YWsqMsu/b+3rifaYl3L6laGRkHAN+2TdKuCJ3KPujT6tWweiE+Kl9W9IUM22wn
         dmdDH7qwwXHLO8VyBP4RROE5cXodqrtYxp1iTAUKAfEx7inpP71YKt4afjXvH7vr1b+8
         3SUP8i2sxr4CbsX3dtUTrqexPD5rT5bvnDxY+qvmTRawlkU+8/uIGoiOJ+UPSUBi+Pr7
         lTphRu/++P3XLAu+FSwXHTN6euUK3w2jmiGWo/JZaqxRGp/Y0PZAYrogVZ5IeVkZ68XW
         +Tnw==
X-Gm-Message-State: AOAM530oeDxLqF/e9OyprNSk0oL4wPzSkND9I/MfVqgXrXT0SgZ/8heh
        DdPWdiKR2UYg+U2HH3GV0crWTd3QLmnz+ENTJrnjGl3Ew7a+3jmCpq+bOUOee11fbh8jOIdFXh3
        uMoLhfR7qRnDGi10/m9kaRui7XAksBXjZxA0+H+mO1g==
X-Received: by 2002:adf:a502:: with SMTP id i2mr2014571wrb.311.1633679613580;
        Fri, 08 Oct 2021 00:53:33 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy55rGtLFm7Q1RFwWN7SRi5FPdu5yq/yrTSIZyZpeE9GzwuxNnqBtvJN0JTQdIYzvHIu5W+XA==
X-Received: by 2002:adf:a502:: with SMTP id i2mr2014555wrb.311.1633679613404;
        Fri, 08 Oct 2021 00:53:33 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-186-13.adslplus.ch. [188.155.186.13])
        by smtp.gmail.com with ESMTPSA id l16sm1812279wmj.33.2021.10.08.00.53.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Oct 2021 00:53:33 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] soc: samsung: pm_domains: drop unused is_off field
Date:   Fri,  8 Oct 2021 09:52:53 +0200
Message-Id: <20211008075253.67961-1-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The 'is_off' member of internal state structure 'exynos_pm_domain' is
not used anymore.

Fixes: 2ed5f236716c ("ARM: EXYNOS: Detect power domain state on registration from DT")
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 drivers/soc/samsung/pm_domains.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/soc/samsung/pm_domains.c b/drivers/soc/samsung/pm_domains.c
index 5ec0c13f0aaf..d07f3c9d6903 100644
--- a/drivers/soc/samsung/pm_domains.c
+++ b/drivers/soc/samsung/pm_domains.c
@@ -28,7 +28,6 @@ struct exynos_pm_domain_config {
  */
 struct exynos_pm_domain {
 	void __iomem *base;
-	bool is_off;
 	struct generic_pm_domain pd;
 	u32 local_pwr_cfg;
 };
-- 
2.30.2

