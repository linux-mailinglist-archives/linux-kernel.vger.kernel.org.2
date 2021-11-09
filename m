Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB7E444A65C
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Nov 2021 06:34:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240862AbhKIFgt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Nov 2021 00:36:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242938AbhKIFgd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Nov 2021 00:36:33 -0500
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03B5CC0613F5
        for <linux-kernel@vger.kernel.org>; Mon,  8 Nov 2021 21:33:48 -0800 (PST)
Received: by mail-pg1-x52f.google.com with SMTP id p8so16114254pgh.11
        for <linux-kernel@vger.kernel.org>; Mon, 08 Nov 2021 21:33:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aGs0imFfCIIi9peSh9xMQNmQGGyfoBu+v5r5spN7t4c=;
        b=lGYZsguWD/fWmd5YVWbJ3Zxt0D/hj/dfFX0T7usV/K5o2FILCYKmQ88Mn5/Jo8TyML
         dWdCl+lyiWNBQPgXnNDvl8q/9Ov0uThCcB7f6MtsHQa9sGukSu+nIfw2LnJU+86tuihK
         W+aIQXWYJne1d1qrMnmH7ECSv5ceb1hlXITHE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aGs0imFfCIIi9peSh9xMQNmQGGyfoBu+v5r5spN7t4c=;
        b=RhHzBszyvnDkoQ37vlxIERhnf5ylNJyo1asIJvE/UKriTQY52liA3sK8+6QR1FfnFx
         BITSysqgl40INuT+pd+3U/0j44xD3E+FG8M5Bgo8+gofqdpwacKepZ8A3Zkyth3vcmss
         QZG9Y8RJnN3GO29DHtFtgZgMI6IOaMqsG9tlZYHYh7WmMigVPJp5YPKRnR7kbMr955Hc
         Xe+W3tbd6wCMF1WfPyVNdgVB2ajZOcyvV0V9DmiHutijswzBj0WYvHS3uwmTySHnfp8n
         ipR6gUuuUK9GZfFBGC5yHOrb57VOrKLLzYeGTu8G9LjaorwMrzmU8jlmXvj+VfGrwojM
         UlNg==
X-Gm-Message-State: AOAM531C52nOMxLpoqNo0h/JgaCB4ZHE2psOdjLVyEXwCjGWGYOWti88
        YdEmELqz7XADOVp0tcIcZ/KUqA==
X-Google-Smtp-Source: ABdhPJx7+9wnj4bEO+9tMDgaq7DvX6hC009rYk+EmfpDn1fmzbk4HRcpfqzml/7z5oKx+zl+3YrB+Q==
X-Received: by 2002:a05:6a00:174e:b0:47b:d4d6:3b9e with SMTP id j14-20020a056a00174e00b0047bd4d63b9emr5136764pfc.21.1636436027528;
        Mon, 08 Nov 2021 21:33:47 -0800 (PST)
Received: from hsinyi-z840.tpe.corp.google.com ([2401:fa00:1:10:cc3e:b71b:e327:fb32])
        by smtp.gmail.com with ESMTPSA id w5sm13741479pgp.79.2021.11.08.21.33.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Nov 2021 21:33:47 -0800 (PST)
From:   Hsin-Yi Wang <hsinyi@chromium.org>
To:     Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 7/7] dt-bindings: arm64: dts: mediatek: Add sku22 for mt8183 kakadu board
Date:   Tue,  9 Nov 2021 13:33:34 +0800
Message-Id: <20211109053334.1840273-7-hsinyi@chromium.org>
X-Mailer: git-send-email 2.34.0.rc0.344.g81b53c2807-goog
In-Reply-To: <20211109053334.1840273-1-hsinyi@chromium.org>
References: <20211109053334.1840273-1-hsinyi@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add sku22 which uses different audio codec than previous kakadu board.

Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
---
v2: fix compatible items matching
---
 Documentation/devicetree/bindings/arm/mediatek.yaml | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/mediatek.yaml b/Documentation/devicetree/bindings/arm/mediatek.yaml
index 99e7f8e294cd03..d08f0fcbbe12ae 100644
--- a/Documentation/devicetree/bindings/arm/mediatek.yaml
+++ b/Documentation/devicetree/bindings/arm/mediatek.yaml
@@ -161,8 +161,13 @@ properties:
           - const: mediatek,mt8183
       - description: Google Kakadu (ASUS Chromebook Detachable CM3)
         items:
-          - const: google,kakadu-rev3
-          - const: google,kakadu-rev2
+          - oneOf:
+              - items:
+                  - const: google,kakadu-rev3-sku22
+                  - const: google,kakadu-rev2-sku22
+              - items:
+                  - const: google,kakadu-rev3
+                  - const: google,kakadu-rev2
           - const: google,kakadu
           - const: mediatek,mt8183
       - description: Google Kappa (HP Chromebook 11a)
-- 
2.34.0.rc0.344.g81b53c2807-goog

