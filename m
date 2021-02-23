Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EFD4322E44
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Feb 2021 17:04:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233423AbhBWQCl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Feb 2021 11:02:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233365AbhBWQCY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Feb 2021 11:02:24 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38AE6C061786;
        Tue, 23 Feb 2021 08:01:42 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id r3so11463805wro.9;
        Tue, 23 Feb 2021 08:01:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=QF57n3BJmbnE5g02H0hISJw4D48Vk03Ja0GucFbbgno=;
        b=g7yKIyLjHLJAclUi1E3w2cGHPPPeepCJF8hoqOLbcLBjV3PJCdTaErAvevJG6OwOYT
         ttX7Raveeakz/9V1ipN9FlrsS+TOVaGEtNrGhTKe4sqOSmFL5L/PIwwv9Adb4UW89WKZ
         7XOpeH5JRAcbzvFevD4j8ytIF72fdXX2+EM0awp6NvRfK1iIUM8ILZYZQTcFSRytRD+B
         eshykGlz/5TPS352P/WoN9loULc2LC7mAVFG4UM1Gny3LrvfEWzJ/2Fwl76wWLiICBXu
         vWIcMVqy2ZVTzCH53efuq9oZIih0asMcqgXiF3sjTN7oTQt9oOeflSmLfs9iW0ovano3
         JZRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QF57n3BJmbnE5g02H0hISJw4D48Vk03Ja0GucFbbgno=;
        b=kgOoOFncSw/DoSvQLUCB5zu/hZjbyNo3h09NUQ3vle0R2Nnou/J7yNnA1rs8Yb+Sut
         dNaXlKzgfNj6B/F761NrY0lJOAcWdSXGpTDvhwRbE7WQwgXfQz1Jnas6LogfeVgEvq0A
         R+PwRKwvv+QwJYzn/kXrfBv+xfb1POw4qDvcVWTpin+xtOYoihl1GL9KO+d6rL0NeSav
         FUiR+tKFXMMYPc8A2x4tu4AZnncEC66JjjDzl1PF2m1NGyjVghfsMyEpbVpkNH5vog4X
         QdTu6JWyQ8H4xCluJwCFkRslo+2j33blwjQH6W2wy48Dfc/SYjrU+B/THUjMvNKm5oPG
         UMtw==
X-Gm-Message-State: AOAM530jvTMerOjHRmvKkb5TgX0olBTFGgCdfZFuW51PVdhdvECC02Hs
        uXf+C0llBkdqNqPVugPAPww=
X-Google-Smtp-Source: ABdhPJyDyKvRwCwF1dKgt6Z1WCk/jUJlEnXDpXuYT68NLSpG8Z5uiZzpxIacTv/1WrE1omqdAlD3yA==
X-Received: by 2002:adf:c3c8:: with SMTP id d8mr1050138wrg.167.1614096096954;
        Tue, 23 Feb 2021 08:01:36 -0800 (PST)
Received: from skynet.lan (170.red-88-1-105.dynamicip.rima-tde.net. [88.1.105.170])
        by smtp.gmail.com with ESMTPSA id h15sm33999381wrh.13.2021.02.23.08.01.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Feb 2021 08:01:36 -0800 (PST)
From:   =?UTF-8?q?=C3=81lvaro=20Fern=C3=A1ndez=20Rojas?= 
        <noltari@gmail.com>
To:     Matt Mackall <mpm@selenic.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Rob Herring <robh+dt@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Lee Jones <lee.jones@linaro.org>,
        =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= 
        <nfraprado@protonmail.com>,
        =?UTF-8?q?=C3=81lvaro=20Fern=C3=A1ndez=20Rojas?= 
        <noltari@gmail.com>, Rikard Falkeborn <rikard.falkeborn@gmail.com>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        linux-crypto@vger.kernel.org, devicetree@vger.kernel.org,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] dt-bindings: rng: bcm2835: document reset support
Date:   Tue, 23 Feb 2021 17:01:30 +0100
Message-Id: <20210223160131.29053-2-noltari@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210223160131.29053-1-noltari@gmail.com>
References: <20210222194510.14004-1-noltari@gmail.com>
 <20210223160131.29053-1-noltari@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some devices may need to perform a reset before using the RNG, such as the
BCM6368.

Signed-off-by: Álvaro Fernández Rojas <noltari@gmail.com>
---
 v2: document reset support.

 Documentation/devicetree/bindings/rng/brcm,bcm2835.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/rng/brcm,bcm2835.yaml b/Documentation/devicetree/bindings/rng/brcm,bcm2835.yaml
index c147900f9041..dba70764b7d0 100644
--- a/Documentation/devicetree/bindings/rng/brcm,bcm2835.yaml
+++ b/Documentation/devicetree/bindings/rng/brcm,bcm2835.yaml
@@ -31,6 +31,9 @@ properties:
   interrupts:
     maxItems: 1
 
+  resets:
+    maxItems: 1
+
 required:
   - compatible
   - reg
@@ -58,4 +61,6 @@ examples:
 
         clocks = <&periph_clk 18>;
         clock-names = "ipsec";
+
+        resets = <&periph_rst 4>;
     };
-- 
2.20.1

