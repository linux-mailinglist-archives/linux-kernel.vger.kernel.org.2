Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FCD534FC50
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 11:14:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234595AbhCaJOB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Mar 2021 05:14:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234543AbhCaJNe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Mar 2021 05:13:34 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58B6BC06175F
        for <linux-kernel@vger.kernel.org>; Wed, 31 Mar 2021 02:13:34 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id x21-20020a17090a5315b029012c4a622e4aso894647pjh.2
        for <linux-kernel@vger.kernel.org>; Wed, 31 Mar 2021 02:13:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Pz7Z5j8vF+y9QTZ6X6Ijd3UIKgXWavlXGezKvBp98zM=;
        b=QWSpZAyLCBFJZFXGbCObt6VVs2FSJdJUhL5c0D1d2UxZenJ89hmjkumKRnBZGN19EM
         7DneS120Kl+QHDfW4abWa/rWiYbW8sCPZyS/RgiZVWiYFD/gLqNtIKTc1F4nJ/CCSrRv
         UI06ShdtNRTRY/YXA1cFX28GfNbTyUvP9GCew=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Pz7Z5j8vF+y9QTZ6X6Ijd3UIKgXWavlXGezKvBp98zM=;
        b=Jum1JMhfHi761SQabJw6TJuq9r19MHbdnTXShoZ99YAUdPg12KeSVzlAoU833Ry9SQ
         zIHCQrQCvBrJvlJYk1NWbyR/2UnpBmNyK4r9HerQbfTVfhH8J1bfLxcpFPFxbGhfplJI
         J2a8aCrXX4Ej9pNei86dDXvq3atmsZ3CEeEjHM0OsWQzeDkk/o+HgQQ04HgsknlFU5Xs
         lsXnZUdklPXkR82+Q7vhfHgkPxKBD/IqyU3AvDcpOdrwPMazhpZngAtBtlw6GyyTfLKe
         gagYksQX+lCFlZCca7RvW7YwebHSmIyU/PHi/PL5QMFnDQZwvZr8njxl+46hzdanpmNj
         tshg==
X-Gm-Message-State: AOAM533PUywcbjUxgQ+5RgS+dc6gUASc0aD6G82gs/OTmzu9RixX7m5U
        sJkMPMNiy5ucs0+/WtKRUsqslQ==
X-Google-Smtp-Source: ABdhPJxGkCKZMCI4i/E1qaOe7U/FYbvm4Fs3hB9UQ3N4UPc+0s6R0VJ/mkrP9+mKkF1E+o67YCeLxw==
X-Received: by 2002:a17:90a:6c22:: with SMTP id x31mr2583500pjj.213.1617182013867;
        Wed, 31 Mar 2021 02:13:33 -0700 (PDT)
Received: from hsinyi-z840.tpe.corp.google.com ([2401:fa00:1:10:85fc:9f25:6293:28f1])
        by smtp.gmail.com with ESMTPSA id s7sm1484723pjr.18.2021.03.31.02.13.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Mar 2021 02:13:33 -0700 (PDT)
From:   Hsin-Yi Wang <hsinyi@chromium.org>
To:     Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Sean Wang <sean.wang@mediatek.com>,
        Ben Ho <Ben.Ho@mediatek.com>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>
Subject: [PATCH 2/4] dt-bindings: arm64: dts: mediatek: Add mt8183-kukui-kodama
Date:   Wed, 31 Mar 2021 17:13:25 +0800
Message-Id: <20210331091327.1198529-2-hsinyi@chromium.org>
X-Mailer: git-send-email 2.31.0.291.g576ba9dcdaf-goog
In-Reply-To: <20210331091327.1198529-1-hsinyi@chromium.org>
References: <20210331091327.1198529-1-hsinyi@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kodama is also known as Lenovo 10e Chromebook Tablet.

Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
---
 Documentation/devicetree/bindings/arm/mediatek.yaml | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/mediatek.yaml b/Documentation/devicetree/bindings/arm/mediatek.yaml
index 9774f44b51d9..c6ecb510d372 100644
--- a/Documentation/devicetree/bindings/arm/mediatek.yaml
+++ b/Documentation/devicetree/bindings/arm/mediatek.yaml
@@ -144,6 +144,15 @@ properties:
           - const: google,kakadu-rev2
           - const: google,kakadu
           - const: mediatek,mt8183
+      - description: Google Kodama (Lenovo 10e Chromebook Tablet)
+        items:
+          - enum:
+              - google,kodama-sku16
+              - google,kodama-sku272
+              - google,kodama-sku288
+              - google,kodama-sku32
+          - const: google,kodama
+          - const: mediatek,mt8183
 
 
 additionalProperties: true
-- 
2.31.0.291.g576ba9dcdaf-goog

