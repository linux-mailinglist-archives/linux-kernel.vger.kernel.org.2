Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FB6436E440
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Apr 2021 06:28:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237154AbhD2E3i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Apr 2021 00:29:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235095AbhD2E3a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Apr 2021 00:29:30 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 150E3C06138D
        for <linux-kernel@vger.kernel.org>; Wed, 28 Apr 2021 21:28:45 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id y1so18422045plg.11
        for <linux-kernel@vger.kernel.org>; Wed, 28 Apr 2021 21:28:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gt4pb5bT5mW/MToENIuo4Jt8VqUlSnyGRgKvmw6yKp0=;
        b=m2YPwqx7aeh6V4lUo0oHObJCqs1T+6ImiIjbJPb/XrFOXsS88GT0/U1TDgdJ1tlgtf
         vjjBBMfm1Eh2YmwOe5/fcnlTizd+eytKYuLtVI0Gxm72V5zal5FgLmjsqqeYmBs89pTu
         fubvjuXh/iVeU7gxgntYYq/wNSGAnKMhvhb1Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gt4pb5bT5mW/MToENIuo4Jt8VqUlSnyGRgKvmw6yKp0=;
        b=Pa+5yFjgCHMKvT5YYA4l1t/Bnrthq8/fXX1LLcZOMvcUov9rEHz6XhsJUleWCltjvN
         QRCP/7ass88FInmmS29XfYNOLYNFOOUtwkRu09C+N65mvk7CBX36ox+odrT1nMJ+kHlO
         DCk9PsmQMsDwZgpp1FTChSoNt5gL52MaZHN0Ky3cTIhWnXpVKtPUK9Bf5Kh4gaf+ARPu
         tBc35PQQfM0SXV5Z7AicoSmDtOM5ADekNSLa+ydLn8M3Id1SRbiNfBThqfWf6WSdtYGf
         +0dRBT70Dvw5F2enzVZP+lx2tnhfWb+mLiN4J+4xTmaQs+CTqCX7ULxPmPoxWJ7LU8/B
         TdTQ==
X-Gm-Message-State: AOAM530f1kJfF/P3CUs+sEEi/jzX5XlzeUPuxKNG3dCRNNdn0kTn2VBG
        V4SSFWpEntfGZ2G/7jX7+jwhBw==
X-Google-Smtp-Source: ABdhPJx0CF0XSmcRjIoO/yWcAnjTe7hR6m9+xUw2Ts97CHJGvHusZESHQqWarI1X5miU9uUBrAavWQ==
X-Received: by 2002:a17:90a:dd45:: with SMTP id u5mr7845750pjv.15.1619670524616;
        Wed, 28 Apr 2021 21:28:44 -0700 (PDT)
Received: from hsinyi-z840.tpe.corp.google.com ([2401:fa00:1:10:f701:2ca2:56ba:8e83])
        by smtp.gmail.com with ESMTPSA id w124sm1069390pfb.73.2021.04.28.21.28.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Apr 2021 21:28:44 -0700 (PDT)
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
Subject: [PATCH v6 3/3] arm64: dts: mt8183: Add panel rotation
Date:   Thu, 29 Apr 2021 12:28:34 +0800
Message-Id: <20210429042834.1127456-3-hsinyi@chromium.org>
X-Mailer: git-send-email 2.31.1.498.g6c1eba8ee3d-goog
In-Reply-To: <20210429042834.1127456-1-hsinyi@chromium.org>
References: <20210429042834.1127456-1-hsinyi@chromium.org>
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

