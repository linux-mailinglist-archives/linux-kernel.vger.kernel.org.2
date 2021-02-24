Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 551A6323951
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Feb 2021 10:21:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234600AbhBXJVM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Feb 2021 04:21:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234574AbhBXJVB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Feb 2021 04:21:01 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC229C061574
        for <linux-kernel@vger.kernel.org>; Wed, 24 Feb 2021 01:20:20 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id w18so818549plc.12
        for <linux-kernel@vger.kernel.org>; Wed, 24 Feb 2021 01:20:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=K6QbaVKtgtUI1ubiXeNENn0SvGUBYVnolrmYp1NXybw=;
        b=lhrDhFL9BPsIUJr+sHv8QFAokk6fIi+d3ao6ADbx57svNfTlb6pKOr05hv45/voIya
         9Go6qlRZbtKY9YXNx13LjCGzRkZTrWTfHqCAN3ruCmAR5J4G+t5ycwl0Ud0/2d65miA5
         aykld+iKInnGjJB1HIhORveAhbZXZbrk7gKEU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=K6QbaVKtgtUI1ubiXeNENn0SvGUBYVnolrmYp1NXybw=;
        b=oEYKWB4yCQKE0Z9myFQaE33QDTlvXC+IaSLsp+Tv3myMX2g1RyqqnZyL7YWP5O0JNL
         ukENUqnHYvBt0apNEmJvcFEfBmowzob4IeozwOqSLTtuFE9yZ7do2oNhyf1UItMdczuY
         h+YffoX7bBm0M8Ut1kgaRfM1b1kqfb723wPTGiVo6/KXR6ZFwVJjxaI30YspFERXBAl5
         wvCCp0Njr6EnjJdugeEJkLbZhba/T3a2MJKgFLyU8yZh1+tI03cELy30o4Z7S+Zz8x01
         i/tVGWF4yStiEO1ikZery3jgytLKJFQU1tKnYptMCHp4ke/2iZgCRv+GUzxntj6vLnDk
         IW4w==
X-Gm-Message-State: AOAM531AHt6Yb1t+YKhTHMFoFxc+APqGI0gQiGbRupTRRT7uYI9TKatl
        ooWxjIuwa0JXbXgcR6bh9jsUtw==
X-Google-Smtp-Source: ABdhPJzdWYNLyuGtkFHMNT1hFuQvLfPscgO8J+QdoZyQv16sdgGt+CJC44NDs5lHg4sX5U8g1+tZJA==
X-Received: by 2002:a17:90a:fb58:: with SMTP id iq24mr3533991pjb.64.1614158420489;
        Wed, 24 Feb 2021 01:20:20 -0800 (PST)
Received: from ikjn-p920.tpe.corp.google.com ([2401:fa00:1:b:186a:b03e:afb5:9b45])
        by smtp.gmail.com with ESMTPSA id q2sm1906456pfu.215.2021.02.24.01.20.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Feb 2021 01:20:20 -0800 (PST)
From:   Ikjoon Jang <ikjn@chromium.org>
To:     devicetree@vger.kernel.org, linux-mediatek@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Weiyi Lu <weiyi.lu@mediatek.com>, Ikjoon Jang <ikjn@chromium.org>
Subject: [PATCH] arm64: dts: mt8183: Add power-domains properity to mfgcfg
Date:   Wed, 24 Feb 2021 17:17:42 +0800
Message-Id: <20210224091742.1060508-1-ikjn@chromium.org>
X-Mailer: git-send-email 2.30.0.617.g56c4b15f3c-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

mfgcfg clock is under MFG_ASYNC power domain

Signed-off-by: Weiyi Lu <weiyi.lu@mediatek.com>
Signed-off-by: Ikjoon Jang <ikjn@chromium.org>
---

 arch/arm64/boot/dts/mediatek/mt8183.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8183.dtsi b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
index 5b782a4769e7..3384df5284c0 100644
--- a/arch/arm64/boot/dts/mediatek/mt8183.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
@@ -962,6 +962,7 @@ mfgcfg: syscon@13000000 {
 			compatible = "mediatek,mt8183-mfgcfg", "syscon";
 			reg = <0 0x13000000 0 0x1000>;
 			#clock-cells = <1>;
+			power-domains = <&scpsys MT8183_POWER_DOMAIN_MFG_ASYNC>;
 		};
 
 		mmsys: syscon@14000000 {
-- 
2.30.0.617.g56c4b15f3c-goog

