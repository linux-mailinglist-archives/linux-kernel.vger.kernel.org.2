Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0437D43E361
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Oct 2021 16:20:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231272AbhJ1OWc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Oct 2021 10:22:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231182AbhJ1OW3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Oct 2021 10:22:29 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FF60C061570;
        Thu, 28 Oct 2021 07:20:02 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id b82-20020a1c8055000000b0032ccc728d63so5210346wmd.1;
        Thu, 28 Oct 2021 07:20:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dwKhuPd0K1+EmTRAh45beol0sV7WvBTjR24Mfp3dTpE=;
        b=N0HwkOaju3aHOIPChBq71/QS7cdj2sLk6qHh0FwX7OVXO5sW+QNvVhsxl3b6kVzZHy
         1TsgXblfqH4lohGTZH4PrW4Cmb03P57HNMFzFRTUUUNcYWNKu9O+/wnSNr80QU14tllv
         87+5xccCn9T5Rz/c/mL47kP6DQIlacnBh2zc9T8fgaV5WyWLsJPPLeOaCdjivi60CBb0
         KLCcShyp7Pog1dJqJMwYSq6ayLOr85LQYKd3EeBZxP/lmKDp6XRrqCzfkHnpxm8sRrAP
         lmmf7ZLwHtr0LiPTldNLBGBFCoJI3hM2iDQZnfW/lOVKzLEWFqgcOhgJAROKeY1ge+Co
         x9ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dwKhuPd0K1+EmTRAh45beol0sV7WvBTjR24Mfp3dTpE=;
        b=01yQKAo+fhzbhsNvZgu8ajFH63T+2SZLWlW9RGOfzh+eedHippq+cKPdLiD7/9gnLi
         1OFLawrxUJCVMXYqw9DNwgnPnDh4RyOQg5QvBFuE3I4v/1d0wFljk9hDYE53Z3bAoQVc
         dM2rfw49u73sEjjIA9Eh6yKUgo8l/RoJaHkwuoH/qqqUwHz5ErObadpyobhbz7E7IRjs
         04dB3oOR88QTYA2emsv5DfoZeSGwO8VABMYYpom4L9h3bFS2r6/bvaMyWXurK9RbtKay
         k++gUKMIR7C+gKF/bQP9gAhNwhXKqP7LKc69bpkM9m/MNzRq0TgHwVW9JnMeRYMzPYqv
         43Mw==
X-Gm-Message-State: AOAM533IaCBD7X6Cs2KSKco7yz8uEXBwiji3ubluxDxQzi42nnbJqHcP
        5jxv2lYK4HFtojdcXH0sKfg=
X-Google-Smtp-Source: ABdhPJxJf+q7NdBCBG/TUWbpWh436luTVJzFSER9ir83w9qoTEJrg8dMENgpR69PnWdTbdIfAD/BSA==
X-Received: by 2002:a1c:f601:: with SMTP id w1mr12724598wmc.112.1635430801147;
        Thu, 28 Oct 2021 07:20:01 -0700 (PDT)
Received: from localhost.localdomain (i5C74E249.versanet.de. [92.116.226.73])
        by smtp.gmail.com with ESMTPSA id m2sm6284546wml.15.2021.10.28.07.20.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Oct 2021 07:20:00 -0700 (PDT)
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
Subject: [PATCH 04/13] arm: drop an obsolete ifdef with the removed config PCI_HOST_ITE8152
Date:   Thu, 28 Oct 2021 16:19:29 +0200
Message-Id: <20211028141938.3530-5-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20211028141938.3530-1-lukas.bulwahn@gmail.com>
References: <20211028141938.3530-1-lukas.bulwahn@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 6da5238fa384 ("ARM: 8993/1: remove it8152 PCI controller driver")
removes the config PCI_HOST_ITE8152, but left a dangling obsolete ifndef
in ./arch/arm/kernel/bios32.c.

Hence, ./scripts/checkkconfigsymbols.py warns:

PCI_HOST_ITE8152
Referencing files: arch/arm/kernel/bios32.c

Remove this obsolete ifndef.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
 arch/arm/kernel/bios32.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm/kernel/bios32.c b/arch/arm/kernel/bios32.c
index e7ef2b5bea9c..26b5d8361980 100644
--- a/arch/arm/kernel/bios32.c
+++ b/arch/arm/kernel/bios32.c
@@ -529,12 +529,10 @@ void pci_common_init_dev(struct device *parent, struct hw_pci *hw)
 	}
 }
 
-#ifndef CONFIG_PCI_HOST_ITE8152
 void pcibios_set_master(struct pci_dev *dev)
 {
 	/* No special bus mastering setup handling */
 }
-#endif
 
 char * __init pcibios_setup(char *str)
 {
-- 
2.26.2

