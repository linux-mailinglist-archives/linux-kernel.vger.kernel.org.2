Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42672340282
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 10:55:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229818AbhCRJzH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 05:55:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229640AbhCRJzB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 05:55:01 -0400
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76EB7C06174A;
        Thu, 18 Mar 2021 02:55:00 -0700 (PDT)
Received: by mail-qt1-x82b.google.com with SMTP id h7so3577597qtx.3;
        Thu, 18 Mar 2021 02:55:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vFSXhzA4lUZdcudxTZTWEXkrKRPu4vpjtPxZiKe5AV8=;
        b=nWIFzWcDyA81mVj7np59hj0JpQZHKRyPONh0s2HRBfsFaJ8MW5ty2MSaXzOCGVqrm5
         +2mKHLnhdnQd+p0LnpG9fkcdFbvNlPDmJ/JBTY9sz4WUTxRkuJYPF9X6NVjcRdTTWSpG
         +s+OENz39urAx8w8Fdt5Q0pHCuJngtRz23BA/i01ZVG4wuuVYwW5lliBftuidZG2bd5G
         W0VsoCS+iRuBiQR/OMLyVVt6acjuJXxsZgGSTUIRY/jr3NJYE9TCjiBTlQx3/xcu4u+k
         QUauMtG8Hd5ofY4xnRJUYj2hVo55IW7k7ZZWNJ9ua1WospI4fw79uBgNqeirSIee2Yyt
         MAjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vFSXhzA4lUZdcudxTZTWEXkrKRPu4vpjtPxZiKe5AV8=;
        b=ufVjmB8uPcXPl/iW0DR4zPGvBpFHIGKyiz70pCc4PAmAZ3p056C0R+unswJcXdRaUD
         26zwkCW0KwvgFBsjWFEIFeLZNYJD0Q9S/Uy3BDhphlhh1x0kXo1n76Eae+LR8HRv9dGP
         csFvicGgScSHI/NE9JoEy2JbZL/FCQgCaFNzvrGwhIVuW1G+T2gGk8BOaXMlDM411xpe
         lScX/uGjBqZ9Z0gOkJjEDF7cI9Fv3ZUTjD36wW/o2YEbw/Milrz6Ip72syT1EHNcwKKC
         nTp1lgq0e0sEUlHTb7+g4tNOlLpv3ZUBO0CKhvWvzYBUnm0joRjivg6E3H87tFsda258
         nDsQ==
X-Gm-Message-State: AOAM530RaChrnO6ASPkH5fF33mvbap4NreN/zOkct5pj1Xs2T2wPR5UR
        kL89EzIGG+RgaKKwQQ7jleo=
X-Google-Smtp-Source: ABdhPJyxPw8nvrlZycPxOga4ugBqzbjq461E/sv4Xy02wv4aztgzBSwSpoZde0UvcH4UlPYLCbm7+g==
X-Received: by 2002:aed:2ea4:: with SMTP id k33mr2846747qtd.169.1616061298837;
        Thu, 18 Mar 2021 02:54:58 -0700 (PDT)
Received: from localhost.localdomain ([156.146.54.246])
        by smtp.gmail.com with ESMTPSA id j24sm1334519qka.67.2021.03.18.02.54.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Mar 2021 02:54:58 -0700 (PDT)
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
        ludovic.desroches@microchip.com, dt@kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     rdunlap@infradead.org, Bhaskar Chowdhury <unixbhaskar@gmail.com>
Subject: [PATCH] ARM: boot: dts:  Fix a typo
Date:   Thu, 18 Mar 2021 15:22:37 +0530
Message-Id: <20210318095237.28436-1-unixbhaskar@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


s/conlicts/conflicts/

Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
---
 arch/arm/boot/dts/sama5d3.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/sama5d3.dtsi b/arch/arm/boot/dts/sama5d3.dtsi
index 7c979652f330..d1841bffe3c5 100644
--- a/arch/arm/boot/dts/sama5d3.dtsi
+++ b/arch/arm/boot/dts/sama5d3.dtsi
@@ -709,7 +709,7 @@ pinctrl_mmc0_dat4_7: mmc0_dat4_7 {
 						atmel,pins =
 							<AT91_PIOD 5 AT91_PERIPH_A AT91_PINCTRL_PULL_UP	/* PD5 periph A MCI0_DA4 with pullup, conflicts with TIOA0, PWMH2 */
 							 AT91_PIOD 6 AT91_PERIPH_A AT91_PINCTRL_PULL_UP	/* PD6 periph A MCI0_DA5 with pullup, conflicts with TIOB0, PWML2 */
-							 AT91_PIOD 7 AT91_PERIPH_A AT91_PINCTRL_PULL_UP	/* PD7 periph A MCI0_DA6 with pullup, conlicts with TCLK0, PWMH3 */
+							 AT91_PIOD 7 AT91_PERIPH_A AT91_PINCTRL_PULL_UP	/* PD7 periph A MCI0_DA6 with pullup, conflicts with TCLK0, PWMH3 */
 							 AT91_PIOD 8 AT91_PERIPH_A AT91_PINCTRL_PULL_UP>;	/* PD8 periph A MCI0_DA7 with pullup, conflicts with PWML3 */
 					};
 				};
--
2.26.2

