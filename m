Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B00934AA14
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 15:37:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231308AbhCZOgs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Mar 2021 10:36:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230359AbhCZOf0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Mar 2021 10:35:26 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E11ACC0613B2
        for <linux-kernel@vger.kernel.org>; Fri, 26 Mar 2021 07:35:25 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id e18so5871400wrt.6
        for <linux-kernel@vger.kernel.org>; Fri, 26 Mar 2021 07:35:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YMBBfLBQyPfcs/BjCQH23mCoZ18SMLXlxq4s4Yi+O24=;
        b=SzlRTOBcfb8HruNCzxQ/XXDAxq8fqES6yINPpKxgv4YKBPLmmbqmuPhwiUVO/O/bUW
         P1w/L8olV5BC+2GhwMbfJzWKf+I0byxOzDmxedHXQRpbaUn7kLwJTP3EYVK9rUnFTuOX
         LSPAQMbX/Q5Z9jQhWhH72x2cn7ShB3260TwJY25LbnCBInnTAVHXAYq5MrO24MNb+/nk
         3JFUCg6Dz1iHWIaWHwysjygdZsVzZpilI2K649/2LGwPBWT6xLAlqMoZIUed5yLxFyr3
         Md0ubvCnN3awJtJHYKf5OU0rJagj7ePess/DcrJvayL0t57GgwR5I2DPAW5/L1/rCSIY
         4Xxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YMBBfLBQyPfcs/BjCQH23mCoZ18SMLXlxq4s4Yi+O24=;
        b=tXr+6X+a/02Wb6LJdCR0onUbPHFa4l5OAcBfi4Y5mZZM11hWB2Pd5smoLDEp15TYqW
         jYX6lR8yJskCbFRxOQD7uaGy3ilTkM4yqQZ4ltZR3siLj6a5VoulGYvxRox0NrXtjYVU
         WAE+EvTxfUgnaavsmu9xBchWocLH54dJ1itCFl8dTflIbLDCfJJcu8mq/5/LW+KZ5YjU
         eNMwsZ9IOg4VGOdrkNjCgcJFVnh6CWIeyoc8mb/LOPVUT1zpEoy97i1WWE5AxsHkUzx0
         IsXmZv3BRr6okv/asO82dPnB3ia+a0o3Lqn8Pgzv8x0dNuIU66KVZ5hPQe0/TbwMAHqq
         XpJg==
X-Gm-Message-State: AOAM531E88Cam6suIOLxt7XcOBeeUEUcbdgpoRhoBcDBCYTedw/Jf+1q
        lil8EQ0Fo60vR5lTwMkDx8W5gg==
X-Google-Smtp-Source: ABdhPJxVEQw3OXVcUWupqGocVo9kUby54BTdwkPyGcKLXqoHGoInXFiNk3GDV8kL7UYSFgCKfKInWQ==
X-Received: by 2002:a5d:6092:: with SMTP id w18mr14807891wrt.52.1616769324690;
        Fri, 26 Mar 2021 07:35:24 -0700 (PDT)
Received: from dell.default ([91.110.221.194])
        by smtp.gmail.com with ESMTPSA id j26sm12878225wrh.57.2021.03.26.07.35.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Mar 2021 07:35:24 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Jiri Kosina <jikos@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-input@vger.kernel.org, linux-iio@vger.kernel.org
Subject: [PATCH 22/25] HID: hid-sensor-hub: Remove unused struct member 'quirks'
Date:   Fri, 26 Mar 2021 14:34:55 +0000
Message-Id: <20210326143458.508959-24-lee.jones@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210326143458.508959-1-lee.jones@linaro.org>
References: <20210326143458.508959-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit b0f847e16c1ea ("HID: hid-sensor-hub: Force logical minimum to 1
for power and report state") removed the last used quirk handled by
this driver.

Fixes the following W=1 kernel build warning(s):

 drivers/hid/hid-sensor-hub.c:39: warning: Function parameter or member 'quirks' not described in 'sensor_hub_data'

Cc: Jiri Kosina <jikos@kernel.org>
Cc: Jonathan Cameron <jic23@kernel.org>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: linux-input@vger.kernel.org
Cc: linux-iio@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/hid/hid-sensor-hub.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/hid/hid-sensor-hub.c b/drivers/hid/hid-sensor-hub.c
index 3dd7d32467378..36b6852f75dd5 100644
--- a/drivers/hid/hid-sensor-hub.c
+++ b/drivers/hid/hid-sensor-hub.c
@@ -34,7 +34,6 @@ struct sensor_hub_data {
 	spinlock_t dyn_callback_lock;
 	struct mfd_cell *hid_sensor_hub_client_devs;
 	int hid_sensor_client_cnt;
-	unsigned long quirks;
 	int ref_cnt;
 };
 
@@ -615,7 +614,6 @@ static int sensor_hub_probe(struct hid_device *hdev,
 	}
 
 	hid_set_drvdata(hdev, sd);
-	sd->quirks = id->driver_data;
 
 	spin_lock_init(&sd->lock);
 	spin_lock_init(&sd->dyn_callback_lock);
-- 
2.27.0

