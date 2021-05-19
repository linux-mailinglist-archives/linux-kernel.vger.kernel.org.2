Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE644389804
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 22:36:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229708AbhESUhV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 16:37:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229575AbhESUhR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 16:37:17 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F17E0C061761
        for <linux-kernel@vger.kernel.org>; Wed, 19 May 2021 13:35:56 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id a4so15400069wrr.2
        for <linux-kernel@vger.kernel.org>; Wed, 19 May 2021 13:35:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=E86M8ZFI17SPZdRhP/Hegi7pved0ocDQoAlWZoCG2K0=;
        b=QvEVTtHHUyx0bus4QZnTQbK6l5ZunpAU30ioE38p3xjfvwrl/4ofHoI7UB3WBmWvj2
         k959cr675azEQL9Aa9k/XAIpRn0njMB7PSWT4z0syjZwtWHR9di1Cl5oWREewtR3tTrF
         vFyN31nhYaiY9shGObcrUDhn0B5vQmv5ddGkc0zRuViXR4HBs9uRgURVPXIlbrg+weZV
         3HRsjYWt+tEF9O73j2Px7KkgSBzD8xkiuKbAQ5tHnOL8QXphLFiGjn3UVpoXL4iALbTN
         vPXc25NmPH75+BeA250crVSGBFhJ8DdTfLSsWCB5f0sem44Tky8zMlbvG1wlMHnLz9pz
         tbOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=E86M8ZFI17SPZdRhP/Hegi7pved0ocDQoAlWZoCG2K0=;
        b=HUyAxxmWUJx3kQ0HiAsacwj7njGd97FnGY65YQTYlil9u48axPDVQz5ktDyUSqjSlC
         OIx9/am/jGV1pF5VfvKhnKA79cPMijoUxgWsaiQZllKs7k8imYUdQGLg5YHOmOIANYEv
         kAdDBl2KXDTRJ/xgUe6eBmRFwM8Qqh42B1FQeHf65av7M6koh6DZiWCu/mu40L9LyNkY
         +3FPAN34IWRT44iy8NwRWjW5QETJJ4YnF1Z3lyMM3F4QU4+j0icMGOoiQrQMzj7/q9ok
         q11ikuqkEBibL1apHhTnzYZiygRSYPR7BfFbXqO0pmk2v/iS10YvmO1OFemYl8BIslll
         5e4A==
X-Gm-Message-State: AOAM530/BkpPBvxgNmNhV5mq/0OnNLdCzXji2fj1OKR9+fX2uuD44HWh
        cyayK2qCbXalLvwLCg7MH2v0WA==
X-Google-Smtp-Source: ABdhPJwW3NvOpKEXYZiI5P5aVY4plqkdy1YIWQBgyz37GWNhM4ckyeMYB/gc2E10kBgaPi7Ca7ZGmw==
X-Received: by 2002:a5d:5989:: with SMTP id n9mr778417wri.60.1621456555641;
        Wed, 19 May 2021 13:35:55 -0700 (PDT)
Received: from localhost.localdomain (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id y20sm7531918wmi.0.2021.05.19.13.35.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 May 2021 13:35:55 -0700 (PDT)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     airlied@linux.ie, daniel@ffwll.ch, linus.walleij@linaro.org,
        robh+dt@kernel.org, ulli.kroll@googlemail.com
Cc:     devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH v2 3/3] ARM: dts: gemini: remove xxx-cells from display
Date:   Wed, 19 May 2021 20:35:47 +0000
Message-Id: <20210519203547.837237-3-clabbe@baylibre.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210519203547.837237-1-clabbe@baylibre.com>
References: <20210519203547.837237-1-clabbe@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

dtb_check complains about #address-cells and #size-cells, so lets
remove them.

Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
 arch/arm/boot/dts/gemini.dtsi | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm/boot/dts/gemini.dtsi b/arch/arm/boot/dts/gemini.dtsi
index fa708f5d0c72..34961e5bc7b2 100644
--- a/arch/arm/boot/dts/gemini.dtsi
+++ b/arch/arm/boot/dts/gemini.dtsi
@@ -417,8 +417,6 @@ display-controller@6a000000 {
 			clock-names = "PCLK", "TVE";
 			pinctrl-names = "default";
 			pinctrl-0 = <&tvc_default_pins>;
-			#address-cells = <1>;
-			#size-cells = <0>;
 			status = "disabled";
 		};
 
-- 
2.26.3

