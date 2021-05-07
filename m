Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B0A93765E3
	for <lists+linux-kernel@lfdr.de>; Fri,  7 May 2021 15:14:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237180AbhEGNPc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 May 2021 09:15:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237136AbhEGNPS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 May 2021 09:15:18 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABC73C06138A
        for <linux-kernel@vger.kernel.org>; Fri,  7 May 2021 06:14:17 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id c21so7135917pgg.3
        for <linux-kernel@vger.kernel.org>; Fri, 07 May 2021 06:14:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Z5uRcm+z5t4aeBxWsSjq74fZr3pDWXQjhRR69I0+uIA=;
        b=H3z2qCoLD7IfYuyroPiDy5fAoe2wbDqn1Vnl1mTG/23sUSa0pIb0dBthqVqkDnwxv5
         +gkIBUv8mIFN5pvK/ryk7yl35ZYzq+8nnwQcXY1Bpe0XvVy4vkIQdRhY7J5N1+YssF8D
         5HxJZYjzDawin42Sq91HpOpWvSq7lxCu0Nmcg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Z5uRcm+z5t4aeBxWsSjq74fZr3pDWXQjhRR69I0+uIA=;
        b=TQjD7bclT0yFCN41vQ/Shvg/zrFVFJHWslJG2y307qzl9zNgkkPrHfwCPW8frqA0Tt
         sWM3L/5ODeMyaoW5YmcZTGfhtMQQ2/+LNIAJ1v32/IBV8AJpZ4GMQNTiJ2OgZ2JVUSkn
         xbKfQzbw2nakeobL9MPjbzxevMIL2kLeLM2yYMR+g1P8TSKQn4O7hqJOAfwT5CeZxbTP
         vXoEbchXHFUPi2T3YCWOSq7wX2EOHPnfbNFYMvTkpKE2sd4XZTyoRT1d51GAKIA/NrhW
         SL0Erwf/QD8Bi813XmNV4lenkzH+MKZBIbqgxW0xTxLUId3mc0iRMXh+JDyZ6A1Bchu1
         un8Q==
X-Gm-Message-State: AOAM532nnCL4IG53Rsi8D627WBfqL0SosskDPJHSs5Hax8aZMl6QdGoG
        eEDbYpEyYq29dy9mCRp4k5mFl5oyBprzQg==
X-Google-Smtp-Source: ABdhPJwXgl15gc0vRklpyyJcdK2f9/dPf52EGEjnqBHI+xiQ73HrxYgQkGwIjLYder7XGpt9XbxDYQ==
X-Received: by 2002:a62:3106:0:b029:25c:cd66:3be1 with SMTP id x6-20020a6231060000b029025ccd663be1mr10438925pfx.29.1620393257211;
        Fri, 07 May 2021 06:14:17 -0700 (PDT)
Received: from hsinyi-z840.tpe.corp.google.com ([2401:fa00:1:10:711f:8553:a124:a19])
        by smtp.gmail.com with ESMTPSA id z29sm4656539pga.52.2021.05.07.06.14.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 May 2021 06:14:16 -0700 (PDT)
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
Subject: [PATCH v21 2/5] dt-binding: i2c: mt65xx: add vbus-supply property
Date:   Fri,  7 May 2021 21:14:03 +0800
Message-Id: <20210507131406.2224177-3-hsinyi@chromium.org>
X-Mailer: git-send-email 2.31.1.607.g51e8a6a459-goog
In-Reply-To: <20210507131406.2224177-1-hsinyi@chromium.org>
References: <20210507131406.2224177-1-hsinyi@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add vbus-supply property for mt65xx. The regulator can be passed into
core and turned off during suspend/sleep to reduce power consumption.

Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
Acked-by: Rob Herring <robh@kernel.org>
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
2.31.1.607.g51e8a6a459-goog

