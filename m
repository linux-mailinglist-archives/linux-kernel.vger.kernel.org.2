Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A8DB43E35B
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Oct 2021 16:20:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231201AbhJ1OWZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Oct 2021 10:22:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230305AbhJ1OWX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Oct 2021 10:22:23 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9F28C061745;
        Thu, 28 Oct 2021 07:19:55 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id e4so10486470wrc.7;
        Thu, 28 Oct 2021 07:19:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=V3KiU206SAU31NUfwpS2+BkRGT20ITYrNtM1Dgg2dPQ=;
        b=EU3xEG/3dC9YXPW/ccVFr8K3ChYeYFaYcNGGtHp0RPz/O0Ec7X9YV2fflD58Vb/Xso
         e9oHK0zp1VWtKz/TtPv+KlKv0VY+4wEx+KVkrpdQYgTP+IHKbLJs/vKYgBthSHiLH7Si
         vHKFVvvoU6t7ADJSwLn97xxpdkBa55eS7kQUVcD/5VuGcYQ0EZQdV/4kyNJR8rHzS9Dw
         zuoHixsB5EbAsiKAUaK41cjTNEj2Fw4a5SWEgWTSkcH1v/pENY5Jitp3svHZAmly13W7
         zxc/xp4Gm+1aj3Su20bhbwplVlkYEdigikzOeMADEPj/FMzWEveXImKKEM85ea1SdlZA
         zcXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=V3KiU206SAU31NUfwpS2+BkRGT20ITYrNtM1Dgg2dPQ=;
        b=t4ziafhfTAN9/+a0WfvKLY6LYFOdVGVEWGnHbzedNAg7bhzF9fL1LYGcJfpZh9PP9s
         Xoci7B7olAdLQB6zjdj3uQGw75IFH2KIO9yJYvjSDq5UP25osY3XA+VmXuIn8eqqDaAo
         HaDjmNfVtOsZUUYNQKGNpU5jUA//72l0pTcSFNLCBQ3EZ8pM9skoU7ejddNIeLhwMdCk
         Jq5t9A/fRzZz+6HJg6uynOgiRmcJkBadfkS3koxPBYTE9gXogFqFB5FVYL4jQzERX9Xl
         x3bosqjtWZAj8CNEk4wnDvOU4g5pOJEm+GiHNcE43jVEgax8ALf6a4QCmdKB8HHPURMW
         fTjQ==
X-Gm-Message-State: AOAM5332ANH1JWdP9lYv/rGDpz+KSfd3qu88vdOWOHyXecB7EtXrro3g
        a9EUBSgc4Kfi0kBfhDngufQ=
X-Google-Smtp-Source: ABdhPJwg3ZOGkOv7nfE4Q1CFcC2U67ylJHTUMHUX7NHf7xKUz3nmHuxjhKWOUj9v1S9QjSEYhiHxYg==
X-Received: by 2002:adf:c00d:: with SMTP id z13mr5966699wre.299.1635430794430;
        Thu, 28 Oct 2021 07:19:54 -0700 (PDT)
Received: from localhost.localdomain (i5C74E249.versanet.de. [92.116.226.73])
        by smtp.gmail.com with ESMTPSA id m2sm6284546wml.15.2021.10.28.07.19.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Oct 2021 07:19:54 -0700 (PDT)
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
Subject: [PATCH 01/13] arm: debug: remove obsolete debug code for DEBUG_ZTE_ZX
Date:   Thu, 28 Oct 2021 16:19:26 +0200
Message-Id: <20211028141938.3530-2-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20211028141938.3530-1-lukas.bulwahn@gmail.com>
References: <20211028141938.3530-1-lukas.bulwahn@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 89d4f98ae90d ("ARM: remove zte zx platform") removes the config
DEBUG_ZTE_ZX. Hence, since then, the "ifdef CONFIG_DEBUG_ZTE_ZX" in
./arch/arm/include/debug/pl01x.S is dead code.

Fortunately, ./scripts/checkkconfigsymbols.py detects this and warns:

DEBUG_ZTE_ZX
Referencing files: arch/arm/include/debug/pl01x.S

So, remove the obsolete ifdef CONFIG_DEBUG_ZTE_ZX.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
 arch/arm/include/debug/pl01x.S | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/arch/arm/include/debug/pl01x.S b/arch/arm/include/debug/pl01x.S
index 0c7bfa4c10db..c7e02d0628bf 100644
--- a/arch/arm/include/debug/pl01x.S
+++ b/arch/arm/include/debug/pl01x.S
@@ -8,13 +8,6 @@
 */
 #include <linux/amba/serial.h>
 
-#ifdef CONFIG_DEBUG_ZTE_ZX
-#undef UART01x_DR
-#undef UART01x_FR
-#define UART01x_DR     0x04
-#define UART01x_FR     0x14
-#endif
-
 #ifdef CONFIG_DEBUG_UART_PHYS
 		.macro	addruart, rp, rv, tmp
 		ldr	\rp, =CONFIG_DEBUG_UART_PHYS
-- 
2.26.2

