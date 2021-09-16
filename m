Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7607E40D45B
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Sep 2021 10:17:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234947AbhIPISu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Sep 2021 04:18:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229908AbhIPISt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Sep 2021 04:18:49 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3194DC061574;
        Thu, 16 Sep 2021 01:17:29 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id g19-20020a1c9d13000000b003075062d4daso3890756wme.0;
        Thu, 16 Sep 2021 01:17:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=H1ww3lGPcUZ1JbC+7bYQbWQsgaNUgWkADb7sAryk5jc=;
        b=A8Z3uN2lf864arVF5o7WX9EgjI9uohgDQAxPkOHuv/4ufOpnRhskoT03t0rDPCbo5i
         1W5As73lc8AYuDAAlwrrL+98tN1dawtl5CUjmwmsgLY+LysAfywze/jXDpCaYZNjGtGd
         MBnkPVZ6qGwa7FuI0VayRtjBuI3LuOB517JNjYnh/cOuvyCocZ8fctLqGdOzH9t/Phpq
         em+rujCXobpt2tOmY2YZEVdWS8np9cyifkdq9z9tof+w40O9C7F1ArYXlAHmBcplI+Nl
         XAv//XqmqxGeRLH3OjksGKFTl/fB5Bo/REoTC8gy7RtYSy+u3tVwHxdtqyk3vV4nRz6Z
         uQ/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=H1ww3lGPcUZ1JbC+7bYQbWQsgaNUgWkADb7sAryk5jc=;
        b=b+6Q1E4siZeNRyiMbyHsGvXyBwjZspbpQtbJ8e3UJY9ZnLtTEEee52xd6+6uZh65h3
         wi2hd9+DGGoCFGmpIkXNp1PN1D81NbaWMoJ+prYuzjwYVLlH9TcAKGF6sWu6CsM+UioF
         VMk7No2VfVuifH4CuYFyX2SJLiRnZ2/Ksq35O0VVSiYd8Od75F2lirWvoK1ICNPcasPF
         XLo8WpiuWFqbgA0R5gwapamYNH4e7g0QPgJV9avpCg8NiPi1QDQHnv0CceibKkT9Ml27
         z1w7q3wZWe258h7dwY/LPmIjTgy84uv3sYYL1uWQo8+4pWReKfu3B027egjAprpSZj28
         djkg==
X-Gm-Message-State: AOAM531iMUwjkgpIlp1hnL0jUO6Uw83vJ9hMmzORxnJ3rWaVyA3AMweL
        XXfqdTLz4JM+q71fXLDY6zE=
X-Google-Smtp-Source: ABdhPJwngzby5zhk6Y6v22PCQTRfp3xLylztrh6TLkn7x93W6jIB6p9DPAgGnFHTijPTxW05R4kAzw==
X-Received: by 2002:a1c:149:: with SMTP id 70mr8518758wmb.187.1631780247660;
        Thu, 16 Sep 2021 01:17:27 -0700 (PDT)
Received: from localhost ([2a01:e0a:3d3:9cc4:89bf:529b:6a06:470])
        by smtp.gmail.com with ESMTPSA id m18sm2462192wrn.85.2021.09.16.01.17.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Sep 2021 01:17:26 -0700 (PDT)
From:   roucaries.bastien@gmail.com
X-Google-Original-From: rouca@debian.org
To:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Chen-Yu Tsai <wens@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Salvatore Bonaccorso <carnil@debian.org>,
        =?UTF-8?q?Bastien=20Roucari=C3=A8s?= <rouca@debian.org>
Subject: [PATCH] [PATCH] ARM: dts: sun7i: A20-olinuxino-lime2: Fix ethernet phy-mode
Date:   Thu, 16 Sep 2021 08:17:21 +0000
Message-Id: <20210916081721.237137-1-rouca@debian.org>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bastien Roucariès <rouca@debian.org>

Commit bbc4d71d6354 ("net: phy: realtek: fix rtl8211e rx/tx delay
config") sets the RX/TX delay according to the phy-mode property in the
device tree. For the A20-olinuxino-lime2 board this is "rgmii", which is the
wrong setting.

Following the example of a900cac3750b ("ARM: dts: sun7i: a20: bananapro:
Fix ethernet phy-mode") the phy-mode is changed to "rgmii-id" which gets
the Ethernet working again on this board.

Signed-off-by: Bastien Roucariès <rouca@debian.org>
---
 arch/arm/boot/dts/sun7i-a20-olinuxino-lime2.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/sun7i-a20-olinuxino-lime2.dts b/arch/arm/boot/dts/sun7i-a20-olinuxino-lime2.dts
index 8077f1716fbc..ecb91fb899ff 100644
--- a/arch/arm/boot/dts/sun7i-a20-olinuxino-lime2.dts
+++ b/arch/arm/boot/dts/sun7i-a20-olinuxino-lime2.dts
@@ -112,7 +112,7 @@ &gmac {
 	pinctrl-names = "default";
 	pinctrl-0 = <&gmac_rgmii_pins>;
 	phy-handle = <&phy1>;
-	phy-mode = "rgmii";
+	phy-mode = "rgmii-id";
 	status = "okay";
 };
 
-- 
2.33.0

