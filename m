Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0051F387F12
	for <lists+linux-kernel@lfdr.de>; Tue, 18 May 2021 19:54:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351407AbhERRzv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 May 2021 13:55:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351341AbhERRzr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 May 2021 13:55:47 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06FE2C0613ED
        for <linux-kernel@vger.kernel.org>; Tue, 18 May 2021 10:54:29 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id z17so11168078wrq.7
        for <linux-kernel@vger.kernel.org>; Tue, 18 May 2021 10:54:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oTjBUDtJCB1J9ynhq80z5EUfzEOQqX8trIBK7k8vqMA=;
        b=K4IpbOBeRCDOgQiM6FDeJT3mk1uhIKsw0dzbEbSPM1skpiUAk+nb9km8r3h/745grb
         /HLeM3mmZwtutSsG50RHiRis51y6YQei9vpzPt8Lz9jAJqcfh5T27atB3JxEUtZjZyIb
         xMIILo0/85wryKnJD9jmv10XAaEHukZ9NYvIoHRzrz42g50p/R5atl2iYlftxJ1zxyoz
         M2Rk93DnSuW1Ijfh2DKwFhi0Fd1VGPcgdrSTH9Pyqp5Ndn7ec4NMbKncBdhIR0ydireS
         Pz3rXpQ4XtkJya2vrNQ8kN0ETSPtXT2znaP1BFE7odo+p+DhnDd2CyGdUumOQ3vp1C8S
         UX/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oTjBUDtJCB1J9ynhq80z5EUfzEOQqX8trIBK7k8vqMA=;
        b=Hmt4z/WKnZZSg3DeNvQ/HITY+vekrpMSFywKAEZ8VB+dkguBc+HrqpOibCSdHsQwmU
         tK/RgKa79+3Uj7azOjHVx5zlKBalVju0TUzwa10+gcnObe7TUgySP9Y71HIvdmyMZYfo
         mw+DCDeX3XtXYt31hPYuuiEUSVR7/fQrnEUsiFN5wcTXV9/hjmUOTH5xe0Eb/7HoT/TZ
         DTpFcIhAz709jzlyD2g2QbWGemDVfL5NnbD/f/4cWpmw/tLWj3OZHaOuWq+UcXspYGXo
         cHnuNa7tzfG5aYlJ6MVo+KZqQuxZU+dlnofVavUupxMeeXFN1vhLVbZsN2BKXwKzv5XE
         Qfzw==
X-Gm-Message-State: AOAM532S8qVbt9F40Ndcas9iPXYhtxWEFfFxrW2IISLZbzSuYc4NanE4
        awZC9ImiwO9giHVQgb/Igb8arQ==
X-Google-Smtp-Source: ABdhPJw8Tr0azrXxw/3cA5XoNuS3GO362ZVgSmK+kMj5HqdWeyqVqXBzGMEbV+QpbfMIDmo1+rvA8A==
X-Received: by 2002:a5d:4346:: with SMTP id u6mr8631720wrr.304.1621360467692;
        Tue, 18 May 2021 10:54:27 -0700 (PDT)
Received: from localhost.localdomain ([88.160.162.107])
        by smtp.gmail.com with ESMTPSA id a17sm14458963wrt.53.2021.05.18.10.54.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 May 2021 10:54:27 -0700 (PDT)
From:   Fabien Parent <fparent@baylibre.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Lee Jones <lee.jones@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     mkorpershoek@baylibre.com, Fabien Parent <fparent@baylibre.com>,
        linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] dt-bindings: pwm: pwm-mtk-disp: add binding for MT8365 SoC
Date:   Tue, 18 May 2021 19:54:21 +0200
Message-Id: <20210518175422.2678665-3-fparent@baylibre.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210518175422.2678665-1-fparent@baylibre.com>
References: <20210518175422.2678665-1-fparent@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add binding documentation to the pwm-mtk-disp driver for the MT8365
SoC.

Signed-off-by: Fabien Parent <fparent@baylibre.com>
---
 Documentation/devicetree/bindings/pwm/pwm-mtk-disp.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/pwm/pwm-mtk-disp.yaml b/Documentation/devicetree/bindings/pwm/pwm-mtk-disp.yaml
index 85bca1c59f95..548ec7e06028 100644
--- a/Documentation/devicetree/bindings/pwm/pwm-mtk-disp.yaml
+++ b/Documentation/devicetree/bindings/pwm/pwm-mtk-disp.yaml
@@ -22,6 +22,9 @@ properties:
       - items:
           - const: mediatek,mt8167-disp-pwm
           - const: mediatek,mt8173-disp-pwm
+      - items:
+          - const: mediatek,mt8365-disp-pwm
+          - const: mediatek,mt8183-disp-pwm
 
   reg:
     maxItems: 1
-- 
2.31.1

