Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A4A03225D1
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Feb 2021 07:23:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231786AbhBWGWE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Feb 2021 01:22:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231605AbhBWGUf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Feb 2021 01:20:35 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7F38C0617A7
        for <linux-kernel@vger.kernel.org>; Mon, 22 Feb 2021 22:19:20 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id s16so9205703plr.9
        for <linux-kernel@vger.kernel.org>; Mon, 22 Feb 2021 22:19:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0x0f.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WvzkCjZyptzDnW1uepsiXb6ybrsE6A8U5lzjXZF4NH4=;
        b=DeXXljYGddSCbpsw5yQZDdWWq/dbOTy0CmpXadmiPDNqrp0kPHRgRzwK11zwiGd6AO
         BY+r+BrMSNGMhKk+KRhiTLh2ke5g/iRd1c0XY2bJIWXOC/JSLO4AUt9qWVD5qNlZIcOE
         vlc8lAkWXzdwQkm1q3G4APE7sDzXfl4MycAic=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WvzkCjZyptzDnW1uepsiXb6ybrsE6A8U5lzjXZF4NH4=;
        b=S+2KUHX5Ot1zMm4BhDAwJQgybf5rmGrx7bFLIRzrwnsHhdDF3G6LBsO8f7W1/+Y/eW
         9Ehgk19dxujM3xjPrDBF4+LE6Yfqfi3X8szvnDIb2Z+NMLkssxAfQddre4WRcnSe+LT6
         wBI7zzn+E4SuGy8qRhzjY/KcFT5psAPQd+T4NtgrEhCqpxKEa6jd3YQHkMtXvQFfHBMg
         7Xd5rNRZD6Y+qEU/3U834enxtdOMW1XFnT/cfWcECDfXz+xtUSJ0aj4wE0eklkLSwleX
         ZTJoYcvIuMxAM6u5YE4k3EfoL4/seq17vRHvRriaR0j2a+Eadg2Cqj6j5R5clZ52FxW3
         6ERQ==
X-Gm-Message-State: AOAM531Y7KguUrEwr8cGd6DakHzSn59OUb85lsfYTdrwAKuTmDg3vFhd
        YUs0ezyoWf5PA5BcfcJbA7dLB0Uwn9diPg==
X-Google-Smtp-Source: ABdhPJzUFcIDoQ53XoBGFCZHB+j9nJd4ObgYI5HbP5VqqkuvxkGhU56VmEE/a/ZFZLF7fjsQVyhI2Q==
X-Received: by 2002:a17:90a:ea88:: with SMTP id h8mr27156943pjz.154.1614061160369;
        Mon, 22 Feb 2021 22:19:20 -0800 (PST)
Received: from shiro.work (p345188-ipngn200408sizuokaden.shizuoka.ocn.ne.jp. [124.98.97.188])
        by smtp.googlemail.com with ESMTPSA id n10sm20135169pgk.91.2021.02.22.22.19.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Feb 2021 22:19:20 -0800 (PST)
From:   Daniel Palmer <daniel@0x0f.com>
To:     devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        soc@kernel.org, sboyd@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        w@1wt.eu, Daniel Palmer <daniel@0x0f.com>
Subject: [PATCH 3/8] ARM: mstar: Add cpupll to base dtsi
Date:   Tue, 23 Feb 2021 15:18:25 +0900
Message-Id: <20210223061830.1913700-4-daniel@0x0f.com>
X-Mailer: git-send-email 2.30.0.rc2
In-Reply-To: <20210223061830.1913700-1-daniel@0x0f.com>
References: <20210223061830.1913700-1-daniel@0x0f.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All MStar/SigmaStar ARMv7 SoCs have the CPU PLL at the same
place so add it to the base dtsi.

Signed-off-by: Daniel Palmer <daniel@0x0f.com>
---
 arch/arm/boot/dts/mstar-v7.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/mstar-v7.dtsi b/arch/arm/boot/dts/mstar-v7.dtsi
index 075d583d6f40..d323c1a3f3c2 100644
--- a/arch/arm/boot/dts/mstar-v7.dtsi
+++ b/arch/arm/boot/dts/mstar-v7.dtsi
@@ -132,6 +132,13 @@ mpll: mpll@206000 {
 				clocks = <&xtal>;
 			};
 
+			cpupll: cpupll@206400 {
+				compatible = "mstar,msc313-cpupll";
+				reg = <0x206400 0x200>;
+				#clock-cells = <0>;
+				clocks = <&mpll MSTAR_MSC313_MPLL_DIV2>;
+			};
+
 			gpio: gpio@207800 {
 				#gpio-cells = <2>;
 				reg = <0x207800 0x200>;
-- 
2.30.0.rc2

