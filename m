Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9128D359431
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 06:53:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231410AbhDIExf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Apr 2021 00:53:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230312AbhDIExd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Apr 2021 00:53:33 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E265C061760
        for <linux-kernel@vger.kernel.org>; Thu,  8 Apr 2021 21:53:21 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id y32so2959450pga.11
        for <linux-kernel@vger.kernel.org>; Thu, 08 Apr 2021 21:53:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OS7lcaPxknITZLvovVkA4QPXgon3j/mJxiD24igJRqo=;
        b=h4zcLAdWfRJgihK2lfSX3Ypml2LDDqkOCQxP1jzvewO4jhVm55tUwaYfZcqvP2cxZG
         +p00cv2fniK5dn64pXL/DD4rWqhDqCXJA/Hy890kQH2cKfRb6uQHe8wlmXMWoHg65I/s
         0ddH48c2OC/fmk1+1JQ6/j6A3800tbq4+63TA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OS7lcaPxknITZLvovVkA4QPXgon3j/mJxiD24igJRqo=;
        b=pijh35649oUkmImOgq6Nh1lI4EBQsoZ62JTuQW/aQPvj3QVGWulO6AhxpYICDAah0n
         E3cPTzVyPulUAMzuZhPxMXL7aRXrX1VuvEmJ99fvHDtaL1pFCdw1vZHNbv4tBrsLv5vH
         ydL9536ZVPrXJGaURBF8csQQnyyu+uERU4HsCGk3BlxCdsXtXXIfAeXb4V/wFisKXNxw
         tLqjgnJozIkc8pAOA5jsIhHuk0X4IbzImCwEs9K7R2LGB2fnlM9KG6QWtF598heCLmd2
         JmTJFvZPYe6ZyP4+QvLvl5R6t+h6VuuEitXrJVIbpUH1vw/1dNkvelZ+Qxm++ilpfS8F
         jH5w==
X-Gm-Message-State: AOAM533iBDi+MYUTCOd9eTHN6k6EqJcFi4VFRgqXX/IPnq6MM4L9hQSv
        z7RzIckIqbqqbAtnklID/1iKjQ==
X-Google-Smtp-Source: ABdhPJwvi9n1MpPr9EbApqw4tpal6rn4nFHgDRv5qpHpDXeyET2KUNc94sSla03g7YL6LJLDGwmMDw==
X-Received: by 2002:a05:6a00:1c77:b029:241:5c43:8cf5 with SMTP id s55-20020a056a001c77b02902415c438cf5mr10989642pfw.10.1617944000932;
        Thu, 08 Apr 2021 21:53:20 -0700 (PDT)
Received: from hsinyi-z840.tpe.corp.google.com ([2401:fa00:1:10:f9f6:696:a955:72e9])
        by smtp.gmail.com with ESMTPSA id p2sm900696pgm.24.2021.04.08.21.53.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Apr 2021 21:53:20 -0700 (PDT)
From:   Hsin-Yi Wang <hsinyi@chromium.org>
To:     Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
Subject: [PATCH 2/2] arm64: dts: mt8183: Add panel rotation
Date:   Fri,  9 Apr 2021 12:53:14 +0800
Message-Id: <20210409045314.3420733-2-hsinyi@chromium.org>
X-Mailer: git-send-email 2.31.1.295.g9ea45b61b8-goog
In-Reply-To: <20210409045314.3420733-1-hsinyi@chromium.org>
References: <20210409045314.3420733-1-hsinyi@chromium.org>
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
2.31.1.295.g9ea45b61b8-goog

