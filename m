Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADDC9380969
	for <lists+linux-kernel@lfdr.de>; Fri, 14 May 2021 14:21:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233378AbhENMXE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 May 2021 08:23:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233398AbhENMW6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 May 2021 08:22:58 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54E33C061756
        for <linux-kernel@vger.kernel.org>; Fri, 14 May 2021 05:21:47 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id t21so16096039plo.2
        for <linux-kernel@vger.kernel.org>; Fri, 14 May 2021 05:21:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sKjlU1Buo3yAKav8pJKU6YPJruDt7qvnKtW5oGGLMB0=;
        b=NLXYC/fCzff42RFMo4JsKua3S2IUCUzTzaHkCXxtiZNbwuwiwTdCxz6oz87Jq392+5
         geLJgwyMNlpMjsQV1eMcrdPMIIz9KPJl2FVhKbTfE+rCCtZm/96BW7tBnrHuaVnZBnfw
         DjDsx2hnn3ihtXF61OzbVgrDk0P2cCFWKerUE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sKjlU1Buo3yAKav8pJKU6YPJruDt7qvnKtW5oGGLMB0=;
        b=qqICTBM50EJfWW/PR6O++Xail+tfVlYu0YUTxiJmwHB7GjgEa2u0zuE+GLGAJIfjb+
         ioCXi46ED0HZM/LEslTYE40+Uawajx3SVDxUymfbjB2DvX02J6gr9c4JeJMwqmKpFyzE
         HXXeRFZjswzjvios1oLNbU1rBW0IBWqXjmKwn2vHv70rSVh63F1zgOw/D5rV7xXGQsxa
         xwGlKNsV7PA/sbjVGLF1t1gw1V3J8YSu7+5651z2lYgxuLPyTKM1blNd8vF0T0j41eS0
         5y0vO7bBxAt3DAwBtTHfgTwXlx1GxMcMCZx67fHqDc9MTTpXfIVsJagupzsVj5otIqeu
         BLvA==
X-Gm-Message-State: AOAM531mopHn7SIQZfvrXflreZcIm69kJggTUInxi+Ei4hCchtAOG5FI
        qT09oAwqoYkF04MszXr9MnhtYA==
X-Google-Smtp-Source: ABdhPJzbhRjGp805y3Hi2jGWtbTzWzNP/rtCinbBrDZStuzJwfwKrzHfxCMVKpvvbNeU+KgrFdTwVA==
X-Received: by 2002:a17:90a:f87:: with SMTP id 7mr33610983pjz.38.1620994906861;
        Fri, 14 May 2021 05:21:46 -0700 (PDT)
Received: from ikjn-p920.tpe.corp.google.com ([2401:fa00:1:b:7641:4b1d:694e:6ea2])
        by smtp.gmail.com with ESMTPSA id u17sm4010117pfm.113.2021.05.14.05.21.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 May 2021 05:21:46 -0700 (PDT)
From:   Ikjoon Jang <ikjn@chromium.org>
To:     devicetree@vger.kernel.org, Lee Jones <lee.jones@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        Guenter Roeck <groeck@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Benson Leung <bleung@chromium.org>,
        linux-input@vger.kernel.org, Hsin-Yi Wang <hsinyi@chromium.org>,
        Jiri Kosina <jikos@kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Ikjoon Jang <ikjn@chromium.org>,
        Rob Herring <robh+dt@kernel.org>
Subject: [RESEND PATCH v7 2/2] arm64: dts: mt8183: add cbas node under cros_ec
Date:   Fri, 14 May 2021 20:20:50 +0800
Message-Id: <20210514122051.266169-3-ikjn@chromium.org>
X-Mailer: git-send-email 2.31.1.751.gd2f1c929bd-goog
In-Reply-To: <20210514122051.266169-1-ikjn@chromium.org>
References: <20210514122051.266169-1-ikjn@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a 'cbas' device node for supporting tablet mode switch in
kukui devices.

Kukui platforms with detacheable base have an additional input
device under cros-ec, which reports SW_TABLET_MODE regarding
its base state (e.g. base flipped or detached).

Signed-off-by: Ikjoon Jang <ikjn@chromium.org>

---

Changes in v7:
- remove a label in cbas node
- fix an erratum in commit message (table --> tablet)
- dt-binding patchess merged altogether with mt8183 dts

 arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi b/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi
index ff56bcfa3370..1512605a438e 100644
--- a/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi
@@ -816,6 +816,10 @@ usbc_extcon: extcon0 {
 			compatible = "google,extcon-usbc-cros-ec";
 			google,usb-port-id = <0>;
 		};
+
+		cbas {
+			compatible = "google,cros-cbas";
+		};
 	};
 };
 
-- 
2.31.1.751.gd2f1c929bd-goog

