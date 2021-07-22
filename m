Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 524EA3D2530
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jul 2021 16:06:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232333AbhGVNZa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jul 2021 09:25:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232320AbhGVNZ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jul 2021 09:25:28 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 807D3C061575;
        Thu, 22 Jul 2021 07:06:02 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id i5so8749309lfe.2;
        Thu, 22 Jul 2021 07:06:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SgL0jl+mGyF6SSLvs6k02lrCaESH25yjasdaW3GUG0o=;
        b=sq3WFwTOtj9kKuM6XYMC9kzFMB26rvdchXWIsRyAs9CSwzaUFhxpEhwvI6dABcicCn
         dMQjhCw6/Op/IR2zpeWN1vsPFW/2QeztnxdXppvV3RiNUCnCPZI56C0bJ+8xllCqaYoE
         9Q2E1GZE87mzzFuiipLwZcvrrMn3Gdm6+8Fl5NTDXAffFhO8iZVxj1xGexRWCvx6pdzH
         aa1kCXulmyIzfOYP4BtOLqxEizIGZrYON6nC4VgO67rE86jjAPQSddl4B5F+a44yvKpA
         zpQKE8XsLwLT7f0yBOgNQhnWgfClARMrG1e0FDac8UG02x4OVrOvS3rCzBPPMpDnG6AL
         uVtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SgL0jl+mGyF6SSLvs6k02lrCaESH25yjasdaW3GUG0o=;
        b=czFf7oXf3mPhMM7ASGiJh9k6nlQjszR/E/3Yndvi52LKVbKRwKUzAJa87D19KFweMP
         E8r55Rgt1aYSU71/Hv5qbgES+zwW6Nxp7pI/s6TDaXNec0pJzmkR9K8iCiIdG2jnR4NE
         oThgWJfjF80eIqoDQOGUB4X28seRSD/AWQDJFux96OPOmRRvBzIxMY21y2iyfEgHtnXk
         AvqtLEdXJZbFY90XFUc9Y6BSoir7czm56vZSzWf1KsKaWmYpHSq9Y2ppOe4rLlChg0Lp
         0nBSg1/FXbQv93SwvCA0jCUS4bQkNaKJntDpn//La1pWaZSr+3Dl92gF4AvwoAtXW+hG
         t4UA==
X-Gm-Message-State: AOAM530NTBZKpLnxs/U9l41qVgnsKx5UTYymVEL7t2Z2AXz9wOITD56y
        VcEvC6jF/CybZI/zTHq58EY=
X-Google-Smtp-Source: ABdhPJx9mtYdhnrB+vR926drj9lChYq1hVwCQzBc0ZUN5zDL0boUpcXA5BOB077b74mGX7OKYjGzVw==
X-Received: by 2002:a05:6512:5d9:: with SMTP id o25mr28894409lfo.146.1626962760867;
        Thu, 22 Jul 2021 07:06:00 -0700 (PDT)
Received: from akaWolf-PC.. ([194.79.5.201])
        by smtp.gmail.com with ESMTPSA id p8sm190584lfu.163.2021.07.22.07.05.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jul 2021 07:06:00 -0700 (PDT)
From:   Artjom Vejsel <akawolf0@gmail.com>
Cc:     thierry.reding@gmail.com, sam@ravnborg.org,
        dri-devel@lists.freedesktop.org, robh+dt@kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        paul@crapouillou.net, akawolf0@gmail.com
Subject: [PATCH 2/3] dt-bindings: Add DT bindings for QiShenglong Gopher 2b panel
Date:   Thu, 22 Jul 2021 17:04:31 +0300
Message-Id: <20210722140432.1426173-3-akawolf0@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210722140432.1426173-1-akawolf0@gmail.com>
References: <20210722140432.1426173-1-akawolf0@gmail.com>
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

