Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA17A3A37E1
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 01:28:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231284AbhFJXar (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Jun 2021 19:30:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230269AbhFJXaq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jun 2021 19:30:46 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFEA2C061574;
        Thu, 10 Jun 2021 16:28:37 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id h22-20020a05600c3516b02901a826f84095so7410371wmq.5;
        Thu, 10 Jun 2021 16:28:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fY39Ptk0sw5qXBAnjzWmLKrEgOiYPHLxRS1HTe3/ra8=;
        b=a/MiVDn1JdEQF9wRpjW4aEDvLn1WR4dUr3dVfjAg2cV8yAdEsdR/hsZXp3Qxwq21Sd
         4TI/x+j1vfVV5nfCkZe/1T6aPR+FAYy3wjVksI/ryDaU5Y7oyWLd46Bgi71YqG1pC/tv
         Sft8hMp55HpAxY15hgXgls8SpkoWrsV3I4g9FU1uDIQ8vuNEH4BF/dTOqshCjrPOk22V
         CTHZai335bSowLt1rNe7zUYkrGBMSkVtiJp67O7cCvA052LmtQTGXo067npFVKPZQkss
         IoZVnZXCLAbXcsmTGV3mVqp6AVlw17PUr7w/iLvuhLjf61YtWsjCCImhia2CbSCpiEKj
         1z7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fY39Ptk0sw5qXBAnjzWmLKrEgOiYPHLxRS1HTe3/ra8=;
        b=XBbNsSvb4ne3n2EvuS6tffvl381CcuxCAaWr2P5zWF3Xbvx3wRWbRy/QM3gMxSPf/+
         Q5Zy2wkEodRWHG8GQZbESzVWad0VOglj/CQEQXic0dZxWqYJXm6EnKRlY4gGQFi3b5Hm
         YMdwDuRgE02VGwTTbHH0w+EBLGB8wFimvpHGjsIB39dBdIAdaMGkoy4oKmsQ7PfsAQRO
         aaQGL97T9Vqq0xo5MtQqK+RxM4UcxfZbdmIdCUEVsZYYRvBzS95tIsKdxmwvP3Bk88E7
         a0GmYQnCPr3D9HHvLTGV0tDVxdEZjOiw3CSqLTRcLE4uMwrmF6fQyOshlS6hCKsw3Iec
         zxow==
X-Gm-Message-State: AOAM530FfgNY3MzZxIHn8JmA+vTgNcOLF4FTUXSxV3dpkegSRDsjAdSK
        B0GwHnpTYV5IeI0nTgvUZJk=
X-Google-Smtp-Source: ABdhPJy+s2yIZkcJEiGe84bEKlWeqiQEB0JakPzVhGXnIuj7SAMYOp9sVBFq4Je+XRMXvzk1PZe56w==
X-Received: by 2002:a1c:ddc3:: with SMTP id u186mr17327237wmg.44.1623367716526;
        Thu, 10 Jun 2021 16:28:36 -0700 (PDT)
Received: from cluster5 ([80.76.206.81])
        by smtp.gmail.com with ESMTPSA id o7sm5433527wro.76.2021.06.10.16.28.35
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Thu, 10 Jun 2021 16:28:36 -0700 (PDT)
From:   Matthew Hagan <mnhagan88@gmail.com>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Matthew Hagan <mnhagan88@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        soc@kernel.org, Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Sam Ravnborg <sam@ravnborg.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 2/5] ARM: dts: NSP: Add Meraki MX64/MX65 to Makefile
Date:   Fri, 11 Jun 2021 00:27:14 +0100
Message-Id: <20210610232727.1383117-3-mnhagan88@gmail.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <20210610232727.1383117-1-mnhagan88@gmail.com>
References: <20210610232727.1383117-1-mnhagan88@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add Makefile entries for the Meraki MX64/MX65 series devices.

Signed-off-by: Matthew Hagan <mnhagan88@gmail.com>
---
 arch/arm/boot/dts/Makefile | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index f8f09c5066e7..033d9604db60 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -154,6 +154,12 @@ dtb-$(CONFIG_ARCH_BCM_NSP) += \
 	bcm958525xmc.dtb \
 	bcm958622hr.dtb \
 	bcm958623hr.dtb \
+	bcm958625-meraki-mx64.dtb \
+	bcm958625-meraki-mx64-a0.dtb \
+	bcm958625-meraki-mx64w.dtb \
+	bcm958625-meraki-mx64w-a0.dtb \
+	bcm958625-meraki-mx65.dtb \
+	bcm958625-meraki-mx65w.dtb \
 	bcm958625hr.dtb \
 	bcm988312hr.dtb \
 	bcm958625k.dtb
-- 
2.26.3

