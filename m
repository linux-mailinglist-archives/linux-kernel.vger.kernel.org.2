Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F93D3954AB
	for <lists+linux-kernel@lfdr.de>; Mon, 31 May 2021 06:35:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230050AbhEaEhZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 May 2021 00:37:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229717AbhEaEg5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 May 2021 00:36:57 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D8D6C061760
        for <linux-kernel@vger.kernel.org>; Sun, 30 May 2021 21:35:10 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id q25so8105627pfn.1
        for <linux-kernel@vger.kernel.org>; Sun, 30 May 2021 21:35:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wS5m2z0kdK64AV2ytOX+ndcFkQ/Q87q9VVh0RznGUCE=;
        b=ohNQUgiFv/Fr1yPgaH6iA4nF1fNcnSHZKFgxhEAFnwjZTEMCaINRq9c/T5U3EIuJaE
         3ZNmPQWOsv0nGdzItO5F+G3bx6lLHnTVI+Fn5/VX4bVdNu7QbF+hCAXbOT2jy7Ft++jN
         IBXZsCeuCvycV5LrSpzECRpKsV4+PI8V9kk8I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wS5m2z0kdK64AV2ytOX+ndcFkQ/Q87q9VVh0RznGUCE=;
        b=k6YZYJUBnefHfcxn2/qd7SaubPH/hm9rGWiwZhvHmqeAB0UFSMHK47AF76TVnh+F9N
         neibJca0fsyY0YzCzNV+PgjsBB5tGlYgRP0rnyHFms2OcBMFQjZZNVqiR5NymY23f5pI
         McdvSa1TvFkEaUSGIvDWAT5OSxJPJAaqHdc2j5P8qfVHuG5x7TZ8ZYNrODvNBcg4HiDI
         nx1jBh+ZH5FNWwF80lD8KUahmyw//gAh2vyNa4mMyDSwYz6i0oqUuu+YiREeQ3hmgdgZ
         GOa4uUks+GMFJGp+efG2OMYc0ovm9Ck6GvDhYAboptjwrDq1CVMSSvNGBgLkGqaqLuhR
         buiA==
X-Gm-Message-State: AOAM5308jWddqYud7lVj69kBy2e48l2gdx+CRFpG9K9k5xaUVjMxH+qt
        SfOmQq94BwBLu7qffXHXkCFAcQ==
X-Google-Smtp-Source: ABdhPJzOiquBBIDE4EvMprzcLUHuBhRfUOPzESEydjqntsXKkuvRcoC9aC3UWo9/twaTctBSY393ig==
X-Received: by 2002:a63:7d4:: with SMTP id 203mr7910265pgh.348.1622435709911;
        Sun, 30 May 2021 21:35:09 -0700 (PDT)
Received: from hsinyi-z840.tpe.corp.google.com ([2401:fa00:1:10:c929:9e58:1e99:bfb5])
        by smtp.gmail.com with ESMTPSA id a9sm9366811pfo.69.2021.05.30.21.35.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 May 2021 21:35:09 -0700 (PDT)
From:   Hsin-Yi Wang <hsinyi@chromium.org>
To:     Matthias Brugger <matthias.bgg@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        chun-jie.chen@mediatek.corp-partner.google.com,
        Yong Wu <yong.wu@mediatek.com>
Subject: [PATCH 3/3] arm64: dts: mt8183: remove syscon from smi_common node
Date:   Mon, 31 May 2021 12:35:02 +0800
Message-Id: <20210531043502.2702645-3-hsinyi@chromium.org>
X-Mailer: git-send-email 2.32.0.rc0.204.g9fa02ecfa5-goog
In-Reply-To: <20210531043502.2702645-1-hsinyi@chromium.org>
References: <20210531043502.2702645-1-hsinyi@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We don't need to register smi_common as syscon. Also add required
property power-domains for this node.

Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
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

