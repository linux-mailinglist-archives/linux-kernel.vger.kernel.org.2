Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 207A33AFB44
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jun 2021 05:08:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231464AbhFVDKP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Jun 2021 23:10:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230188AbhFVDKO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jun 2021 23:10:14 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 685ACC061756
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jun 2021 20:07:59 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id p4-20020a17090a9304b029016f3020d867so1398508pjo.3
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jun 2021 20:07:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lkbW9hluwcztIOh5kOua513vVzY59E2u/mei+FpwsSU=;
        b=RkwrsYDbtUQcWzbVeDSJAQgCYy9gRaRRqozIRYV1yWbYfhv7cdakF5J3Bv2BUngsfK
         hFeLAZPesXvPVBLBNLFE0napPJPxpRWdvXy5QwbvejJwJkDMbYaqL24vsX5nu6api4WC
         +9MX/N1/6gkIAn8RNjfy/zz3PpXPQPBYS/XsM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lkbW9hluwcztIOh5kOua513vVzY59E2u/mei+FpwsSU=;
        b=kPA0jG5qNDbRxsqTIMCrhrdo0yQ1fOepqYWfO8PzQYWumnBCw6xz/H5UG8Cx6T8nFl
         ryvyQZzlROwDUPiZ2MbM++h7/yd8Jxvp5DWhlqdq6wVCb0hMLYUCipaON7zlLNak/XfJ
         EinpZPyQrVjtQbsgjhtdx6eZ+rhm5UO3nkLGBjZWIxx+jot8MYgKp9/5xH0rkszD/cJE
         mTrwtgykEwoyWgl6ldNiBx/ubqZYhfmRR38C1myLCaLiGh0PN/yfvE+Dsd5LWix95KfR
         Novgirsa27OKsQVJCUPDNbwWxo7WsYcQ7uOwgIXh2DDWeAeXjYJoSKcr/zJ2/wAwgkUI
         VEBw==
X-Gm-Message-State: AOAM531ymgbLn5SHQ3ywNX5fnOQqgrHicSnpksUBQ3j6fb0Y78IBtu8X
        DlzLHYgy3s02Qm228Oo19rn5jQ==
X-Google-Smtp-Source: ABdhPJywluBdydO/3+koxsNDeRCsfm/8/sSu9Nh+eXDSX8Lh9XieDEU9gLyfXK1qghmIJoNiqBpV6Q==
X-Received: by 2002:a17:90a:c002:: with SMTP id p2mr1501687pjt.132.1624331278548;
        Mon, 21 Jun 2021 20:07:58 -0700 (PDT)
Received: from hsinyi-z840.tpe.corp.google.com ([2401:fa00:1:10:aaeb:6e67:2eb9:f492])
        by smtp.gmail.com with ESMTPSA id z6sm13740722pfj.117.2021.06.21.20.07.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jun 2021 20:07:58 -0700 (PDT)
From:   Hsin-Yi Wang <hsinyi@chromium.org>
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        devicetree@vger.kernel.org,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Jassi Brar <jaswinder.singh@linaro.org>
Subject: [PATCH v3 RESEND 1/2] arm64: dts: mt8183: add mediatek,gce-events in mutex
Date:   Tue, 22 Jun 2021 11:07:41 +0800
Message-Id: <20210622030741.2120393-1-hsinyi@chromium.org>
X-Mailer: git-send-email 2.32.0.288.g62a8d224e6-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

mediatek,gce-events is read by mutex node.

Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
Reviewed-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
---
 arch/arm64/boot/dts/mediatek/mt8183.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8183.dtsi b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
index c5e822b6b77a3..cf22d71161e58 100644
--- a/arch/arm64/boot/dts/mediatek/mt8183.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
@@ -1250,6 +1250,8 @@ mutex: mutex@14016000 {
 			reg = <0 0x14016000 0 0x1000>;
 			interrupts = <GIC_SPI 217 IRQ_TYPE_LEVEL_LOW>;
 			power-domains = <&spm MT8183_POWER_DOMAIN_DISP>;
+			mediatek,gce-events = <CMDQ_EVENT_MUTEX_STREAM_DONE0>,
+					      <CMDQ_EVENT_MUTEX_STREAM_DONE1>;
 		};
 
 		larb0: larb@14017000 {
-- 
2.32.0.288.g62a8d224e6-goog

