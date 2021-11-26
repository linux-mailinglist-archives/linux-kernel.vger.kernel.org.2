Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A768745F5CA
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Nov 2021 21:25:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240637AbhKZU2N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Nov 2021 15:28:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239999AbhKZU0H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Nov 2021 15:26:07 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4983CC06174A;
        Fri, 26 Nov 2021 12:22:04 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id n33-20020a05600c502100b0032fb900951eso11492775wmr.4;
        Fri, 26 Nov 2021 12:22:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1BejTOJeuXx0KsauYDbKnEuX2+Uj/mIn82Fl6byzxj0=;
        b=WyLQcViM/fgfJEs2YDWvTFL5riGU5OyW63tZf2uXlrIOpiM1MZD7Z7INCZpnEEeboJ
         JrjoxgCgLq0wu5pz5thWAi1dTF5DXHWZhcxdtVLSaUulbrO/MJhRBRve9IEwautWOAwO
         3qEAWkn3DF+MxCd+kXmrb4MwBwbUgT/Ae2Vvjb/X3IXSWfVLOjHLXTMdgS9UCjoSoFO/
         gL2MiLV+JCoS1YyF0Qm0/KNM5gzA6ZhwbOVOIgUW5buwng8A1eQVzjOCbK0z+MrFefn5
         2KJVjBRIuAAxhNyLwT1RYZfWYWO+djHzCYm79jo1jlooJlspR/AgS7gI3Ml2y4NAcqh9
         s+wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1BejTOJeuXx0KsauYDbKnEuX2+Uj/mIn82Fl6byzxj0=;
        b=NaNBjoziuI/PYtSg2pcgxVeeftIIe16SJphNlwhMNPOOFOOMeVyCb9+p8wSsLtFGpK
         eOkmTCmuA8DyQa/ZDhwcHmIl3xls8Af1HBnQLLpdVS41HDFBFQMzYOj93sgcAn02ZX+w
         iFPzFRygKygx4OfsKg5ZjsYgWCMcHx1zWfiXFZHypnGHFaNibpMFJlB9DCZrL7Jgr51c
         X/Qz44vMU00UMzC/6iyFoZQPrcFYJwhGMmdwF/cUwi0h5A06RpJFQiB6oYnKGvw1In1O
         08tEW43MQ9udtVimWatczeqEUKRpBup05ANT24o9IJ1sQDpUI9HPGI5wycBimEeEaL0k
         Fhrg==
X-Gm-Message-State: AOAM530lZtWjT86mSgapAb8+2LYir+N2wup0PZqWmHY6QJh/Vo+cmuxr
        TGANkKSbHOxAzWZeRtZphZYjTTIJIJI=
X-Google-Smtp-Source: ABdhPJxZXL81jdxgu2l8Z2pMT9tymHke6ye10PrsS6Y0SlTeF9DXY/YcOTm6nLx2l2VvsMbGHXYpXw==
X-Received: by 2002:a7b:cc8f:: with SMTP id p15mr19148841wma.158.1637958122726;
        Fri, 26 Nov 2021 12:22:02 -0800 (PST)
Received: from debby ([2a01:e0a:a6d:a8d0:7ff4:8f61:5574:9f95])
        by smtp.gmail.com with ESMTPSA id l7sm8118475wry.86.2021.11.26.12.22.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Nov 2021 12:22:02 -0800 (PST)
From:   Romain Perier <romain.perier@gmail.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Daniel Palmer <daniel@0x0f.com>,
        Romain Perier <romain.perier@gmail.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/4] ARM: dts: mstar: Remove unused rtc_xtal
Date:   Fri, 26 Nov 2021 21:21:40 +0100
Message-Id: <20211126202144.72936-3-romain.perier@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211126202144.72936-1-romain.perier@gmail.com>
References: <20211126202144.72936-1-romain.perier@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The rtc device node use an oscillator @12Mhz right now, namely
xtal_div2. rtc_xtal is no longer used, remove it.

Signed-off-by: Romain Perier <romain.perier@gmail.com>
---
 arch/arm/boot/dts/mstar-v7.dtsi | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/arch/arm/boot/dts/mstar-v7.dtsi b/arch/arm/boot/dts/mstar-v7.dtsi
index 89ebfe4f29da..9b335ee4512c 100644
--- a/arch/arm/boot/dts/mstar-v7.dtsi
+++ b/arch/arm/boot/dts/mstar-v7.dtsi
@@ -55,13 +55,6 @@ xtal: xtal {
 			clock-frequency = <24000000>;
 		};
 
-		rtc_xtal: rtc_xtal {
-			#clock-cells = <0>;
-			compatible = "fixed-clock";
-			clock-frequency = <32768>;
-			status = "disabled";
-		};
-
 		xtal_div2: xtal_div2 {
 			#clock-cells = <0>;
 			compatible = "fixed-factor-clock";
-- 
2.33.0

