Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0904935EFE6
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 10:46:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350328AbhDNIkg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 04:40:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350205AbhDNIjK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 04:39:10 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 518C1C061343
        for <linux-kernel@vger.kernel.org>; Wed, 14 Apr 2021 01:38:20 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id l76so13893429pga.6
        for <linux-kernel@vger.kernel.org>; Wed, 14 Apr 2021 01:38:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7XXmpI6HkWp3If8HQFwzyKKNYzDH+WeOIEtuebDT2y0=;
        b=R0Oru1OcUZBxs5N76VWsx4+y0qphIgDd3Khgl47MGvgDk1J0mcJujNHWcDbSHMw4vk
         retbPZHixrp0BJSeAXCiluZ9waJuMYWYhRNeOqx8VSPLeJ6oKNsH7jwVtxn3z+2Gi1LW
         ZAN+yoYP+K8ioD/XXhw+T0FlrkDDEFPdnwg88=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7XXmpI6HkWp3If8HQFwzyKKNYzDH+WeOIEtuebDT2y0=;
        b=RD1y5yUujqwta6I2AvMJgdS+1VxquJbd2fRBybv0EB9NEmfUIb1ku/ZvOhy3Zd99D1
         0YeFr2iGQVyQJBpSvWifnu/4fhY9H4M1xDoZzLUcmVzpUndrQkVM0lWo5ATidhFWoJuk
         Mdybm2/B2AL0pYxdqL8iP98UsWHH0upxiLCCznn1a8VrxI1rbqf9jVfduF87p85PQw+C
         h1dCoznNO2C+q78aN4nYfstDGjSWR4NluuDJm5926Pn8wN32WP4GibIazrM4KzPnve2q
         jBrzbUeBa8uBGvRnvvnsNmJLky2qcxnX6xIO2tGgAiV+ab7xuC4gl2Mhq7Hyr504MuhQ
         sb/w==
X-Gm-Message-State: AOAM533+iMCrBMyCUMd+VKoVoy/rgBXmtH3TuQ3Ja8ecBDDgbYUYkpxB
        rmyiWZRK4vAuGbjQ3DlQaegw/Q==
X-Google-Smtp-Source: ABdhPJz8ts/rFcx+fO1sCnhZkR6UKWNkO2GMDiHGUXl3hfNTchm75W/OIyecWwcg+qif9NTMmXCj7g==
X-Received: by 2002:a63:4644:: with SMTP id v4mr4335415pgk.316.1618389499788;
        Wed, 14 Apr 2021 01:38:19 -0700 (PDT)
Received: from hsinyi-z840.tpe.corp.google.com ([2401:fa00:1:10:bae3:4af0:9792:1539])
        by smtp.gmail.com with ESMTPSA id g24sm8901582pfh.164.2021.04.14.01.38.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Apr 2021 01:38:19 -0700 (PDT)
From:   Hsin-Yi Wang <hsinyi@chromium.org>
To:     Wolfram Sang <wsa@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Cc:     linux-i2c@vger.kernel.org, Qii Wang <qii.wang@mediatek.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Brown <broonie@kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Bibby Hsieh <bibby.hsieh@mediatek.com>,
        Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH v18 2/5] dt-binding: i2c: mt65xx: add vbus-supply property
Date:   Wed, 14 Apr 2021 16:38:06 +0800
Message-Id: <20210414083809.1932133-3-hsinyi@chromium.org>
X-Mailer: git-send-email 2.31.1.295.g9ea45b61b8-goog
In-Reply-To: <20210414083809.1932133-1-hsinyi@chromium.org>
References: <20210414083809.1932133-1-hsinyi@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add vbus-supply property for mt65xx. The regulator can be passed into
core and turned off during suspend/sleep to reduce power consumption.

Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
---
 Documentation/devicetree/bindings/i2c/i2c-mt65xx.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/i2c/i2c-mt65xx.txt b/Documentation/devicetree/bindings/i2c/i2c-mt65xx.txt
index 7f0194fdd0cc..2c45647e9f0b 100644
--- a/Documentation/devicetree/bindings/i2c/i2c-mt65xx.txt
+++ b/Documentation/devicetree/bindings/i2c/i2c-mt65xx.txt
@@ -32,6 +32,7 @@ Optional properties:
   - mediatek,have-pmic: platform can control i2c form special pmic side.
     Only mt6589 and mt8135 support this feature.
   - mediatek,use-push-pull: IO config use push-pull mode.
+  - vbus-supply: phandle to the regulator that provides power to SCL/SDA.
 
 Example:
 
-- 
2.31.1.295.g9ea45b61b8-goog

