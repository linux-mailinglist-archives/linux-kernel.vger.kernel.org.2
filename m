Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 702C743E371
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Oct 2021 16:20:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231384AbhJ1OXC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Oct 2021 10:23:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231326AbhJ1OWr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Oct 2021 10:22:47 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 369EBC061228;
        Thu, 28 Oct 2021 07:20:19 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id k7so10455367wrd.13;
        Thu, 28 Oct 2021 07:20:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7KVlpgZO0dCMGpzJjKxhnceHT6UKMAoRduCsZEkMUE8=;
        b=hHbvKPrEoSKQC7djeA6n5NJDPAyLs1GTnx1kVQgrwegVlEJ0QdYaZDjsyuuGzr8fRv
         F9T3FcTr+JuzCpX6rdsMvp0gtLZCk/239WO5a5rI76A4QcFstF6+9XFAfqA3fK6sVSxY
         Xvids82VKesGpequgPQ9WmTjz+jQSmfp5Ao8lNfTCOXYfSTZU6IxtZjnoTDZ+NMmQHej
         4tnoOBItQC9bWK7xrqnyVgvaT1+n1svo83UqdVLA2yqfsmDtDcTHNzOqlGiOuLfX1ic9
         SAvJrNAkU02aSRUN2IjgRWl1UXqqraHm0xbxXfqt4Kf3ceknUGaKfvbjWGFVuGI/CdRe
         xWcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7KVlpgZO0dCMGpzJjKxhnceHT6UKMAoRduCsZEkMUE8=;
        b=VMDxOSwZqe81zSP8P/l9mbRxcRiD+hMS4uJ/FtqqMgc8XTxxntElZkNjVyKSgq5kjv
         f7mkhucYX/aqdhQIq2Piv9F2cOoR2ywWPxMhUUDfsqtMpsMrbu6XRjl2h42ZZ+tUuGud
         x///HSzDrai5yn3eECATfgwSt+70VKCDo6dCupwk/VGyqbj3/4UqwIrF4cSG2IMQRbxi
         HCsgIVO39aRizvhQan3MdHLaFjc1PUsZs7EkKjZ26u4I2OJiScfkOQomGDJOYLCRXjL/
         5tL6kqAPg1Ss/VvuvDyqLS+GL3tOQKKv4xVpAEdZsYUv+hA+VMRGy9xkWy9LETIk1LPn
         fjpA==
X-Gm-Message-State: AOAM533J1izemeH3AX/vR4ImVHvjIcL2xzuUMEFOPo5VuzbYRwtCds4N
        7KJBQ/1N/khIDcFp6xmbBzs=
X-Google-Smtp-Source: ABdhPJz49YR12dBg5U6u32/RrLtwMQYZtgCaHEc4fjD/v0JKfj7gX1PL+MxOROCEP1Ry4zyP+Jv5IA==
X-Received: by 2002:adf:c00d:: with SMTP id z13mr5970271wre.299.1635430817777;
        Thu, 28 Oct 2021 07:20:17 -0700 (PDT)
Received: from localhost.localdomain (i5C74E249.versanet.de. [92.116.226.73])
        by smtp.gmail.com with ESMTPSA id m2sm6284546wml.15.2021.10.28.07.20.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Oct 2021 07:20:17 -0700 (PDT)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Russell King <linux@armlinux.org.uk>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Sekhar Nori <nsekhar@ti.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Linus Walleij <linusw@kernel.org>,
        Imre Kaloz <kaloz@openwrt.org>,
        Krzysztof Halasa <khalasa@piap.pl>,
        Avi Fishman <avifishman70@gmail.com>,
        Tomer Maimon <tmaimon77@gmail.com>,
        Tali Perry <tali.perry1@gmail.com>,
        Patrick Venture <venture@google.com>,
        Nancy Yuen <yuenn@google.com>,
        Benjamin Fair <benjaminfair@google.com>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        linux-arm-kernel@lists.infradead.org, openbmc@lists.ozlabs.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH 11/13] arm: npcm: drop selecting non-existing ARM_ERRATA_794072
Date:   Thu, 28 Oct 2021 16:19:36 +0200
Message-Id: <20211028141938.3530-12-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20211028141938.3530-1-lukas.bulwahn@gmail.com>
References: <20211028141938.3530-1-lukas.bulwahn@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no and never was a Kconfig for ARM_ERRATA_794072 in the kernel
tree. So, there is no need to select ARM_ERRATA_794072 in
./arch/arm/mach-npcm/Kconfig.

Simply drop selecting the non-existing ARM_ERRATA_794072.

This issue was discovered with ./scripts/checkkconfigsymbols.py.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
 arch/arm/mach-npcm/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/mach-npcm/Kconfig b/arch/arm/mach-npcm/Kconfig
index a71cf1d189ae..9c137462fbe4 100644
--- a/arch/arm/mach-npcm/Kconfig
+++ b/arch/arm/mach-npcm/Kconfig
@@ -30,7 +30,6 @@ config ARCH_NPCM7XX
 	select ARM_ERRATA_764369 if SMP
 	select ARM_ERRATA_720789
 	select ARM_ERRATA_754322
-	select ARM_ERRATA_794072
 	select PL310_ERRATA_588369
 	select PL310_ERRATA_727915
 	select MFD_SYSCON
-- 
2.26.2

