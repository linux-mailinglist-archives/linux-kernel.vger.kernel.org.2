Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8329B397867
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jun 2021 18:48:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234533AbhFAQt7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Jun 2021 12:49:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234506AbhFAQt4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jun 2021 12:49:56 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71F77C06174A;
        Tue,  1 Jun 2021 09:48:13 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id h24so18823080ejy.2;
        Tue, 01 Jun 2021 09:48:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=g6VRk7pLTv14ZqW4HS/uJREzcuFALmE6Z5eWW3DWvAQ=;
        b=MpgOrNRFTId0SN+tfPxA2A4oeYOe4Gnn12I4uLktM8/O/NTHrIOO5eVna7lhRSQM1N
         sw0W/mOxAgk0NfXR3tnkJE1VtYTbT/VWFGbKFsw27C1U+IqwjHepwgxyaYGT/vdUZ0k2
         vB1EPiW/Z+nso1GKUcDFBPnaZLzQA6EIruY8dtOvoEfr1vfQ5/o39YIRqca9ct5MJO3k
         V2kl4LHbJhxhwAEiytyZjateCV2BAKynR7q6UAMjosv2Bz/nHuXh56p6gPn7bHVpSGuZ
         o5YAyZTbvLHI5zjWtGjUWK5tthZDhTHib+cOO7gZG89A2vdazzYN/FHEXYpYPrB0Ul4G
         CsCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=g6VRk7pLTv14ZqW4HS/uJREzcuFALmE6Z5eWW3DWvAQ=;
        b=RKZeQOv4PFbUzxLYyQ+MIV8944rD2gAbLtKWmSAcZ8D+bKV3mSgq6Nlgunojc9zYQS
         uBy1Tuo5D5O2bBdMwdIQybYHQdWr9iABf0kBuaw5QvuhRhqx0SeiZpXCZ2vMCH7DfOWx
         uHVWlPozU/zxegvCAM/eOY8dqya7Ay1YVldHPF8r42yYolKmIHlab9TkO8vO0MSVfDjF
         DT9s93rxWX487t0En5wH1NYd5p5Ci0FfJl+PYv/pYzazsjtgv6eXgHph9srFm0ZSYMlf
         5FHCsY30is7coiYQerkLO02fcShu2Ns5HkFmJkkUXZSQlTNmzuoAM2elcwRUZCn4d2LG
         glbA==
X-Gm-Message-State: AOAM533xhGTGykuDli82lPqeNxJTdmyiL3SUKSJxLY/Pnou5sEHp+2Zz
        6WdorcWzpa1jfxM5clnTeZ/RfHREQQJPaA==
X-Google-Smtp-Source: ABdhPJwNuuIuSL6mm3XCOpqcPdvbFx0jNg1gsdx1EYhm+NAhvjfe+/xP2OtQtG4scGTDm84L44FLIw==
X-Received: by 2002:a17:907:7749:: with SMTP id kx9mr30893200ejc.90.1622566092137;
        Tue, 01 Jun 2021 09:48:12 -0700 (PDT)
Received: from debian.home (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id q18sm8327750edd.3.2021.06.01.09.48.11
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 01 Jun 2021 09:48:11 -0700 (PDT)
From:   Johan Jonker <jbx6244@gmail.com>
To:     heiko@sntech.de
Cc:     robh+dt@kernel.org, kishon@ti.com, vkoul@kernel.org,
        t.schramm@manjaro.org, linux-phy@lists.infradead.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v7 2/5] dt-bindings: soc: rockchip: grf: add compatible for RK3308 USB grf
Date:   Tue,  1 Jun 2021 18:47:57 +0200
Message-Id: <20210601164800.7670-3-jbx6244@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20210601164800.7670-1-jbx6244@gmail.com>
References: <20210601164800.7670-1-jbx6244@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tobias Schramm <t.schramm@manjaro.org>

The RK3308 has a USB GRF.
This patch adds a compatible string for it.

Signed-off-by: Tobias Schramm <t.schramm@manjaro.org>
Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---

Changed:
  Add "rockchip,rk3308-usb2phy-grf" to "usb2phy@[0-9a-f]+$"
  patternProperties too.
---
 Documentation/devicetree/bindings/soc/rockchip/grf.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/soc/rockchip/grf.yaml b/Documentation/devicetree/bindings/soc/rockchip/grf.yaml
index 43c288708..8c1c46fef 100644
--- a/Documentation/devicetree/bindings/soc/rockchip/grf.yaml
+++ b/Documentation/devicetree/bindings/soc/rockchip/grf.yaml
@@ -31,6 +31,7 @@ properties:
               - rockchip,rk3308-core-grf
               - rockchip,rk3308-detect-grf
               - rockchip,rk3308-grf
+              - rockchip,rk3308-usb2phy-grf
               - rockchip,rk3328-grf
               - rockchip,rk3328-usb2phy-grf
               - rockchip,rk3368-grf
@@ -174,6 +175,7 @@ allOf:
             enum:
               - rockchip,px30-usb2phy-grf
               - rockchip,rk3228-grf
+              - rockchip,rk3308-usb2phy-grf
               - rockchip,rk3328-usb2phy-grf
               - rockchip,rk3399-grf
               - rockchip,rv1108-grf
-- 
2.11.0

