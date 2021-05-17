Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B970F382923
	for <lists+linux-kernel@lfdr.de>; Mon, 17 May 2021 12:00:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236474AbhEQKAU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 May 2021 06:00:20 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:34572 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236224AbhEQJ7u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 May 2021 05:59:50 -0400
Received: from mail-ej1-f70.google.com ([209.85.218.70])
        by youngberry.canonical.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <juerg.haefliger@canonical.com>)
        id 1lia1B-0002RZ-C5
        for linux-kernel@vger.kernel.org; Mon, 17 May 2021 09:58:33 +0000
Received: by mail-ej1-f70.google.com with SMTP id cs18-20020a170906dc92b02903a8adf202d6so815598ejc.23
        for <linux-kernel@vger.kernel.org>; Mon, 17 May 2021 02:58:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=q/wSN0+Q7UW1xpdFuLri53LFWf1u+HpJsXzIKwoz29A=;
        b=KoUoZamUWfkvX80Qk5zzs4cbBFScYAhIW6dt2ZKJxyQAn5PhFVy3Lg7fptJUlnFyZX
         ewbAaO5/rzoqTIrvuk94rhnTSndBCwR9Q6aGQCB/LwE1DJrl4DXEK+KZoyJGK8Sil0VZ
         E9MXszOfGHtaGHoREO7KRz5plNHkeugRXzY1YW+k16R+bEIgmrVM37D9SMl/pO1R9EO3
         PAZ7T5dg3JUo+SDCgrcTDvk9/HFyOtmP0hx5r2JTHiXAJmWdSgF/WB40yFUzb2Y0L5Ec
         o+Ylgf+3EnJOfjIBz+XB77rbcyldyVGj1dVTA256xQhwCW+yhrnFQ0DOmwGiormWvK3b
         nUNA==
X-Gm-Message-State: AOAM532muJs+ul1HXTQzj3u3V8+TglCtkYUaljm1Q1UrluwC8NCwarc5
        UA6jRTKj0b9IyR5Eqh6w3TGM3tBXUq1zgS2AXYM5a4Did8oyrCWdZE4IMA/y8ySZZiNiPs3o3OX
        lYXb38bVhK0zOnexabb82HpflxuRhFg/8JfQ0C5zRHw==
X-Received: by 2002:aa7:d818:: with SMTP id v24mr26537150edq.290.1621245513102;
        Mon, 17 May 2021 02:58:33 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxNlXvNzVQOstOtLAhWapeNUCRt/jrF806iuW+e4UxXf45W748ZixHui0OO1NUHaHLpYFlN1A==
X-Received: by 2002:aa7:d818:: with SMTP id v24mr26537136edq.290.1621245512971;
        Mon, 17 May 2021 02:58:32 -0700 (PDT)
Received: from gollum.fritz.box ([194.191.244.86])
        by smtp.gmail.com with ESMTPSA id bh2sm7362212ejb.80.2021.05.17.02.58.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 May 2021 02:58:32 -0700 (PDT)
From:   Juerg Haefliger <juerg.haefliger@canonical.com>
X-Google-Original-From: Juerg Haefliger <juergh@canonical.com>
To:     mpm@selenic.com, herbert@gondor.apana.org.au,
        zhouyanjie@wanyeetech.com, linux-crypto@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, juergh@canonical.com
Subject: [PATCH] hwrng: Remove leading spaces in Kconfig
Date:   Mon, 17 May 2021 11:58:31 +0200
Message-Id: <20210517095831.81631-1-juergh@canonical.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove leading spaces before tabs in Kconfig file(s) by running the
following command:

  $ find drivers/char/hw_random -name 'Kconfig*' | x\
    args sed -r -i 's/^[ ]+\t/\t/'

Signed-off-by: Juerg Haefliger <juergh@canonical.com>
---
 drivers/char/hw_random/Kconfig | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/char/hw_random/Kconfig b/drivers/char/hw_random/Kconfig
index 1fe006f3f12f..0e1e97680f08 100644
--- a/drivers/char/hw_random/Kconfig
+++ b/drivers/char/hw_random/Kconfig
@@ -168,14 +168,14 @@ config HW_RANDOM_OMAP
 	depends on ARCH_OMAP16XX || ARCH_OMAP2PLUS || ARCH_MVEBU
 	default HW_RANDOM
 	help
- 	  This driver provides kernel-side support for the Random Number
+	  This driver provides kernel-side support for the Random Number
 	  Generator hardware found on OMAP16xx, OMAP2/3/4/5, AM33xx/AM43xx
 	  multimedia processors, and Marvell Armada 7k/8k SoCs.
 
 	  To compile this driver as a module, choose M here: the
 	  module will be called omap-rng.
 
- 	  If unsure, say Y.
+	  If unsure, say Y.
 
 config HW_RANDOM_OMAP3_ROM
 	tristate "OMAP3 ROM Random Number Generator support"
@@ -485,13 +485,13 @@ config HW_RANDOM_NPCM
 	depends on ARCH_NPCM || COMPILE_TEST
 	default HW_RANDOM
 	help
- 	  This driver provides support for the Random Number
+	  This driver provides support for the Random Number
 	  Generator hardware available in Nuvoton NPCM SoCs.
 
 	  To compile this driver as a module, choose M here: the
 	  module will be called npcm-rng.
 
- 	  If unsure, say Y.
+	  If unsure, say Y.
 
 config HW_RANDOM_KEYSTONE
 	depends on ARCH_KEYSTONE || COMPILE_TEST
-- 
2.27.0

