Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27AF73D4496
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Jul 2021 05:45:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233934AbhGXDEK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jul 2021 23:04:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233871AbhGXDDw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jul 2021 23:03:52 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5797C061575;
        Fri, 23 Jul 2021 20:44:24 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id u9-20020a17090a1f09b029017554809f35so11665925pja.5;
        Fri, 23 Jul 2021 20:44:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=SJz83ejABGMbQ2Eo9CZm9YSYODNjLXFLcuNMYaINnuE=;
        b=iFe8DxMo9KoTmBPe+SHB9albjxjUiD/wzCtv1hzbQsxPtYkKy0gdZxiIix2NyHralt
         8OU76Er2NVYEyqpt9OiH6K14mFhyEsGB3s6MvcJIXTRUb97VfkALnk9fCP4XmAdkvXTy
         1Y0KR3GX69z+5uxVGUAG3B9yCf8RshUCKUrK0qL3BMx+uhTGP8mQgdcFbsL8HfgJYi+m
         B/TudAFAcUFaaWIagLjFSduRriA8RVL2Q5n5FEw12SSNArEfms+WTSnBJkK+Um2kxAi1
         lA25N9NG0tZXH8BG9KGxp9UoeDguUoAhNpJwCLH8Nwx9j9T0akVEv5mqt9gxzoaDGpOw
         RmRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=SJz83ejABGMbQ2Eo9CZm9YSYODNjLXFLcuNMYaINnuE=;
        b=Qk/ceY1oIEON0qFEJt0/aSIwmAU/FS5CoVhWxwAM+ol/+OSbYXFTHt0G8k9JYQpN8+
         MlWXRCS5odf/b7UCof2AfK7OF8/e/9BIkpghETQ0/pzTYZN4Ql67oiH75zlS8TCl2x83
         CNKzUiDVsK0UyX3CBL19WtsrNZJdn8cUifaHGsq/PrObEzbvShHVKlBC0l9ox5TIKZzw
         cn1svo/GERE6KEhJ8fXexcFNQzzUkDy2PE5c/C1dVWyNfnEWlvYn1xmGGVjRKxGcn5Ic
         2VaC7tY5xu0WUAj7m44cDnxz4aN4CdFoVqPaMYflaTiPB5Lur322QevUb9qcayKzZIh4
         PRKA==
X-Gm-Message-State: AOAM530AyXh+BWrbA6AhGUdNtsF5dLaXy74/jZaT2LJv8vZOZ4RK67U4
        2a3Jy3FLh+gEBjIdPtSzz8c=
X-Google-Smtp-Source: ABdhPJxCVwwsBuIPEgilZ54pQuKM4Kct1PiMGYn4+2ejYooVZncuhDWJo8bl5S5Id+St+Ycz5XBTpQ==
X-Received: by 2002:a17:90a:f02:: with SMTP id 2mr7326015pjy.75.1627098264318;
        Fri, 23 Jul 2021 20:44:24 -0700 (PDT)
Received: from localhost.localdomain ([23.228.102.68])
        by smtp.gmail.com with ESMTPSA id c17sm35118733pfv.68.2021.07.23.20.44.19
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 23 Jul 2021 20:44:23 -0700 (PDT)
From:   dillon.minfei@gmail.com
To:     laurent.pinchart@ideasonboard.com, thierry.reding@gmail.com,
        sam@ravnborg.org, airlied@linux.ie, daniel@ffwll.ch,
        robh+dt@kernel.org, linus.walleij@linaro.org,
        alexandre.torgue@foss.st.com, mcoquelin.stm32@gmail.com,
        noralf@tronnes.org
Cc:     kbuild-all@lists.01.org, linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Dillon Min <dillon.minfei@gmail.com>
Subject: [PATCH v4 2/3] ARM: dts: stm32: fix dtbs_check warning on ili9341 dts binding
Date:   Sat, 24 Jul 2021 11:44:02 +0800
Message-Id: <1627098243-2742-3-git-send-email-dillon.minfei@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1627098243-2742-1-git-send-email-dillon.minfei@gmail.com>
References: <1627098243-2742-1-git-send-email-dillon.minfei@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dillon Min <dillon.minfei@gmail.com>

Since the compatible string defined from ilitek,ili9341.yaml is
"st,sf-tc240t-9370-t", "ilitek,ili9341"

so, append "ilitek,ili9341" to avoid the below dtbs_check warning.

arch/arm/boot/dts/stm32f429-disco.dt.yaml: display@1: compatible:
['st,sf-tc240t-9370-t'] is too short

Fixes: a726e2f000ec ("ARM: dts: stm32: enable ltdc binding with ili9341, gyro l3gd20 on stm32429-disco board")
Signed-off-by: Dillon Min <dillon.minfei@gmail.com>
Reported-by: kernel test robot <lkp@intel.com>
---
v4: no change.

 arch/arm/boot/dts/stm32f429-disco.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/stm32f429-disco.dts b/arch/arm/boot/dts/stm32f429-disco.dts
index 075ac57d0bf4..6435e099c632 100644
--- a/arch/arm/boot/dts/stm32f429-disco.dts
+++ b/arch/arm/boot/dts/stm32f429-disco.dts
@@ -192,7 +192,7 @@
 
 	display: display@1{
 		/* Connect panel-ilitek-9341 to ltdc */
-		compatible = "st,sf-tc240t-9370-t";
+		compatible = "st,sf-tc240t-9370-t", "ilitek,ili9341";
 		reg = <1>;
 		spi-3wire;
 		spi-max-frequency = <10000000>;
-- 
1.9.1

