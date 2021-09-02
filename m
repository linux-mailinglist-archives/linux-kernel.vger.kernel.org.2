Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC8DD3FEEF8
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Sep 2021 15:49:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345298AbhIBNu0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Sep 2021 09:50:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234364AbhIBNuW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Sep 2021 09:50:22 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9ECCC0613C1
        for <linux-kernel@vger.kernel.org>; Thu,  2 Sep 2021 06:49:23 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id g138so1327857wmg.4
        for <linux-kernel@vger.kernel.org>; Thu, 02 Sep 2021 06:49:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oj4j/+RKPWZynb1QTKEYiXoK5GFx0DuIh0dsK+YOz70=;
        b=Q2Z7V5PgsCJ85ScYojuBJgHK46WzEFCDleMnYLwQ4pQnV/smerrBx8EXlxWwElHsII
         4cpj3+u5PI5T/KPeW7PzUon33Qsdr6RCOogPrrrTbyyuMiufJpvVrMUiNQlzKk3lwcMB
         QlMWnbWPDf6RgpUk3AsJUDSwW9yv2tzBUt7+14S6cvk9mqZfQ+4COlZ+zuvbBal4Lz/d
         JQnEman2NRmmwLH5QI4PnmRtR6QCDHuCHT3/UDgnGjF/jKo8x40HGeb1LAaN8CA2iwyr
         kyKgwhkP8MqwWn8Vmyv/tdWGJpZ73VLDV371iwCE8xtJrZPe9dvYhSJ0wkMWz5I/aQhv
         /HdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oj4j/+RKPWZynb1QTKEYiXoK5GFx0DuIh0dsK+YOz70=;
        b=brElTlbXIxXwxob8/WOoiHaow+6lPuJ9J/2Z67Y/MB34vERMA8HsELDGQ0F5ZLyzBH
         atWSMEdavs0DNgzVkpmwJo6znQ1G+g58Eq4X+JKw8hMYI0nEcIhtaBoesu6oB7ZTVj7/
         3A5rlNRRj9/8Us7LS0JENGd7wVJ+/KSxWSHlZ02cKS+Y+iEHUScfqnAA+bLY3ptZGdeL
         lWfTSmJUWBzZLSAq4yjeRv8DE5MuWVgj3G8rxcPtmoxHkRo69WW4Xw2pPtwERek6tCmQ
         K9SfbbT7b291CH1gMMqu3jdxLvO5nUJvDf+jmiqkN68GT/MExTA8ld9hG3uLoTmsLlB7
         SSag==
X-Gm-Message-State: AOAM531l0dM22Pi39jtLfW17AqfyXHLXllXBJ4JpUZrVEy9VQ9wZwvYD
        UGV5vHrx0qClF0/c6UiGuG/2TA==
X-Google-Smtp-Source: ABdhPJzXWKeLkhVS1joNTc2NUQrEZ7RsSDad/Dyg9eBJNYQBgSa9vVh1As/lmTmZzAmztrcHAEMw2A==
X-Received: by 2002:a1c:f713:: with SMTP id v19mr3250388wmh.188.1630590562305;
        Thu, 02 Sep 2021 06:49:22 -0700 (PDT)
Received: from localhost.localdomain ([2001:861:44c0:66c0:98:6312:3c8:6531])
        by smtp.gmail.com with ESMTPSA id z5sm1710162wmp.26.2021.09.02.06.49.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Sep 2021 06:49:21 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     maz@kernel.org, tglx@linutronix.de, jbrunet@baylibre.com
Cc:     khilman@baylibre.com, lee.jones@linaro.org, saravanak@google.com,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: [PATCH 2/2] arm64: meson: remove MESON_IRQ_GPIO selection
Date:   Thu,  2 Sep 2021 15:49:14 +0200
Message-Id: <20210902134914.176986-3-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210902134914.176986-1-narmstrong@baylibre.com>
References: <20210902134914.176986-1-narmstrong@baylibre.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=810; h=from:subject; bh=owkhlb4ciqjjQmULPQLOVbgzD27XBXXd7036af5Wvz8=; b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBhMNYVFMjvCnxnhaNrw0vw+U5deLnZE1I3QXIFVD07 OWgHzauJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCYTDWFQAKCRB33NvayMhJ0ei0D/ 94rKxPedZsvrnEc1oCh+9e2Dw+iN18I5LHLklE1zVH2UD3Z82MiEiSB4ug5WNxF1bqsTYsfofVHoZx xBAL1H19GKYK9UwFBvt7RNj+4ahjFRxDtKx+hN7nxYld2CjIdpqs0pvBiVabZNRtcRphQ3u/PgPu/q OAJPcxFD1B0qH2x8zwUc56KkQjjQ7PgdbNHHMnWQwSA9pFCzkPVvwmC2Wr0zQ8qW8wsIvHkG31MZO0 MuvzmxPcTnRPI2rT/Mfz31cPNUe1OxfIKkdpYj5c044djZD75QNnRbUydkZODdhSwhZPlNGGXBdngA JIrikQ/2+MyhNjBYgadk8sjiLRs9RtJykemEjqEB1Xkhcxl0qXz3MWpk4nLWRm9AHWr3GxRQHTKGad r+K+UYpAzZaAinvsTzINzvX42P3A3Ll0oyVWeyXPJ1hVJfdXK2ZaQnXxs5f2+hcbxYVamwtetsSATk eD154UaAaJWFd0vHJvG1U8K6R6uZxC60Zdw5i/oXsw+yjjNkR7uY8k34iwM4K18ykg0iqGMPn8o9ke oCE05tqb0P9MMu8ghT+zWpwPwjQvRSUPZ6K7owPwNQv7N3Cx1bmx0zxTJkFDQ+wQH5rtYdAWj9zUOy mYlBMaeanC7iwARbjsxfJgrSfeNm3GJYvY0fObdhz9GzbKiY44RCoFirwvAg==
X-Developer-Key: i=narmstrong@baylibre.com; a=openpgp; fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Selecting MESON_IRQ_GPIO forces it as built-in, but we may need to build it
as a module, thus remove it here and let the "default ARCH_MESON" build as
built-in by default with the option to switch it to module.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 arch/arm64/Kconfig.platforms | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
index b0ce18d4cc98..ff2d83fbbde1 100644
--- a/arch/arm64/Kconfig.platforms
+++ b/arch/arm64/Kconfig.platforms
@@ -167,7 +167,6 @@ config ARCH_MEDIATEK
 config ARCH_MESON
 	bool "Amlogic Platforms"
 	select COMMON_CLK
-	select MESON_IRQ_GPIO
 	help
 	  This enables support for the arm64 based Amlogic SoCs
 	  such as the s905, S905X/D, S912, A113X/D or S905X/D2
-- 
2.25.1

