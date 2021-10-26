Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35BD343AAC4
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Oct 2021 05:33:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234662AbhJZDfr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Oct 2021 23:35:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233728AbhJZDfq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Oct 2021 23:35:46 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE0FFC061745;
        Mon, 25 Oct 2021 20:33:22 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id nn3-20020a17090b38c300b001a03bb6c4ebso566942pjb.1;
        Mon, 25 Oct 2021 20:33:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Mkq3aea+NCXE9zaVj4MupeFeuH4eRueS9CDWO70cBHg=;
        b=Io3oA2TNwgqt2KOVh19dDB40d3zTv1EmwhDyaeSJlPW+jCTF3ZUxoLzx3sx+dAgzA2
         tkpHVVD/ng2yLaWu1SzihCEkNT41LTXcm0348rNqF4kuPepBXdw3kvdM5EvXh8gSZSX/
         MFEGKVPoaDA/P8p216qFNx7+UO68jh/c+ptXyVsj+veRayu/MpkMLeKBU9dzzXfozTMZ
         wqSXsUebMtVWf4A/RvdrHj4hw0+w0kkf+NWOnxK2Uird7mZ8g/eEokqdSe5cMiHj572W
         p+0TQsBm/P7mX9WTNQUaxYI/ysn3QD1eueHkoQWLiMle2FgHPH4sJfSbbDYhPBrujcZc
         pFDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Mkq3aea+NCXE9zaVj4MupeFeuH4eRueS9CDWO70cBHg=;
        b=rPOewNs4Yl2mp/jLV0zl2Xx0NAeAU9gxBAbBFKLXxUgWpXwP6BXp+eLBiQr8Kohyv4
         eIaUCfbbXTYJKYZeRGJzdC2lC+pexJkV30a3aL4d5qPJvB91tKu+vuF8vz73CxW1+FeS
         qObEmzU7Pbo+Z+NFfT2+5XED2IigvE7hjDf01gEbnne0Z+LYmnXRU6P9twaqDhDloqFW
         i+DZglg0/vo0BZkvk2L4d3aI/0nJ0TRiLCxwWHQ2VIWodmh3dTGkn9IMJRZ5tV7Y46dJ
         uIlBt9CppXfYVZAKqsZrsjwe9PDXMXOkbqNQ2ddmLAMGq/yID3psT+5T3laFrtOywTGv
         w4/Q==
X-Gm-Message-State: AOAM533JF5fxP57fd7K52v1z5mNF2sbBq8fKp8lEPspfkxDZDXwfJgbZ
        c/5Wny5UHN2mqV+ztstI/WM=
X-Google-Smtp-Source: ABdhPJw1/vCijhY8xut2g+W8TLMDs7p7jzHYjrF94y5AKv57S5LiwNiOF6aS3TQOXDqfE55gVELcqg==
X-Received: by 2002:a17:90b:1a87:: with SMTP id ng7mr40993753pjb.69.1635219200489;
        Mon, 25 Oct 2021 20:33:20 -0700 (PDT)
Received: from localhost.localdomain (c-73-222-199-61.hsd1.ca.comcast.net. [73.222.199.61])
        by smtp.googlemail.com with ESMTPSA id ng5sm20091129pjb.51.2021.10.25.20.33.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Oct 2021 20:33:20 -0700 (PDT)
From:   Hill Ma <maahiuzeon@gmail.com>
To:     benh@kernel.crashing.org, linuxppc-dev@lists.ozlabs.org
Cc:     Hill Ma <maahiuzeon@gmail.com>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org
Subject: [PATCH v2] macintosh/via-pmu-led: make disk activity usage a parameter.
Date:   Mon, 25 Oct 2021 20:32:54 -0700
Message-Id: <20211026033254.1052-1-maahiuzeon@gmail.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Whether to use the LED as a disk activity is a user preference.
Some like this usage while others find the LED too bright. So it
might be a good idea to make this choice a runtime parameter rather
than compile-time config.

The default is set to disabled as OS X does not use the LED as a
disk activity indicator.

Signed-off-by: Hill Ma <maahiuzeon@gmail.com>
---
 Documentation/admin-guide/kernel-parameters.txt |  6 ++++++
 drivers/macintosh/Kconfig                       | 10 ----------
 drivers/macintosh/via-pmu-led.c                 | 11 ++++++++---
 3 files changed, 14 insertions(+), 13 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 43dc35fe5bc0..a656a51ba0a8 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -250,6 +250,12 @@
 			Use timer override. For some broken Nvidia NF5 boards
 			that require a timer override, but don't have HPET
 
+	adb_pmu_led_disk [PPC]
+			Use front LED as disk LED by default. Only applies to
+			PowerBook, iBook, PowerMac 7,2/7,3.
+			Format: <bool>  (1/Y/y=enable, 0/N/n=disable)
+			Default: disabled
+
 	add_efi_memmap	[EFI; X86] Include EFI memory map in
 			kernel's map of available physical RAM.
 
diff --git a/drivers/macintosh/Kconfig b/drivers/macintosh/Kconfig
index 5cdc361da37c..243215de563c 100644
--- a/drivers/macintosh/Kconfig
+++ b/drivers/macintosh/Kconfig
@@ -78,16 +78,6 @@ config ADB_PMU_LED
 	  behaviour of the old CONFIG_BLK_DEV_IDE_PMAC_BLINK, select this
 	  and the disk LED trigger and configure appropriately through sysfs.
 
-config ADB_PMU_LED_DISK
-	bool "Use front LED as DISK LED by default"
-	depends on ADB_PMU_LED
-	depends on LEDS_CLASS
-	select LEDS_TRIGGERS
-	select LEDS_TRIGGER_DISK
-	help
-	  This option makes the front LED default to the disk trigger
-	  so that it blinks on disk activity.
-
 config PMAC_SMU
 	bool "Support for SMU  based PowerMacs"
 	depends on PPC_PMAC64
diff --git a/drivers/macintosh/via-pmu-led.c b/drivers/macintosh/via-pmu-led.c
index ae067ab2373d..faf39a5962aa 100644
--- a/drivers/macintosh/via-pmu-led.c
+++ b/drivers/macintosh/via-pmu-led.c
@@ -25,6 +25,7 @@
 #include <linux/leds.h>
 #include <linux/adb.h>
 #include <linux/pmu.h>
+#include <linux/moduleparam.h>
 #include <asm/prom.h>
 
 static spinlock_t pmu_blink_lock;
@@ -71,11 +72,10 @@ static void pmu_led_set(struct led_classdev *led_cdev,
  	spin_unlock_irqrestore(&pmu_blink_lock, flags);
 }
 
+bool adb_pmu_led_disk;
+
 static struct led_classdev pmu_led = {
 	.name = "pmu-led::front",
-#ifdef CONFIG_ADB_PMU_LED_DISK
-	.default_trigger = "disk-activity",
-#endif
 	.brightness_set = pmu_led_set,
 };
 
@@ -106,6 +106,9 @@ static int __init via_pmu_led_init(void)
 	}
 	of_node_put(dt);
 
+	if (adb_pmu_led_disk)
+		pmu_led.default_trigger = "disk-activity";
+
 	spin_lock_init(&pmu_blink_lock);
 	/* no outstanding req */
 	pmu_blink_req.complete = 1;
@@ -114,4 +117,6 @@ static int __init via_pmu_led_init(void)
 	return led_classdev_register(NULL, &pmu_led);
 }
 
+core_param(adb_pmu_led_disk, adb_pmu_led_disk, bool, 0644);
+
 late_initcall(via_pmu_led_init);
-- 
2.33.1

