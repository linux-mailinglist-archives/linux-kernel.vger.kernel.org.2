Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2406362CA7
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Apr 2021 03:13:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235344AbhDQBMD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 21:12:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235514AbhDQBMA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 21:12:00 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4075AC061574
        for <linux-kernel@vger.kernel.org>; Fri, 16 Apr 2021 18:11:35 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id n10so3711070plc.0
        for <linux-kernel@vger.kernel.org>; Fri, 16 Apr 2021 18:11:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0x0f.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4iQwcrP76XND1KpyIIjDX5F1DM/jpRSnMhRHiRWy9PM=;
        b=RCfCbgPnnkU94wcgcgHR1NXnnA4O47bVddkwHUrbhp1OGyytop/9Ytgb+d03pVihIO
         siRltm4AWh7ojfhzZe/um38LkQ512SoRFO7wfiU9N6HvaoXdJ6YLagv4LzfDYZ5/uNww
         UkeZI0VdMDb/ERgJDSwqgD6vy6UCdf0AtcD5s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4iQwcrP76XND1KpyIIjDX5F1DM/jpRSnMhRHiRWy9PM=;
        b=GtI8ulCop6zQJyheLRAM+LcUwj33LGwCvcB+3IYC41KTPqo4WfEl9oo72kW2C4fto4
         4Oq1/T8ict3TzmAQ1vp/gqyoB6LYsI/R/TPnLcp9fUzIJKvMjGsIrK9ceaFkpbJ+VRBb
         OjgEjuAf65F7LYhcxbbFeh2RzcrZSR8uyYLN3TFM95VCx47id64DtTjHx7sHN0ddVUyk
         /uwQyhYfAKbDLKXmfqGW6XBLsgV+lYzsRLNai9i1eo2pfIt1nv7ZTRFC3wmM6Leno458
         UYmncUwfgLlFGnc2OrO2HUrSCHR2NiiLe0eAkdIbxkwTB1Yj/q95P2GQk+rqUy4QmqsG
         kAIg==
X-Gm-Message-State: AOAM533FzYZwRjcL+wLmYRpF+9h9aR8D370+APGRIibTJrdbvzZMLcKx
        1JXPKwXCRkUhFc7UGkQdXs7Prg==
X-Google-Smtp-Source: ABdhPJw84Vzs9qhqrr0aOVygyyA7rFMa7bvZYva6opSQkrgMOLDfLuoVbDm5vcw5kvXuoQ/h7sIZ3A==
X-Received: by 2002:a17:90a:db87:: with SMTP id h7mr12533861pjv.36.1618621894873;
        Fri, 16 Apr 2021 18:11:34 -0700 (PDT)
Received: from shiro.work (p345188-ipngn200408sizuokaden.shizuoka.ocn.ne.jp. [124.98.97.188])
        by smtp.googlemail.com with ESMTPSA id x17sm2181515pjr.0.2021.04.16.18.11.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Apr 2021 18:11:34 -0700 (PDT)
From:   Daniel Palmer <daniel@0x0f.com>
To:     devicetree@vger.kernel.org, soc@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, olof@lixom.net, arnd@kernel.org
Cc:     w@1wt.eu, Daniel Palmer <daniel@0x0f.com>
Subject: [PATCH 2/3] dt-bindings: arm: mstar: Add compatible for M5Stack UnitV2
Date:   Sat, 17 Apr 2021 10:10:14 +0900
Message-Id: <20210417011015.2105280-3-daniel@0x0f.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20210417011015.2105280-1-daniel@0x0f.com>
References: <20210417011015.2105280-1-daniel@0x0f.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a compatible for the M5Stack UnitV2 that is based on the
SigmaStar SSD202D (inifinity2m).

Signed-off-by: Daniel Palmer <daniel@0x0f.com>
---
 Documentation/devicetree/bindings/arm/mstar/mstar.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/mstar/mstar.yaml b/Documentation/devicetree/bindings/arm/mstar/mstar.yaml
index 61d08c473eb8..a316eef1b728 100644
--- a/Documentation/devicetree/bindings/arm/mstar/mstar.yaml
+++ b/Documentation/devicetree/bindings/arm/mstar/mstar.yaml
@@ -24,6 +24,7 @@ properties:
         items:
           - enum:
               - honestar,ssd201htv2 # Honestar SSD201_HT_V2 devkit
+              - m5stack,unitv2 # M5Stack UnitV2
           - const: mstar,infinity2m
 
       - description: infinity3 boards
-- 
2.31.0

