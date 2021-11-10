Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A23E44BBC1
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Nov 2021 07:31:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230409AbhKJGef (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Nov 2021 01:34:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230328AbhKJGeT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Nov 2021 01:34:19 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCF63C061764
        for <linux-kernel@vger.kernel.org>; Tue,  9 Nov 2021 22:31:30 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id iq11so721563pjb.3
        for <linux-kernel@vger.kernel.org>; Tue, 09 Nov 2021 22:31:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7VRwqE4mljaTBbEn84HnhMeSkIM9YCg3MxPTKXVa2zs=;
        b=MxHJDM8GyITaPlwz3hRFlgPApmlsT9vH5iVCcFw+8JIfbbL47ai6x1PvNOZC6AQgeR
         ftRLF7CGq4Ssj11u1VdXS+5MXQVdO56WEXUWli/maqXwqKqqnpk1UEu9KpzdpYTwwB4g
         hFY72GezTFtdjkz6tOUTG2GjyEMthOe5d+lAk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7VRwqE4mljaTBbEn84HnhMeSkIM9YCg3MxPTKXVa2zs=;
        b=M12yWiG9pT1VD4AqyjftfTZW+qxP7PRF/bHlCJt1AhM8Og1ibxTzgr219R9l4JyjKv
         uU5a8pmMzGVBdjWparz1ORvUAWi2ykGqL6qqIZT2ZIgzjTrx1NAmwEQO0CMIdxa0xHE0
         p7yI6SUUHpasnRNNC1loyadBML2tE4/RR4TMPFF+ZqiN8usoM9/ypyBzk/8vCA8ierUF
         VmHELqF+h0OziQrqlz6wagABMzlvyErAlVBQg4M1BssyTypwebupKoUuJ8sQXgmWabAR
         PEj3/0o8dMQF24d64hoUnxQrvI68gUP7NpcCqON/zL971F2Gzg+y7YXOFu6xA/aHuxlu
         cRVA==
X-Gm-Message-State: AOAM532XESdV5BOTZT9LrtXxpNKf+IkChFocXQMxXI6NYmgacWgfAsV9
        WC/Ohx8A2oNjepMcQ9fombsDLw==
X-Google-Smtp-Source: ABdhPJzq7nkp3CFD6DNs6EgqOZnXl05X7pcntes1Voih0ZR8rTI5/EB7QCsokvu16RpAIQDlHFT1Vg==
X-Received: by 2002:a17:90a:4212:: with SMTP id o18mr14163484pjg.154.1636525890398;
        Tue, 09 Nov 2021 22:31:30 -0800 (PST)
Received: from hsinyi-z840.tpe.corp.google.com ([2401:fa00:1:10:6886:f712:1a79:e3d9])
        by smtp.gmail.com with ESMTPSA id w1sm15623959pgb.50.2021.11.09.22.31.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Nov 2021 22:31:30 -0800 (PST)
From:   Hsin-Yi Wang <hsinyi@chromium.org>
To:     Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 6/7] dt-bindings: arm64: dts: mediatek: Add more SKUs for mt8183 fennel board
Date:   Wed, 10 Nov 2021 14:31:17 +0800
Message-Id: <20211110063118.3412564-6-hsinyi@chromium.org>
X-Mailer: git-send-email 2.34.0.rc0.344.g81b53c2807-goog
In-Reply-To: <20211110063118.3412564-1-hsinyi@chromium.org>
References: <20211110063118.3412564-1-hsinyi@chromium.org>
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

