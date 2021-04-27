Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F4C636BEF7
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 07:37:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234240AbhD0FhZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Apr 2021 01:37:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230338AbhD0FhM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Apr 2021 01:37:12 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FD27C06175F
        for <linux-kernel@vger.kernel.org>; Mon, 26 Apr 2021 22:36:28 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id e9so13259004plj.2
        for <linux-kernel@vger.kernel.org>; Mon, 26 Apr 2021 22:36:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ch2oBLC6NQEww7nsJ+lCH4p8Gxy8IDtfp3C2k0cWO+A=;
        b=iDT/mscq6c4jBDu4qaDzOe3nXm1ALmCUYfi+kLqFJOGJboFHaIsHKm5eQHmbuEaUsi
         e2pm1psA/gibSKNBQ3QDGIwJaA0qTniHLFxuyTSeDExIYdYDSY0aUtM15Ab32BvDrU3X
         Fqw0WP+vbOmWk1ZVtLuq3op9CLgo0pp9ZczUk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ch2oBLC6NQEww7nsJ+lCH4p8Gxy8IDtfp3C2k0cWO+A=;
        b=E6+B2cjQMqwlubB5NUoN+euOknDu3UnufbicPpJlFbAHgxsIZ5TiQ7DGYGmpLlhitK
         KrztiFSvwKKn8/qg8yQmcl1Wd2ATT2U7LFB/1WQ25y781Lkie6g4R60xNudgHPG1idoK
         qa17361510qy6FyMlOoUNJVa7af4oAWq2TkBSzu1MWnzI+gDFkD6XLY2S0niEK9Orrd4
         t7HFWeIFmN1/WHT6hFT5WoBGFrPKELlZ4frMKClBEC06/GvGFuahhTsTzGqRh8KUKENZ
         3H0k8LwFt616fNqiuKQ/CnjcsZXftzKVCkAUc9aTknwmAslMw7QHqDqPlvHWz+9DJGOo
         MqpQ==
X-Gm-Message-State: AOAM533wEsxts5DD8CM0NWgkTfOANfcbWvl3eI13br4woZNN0YvDYVyr
        60XGJjnbbvRt75xwho/+8nPU5w==
X-Google-Smtp-Source: ABdhPJx+gZbECjl99mVB5kXeY+H3By4RaE8KMXOPfabslEPl1PyacDfTdB7lt1pkQt0cn6pfYCGwgw==
X-Received: by 2002:a17:902:db03:b029:ec:94dd:b6b3 with SMTP id m3-20020a170902db03b02900ec94ddb6b3mr22246181plx.69.1619501788150;
        Mon, 26 Apr 2021 22:36:28 -0700 (PDT)
Received: from hsinyi-z840.tpe.corp.google.com ([2401:fa00:1:10:3984:c4f5:8612:6b3e])
        by smtp.gmail.com with ESMTPSA id gc15sm993529pjb.2.2021.04.26.22.36.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Apr 2021 22:36:27 -0700 (PDT)
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
Subject: [PATCH v20 2/5] dt-binding: i2c: mt65xx: add vbus-supply property
Date:   Tue, 27 Apr 2021 13:36:14 +0800
Message-Id: <20210427053617.27972-3-hsinyi@chromium.org>
X-Mailer: git-send-email 2.31.1.498.g6c1eba8ee3d-goog
In-Reply-To: <20210427053617.27972-1-hsinyi@chromium.org>
References: <20210427053617.27972-1-hsinyi@chromium.org>
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
2.31.1.498.g6c1eba8ee3d-goog

