Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79B0134E62E
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 13:14:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231915AbhC3LOA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 07:14:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231812AbhC3LNj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 07:13:39 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB784C061762
        for <linux-kernel@vger.kernel.org>; Tue, 30 Mar 2021 04:13:38 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id h13so17712758eds.5
        for <linux-kernel@vger.kernel.org>; Tue, 30 Mar 2021 04:13:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=K+Zp6h/Roq/8W6vTjgUVZI6yb4LGecaGfb7HQEla4/A=;
        b=vF9uYVWrLLWCZCZdzAnJ5QC63JjsfeDqXJhkcuh7NKmcI/nWbHUCTiEj55SMGcEqXr
         0b7yorVTxpYE5s5Gh4wcvKr7fBuHoyA/IyU35YS5fKjo/O/AzAW0WuSqowDB5N8ykHU1
         D4mekCDkQjwzUCFihccNzpggQNoYTGooRnW3owi+C7e4IOPeBPnxS88h0VrYSsqir/EW
         BrXq8eSrAGXDiX3MAgl7+HLLzsfJ+R0zs3KF26sYgi4ANS6PXV+izVS3FFBX8OYHnvMZ
         q3ayJR+VPO58i8XkdDxCqlrjGJkcLmsJA7MwjXNQkn8ZtMeSXYDtWwg+6GxBO3x33qZG
         1m1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=K+Zp6h/Roq/8W6vTjgUVZI6yb4LGecaGfb7HQEla4/A=;
        b=G6SCAOxjdB3EihRiLg4Uf0eJpfRT3TfoEW9p7ZkSVTN/1nE5ZsXLb3V4wvFww1Nmg+
         +TDIAwLmU1JSUjj0WH3+S1mBjLl6JnQwNpRHahc3DEGn9pplL4ixduYKsglH3bPn4KiP
         PDDsb5WFNRy28tnpT+UG9d9z1/i2+cp13LhSQs1htRmLGf+0M5qQmufOnyP9zrnkIWN1
         RH79peYsAUefcXBSFE1EFytR7MyDzVu+mWlcVTNbcWrdhikphhrzGCSeByGXFSoTW6V/
         2PWntWQrZW9jhLStJzaxK3U7VdgAriTjxnvuquh68kaEqBDqvNN/6VN+6OCA9+CCXdZ3
         /ttg==
X-Gm-Message-State: AOAM533Z1caUZmNCH2fzypHAsNGn+OF1TQvkUx15WF2eg8H7khSDwkyP
        jkMEM6PAbn3NUdlKryqFgvVRIw==
X-Google-Smtp-Source: ABdhPJwWg4aA3sk8cq6+kkXcgqbN/+7yXiHZzQ2LClytX2Q773nJJ4PBO1XFSNLK/mlx8q2Frp7VVA==
X-Received: by 2002:aa7:dc4e:: with SMTP id g14mr33443658edu.114.1617102817633;
        Tue, 30 Mar 2021 04:13:37 -0700 (PDT)
Received: from srini-hackbox.lan (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.gmail.com with ESMTPSA id r19sm10961308edp.52.2021.03.30.04.13.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Mar 2021 04:13:37 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, Ryan Wu <Yz.Wu@mediatek.com>,
        Rob Herring <robh@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 01/10] dt-bindings: nvmem: mediatek: add support for MediaTek mt8192 SoC
Date:   Tue, 30 Mar 2021 12:12:32 +0100
Message-Id: <20210330111241.19401-2-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20210330111241.19401-1-srinivas.kandagatla@linaro.org>
References: <20210330111241.19401-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ryan Wu <Yz.Wu@mediatek.com>

This updates dt-binding documentation for MediaTek mt8192

Signed-off-by: Ryan Wu <Yz.Wu@mediatek.com>
Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 Documentation/devicetree/bindings/nvmem/mtk-efuse.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/nvmem/mtk-efuse.txt b/Documentation/devicetree/bindings/nvmem/mtk-efuse.txt
index ef93c3b95424..2f2895b1f06d 100644
--- a/Documentation/devicetree/bindings/nvmem/mtk-efuse.txt
+++ b/Documentation/devicetree/bindings/nvmem/mtk-efuse.txt
@@ -8,6 +8,7 @@ Required properties:
 	      "mediatek,mt7623-efuse", "mediatek,efuse": for MT7623
 	      "mediatek,mt8173-efuse" or "mediatek,efuse": for MT8173
 	      "mediatek,mt8516-efuse", "mediatek,efuse": for MT8516
+	      "mediatek,mt8192-efuse", "mediatek,efuse": for MT8192
 - reg: Should contain registers location and length
 
 = Data cells =
-- 
2.21.0

