Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81AF0396FBB
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jun 2021 11:01:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233374AbhFAJDd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Jun 2021 05:03:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231139AbhFAJDb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jun 2021 05:03:31 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46816C061756
        for <linux-kernel@vger.kernel.org>; Tue,  1 Jun 2021 02:01:50 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id h5-20020a05600c3505b029019f0654f6f1so511947wmq.0
        for <linux-kernel@vger.kernel.org>; Tue, 01 Jun 2021 02:01:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=V8v8K0WEFQXEEpVnmTau1yLxHgljrFOj3yQnNjaehaA=;
        b=iFUIAErs8JLqTNy9uNleZtAnAx0vA6v+e75ppi6rvwxT93N87zBXVJTvl6lcU+0fU1
         ufFccw6XOvN31uymyqoPTIZmZHOhGocNwkBqunbMytlNf4R9allT16yw0hxyMHEZeEGw
         iF1NK8nYAB96iVymjwI4bpLWRDfXeiuP5wCfjBpqbYG9olK7mhw/4xIqE7FUJiyjeb8U
         OyJ6zHh2ez8RJQ52LcF9JHKE2DRbC42md67fIB0ZaTAKe8c1n5KonbIK4ufgKcFqFIow
         i8bdSrSLVfxIeN+xRw7mfMmSqwYiY/8Whm7VK+dpRFMPVYQeV7ldPU29G2WDJC8YKfzL
         9HPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=V8v8K0WEFQXEEpVnmTau1yLxHgljrFOj3yQnNjaehaA=;
        b=G4Wvmzt+nqn6ps6mW3UvSpPO3ZcHou7X3lQlaJopX9MWCnraTLMIk+W8GPLQbIj4qC
         QO/5N3oDHSDjiC2N9lRh4z7Vm8GhedyhqbRu20XQj1u87yVgk/bxtdT+x5drzM7jg3A7
         RcjkkFgXzriWJM63VrIDWG2jS/rb9/RpP4N//5u/49GZAAX8YxfVqgZjVCQ25Zpi5tqo
         WSQS9IW8X0P+OfI+wUyXvtA3tjFbuhXuQjuYUyM84j59f1omFygSRcS8gU1FmCSxvoUG
         /yfvJxGswZKLtIS/35oKKjLC/An7//fHFqrRKtRoksE+Hhd6V0VQqHT3DoQdJGHjTuY0
         OZ+Q==
X-Gm-Message-State: AOAM530NOyLlmx6ouJsMmIpp+HRaZ+DgGrT0aWz+LLmE475OSP777C2u
        cksp3dRNurt6GSHkfhCwGHU9xA==
X-Google-Smtp-Source: ABdhPJxDNxuOkjVgNefIggbTpiKRLLV2xHre6tqn1iyIf9M+pn1DShFD1K8iVmz/2E5qaPEyNU+uQQ==
X-Received: by 2002:a7b:c5cd:: with SMTP id n13mr25507536wmk.97.1622538108830;
        Tue, 01 Jun 2021 02:01:48 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:90c:e290:a3a:d001:6a80:207a])
        by smtp.gmail.com with ESMTPSA id e17sm2668199wre.79.2021.06.01.02.01.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jun 2021 02:01:48 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     khilman@baylibre.com, jbrunet@baylibre.com,
        martin.blumenstingl@googlemail.com
Cc:     linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        tobetter@gmail.com, Neil Armstrong <narmstrong@baylibre.com>
Subject: [PATCH 2/6] arm64: dts: meson-sm1-odroid: set tf_io regulator gpio as open source
Date:   Tue,  1 Jun 2021 11:01:36 +0200
Message-Id: <20210601090140.261768-3-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210601090140.261768-1-narmstrong@baylibre.com>
References: <20210601090140.261768-1-narmstrong@baylibre.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=998; h=from:subject; bh=9yMaHLPwe3jWkljS8fsiiW3t+WKkLEJUslG1TXLuy7Y=; b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBgtfc7olCqrUutdL0HKLAMaFWLCLUomQM2i5k6iVcw BQqPhYSJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCYLX3OwAKCRB33NvayMhJ0XmVD/ 9C1zwhHGaNkdYGhxO1DNFGEv78p5VHlsBqsd2cZvaA1vpZQm9TjTjfaB1psyZFNF+VP/9F3Ut6IuZF NtU2wmoKvv4P4tqlwikpghwd9hnYc0vcVtzpLrJL9pDjqTApqPXSuzQrtmFpnMlWNgEaMSXXITTEE+ M2DPho0YxlX9nRwP9YVSkLk6rSNhznxUSYbevCgWBVkgUGZFJfAYFQgmBzWbBVypJpjMGIkIOA51ww X1wMq4wZT7NwqdWFx6FYPoeOV4IHNTr3zuHESCSz/CcTCodaf81EZQt+O1TorioBrJUpERgimsakhA MAa2fIhPXg3ggJYx3lwsqfkyzjNBCv0K0DjGZaN6xOrmgzeR2cAFX5Yx0njg+Qi1A47zCNuPaJBFcD 2yFU0W6Ft6f18ZxWwrtsC9VVvwRb6UJMHmC4JIHOe6U1qDE8/AfeHYWg/GiIDkholWzJT34I5LJmRa dog0tVFUai1GRV2jSPTtxmi6Hy8BG8YM/Bdw2N6EbxWGVBFWJd0fZ5JIT1OC+BCOsKgn0XOq5h2qLj NQ8ryQ9MVNqIgvA3M+0tpe2x2MCz+uUCVcm3yAZ6LcDlRGAlKdfHgWadi5PD7KmxuO05wp7Q0x3PVV ebrd5YGquacK19hGE18LZjGqWyRW5A8y81Y4DBUvuTNRHKgZxHS06ESN7ceA==
X-Developer-Key: i=narmstrong@baylibre.com; a=openpgp; fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According to Odroid-C4 & HC4 Schematics, the TF_3V3N_1V8_EN can be in Hi-Z for 3v3,
and since it's the default GPIOAO_6 mode at reset, let switch this GPIO as Open-Source
to drive for 1, and input for 0.

Fixes: 88d537bc92ca ("arm64: dts: meson: convert meson-sm1-odroid-c4 to dtsi")
Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
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

