Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C38D531F2A1
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Feb 2021 23:58:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230029AbhBRW4h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Feb 2021 17:56:37 -0500
Received: from smtpcmd0986.aruba.it ([62.149.156.86]:43275 "EHLO
        smtpcmd0986.aruba.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229953AbhBRW4d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Feb 2021 17:56:33 -0500
Received: from ubuntu.localdomain ([146.241.168.111])
        by Aruba Outgoing Smtp  with ESMTPSA
        id CsCZl9zcdJFRNCsCjlTfPl; Thu, 18 Feb 2021 23:55:25 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aruba.it; s=a1;
        t=1613688925; bh=s/UERopb9u0RDrgH/LWOENkyuqsgqusgzZkHdljYKTk=;
        h=From:To:Subject:Date:MIME-Version;
        b=Rdhb/i9stIJCzNzxXLxApmzLCiMQJBI5FAHm+kO3JzZyMkHYL1Yd1Z4c+kiNyTIvJ
         pa1M2d/GoyVaW02RWFvS2w7Z73/ZXY1zn11iV5awYFNMqyMZZeXMaSmcjXpGCvF7rv
         uY049t9gwelNcBCUsYdKupGeRp7AUJO6ulnuunxw3KJ2/cajWxzgBz0qbLLUwkC0K+
         k30gj+0X6M5UicrsF9AITw9XAjvaKYgzuz90mSsQu7Tnpe39ckqdGQYOh8OnMNBHeC
         6lz5kP2Ty5vd56FEgZxctkslINj+rbpYanWWQRW23jUKaowCkfEviGdm/jOTlblWat
         BLqW+p+Wz9jmg==
From:   Giulio Benetti <giulio.benetti@benettiengineering.com>
Cc:     Giulio Benetti <giulio.benetti@micronovasrl.com>,
        Giulio Benetti <giulio.benetti@benettiengineering.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Shawn Guo <shawnguo@kernel.org>,
        Daniel Palmer <daniel@0x0f.com>,
        Lubomir Rintel <lkundrak@v3.sk>, allen <allen.chen@ite.com.tw>,
        Max Merchel <Max.Merchel@tq-group.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/9] dt-bindings: display/panel: add Jenson JT60248-01
Date:   Thu, 18 Feb 2021 23:54:50 +0100
Message-Id: <20210218225458.823773-3-giulio.benetti@benettiengineering.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210218225458.823773-1-giulio.benetti@benettiengineering.com>
References: <20210218225458.823773-1-giulio.benetti@benettiengineering.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfNGSe8xYL/gly+QRtGwDO2BRDu0xq01vqHThCGzmD+zo53ZA/Ax+nhZGi0ZYcXVVQ9yxSfod5BHxa8gUg1itK5rCV+fRCoKr4AZR2ykez4CasqVgGJCG
 tZFamF3ONC/ndY6yCQymmWsGTqtuqr8dFIw6+F7/NWf4h8pHqqFI/IDTuTf+V1vB2hz/LQXEua2Nancwd3P0ihLzCf8DkYcqy1IkSQIYhfNKifilOxRIIZSW
 j58AW0DFL1bQ4JILH2apQmg0GY6NPTZv2Bcy5aliOpfbLa7iuGgPna2xTlteRKOQlmCCygonhzBBOGXLEUB7svyRXLvBLbx8h8JQdd4yUdyrFkdxl5lqXaAD
 4AUVhFX63LvEeOT3Dg5rnXIFe764/440kNg6jvLOv0w28w8+7zWLp8SGZq6AWX7JCJqqFjms/yKP6ICu88vBbkotBHTZJ+I9N1E2/QnU+nEEPehIg1C79JYF
 uAqPC2953ivmuUKfKnl9/ryDV+SEHaDlgcWXGb+55Tv/7GtfcWrgfjJPn/n5i5bSjBglUAGeMT5Xvo4y5Q4S8OcdJI/cKx4IvyIsV0HCqMtAZeof5W31YDES
 IrfrrfiQv8NOvGFLHIADRsAOV+Oq2/RdEanN1T4ub1Szjqe3H/5Wx7sMJwgvl0rmOev15X+6gpV7hEh37K+sN9jQJJHEoZA1Izzl/s8yfYJBn+W0MdKgdQBY
 oG6J9RGluGvMVdyd5MXDZpbzb+6qaknAiOcq9Oo/iChtFRxNHRNj38sQ32n0pvR+VaHjVmN6pX/7Jc1rgOCnbWmfiLaqIzWq3BmA3nHpm6PlNoTg6o3O4Q==
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Giulio Benetti <giulio.benetti@micronovasrl.com>

Add DT binding for "jenson,jt60248-01".

Signed-off-by: Giulio Benetti <giulio.benetti@micronovasrl.com>
Signed-off-by: Giulio Benetti <giulio.benetti@benettiengineering.com>
---
 .../devicetree/bindings/display/panel/panel-simple.yaml         | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/panel/panel-simple.yaml b/Documentation/devicetree/bindings/display/panel/panel-simple.yaml
index 27fffafe5b5c..d4359f09818a 100644
--- a/Documentation/devicetree/bindings/display/panel/panel-simple.yaml
+++ b/Documentation/devicetree/bindings/display/panel/panel-simple.yaml
@@ -165,6 +165,8 @@ properties:
       - innolux,n156bge-l21
         # Innolux Corporation 7.0" WSVGA (1024x600) TFT LCD panel
       - innolux,zj070na-01p
+        # Jenson Display JT60248-01 4,3" (480x272) TFT LCD panel
+      - jenson,jt60248-01
         # King & Display KD116N21-30NV-A010 eDP TFT LCD panel
       - kingdisplay,kd116n21-30nv-a010
         # Kaohsiung Opto-Electronics Inc. 5.7" QVGA (320 x 240) TFT LCD panel
-- 
2.25.1

