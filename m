Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5C64447B0A
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Nov 2021 08:31:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237888AbhKHHaf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Nov 2021 02:30:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237815AbhKHHaP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Nov 2021 02:30:15 -0500
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB180C061570
        for <linux-kernel@vger.kernel.org>; Sun,  7 Nov 2021 23:27:31 -0800 (PST)
Received: by mail-pg1-x533.google.com with SMTP id q126so10443305pgq.13
        for <linux-kernel@vger.kernel.org>; Sun, 07 Nov 2021 23:27:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7VRwqE4mljaTBbEn84HnhMeSkIM9YCg3MxPTKXVa2zs=;
        b=SEil9SApMgo3zx21+CayURwOiP6vwjadUGGhRy1wur3B06MtS4rni4k3GLVSKHMx3P
         LDI2CF2bB8tznlGhuROYtBbjsha6Mldlbn++gD2gYYirfP0L4ZaD4DbQJkJPHh8iXnoa
         N2H+pcLHqvwF1eI8yKjpo3A+7rBi9TWaCvHQk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7VRwqE4mljaTBbEn84HnhMeSkIM9YCg3MxPTKXVa2zs=;
        b=bpljla6nD/K9LsH0jtloo1mu9iEbTuyQqyrtbaXQZUtQ/x3YUMVJzn2nZXB92FVdnP
         NGro02CPUpKvRe0ce/SoyXGHeCkHiTMmYzXXCPLjRP3C6iPgsHmK8MrL+J4RH/podbNe
         Ht3MZ37G5PSD/2fyMu30Mi2CaP8klQJvmuoKCFNacSUCXv1dCO3wSXzP4zA8M2AHXxyx
         Hc7FcHQsq5ADJAgonedam25yCpGBGR4lpKWNjxx2s3f/Ujh5RgRu5pDNxRk65VOiDtWt
         qqyU9uVHks0JQ978waRzx2mUm7w4HrFNYJZ6iGn6N48ObuD34Gom32fjD+JE2CXfpsmR
         pFkw==
X-Gm-Message-State: AOAM530L12K66PPO7trx6pVWqAKhYXh/7JvGAAlBp5W28LvvYzgZdHaT
        nhUaKzYcyorTZywqKvxpCtCpTQ==
X-Google-Smtp-Source: ABdhPJz0KGRio6+Vfg/0zl1gPXCnZf6PlR0Ubx5ZdyQMG7go+EpTemLTEnTrnxJ8YifJIDmL4Zp3kA==
X-Received: by 2002:a63:7d46:: with SMTP id m6mr60136373pgn.409.1636356446512;
        Sun, 07 Nov 2021 23:27:26 -0800 (PST)
Received: from hsinyi-z840.tpe.corp.google.com ([2401:fa00:1:10:5f03:6a9b:24e8:3a2e])
        by smtp.gmail.com with ESMTPSA id e8sm11684972pgn.46.2021.11.07.23.27.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Nov 2021 23:27:26 -0800 (PST)
From:   Hsin-Yi Wang <hsinyi@chromium.org>
To:     Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 6/7] dt-bindings: arm64: dts: mediatek: Add more SKUs for mt8183 fennel board
Date:   Mon,  8 Nov 2021 15:27:10 +0800
Message-Id: <20211108072711.1628566-6-hsinyi@chromium.org>
X-Mailer: git-send-email 2.34.0.rc0.344.g81b53c2807-goog
In-Reply-To: <20211108072711.1628566-1-hsinyi@chromium.org>
References: <20211108072711.1628566-1-hsinyi@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add sku2 and sku7 which uses different audio codec than other fennel boards.

Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
---
 Documentation/devicetree/bindings/arm/mediatek.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/mediatek.yaml b/Documentation/devicetree/bindings/arm/mediatek.yaml
index 7cf0c76cd31006..99e7f8e294cd03 100644
--- a/Documentation/devicetree/bindings/arm/mediatek.yaml
+++ b/Documentation/devicetree/bindings/arm/mediatek.yaml
@@ -147,7 +147,9 @@ properties:
           - enum:
               - google,fennel-sku0
               - google,fennel-sku1
+              - google,fennel-sku2
               - google,fennel-sku6
+              - google,fennel-sku7
           - const: google,fennel
           - const: mediatek,mt8183
       - description: Google Juniper (Acer Chromebook Spin 311) / Kenzo (Acer Chromebook 311)
-- 
2.34.0.rc0.344.g81b53c2807-goog

