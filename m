Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 468A839D56D
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jun 2021 08:54:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230210AbhFGG4l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Jun 2021 02:56:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbhFGG4h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jun 2021 02:56:37 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E39CC061787
        for <linux-kernel@vger.kernel.org>; Sun,  6 Jun 2021 23:54:47 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id h3so9278887wmq.3
        for <linux-kernel@vger.kernel.org>; Sun, 06 Jun 2021 23:54:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cUdkaQG5aCgHatEguGsmkfAI10h8bEeuy1goie3+ZSk=;
        b=WDso6HKZrHk1K6rSvjJhR4nNZ0jhdzTEAfy01D2gMmQ86WwgcUQ+9+grT0ELB4f5Pm
         zuZNjO8THQADGJ5JNEPzpqgFg5YxLzEhOtZejkefqIoVljGN2gz8AubzhxM6kAMi/k3k
         wRW5ilAq8I3Wj+MveeCIFXfKIf/kPRbuiysBSRTQCleZZ500El7UNsHEnZWZU8TdZe6J
         H93XFuVSq6juUZHyF3za1ucdrRDwKRMrkTdq6qHBgMgOw9ZxywRPZjvwE1FkxDAAO6yr
         9SGbC35h1Tt7SdHdMKOoFc3VPTQYF4s3ZPcyNttTK5DnwlG77ka0BMJI8sUSBDJO2C5D
         bhfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cUdkaQG5aCgHatEguGsmkfAI10h8bEeuy1goie3+ZSk=;
        b=DvZQ691Kj/83IWG4g87vs+Cio5nEJzUkQk2650mH2cu0ZqUY6Q+V756SgLdE89G8vP
         PFgK6Wb31ru+aMuT/oQxgAK0ju2xXA4tkgBdd5xVfKUT8XxALh3k0zeSk3YK9MTswEh1
         5p+tBqkjLKKcO7+8WLsiUrFmdclQNerd4GtHg2J+Dugbo993WfoYZ9A3C+mQgnLwZ7Ac
         KZUljTrFJ7kthC5G7ySHBOyqSWdf3y257kprHT0KUzruHwYf0svs6O6bOAMfUtM2nih2
         Jk0kQ0FxSiLA5mD1P/cKfHskLqKRYe95lFv06H8z4uTuyBbPCwzgtxXCfD7mV4if1D7W
         zkfw==
X-Gm-Message-State: AOAM53383mJd16y5av9HW0quQpptQHX6Zwa2LnxXZSC0hjgKhEgQFvCT
        xTrb29GbltSX+F/OXbkQQGuzKA==
X-Google-Smtp-Source: ABdhPJwiDNdO6oTLu7kFd7H0SHtUmizxfdESY8WoOZ2WbTXoMX1kTqyAoudgxGWYwU+AcPBph6qy5w==
X-Received: by 2002:a05:600c:4e90:: with SMTP id f16mr15450015wmq.116.1623048885543;
        Sun, 06 Jun 2021 23:54:45 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:90c:e290:7c1f:1c9f:555e:7398])
        by smtp.gmail.com with ESMTPSA id l5sm16145742wmi.46.2021.06.06.23.54.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Jun 2021 23:54:45 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     khilman@baylibre.com, jbrunet@baylibre.com,
        martin.blumenstingl@googlemail.com
Cc:     linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        tobetter@gmail.com, Neil Armstrong <narmstrong@baylibre.com>
Subject: [PATCH v2 2/7] arm64: dts: meson-sm1-odroid: set tf_io regulator gpio as open source
Date:   Mon,  7 Jun 2021 08:54:30 +0200
Message-Id: <20210607065435.577334-3-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210607065435.577334-1-narmstrong@baylibre.com>
References: <20210607065435.577334-1-narmstrong@baylibre.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=986; h=from:subject; bh=9RLJIF8542k5weQ8o009+F4gMN3x44LN7xQPDqGEmsI=; b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBgvcJAXfvdglKywKTI3zwqpiZBdnc9f53ieiHONJqJ /T7QyESJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCYL3CQAAKCRB33NvayMhJ0fuhEA DH5yC5rmFUKnbMibJEA89uOMJVjNIKJbMkhgeQb3A9FLzpA89+FkDZMtJFMNU3ahtxQ4R9cA01evu8 aRoEf7R69nXafiZPEvVfOGrf4gCU+suKtb16/OWdDk1epugGSh3raj9eLz0ZLTvp1qP7GxvQHXK6eU wJdr05M+5S3k67QOkurhB9qlrwH7y65K1u4K3OF7vjVNkw3AvKuCh5NXVE6nYeqvfLgtO9OvCFwbeK mJrjCj5fnCj1gevTH3DqU/94OBmh5CBSNaUl1pnwgA0lgdYXjYqyePAIoUDQ/4K1vd0f7tCXk5hFwg ohVHt10mzanN60rPgvrDsNTL9jBvZJPxsmp4PRN15TKlF++K8/ijW4mMFpWHR/XM4QQe7JlT8F95cs lX7n/khxFQxaquW7Uxn4ZRibsiRvq6RV0mNCf6lnLzOC9zRszE3bCefodUFUJayu7abrUfwPJ3n8+f kRmgFTUiy6yWAB0DBiFJ8tShhHwos8lWqv5jewzQ9YBEwSynEgveuQLUGJfosiBM04mwGpR8inWcTV PivNB6hpkwOuL3G0vyCYoo6AGjv74RMEc+GWk/ZCh4RCtds2AM3k9HDisY0NGU1ZQX0/VDHBBvnzVu iZ29NaEh3l0yZfetc290mdux0TLUaT7Ff6IkVCuqZ/1+n6AcP7vbTI0jzDbw==
X-Developer-Key: i=narmstrong@baylibre.com; a=openpgp; fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According to Odroid-C4 & HC4 Schematics, the TF_3V3N_1V8_EN can be in Hi-Z for 3v3,
and since it's the default GPIOAO_6 mode at reset, let switch this GPIO as Open-Source
to drive for 1, and input for 0.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
Acked-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 arch/arm64/boot/dts/amlogic/meson-sm1-odroid.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/amlogic/meson-sm1-odroid.dtsi b/arch/arm64/boot/dts/amlogic/meson-sm1-odroid.dtsi
index af40ba461074..e64359163331 100644
--- a/arch/arm64/boot/dts/amlogic/meson-sm1-odroid.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-sm1-odroid.dtsi
@@ -52,7 +52,7 @@ tf_io: gpio-regulator-tf_io {
 		enable-active-high;
 		regulator-always-on;
 
-		gpios = <&gpio_ao GPIOAO_6 GPIO_ACTIVE_HIGH>;
+		gpios = <&gpio_ao GPIOAO_6 GPIO_OPEN_SOURCE>;
 		gpios-states = <0>;
 
 		states = <3300000 0>,
-- 
2.25.1

