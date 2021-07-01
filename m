Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60C4F3B9381
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jul 2021 16:41:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232521AbhGAOnz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jul 2021 10:43:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230100AbhGAOnv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jul 2021 10:43:51 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC8CAC061764;
        Thu,  1 Jul 2021 07:41:20 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id df12so8796032edb.2;
        Thu, 01 Jul 2021 07:41:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=AvF+6Thjc7VS3d+lH/xoSpjcWaqN37c3IWH+gDSK5LE=;
        b=b25zxcDyLu1iUJc6dO4ans9rCu/b5OwLrgjWCInEg2cFxRJDk0vwYmxXLiTe0E4zdA
         MJ3wLBe0PRmgqcmjhjolXhI9GoDJrCagKYEm6g1A2Kz7TVOTlCe0VE+C9Z0W9hmKWYEx
         12MwmnvHKrlJHOaCNNBJAmMMAqMkns+LgZnYOSt7b4zeGt1SSJ1GCg437LqysbDtAbvq
         QH4nvZ4PJdu367gTTj88J1EIJEOVOm1cOtTc9wDSQz/owet6wQSxaH+pW/pF82V5Vuqi
         Mko7+/liayHEcpCg3yYutTAlcaVo7R6bXh+qpjwavy1VkYAippICanszMPLiY6wlRrzb
         xC1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=AvF+6Thjc7VS3d+lH/xoSpjcWaqN37c3IWH+gDSK5LE=;
        b=b6nV8OffUlJhze2dTzmwS/q5jvvVsg0AJEuZ/Mug+HU04VVsvqnzlMKXOtTJRIjCWF
         ANvIpYrBIv2FlIQSI2F+dtjF8f0JTEIbOg3CvtBd3tBxY0j02PvNKWpyIh+Gt+eyLfg0
         ucFMYCFZnK9/eCGy8dZrDEnmZmB1/7IzNiCINIukJXB2xk0Zo8lUq3Tt9cf7nV7iOqts
         4+prsa1xAj7Nk0SB0t/jYlkI5QYrDwOs5uxwSFbsywtiKLJ3YsdhDrG8JvWRnZplgXgP
         jrjlthgV11i9ZYdTVYnNoAAvXLPW/JEDUa1LXF4iq6OeZ22yKjthk90tc/cBPXeOdMeM
         fPVQ==
X-Gm-Message-State: AOAM533aH1Y2H6b7JyXS2ZavcgcaY1XNRAOqCZ41QDIeHCwHHUlLnPpI
        xAESINnDhO6Et2T9mEHpjiYmmeVnNNsShA==
X-Google-Smtp-Source: ABdhPJw+7B3axxOsOx75pV9gDw2Bqed7PttXMKPft6o0SQ5cklKiVayLhjUPf/7+qX9RUvRJzGKFmg==
X-Received: by 2002:a05:6402:2681:: with SMTP id w1mr181454edd.275.1625150479387;
        Thu, 01 Jul 2021 07:41:19 -0700 (PDT)
Received: from debian.home (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id a8sm2239ejx.99.2021.07.01.07.41.18
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 01 Jul 2021 07:41:19 -0700 (PDT)
From:   Johan Jonker <jbx6244@gmail.com>
To:     heiko@sntech.de
Cc:     robh+dt@kernel.org, linux-rockchip@lists.infradead.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] arm64: dts: rockchip: remove ddc-i2c-scl-* properties from rk3318-a95x-z2.dts
Date:   Thu,  1 Jul 2021 16:41:10 +0200
Message-Id: <20210701144110.12333-2-jbx6244@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20210701144110.12333-1-jbx6244@gmail.com>
References: <20210701144110.12333-1-jbx6244@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ddc-i2c-scl-* properties in the hdmi node are
not in use in the mainline kernel, so remove them.

Reported-by: Alex Bee <knaerzche@gmail.com>
Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
 arch/arm64/boot/dts/rockchip/rk3318-a95x-z2.dts | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3318-a95x-z2.dts b/arch/arm64/boot/dts/rockchip/rk3318-a95x-z2.dts
index d41f786b2..43c928ac9 100644
--- a/arch/arm64/boot/dts/rockchip/rk3318-a95x-z2.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3318-a95x-z2.dts
@@ -193,8 +193,6 @@
 };
 
 &hdmi {
-	ddc-i2c-scl-high-time-ns = <9625>;
-	ddc-i2c-scl-low-time-ns = <10000>;
 	status = "okay";
 };
 
-- 
2.11.0

