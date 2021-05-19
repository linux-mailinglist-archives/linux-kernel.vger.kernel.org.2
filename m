Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25E50389800
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 22:36:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229652AbhESUhT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 16:37:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229565AbhESUhQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 16:37:16 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29CFDC061760
        for <linux-kernel@vger.kernel.org>; Wed, 19 May 2021 13:35:56 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id p7so11623218wru.10
        for <linux-kernel@vger.kernel.org>; Wed, 19 May 2021 13:35:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6eCG6g9vnsV5mVrNbPu9Aj3xE5jJrcF1SJW4LgqoH9w=;
        b=Y5DGmtFFbz3Ryg2DZyMzNdfcry+XnVGFtjQSW4+r3SxbzZjgcd79hV607ejaeCWVM+
         nbgAZMJOL3xe2lgv3dwjHYjiq5zosKyng8KPkf86xsAlbCXnUciQfayX/wY7SEG1Os9i
         qotEYn2MPNdjsOFOxBWydl6rhGxpSeXS4DqA/Iw8odbE/NPxclZ5r6VBmSHvzAOFjlfF
         5jpWOXQKVLnOrU7FpYsCua++XmPPpzhav4NyVDKlY8XQqf9B1hXTU31i+4MQ8xrWQdcX
         2j1riyzqbNR+ABkfZkDm8YxPm1JF+8d7eb7gmyVHL+kjTGvUSRsPwAOQ/6tCwhpTVlvJ
         EwvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6eCG6g9vnsV5mVrNbPu9Aj3xE5jJrcF1SJW4LgqoH9w=;
        b=neIJw3waTeoC/+frUKL76r3XIVKZavb0B8Z7Y4DBS1oUWiLr2OJn2NhIroeA4eBwSP
         ej0O6J+tYi6+lTCHiAyaZCLiRCXPYC23f2iMbLP6W+UVNtgFm7uYPCR9aLfvifzJZmU8
         amSfyX2z9NhLY7nZQ7oJxKMhUn0ZhGuGJ3qND0f/xT98GmzdmOTdlN0qCFCRDITQhy5f
         9dSMmAaECPWTaLP0gbEhHVCF+2GSw1JeCsrrxp1EGBqRrwX3uQmEq47O9YFKtP9TbW5K
         st1Hub/eWPsDWVHExuPwW00PWnEnqWa5Z5lpXzuFWP4XELW0Nc2iHGOmj8bmiVz9xpWS
         KzfA==
X-Gm-Message-State: AOAM533NMg5C4VBSt0eLftB+W6OpjVTvN2bP2XUI8CNYKGqdEZNyrNWd
        p7NSw/79ONNVztas5ka4mPA3HQ==
X-Google-Smtp-Source: ABdhPJzESLwfBMc9nNVsU47ZKg8uSf8qzju6eU94c/V4fey4BkTdnKjPMoNoe9J6EvDojjlNgjjc3A==
X-Received: by 2002:a5d:45c6:: with SMTP id b6mr727972wrs.333.1621456554751;
        Wed, 19 May 2021 13:35:54 -0700 (PDT)
Received: from localhost.localdomain (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id y20sm7531918wmi.0.2021.05.19.13.35.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 May 2021 13:35:54 -0700 (PDT)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     airlied@linux.ie, daniel@ffwll.ch, linus.walleij@linaro.org,
        robh+dt@kernel.org, ulli.kroll@googlemail.com
Cc:     devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH v2 2/3] ARM: dts: gemini-dlink-dir-685: Remove address from display port
Date:   Wed, 19 May 2021 20:35:46 +0000
Message-Id: <20210519203547.837237-2-clabbe@baylibre.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210519203547.837237-1-clabbe@baylibre.com>
References: <20210519203547.837237-1-clabbe@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The address and reg adds no value to the port node, remove them.

Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
 arch/arm/boot/dts/gemini-dlink-dir-685.dts | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/gemini-dlink-dir-685.dts b/arch/arm/boot/dts/gemini-dlink-dir-685.dts
index cc39289e99dd..2eeb142b5464 100644
--- a/arch/arm/boot/dts/gemini-dlink-dir-685.dts
+++ b/arch/arm/boot/dts/gemini-dlink-dir-685.dts
@@ -492,8 +492,7 @@ drive0: ide-port@0 {
 		display-controller@6a000000 {
 			status = "okay";
 
-			port@0 {
-				reg = <0>;
+			port {
 				display_out: endpoint {
 					remote-endpoint = <&panel_in>;
 				};
-- 
2.26.3

