Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BC113735A1
	for <lists+linux-kernel@lfdr.de>; Wed,  5 May 2021 09:33:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231671AbhEEHdx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 May 2021 03:33:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231318AbhEEHdu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 May 2021 03:33:50 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79348C061574
        for <linux-kernel@vger.kernel.org>; Wed,  5 May 2021 00:32:54 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id m9so671974wrx.3
        for <linux-kernel@vger.kernel.org>; Wed, 05 May 2021 00:32:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PjPVZHKFcw/0Kjl3neOnoz2ErhwMmf8NtZZOxTpdu8s=;
        b=dFZLSL9G842H3ZEdEwu6yZvm3a/ow1ERyjz4m0bkqhXaPGYAVPJvWzf6TW6mO8tt6v
         mwy3/5i8bv8aRWXVcf+UmaqTeI0MhKHLyZJtJ7T1+MDc2l879NS6PlkurO2orL1NIC7S
         d21eZ15Az0MUEbiGTZskcRwMPMVx6UeEwZ5Rc52oQ1uCc1lrQO4OniMaU9Lttl10VBXu
         Rcrb4ohqsFElnCe9oGJXujlsF/QoxIrpTphbdQJe8YPncCSRsmS3M8/01ySZfNzBPlpZ
         kEyaowUemrOT9Dm28fRPoguDGHWt0rj/Dpn8h7AzuYHAfXLcQQsnmN5K2dT/5idENLgt
         bpGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PjPVZHKFcw/0Kjl3neOnoz2ErhwMmf8NtZZOxTpdu8s=;
        b=c3NKCudQPtOxLqsv0enwd3ZAWi32h5fzFfX2OXZz6jxLUi/vtqtoknaHoIopkb+y1C
         9lKodsnScrUjd1bK7H6XqJk+pmZndLNYThXOVGfQkKZP2YcO6YaJYbDMDPVFuKdvfu14
         l7cl3xOhwZprVrTeiHknFMHMhR5nIfACN6xweA693DIgQwsE6QNzIXYzpRugX+8uUbEx
         CEScNiBw9B52DbXGDO4sMCskLSkQR9m+6V4IXwNB5ZOSxWVwxo/XWS+J1LSN9oEhTtIT
         engqRGHg6SNwYKoM2dpU+I0TZ34clIrVwE9p2sKxtK1jO0mmfaI+qm5J930CKpRQO8lU
         4sEg==
X-Gm-Message-State: AOAM533a4/Mcklom0zVgPg85I1QSksXcvpk80gZdEkAjCtDGUzw2cYM4
        9z1JVIyqkXWeS9Oghs9uJFZw0w==
X-Google-Smtp-Source: ABdhPJzPrdLSH9rlXg/aGBRF/v87OS8+jTKOJeqvQkjf0HBAu7BtwK3sgPI8Ob/3fYBpicEu7wgJaA==
X-Received: by 2002:adf:f891:: with SMTP id u17mr17163914wrp.352.1620199973128;
        Wed, 05 May 2021 00:32:53 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:90c:e290:6eb3:66ab:cb1e:ef0])
        by smtp.gmail.com with ESMTPSA id v20sm4965663wmj.15.2021.05.05.00.32.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 May 2021 00:32:52 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     khilman@baylibre.com, jbrunet@baylibre.com,
        martin.blumenstingl@googlemail.com
Cc:     linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: [PATCH v2 2/3] dt-bindings: arm: amlogic: add Banana PI M5 bindings
Date:   Wed,  5 May 2021 09:32:47 +0200
Message-Id: <20210505073248.3816183-3-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210505073248.3816183-1-narmstrong@baylibre.com>
References: <20210505073248.3816183-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add bindings for the Banana PI M5 board.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 Documentation/devicetree/bindings/arm/amlogic.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/amlogic.yaml b/Documentation/devicetree/bindings/arm/amlogic.yaml
index 5f6769bf45bd..d81a20f66415 100644
--- a/Documentation/devicetree/bindings/arm/amlogic.yaml
+++ b/Documentation/devicetree/bindings/arm/amlogic.yaml
@@ -164,6 +164,7 @@ properties:
       - description: Boards with the Amlogic Meson SM1 S905X3/D3/Y3 SoC
         items:
           - enum:
+              - bananapi,bpi-m5
               - hardkernel,odroid-c4
               - hardkernel,odroid-hc4
               - khadas,vim3l
-- 
2.25.1

