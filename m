Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C4F33B2D0A
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jun 2021 12:55:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232349AbhFXK55 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Jun 2021 06:57:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232328AbhFXK5x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jun 2021 06:57:53 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80DEEC0617A6
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jun 2021 03:55:30 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id i4so2738295plt.12
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jun 2021 03:55:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Hriaztl5QKv2WOAvCmMVPEwAJVtjiW9iYPTLBEXStgo=;
        b=PDsAEsv+dfSRLQusPsoLYF8w7G6GnvRlHkrr1kzzx6as4Dh+x0U/zsW8d+GhiKFdsg
         FA2BBqPC5dprZVkpB5t5nsTliD/J2q5h8naaAS4RkKkgY5ukGDiE+mHZ/fjywOYmt7sp
         ZrJF+LxGucZtg7eBi8oNwcPwnRMsbOh9cKajE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Hriaztl5QKv2WOAvCmMVPEwAJVtjiW9iYPTLBEXStgo=;
        b=bqATwkTFPgLrAITFhEfvqoRmtV+zw3Kgb6ZU/lsZHqiubxw1yH+vj97gADegyuetSz
         GxQ7m9hgsONJU4G+tdkneAEu1ZFjAipLNJGN3+T6muFOSUza1oFfDcLgW9fp2AAMZF1B
         pjOTHPzyca+R+JowYzT3Jof19uwcLMJD6IRI1D6mAfxRh1S4d3IZGRE1vqNMfTPcakZu
         4Vall78XK6VKqEkUBesBFma8Y2DEBaLng5Jgpj7epS7k1K6RPxWiP3II4tUXci8r3o6i
         KSEstG4UGQbTqUN9Bt2ksSdoVxWmkxjcAQoetaMzf3zBZcnXCmuOfN9jBJO6X6/M1vtq
         GHhQ==
X-Gm-Message-State: AOAM532OsZPB+f1IpNmeRdewcOMD+RyhtOTdSC85JZGCQOF22uHhlDzY
        m7oXEfE0xBSGQmMHUCpFdRYZ3g==
X-Google-Smtp-Source: ABdhPJwIDZVYWX3JX8E878WehoIk0M5IUEfQqdozGEiAiaCvO86PR75GYv750m47mk4o7duo8cErKQ==
X-Received: by 2002:a17:90a:9a83:: with SMTP id e3mr15001900pjp.139.1624532130023;
        Thu, 24 Jun 2021 03:55:30 -0700 (PDT)
Received: from hsinyi-z840.tpe.corp.google.com ([2401:fa00:1:10:368f:686c:969:1f38])
        by smtp.gmail.com with ESMTPSA id t7sm2212536pgh.52.2021.06.24.03.55.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jun 2021 03:55:29 -0700 (PDT)
From:   Hsin-Yi Wang <hsinyi@chromium.org>
To:     dri-devel@lists.freedesktop.org,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        intel-gfx@lists.freedesktop.org
Cc:     Sean Paul <sean@poorly.run>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH v6 RESEND 3/3] arm64: dts: mt8183: Add panel rotation
Date:   Thu, 24 Jun 2021 18:55:17 +0800
Message-Id: <20210624105517.3886963-3-hsinyi@chromium.org>
X-Mailer: git-send-email 2.32.0.288.g62a8d224e6-goog
In-Reply-To: <20210624105517.3886963-1-hsinyi@chromium.org>
References: <20210624105517.3886963-1-hsinyi@chromium.org>
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
index ff56bcfa33703..793cc95013379 100644
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
2.32.0.288.g62a8d224e6-goog

