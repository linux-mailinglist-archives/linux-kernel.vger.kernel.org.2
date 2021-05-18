Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCEF9387767
	for <lists+linux-kernel@lfdr.de>; Tue, 18 May 2021 13:23:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232127AbhERLYh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 May 2021 07:24:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233671AbhERLYU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 May 2021 07:24:20 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72C6AC061761
        for <linux-kernel@vger.kernel.org>; Tue, 18 May 2021 04:23:01 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id s5-20020a7bc0c50000b0290147d0c21c51so1257825wmh.4
        for <linux-kernel@vger.kernel.org>; Tue, 18 May 2021 04:23:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oaLFELdmsSuj6jGUpLjdC3C6Wd7IWhp+KmWoppj+Ots=;
        b=VKSM0kO2iOln9CQUfzNDIsaTFKxbenOaoUvS60FBMhhB5nYExLkbpuY82iCC+ohbQX
         F7cHamO4ub1tlhjaLWntbt8A677LWvQxZWIWTWuKA2x6L9yFn+IFCd43RLTbl4mW3RhI
         whmFtFv3pH0pvFuKOKFL8HveAo1pQPXXjIB1/x54gENVkwDGlwCPT4H94WN3/B4dm0V0
         U8iT7kCQ+m1pxzgvAYMYqIVbvl/I5vB22MaaAJnGZdczQh01NYNY6deiijmc6zJNcgcb
         4fx66hXYMQzIfDyZ9mVjCtIh7T/bpJkidlDjcaiFvK1kVRsDxzK59s29Y7sfTYt7fpcu
         AObw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oaLFELdmsSuj6jGUpLjdC3C6Wd7IWhp+KmWoppj+Ots=;
        b=QlxNzixD1aWTuaewmj5llcSt14AMEzGz2x2X5wFLF1Tboq4ciRgSFeW7L/km5yhX6Y
         ocLimHVXsZTec+KC7ftNJmwvET/o9f5QsbyN3IJHS10JJNI/OLwdss1Owgc+e/Wh7nAy
         WtiAdWjhO9Rqny+MQvdh2AVE2jkA5ukbZe8CJBybhJeZfaoiUjCIWsOVJex0acK5JRyi
         bUHL0CiXCQoCSEyRoP2v9g+ApM+lQL3xeCgnhXuNeyAnLiTyYEneJlhLvvxPbu5RtjW0
         1DnncbpFa2enrzGU7T2aEDMqm0+4gQAbhtc0Lu2qiAQQI5Yl48kGiuOyq7JkQedAg6i+
         pdmA==
X-Gm-Message-State: AOAM5338PkdR0+0s8XNUjEd5k6Wu8+6q0r+5sO8hmaOYk/if6x7SyPiI
        fd1N82NH88qgrg0s2Tn5CII7Yg==
X-Google-Smtp-Source: ABdhPJzl2Utkm0LkpJMg42RFFaMV0xPUsR/PlhE1Hxe69g5OBNLG/XNR5HueBpJgHnFR0O56vHEiXg==
X-Received: by 2002:a05:600c:4a23:: with SMTP id c35mr4408392wmp.130.1621336980047;
        Tue, 18 May 2021 04:23:00 -0700 (PDT)
Received: from localhost.localdomain ([88.160.162.107])
        by smtp.gmail.com with ESMTPSA id y20sm2881337wmi.0.2021.05.18.04.22.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 May 2021 04:22:59 -0700 (PDT)
From:   Fabien Parent <fparent@baylibre.com>
To:     Matt Mackall <mpm@selenic.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Sean Wang <sean.wang@mediatek.com>
Cc:     mkorpershoek@baylibre.com, Fabien Parent <fparent@baylibre.com>,
        linux-crypto@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] dt-bindings: rng: mediatek: add mt8365 to mtk rng binding
Date:   Tue, 18 May 2021 13:22:50 +0200
Message-Id: <20210518112250.2146819-2-fparent@baylibre.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210518112250.2146819-1-fparent@baylibre.com>
References: <20210518112250.2146819-1-fparent@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add RNG binding for MT8365 SoC.

Signed-off-by: Fabien Parent <fparent@baylibre.com>
---
 Documentation/devicetree/bindings/rng/mtk-rng.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/rng/mtk-rng.yaml b/Documentation/devicetree/bindings/rng/mtk-rng.yaml
index d9731f0ae47d..ccff10b27f73 100644
--- a/Documentation/devicetree/bindings/rng/mtk-rng.yaml
+++ b/Documentation/devicetree/bindings/rng/mtk-rng.yaml
@@ -20,6 +20,9 @@ properties:
       - items:
           - const: mediatek,mt7629-rng
           - const: mediatek,mt7623-rng
+      - items:
+          - const: mediatek,mt8365-rng
+          - const: mediatek,mt7623-rng
       - items:
           - const: mediatek,mt8516-rng
           - const: mediatek,mt7623-rng
-- 
2.31.1

