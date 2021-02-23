Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D83653225D4
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Feb 2021 07:23:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231806AbhBWGW0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Feb 2021 01:22:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231626AbhBWGUj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Feb 2021 01:20:39 -0500
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1537CC0617AB
        for <linux-kernel@vger.kernel.org>; Mon, 22 Feb 2021 22:19:23 -0800 (PST)
Received: by mail-pf1-x42d.google.com with SMTP id u26so2188568pfn.6
        for <linux-kernel@vger.kernel.org>; Mon, 22 Feb 2021 22:19:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0x0f.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=F8U0f9JNY8hRMi39WPkD4ASf4aAhKNDuZAqXYiDMPnc=;
        b=OdafbEs6apuScIxtpkC5hbqj2hdH2BgCZ/p6xtr5NI/8lYsH/8jqbSc51l3+G+oxdm
         /HTWGZWDK2BndoVcYAnXd0cjugjc+PqdTeqTCSYl4njHNY1e7RWaWUsyGsoI42armolR
         q0pkImbhFou/3iRgFAQDzcMf3nJvz1jrtqflU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=F8U0f9JNY8hRMi39WPkD4ASf4aAhKNDuZAqXYiDMPnc=;
        b=MD1txmu+ytfg3jUrbUDcw8mrLeu30c4MUc8PFFR9tmcVELExz/k5/WPUVl6dpDpk8P
         LV+zG62OCxKnRw5xYRcrpovfS5qupDytQwaoSinGdzVg7mFu0IR3W7gz+z+NlaCH0Fvh
         E4Og48vxfDoDWtZ3JdGQWA+6ux32uf9IQpbhXOknQkNXHnK98K4f0XfZGpqXMmkfc27T
         MRpgkErKUL7He9FK2e6W+9GaJjtaq1jPOnFvGzAede5QF81dIoFMtT5nnrW867TgwG++
         JUaLIkwTZWiZZJhUHTWcayfbt2BaTZsLybufuQ43YXmQwEuLfKaWl0BHnXB/+wtH7sZz
         jnbg==
X-Gm-Message-State: AOAM532UAsNZVeB+ZzpX19q0rjVEL6f110t8Br+kXOEt5Rgdk+omSvc1
        ZLinBMoS9Ucy9+I64JaYJTtXJw==
X-Google-Smtp-Source: ABdhPJxc6Ul/6qH9CfSEt6s256nfdmu2EHwQomQ8gqEAsR960hE9xL7M7oKKwskSClxqWd9Szf2f+A==
X-Received: by 2002:a62:dd01:0:b029:1ed:6b67:1377 with SMTP id w1-20020a62dd010000b02901ed6b671377mr938433pff.48.1614061162681;
        Mon, 22 Feb 2021 22:19:22 -0800 (PST)
Received: from shiro.work (p345188-ipngn200408sizuokaden.shizuoka.ocn.ne.jp. [124.98.97.188])
        by smtp.googlemail.com with ESMTPSA id n10sm20135169pgk.91.2021.02.22.22.19.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Feb 2021 22:19:22 -0800 (PST)
From:   Daniel Palmer <daniel@0x0f.com>
To:     devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        soc@kernel.org, sboyd@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        w@1wt.eu, Daniel Palmer <daniel@0x0f.com>
Subject: [PATCH 4/8] ARM: mstar: Link cpupll to cpu
Date:   Tue, 23 Feb 2021 15:18:26 +0900
Message-Id: <20210223061830.1913700-5-daniel@0x0f.com>
X-Mailer: git-send-email 2.30.0.rc2
In-Reply-To: <20210223061830.1913700-1-daniel@0x0f.com>
References: <20210223061830.1913700-1-daniel@0x0f.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The CPU clock is sourced from the CPU PLL.
Link cpupll to the cpu so that frequency scaling can happen.

Signed-off-by: Daniel Palmer <daniel@0x0f.com>
---
 arch/arm/boot/dts/mstar-v7.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/mstar-v7.dtsi b/arch/arm/boot/dts/mstar-v7.dtsi
index d323c1a3f3c2..4d9991294f7c 100644
--- a/arch/arm/boot/dts/mstar-v7.dtsi
+++ b/arch/arm/boot/dts/mstar-v7.dtsi
@@ -21,6 +21,8 @@ cpu0: cpu@0 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a7";
 			reg = <0x0>;
+			clocks = <&cpupll>;
+			clock-names = "cpuclk";
 		};
 	};
 
-- 
2.30.0.rc2

