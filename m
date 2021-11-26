Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D15845F09F
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Nov 2021 16:24:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378205AbhKZP1A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Nov 2021 10:27:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349756AbhKZPY7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Nov 2021 10:24:59 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EEB8C06179E;
        Fri, 26 Nov 2021 07:17:43 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id j140-20020a1c2392000000b003399ae48f58so10945955wmj.5;
        Fri, 26 Nov 2021 07:17:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OLdg7HwQbvAV+brizYiBW+l2eqA2RggMeGyT4QmZCLk=;
        b=CDwmcHb2iG2QOeb1CvlOm9RbdSKzrqFe7BekiXZt4K+vmADjoAvzYV0+4c3zNnx2/7
         uKerd3PNgCDQzuOvqVkyOTOEvXhzD8N4Sk1JDfZ0zdnB1tMhWNNpj1XB/3SePak6Muus
         aBpjWtiYja+nVVEE3XLRhBx9M6EJFvtDafchSTr43ajNdrssGZ6DQMNJYAftwqaReYVX
         lXNcQ+0mh3mXLzEGiGZxJ7YH70jp/OEprOb7+74pXNNgVqLVNr/Lr/iigSUy1gYsYe5J
         BaL6+/s9T/cTpXzWjgSgz3oO62EwdmcTGGalhguiFWs5nERNBQ4YSBDw14Qn8LyXoz2q
         S2oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OLdg7HwQbvAV+brizYiBW+l2eqA2RggMeGyT4QmZCLk=;
        b=JEJnYsp8l8/BAkfc2zlBpQPLar8vjQN9cgaifi1g/Hum+Pk6cel0sar0kmNQ/LnF8w
         s90wAGQsw1MeQWq3NNRaGBO0CUHiSQ8vrncoWE635lHVURExZBNADXzpqfmfgJKU9YWj
         wo8lDCWkjJO1GHjR9Gc+EbBU6a0t/NjGh8qOCkmdMSbfXNyx2KvUO0GkMGcZj1xQXXUu
         mkJA8Doh50kyMJjAFEHtBmYq0zXWOisWAJoXhml/rOg0yu+m8si9SvnCuyOB2NagoEW3
         1g325SImM+YMESHPpZJXBKf7LJ/4CrWEDE5+QBunA7ZByEa2VkNE9buSccNW1NnNXbOn
         U3QQ==
X-Gm-Message-State: AOAM533hBGcxAjP91//MPgggP/tUVVONCAq/xW07b4TIM/1BQ4JG6iNW
        +/jQua/Gx4asqELntdIxxg==
X-Google-Smtp-Source: ABdhPJwU44ffPVjwrN172U8Rre7Cpin6zr+0rXftU1O55iV/+oAQIjFNWHd9iv8RRByAGuzvl1GFTQ==
X-Received: by 2002:a1c:4d8:: with SMTP id 207mr16246637wme.23.1637939861901;
        Fri, 26 Nov 2021 07:17:41 -0800 (PST)
Received: from alex-ThinkPad-E480.. (ip5b435a69.dynamic.kabel-deutschland.de. [91.67.90.105])
        by smtp.googlemail.com with ESMTPSA id k187sm12323496wme.0.2021.11.26.07.17.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Nov 2021 07:17:41 -0800 (PST)
From:   Alex Bee <knaerzche@gmail.com>
To:     Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh+dt@kernel.org>
Cc:     Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Ezequiel Garcia <ezequiel@collabora.com>,
        Alex Bee <knaerzche@gmail.com>
Subject: [PATCH 4/4] arm64: dts: rockchip: Enable the GPU on Quartz64 Model A
Date:   Fri, 26 Nov 2021 16:17:29 +0100
Message-Id: <20211126151729.1026566-5-knaerzche@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211126151729.1026566-1-knaerzche@gmail.com>
References: <20211126151729.1026566-1-knaerzche@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ezequiel Garcia <ezequiel@collabora.com>

Enable the GPU core on the Pine64 Quartz64 Model A.

Signed-off-by: Ezequiel Garcia <ezequiel@collabora.com>
Signed-off-by: Alex Bee <knaerzche@gmail.com>
---
 arch/arm64/boot/dts/rockchip/rk3566-quartz64-a.dts | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3566-quartz64-a.dts b/arch/arm64/boot/dts/rockchip/rk3566-quartz64-a.dts
index 4d4b2a301b1a..625489c60622 100644
--- a/arch/arm64/boot/dts/rockchip/rk3566-quartz64-a.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3566-quartz64-a.dts
@@ -205,6 +205,11 @@ &gmac1m0_clkinout
 	status = "okay";
 };
 
+&gpu {
+	mali-supply = <&vdd_gpu>;
+	status = "okay";
+};
+
 &i2c0 {
 	status = "okay";
 
-- 
2.30.2

