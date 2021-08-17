Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 796FA3EE8D3
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Aug 2021 10:48:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239220AbhHQIsu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Aug 2021 04:48:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234880AbhHQIst (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Aug 2021 04:48:49 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76A18C061764;
        Tue, 17 Aug 2021 01:48:16 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id q10so27448930wro.2;
        Tue, 17 Aug 2021 01:48:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UvsOH8jtQe+4Kanh6E/MrBCjFWLS1TOh5zSyYH4PboQ=;
        b=LbR8LaJuOhBakcLFAAFQ2PSM/njYxfneXxDeDQYlanx3FENXuAF6gIa2xv7Wo1X2c2
         R9OvMZUC5T3QXMdttlxfunjDSmS0SpioQKYCVIkhzwtq3u4dP8lMsia9ZL9A8x0102Nr
         oim0c7sOWji/ztnYQeIzF18NgS9SkJtTLWsAqYrJd22trjBcZtNyJplcdFZrXqv/OkX3
         HVgg4pi0RVbrICIsacxYUOjtNVCTWRfOdE53LABlXoMXTYZav5Cu1iN/mahqaUmtJ27E
         4a9/JyDuXPfQWqt3DUcIe9xwZTDPxR+b2hNiao1jTATo1UFeXqaApMu09Tz5Nryua+eK
         7/dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UvsOH8jtQe+4Kanh6E/MrBCjFWLS1TOh5zSyYH4PboQ=;
        b=N8e7XF24i6EK9S2VSQU/j6jNf5gmsPaZd2Ynp7Z78NSY/O5w6CpBXkI3ThqP8xsQGN
         fNIgL4maG5A5DG4hAMX0Kzil1SbpZJj0LjvrZ1EjJpDjNs4xnN/jILsA/gAx0Vcu5V7Q
         6aoNQeyfyJQtziZQnoZWFLwnAdLbq1jaNW5aU30827A7/aCTMydzaQMBPx7rtq/+2oVt
         yPnn/9D7otfghAaxD/w/AoHZDkxK4pbeAc602jgiU3+gXStajPTHTs09v5t2iVTJnaeE
         UDFRK8zHfL6mH96vbKLybc3fKJoCQp7d5HwB0X+8HeE9ZJgx6qM3p7TgRRRkHh/t6K0D
         8qIg==
X-Gm-Message-State: AOAM532aCkSg33iCcXRhPIjp3ptl2hBkyN3E1/t5khJMzRVlwd2NCJSt
        g+iv+VfQxWroXfK9sO6OEMo=
X-Google-Smtp-Source: ABdhPJy2o8VurqIMFUNktoLextNJhp00f0HEhzkQIq8R2VbnLDV0HaQAeUr+eat2ZRGeJzfbzYVdIw==
X-Received: by 2002:adf:f741:: with SMTP id z1mr2597669wrp.201.1629190095036;
        Tue, 17 Aug 2021 01:48:15 -0700 (PDT)
Received: from localhost.localdomain (arl-84-90-178-246.netvisao.pt. [84.90.178.246])
        by smtp.gmail.com with ESMTPSA id o14sm1302899wms.2.2021.08.17.01.48.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Aug 2021 01:48:14 -0700 (PDT)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>, linux-hwmon@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH] hwmon: remove amd_energy driver in Makefile
Date:   Tue, 17 Aug 2021 10:48:11 +0200
Message-Id: <20210817084811.10673-1-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 9049572fb145 ("hwmon: Remove amd_energy driver") removes the driver,
but misses to adjust the Makefile.

Hence, ./scripts/checkkconfigsymbols.py warns:

SENSORS_AMD_ENERGY
Referencing files: drivers/hwmon/Makefile

Remove the missing piece of this driver removal.

Fixes: 9049572fb145 ("hwmon: Remove amd_energy driver")
Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
 drivers/hwmon/Makefile | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/hwmon/Makefile b/drivers/hwmon/Makefile
index 53a8f4b500b8..4b33421746c0 100644
--- a/drivers/hwmon/Makefile
+++ b/drivers/hwmon/Makefile
@@ -45,7 +45,6 @@ obj-$(CONFIG_SENSORS_ADT7462)	+= adt7462.o
 obj-$(CONFIG_SENSORS_ADT7470)	+= adt7470.o
 obj-$(CONFIG_SENSORS_ADT7475)	+= adt7475.o
 obj-$(CONFIG_SENSORS_AHT10)	+= aht10.o
-obj-$(CONFIG_SENSORS_AMD_ENERGY) += amd_energy.o
 obj-$(CONFIG_SENSORS_APPLESMC)	+= applesmc.o
 obj-$(CONFIG_SENSORS_ARM_SCMI)	+= scmi-hwmon.o
 obj-$(CONFIG_SENSORS_ARM_SCPI)	+= scpi-hwmon.o
-- 
2.26.2

