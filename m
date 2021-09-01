Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0EFC03FE3D2
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Sep 2021 22:21:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344722AbhIAUVz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Sep 2021 16:21:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343722AbhIAUVj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Sep 2021 16:21:39 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7026BC061764
        for <linux-kernel@vger.kernel.org>; Wed,  1 Sep 2021 13:20:41 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id 2so730467pfo.8
        for <linux-kernel@vger.kernel.org>; Wed, 01 Sep 2021 13:20:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mWpQuuJjmOltxcGlhp80Go7kcj2rBByEKq5WUEPaCUU=;
        b=XK94ViAcm0nxkHX43OqtJrmDk10oapIw+sE89kl6IesikSt+5Jv6hCy+/YIjBhe8NU
         ldI/mEX6luWPDd3MUKfPNt2tHvoCnvN4ej7yZuvIxr6MxL+AloelI0Fl+k8Td78wfGiz
         AWlJWNJobDgFv+/YDryZq12xHWLaxOG1XqeCY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mWpQuuJjmOltxcGlhp80Go7kcj2rBByEKq5WUEPaCUU=;
        b=IHRcSarJdgx0B3w0/x0U5hRIHSmwNyMEr6Ik4ixW5Lzq15MrRHA6euierTr98cG2SZ
         wJWvMgQKOnZUYyFD+e4blbVJORbkNiAXBieFBLgdahkqMeVdCjbbi1IP5FbEp4K7spp1
         Z9aBSiK/208jTWB1VSEQwF2joZKZBIkGLEFZPFONURHPY5lhPeZ6I5NB+mWrZWRTZ4ad
         e1PGDpDU64OEzWcplP8AtaDyaLegVupOol8ZEdVZmhvotSGt4G7OCi3H8bZ+NAUfAn+M
         M7CmUsHVZvokquqGA81HAaxpr3EUVAFktRQQ5sgPh1wpN/YkCY5LwQeUIn/zzdFMOeNk
         XqPA==
X-Gm-Message-State: AOAM530kr2ChPY/yxddhZAzeoe9HgKQTtNnjOhYRJ1epcFr1kooMmvX6
        wkyr32mAfikX2Vyi47mfyDKKNg==
X-Google-Smtp-Source: ABdhPJzp2cmXbEsSbVWCOkZZKfiv31TzBP31B0LfIbPldpdBtF6YxlUM1F7d6HlVMOhOFD452XmjKw==
X-Received: by 2002:a63:ed03:: with SMTP id d3mr802704pgi.24.1630527641056;
        Wed, 01 Sep 2021 13:20:41 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:201:958b:b561:a735:e774])
        by smtp.gmail.com with ESMTPSA id x15sm321178pfq.31.2021.09.01.13.20.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Sep 2021 13:20:40 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Sam Ravnborg <sam@ravnborg.org>
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Linus W <linus.walleij@linaro.org>,
        Daniel Vetter <daniel@ffwll.ch>, devicetree@vger.kernel.org,
        Steev Klimaszewski <steev@kali.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Maxime Ripard <mripard@kernel.org>,
        David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org,
        Douglas Anderson <dianders@chromium.org>,
        Andrey Zhizhikin <andrey.zhizhikin@leica-geosystems.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Fabio Estevam <festevam@gmail.com>,
        =?UTF-8?q?Guido=20G=C3=BCnther?= <agx@sigxcpu.org>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Michael Walle <michael@walle.cc>, Nishanth Menon <nm@ti.com>,
        Shawn Guo <shawnguo@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 07/16] arm64: defconfig: Everyone who had PANEL_SIMPLE now gets PANEL_SIMPLE_EDP
Date:   Wed,  1 Sep 2021 13:19:25 -0700
Message-Id: <20210901131531.v3.7.Ied5c4da3ea36f8c49343176eda342027b6f19586@changeid>
X-Mailer: git-send-email 2.33.0.259.gc128427fd7-goog
In-Reply-To: <20210901201934.1084250-1-dianders@chromium.org>
References: <20210901201934.1084250-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the patch ("drm/panel-simple-edp: Split eDP panels out of
panel-simple") we split the PANEL_SIMPLE driver in 2. Let's enable the
new config.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

(no changes since v1)

 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index f423d08b9a71..914057efa160 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -697,6 +697,7 @@ CONFIG_DRM_MSM=m
 CONFIG_DRM_TEGRA=m
 CONFIG_DRM_PANEL_LVDS=m
 CONFIG_DRM_PANEL_SIMPLE=m
+CONFIG_DRM_PANEL_SIMPLE_EDP=m
 CONFIG_DRM_PANEL_BOE_TV101WUM_NL6=m
 CONFIG_DRM_PANEL_MANTIX_MLAF057WE51=m
 CONFIG_DRM_PANEL_RAYDIUM_RM67191=m
-- 
2.33.0.259.gc128427fd7-goog

