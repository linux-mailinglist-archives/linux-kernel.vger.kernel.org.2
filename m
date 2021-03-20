Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CBCF342F51
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Mar 2021 20:39:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229884AbhCTTil (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Mar 2021 15:38:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229931AbhCTTi0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Mar 2021 15:38:26 -0400
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54878C061574
        for <linux-kernel@vger.kernel.org>; Sat, 20 Mar 2021 12:38:26 -0700 (PDT)
Received: by mail-qk1-x72c.google.com with SMTP id q26so1312268qkm.6
        for <linux-kernel@vger.kernel.org>; Sat, 20 Mar 2021 12:38:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=THHtOHJ2QSwi0+iA0Mh0rEnwX2U/sRTGXnqHyCuZamk=;
        b=EcjvksHHWZ8hEZ86c4VJi0wDsYEvj0fMfA7wQWnKEoSbS8/fn7aqjCwLRuIOEjda9x
         pMwrb1Gh7Ma7mzqOJj5nSrsXuec2N24+jxgCi/ftz0Rz4RFxsCGk2+WOfb3+BcU/HMzB
         y1PuCwJ8dpyvkeXGUgO3KDQ1U0SQjzeXdJCPw1EvmzG7zh1GcTUPskvDAIsXbn1WRZer
         CmWSn8HVdBJ07S/JBIL3+4BB72DQ79rxd6S0JY6cw8bvzZmh2F93QwIo4KLL6OHYdXpo
         tqJ+pPD5zWlk/CHUIVN4Ozma8C9PE67KC7WUSsto5HqiPSdlVZuZRKkc3JRneari4T34
         3z8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=THHtOHJ2QSwi0+iA0Mh0rEnwX2U/sRTGXnqHyCuZamk=;
        b=aW3XT9z5E/gUVfngNm8y155tK7haUtHdBBmhrVdIVqmB3qwxqQ2IYdUq4UUTyo7oE1
         OpJArnKtk8jcAQFWHVtsnGWhgtai4ts6zaiXruDjxyS08HpGHumvGmDAI4XjRzGYaL3y
         bGelog90lshJ5gqfzGtgGivyLImpR7t+hfUHRWC0XUiphLMPmamUUsvYIphtbkw4g+fz
         Um16B3q5/yIOuL0UGBFFpqgnZZirNZA/Co//o+sM6RvkY6rTJ4pniocTJaGKFb/TJskX
         pRvGFyOdrXl+jL6nr2xtflAGyuBJ0ONYacU8Ui8vjRcKWBUzLbX9JCMpfHxM/YMY8kEL
         m4XA==
X-Gm-Message-State: AOAM5318fnZFg351d8ohiP3JDP1Q0sDV52FpOTjwfpePCTFqtNsCYAO8
        uZLa55TTM6bt29IziMnvfE+2VJrFmpWIrw==
X-Google-Smtp-Source: ABdhPJw/DOfogFq0h76HEAE7ohkiLVYRq72K3ym2ssShDYmgbVVaZO9Bjf8PIvrcFxtUT4DhMlwxDA==
X-Received: by 2002:a05:620a:135a:: with SMTP id c26mr4162982qkl.110.1616269105475;
        Sat, 20 Mar 2021 12:38:25 -0700 (PDT)
Received: from tong-desktop.local ([2601:5c0:c200:27c6:f925:bb4b:54d2:533])
        by smtp.googlemail.com with ESMTPSA id a207sm874713qkc.135.2021.03.20.12.38.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Mar 2021 12:38:24 -0700 (PDT)
From:   Tong Zhang <ztong0001@gmail.com>
To:     Lee Jones <lee.jones@linaro.org>,
        Rikard Falkeborn <rikard.falkeborn@gmail.com>,
        linux-kernel@vger.kernel.org
Cc:     Tong Zhang <ztong0001@gmail.com>
Subject: [PATCH] mfd: intel_quark_i2c_gpio: fix write to const mem
Date:   Sat, 20 Mar 2021 15:38:20 -0400
Message-Id: <20210320193820.72057-1-ztong0001@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

intel_quark_i2c_res and intel_quark_gpio_res are written by
intel_quark_mfd_probe. Making them const can cause page fault.

[    1.319934] BUG: unable to handle page fault for address: ffffffffc00be140
[    1.320296] #PF: supervisor write access in kernel mode
[    1.320571] #PF: error_code(0x0003) - permissions violation
[    1.322419] RIP: 0010:intel_quark_mfd_probe+0xb7/0x23e [intel_quark_i2c_gpio]
[    1.327670] Call Trace:
[    1.327800]  local_pci_probe+0x48/0x80

Fixes: c4a164f41554 (mfd: Constify static struct resources)
Signed-off-by: Tong Zhang <ztong0001@gmail.com>
---
 drivers/mfd/intel_quark_i2c_gpio.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mfd/intel_quark_i2c_gpio.c b/drivers/mfd/intel_quark_i2c_gpio.c
index fe8ca945f367..84ca7902e1df 100644
--- a/drivers/mfd/intel_quark_i2c_gpio.c
+++ b/drivers/mfd/intel_quark_i2c_gpio.c
@@ -72,7 +72,7 @@ static const struct dmi_system_id dmi_platform_info[] = {
 	{}
 };
 
-static const struct resource intel_quark_i2c_res[] = {
+static struct resource intel_quark_i2c_res[] = {
 	[INTEL_QUARK_IORES_MEM] = {
 		.flags = IORESOURCE_MEM,
 	},
@@ -85,7 +85,7 @@ static struct mfd_cell_acpi_match intel_quark_acpi_match_i2c = {
 	.adr = MFD_ACPI_MATCH_I2C,
 };
 
-static const struct resource intel_quark_gpio_res[] = {
+static struct resource intel_quark_gpio_res[] = {
 	[INTEL_QUARK_IORES_MEM] = {
 		.flags = IORESOURCE_MEM,
 	},
-- 
2.25.1

