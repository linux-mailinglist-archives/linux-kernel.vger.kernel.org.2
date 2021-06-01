Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A814A396BFE
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jun 2021 06:00:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231171AbhFAECB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Jun 2021 00:02:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbhFAECA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jun 2021 00:02:00 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B2B8C061574
        for <linux-kernel@vger.kernel.org>; Mon, 31 May 2021 21:00:19 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id o17-20020a17090a9f91b029015cef5b3c50so646376pjp.4
        for <linux-kernel@vger.kernel.org>; Mon, 31 May 2021 21:00:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=k3CXuIHvguEKDy/ECWlq3WX2NJbLw9/l4D5j8nQaStQ=;
        b=UPTILnt9B7+RBltwKhRkE3pDiFM447zC45wGOtGp30p7Gacb2MTU7rMY3naqzhfpLz
         VH4yJnFNaFN5lr1cF4PURM4D81wWhql55YMgqGbvu9NflrxWS1MnLdwlj5TPlHefOIO4
         Yt2BOQjYlm0lzGkyu7DibJv5p+gDjuJLdvj4E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=k3CXuIHvguEKDy/ECWlq3WX2NJbLw9/l4D5j8nQaStQ=;
        b=Moamq5ltpArftlMpePtfRATCWdtd7ShKvHHixGXhGaOrFmqSSl5/ZeIB1BU91xHV4h
         n22byvnLghVENQca9u9hZBDTDSQjKVq52gf1ZVFjOwaB3/ViFVAGKUCsfnCowS75rsXT
         HDQCADOt0mSap/T+nYC6sThMvm6hz0+kM1F1YYsZAORA7hgpusyh+nIucE+8r+cNRRP/
         rfxozZouzgcJ6RPH2Lk5kp+/wU0+7yciPONrt6po7hp+cNi6Ri8X5Hiq+qiLludL4Rwn
         FDNiU67wQs5BGweZLib8AAAAKljcN8uE0/Z7IvmklIgpTHTvMcPPFeTcxvHF1a3kpatM
         NZrA==
X-Gm-Message-State: AOAM530mTUZwcP1TTRrkvONOvAup06IEPuXMLfO1pLG5xRIvQCkuSYlJ
        r5eqfwzXO4IhoUn6xmsVsucliw==
X-Google-Smtp-Source: ABdhPJxVRZNWrzNMHtMZqws3k5caqBWHpgoq/Euc0BFxsKp0hxH4Lc9Fj8WdYMvbSZCNfIab89LMoQ==
X-Received: by 2002:a17:90a:9517:: with SMTP id t23mr2477148pjo.130.1622520019059;
        Mon, 31 May 2021 21:00:19 -0700 (PDT)
Received: from hsinyi-z840.tpe.corp.google.com ([2401:fa00:1:10:5f83:3563:b780:4d82])
        by smtp.gmail.com with ESMTPSA id 191sm11866953pfx.121.2021.05.31.21.00.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 May 2021 21:00:18 -0700 (PDT)
From:   Hsin-Yi Wang <hsinyi@chromium.org>
To:     Matthias Brugger <matthias.bgg@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        chun-jie.chen@mediatek.corp-partner.google.com,
        Yong Wu <yong.wu@mediatek.com>
Subject: [PATCH v2 3/3] arm64: dts: mt8183: remove syscon from smi_common node
Date:   Tue,  1 Jun 2021 12:00:14 +0800
Message-Id: <20210601040014.2970805-1-hsinyi@chromium.org>
X-Mailer: git-send-email 2.32.0.rc0.204.g9fa02ecfa5-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We don't need to register smi_common as syscon. Also add required
property power-domains for this node.

Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
Reviewed-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
---
 arch/arm64/boot/dts/mediatek/mt8183.dtsi | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt8183.dtsi b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
index c5e822b6b77a..e074c0d402ff 100644
--- a/arch/arm64/boot/dts/mediatek/mt8183.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
@@ -1263,13 +1263,14 @@ larb0: larb@14017000 {
 		};
 
 		smi_common: smi@14019000 {
-			compatible = "mediatek,mt8183-smi-common", "syscon";
+			compatible = "mediatek,mt8183-smi-common";
 			reg = <0 0x14019000 0 0x1000>;
 			clocks = <&mmsys CLK_MM_SMI_COMMON>,
 				 <&mmsys CLK_MM_SMI_COMMON>,
 				 <&mmsys CLK_MM_GALS_COMM0>,
 				 <&mmsys CLK_MM_GALS_COMM1>;
 			clock-names = "apb", "smi", "gals0", "gals1";
+			power-domains = <&spm MT8183_POWER_DOMAIN_DISP>;
 		};
 
 		imgsys: syscon@15020000 {
-- 
2.32.0.rc0.204.g9fa02ecfa5-goog

