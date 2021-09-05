Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5850D40115C
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Sep 2021 21:26:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237538AbhIET1k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Sep 2021 15:27:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233945AbhIET1j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Sep 2021 15:27:39 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CD90C061575;
        Sun,  5 Sep 2021 12:26:36 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id i6so6370886edu.1;
        Sun, 05 Sep 2021 12:26:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qlez6w9+Xry8jtHHgqQjUNA5ndA2CrnxtsKlEHI62vo=;
        b=Kk/FIIAPqgwUFLerUyXZRmwCq/E48RR3rZJJbFMatB2+kiS55ufkQAFCmMyqCpJkN+
         pWbW/nF/nEG+jiOT71kb9y2VmCtYYrWYumDW2+MBaQtdXCX5wypLEWAp/tJHv+AFAYT/
         p4g2uJefZAs+3xUNfrNNByfmbZKDhLsS+Ugduj4XkEzM74NY+WIyNqLvgaJ9t26TlYsH
         nGtJO3ZuXY3c9AA7KNb+FFRJlFFSIiOXQbHqm4KHSablhtphox4wIMzvBoA1TcLHNazP
         1strZGPRX9ng9BBqe3Y7k15QMJBy2FMG9CTgc0YvU1KVWCMfJaRbhZlnZrzcW2qlxBnM
         ZiSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qlez6w9+Xry8jtHHgqQjUNA5ndA2CrnxtsKlEHI62vo=;
        b=VbNjZnQpNk/6ky4RZ1z/ii1vk2TzFzBErPSpiOkjsG6TuvRLTYQqyabn7Mz1PkZw4i
         1HEdJJE8HSIrrEt2w8phiVa9jpmlxf+Qxn0KxnJU2L7AGkC/Q77EN5Ob1xqORF2xMwdI
         rJ6JEUzziz59sOIKn9V9iiRBVuakfU1Daa0WxnlNEJ9SvbQriEmF+ugO6JiDLIIgckvP
         KhXvceuFA8daby6KyONeKA1v4o9OV8xca8izIb0pbTNsAxobPofBFLmrDlom/RzKy7he
         nhvdWQPb89DLdsRjgviFL/vCrywCfumyI0k8uEazT4Xk61yblYTUgzk33MXHFtBuUQgS
         ULBA==
X-Gm-Message-State: AOAM533XQY88YKh5vYVHMzdqaj+wD8V9E8Tg60iRbH2OXZWVwfBck8uY
        c4K6xAysYXe1quhJd+kA9ik=
X-Google-Smtp-Source: ABdhPJwKkZh7U2OnpEzLD2FkeUDsXAtatl/gJKYiiF2lhr2i3q4HMdaUGKVSitTapNvRGbtX/oZvRA==
X-Received: by 2002:aa7:d99a:: with SMTP id u26mr10016178eds.297.1630869993740;
        Sun, 05 Sep 2021 12:26:33 -0700 (PDT)
Received: from kista.localdomain (cpe-86-58-29-253.static.triera.net. [86.58.29.253])
        by smtp.gmail.com with ESMTPSA id n13sm3238992edq.91.2021.09.05.12.26.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Sep 2021 12:26:33 -0700 (PDT)
From:   Jernej Skrabec <jernej.skrabec@gmail.com>
To:     mripard@kernel.org, wens@csie.org
Cc:     robh+dt@kernel.org, codekipper@gmail.com, peron.clem@gmail.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
        Jernej Skrabec <jernej.skrabec@gmail.com>
Subject: [PATCH] arm: dts: sunxi: h3/h5: Fix I2S2 node
Date:   Sun,  5 Sep 2021 21:26:28 +0200
Message-Id: <20210905192628.206061-1-jernej.skrabec@gmail.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I2S2 controller has RX DMA channel according to documentation.

Add it.

Fixes: cd7c897821a0 ("arm: dts: sunxi: h3/h5: Add I2S2 node")
Signed-off-by: Jernej Skrabec <jernej.skrabec@gmail.com>
---
 arch/arm/boot/dts/sunxi-h3-h5.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/sunxi-h3-h5.dtsi b/arch/arm/boot/dts/sunxi-h3-h5.dtsi
index c7428df9469e..bd26f2059220 100644
--- a/arch/arm/boot/dts/sunxi-h3-h5.dtsi
+++ b/arch/arm/boot/dts/sunxi-h3-h5.dtsi
@@ -670,9 +670,9 @@ i2s2: i2s@1c22800 {
 			interrupts = <GIC_SPI 15 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&ccu CLK_BUS_I2S2>, <&ccu CLK_I2S2>;
 			clock-names = "apb", "mod";
-			dmas = <&dma 27>;
+			dmas = <&dma 27>, <&dma 27>;
 			resets = <&ccu RST_BUS_I2S2>;
-			dma-names = "tx";
+			dma-names = "tx", "rx";
 			status = "disabled";
 		};
 
-- 
2.33.0

