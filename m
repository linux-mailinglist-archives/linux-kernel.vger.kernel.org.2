Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 854B939C639
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Jun 2021 08:24:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230126AbhFEG0K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Jun 2021 02:26:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229660AbhFEG0I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Jun 2021 02:26:08 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7FBBC061766;
        Fri,  4 Jun 2021 23:24:07 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id j12so9557365pgh.7;
        Fri, 04 Jun 2021 23:24:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=r2xrOsoZZxRSqy6qqxdG6tTS5Reg+2W0VGzUs3SrOYI=;
        b=mX0ja+UyXWgWge+Nfd9JNZE2FWNPyXfhFLMZv8TiHr+JyS3IWaPGSERSU+I29OY3v6
         c8mKxeRP4OD+5RaXkbU5m1TRiQS2x8ZE4HTkZUvLc3vp+aoQ6xx0RzYDr11wGt9hrClV
         Hz8r44bIn734DK6qa97yY/2WFv1LKAGIl5lDHjNehyVuUXAaMdMKJKo1uHhDxbupjk3c
         as185e6R6/rn6rYQ48N9GnW/QjVH48BXifkEywxUoUAKxv0rzPQ+VxRP0aEuAa1k1sH4
         mOxTG5LHoSa3CW1YKBJ5+hDrrgy8DXsVTAQdyycEjm21oTzY5F57xF5mKrNx0rSN2HJs
         clgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=r2xrOsoZZxRSqy6qqxdG6tTS5Reg+2W0VGzUs3SrOYI=;
        b=VCHRsckoPx6nvANl/bq98dKxiqUYzoxGF2/ENcuEE0QK5z3DZvsZmd4WOBhnec+/Wm
         Fm31Zsdkw/cSrHGcr6a6dyVPIV8/t7RZNpEWI0fYnGFsajkhvZMVTkFN22YBv+34le6H
         BYp4QyDykeXwsop0RPyGjR4h5hu4JCKhAT9WKK/O04Q/44q3icEExt38xO1xEEQjSQKf
         W6oYnsQ5nTMNFs4lRcBV+POO8SQQRz6qdAhQLv9rtilLxiqAABmm2dug3o9g9FyZD5oH
         0MGb6C99SELzrMqiFmhYjpq4J2PsNGj88ImICYy0QN4dNJ9B6ihrz4TlOPb/paNbmeJA
         4bxQ==
X-Gm-Message-State: AOAM533IktJC/1IH08/2VsjMxy6xyvaxufMVmX2ZSgMNHsTd36DTAW8v
        P7pt2NoD0K7ZZLmed0Mt68k=
X-Google-Smtp-Source: ABdhPJyPUtXlYrM7kZKxm8T97ZgicScU6t6VgaJweoC768ycu9GYxWV/unBxwusbRTNFNUhu8chhtg==
X-Received: by 2002:aa7:9438:0:b029:2df:258e:7f10 with SMTP id y24-20020aa794380000b02902df258e7f10mr7844755pfo.79.1622874247508;
        Fri, 04 Jun 2021 23:24:07 -0700 (PDT)
Received: from localhost.localdomain (199.19.111.227.16clouds.com. [199.19.111.227])
        by smtp.gmail.com with ESMTPSA id v14sm2800870pgo.89.2021.06.04.23.24.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Jun 2021 23:24:07 -0700 (PDT)
From:   xieqinick@gmail.com
To:     robh+dt@kernel.org, narmstrong@baylibre.com, khilman@baylibre.com,
        jbrunet@baylibre.com, martin.blumenstingl@googlemail.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     nick@khadas.com, artem@khadas.com
Subject: [PATCH 6/6] arm64: dts: meson: vim2: add i2c aliases
Date:   Sat,  5 Jun 2021 14:23:13 +0800
Message-Id: <20210605062313.418343-7-xieqinick@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210605062313.418343-1-xieqinick@gmail.com>
References: <20210605062313.418343-1-xieqinick@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nick Xie <nick@khadas.com>

Add i2c aliases for Khadas VIM2.

Signed-off-by: Nick Xie <nick@khadas.com>
---
 arch/arm64/boot/dts/amlogic/meson-gxm-khadas-vim2.dts | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gxm-khadas-vim2.dts b/arch/arm64/boot/dts/amlogic/meson-gxm-khadas-vim2.dts
index 70488ae45876..3f3ea65df665 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxm-khadas-vim2.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxm-khadas-vim2.dts
@@ -21,6 +21,8 @@ aliases {
 		serial2 = &uart_B;
 		serial3 = &uart_C;
 		serial4 = &uart_AO_B;
+		i2c0 = &i2c_A;
+		i2c1 = &i2c_B;
 	};
 
 	chosen {
-- 
2.25.1

