Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0B113CCBB8
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jul 2021 02:17:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233941AbhGSAUs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Jul 2021 20:20:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233898AbhGSAUm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Jul 2021 20:20:42 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81FDCC061762;
        Sun, 18 Jul 2021 17:17:42 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id w15so17276469pgk.13;
        Sun, 18 Jul 2021 17:17:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=1gtBV11Yp08tX+bShNS4fOnnqi4rnWJMiZDXxIw07HY=;
        b=VHIRZh80EZf7ljdAEYZJc0XzORChQ/oS9ZpcsfIKq1C/zPibRc+JifbI5VPYrZqMxc
         0Ev+RVv8VlX2fvkd/cSWPD58Hiq5Allr5Jek78yxMeWS2zYElE8vwHdeDVfrkYZMWV+9
         ITrJ3bh0iS37tFEEyxDfyqeiykd3dj9rx6ny7Y4ZaNqQAVZ5gQJPQZsihufJyqf0lTdD
         VodM6HwNI7q6N4BKT0k1y+nNBpEpkhcIbq/ELbvcD888J6yXGhHGFhAs+NrFS8ANuTOy
         +diZOovi1zxJQyePsHgwz1auOl7gjpkqWIc/vXlvWPZTWorQI70A90ILBeN6oGk+jkwI
         4JOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=1gtBV11Yp08tX+bShNS4fOnnqi4rnWJMiZDXxIw07HY=;
        b=jxYqRsVRqeF3h7eHQCVrDmLpuFeTT1w2lBwVX3ahn2y2Atx1EwaBrQg8zMEvLe/Krd
         8s9BBx/zQT3XkgAAAsdJgxBuBw4B/Nigz0eJ1i1Mp1ipFYgnQYI17E8tnw+c6N82Q8gZ
         ZPPBHa+5adNBqQmPO7DNir8klzSX8kRTA/W84TQau+MXoiArQM+fT8PX8OyUA259NmLc
         LPwN6tGgcBCqvMY+1WMBnPeGi7dil5ooLZRZjwGm+qZUdUo2EScPz/LCS6TiOXo1Illz
         bRXwZ8yd8RTcs+LOvJu30Zw5ZfQQre3p/WkW8o6YfVSbNaEZ6JAhk04KNB9ZVhjYXlRD
         XgtQ==
X-Gm-Message-State: AOAM530xemPiKIH+oPJlyT97Raii2ZXIM5B/P6NOMmNKSLCbqxctzgTC
        CkpCR4Rwzu1G/L5uv+KL7Jw=
X-Google-Smtp-Source: ABdhPJziOmNCGHJ54lIjSTicoJLCkd9r6laOAsYHbZkU5k7hWg+BhWm5brJrvi3bGNBreHWhTzmaFA==
X-Received: by 2002:aa7:8058:0:b029:332:9da3:102d with SMTP id y24-20020aa780580000b02903329da3102dmr23071284pfm.21.1626653861877;
        Sun, 18 Jul 2021 17:17:41 -0700 (PDT)
Received: from taoren-ubuntu-R90MNF91.thefacebook.com (c-73-252-146-110.hsd1.ca.comcast.net. [73.252.146.110])
        by smtp.gmail.com with ESMTPSA id x7sm1059847pfn.70.2021.07.18.17.17.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Jul 2021 17:17:41 -0700 (PDT)
From:   rentao.bupt@gmail.com
To:     Rob Herring <robh+dt@kernel.org>, Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        openbmc@lists.ozlabs.org, taoren@fb.com
Cc:     Tao Ren <rentao.bupt@gmail.com>
Subject: [PATCH 4/4] ARM: dts: aspeed: wedge100: Enable ADC channels
Date:   Sun, 18 Jul 2021 17:17:24 -0700
Message-Id: <20210719001724.6410-5-rentao.bupt@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210719001724.6410-1-rentao.bupt@gmail.com>
References: <20210719001724.6410-1-rentao.bupt@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tao Ren <rentao.bupt@gmail.com>

Enable the ADC voltage sensoring channels used by Wedge100.

Signed-off-by: Tao Ren <rentao.bupt@gmail.com>
---
 arch/arm/boot/dts/aspeed-bmc-facebook-wedge100.dts | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed-bmc-facebook-wedge100.dts b/arch/arm/boot/dts/aspeed-bmc-facebook-wedge100.dts
index 39c6be91d53f..584efa528450 100644
--- a/arch/arm/boot/dts/aspeed-bmc-facebook-wedge100.dts
+++ b/arch/arm/boot/dts/aspeed-bmc-facebook-wedge100.dts
@@ -12,6 +12,11 @@
 		stdout-path = &uart3;
 		bootargs = "console=ttyS2,9600n8 root=/dev/ram rw";
 	};
+
+	ast-adc-hwmon {
+		compatible = "iio-hwmon";
+		io-channels = <&adc 5>, <&adc 6>, <&adc 7>, <&adc 8>, <&adc 9>;
+	};
 };
 
 &wdt2 {
-- 
2.17.1

