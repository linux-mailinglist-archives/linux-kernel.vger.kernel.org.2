Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4A2D365DC2
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Apr 2021 18:50:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233300AbhDTQue (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Apr 2021 12:50:34 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:49809 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233254AbhDTQua (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Apr 2021 12:50:30 -0400
Received: from mail-ej1-f72.google.com ([209.85.218.72])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <krzysztof.kozlowski@canonical.com>)
        id 1lYtZV-0003WO-R9
        for linux-kernel@vger.kernel.org; Tue, 20 Apr 2021 16:49:57 +0000
Received: by mail-ej1-f72.google.com with SMTP id ji8-20020a1709079808b029037c921a9ea0so5016169ejc.9
        for <linux-kernel@vger.kernel.org>; Tue, 20 Apr 2021 09:49:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+QGIfs0xu2iWGBhjfxFAoqeLLE0TQoKKNcQGnUSArgQ=;
        b=uaBwnRrt26dUZiGu2HH2J+Qvoj9g2LkQSnX8ZJ1suULEUbqPuj5zn8cmIzcJw5MsQH
         FkD4ba48JdTmkp4v9Ea1Phai49Yf0uZXCwiMuIIL6HJWUiPqeQcQz+aSro9/cjxqYxJ/
         ekRJyH9vMVxHMA34db0KtJT8mrkem/ZSRrq2DXiWukjKEMmw54XSJ4DCrt+p7zbYaUia
         VNdO/MTMwvAtEZKsX18n12a3npd5SqdReiTGGAcFVIrujlMzZFcNf45o104Fy6G/hnk9
         cGENS5UKkRXK4KyKegRH3lyMhKSE5BMxcVLEJ+25rjYynX0YSM9x5alqT00Z/hUSfKlt
         jRxw==
X-Gm-Message-State: AOAM532JR0MVrH1xkC27UD4O3wWONSpYQ0r1vaJXobC6nM929dehIMzE
        0ScAfpq65IgIf1qFCLdv74Ito+gkVNfvw8xV/2W6CEHQZmym6udAV9YnxWeGG9kdt1CwwrtKdNz
        ak2+jAJnXWeKdklmal6Bqwl43XQYhodnqgRJXTmqAOg==
X-Received: by 2002:a50:cc4b:: with SMTP id n11mr33958121edi.186.1618937397620;
        Tue, 20 Apr 2021 09:49:57 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzFpLXaO26NoPnHh4aEiGAmvUqWmrI333nb0Yo3aHX7WOiiVNvUBOWtMLlzw59fq5NlWZRiHQ==
X-Received: by 2002:a50:cc4b:: with SMTP id n11mr33958102edi.186.1618937397373;
        Tue, 20 Apr 2021 09:49:57 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-180-75.adslplus.ch. [188.155.180.75])
        by smtp.gmail.com with ESMTPSA id c12sm18252873edx.54.2021.04.20.09.49.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Apr 2021 09:49:55 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 05/11] ARM: dts: exynos: enable PMIC wakeup from suspend on Midas
Date:   Tue, 20 Apr 2021 18:49:37 +0200
Message-Id: <20210420164943.11152-5-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210420164943.11152-1-krzysztof.kozlowski@canonical.com>
References: <20210420164943.11152-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The RTC on Maxim max77686 PMIC can wakeup the system from suspend to
RAM.  Add a generic property for this.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 arch/arm/boot/dts/exynos4412-midas.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/exynos4412-midas.dtsi b/arch/arm/boot/dts/exynos4412-midas.dtsi
index fc77c1bfd844..968c7943653e 100644
--- a/arch/arm/boot/dts/exynos4412-midas.dtsi
+++ b/arch/arm/boot/dts/exynos4412-midas.dtsi
@@ -668,6 +668,7 @@ max77686: pmic@9 {
 		interrupts = <7 IRQ_TYPE_LEVEL_LOW>;
 		pinctrl-0 = <&max77686_irq>;
 		pinctrl-names = "default";
+		wakeup-source;
 		reg = <0x09>;
 		#clock-cells = <1>;
 
-- 
2.25.1

