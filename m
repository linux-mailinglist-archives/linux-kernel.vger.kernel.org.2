Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07A3044BBBE
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Nov 2021 07:31:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230462AbhKJGec (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Nov 2021 01:34:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230367AbhKJGeR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Nov 2021 01:34:17 -0500
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56030C061205
        for <linux-kernel@vger.kernel.org>; Tue,  9 Nov 2021 22:31:29 -0800 (PST)
Received: by mail-pg1-x532.google.com with SMTP id r28so1404290pga.0
        for <linux-kernel@vger.kernel.org>; Tue, 09 Nov 2021 22:31:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=86/08aG+p6XRAME724Hp/6Odjw/P8UK3rjLz7Rko9pk=;
        b=XHheJmSpYLVQSr3R4rxKaf5taYQBD0bYs1rjkecMNt0qVAN0Ew+VJCgsfYBLeFjOT1
         zAfcGf9/NzWjxww35M5fSyXsEcQnYuxh+qgmuOhSUYBSrnZ7LPT9GLQXZW1g6Z5xjQa7
         zsc0h9a1O+7zMrHQQwlL29Hd+5YPCxouHsz+8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=86/08aG+p6XRAME724Hp/6Odjw/P8UK3rjLz7Rko9pk=;
        b=LFVFlZxFp4+nDkmSNLSN1EZvHh/cY0lG6J1dlx/3JWUfgS1xIZOCp7ppEZAdummZdG
         zCPGPeDSy69mTDUjIgnjlU6rjqxe7naIc1B+6EU5pzFE3Sy3ldEUwX5JNKXBib1sEKNM
         trzWlA5uYLdwj2r5fFDf/x0bPqUOl6EJKYPgzhPuKcosmJSltJY02ZGBy4SKg/uWREXV
         QC3z8J4Vmg6/bZVBhau0yT/CTOJoctn/bPzIfKntVG/O8q8nfZxWo3E0JqmgrcgPVpD/
         KHJR17T+km/E+fE5aVF7iBU9r3K6kKT55JiFdL6I4BG05NEaC7bWmSMBYVRWFvEGgWlF
         K+5w==
X-Gm-Message-State: AOAM531OGIC8wDg3DKHRG5wnIlsK7xIi8zK1AJJMuW3ga+FrFUi3B3Gq
        roU9izYdCYYb0HoCioRUDfE8FQ==
X-Google-Smtp-Source: ABdhPJyGjFC2Sh8vaHJGhq+5Jw4jMiG6OxOmugcVKfn7mui/GLCO5k7lMCWwoeNTqLpMdAptVvaqRQ==
X-Received: by 2002:a63:dc0d:: with SMTP id s13mr10597486pgg.254.1636525888877;
        Tue, 09 Nov 2021 22:31:28 -0800 (PST)
Received: from hsinyi-z840.tpe.corp.google.com ([2401:fa00:1:10:6886:f712:1a79:e3d9])
        by smtp.gmail.com with ESMTPSA id w1sm15623959pgb.50.2021.11.09.22.31.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Nov 2021 22:31:28 -0800 (PST)
From:   Hsin-Yi Wang <hsinyi@chromium.org>
To:     Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 5/7] dt-bindings: arm64: dts: mediatek: Add mt8183-kukui-jacuzzi-cozmo
Date:   Wed, 10 Nov 2021 14:31:16 +0800
Message-Id: <20211110063118.3412564-5-hsinyi@chromium.org>
X-Mailer: git-send-email 2.34.0.rc0.344.g81b53c2807-goog
In-Reply-To: <20211110063118.3412564-1-hsinyi@chromium.org>
References: <20211110063118.3412564-1-hsinyi@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cozmo is known as Acer Chromebook 314 (CB314-2H/CB314-2HT) Chromebook.

Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
---
 Documentation/devicetree/bindings/arm/mediatek.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/mediatek.yaml b/Documentation/devicetree/bindings/arm/mediatek.yaml
index 0fa55497b96fd2..7cf0c76cd31006 100644
--- a/Documentation/devicetree/bindings/arm/mediatek.yaml
+++ b/Documentation/devicetree/bindings/arm/mediatek.yaml
@@ -134,6 +134,10 @@ properties:
               - google,krane-sku176
           - const: google,krane
           - const: mediatek,mt8183
+      - description: Google Cozmo (Acer Chromebook 314)
+        items:
+          - const: google,cozmo
+          - const: mediatek,mt8183
       - description: Google Damu (ASUS Chromebook Flip CM3)
         items:
           - const: google,damu
-- 
2.34.0.rc0.344.g81b53c2807-goog

