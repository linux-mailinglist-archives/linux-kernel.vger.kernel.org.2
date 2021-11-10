Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5617444C981
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Nov 2021 20:50:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231982AbhKJTxI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Nov 2021 14:53:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231859AbhKJTxG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Nov 2021 14:53:06 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB00EC061767
        for <linux-kernel@vger.kernel.org>; Wed, 10 Nov 2021 11:50:17 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id d5so5984179wrc.1
        for <linux-kernel@vger.kernel.org>; Wed, 10 Nov 2021 11:50:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IvmETFDU1aZRyg9GHS+FGtvzWa39IdshgN6HuoFmqYI=;
        b=dKuxtI2584RvobmXc8CJP3nWR59VbsiSNVrW+FbRSzx2kB3wxpqGivnSRkUcp+4oZO
         lzWMBSPeC5rT0BpFt0LqmblipaIUtKPqVoYM/N1E8gGsmCOHEjbfv8CztelutewnqNTo
         Hhb7cwYhtPmnkx2/NQZKwhXVIfeqpiFiI2bnGiIHQfMyE2+Ml1lzfc6Maz8R/Oo8DVVB
         2JkI1YYbZfiJjJ6MR4jdcb9FXhgS/mj9ivAhVAKHnT8/O7rkfFakekn9UqgqKKHaD4ad
         VDeqnGPDJdCa3HgNZ1Fhl6jFv7I1d+UMvXXiqyVoogMBMl/9ientCN5Nd+RoFByj0mry
         3HHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IvmETFDU1aZRyg9GHS+FGtvzWa39IdshgN6HuoFmqYI=;
        b=4+oDVU47ti2tYzuQ9fxvKc6oX6dnkF5oxLCMZrK1IPbyrJMenjGWS3e+hijDkMpgga
         GQJx7mXZ/+qmOpVyNGIZ6Byqi8EThn7z7/9sbesBxe0kCObyomjH+E+RDPsnMM2B5dwk
         7xEcYFaMDqi0asIn1y1IjbObfb0bWbb59yXnNC+e8LU9HXQSlWSTMnH9aPZLrAqZV4Mz
         KUZuWVky6kb3AR/WmeX3sGZM36fwiZOveOwQ5ORpcUzpYzOqPjeq1Ykhm+JMNa7KgJoc
         TDjf/S35H7ZWM6MoJ39N86YJCsbss1qJhQ/rJXOGyK7YD0hWFngjS53vlXFK56KiOkko
         dnNA==
X-Gm-Message-State: AOAM533WwIShQ/Ba6npOSA9Tyjym0777nXa4hNdSFLme2HzTK9Mmgr/0
        skL+/mykrNG9aniErm8grrb5YQ==
X-Google-Smtp-Source: ABdhPJyt91L5dhbRUokBF789uCxIJneb+BFFENpsod7T3a54QzIpI6DlYXnYJQHB/pK/KpbL5weNvg==
X-Received: by 2002:a5d:47c7:: with SMTP id o7mr2028688wrc.204.1636573816415;
        Wed, 10 Nov 2021 11:50:16 -0800 (PST)
Received: from localhost.localdomain ([88.160.162.107])
        by smtp.gmail.com with ESMTPSA id k15sm750935wrx.53.2021.11.10.11.50.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Nov 2021 11:50:15 -0800 (PST)
From:   Fabien Parent <fparent@baylibre.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Qii Wang <qii.wang@mediatek.com>
Cc:     Fabien Parent <fparent@baylibre.com>,
        Rob Herring <robh@kernel.org>, linux-i2c@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/4] dt-bindings: i2c: i2c-mt65xx: add binding for MT8365 SoC
Date:   Wed, 10 Nov 2021 20:49:57 +0100
Message-Id: <20211110194959.20611-2-fparent@baylibre.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211110194959.20611-1-fparent@baylibre.com>
References: <20211110194959.20611-1-fparent@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add binding documentation for the MT8365 I2C controllers.

Signed-off-by: Fabien Parent <fparent@baylibre.com>
Acked-by: Rob Herring <robh@kernel.org>
---

v3: rebased
v2: No change

 Documentation/devicetree/bindings/i2c/i2c-mt65xx.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/i2c/i2c-mt65xx.yaml b/Documentation/devicetree/bindings/i2c/i2c-mt65xx.yaml
index af0880fcc22b..843f3b22e975 100644
--- a/Documentation/devicetree/bindings/i2c/i2c-mt65xx.yaml
+++ b/Documentation/devicetree/bindings/i2c/i2c-mt65xx.yaml
@@ -27,6 +27,7 @@ properties:
           - mediatek,mt8173-i2c
           - mediatek,mt8183-i2c
           - mediatek,mt8192-i2c
+          - mediatek,mt8365-i2c
       - items:
           - enum:
               - mediatek,mt2701-i2c
-- 
2.33.1

