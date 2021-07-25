Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65A213D505E
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jul 2021 00:16:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231293AbhGYVfj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Jul 2021 17:35:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231239AbhGYVfh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Jul 2021 17:35:37 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23CCDC061757;
        Sun, 25 Jul 2021 15:16:06 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id x7so9008679ljn.10;
        Sun, 25 Jul 2021 15:16:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SgL0jl+mGyF6SSLvs6k02lrCaESH25yjasdaW3GUG0o=;
        b=XVJjTIPxvnEWl4SG7Nf+hPCcxTuaZPN5sl9Z6oIY8QhhteqMKX1+81uH4TmUjWkiRb
         Hl6eGd/Udy8KUC+68+8Um7NMvBJ23Ir/LSmflE6RmiZXHOXc3OPkT0vQ6vk506PmJbXk
         oz9TkdfMBQ/RWkWoik78kXGRtMneGJrPpTaKxxc4xLI9FK17PGXs7WnMCrngIvjrted/
         zPk84qETZLDO46YFmjPQXsbVkoWAWVB+hx9Jfahi3Avjq98DlopGN4ooOqLm72Mxscle
         m/fhTuHyBM4Gk8fb1sCFAIY7Lxyk2Qmn1mTytNifevzXYwWK2nfnrrXGNARYH4eKZAwG
         Xmkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SgL0jl+mGyF6SSLvs6k02lrCaESH25yjasdaW3GUG0o=;
        b=A+25G+TeDuak/k0UBwd3au0pTUS7qMGCpQMJIxi13gv6VTHzW7140xlEYGCOLrPTYQ
         8APXcmfQKCT6UuKtE++2sewT2i2WMBAFRf3s6gBwd6yw6CuvkI/bVl7/1/QTLLDhUla4
         9SPkJeQXIE4WOGC4I51EK3ygpvaJW02Qh7Fklmq26Hh+z3z7ct90eJVSL7ddyagaYWDi
         g/reFikIH11SKeJYCO42mVLdjnzUU65A9AjJq/cZyrAypCyuhcINhcSu7zb5VhLqwGK0
         hnyHbpELxgAihdTXrcMyaVLRI4PcGA3azA8NLluc54WYcJCwQQbMH+0h6t+idOgd3Tcx
         r8ng==
X-Gm-Message-State: AOAM533Eq9CabgJAnZ8k2xGeuBlPigV9uTta7/yQqi1H1aEhTdXnh45n
        o9tbXsmY2MQJYXf5qutK+gs=
X-Google-Smtp-Source: ABdhPJwBU2jxUb/QN5CBkad1DB5Az/HhP0LQMBNTgpBFw3PXObxa8LTzkcmGR0JvZdp/GsVaigtQUw==
X-Received: by 2002:a2e:98c8:: with SMTP id s8mr10370354ljj.495.1627251364569;
        Sun, 25 Jul 2021 15:16:04 -0700 (PDT)
Received: from akaWolf-PC.. ([194.79.5.201])
        by smtp.gmail.com with ESMTPSA id z12sm2862647lfu.53.2021.07.25.15.16.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Jul 2021 15:16:04 -0700 (PDT)
From:   Artjom Vejsel <akawolf0@gmail.com>
Cc:     thierry.reding@gmail.com, sam@ravnborg.org,
        dri-devel@lists.freedesktop.org, robh+dt@kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        paul@crapouillou.net, akawolf0@gmail.com
Subject: [PATCH v3 2/3] dt-bindings: Add DT bindings for QiShenglong Gopher 2b panel
Date:   Mon, 26 Jul 2021 01:15:26 +0300
Message-Id: <20210725221527.1771892-3-akawolf0@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210725221527.1771892-1-akawolf0@gmail.com>
References: <20210725221527.1771892-1-akawolf0@gmail.com>
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

