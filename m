Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E1A536EE8D
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Apr 2021 19:04:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240930AbhD2RE7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Apr 2021 13:04:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240929AbhD2RE6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Apr 2021 13:04:58 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DEE7C06138C
        for <linux-kernel@vger.kernel.org>; Thu, 29 Apr 2021 10:04:11 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id p6-20020a05600c3586b029014131bbe5c7so106184wmq.3
        for <linux-kernel@vger.kernel.org>; Thu, 29 Apr 2021 10:04:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tHdvLci4AjeWueXRfl+ywrg6Pi3jWbPlIYdsAlZWirA=;
        b=Go+ktUieE1y5w7VouhAHT1nD6iJ2PflfhXDn4lVlwCWRDuTPfj1Pj7Gb2Vj5UJlqgr
         exf6TD4FxTUx/CO9TbYzJZytkkEXFL5szCsoKMi5FzFPq7wljOwqnZskqgr22eehdTDZ
         ONxHAa4hJeQWhzu05HfPFy55aL1RwnWuIynQ2Cjh2Gjfi89Q26ty1+TSDrRa6QQcGWnn
         aF0qD9ggCwsyo20pV1n7hm+iVS0up6RiApRND31g9B3Fv0sAjxD2xc24Oy7a/vfU1/C1
         oQYwFQGFjXx+d/vtFbOKUmeAn30SLRhfmvrSyNW4uQ4Kt/IvW+azzydwks5k0r6sAvqo
         hRKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tHdvLci4AjeWueXRfl+ywrg6Pi3jWbPlIYdsAlZWirA=;
        b=pPdv5GZ+x1JJbPhzjNFRrCt3x7y1Vbq4H701oxFpMasWgpNPmqa2/ziuwT5AFPrf/L
         P7Us+rA9yIzulZed+7hHL90SADzdIKLviCJTSzpWVBXRczOgIhEZyfr2Ebs/8huDyaEd
         R0XyGhW1k0P3OZwlr8qiYkg57HOEre+kVqDh5ntL1fbzIZShzS+vO4FWAYQwP2rRdSh6
         iOI3yNPkK7TCH11iA07Z2CB1hjEfee0U3ohR7eLlNBlsg079czpWU5VuPqIEgMc3tXhH
         fQZ+Eq3PkxH+/q+yL1HhLdvc/kR5i1wDNzOrbntzx6sDL9MzxiaoSGW6u6okP1sDg0kS
         B/JQ==
X-Gm-Message-State: AOAM530mY0VvUmCTB+CmOLwsYujYs2aTBL0dqV3Wdq0xfWGSu8QIomhd
        7o8zm66rX1mfem96Is4AxAsRhg==
X-Google-Smtp-Source: ABdhPJyHu2ZQXATO3CS2wDNOUAsdz6c46NgNdi4tAh5px8nKSJfYM5xbkZOG7QhbTBvsfFdUviDJtA==
X-Received: by 2002:a1c:3505:: with SMTP id c5mr11492526wma.169.1619715849941;
        Thu, 29 Apr 2021 10:04:09 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:90c:e290:c304:4b2b:4a79:1da9])
        by smtp.gmail.com with ESMTPSA id 18sm11041275wmo.47.2021.04.29.10.04.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Apr 2021 10:04:09 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     khilman@baylibre.com, jbrunet@baylibre.com,
        martin.blumenstingl@googlemail.com, devicetree@vger.kernel.org
Cc:     linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: [PATCH 2/3] dt-bindings: arm: amlogic: add Banana PI M5 bindings
Date:   Thu, 29 Apr 2021 19:04:03 +0200
Message-Id: <20210429170404.3616111-3-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210429170404.3616111-1-narmstrong@baylibre.com>
References: <20210429170404.3616111-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add bindings for the Banana PI M5 board.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 Documentation/devicetree/bindings/arm/amlogic.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/amlogic.yaml b/Documentation/devicetree/bindings/arm/amlogic.yaml
index 5f6769bf45bd..4eaf400c3522 100644
--- a/Documentation/devicetree/bindings/arm/amlogic.yaml
+++ b/Documentation/devicetree/bindings/arm/amlogic.yaml
@@ -164,6 +164,7 @@ properties:
       - description: Boards with the Amlogic Meson SM1 S905X3/D3/Y3 SoC
         items:
           - enum:
+	      - bananapi,bpi-m5
               - hardkernel,odroid-c4
               - hardkernel,odroid-hc4
               - khadas,vim3l
-- 
2.25.1

