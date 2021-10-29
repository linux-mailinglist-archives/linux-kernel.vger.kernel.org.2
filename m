Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C826743FF1B
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Oct 2021 17:09:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230016AbhJ2PMP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Oct 2021 11:12:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbhJ2PMO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Oct 2021 11:12:14 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A74EC061570
        for <linux-kernel@vger.kernel.org>; Fri, 29 Oct 2021 08:09:46 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id p14so16561482wrd.10
        for <linux-kernel@vger.kernel.org>; Fri, 29 Oct 2021 08:09:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rVB6Mape8AZ3GYEGuo0nTCaIun4TlRzMw50e6bL9ymY=;
        b=EMVzMLbWRoMf4OZF/PgsKjgYtOS9kAkDV3iR/xftdDi1YIEVdYiMNgF3uUGSG4ejMI
         brjjvHcbKZLWq60nsW1wt3Kp2xqSMKlMA2JlXtfDuXQo1G+D8iLHxdnVSQvHBu1qzEWa
         rpUOMRsX9HhMcfOWoGp1HOLOReQb2I3SRwpJbXAJr6S2yI9qC/Q6I5TQBRIIHHrwBXr3
         5zt5o2vY7SrkMm0KlmDUXUZk0TaYXvvsKOlz4FqH89IyGeAIr0du1MU2RtcP8vSqA1Ve
         AV4A1Rm9pi1ZesG5fH9XChCNoY0Tvt6IJBxArlfTlp4ykeoG9Fx609FIfpCXdMs9JyqN
         /YQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rVB6Mape8AZ3GYEGuo0nTCaIun4TlRzMw50e6bL9ymY=;
        b=kUMGEvWIbL8lQTKonUUbLurFxCucON5e/3Ank6GjBTEMeGvqx5Wyj/16+ekKnRHLSw
         aZMzmq0Qwmd0L5po1FTNxiW0XyweLgAnbIYR24a1oo42RwOsvPHnPjVk+scdpn+FhJYF
         YPUYfI2UPU9nUro0xAbJZ4YLw8P0pm1dPaX4BEWeu/ueplRcu71xAdJK/9pUlZqkHoLF
         Z7pxVvixZOb0LNPWNeD7aWgerPMPJsdyzYYl3Whx1lP3+BSERSgR7bgmZPQUrI5HMGeK
         LzjpDvW1BJwVSl/2JR0EhUSrUqJoVU7GVrJfEG33HkzW3u48bH9gJOTEpac0zndbHPvO
         quLg==
X-Gm-Message-State: AOAM5303tGxrLDdAeMlOF6Un/Je8YE0uo5O5L1IxReikZWznEGE7tYXq
        4s+4owwcHWi2KDOWnwKydmkYYQ==
X-Google-Smtp-Source: ABdhPJxWCDtRa1WRZHbIEGvicZYDAkWdzBxqu6H4aBB+0DGhYUsouJaUQCXEmzjReLHo4UHowFMefg==
X-Received: by 2002:adf:c40f:: with SMTP id v15mr5519721wrf.302.1635520183915;
        Fri, 29 Oct 2021 08:09:43 -0700 (PDT)
Received: from xps-9300.baylibre.local (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id b7sm7091906wrv.72.2021.10.29.08.09.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Oct 2021 08:09:43 -0700 (PDT)
From:   Alexandre Bailon <abailon@baylibre.com>
To:     rafael@kernel.org, rui.zhang@intel.com, daniel.lezcano@linaro.org,
        amitk@kernel.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        ben.tseng@mediatek.com, khilman@baylibre.com, mka@chromium.org,
        Alexandre Bailon <abailon@baylibre.com>
Subject: [PATCH v3 0/2] Add a generic virtual thermal sensor
Date:   Fri, 29 Oct 2021 17:08:55 +0200
Message-Id: <20211029150857.504891-1-abailon@baylibre.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series add a virtual thermal sensor.
It could be used to get a temperature using some thermal sensors.
Currently, the supported operations are max, min and avg.
The virtual sensor could be easily extended to support others operations.

Changes in v2:
- Fix some warnings / errors reported by kernel test robot
- rename some struct and functions with a more accurate name
- update the dt bindings: rename type attribute to aggregation-function
- factorize a little bit the aggregation functions
Changes in v3:
- Aggregate thermal zone instead of thermal sensors
- Use try_get_module / put_module to prevent thermal providers to be removed
- Update the bindings, to be more accurate

Alexandre Bailon (2):
  dt-bindings: Add DT bindings for the DT-based virtual sensor driver
  thermal: add a virtual sensor to aggregate temperatures

 .../thermal/virtual,thermal-sensor.yaml       |  80 +++++++
 drivers/thermal/Kconfig                       |   8 +
 drivers/thermal/Makefile                      |   1 +
 drivers/thermal/virtual_thermal_sensor.c      | 219 ++++++++++++++++++
 include/dt-bindings/thermal/virtual-sensor.h  |  15 ++
 5 files changed, 323 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/thermal/virtual,thermal-sensor.yaml
 create mode 100644 drivers/thermal/virtual_thermal_sensor.c
 create mode 100644 include/dt-bindings/thermal/virtual-sensor.h

-- 
2.32.0

