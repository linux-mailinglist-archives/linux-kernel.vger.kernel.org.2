Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1517336DD48
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Apr 2021 18:42:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241164AbhD1QnW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Apr 2021 12:43:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241134AbhD1QnQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Apr 2021 12:43:16 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A156C06138C
        for <linux-kernel@vger.kernel.org>; Wed, 28 Apr 2021 09:42:30 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id x5so13484747wrv.13
        for <linux-kernel@vger.kernel.org>; Wed, 28 Apr 2021 09:42:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4iBEXnR1nc8SuK9x0RI0HjJCZgNJ4KQ0iJTuPJeZHB8=;
        b=Rq3J38Zqc6gI2+zGNcT7zWRQ3/6wkLaHH1GGf4GEoRqnzFASs7CFrP1Wl6jtxARL9i
         3aj23YNgSI3EhVwxyms52vAUEQpyh4ze9anBmJ+Q5V3CahksOV0j6GN/AcTVzP2RqaYI
         wyi9JoFEQ/WNvw4tR2ifYYBpuQxd//Xs5iNbxGIhZZZcJPib+HdGBlmtbLOVkiPMt7Bo
         /JEv+93o3OsoP4IdJqHymAfa2Cb9ani1n1MKEPZKL2CwJrmlWcuGZpZz/p01H0MspOya
         ULpfKTHN06cenKhTc8jYQqtDRVZcQxCkEJ1zxYVrHfNk6WyV9iBi38nwEggGi3unmtjn
         mhIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4iBEXnR1nc8SuK9x0RI0HjJCZgNJ4KQ0iJTuPJeZHB8=;
        b=qVyr75KyK6pxqoihp5dzZkCUaURDRQmO/0KS/ghziaC0OUnRevYRYht3lZ+mNQAuBJ
         LHQk98ThU9WOhzrAVQdQkh54mqsCCnr6k8u12lxtYMwNjOmdGuN7z6fQZJqDbFchPSjF
         zb+kTQYvHSXFVyhvxP5CavFLD0dtRWUgQJeuY4yAJDmhy6Oi4W9a/s9cS6b3q3VcTzMI
         uqsJprAi0s1kQ9JFIEdgPgNH61bppdfCPaKlpkFwPzdR/ilGQ+Q/rxqH/g1nQ3Jy6kPS
         30NewKo4A1yTpslgHdlPgrEHT1mlCH2pOvJjCiAV39Rs7Ibnk3mYiNW/m7WnHe45QTdp
         YU7A==
X-Gm-Message-State: AOAM5317dIT2MWXOShIiWlhCqxBNyJ+DVqG1XFV3taYx8GTqIgSP+ORC
        jQ30Be9OLz4UME1EDmO9bVCu9g==
X-Google-Smtp-Source: ABdhPJyWEwmUF9T2p2cho3eW1dDUOfY2IOjaly14N2nUuESPRrAaxGB0L8uVg8DlnkNWW8vpNPDdaQ==
X-Received: by 2002:a5d:6648:: with SMTP id f8mr16158946wrw.396.1619628149075;
        Wed, 28 Apr 2021 09:42:29 -0700 (PDT)
Received: from groot.home ([2a01:cb19:826e:8e00:5864:ddd1:d623:f912])
        by smtp.gmail.com with ESMTPSA id o10sm351299wrx.35.2021.04.28.09.42.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Apr 2021 09:42:28 -0700 (PDT)
From:   Mattijs Korpershoek <mkorpershoek@baylibre.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     fparent@baylibre.com,
        Mattijs Korpershoek <mkorpershoek@baylibre.com>,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 4/7] dt-bindings: input: mtk-pmic-keys: add MT6358 binding definition
Date:   Wed, 28 Apr 2021 18:42:16 +0200
Message-Id: <20210428164219.1115537-5-mkorpershoek@baylibre.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210428164219.1115537-1-mkorpershoek@baylibre.com>
References: <20210428164219.1115537-1-mkorpershoek@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the binding documentation of the mtk-pmic-keys for the MT6358 PMICs.

MT6358 is a little different since it used separate IRQs for the
release key (_r) event

Signed-off-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
---
 Documentation/devicetree/bindings/input/mtk-pmic-keys.txt | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/input/mtk-pmic-keys.txt b/Documentation/devicetree/bindings/input/mtk-pmic-keys.txt
index 535d92885372..9d00f2a8e13a 100644
--- a/Documentation/devicetree/bindings/input/mtk-pmic-keys.txt
+++ b/Documentation/devicetree/bindings/input/mtk-pmic-keys.txt
@@ -9,7 +9,10 @@ For MT6397/MT6323 MFD bindings see:
 Documentation/devicetree/bindings/mfd/mt6397.txt
 
 Required properties:
-- compatible: "mediatek,mt6397-keys" or "mediatek,mt6323-keys"
+- compatible: Should be one of:
+	- "mediatek,mt6397-keys"
+	- "mediatek,mt6323-keys"
+	- "mediatek,mt6358-keys"
 - linux,keycodes: See Documentation/devicetree/bindings/input/input.yaml
 
 Optional Properties:
-- 
2.27.0

