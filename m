Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E709F308B51
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jan 2021 18:19:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231596AbhA2RS3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jan 2021 12:18:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232208AbhA2RQJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jan 2021 12:16:09 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D4D5C061788
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jan 2021 09:14:50 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id f16so7394109wmq.5
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jan 2021 09:14:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=r0DeJRQSouD6CDUFN4FcJrgT9nh0a6Rl7JYqFQiHWdE=;
        b=Jn4mv2sHCPZ0MMXzT32Xbz5rAfWG/yn4zEA3JV5sz54Zln1eyTrj4V2e6xH2qPzj4p
         ixFRplLWCRknfZdts7ndcoZN3t/anX6JFejRDeXJDOXYzx2mQZcgGAkBDt2r/WfWhyNa
         lP0OdPaf9KIROM/vv0eZdkmZnM1flWbGRvpTzL+FKiOkoifNwRT5b2S8GT3XHI/A6XdT
         k0dO6du5reV+wb/jzBGjyXetGAm0Wl2lhnQXqGphEHrwgVRoA25OyvUU2kTey8WP+xxU
         AZjTdu8mVWJIegIcGqnKk4280VTIksVLYQPapnQ/cekpzSTyJuoxA/PzWstwIwrLXrea
         7rCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=r0DeJRQSouD6CDUFN4FcJrgT9nh0a6Rl7JYqFQiHWdE=;
        b=UOPIjnf65E9mUOYFI9mAQ1XYEo9ydEslr9dnnqMaqnMN1pAKjBW34aYvBgh5oiuUbN
         DwO2YRkhBdeskd5ipHHcNZozgYGM6CCsvKIWyP9OPeM+2dOkS3rGOJLUX9FkrOia3ABW
         27jTF8hW3OkLeXBBuOH55aRMLMz5793GDmszU3rT8ADNvrwzQWakhowJck5Kkt/jVpVh
         Zkl5WZBxvHw3E6rWUaaeSZ2/b6x4NPfZA+KqF9ijmGvlq65fc8INBQ1Oy6WSt0rVXw8y
         wsCtR2Hp1d9P7KhElVGZQ+Wo3aMVT3vyRFZsv/8bp8PIg4bZj53Y65IY2AvsCTwobLiS
         wq0A==
X-Gm-Message-State: AOAM532moTYO7KmMG3pdIUnm4Rghc0nGFg6ShLGrweRyEm4vwcEqlmD9
        mvx90OHoQc96osHQKYqT8b118wrEMPtJkA==
X-Google-Smtp-Source: ABdhPJwl3lu0deH+Vf0Y7IibiR0OQyI23bJ/81r7PuQ0/N/1UE7mg5bkV3yVo63BvV6yEheL2noCdw==
X-Received: by 2002:a7b:cbd7:: with SMTP id n23mr4811981wmi.162.1611940489279;
        Fri, 29 Jan 2021 09:14:49 -0800 (PST)
Received: from srini-hackbox.lan (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.gmail.com with ESMTPSA id n15sm12952487wrx.2.2021.01.29.09.14.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Jan 2021 09:14:48 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org,
        Ahmad Fatoum <a.fatoum@pengutronix.de>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 5/5] nvmem: core: skip child nodes not matching binding
Date:   Fri, 29 Jan 2021 17:14:30 +0000
Message-Id: <20210129171430.11328-6-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20210129171430.11328-1-srinivas.kandagatla@linaro.org>
References: <20210129171430.11328-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ahmad Fatoum <a.fatoum@pengutronix.de>

The nvmem cell binding applies to all eeprom child nodes matching
"^.*@[0-9a-f]+$" without taking a compatible into account.

Linux drivers, like at24, are even more extensive and assume
_all_ at24 eeprom child nodes to be nvmem cells since e888d445ac33
("nvmem: resolve cells from DT at registration time").

Since df5f3b6f5357 ("dt-bindings: nvmem: stm32: new property for
data access"), the additionalProperties: True means it's Ok to have
other properties as long as they don't match "^.*@[0-9a-f]+$".

The barebox bootloader extends the MTD partitions binding to
EEPROM and can fix up following device tree node:

  &eeprom {
    partitions {
      compatible = "fixed-partitions";
    };
  };

This is allowed binding-wise, but drivers using nvmem_register()
like at24 will fail to parse because the function expects all child
nodes to have a reg property present. This results in the whole
EEPROM driver probe failing despite the device tree being correct.

Fix this by skipping nodes lacking a reg property instead of
returning an error. This effectively makes the drivers adhere
to the binding because all nodes with a unit address must have
a reg property and vice versa.

Fixes: e888d445ac33 ("nvmem: resolve cells from DT at registration time").
Signed-off-by: Ahmad Fatoum <a.fatoum@pengutronix.de>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/nvmem/core.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index 68ae6f24b57f..a5ab1e0c74cf 100644
--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -682,7 +682,9 @@ static int nvmem_add_cells_from_of(struct nvmem_device *nvmem)
 
 	for_each_child_of_node(parent, child) {
 		addr = of_get_property(child, "reg", &len);
-		if (!addr || (len < 2 * sizeof(u32))) {
+		if (!addr)
+			continue;
+		if (len < 2 * sizeof(u32)) {
 			dev_err(dev, "nvmem: invalid reg on %pOF\n", child);
 			return -EINVAL;
 		}
-- 
2.21.0

