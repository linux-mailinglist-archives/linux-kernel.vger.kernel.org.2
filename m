Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9934736BEA3
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 06:50:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235090AbhD0Eur (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Apr 2021 00:50:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234761AbhD0Eul (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Apr 2021 00:50:41 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AA65C061574
        for <linux-kernel@vger.kernel.org>; Mon, 26 Apr 2021 21:49:58 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id l10-20020a17090a850ab0290155b06f6267so340506pjn.5
        for <linux-kernel@vger.kernel.org>; Mon, 26 Apr 2021 21:49:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gt4pb5bT5mW/MToENIuo4Jt8VqUlSnyGRgKvmw6yKp0=;
        b=c+K89QY/gVhAeVZ0+WRtE2V6947IE8xTms8pbQvd+uhFOHJ2x/QLZl0aO54BBy9N6x
         PKAshJvy/RwX8BXEYR/ej2DI9gs6jXQHgNoUnvesfJ/1BNnYbIKLNyWO1Sy/lViJxzBo
         TkXU0r6xkpSpA841HlW63vUTSlXIbr7Kf5iLE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gt4pb5bT5mW/MToENIuo4Jt8VqUlSnyGRgKvmw6yKp0=;
        b=VFYhHytABEBcc9ZTPSm7OTkb2OGmp83HDSCIa7zymniVx73vCsO0DNmpZ8y2MgFY17
         5p50G2fHe8k/VJiFLe8b2Zp88OkN+8WwErvq83GEQyKqsVIFn05h/8QyUm/TgPXbwPZ4
         lSG9bByPksfYthYr4j9lGQaq+0L0X7LyZnNkNmGqPxfvZKj3Rueou3QpNQQWB7AA3ueh
         w/++9NPMGSqUhaEJ2U8nGP1TFT1sNjg1GqqOtImzHHkKP5WCYjTw/P3rDdnryXMKAlZO
         6fHuScfy70su3hFaBcunPm/0Utg1xy7QBO/PLRJ2mEs3ZpXC+E0jM2Inoecj5kWFEyP0
         Va+g==
X-Gm-Message-State: AOAM530x1LFGQl7Xyy5KX1SyM7W2RPgsl6ALm5DxEwvqaAz5bE3U49iI
        V+Kkp0JjJO94qw1DJ3+zGjiQ2w==
X-Google-Smtp-Source: ABdhPJy1BUt6+R21LCxa4D+U5Ie0p/vfRjiqUmnUX6m/JmeuU/QU2wgLbY7MTc98UD0cppxqB/jq0A==
X-Received: by 2002:a17:90a:b78f:: with SMTP id m15mr15823564pjr.131.1619498998028;
        Mon, 26 Apr 2021 21:49:58 -0700 (PDT)
Received: from hsinyi-z840.tpe.corp.google.com ([2401:fa00:1:10:3984:c4f5:8612:6b3e])
        by smtp.gmail.com with ESMTPSA id c125sm1151517pfa.74.2021.04.26.21.49.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Apr 2021 21:49:57 -0700 (PDT)
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
Subject: [PATCH v3 3/3] arm64: dts: mt8183: Add panel rotation
Date:   Tue, 27 Apr 2021 12:49:48 +0800
Message-Id: <20210427044948.12596-3-hsinyi@chromium.org>
X-Mailer: git-send-email 2.31.1.498.g6c1eba8ee3d-goog
In-Reply-To: <20210427044948.12596-1-hsinyi@chromium.org>
References: <20210427044948.12596-1-hsinyi@chromium.org>
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

