Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA784371120
	for <lists+linux-kernel@lfdr.de>; Mon,  3 May 2021 07:05:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232853AbhECFG0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 May 2021 01:06:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232463AbhECFGW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 May 2021 01:06:22 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B529C061756
        for <linux-kernel@vger.kernel.org>; Sun,  2 May 2021 22:05:28 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id t22so2869951pgu.0
        for <linux-kernel@vger.kernel.org>; Sun, 02 May 2021 22:05:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=g3OaSiVF5MtL/VroYDmXFrkkWbMJTL0iUxMjRnNHvBY=;
        b=nKzE6s5knmvNp/Hcd0vBxdVoIJLOGEBAopHSc/8Lo1xuaFCkOeckBx31XO1SdCzYqr
         c3Lp+RYIf1YodVE9jGMYF7pKrcMH4QdKWUljPofNhlCd62P2uTzbyPryq3vDcN4kleYm
         TQD11xqkA88SZXJ/v70iuhVXZQaFFO9rnwBgc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=g3OaSiVF5MtL/VroYDmXFrkkWbMJTL0iUxMjRnNHvBY=;
        b=BTz3YhWDbzKAoB6rdW8pXIRzm7cGAH4iW+y3ZP8PbkjqqOia/zbuHvUsdLp/4nZ7Px
         ZfpveNY4+9wRTDGZLWf6dXNRfKtj9J9am/NtQv65mM2L24moJSn84b4twTDadAApAk9R
         FZ+2z4U+iASlD0jD8CxnYGmvJNdOPLj9KWLXpMbePwUD34nwTkHCV38YsQtVrIeQW8Fw
         R4eFE1UbZECs/hzayZ6cS2Xgv1ofublVv8TJ1vrR+MGD9MMZGVtl1zl2t7JyGA11EsJA
         Fhz6XB5XixLYPHYXMuTUSTkWGEIO5ofeyD5N+i0QRk0ig8lACj76W6iJYufbFQeLKKMu
         7vHQ==
X-Gm-Message-State: AOAM530CXbIw2LeqBbHJC6zT9Rt4Ceq493N+cFDNwLfaMC/HNqAQmFtd
        rfMYFEZxJ477kznreEU9Nbt1OQ==
X-Google-Smtp-Source: ABdhPJzzaCXBMXMoEGL5WtdSc8NmhA2rO2kQhgEa8DyTFoirOLa/q/qV8pUGOT20LBAYUdQMVgk+iQ==
X-Received: by 2002:a62:6142:0:b029:28e:b072:6b7 with SMTP id v63-20020a6261420000b029028eb07206b7mr710806pfb.65.1620018327485;
        Sun, 02 May 2021 22:05:27 -0700 (PDT)
Received: from hsinyi-z840.tpe.corp.google.com ([2401:fa00:1:10:63a0:c726:475a:ace5])
        by smtp.gmail.com with ESMTPSA id 14sm7854600pfi.145.2021.05.02.22.05.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 May 2021 22:05:27 -0700 (PDT)
From:   Hsin-Yi Wang <hsinyi@chromium.org>
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        devicetree@vger.kernel.org,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] arm64: dts: mt8183: add mediatek,gce-events in mutex
Date:   Mon,  3 May 2021 13:05:22 +0800
Message-Id: <20210503050523.2571758-1-hsinyi@chromium.org>
X-Mailer: git-send-email 2.31.1.527.g47e6f16901-goog
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
index c5e822b6b77a..cf22d71161e5 100644
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
2.31.1.527.g47e6f16901-goog

