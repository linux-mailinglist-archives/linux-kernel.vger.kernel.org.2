Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD70A3429D8
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Mar 2021 02:58:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229879AbhCTB5t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 21:57:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229922AbhCTB5V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 21:57:21 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCE89C061760;
        Fri, 19 Mar 2021 18:57:09 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id l123so7103827pfl.8;
        Fri, 19 Mar 2021 18:57:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=VCzEU/pil3MTu8S/aYMTsjT9oMpE9r8HPtiJlG91plE=;
        b=M9r+olV5V+aNndKJcLMTK4qzmhPcP5LIWBjeX6yfzj9MM1y21tUJ0Cg4gkK2kGZ0Ag
         q3El4P0nu1b+imZ2q9/ZBYecJ+DJJi2q54I2sQzL+WzZRNl96uNXkYcBdsmQ4MVcK5k3
         2K0ZojkQKxyY+24Pf/eGlSgIdybcS3ODeYK3eVwQbfDRnCdN8yxLhElH3k5kaVJ4GaN3
         pll3WIkIlOGgffWJ4+znpnwrNCjYCgPkEarQ5ReT65K2oLwNwP7rC/axT1oWG0A0H/ll
         Cgb7yIGe+93PLaOKZFsOmave85XIe9Vw4cYnfh+ez0Xr08VLdSq61BD4pAdLJHUEowE+
         Piwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=VCzEU/pil3MTu8S/aYMTsjT9oMpE9r8HPtiJlG91plE=;
        b=N9EZTHSXaZ6rmQQos6y4GbiGdpmyk35f+wKKxa2SanxzpE3ZCCIqKQpqN11BAixgSy
         +RhL9Veur7Yih4jb0RWZvSyFObxCELOygwBt1CCUVWOGOEg2WrOjDMGCaKHqiSVHKkRr
         yFa/Sdxa3kauHjKrzrkv2fMQx9uSYHb6YxKFdYYoV9bP4f6syT34JHUj1zx3HPGRt9sl
         6hYIadbDEf1X9WIYQXFdRAbPnAVy2dwr/5uJ6sdWV6mnjPMAuyl13ug6jWoWi2FFgsek
         j0b9rG1cpsMfypSnhIto4k7iUGAYv3N+PbRii3j7Q82AJpS1Hf96zuPLHHPpsJWiR2y6
         1LAA==
X-Gm-Message-State: AOAM530rqQETKqmlEXNk974rKwIxmxMjKJ/dOcEox9TaZvhG0cUBU4UW
        jtq//mB1b4CRol+vXtEFRjc=
X-Google-Smtp-Source: ABdhPJwn7lnmyGG9SqN9cgEHbtjPsDYamvUajTPWCFzIIKGfKqS7onz+9EQToq009RBXlIf4xfwd3A==
X-Received: by 2002:a63:8348:: with SMTP id h69mr6928172pge.136.1616205429444;
        Fri, 19 Mar 2021 18:57:09 -0700 (PDT)
Received: from localhost.localdomain ([204.44.111.4])
        by smtp.gmail.com with ESMTPSA id y7sm5755904pgp.23.2021.03.19.18.57.04
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 19 Mar 2021 18:57:09 -0700 (PDT)
From:   dillon.minfei@gmail.com
To:     alexandre.torgue@foss.st.com, rong.a.chen@intel.com,
        robh+dt@kernel.org, a.fatoum@pengutronix.de,
        mcoquelin.stm32@gmail.com, devicetree@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux@armlinux.org.uk, vladimir.murzin@arm.com,
        afzal.mohd.ma@gmail.com, gregkh@linuxfoundation.org,
        erwan.leray@foss.st.com, linux-serial@vger.kernel.org,
        lkp@intel.com
Cc:     dillon min <dillon.minfei@gmail.com>
Subject: [PATCH v4 9/9] dt-bindings: serial: stm32: Use 'unevaluatedProperties' instead of 'additionalProperties'
Date:   Sat, 20 Mar 2021 09:56:23 +0800
Message-Id: <1616205383-24114-8-git-send-email-dillon.minfei@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1616205383-24114-1-git-send-email-dillon.minfei@gmail.com>
References: <1616205383-24114-1-git-send-email-dillon.minfei@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: dillon min <dillon.minfei@gmail.com>

To use additional properties 'bluetooth', need use unevaluatedProperties
to fix dtbs_check warnings.

'arch/arm/boot/dts/stm32h750i-art-pi.dt.yaml: serial@40004800: 'bluetooth'
does not match any of the regexes: 'pinctrl-[0-9]+'

Reported-by: kernel test robot <lkp@intel.com>
Fixes: af1c2d81695b ("dt-bindings: serial: Convert STM32 UART to json-schema")
Signed-off-by: dillon min <dillon.minfei@gmail.com>
---

v4:
- add Reported-by and Fixes tag
- use unevaluatedProperties: false to fix dtbs_check warrnings instead of
  add 'bluetooth' in st,stm32-uart.yaml

 Documentation/devicetree/bindings/serial/st,stm32-uart.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/serial/st,stm32-uart.yaml b/Documentation/devicetree/bindings/serial/st,stm32-uart.yaml
index 8631678283f9..305941b1d5a0 100644
--- a/Documentation/devicetree/bindings/serial/st,stm32-uart.yaml
+++ b/Documentation/devicetree/bindings/serial/st,stm32-uart.yaml
@@ -80,7 +80,7 @@ required:
   - interrupts
   - clocks
 
-additionalProperties: false
+unevaluatedProperties: false
 
 examples:
   - |
-- 
1.9.1

