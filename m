Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74473327E73
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Mar 2021 13:37:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235092AbhCAMhK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Mar 2021 07:37:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235069AbhCAMhI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Mar 2021 07:37:08 -0500
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3902C06178B
        for <linux-kernel@vger.kernel.org>; Mon,  1 Mar 2021 04:36:22 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id c16so308144ply.0
        for <linux-kernel@vger.kernel.org>; Mon, 01 Mar 2021 04:36:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0x0f.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=536xRWNL7jknD9IRPbTVC2QcHZZ+m5eHrkYF4PRPpVs=;
        b=S8bV2V8DbZz51yB79NHw1Qy5wgklnsXO4bpxwk/7Yo8G5e9J+77QaPbiJbTcvc+dlt
         PMWdcbW2I+A1CUoKWv94xaPmPurGfHghp37tKPxyWJYu2jiT1maVOJXVjuit63g2TnO1
         jcPvcbMs/uP1VXjWXhM7ZU/wuUToOBgqCOeM8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=536xRWNL7jknD9IRPbTVC2QcHZZ+m5eHrkYF4PRPpVs=;
        b=ju6cE2wcjhWoJhNQTeA3hLrOCxrNy1jVzcvXaIUfKLG86Z4RaMqPWZ1Tug7ojWI+aV
         /1OilZBFQ4m7X2rfF5RwE4aX+2VYbrNgIROxMWEHVV6Q+E/bkCe4XfOatB4Cp7nVgmp4
         KVh1KbF70tOpuZHg/zNcTBBzDbR0WIV1z3jteJVaUnktZ+2Fo7gRnz7mzNhgLWqUbMVq
         js28o7Oy3sppqhRVnOTMGsKlXSCsB3TdpLlL+Z/4Aod6PWN8+/VsWLVcqLcFWOC9GVyI
         bRVR1TCGeVNhVQWxP+Us+ANpBGByetTeapDqQ/5P+CO0xUW/l44U/hVodYqZz1rjbhhS
         29Sg==
X-Gm-Message-State: AOAM530pTNH65RVGvocvqhPPYdTk1rX4DKiwXM1AhmRFf+YYHIXHwE+k
        9FQ6/+ofblYZaQ4+UxrNU4hUzQ==
X-Google-Smtp-Source: ABdhPJxmG3O7GKhc9qGTw5SpHoWvJ1q6BkDMP4KXQkRz8Z1MS08I62eDj0MAiABHUQcXvEmu/Q8wlQ==
X-Received: by 2002:a17:90a:6c22:: with SMTP id x31mr17844508pjj.213.1614602182273;
        Mon, 01 Mar 2021 04:36:22 -0800 (PST)
Received: from shiro.work (p345188-ipngn200408sizuokaden.shizuoka.ocn.ne.jp. [124.98.97.188])
        by smtp.googlemail.com with ESMTPSA id 8sm18130928pfp.171.2021.03.01.04.36.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Mar 2021 04:36:22 -0800 (PST)
From:   Daniel Palmer <daniel@0x0f.com>
To:     soc@kernel.org
Cc:     arnd@kernel.org, olof@lixom.net, w@1wt.eu,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Daniel Palmer <daniel@0x0f.com>
Subject: [PATCH 3/3] ARM: mstar: Add mpll to base dtsi
Date:   Mon,  1 Mar 2021 21:35:42 +0900
Message-Id: <20210301123542.2800643-4-daniel@0x0f.com>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210301123542.2800643-1-daniel@0x0f.com>
References: <20210301123542.2800643-1-daniel@0x0f.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All of the currently known MStar/SigmaStar ARMv7 SoCs have at least
one MPLL and it seems to always be at the same place so add it to
the base dtsi.

Signed-off-by: Daniel Palmer <daniel@0x0f.com>
---
 arch/arm/boot/dts/mstar-v7.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/mstar-v7.dtsi b/arch/arm/boot/dts/mstar-v7.dtsi
index 889c3804c251..075d583d6f40 100644
--- a/arch/arm/boot/dts/mstar-v7.dtsi
+++ b/arch/arm/boot/dts/mstar-v7.dtsi
@@ -6,6 +6,7 @@
 
 #include <dt-bindings/interrupt-controller/irq.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
+#include <dt-bindings/clock/mstar-msc313-mpll.h>
 
 / {
 	#address-cells = <1>;
@@ -124,6 +125,13 @@ l3bridge: l3bridge@204400 {
 				reg = <0x204400 0x200>;
 			};
 
+			mpll: mpll@206000 {
+				compatible = "mstar,msc313-mpll";
+				#clock-cells = <1>;
+				reg = <0x206000 0x200>;
+				clocks = <&xtal>;
+			};
+
 			gpio: gpio@207800 {
 				#gpio-cells = <2>;
 				reg = <0x207800 0x200>;
-- 
2.30.1

