Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3F1343E365
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Oct 2021 16:20:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231219AbhJ1OWi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Oct 2021 10:22:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231236AbhJ1OWe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Oct 2021 10:22:34 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B124C061767;
        Thu, 28 Oct 2021 07:20:07 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id m22so10600942wrb.0;
        Thu, 28 Oct 2021 07:20:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=F6qCaetzo2bs6A7edSV2Oql0KSOh/v96h0FaEf6Bxg8=;
        b=UfgmKlupugzoAbKp7xujF4Bioo5jj0psmD2waMtBu3v7UgPgx1LgBlYUNypUZlf6hg
         FeyfH2CeOit/1NOWH/Oi7HhoRtCQoBU81UGvbinCaD9crQRtPP8kNuqNmI6E0z0iNtJX
         pg/52AU7f1xFH0sU9Yc9veasKpTmSs6GOs9EmA0gBO/wh8XjrIl0L/srAtCpsIhXhB/q
         6I34wff4lmabQEuSj9N4F1sMq0VMWsCOS8RGzTXbLuehS+cQ7Ch0qETCZy3apszMJekD
         R+SZ1NKFydq2p9x6MWvT/oqP35PqIrWxv808q1kpio5EW5ZPKg/qy7FSqUs8Naw6SOJS
         00vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=F6qCaetzo2bs6A7edSV2Oql0KSOh/v96h0FaEf6Bxg8=;
        b=ouXLsnH6xq+8pJhhId59UC0BlPmX+TTA3CnROymR/6RUtX2jZ0yg9G0O4KXdPA8TSj
         HoH+tneEWsmb7TUKjqk1JTcbITJtaeat0uSIiC6LzOwAf5lKUegtxEQWtousxq7boNMU
         005rQGmQ5ROw4adFWCuQjGp2k2n8t9dmOlhXq2umOP9bwtS9JwZGGbwwzwdhos9hnfc3
         cakf7Nw3GmtPFXa0YXvLG7wrnNt0chGyfVQxHOEGRMDWuLFUXpkkEhc+UtQLc3ZrRvsI
         Q+d+OIpFOPfJNLZ7xHWALG3c3B23uS4SGi7/lTAnS8O5EcDFgKoJesdKTKEUpgXCLeft
         0cSg==
X-Gm-Message-State: AOAM532M1WzID+uKp7J23K8tGeA8E6khzWQnYtmdoCLXGcaHaXQYIz7I
        cbS3G0y2aGUgo7Oyp4wk0Mw=
X-Google-Smtp-Source: ABdhPJwsYeCVobccll8qJYf0Xr5UYFyrFoG4o3B6V4rxDH3/wnWoB3yXN3/SbpxMCO72VgT9uV2yPw==
X-Received: by 2002:adf:efca:: with SMTP id i10mr6042738wrp.289.1635430805719;
        Thu, 28 Oct 2021 07:20:05 -0700 (PDT)
Received: from localhost.localdomain (i5C74E249.versanet.de. [92.116.226.73])
        by smtp.gmail.com with ESMTPSA id m2sm6284546wml.15.2021.10.28.07.20.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Oct 2021 07:20:05 -0700 (PDT)
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
Subject: [PATCH 06/13] arm: ixp4xx: remove dead configs CPU_IXP43X and CPU_IXP46X
Date:   Thu, 28 Oct 2021 16:19:31 +0200
Message-Id: <20211028141938.3530-7-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20211028141938.3530-1-lukas.bulwahn@gmail.com>
References: <20211028141938.3530-1-lukas.bulwahn@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 73d04ca5f4ac ("ARM: ixp4xx: Delete Intel reference design
boardfiles") removes the definition of the configs MACH_IXDP465 and
MACH_KIXRP435, but misses to remove the configs CPU_IXP43X and CPU_IXP46X
that depend on those removed configs, and hence are dead now.

Fortunately, ./scripts/checkkconfigsymbols.py warns:

MACH_IXDP465
Referencing files: arch/arm/mach-ixp4xx/Kconfig

MACH_KIXRP435
Referencing files: arch/arm/mach-ixp4xx/Kconfig

Remove the dead configs CPU_IXP43X and CPU_IXP46X.

A further quick grep for the name of those two symbols did not show any
use of the two config symbols; so, there are no further clean-up activities
beyond this config removal needed.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
 arch/arm/mach-ixp4xx/Kconfig | 13 -------------
 1 file changed, 13 deletions(-)

diff --git a/arch/arm/mach-ixp4xx/Kconfig b/arch/arm/mach-ixp4xx/Kconfig
index 365a5853d310..4c787b4be62b 100644
--- a/arch/arm/mach-ixp4xx/Kconfig
+++ b/arch/arm/mach-ixp4xx/Kconfig
@@ -39,19 +39,6 @@ config ARCH_PRPMC1100
 	  PrPCM1100 Processor Mezanine Module. For more information on
 	  this platform, see <file:Documentation/arm/ixp4xx.rst>.
 
-#
-# Certain registers and IRQs are only enabled if supporting IXP465 CPUs
-#
-config CPU_IXP46X
-	bool
-	depends on MACH_IXDP465
-	default y
-
-config CPU_IXP43X
-	bool
-	depends on MACH_KIXRP435
-	default y
-
 comment "IXP4xx Options"
 
 config IXP4XX_PCI_LEGACY
-- 
2.26.2

