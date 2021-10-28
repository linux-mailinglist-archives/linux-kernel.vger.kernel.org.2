Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 817CF43E35F
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Oct 2021 16:20:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231230AbhJ1OW3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Oct 2021 10:22:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231182AbhJ1OW1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Oct 2021 10:22:27 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 542CCC061745;
        Thu, 28 Oct 2021 07:20:00 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id d3so10497412wrh.8;
        Thu, 28 Oct 2021 07:20:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TTzwjJSMGjlHkXTlA0zITL/LluZlDy2EIE8RaOC2PJI=;
        b=Lyqxw30wY1+Qu4YrrWv9AZrP77iWbXkCezYcd7gBlUxCmuguq56Kt7O/I3OeUVxue3
         rpG4PDB3E3/aw+jz5NL7Slz2PX8qtVXrIVNe6fWe/QhrtnLm22Ii8qST2l0DYrwPmXQd
         Ya4P/NxByV+cJRgmL7TlpNl/cpYBCSYkIZtcsgVEH5cinRAX6/kmkscyJlDRWb+hv3VR
         QXX/hGigeX5hioY7ibMAMHKzwaH3T3NOkMTc1aHizfOXTTvMJrZog92IVUrZoEaNSMEu
         Oo77pnlXTobtewh2RVDxsfueEgIy5sBr8NcizYz5GpbzXkMJ3kU/Aa5EnA4cmosZieo3
         cf4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TTzwjJSMGjlHkXTlA0zITL/LluZlDy2EIE8RaOC2PJI=;
        b=M9sVgRqSMT5KEgIDP0jCWl0KvvnkvSGUi+t4FB7zahaiUvbe1vi/QU5EPUaueDKMpA
         PIAvt08FL5YUpTAGJpFusPPRY4XhG+sexYh8261stZMEkCIxC21USS8f+47fpd0UDfuu
         2HNBcLkrZ5pAbVvoYOB6aVZwSXpxbh9w4sYK4kUAHrSWXvwHTzmHPN65wcWAdGHndw3w
         BzgycxBabpsAWi512+WXRrLdzrVBN6JIlGiRAewSqS0iKqObr5zkJA9/FZf0gnomsEkw
         FIBBL88QDR5boar50EatxuxcWfAfG/CHvJxvioMkhemFyRcqv/eyXPcal/9cIzKL7Hyy
         WWgw==
X-Gm-Message-State: AOAM530rGUv+WldHqjGUGXs4Y+uvXnWujuc8mxOugZejyV6qoEdAex0j
        SkQPE0nohTuHfVeVFmP4h/U=
X-Google-Smtp-Source: ABdhPJyDRNj6li3loAoD7ixRNKCJ3lHGxNkXGZ+nglud05oQ0vkYfqtyVHtcULhBtjciYHnjgbx2aw==
X-Received: by 2002:adf:e489:: with SMTP id i9mr6253592wrm.22.1635430798893;
        Thu, 28 Oct 2021 07:19:58 -0700 (PDT)
Received: from localhost.localdomain (i5C74E249.versanet.de. [92.116.226.73])
        by smtp.gmail.com with ESMTPSA id m2sm6284546wml.15.2021.10.28.07.19.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Oct 2021 07:19:58 -0700 (PDT)
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
Subject: [PATCH 03/13] arm: Kconfig.debug: drop reference to removed ARCH_MSM
Date:   Thu, 28 Oct 2021 16:19:28 +0200
Message-Id: <20211028141938.3530-4-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20211028141938.3530-1-lukas.bulwahn@gmail.com>
References: <20211028141938.3530-1-lukas.bulwahn@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit c0c89fafa289 ("ARM: Remove mach-msm and associated ARM architecture
code") removes the definition of the config ARCH_MSM. Since then, the
reference to ARCH_MSM in the dependencies of UNCOMPRESS_INCLUDE in
Kconfig.debug is dead.

Fortunately, ./scripts/checkkconfigsymbols.py warns:

ARCH_MSM
Referencing files: arch/arm/Kconfig.debug

Drop the dependency on this removed config.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
 arch/arm/Kconfig.debug | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug
index 83484564b1d9..87aa6e92ee6e 100644
--- a/arch/arm/Kconfig.debug
+++ b/arch/arm/Kconfig.debug
@@ -1886,7 +1886,7 @@ config DEBUG_UNCOMPRESS
 
 config UNCOMPRESS_INCLUDE
 	string
-	default "debug/uncompress.h" if ARCH_MULTIPLATFORM || ARCH_MSM || \
+	default "debug/uncompress.h" if ARCH_MULTIPLATFORM || \
 					PLAT_SAMSUNG || ARM_SINGLE_ARMV7M
 	default "mach/uncompress.h"
 
-- 
2.26.2

