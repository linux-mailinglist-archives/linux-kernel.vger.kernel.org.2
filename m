Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73BEE43E36C
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Oct 2021 16:20:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231348AbhJ1OWv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Oct 2021 10:22:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231343AbhJ1OWl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Oct 2021 10:22:41 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A444C061570;
        Thu, 28 Oct 2021 07:20:14 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id e4so10488281wrc.7;
        Thu, 28 Oct 2021 07:20:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/Nx/FXuZHmzN2GOFSI5UkCtNDgB6jstgst0HpHC3bhg=;
        b=A6WnNrgNuUzR2IdplG9xU5Gda69cXlfGiU1iEpuut95+ObDoQu1P91FrbNMRKlmqZa
         OE1Nuc1KwLULHd2xdii8m0/7wQoIC27d/Z4SpOeEosVI7QfrR9PaO6bnH0ZNVySIxccR
         9I70Iyl98aAfQZ4NRYpvp8TQ/ooZaDTsb5xfmQ3/7B8HKq7gVupxZAgvGtzZZGrw8zkf
         Fb7VblpEaH3Ydc7Wm3zYsqDHt5nAQ0r7VgKWFdIrJ8LGr9oBLjW4kclFyV2mePgpQ4+q
         xXtNmYzt+EEBS4miFg4Q/gJqhzs7yLP1pexOC2O44eqyGMdROaTEAGRJ2jNP6XLuc70M
         jvkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/Nx/FXuZHmzN2GOFSI5UkCtNDgB6jstgst0HpHC3bhg=;
        b=dbp2QdBQtj/6tXXfXsLQNQ62isIz98JydkZ+Q4z0HGEVXG5u/Nh1GoIahWi4s9Ym5J
         9+xyp/GiUtaDwsv/VXo2A2CiWwDYiymhCjlK5+Enpn+cIJqfR7sQ5DblMyn8Xphs7oBK
         46xp3lRjIuIHl7FOGJHhBcm6hAw5Om3qhKJFvg5EFlFjY+QhlHWHrDQr6H2gNRdpOzaF
         QkoUgoEuMqW0yIZHgf8PWZKEG6bLYXhUvX4dyhmtlHmbhJJs6ldbQbpH07DuOZTiFnav
         bvNwm0C2mjotzvif/o71VLxMpBqT8QIQOBT6DSNIrHEF68H/x+YpfJyt/YkaQeS77XZz
         +JeQ==
X-Gm-Message-State: AOAM533daaTEIQKDDLTPxNELJIgj+48aBWDuLZIdjDHrSFwqewuYATJF
        DcdxZGRivSsxKBQY38Ue6Ac=
X-Google-Smtp-Source: ABdhPJzKYyvK9ywN7FVlYbhzQ1DkLGKtk+llarpayFZ0BWuSbPQgbsxmQR6e6DL+lCwMCTPH0zsAJA==
X-Received: by 2002:a5d:69ce:: with SMTP id s14mr4967054wrw.25.1635430812973;
        Thu, 28 Oct 2021 07:20:12 -0700 (PDT)
Received: from localhost.localdomain (i5C74E249.versanet.de. [92.116.226.73])
        by smtp.gmail.com with ESMTPSA id m2sm6284546wml.15.2021.10.28.07.20.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Oct 2021 07:20:12 -0700 (PDT)
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
Subject: [PATCH 09/13] arm: milbeaut: remove select of non-existing PINCTRL_MILBEAUT
Date:   Thu, 28 Oct 2021 16:19:34 +0200
Message-Id: <20211028141938.3530-10-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20211028141938.3530-1-lukas.bulwahn@gmail.com>
References: <20211028141938.3530-1-lukas.bulwahn@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch series "Add basic support for Socionext Milbeaut M10V SoC" (see
Link) introduced the config ARCH_MILBEAUT_M10V "Milbeaut SC2000/M10V
platform" in ./arch/arm/mach-milbeaut/ and intended to introduce timer,
clock, pinctrl and serial controller drivers.

However, during patch submission in March 2019, the introduction of the
milbeaut pinctrl driver was dropped from v2 to v3 of the patch series.
Since then, there was no further patch series to add this pinctrl driver
later on.

Hence, selecting PINCTRL_MILBEAUT in config is simply dangling and
referring to a non-existing config symbols.
Fortunately, ./scripts/checkkconfigsymbols.py warns:

PINCTRL_MILBEAUT
Referencing files: arch/arm/mach-milbeaut/Kconfig

Remove this select of the non-existing PINCTRL_MILBEAUT for now.

Link: https://lore.kernel.org/linux-arm-kernel/1551243056-10521-1-git-send-email-sugaya.taichi@socionext.com/

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
 arch/arm/mach-milbeaut/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/mach-milbeaut/Kconfig b/arch/arm/mach-milbeaut/Kconfig
index 6a576fd8521e..f9d1006f9442 100644
--- a/arch/arm/mach-milbeaut/Kconfig
+++ b/arch/arm/mach-milbeaut/Kconfig
@@ -13,7 +13,6 @@ config ARCH_MILBEAUT_M10V
 	select ARM_ARCH_TIMER
 	select MILBEAUT_TIMER
 	select PINCTRL
-	select PINCTRL_MILBEAUT
 	help
 	  Support for Socionext's MILBEAUT M10V based systems
 
-- 
2.26.2

