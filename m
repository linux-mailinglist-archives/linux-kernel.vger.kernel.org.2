Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27464368D62
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Apr 2021 08:53:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236806AbhDWGyR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Apr 2021 02:54:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbhDWGyP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Apr 2021 02:54:15 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B16CC06174A
        for <linux-kernel@vger.kernel.org>; Thu, 22 Apr 2021 23:53:39 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id t22so24441599ply.1
        for <linux-kernel@vger.kernel.org>; Thu, 22 Apr 2021 23:53:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oBsB1gTZg7pCEafsajc7J+2ruSCh6B3ByCc2MPyji4k=;
        b=W2YpkNGska2guIgrKuthtDEFw0MwFDObtJe2oFDv0nSSdYRgHQfhrLWZH/l3ZFhbj1
         Ghy+BnszbbQ96marP7fzm0xZwUhQB6XqAygVceemKVrShGdixZufzFOJCbuwnG3I0F/8
         VOS+exVsVKPOpudrDs6b9KGMdrgXkEx2dA/M8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oBsB1gTZg7pCEafsajc7J+2ruSCh6B3ByCc2MPyji4k=;
        b=MbTpWme+7uGC1G8hz67yVqn3JYT3eDkfs+IxKPcENo/efHomh5KtvehVuXcHU+ahxW
         D3b840AKDRcldgQThdHM54AzEztd/hY+rHw0ngK79deHJ70dg44t8eJAJCR26OF4bWIe
         uB12LDgyMVWH51FEz/yETB6HE2AKK2A0OC1M8BUVC4aRgJejfEGMIDko253LvIBhnWMn
         9a2TC1GLUHZgdoVUzr9+paFbsyhpFrnaoy0NokL5uUPlGJ+YsKYAzAhqTaWPa1Fh1btJ
         jdhVqQ6vJLB1le+e7rqIAtTlYlruBCdW4ebx+w3Fc4ftnrUCw3/IvWNrhqOc8KRZ2NtF
         st/A==
X-Gm-Message-State: AOAM5334IyFyVoXguHtc6pN4XmfXZrHMK3spwM0uMQQCQazDwiKivWhx
        P9nrSP1x0I9bDEAfsmbBXclPAQ==
X-Google-Smtp-Source: ABdhPJyOUqurtSe35jHgXPvYL2sJPGggDMcNevLnMOq/El+jK1sVKr2iiwReHcGfqEMype6g/xvuGA==
X-Received: by 2002:a17:90a:318d:: with SMTP id j13mr2900233pjb.174.1619160818607;
        Thu, 22 Apr 2021 23:53:38 -0700 (PDT)
Received: from hsinyi-z840.tpe.corp.google.com ([2401:fa00:1:10:a0c1:e03a:8cab:4dd4])
        by smtp.gmail.com with ESMTPSA id 1sm3731450pjx.46.2021.04.22.23.53.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Apr 2021 23:53:38 -0700 (PDT)
From:   Hsin-Yi Wang <hsinyi@chromium.org>
To:     Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>
Subject: [PATCH] arm64: dts: mt8183: add mediatek,gce-events in mutex
Date:   Fri, 23 Apr 2021 14:53:28 +0800
Message-Id: <20210423065327.1596075-1-hsinyi@chromium.org>
X-Mailer: git-send-email 2.31.1.498.g6c1eba8ee3d-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

mediatek,gce-events is read by mutex node.

Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
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
2.31.1.498.g6c1eba8ee3d-goog

