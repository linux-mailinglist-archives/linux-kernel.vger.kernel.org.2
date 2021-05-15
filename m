Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32B9B3819C7
	for <lists+linux-kernel@lfdr.de>; Sat, 15 May 2021 18:12:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233325AbhEOQN6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 May 2021 12:13:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233130AbhEOQNx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 May 2021 12:13:53 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 044E9C061573;
        Sat, 15 May 2021 09:12:39 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id q6so1354084pjj.2;
        Sat, 15 May 2021 09:12:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YqzS2k9CSDqK+D/uOKw2fLlOXUMKJ5K/xpW+9plJQSE=;
        b=UnIUQiZva1bvEo5q2XQH41xuj8+PdS9a4uufbKm3KycnqFH2EYjC1ZXdeJl02dOtS1
         sHH9P0k45F0R+hT9Dup3dhf9VJB8w/uDEZe+5VLBjotN5mYSwqXGt/D/3l1KJZnxDZeM
         l9yPh5aZJm0QCktFILuuzBg68K0e22EKlnaHGGYrhiGU1nI6jxhB+3M5cdptnM2KPcuQ
         f3M9lMCsiPa7dt8+cQsot5JRZKJW+FfjCRHlrA7kuZkJzFiZjSk6Vj+wrVZbSpk7R5TL
         A05m2h+Zy0mfIUK6VIi0ESDST0mvkA5mMyyiU5637zvRgUtUul6DSdt/UIDX20VJTuZi
         K4tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YqzS2k9CSDqK+D/uOKw2fLlOXUMKJ5K/xpW+9plJQSE=;
        b=DvXTxj1YNrfabhkyFVwzjSTUGlkgDQ29XaWeelIV19yFXLR+nLt5IL3fgYDsmILEyS
         sgkeMxHTmYOsl+DHFjXegH5CYSgTUF4Z7ftL/4M6y5BGe1/Bn8Dyy4cNwJNcRJnGCjwI
         i3cQb0mU9HnX77Hq4MMP3hMQcP04O9gnnCUG2Ns6pduOA7ZQr5CVhP7JWVDtd7O9ais+
         61ao1FsmZQZc50v2z4x182HBYrnDYfyNjCOtmL0zsH2PqGVhC00RHSu13vnz9r6b9+H4
         jHlQjciJeljAsHH66ITmXPaC6rQHNU9xRVbI8G75Jr8GS2MpyIxH24yDeEbih5MotxMB
         AP8Q==
X-Gm-Message-State: AOAM533wsTniH1xaY/kjiOHgkWlnCTaDXWbGba8m07FQ+/UNpZemNtc+
        eQyfY14tsI/dyVCooYOyoPs=
X-Google-Smtp-Source: ABdhPJxvWalYWkIOidt08fNZrWS28bJKGsBHpmcSUKVS8ibdE8Mw007MHOdqvx/BiqExjk95xSPfkA==
X-Received: by 2002:a17:902:aa42:b029:ee:f55a:b2c1 with SMTP id c2-20020a170902aa42b02900eef55ab2c1mr51494018plr.15.1621095158649;
        Sat, 15 May 2021 09:12:38 -0700 (PDT)
Received: from localhost.localdomain ([103.215.193.72])
        by smtp.googlemail.com with ESMTPSA id kk7sm8258194pjb.16.2021.05.15.09.12.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 May 2021 09:12:38 -0700 (PDT)
From:   kyawswarhtun <server1.kst@gmail.com>
To:     server1.kst@gmail.com
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] Signed-off-by: kyawswarhtun <server1.kst@gmail.com> Adding Custom device tree to kernel
Date:   Sat, 15 May 2021 22:42:26 +0630
Message-Id: <20210515161226.11884-1-server1.kst@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

---
 arch/arm/boot/dts/Makefile | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 0e1c0aeefa69..a7bb8df0a887 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -15,6 +15,9 @@ dtb-$(CONFIG_ARCH_BCM2835) += \
 	bcm2711-rpi-400.dtb \
 	bcm2710-rpi-cm3.dtb \
 	bcm2711-rpi-cm4.dtb
+	
+dtb-$(CONFIG_ARCH_BCM2835) += \
+	+ bcm2711-rpi-4-b-custom.dtb
 
 dtb-$(CONFIG_ARCH_ALPINE) += \
 	alpine-db.dtb
-- 
2.25.1

