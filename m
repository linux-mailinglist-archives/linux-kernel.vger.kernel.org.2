Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18015354750
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Apr 2021 22:04:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234934AbhDEUEM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Apr 2021 16:04:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233253AbhDEUEG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Apr 2021 16:04:06 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B837C061756
        for <linux-kernel@vger.kernel.org>; Mon,  5 Apr 2021 13:03:59 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id r14-20020a05600c35ceb029010fe0f81519so4667379wmq.0
        for <linux-kernel@vger.kernel.org>; Mon, 05 Apr 2021 13:03:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JoeUTxMIo7LMD3N8t52A8FukB5jFgXLkXXTJN8fbj+g=;
        b=g73AJIK25WP7XEAoyKc7uRpenUTjoxW84YeeUt/evdm9XIRXr69JfRXYFkGMqzV5Zc
         GLOq1FHgWcnsdC99b/QWDG3U5HDN2zu5WBLYCpn85QVnMBfA8sXYpyDCPsAIxI0tLYIa
         XgkpOommHHa+TIbX4L+25NYFLckVmXa+WcFXhq5IcdTiUFiWSp65ukjESs2uvBCel5Ii
         jdG4lRVNtnm6815RFBeOE/lNW5XkI1JajH7PLM4cKaDqqVcPNwgmI2qFUpqHAWgjjE81
         8CPbdEWde5U89020coWs3O8nXg5Mdy0kAGsghHkIzD4h5RMOpJkA2+HtP6qmDRjC0Yjt
         p8XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JoeUTxMIo7LMD3N8t52A8FukB5jFgXLkXXTJN8fbj+g=;
        b=LGkX5TX9rBtgrGixOF31gK/NXny9hLv8eC1ckA2CyC1DMCiQ7n8j6vnK7ADtk9mPay
         3mHlYblkTq4KxZcjcEAfbm67HE3mgIxuCLd7jA7RMSYsagVJm2B92AU3G3hjeshkpqem
         OilReLjlpYekHkb2ae/E4sw36qU65gSrJgVEi8te7kbQYicgWqikb5g02vNEb57cfFDN
         6kytSbyUzn7bDVr9aLl3xI7jAEBLCmwUhi0xErpXFhoaVpPhwa8Re5x6WbHAb/t6PCi4
         sEgsiWznFQvxDKHjt5nUgWWv4dYvrnxehFqlARMVZjKBE0CGpjs6CXCXgOz+hwRlQX4o
         KWUg==
X-Gm-Message-State: AOAM530SATVy3jir9BqNNXofvMzA7qbi4+1tP1r29tt4xa+ksGEBiB6D
        fnB8hBsSue/CZY5lzR0KCxonPw==
X-Google-Smtp-Source: ABdhPJy+F/Eu8jOmRExeF5RKu7rRF45ePmTNcKbmTRjD6JUofz2BXs66rVi7VFML/IEm1eiXtHzCBA==
X-Received: by 2002:a1c:7406:: with SMTP id p6mr645945wmc.103.1617653038083;
        Mon, 05 Apr 2021 13:03:58 -0700 (PDT)
Received: from localhost.localdomain ([88.160.162.107])
        by smtp.gmail.com with ESMTPSA id i26sm657406wmb.18.2021.04.05.13.03.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Apr 2021 13:03:57 -0700 (PDT)
From:   Fabien Parent <fparent@baylibre.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     mkorpershoek@baylibre.com, Fabien Parent <fparent@baylibre.com>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH v2 1/2] dt-bindings: mediatek: mmsys: add mt8167 binding
Date:   Mon,  5 Apr 2021 22:03:52 +0200
Message-Id: <20210405200354.2194930-1-fparent@baylibre.com>
X-Mailer: git-send-email 2.31.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add binding documentation for MT8167 SoC.

Signed-off-by: Fabien Parent <fparent@baylibre.com>
Reviewed-by: Chun-Kuang Hu <chunkuang.hu@kernel.org>
Acked-by: Rob Herring <robh@kernel.org>
---
V2: Rebased + fix typo in commit message.

 .../devicetree/bindings/arm/mediatek/mediatek,mmsys.txt          | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/mediatek/mediatek,mmsys.txt b/Documentation/devicetree/bindings/arm/mediatek/mediatek,mmsys.txt
index d8c9108c3b4a..78c50733985c 100644
--- a/Documentation/devicetree/bindings/arm/mediatek/mediatek,mmsys.txt
+++ b/Documentation/devicetree/bindings/arm/mediatek/mediatek,mmsys.txt
@@ -13,6 +13,7 @@ Required Properties:
 	- "mediatek,mt6779-mmsys", "syscon"
 	- "mediatek,mt6797-mmsys", "syscon"
 	- "mediatek,mt7623-mmsys", "mediatek,mt2701-mmsys", "syscon"
+	- "mediatek,mt8167-mmsys", "syscon"
 	- "mediatek,mt8173-mmsys", "syscon"
 	- "mediatek,mt8183-mmsys", "syscon"
 - #clock-cells: Must be 1
-- 
2.31.0

