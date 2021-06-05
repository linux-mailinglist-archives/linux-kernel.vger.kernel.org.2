Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0195C39C543
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Jun 2021 04:50:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231693AbhFECwM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Jun 2021 22:52:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230169AbhFECwL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jun 2021 22:52:11 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32969C061766;
        Fri,  4 Jun 2021 19:50:11 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id u7so5600659plq.4;
        Fri, 04 Jun 2021 19:50:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=r2xrOsoZZxRSqy6qqxdG6tTS5Reg+2W0VGzUs3SrOYI=;
        b=AUs5oDhWOgH3j75/bYJMw3Ta5grxLtUqlXTe8f5iQOvQgFiVMw4K61XSV2d7VRWm4D
         68hzP0TORy5QlplMi39o8F/M48Ve7+b9Dwmd1e2IZgIOewHAiRE+7A9UmXjBZvKJBJX7
         LetOihzpF7Y8VPLlCwHVwr90LBQHp//6lq8B7i3EgD1SnYZfk/VeBfVTetoiFAVNnflu
         oAThQosTxdqH+la2a6STsXsGVerheUTghnJxZGT0S53/Oe1gbv+HqdZLgUzI2picxgMK
         94okBiUToyx5wtj8DzjztKJ1+4p/IBFMqLXTzQq6efoVeVl0FidpuGEeonuSsvg1jl/C
         hOTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=r2xrOsoZZxRSqy6qqxdG6tTS5Reg+2W0VGzUs3SrOYI=;
        b=bq+H4RlqyoHBn3RC9Uup9RNA0eh7SbCdUcS2OntnK9hFb/Kbj26Ue8iCzXc8+WL5FH
         XhujecDzuJRd+aUU6nw4Jr7EUwR6POic9PjK7pPDNPyKglWefdR5J9Wn/2Rb7PygdYJJ
         THEQzmmRWjIovcsdzTPIby0zgUp+OAztp/Hmup5mrRehCzrgPlxIsEb72MVTCtDYL0gl
         ooNxofTO1UD/QabZw8bNUCAaoxuyzLgeMsSNWVuYDQWuTojEuKdGjWNMbGlEnbjRRtde
         dluIyfDw+z9CgmWoaYYTKOF/DgxGydvoLKmQJctIv11imUhgmzbZcUegiz39+mQf5xSL
         /QUg==
X-Gm-Message-State: AOAM5335qeoKQV23y4yjOtdJBdl00dFzuXoy66JwMt/kXT6s2tlRD52w
        Oo2GNgsspEVZGd7uFf/ZTyI=
X-Google-Smtp-Source: ABdhPJzIWy4lPBzx8d5mV5bRpCtxADLwbvERTzzDv1SGcyRQxQ53XODgwEZmkANq0TJBXonvIH812Q==
X-Received: by 2002:a17:90a:4e0b:: with SMTP id n11mr8031071pjh.155.1622861410777;
        Fri, 04 Jun 2021 19:50:10 -0700 (PDT)
Received: from localhost.localdomain (199.19.111.227.16clouds.com. [199.19.111.227])
        by smtp.gmail.com with ESMTPSA id g19sm2630875pfj.138.2021.06.04.19.50.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Jun 2021 19:50:10 -0700 (PDT)
From:   xieqinick@gmail.com
To:     robh+dt@kernel.org, narmstrong@baylibre.com, khilman@baylibre.com,
        jbrunet@baylibre.com, martin.blumenstingl@googlemail.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     nick@khadas.com, artem@khadas.com
Subject: [PATCH] arm64: dts: meson: vim2: add i2c aliases
Date:   Sat,  5 Jun 2021 10:50:03 +0800
Message-Id: <20210605025003.410142-1-xieqinick@gmail.com>
X-Mailer: git-send-email 2.25.1
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

