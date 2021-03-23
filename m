Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9148E3456E6
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 05:35:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229963AbhCWEfP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 00:35:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230034AbhCWEfA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 00:35:00 -0400
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5953C061574;
        Mon, 22 Mar 2021 21:34:59 -0700 (PDT)
Received: by mail-qv1-xf32.google.com with SMTP id t5so9858083qvs.5;
        Mon, 22 Mar 2021 21:34:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=W098yLvagYSO9A4rP3vOMS7ghgfO5xcNeYh53cseJdc=;
        b=Zy5wxp0ZTHydAknLKeFU20M4bgDpcQRNfbsDhC0lRJSVo8hLFsIAKvdvkN3drmVT/o
         JsNAxYiIg8ydzaJjPuvgHA2N/gDCv4F+mGy20WVZwgaNghwiX087+wunDTFebeFxlDhj
         ULoLCFtU9nGiW2JCqKf3U1c2rC0iIGxbHDzobfwq8TaRU64tZ0MVZBtdLSne/wxvTrYY
         gJUQ5zki2QLAetxh+MFkowvhy934kMc3r+fKrQphuu7OYEnUHX6IfSunagjpVd7a7eiX
         uUoz6SOTBGx/ZmEhCJ+ZQzq3A7Jm1BUdYJeuNlWBilTw2jhKGFxDzvwEZOqc+eUOBfA4
         bldg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=W098yLvagYSO9A4rP3vOMS7ghgfO5xcNeYh53cseJdc=;
        b=i0zCovh2O/vOXHVwcgWGbE3ZKSuGDRC8ZOPcvE4MXVsg5tRrRYIQSJXu4F/VaZrVx/
         kTvf+Ieg9MEY7dfQ9aqVfIZfiQpPkW956v6QvvxYbFT/UJHED28MRsbHNj79+k4EO89b
         SM4t3B+IkMdNbKbtt9Qd1AolFJhFtMP3aYfG/jnVcQtT6vxCUB4u4MTWUHyI2V0dngY3
         4ty4ZIKuE/uU7JTee3BsQ87Qa6AAxJyDmto7QHI0HGZ6f3+cTqyqHbirPkR/G77iyXNQ
         Mg0DfPu+0VIq9rXivw9BZKrZx83FOiM51n/kPPg91WtM2gu/5Vl/cUrppoGkyvfJPaAh
         2hMg==
X-Gm-Message-State: AOAM532uWVmaIawSxpWouGAFcTOxyVqmxrnXfkuttSn4ouB8PAFfnPum
        jjoZNLsjnIUcPwmINBHdUzI=
X-Google-Smtp-Source: ABdhPJw7ODDKafOUVKaaZ3KR2haoG6wrpunG/GfsBBVtWn/oO/zBql5bOnLObu65Q8Nj0yleMARTRA==
X-Received: by 2002:ad4:45e4:: with SMTP id q4mr3039822qvu.11.1616474099282;
        Mon, 22 Mar 2021 21:34:59 -0700 (PDT)
Received: from localhost.localdomain ([156.146.54.208])
        by smtp.gmail.com with ESMTPSA id k7sm10142104qtm.10.2021.03.22.21.34.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Mar 2021 21:34:58 -0700 (PDT)
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     jdelvare@suse.com, linux@roeck-us.net, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     rdunlap@infradead.org, Bhaskar Chowdhury <unixbhaskar@gmail.com>
Subject: [PATCH] hwmon: (ftsteutates): Rudimentary typo fixes
Date:   Tue, 23 Mar 2021 10:04:38 +0530
Message-Id: <20210323043438.1321903-1-unixbhaskar@gmail.com>
X-Mailer: git-send-email 2.31.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


s/Temprature/Temperature/
s/revsion/revision/

Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
---
 drivers/hwmon/ftsteutates.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/hwmon/ftsteutates.c b/drivers/hwmon/ftsteutates.c
index ef88a156efc2..ceffc76a0c51 100644
--- a/drivers/hwmon/ftsteutates.c
+++ b/drivers/hwmon/ftsteutates.c
@@ -509,7 +509,7 @@ fan_alarm_store(struct device *dev, struct device_attribute *devattr,
 /* SysFS structs							     */
 /*****************************************************************************/

-/* Temprature sensors */
+/* Temperature sensors */
 static SENSOR_DEVICE_ATTR_RO(temp1_input, temp_value, 0);
 static SENSOR_DEVICE_ATTR_RO(temp2_input, temp_value, 1);
 static SENSOR_DEVICE_ATTR_RO(temp3_input, temp_value, 2);
@@ -713,7 +713,7 @@ static int fts_detect(struct i2c_client *client,
 {
 	int val;

-	/* detection works with revsion greater or equal to 0x2b */
+	/* detection works with revision greater or equal to 0x2b */
 	val = i2c_smbus_read_byte_data(client, FTS_DEVICE_REVISION_REG);
 	if (val < 0x2b)
 		return -ENODEV;
--
2.31.0

