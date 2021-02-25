Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2396E325961
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Feb 2021 23:17:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233236AbhBYWP0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Feb 2021 17:15:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233121AbhBYWOl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Feb 2021 17:14:41 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D49F2C06121E
        for <linux-kernel@vger.kernel.org>; Thu, 25 Feb 2021 14:13:44 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id i14so2754661pjz.4
        for <linux-kernel@vger.kernel.org>; Thu, 25 Feb 2021 14:13:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=H5b91dJajF33xxo9l/aRFZJ84kBvFyWZYIGCDgJLm2M=;
        b=kXqumZKVap5IGXkcHq8EQRiRDEivmBp5ubI5Z5+ZC0MGFgsI/4GxHNxn9dRAtOU2WT
         SrgKxPziCADwHOxfUsSFQOY4lswFf8r3BA0lU5xgM9K5EAcRUEdg01kCsPeNk+IxqYKX
         QTAOCUFFZvkA6fEEcw4Hxmjn5iy891P29K48A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=H5b91dJajF33xxo9l/aRFZJ84kBvFyWZYIGCDgJLm2M=;
        b=rTe6FJHhjdYWUpKNPx7fJzrILh2iZvrErHRF4pd2GlciISd4t8+JXreWGP5W9TTYOM
         aMd5USDOn1ZWonJEb24vr6tjWabCIDm46/xUvw+IRUSfeanhAouR4pfX8zxPfQPAM5bP
         /O3ycPeeQ2nPZRLuyIB2A5SOJF+Z9AZjr5iJNnT8YquVDnQ1ZW43cv7+p2yBquiH4W5V
         56axvrdQvg9MPTsxBiyeo49fs2zJYcYvYrsGcpre5+8HlA/KObGNVIpFWZXBKrBz+Qma
         FTaBJdYZsaPrOGqb9GHE0/HnR/18I3frnx2/YDBg/xPEDw93l0BLCynjyQ3KZRBI3lbn
         eG7g==
X-Gm-Message-State: AOAM531HWuNz6HoUmqxrEU2Bz/qV3PdgCVoUyUdl+Gg7Zt/wRlCxJy1g
        O8n2LU4YX9lzTkno5xog7nRxAJMqUZdzTcnn
X-Google-Smtp-Source: ABdhPJzeu8QR7HJTjp9bPcxbThSTxgsYKAfEOI6xejaNIiTJcQTe1P5y+NmmdBDDdb9LouPQUshAgw==
X-Received: by 2002:a17:90a:b28a:: with SMTP id c10mr37085pjr.39.1614291224463;
        Thu, 25 Feb 2021 14:13:44 -0800 (PST)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:8414:45a5:94c4:d35d])
        by smtp.gmail.com with ESMTPSA id jt21sm6713301pjb.51.2021.02.25.14.13.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Feb 2021 14:13:44 -0800 (PST)
From:   Douglas Anderson <dianders@chromium.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Stephen Boyd <swboyd@chromium.org>,
        Alexandru M Stan <amstan@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Rob Clark <robdclark@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 05/13] arm64: dts: qcom: trogdor: Only wakeup from pen eject
Date:   Thu, 25 Feb 2021 14:13:02 -0800
Message-Id: <20210225141022.5.Ib9672bfbe639c96c85408d6f0217a2609eb0b70f@changeid>
X-Mailer: git-send-email 2.30.1.766.gb4fecdf3b7-goog
In-Reply-To: <20210225221310.1939599-1-dianders@chromium.org>
References: <20210225221310.1939599-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stephen Boyd <swboyd@chromium.org>

Configure the pen to be a wakeup source only when the pen is ejected
instead of both when the pen is ejected and inserted. This corresponds
to wake source requirements.

Signed-off-by: Stephen Boyd <swboyd@chromium.org>
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi b/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi
index 9fcb19a0501f..f3a99c801582 100644
--- a/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi
@@ -6,6 +6,7 @@
  */
 
 #include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/input/gpio-keys.h>
 #include <dt-bindings/input/input.h>
 #include <dt-bindings/regulator/qcom,rpmh-regulator.h>
 
@@ -243,6 +244,7 @@ pen_insert: pen-insert {
 			gpios = <&tlmm 52 GPIO_ACTIVE_LOW>;
 			linux,code = <SW_PEN_INSERTED>;
 			linux,input-type = <EV_SW>;
+			wakeup-event-action = <EV_ACT_DEASSERTED>;
 			wakeup-source;
 		};
 	};
-- 
2.30.1.766.gb4fecdf3b7-goog

