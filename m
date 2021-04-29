Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B073436E772
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Apr 2021 10:55:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232400AbhD2IzI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Apr 2021 04:55:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239890AbhD2IzH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Apr 2021 04:55:07 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31C2EC06138B
        for <linux-kernel@vger.kernel.org>; Thu, 29 Apr 2021 01:54:21 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id w3so98750720ejc.4
        for <linux-kernel@vger.kernel.org>; Thu, 29 Apr 2021 01:54:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Okh7SCTJDi6w4nnu7QO5qBG/v+E7WIC+sY8y8/WILM0=;
        b=u8Vd2oGaTMPpqhwHEz69+5zFmMPmIW3Xe+oOdNQOxMxVkTrl+SeLoyuD0sKuN5RD2l
         u9MVW+trx+Evc55frr7/kM0Jc+c5ICqksesG26zRL8EzYE6hWhF1lujGIqCgmJTGJ7yv
         7KQkm/Z/HxbwntAviIeZVJZ4OJ/2HUalcwNFUpfL/5tPLKGmyjZY2RxsIVJq9az/0jdc
         3gGWYlvf9GwqQbJbg1fTQDlBjWzYe0kO9lhBGQQ/O9yBSgNqwSj4ShtlKxQy205ti5Lq
         d0KLW9gNA62xYvdWammNPJP7+crCLRDXbFhQlRrQBzpIfqrsjn3DYm6W+SD303KGUmxK
         tBiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Okh7SCTJDi6w4nnu7QO5qBG/v+E7WIC+sY8y8/WILM0=;
        b=KtRr6HNH0nIX5tF/+jnGEXQhXIJtFjkPSr38tU6UmZP6JnmU0lqI8W0MTVbrKTDOMu
         eTNBYt/1FEqnWYH1Xohj1/YCCBko0GYCih0YqmEvtT1U+lmfRE5RxsXbqu0MG6XQiaK1
         GD4UD710/HkQ1QuDVjWHY/tEmcusWI5N3DK7EU6MildLsaVOX8FulO7sInM4xR8oqWaZ
         Ekyyc9E3Z6mQsVYWPAd9/aIYH8uTAnyccnRiOKxmeaj4Dah0rsHle6h1c1s5KpwQ58gz
         C0A/U4EbKWynU6djloVW7iXvfTBN282EJ1fyjUXT9aCttfxg2Kl0oxQZB6toM/ZC3+2m
         NcmQ==
X-Gm-Message-State: AOAM530GW1Y8tIdueP0UQVMHH3py5ybsMe+1s5b2/SBxL5D41pNdddSp
        NyGCxlHf/pvDnyuCl0L+SQSEY8lzKAoCv5e4
X-Google-Smtp-Source: ABdhPJwJoIa+rgy+CBsStAafFHpT7XKNSzhMNvbJHyz88GZFb+n1fhDg1aSkROswvEIgI77W9+pK7A==
X-Received: by 2002:a17:906:2bd1:: with SMTP id n17mr22869220ejg.371.1619686459979;
        Thu, 29 Apr 2021 01:54:19 -0700 (PDT)
Received: from localhost.localdomain (82-65-169-74.subs.proxad.net. [82.65.169.74])
        by smtp.googlemail.com with ESMTPSA id x9sm1835847edv.22.2021.04.29.01.54.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Apr 2021 01:54:19 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Kevin Hilman <khilman@baylibre.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH] arm64: dts: meson: vim2: enable highspeed on wifi sdio
Date:   Thu, 29 Apr 2021 10:54:13 +0200
Message-Id: <20210429085413.60368-1-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable highspeed mode for vim2 sdio. In theory, the vim2 SDIO bus is
capable of handling SDR50 mode but this needs to thoroughly tested.

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 arch/arm64/boot/dts/amlogic/meson-gxm-khadas-vim2.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gxm-khadas-vim2.dts b/arch/arm64/boot/dts/amlogic/meson-gxm-khadas-vim2.dts
index 18a4b7a6c5df..217f9d6d470e 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxm-khadas-vim2.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxm-khadas-vim2.dts
@@ -307,6 +307,7 @@ &sd_emmc_a {
 	#size-cells = <0>;
 
 	bus-width = <4>;
+	cap-sd-highspeed;
 	max-frequency = <60000000>;
 
 	non-removable;
-- 
2.31.1

