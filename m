Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4749B322F48
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Feb 2021 18:02:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233680AbhBWRBF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Feb 2021 12:01:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233551AbhBWRAy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Feb 2021 12:00:54 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3673CC061786;
        Tue, 23 Feb 2021 09:00:13 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id n4so23331814wrx.1;
        Tue, 23 Feb 2021 09:00:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=OEwefO5s7q5tH8TqEcawfPCkw0BmTmIeA1fwlofl6+E=;
        b=Bvq5kq6G7MCxav6SCKRj9tVkSW2MxAaxSfktzpSeV0/O3T/obTjyqum3K1iDlWWgct
         9mQZdnU3aioarFsdGaE3X+JrK+oMGiw08deIiIyeAeXVkQZOWLbi6SkORHSRJb1p3dDr
         jgPxkYRdGb6B5OvJHA7HV7TPM5DiciIPKAUoG0dr1hx3LfRAs7ZyslpT0buRQQRkUn5e
         OLctdS0KvBHXbhNVv3NG74BEZ+HftDSqtPkB+JhWG/56xeOTiKlJqW50sOstCqqOqMos
         cZKfq02U6vyRINuBwxANrC621kkx6V6jXumyLuZskLPen2rbsOCziVdyVSRs591haCby
         4t0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OEwefO5s7q5tH8TqEcawfPCkw0BmTmIeA1fwlofl6+E=;
        b=Oo/iTp/Pe47A6LIgJvbGoimQvxOIJ47UtvmbbcjmyyaifKmb6hFzApv6qsB8SsFrNA
         hsGGqFWly0ci/cKWnYjd2a+yf9lzo4ehFs/ie1tUMdzpUjHRPwOyJNKN5f5Rq16SZUgW
         Xt1Af5LgYWg+IZNtmJh0Zw7CEVv1YScUimSAnH1dp6aw45kgbNFGfSPby9tFCA8kH51U
         CSPzkrUhOoYTw+OySXBNKhYg8uK7CHuzzzbd9Wq5qZ9WhBrkCzGvbuRnlqTJ7346Sxzb
         pCr64ySrdrHdrmwg0t7jEkhrG9sINKegnOSv+dxpY8jEb2n6oXMLT6PYfIZWf/m0rpuA
         +CTw==
X-Gm-Message-State: AOAM533eg+R/URqH3XwTz3MyB5p3OAsAby9ppl/Cbbj4aRKNw+bEU+2R
        Auf3kRX+9CodBdWJJHB6x4EsU5kLrBtUsYUY
X-Google-Smtp-Source: ABdhPJxzcvsA9J78p039E9gaxjTRycu1+O26r/KZPd+kCOMtGAsEnxNg6N9CcEyvyOY3R0lUAHANeg==
X-Received: by 2002:a5d:58fb:: with SMTP id f27mr26949829wrd.119.1614099611881;
        Tue, 23 Feb 2021 09:00:11 -0800 (PST)
Received: from skynet.lan (170.red-88-1-105.dynamicip.rima-tde.net. [88.1.105.170])
        by smtp.gmail.com with ESMTPSA id u12sm3057190wmq.38.2021.02.23.09.00.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Feb 2021 09:00:11 -0800 (PST)
From:   =?UTF-8?q?=C3=81lvaro=20Fern=C3=A1ndez=20Rojas?= 
        <noltari@gmail.com>
To:     Matt Mackall <mpm@selenic.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Rob Herring <robh+dt@kernel.org>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Mark Brown <broonie@kernel.org>,
        =?UTF-8?q?=C3=81lvaro=20Fern=C3=A1ndez=20Rojas?= 
        <noltari@gmail.com>, Guenter Roeck <linux@roeck-us.net>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= 
        <nfraprado@protonmail.com>,
        Rikard Falkeborn <rikard.falkeborn@gmail.com>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        linux-crypto@vger.kernel.org, devicetree@vger.kernel.org,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/2] dt-bindings: rng: bcm2835: document reset support
Date:   Tue, 23 Feb 2021 18:00:05 +0100
Message-Id: <20210223170006.29558-2-noltari@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210223170006.29558-1-noltari@gmail.com>
References: <20210222194510.14004-1-noltari@gmail.com>
 <20210223170006.29558-1-noltari@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some devices may need to perform a reset before using the RNG, such as the
BCM6368.

Signed-off-by: Álvaro Fernández Rojas <noltari@gmail.com>
---
 v3: make resets required if brcm,bcm6368-rng.
 v2: document reset support.

 .../devicetree/bindings/rng/brcm,bcm2835.yaml   | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/Documentation/devicetree/bindings/rng/brcm,bcm2835.yaml b/Documentation/devicetree/bindings/rng/brcm,bcm2835.yaml
index c147900f9041..11c23e1f6988 100644
--- a/Documentation/devicetree/bindings/rng/brcm,bcm2835.yaml
+++ b/Documentation/devicetree/bindings/rng/brcm,bcm2835.yaml
@@ -37,6 +37,21 @@ required:
 
 additionalProperties: false
 
+if:
+  properties:
+    compatible:
+      enum:
+        - brcm,bcm6368-rng
+then:
+  properties:
+    resets:
+      maxItems: 1
+  required:
+    - resets
+else:
+  properties:
+    resets: false
+
 examples:
   - |
     rng@7e104000 {
@@ -58,4 +73,6 @@ examples:
 
         clocks = <&periph_clk 18>;
         clock-names = "ipsec";
+
+        resets = <&periph_rst 4>;
     };
-- 
2.20.1

