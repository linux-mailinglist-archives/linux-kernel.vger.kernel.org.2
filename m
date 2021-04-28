Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A39736D176
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Apr 2021 06:55:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235553AbhD1E43 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Apr 2021 00:56:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234376AbhD1E41 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Apr 2021 00:56:27 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFF2FC06175F
        for <linux-kernel@vger.kernel.org>; Tue, 27 Apr 2021 21:55:43 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id p12so43884705pgj.10
        for <linux-kernel@vger.kernel.org>; Tue, 27 Apr 2021 21:55:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gt4pb5bT5mW/MToENIuo4Jt8VqUlSnyGRgKvmw6yKp0=;
        b=oXkcL1lHMS9/atp/1M+2S4oUJFLqrFv1wWQ5I09WWZB5DvznwYznRkUaU8SkfqTGEs
         UYeW43uZrTmQYfz++FpfwhzLxXJ4rtEN+on9zjE9ohFbgKvRHbzOENyfiyVyRz37eJiR
         BFTrFfuAi9YJzDjhgAmeckvfyV99TbMfYgsZ0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gt4pb5bT5mW/MToENIuo4Jt8VqUlSnyGRgKvmw6yKp0=;
        b=WCZAcMWFFrlL485z8YhmDNe13G3QZy7HDd5Q51CZEhEPnJmh4J3A2w8O5qG31YVtsf
         e3C3vZcz6w1FN7NeQdOlmbxRhQRKQItbwbsufjbZ+Y9RPES1Y50qEg/1RQTM3ZexvMz5
         K+ujOzL3VVKLBWpK/mlS6jzTa28RW9r32Z62rPHygCnmijjLmzLlA6sCWR4ibn9/XTaR
         xU1HmWllwSFXsYRJ3zcquJwAOoDGa20erwaXr/YMdeQ/Ir3dtoVKv/2pLJyG2q9H8ePc
         Ltuq1kImxyss0FdbV614YJL43NUE81Wv+0DVKS9/FZgRDuMZL2dsI7J8cVwOWx7wElBC
         8tdg==
X-Gm-Message-State: AOAM533Wg5YXTou1FS3j7ZWBfzGf1jpG8SVsrEglhCq8FON4dCSyIPcl
        Z3rSyW1Y6Y9WLPVfKa3o16T9cw==
X-Google-Smtp-Source: ABdhPJy6K5CdM/3nHF3p+/2eE4TdGymi9eYrEEqROe+kZTRJZLv9zhp0SI6/MmsV0uYFWsxTx8DpSg==
X-Received: by 2002:a62:1b88:0:b029:1fb:d3d0:343a with SMTP id b130-20020a621b880000b02901fbd3d0343amr26649171pfb.76.1619585743151;
        Tue, 27 Apr 2021 21:55:43 -0700 (PDT)
Received: from hsinyi-z840.tpe.corp.google.com ([2401:fa00:1:10:8076:36e5:2db0:967])
        by smtp.gmail.com with ESMTPSA id x13sm1193170pgf.13.2021.04.27.21.55.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Apr 2021 21:55:42 -0700 (PDT)
From:   Hsin-Yi Wang <hsinyi@chromium.org>
To:     dri-devel@lists.freedesktop.org
Cc:     Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Sean Paul <sean@poorly.run>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH v4 3/3] arm64: dts: mt8183: Add panel rotation
Date:   Wed, 28 Apr 2021 12:55:33 +0800
Message-Id: <20210428045533.564724-3-hsinyi@chromium.org>
X-Mailer: git-send-email 2.31.1.498.g6c1eba8ee3d-goog
In-Reply-To: <20210428045533.564724-1-hsinyi@chromium.org>
References: <20210428045533.564724-1-hsinyi@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

krane, kakadu, and kodama boards have a default panel rotation.

Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
---
 arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi b/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi
index ff56bcfa3370..793cc9501337 100644
--- a/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi
@@ -263,6 +263,7 @@ panel: panel@0 {
 		avee-supply = <&ppvarp_lcd>;
 		pp1800-supply = <&pp1800_lcd>;
 		backlight = <&backlight_lcd0>;
+		rotation = <270>;
 		port {
 			panel_in: endpoint {
 				remote-endpoint = <&dsi_out>;
-- 
2.31.1.498.g6c1eba8ee3d-goog

