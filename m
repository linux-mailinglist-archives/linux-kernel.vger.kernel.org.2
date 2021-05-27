Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABCDA392916
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 09:56:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235316AbhE0H6T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 May 2021 03:58:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235213AbhE0H5l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 May 2021 03:57:41 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE3E3C061761
        for <linux-kernel@vger.kernel.org>; Thu, 27 May 2021 00:56:07 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id f22so3054612pfn.0
        for <linux-kernel@vger.kernel.org>; Thu, 27 May 2021 00:56:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MM8kzddH0ZuV0BgZsD6j/UZqR+lPZQliP2/mR7NqPNQ=;
        b=FnkqpDhRWtVgo98ZZzaFBu0d9tAx5+WqDrox/kScBtBSg+ZPgbBqYUf9050eZhoYqC
         UxGHrsorZlaYjWFhpa9O9UVUWJR+/gKBTBev+95L8cN9hHHLRsrhh4Si8ZNLnxiB2Swc
         HqOS4zXE1l3gZveClF6Zwx6TCcY7Aaf5ExlkY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MM8kzddH0ZuV0BgZsD6j/UZqR+lPZQliP2/mR7NqPNQ=;
        b=YmNp3wxcgHQdYaviN//eCTj5sv9CsHAsursyXerZFOAd2XRrr1xNDTA4DYGFWger2X
         S/STReNwNQ+4yUGiN62KNBvWX16ULu2XrJ8y14+Qjx7a1QYm3/tnDMrGIy961B0Pyaa6
         e4AfT/GjuZtm7rB4bZ1QijkBy0QNOnh2t0y6zExqkrpDgXdds0VB+sBPbJCaEga4bfVc
         2RheNSZ29PqOP8c1GF8l/eAAvkC+mjEJKVC8gZM4jiLev20YsAaciaQNV7i9qQqVJw6L
         e47kvHM/adnOTTAZLyZ8v4/gOa8ZJzRDVccTTw+ZWbWgKU7vBueZeIQNGRnWOLZ5Zlww
         Y/Ng==
X-Gm-Message-State: AOAM533REQXBNOAe96Ljt3OsRyg1HCCuy/eTW41wtLtWMy88sVdHzlOQ
        y0ILo8kwSc/wTfRFFAhSMRGywg==
X-Google-Smtp-Source: ABdhPJyOChGktKvovO4oemHNBggRkAwTN52ULnjVngUsAWsrKKPIL7V1slxR+WXS+Ib+L6oEWikEHA==
X-Received: by 2002:a63:1260:: with SMTP id 32mr2593858pgs.232.1622102167325;
        Thu, 27 May 2021 00:56:07 -0700 (PDT)
Received: from hsinyi-z840.tpe.corp.google.com ([2401:fa00:1:10:ece5:55a4:6ad3:d20f])
        by smtp.gmail.com with ESMTPSA id 69sm1217790pfx.115.2021.05.27.00.56.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 May 2021 00:56:07 -0700 (PDT)
From:   Hsin-Yi Wang <hsinyi@chromium.org>
To:     Wolfram Sang <wsa@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Jean Delvare <khali@linux-fr.org>,
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
Subject: [PATCH v21 RESEND 2/4] dt-binding: i2c: mt65xx: add vbus-supply property
Date:   Thu, 27 May 2021 15:55:54 +0800
Message-Id: <20210527075556.1709140-3-hsinyi@chromium.org>
X-Mailer: git-send-email 2.31.1.818.g46aad6cb9e-goog
In-Reply-To: <20210527075556.1709140-1-hsinyi@chromium.org>
References: <20210527075556.1709140-1-hsinyi@chromium.org>
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
2.31.1.818.g46aad6cb9e-goog

