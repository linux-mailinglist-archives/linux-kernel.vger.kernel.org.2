Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D34F3BA613
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Jul 2021 00:52:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231132AbhGBWye (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jul 2021 18:54:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230104AbhGBWyd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jul 2021 18:54:33 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69AD0C061762;
        Fri,  2 Jul 2021 15:52:00 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id c17so18578510ejk.13;
        Fri, 02 Jul 2021 15:52:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DrJ8vO1HssWxZ8Acjo/rbz8cE2rHN+SdBic4zIrJJMs=;
        b=ehFBsvpjSBEY74b8LNx4yff1LMl97sdYtBT2LyhV8U4Fdq49km4EhVnCpTC3lTkmru
         SvrpWcY6++4BQcuozbiS2tIC9XdEb8eVXqC9kU3ek6g/V0e9OYXS8f8WEZn6WjwnvF31
         3M+Z/CLaOGrONS0nxXQnKWZyDTdXBaQ10s8YBUCK5ucya8XR/RButCeORfna5pPchtbi
         BRsb7wHS07wL1IMbhkr2I5/p00OTIsrh9BVhvEuBG5eppS+v2XMku2257mV2VCJiKZde
         PaGwnLlb3uUjRl+yKcZzE4DVtutJaj2c+RD6DtasDSktpJEFv7Lvx7O+6M4eeKTnx0pB
         tLKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DrJ8vO1HssWxZ8Acjo/rbz8cE2rHN+SdBic4zIrJJMs=;
        b=VAselzc/LhROotZgFauqWmkAjpsN0Bs6fTqRbiXV9K/tJP5nUVdbTG3hZV04r+U313
         7Pm6e6hWnD2/UKZLCTCjJcDWgb7D13mAfEbhsI7quyEf+tYjBk8dPFtGH4DfJdNPoPj7
         S3nKe8dvhVvDSYFBxRUpyeaXlEaP4+QrWtwMqTJsj030ZQDOJWUi4nYkwit7V/oOwjq7
         VTIIuEyFiH0Nu+B6pTbefFaMrDtgcB0VVYVgtHQfNkf2yphhza9UoacZo6/6QDi+0Q3t
         ViYH909F8oY9u0Sc9Wy0Uyt2/7twXcNrYcFPOofLtmFkaegTYPpjGefTlJFEm6M1RUp0
         06+Q==
X-Gm-Message-State: AOAM530CPA+ivjt5Y0uBTOeeN2eiRs7q0siLD/GRgNrrs0GoVqG+K71n
        XPxBRFKg+8hyPDAL4xen4zGHEfWx1mg=
X-Google-Smtp-Source: ABdhPJxTJSdxKuhnuggAFqvSl4jKwN16HmCiTpwLaotzMJhT5pNiE90uQl7XEfyNpmrg5b5X0dJC8w==
X-Received: by 2002:a17:907:7252:: with SMTP id ds18mr2044138ejc.227.1625266318870;
        Fri, 02 Jul 2021 15:51:58 -0700 (PDT)
Received: from localhost.localdomain (dynamic-095-117-063-046.95.117.pool.telefonica.de. [95.117.63.46])
        by smtp.googlemail.com with ESMTPSA id r17sm1866964edt.33.2021.07.02.15.51.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jul 2021 15:51:58 -0700 (PDT)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     linux-clk@vger.kernel.org, sboyd@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH v1 0/6] clk: switch dividers to .determine_rate
Date:   Sat,  3 Jul 2021 00:51:39 +0200
Message-Id: <20210702225145.2643303-1-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a continuation of patch #2 ("clk: divider: Switch from
.round_rate to .determine_rate by default", [0]) from my other series:
"clk: meson: rounding for fast clocks on 32-bit SoCs" [1]

That patch caused NULL dereferences in various drivers which are still
accessing clk_divider_ops.round_rate directly (which got removed in the
mentioned patch).

Guenter Roeck found this issue first on Freescale i.MX6 Ultralite and
reported it here: [2]
Later on Marek Szyprowski reported that BCM2835 is also affected: [3]

With this improved version of the patch I am taking a more definsive
approach as suggested by Stephen Boyd. Instead of dropping
clk_divider_ops.round_rate we're now keeping it and adding
clk_divider_ops.determine_rate. CCF core already prefers
.determine_rate over .round_rate so the new implementation is used by
default.

To simplify the transition to .determine_rate in the future this
updated series now has five extra patches to port over the drivers
which used clk_divider_ops.round_rate over to
clk_divider_ops.determine_rate.

I have compile-tested all patches. Additionally the imx patch is
runtime-tested using Guenter Roeck's suggestion (thanks!):
$ qemu-system-arm -M mcimx6ul-evk -m 512M -kernel arch/arm/boot/zImage -dtb arch/arm/boot/dts/imx6ul-14x14-evk.dtb -append "console=ttymxc0 loglevel=8 earlycon earlyprintk" -monitor stdio

This series is based on clk-next commit 783d08bd02f5d3 ("Revert "clk:
divider: Switch from .round_rate to .determine_rate by default"clk-next").
My suggestion is to let all patches go through clk-next (instead of
individual driver trees) as the first patch in this series is a pre-
condition for the other ones.


[0] https://patchwork.kernel.org/project/linux-clk/patch/20210627223959.188139-3-martin.blumenstingl@googlemail.com/
[1] https://patchwork.kernel.org/project/linux-clk/cover/20210627223959.188139-1-martin.blumenstingl@googlemail.com/
[2] https://lore.kernel.org/linux-clk/20210701202540.GA1085600@roeck-us.net/
[3] https://lore.kernel.org/linux-clk/e21c34a3-2586-057d-013b-6c8ec094d1a8@samsung.com/


Martin Blumenstingl (6):
  clk: divider: Implement and wire up .determine_rate by default
  clk: imx: clk-divider-gate: Switch to clk_divider.determine_rate
  clk: bcm2835: Switch to clk_divider.determine_rate
  clk: stm32f4: Switch to clk_divider.determine_rate
  clk: stm32h7: Switch to clk_divider.determine_rate
  clk: stm32mp1: Switch to clk_divider.determine_rate

 drivers/clk/bcm/clk-bcm2835.c      |  9 ++++-----
 drivers/clk/clk-divider.c          | 23 +++++++++++++++++++++++
 drivers/clk/clk-stm32f4.c          |  8 ++++----
 drivers/clk/clk-stm32h7.c          |  8 ++++----
 drivers/clk/clk-stm32mp1.c         | 10 +++-------
 drivers/clk/imx/clk-divider-gate.c | 10 +++++-----
 6 files changed, 43 insertions(+), 25 deletions(-)

-- 
2.32.0

