Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B481331F0F
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Mar 2021 07:16:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229775AbhCIGPp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Mar 2021 01:15:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229599AbhCIGPa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Mar 2021 01:15:30 -0500
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B30FC06174A;
        Mon,  8 Mar 2021 22:15:30 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id d8so6031537plg.10;
        Mon, 08 Mar 2021 22:15:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=BfKik6ijF9a1daxpx/u1Qu+UYWjPOhkfxe7xX5AYUvs=;
        b=u0Hf3/NPIUVfEZTtN/lyB5PKv3tFPsXp/CdO8J0zc5Djcmcd/GRHV1gPfkPnS2plLU
         6+ircmO/UAbGat1pOeFQJ84YWhpV8R+glhY2XLrG63YTKYWGXFHuuyhJ9ADsuTjPgG/i
         xKmdR14WRjS7KC1HU+kcaKyEZvWzKKZE1JlfvjlMsJNwqioc0E9k7OiezwPvDK6XVaLn
         szV2IQ60Mz6v8fZBKIRRCLtjWdgy3saFyDE7S2vX5dF1IhnBhXSDocFG62fXI+OWnEop
         ef4rjDWJpZ12kwMCi+446fEY6O/b3u60Ro3OrmXFkz9ax9oNSJZcDOVE0j06+DppWYbX
         BDuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=BfKik6ijF9a1daxpx/u1Qu+UYWjPOhkfxe7xX5AYUvs=;
        b=VmVO9pM6ybWokBi040VIaDsojkT1J5h42SEwcNAe1MK4KTSa82jkMZ0Zee/LQWtJGx
         d/8fQwtbQsOQ7vBq4Bz1MOhodL+eZdbXLFIJQvI90v4go+xH1N4F6jCP60NSNQERi6y7
         mfPRKTdTNNVD6Hu9vocGcXO/gkStRQXaLq4Au9QDBOhhnWNaT6qMVZsel7EvEDRMQtoe
         C4L9uuo1SCjE0hiGs3XndaTGbADrmJDsBh40npZD3Q7oerbzsTq9EacGm84oDtUwD8zY
         HoLSQO8dfzdLr9qlMQqTDdOPjRJ7JNrKlZ3yZlZ42D82RldDiuzGMe91vgcd8UJPab5/
         qlVQ==
X-Gm-Message-State: AOAM533DLgGZFeLuXZna5MxCRcJ9pk4OW3ljC36XnHm6p6n1cJCUm1sg
        mzsSmqD06btKsszt2kByEhw=
X-Google-Smtp-Source: ABdhPJzGD10B5aop6yRousp6OYOLYUjoTDMMOzd4qYkyWZg7Nh1emll8iDfPo8eeqoULCB+i2caZxg==
X-Received: by 2002:a17:902:f547:b029:e4:7332:c94b with SMTP id h7-20020a170902f547b02900e47332c94bmr24417069plf.69.1615270530122;
        Mon, 08 Mar 2021 22:15:30 -0800 (PST)
Received: from fmin-OptiPlex-7060.nreal.work ([137.59.103.165])
        by smtp.gmail.com with ESMTPSA id r23sm1464613pje.38.2021.03.08.22.15.27
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Mar 2021 22:15:29 -0800 (PST)
From:   dillon.minfei@gmail.com
To:     robh+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        parthiban@linumiz.com, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     dillon min <dillon.minfei@gmail.com>
Subject: [PATCH] ARM: dts: imx6ull: fix ubi filesystem mount failed
Date:   Tue,  9 Mar 2021 14:15:20 +0800
Message-Id: <1615270520-16951-2-git-send-email-dillon.minfei@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1615270520-16951-1-git-send-email-dillon.minfei@gmail.com>
References: <1615270520-16951-1-git-send-email-dillon.minfei@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: dillon min <dillon.minfei@gmail.com>

since Micron MT29F2G08ABAEAWP's ecc error management:

|Description           			| Requirement
|Minimum required ECC  			| 4-bit ECC per 528 bytes
|Minimum ECC with internal ECC enabled  | 4-bit ECC per 516 bytes (user data) +
                                         8bytes (parity data)

to avoid unnecessary overheads related to bigger ecc calculations.
need choose to use fsl,use-minimum-ecc, else will run into ecc error.

[    9.449265] ubi0: scanning is finished
[    9.463968] ubi0 warning: ubi_io_read: error -74 (ECC error) while reading
22528 bytes from PEB 513:4096, read only 22528 bytes, retry
[    9.486940] ubi0 warning: ubi_io_read: error -74 (ECC error) while reading
22528 bytes from PEB 513:4096, read only 22528 bytes, retry
[    9.509906] ubi0 warning: ubi_io_read: error -74 (ECC error) while reading
22528 bytes from PEB 513:4096, read only 22528 bytes, retry
[    9.532845] ubi0 error: ubi_io_read: error -74 (ECC error) while reading
22528 bytes from PEB 513:4096, read 22528 bytes

Fixes: f9ecf10cb88c ("ARM: dts: imx6ull: add MYiR MYS-6ULX SBC")
Signed-off-by: dillon min <dillon.minfei@gmail.com>
---
 arch/arm/boot/dts/imx6ull-myir-mys-6ulx-eval.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/imx6ull-myir-mys-6ulx-eval.dts b/arch/arm/boot/dts/imx6ull-myir-mys-6ulx-eval.dts
index ecbb2cc5b9ab..79cc45728cd2 100644
--- a/arch/arm/boot/dts/imx6ull-myir-mys-6ulx-eval.dts
+++ b/arch/arm/boot/dts/imx6ull-myir-mys-6ulx-eval.dts
@@ -14,5 +14,6 @@
 };
 
 &gpmi {
+	fsl,use-minimum-ecc;
 	status = "okay";
 };
-- 
2.7.4

