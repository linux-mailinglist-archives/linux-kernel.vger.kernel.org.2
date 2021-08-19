Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4567E3F1721
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Aug 2021 12:12:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238156AbhHSKMq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Aug 2021 06:12:46 -0400
Received: from smtp-relay-canonical-1.canonical.com ([185.125.188.121]:43700
        "EHLO smtp-relay-canonical-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238049AbhHSKMn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Aug 2021 06:12:43 -0400
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com [209.85.218.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPS id BD08D411FE
        for <linux-kernel@vger.kernel.org>; Thu, 19 Aug 2021 10:12:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1629367926;
        bh=1q/zDNJ6stj36dAWcIJjYp9AynEo5sG0UMyf+ThhM+A=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=wVPEuqgFXcn4EDow6JF/qJHX4brvkeSCUtWVHJw+9W4oVlxVOfX3kgEMo/10WDiEe
         rhCM2ts0IrHo72VbXX5GyTVHlBv7BiCS4NRUT/RPdQ9juAbrx+vlnJ1X+QuFA8x9b2
         1lP6mbE34GsZajUe5hjVEGHU58o4/czkkkraCIxy3X0ZdsWOy5HaWZdsqxQhhtpH1Q
         CiqC617uWgTNVT2m/m6wlBDmbBRzZfakmeR/g9MbkDxpTwMHT7XSOmm2/noFnkHP1+
         91djeTdID9cx/9Pj4/E/gZ+iuH9ZmRgbwVGERJKrCyv8mR2QE2Xs3z11QgGfh2nuBj
         dQb+OZF39vsYA==
Received: by mail-ej1-f70.google.com with SMTP id j10-20020a17090686cab02905b86933b59dso2055730ejy.18
        for <linux-kernel@vger.kernel.org>; Thu, 19 Aug 2021 03:12:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1q/zDNJ6stj36dAWcIJjYp9AynEo5sG0UMyf+ThhM+A=;
        b=PoCzlgcxjLVjuStasD3w2WzF9wZWZB1+oY6Aad4ksPh28LvSEokh+9e7+Td1ortnVa
         AZJYU78tKrLFG8vJjdRt8HDd0se5Zvd1SkzBx3A+sMy0+7rp0hXnybTxkM8g+mqPsiwL
         UFXhJaDAUJ0FXfMM099I8v7R7jJTm9DJCqmpfatsMG2MuTm3cqoETBTpDrZakT9pEymQ
         qyENGe4xD/mdjg6qrnqWhceYjlbisY0ImrfMiXaG7AOM0HGwz92/QtJRzjzywoeeweou
         RwjrOemmGodrMKwAE5eTFodSGPzFjhK8Pe7VHjBY1A4HdgzCdB/28FAxwDutNffw0eWX
         QATg==
X-Gm-Message-State: AOAM530e9bW8DcdGSALt1eECl4M/VcYY9YnCTK6YPRBhEcUCCVHvWgUy
        tTLxBDWwi7jJDym/8usorpsR650sqgwL+V7x/SYUlHbAP3m8qfeYHWwSEMiPbOgoFeBf2+rG0/Y
        5CNNvjlwAKlZxTUZVX53iKfMp6vZtm9N7B/AWQRDiFw==
X-Received: by 2002:aa7:d896:: with SMTP id u22mr15367859edq.290.1629367926294;
        Thu, 19 Aug 2021 03:12:06 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxI9zNnopbbqxOQWW/ned2EnZ+8UkkZ3IeaEL4Nm49q++mydI6Q/iekQrW4vzQouXJ2dmMtNg==
X-Received: by 2002:aa7:d896:: with SMTP id u22mr15367839edq.290.1629367926151;
        Thu, 19 Aug 2021 03:12:06 -0700 (PDT)
Received: from localhost.localdomain ([86.32.42.198])
        by smtp.gmail.com with ESMTPSA id bs13sm1031774ejb.98.2021.08.19.03.12.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Aug 2021 03:12:05 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Dillon Min <dillon.minfei@gmail.com>,
        Tzung-Bi Shih <tzungbi@google.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Subject: [PATCH 2/2] dt-bindings: sound: rt1015p: correct indentation
Date:   Thu, 19 Aug 2021 12:10:20 +0200
Message-Id: <20210819101020.26368-2-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210819101020.26368-1-krzysztof.kozlowski@canonical.com>
References: <20210819101020.26368-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use common enum instead of oneOf and correct indentation warning:
  realtek,rt1015p.yaml:18:7: [warning] wrong indentation: expected 4 but found 6 (indentation)

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 .../devicetree/bindings/sound/realtek,rt1015p.yaml          | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/realtek,rt1015p.yaml b/Documentation/devicetree/bindings/sound/realtek,rt1015p.yaml
index f31d3c4d0192..fdb7f295ef2d 100644
--- a/Documentation/devicetree/bindings/sound/realtek,rt1015p.yaml
+++ b/Documentation/devicetree/bindings/sound/realtek,rt1015p.yaml
@@ -15,9 +15,9 @@ description: |
 
 properties:
   compatible:
-      oneOf:
-        - const: realtek,rt1015p
-        - const: realtek,rt1019p
+    enum:
+      - realtek,rt1015p
+      - realtek,rt1019p
 
   sdb-gpios:
     description:
-- 
2.30.2

