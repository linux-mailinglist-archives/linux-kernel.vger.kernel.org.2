Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5651233B056
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Mar 2021 11:50:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229792AbhCOKtt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 06:49:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230186AbhCOKtf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 06:49:35 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD213C06175F
        for <linux-kernel@vger.kernel.org>; Mon, 15 Mar 2021 03:49:35 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id a188so6321835pfb.4
        for <linux-kernel@vger.kernel.org>; Mon, 15 Mar 2021 03:49:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DhxSzlXHtGlfEeBFDHzLfSiaE4UuFtHOZg5BLqDfKGQ=;
        b=h5wxAM7hyMHc11zgLkRJWZG0jSomLKZxjPxdytbduWCYJiOTQpUADHNXaMsuso0fcJ
         WAVBNfxAu4pcFVLC1R5Pe/5BeHisZfTyCv2D+M2DVpJfu3ua4Oi9EtxX794WalARDSsk
         /hwk/IGJ+Fm5X4CA3ENmF5itjQ9LiZBedBLco=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DhxSzlXHtGlfEeBFDHzLfSiaE4UuFtHOZg5BLqDfKGQ=;
        b=XCwN3N+6irrtOJ/EsbVNJQem67GLZVM0NYwGsv4I0MxWjDtPHnZvkX7aXP6j0odnvP
         dHe8ybaWbDutyFH2N34WxMhM47271ySlx7mUji5zhv2+XHy9knlR+3uhIO5sexnOjpZq
         PxF3UnUpy3BczffdVmVr11VDDgKCWoHYAnQnkgNjCT02tBQIrSAT1xkMGV+7O3aJPz0m
         dNH2XE5HbxphoMZxwxf8GWtWgjMYW/N7KMZbMo1Vkw+GNc5ORbWGaZfXgnNnFSXd2Ucq
         Q1CdNmYz0nzoxWrFqFjb0b+V4xH7aW9yrAIpLsMz8jP+MWBi2KVXHuJgZWIID0wXwJiJ
         i9JA==
X-Gm-Message-State: AOAM533KmCxS5CELI+JegXEdu2HXZia+YlBu4OiXkVoLJ3KKutnIWYWB
        en49+OwmSUtfWCmFb9ndXw7ZHzSl0n6vc+x0
X-Google-Smtp-Source: ABdhPJxiPBCV/qAXEBni+f8RFql0OIpLXQ7R8q8cJ/NXIl5z6NNYkjPBkxamX5CJqsbw88pK4mKGNA==
X-Received: by 2002:a05:6a00:16c7:b029:1b6:68a6:985a with SMTP id l7-20020a056a0016c7b02901b668a6985amr23948626pfc.44.1615805375030;
        Mon, 15 Mar 2021 03:49:35 -0700 (PDT)
Received: from hsinyi-z840.tpe.corp.google.com ([2401:fa00:1:10:89b7:339b:c097:5ebb])
        by smtp.gmail.com with ESMTPSA id s19sm12906201pfh.168.2021.03.15.03.49.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Mar 2021 03:49:34 -0700 (PDT)
From:   Hsin-Yi Wang <hsinyi@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Fabien Parent <fparent@baylibre.com>,
        Sean Wang <sean.wang@mediatek.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, Ben Ho <Ben.Ho@mediatek.com>
Subject: [PATCH 1/2] dt-bindings: arm64: dts: mediatek: Add mt8183-kukui-jacuzzi-damu
Date:   Mon, 15 Mar 2021 18:49:29 +0800
Message-Id: <20210315104930.1087142-1-hsinyi@chromium.org>
X-Mailer: git-send-email 2.31.0.rc2.261.g7f71774620-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

mt8183-kukui-jacuzzi-damu board also known as ASUS Chromebook Flip CM3,
using mediatek mt8183 SoC.

Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
---
 Documentation/devicetree/bindings/arm/mediatek.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/mediatek.yaml b/Documentation/devicetree/bindings/arm/mediatek.yaml
index 93b3bdf6eaeb..a86716cdd408 100644
--- a/Documentation/devicetree/bindings/arm/mediatek.yaml
+++ b/Documentation/devicetree/bindings/arm/mediatek.yaml
@@ -125,6 +125,10 @@ properties:
               - google,krane-sku176
           - const: google,krane
           - const: mediatek,mt8183
+      - description: Google Damu (ASUS Chromebook Flip CM3)
+        items:
+          - const: google,damu
+          - const: mediatek,mt8183
 
 additionalProperties: true
 
-- 
2.31.0.rc2.261.g7f71774620-goog

