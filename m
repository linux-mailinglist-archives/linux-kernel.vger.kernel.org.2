Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D92603D8DAF
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jul 2021 14:26:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235120AbhG1M01 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jul 2021 08:26:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234601AbhG1M0W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jul 2021 08:26:22 -0400
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2C4AC061757;
        Wed, 28 Jul 2021 05:26:20 -0700 (PDT)
Received: by mail-qk1-x72f.google.com with SMTP id t66so2010222qkb.0;
        Wed, 28 Jul 2021 05:26:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0uGMLBbvQN8srNkNvfT+Pk/8+H4pNrxtnpo3vhHBUd8=;
        b=gNRzuSOY4nKjngNm7Tvd9GEhb9D25zo/YGvVGrukH8YRQNnbe9rvJuobZUu9KW+Uzw
         v8Aa9Sw21Apf8PnXKfVJ67Os5VGW+rT2TT8NJGYKiHKNjV94h7VQH1J7Th+6/E4MrWQl
         +YSHUZ0B93JeFMSdVDPpWWeMKBeO/9dFvQkPX/SzazJAazqYA+aywP1D/KaPiq7m3i2O
         nuO1O8+O/EmsH4J5hhAofTXEp7OGvHKUTxaJofTpvJ4fxlKhkZuUb3pl9w6JfYT5yaZS
         C2D1ur9LTdqyPc28wVSag3jKx6KcjFASZ1DLj0eGwkapw6+uNz3k+z3pbD00rFiri498
         EGqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0uGMLBbvQN8srNkNvfT+Pk/8+H4pNrxtnpo3vhHBUd8=;
        b=dy3Si15d/3xrCwcY+jdPUc8tXM8+T2xMULiYaHxcspYdS5deYO93pXjSzEicOyvHye
         6s5/u5EZs1H2SkEldPfakMbjO6VAdDJiC9gJPIMJc3DfEVIZDB1zfva4EPe6zYu2rLml
         rRfFUTnVBPIPssVilF9NH9t42GBXsaKh57BA2ENH/TKQFEPhdGlsWgiwrIHy1HJ4ZfaF
         VEydy9cNzfeCl8W0U2s96Fw7mslZ9jowjc6lgbAyVbEbyYo+c36Rr7cfjtS27F1/v4Ee
         sJABtBApuH3rOVI6BjesMR5n49OD34HjwWFPYeFklVQ8WfJhrD5wyYklmnhOBUvbO+9R
         q2RQ==
X-Gm-Message-State: AOAM532aP9fRdtYQGeYwnJ4vR/AmyB+5x5n/LEOTvVUaPfIfgQn//xR4
        s9I79/8UMoSyWyw6hud73Bk=
X-Google-Smtp-Source: ABdhPJwYGB4iyvpoc8D3mrR5HxybYHOJ0Q1HhDsTfV3Ay9gHOJh3Y3rTnzBm0bWpIYVZZnaWK3Ww1Q==
X-Received: by 2002:a37:487:: with SMTP id 129mr26373367qke.154.1627475180131;
        Wed, 28 Jul 2021 05:26:20 -0700 (PDT)
Received: from master-laptop.sparksnet ([2601:153:980:85b1:b58:2ae8:d75f:660a])
        by smtp.gmail.com with ESMTPSA id z9sm2842972qtn.54.2021.07.28.05.26.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jul 2021 05:26:19 -0700 (PDT)
From:   Peter Geis <pgwipeout@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-phy@lists.infradead.org, Peter Geis <pgwipeout@gmail.com>
Subject: [RFC PATCH 3/9] dt-bindings: usb: generic-ohci: increase maximum clocks
Date:   Wed, 28 Jul 2021 08:26:00 -0400
Message-Id: <20210728122606.697619-4-pgwipeout@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210728122606.697619-1-pgwipeout@gmail.com>
References: <20210728122606.697619-1-pgwipeout@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The rk3568 generic ohci controller has four clocks.
Increase the maximum clocks in the documentation to account for this.

Signed-off-by: Peter Geis <pgwipeout@gmail.com>
---
 Documentation/devicetree/bindings/usb/generic-ohci.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/usb/generic-ohci.yaml b/Documentation/devicetree/bindings/usb/generic-ohci.yaml
index 569777a76c90..850996e6f451 100644
--- a/Documentation/devicetree/bindings/usb/generic-ohci.yaml
+++ b/Documentation/devicetree/bindings/usb/generic-ohci.yaml
@@ -59,7 +59,7 @@ properties:
 
   clocks:
     minItems: 1
-    maxItems: 3
+    maxItems: 4
     description: |
       In case the Renesas R-Car Gen3 SoCs:
         - if a host only channel: first clock should be host.
-- 
2.25.1

