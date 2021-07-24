Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0988C3D4727
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Jul 2021 12:34:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235297AbhGXJyU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Jul 2021 05:54:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235264AbhGXJyP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Jul 2021 05:54:15 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F34CEC061760;
        Sat, 24 Jul 2021 03:34:45 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id a7so4770042ljq.11;
        Sat, 24 Jul 2021 03:34:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SgL0jl+mGyF6SSLvs6k02lrCaESH25yjasdaW3GUG0o=;
        b=TPOxBFRhgJow6paU5WCNeHGFLVPM3llWW97Bd2nLomggWuu0guMT980zA53bQlY+a3
         wzW+c6VRvera866BvaF+jBJFuYO5XNfsMls7lYhlkC6OOl5HIBO5xYYDt6Vdm1qcaZLj
         6pfQXpHEXbtp9vBq2jd0C5RhwtYhMjb9DDUPAAKG3WvIw7+sO+gvMW2gqecxXhb2HaAd
         PDLHATtFasdl9uwlsxuW4IJjVCiH6NnXxKIp8QNEnznhtlETiq9lQDr272BAlqdk+qlv
         5bMYmuAaTTIkXm+apyd5PabRvI70kONRgHI+jjCoPQhxnsKCyGa0wBmdVA2KfBmXAOlN
         f2sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SgL0jl+mGyF6SSLvs6k02lrCaESH25yjasdaW3GUG0o=;
        b=rwEDwUIhEG91m3IgqtgTuyqSbCDLyOgign4RbntmS+b4lyyXAENSk5JoR7arXn+pdH
         8KddTCNeyas+Q61cc1GUCJnV5jgGxNyJtiBokXMZsZX4YpYGKrDwqbfeQrd5qZ+9A8DF
         TJR9tAJoH9bmvWcthQ/ddhwZq2awH5ULtrm3UdnF+FcWE0X8qm1wQ57h9f5hqnlU6Ah9
         8NCjjKtvPriZenR+mmrtZHNPvuDfxtSk9xecCs2kwacxXLc46StIhektOCNzYerzm09Y
         DUQRlRSgN2oP2nvBtNb5vdsKKYrTwUpZFIv3lKujkmW/APysKu9+yJ5qRdzRLD+wpuX6
         dEEA==
X-Gm-Message-State: AOAM533aPFgY+zZTkc06ai40E6nIMZWj42k6SN+dj2DEO2i1lt5ENfqn
        vRSgQKX6lYJ/K3CFNiLczWU=
X-Google-Smtp-Source: ABdhPJz7+0e5Kv9oCUA8rGIV9kfDSHbMAxwSQzE0wjXc7RG/0cmtCGDqQnH5vzEP4uulfIgWDXkPUA==
X-Received: by 2002:a2e:7817:: with SMTP id t23mr5921664ljc.486.1627122884360;
        Sat, 24 Jul 2021 03:34:44 -0700 (PDT)
Received: from akaWolf-PC.. ([194.79.5.201])
        by smtp.gmail.com with ESMTPSA id v22sm2158938lfi.270.2021.07.24.03.34.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Jul 2021 03:34:44 -0700 (PDT)
From:   Artjom Vejsel <akawolf0@gmail.com>
Cc:     thierry.reding@gmail.com, sam@ravnborg.org,
        dri-devel@lists.freedesktop.org, robh+dt@kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        paul@crapouillou.net, akawolf0@gmail.com
Subject: [PATCH v2 2/3] dt-bindings: Add DT bindings for QiShenglong Gopher 2b panel
Date:   Sat, 24 Jul 2021 13:33:57 +0300
Message-Id: <20210724103358.1632020-3-akawolf0@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210724103358.1632020-1-akawolf0@gmail.com>
References: <20210724103358.1632020-1-akawolf0@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add DT bindings for QiShenglong Gopher 2b 4.3" 480(RGB)x272 TFT LCD panel.

Signed-off-by: Artjom Vejsel <akawolf0@gmail.com>
---
 .../devicetree/bindings/display/panel/panel-simple.yaml         | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/panel/panel-simple.yaml b/Documentation/devicetree/bindings/display/panel/panel-simple.yaml
index 3624363938dd..e7f3db118c5d 100644
--- a/Documentation/devicetree/bindings/display/panel/panel-simple.yaml
+++ b/Documentation/devicetree/bindings/display/panel/panel-simple.yaml
@@ -244,6 +244,8 @@ properties:
       - powertip,ph800480t013-idf02
         # QiaoDian XianShi Corporation 4"3 TFT LCD panel
       - qiaodian,qd43003c0-40
+        # Shenzhen QiShenglong Industrialist Co., Ltd. Gopher 2b 4.3" 480(RGB)x272 TFT LCD panel
+      - qishenglong,gopher2b-lcd-panel
         # Rocktech Displays Ltd. RK101II01D-CT 10.1" TFT 1280x800
       - rocktech,rk101ii01d-ct
         # Rocktech Display Ltd. RK070ER9427 800(RGB)x480 TFT LCD panel
-- 
2.32.0

