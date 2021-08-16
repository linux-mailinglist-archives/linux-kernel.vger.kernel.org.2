Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D6FF3ED34B
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Aug 2021 13:47:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236236AbhHPLsL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Aug 2021 07:48:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235874AbhHPLsK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Aug 2021 07:48:10 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2BCDC061764
        for <linux-kernel@vger.kernel.org>; Mon, 16 Aug 2021 04:47:38 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id v4so16032203wro.12
        for <linux-kernel@vger.kernel.org>; Mon, 16 Aug 2021 04:47:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=P/7JZXYE4iR+4Jd/3+QviIjahegJ9o1DGOwaYn9CX94=;
        b=pUaimuZGNy5jhOzw7G74/LrCUFTqtgHj2Pbh892aT017GS8NKVUtHgRinzK6osKX+m
         0jeUgCjwkNzEgeFXfyPw2baqc9iAdI5zKN2hjQ2sgtYskqEbbINRNh/iOdD1EKVAG+bP
         1/f4cnXJgjHfc8KyvwDwtWHPwWitwFya8RmmSBhn1EkcfJtEwPA15gCy9jE3V+Qsr4Tz
         wdseZOD/zwGb3Ji8tH9KxeujiQJJm8lNtUgTQVcAxeN2Ph0PS6Y6gua51GPiKzhG5tZ5
         3QGfHnydOoO6/zwaWy4vm37l7Hu1VKhfP8yWCKDTySKSf2JxA3PBSmk3jYpjP36xmofg
         VoQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=P/7JZXYE4iR+4Jd/3+QviIjahegJ9o1DGOwaYn9CX94=;
        b=K4gTLqd+CVPWCwz6xQWtoEyelt+KPSo/NFBqjP29/TUPHnDuDGNUw8s3xdkjKkpHNi
         dWSxCu1sItjTuuD+loYqOzv2u9HGCr9GKG1nQQ2CzOtSUISEHgJztV8IiMM/QEtsDEpj
         8JHLz7O0FaGt4WxOr3CxIc6FIvTh6piDHXznqa6tYeBOlYdtAkSV6T9jjLBBdfhQkF1J
         eMACu+nNKqj6fZnrejsI5Xy4UD+mz8ztoI8Co/YEfHt3/OTSudaEo0nQsTn/IrLTTnxj
         Z4Qsf+oYWWHmLrMfHJ/0EK7KGlcMTcaRagB36MpJISbWRv0KBQ54n1hjUNOchlvr4U0v
         76yw==
X-Gm-Message-State: AOAM531fM3u4n1VY5ABHk21nd5XIRBlHazw09eMkvS/R2FnEg7BVBvfX
        qRp8NhQI1V2VSbxFa7q1XxZapQ==
X-Google-Smtp-Source: ABdhPJyBjeUphOs/q6Wk326Uvve1fYIhLjYFHULhhQsyPI1jNHzTq84ShPc7dulVCyA1mPPCEbrAFA==
X-Received: by 2002:adf:f809:: with SMTP id s9mr17861316wrp.370.1629114457282;
        Mon, 16 Aug 2021 04:47:37 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e34:ed2f:f020:e1b0:48c1:6199:9cb4])
        by smtp.gmail.com with ESMTPSA id h9sm11360769wrv.84.2021.08.16.04.47.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Aug 2021 04:47:36 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     andriy.shevchenko@linux.intel.com, akpm@linux-foundation.org
Cc:     jic23@kernel.org, linux-kernel@vger.kernel.org, ceggers@arri.de,
        lukasz.luba@arm.com, myungjoo.ham@samsung.com,
        kyungmin.park@samsung.com, lars@metafoo.de, pmeerw@pmeerw.net,
        rui.zhang@intel.com, linux@roeck-us.net, miquel.raynal@bootlin.com,
        mcoquelin.stm32@gmail.com, rafael@kernel.org,
        daniel.lezcano@linaro.org
Subject: [PATCH v3 00/10] Add Hz macros 
Date:   Mon, 16 Aug 2021 13:47:22 +0200
Message-Id: <20210816114732.1834145-1-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are multiple definitions of the HZ_PER_MHZ or HZ_PER_KHZ in the
different drivers. Instead of duplicating this definition again and
again, add one in the units.h header to be reused in all the place
the redefiniton occurs.

At the same time, change the type of the Watts, as they can not be
negative.

Daniel Lezcano (10):
  units: Change from 'L' to 'UL'
  units: Add the HZ macros
  thermal/drivers/devfreq_cooling: Use HZ macros
  devfreq: Use HZ macros
  iio/drivers/as73211: Use HZ macros
  hwmon/drivers/mr75203: Use HZ macros
  iio/drivers/hid-sensor: Use HZ macros
  i2c/drivers/ov02q10: Use HZ macros
  mtd/drivers/nand: Use HZ macros
  phy/drivers/stm32: Use HZ macros

 drivers/devfreq/devfreq.c                              |  2 +-
 drivers/hwmon/mr75203.c                                |  2 +-
 drivers/iio/common/hid-sensors/hid-sensor-attributes.c |  3 +--
 drivers/iio/light/as73211.c                            |  3 +--
 drivers/media/i2c/ov02a10.c                            |  2 +-
 drivers/mtd/nand/raw/intel-nand-controller.c           |  2 +-
 drivers/phy/st/phy-stm32-usbphyc.c                     |  2 +-
 drivers/thermal/devfreq_cooling.c                      |  2 +-
 include/linux/units.h                                  | 10 +++++++---
 9 files changed, 15 insertions(+), 13 deletions(-)

-- 
2.25.1

