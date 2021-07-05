Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91B633BBDD6
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jul 2021 15:50:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231404AbhGENwy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jul 2021 09:52:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231440AbhGENuy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jul 2021 09:50:54 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 081A9C061574
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jul 2021 06:48:16 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id bg14so29109852ejb.9
        for <linux-kernel@vger.kernel.org>; Mon, 05 Jul 2021 06:48:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura-hr.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QxtlH5tFXalepLIlvKTbHRvqAev9gVNl4cEeuInBWpg=;
        b=cJ1GDsPuxBv7eQjcAGUCvBZVluw68VpgBAOUoO7NzAjZ1WlnCnN/XpEc/nJkfSMrRL
         F1T19SrkRqdlC8747mOo9TbWexi27jV9uz3sOVxz2OWiNhlqtMxn4HsAI42kmNDxvLiv
         7uGtpkIoCaJiTj2L7bVjKutRTBaCae7CI8pxEMGoXIjQinTs+zZXSSGUnDP0WMBShKKF
         VKdfJOsRSTs3H+MASN00htis3pMG77oKpUbgB43x/p4QznlDNAIdwG8KGvF94X55ExvF
         FvxDvarIr1OIlkKCf8aV/8hBUTXlG/ahhs0Lme9pVPYrPgy0D6MvYJQZ2/79v3zBPzlG
         AcJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QxtlH5tFXalepLIlvKTbHRvqAev9gVNl4cEeuInBWpg=;
        b=BZNFC4phbo4PfcqH9DP0DU5ga63c2YwY2knE281tLBHWIJipcPdCSV6rMDAfsmIYRq
         Agt97tMZBgGbYQG6XivhP0TGE/8Rjv/ntGOw5+ci8uGiTaw4Ry/RECUVC7nb58s+PG6z
         9uUtKoyGXiSVUfqCv1kB4sFiI0vyh7cP1/5hrH/OO80sARD3LFiMAtUJiGzoesesSjyp
         /Y1VRcuAHc+Z66xnN0zr6zCi0+wvYyEWD4JAmEkbxfL933TODvXKUV19BFfySRJaF8KC
         icTWZfKEgqLyCLfbZEyMGzOrUdTblP8qhPILY159iL/iNsBFzP8bTnAe+DHYaK0nbk3F
         21RQ==
X-Gm-Message-State: AOAM530K36A6O6GZGqv2Rv7NuYKKO1PXj2X5sW3jCzyderDxQ+y7lnhw
        lxUbhSrf3s/uTsqUTq6hgVep5g==
X-Google-Smtp-Source: ABdhPJzQ5Zocp1Jh1fDFjhpB+4uv2lTTmlklAzEN+42T8ti8AJfd0QEPbBjGwH16Dq0BOY30rlGvQQ==
X-Received: by 2002:a17:906:4fcb:: with SMTP id i11mr11772841ejw.300.1625492894614;
        Mon, 05 Jul 2021 06:48:14 -0700 (PDT)
Received: from localhost.localdomain ([89.18.44.40])
        by smtp.gmail.com with ESMTPSA id cf29sm1557637edb.14.2021.07.05.06.48.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jul 2021 06:48:14 -0700 (PDT)
From:   Pavo Banicevic <pavo.banicevic@sartura.hr>
To:     linux-doc@vger.kernel.org, linux-leds@vger.kernel.org,
        devicetree@vger.kernel.org, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org, geert+renesas@glider.be,
        Max.Merchel@tq-group.com, linux@rempel-privat.de, daniel@0x0f.com,
        shawnguo@kernel.org, sam@ravnborg.org, arnd@arndb.de,
        krzysztof.kozlowski@canonical.com, pavo.banicevic@sartura.hr,
        corbet@lwn.net, lee.jones@linaro.org, pavel@ucw.cz,
        robh+dt@kernel.org, linux@roeck-us.net, jdelvare@suse.com,
        goran.medic@sartura.hr, luka.perkov@sartura.hr,
        luka.kovacic@sartura.hr
Cc:     Robert Marko <robert.marko@sartura.hr>
Subject: [PATCH v8 5/7] Documentation/ABI: Add iei-wt61p803-puzzle driver sysfs interface documentation
Date:   Mon,  5 Jul 2021 15:49:37 +0200
Message-Id: <20210705134939.28691-6-pavo.banicevic@sartura.hr>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210705134939.28691-1-pavo.banicevic@sartura.hr>
References: <20210705134939.28691-1-pavo.banicevic@sartura.hr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Luka Kovacic <luka.kovacic@sartura.hr>

Add the iei-wt61p803-puzzle driver sysfs interface documentation to allow
monitoring and control of the microcontroller from user space.

Signed-off-by: Luka Kovacic <luka.kovacic@sartura.hr>
Signed-off-by: Pavo Banicevic <pavo.banicevic@sartura.hr>
Cc: Luka Perkov <luka.perkov@sartura.hr>
Cc: Robert Marko <robert.marko@sartura.hr>
---
 .../testing/sysfs-driver-iei-wt61p803-puzzle  | 61 +++++++++++++++++++
 1 file changed, 61 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-driver-iei-wt61p803-puzzle

diff --git a/Documentation/ABI/testing/sysfs-driver-iei-wt61p803-puzzle b/Documentation/ABI/testing/sysfs-driver-iei-wt61p803-puzzle
new file mode 100644
index 000000000000..ab4415587f67
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-driver-iei-wt61p803-puzzle
@@ -0,0 +1,61 @@
+What:		/sys/bus/serial/devices/.../mac_address_*
+Date:		September 2020
+Contact:	Luka Kovacic <luka.kovacic@sartura.hr>
+Description:	(RW) Internal factory assigned MAC address values
+
+What:		/sys/bus/serial/devices/.../serial_number
+Date:		September 2020
+Contact:	Luka Kovacic <luka.kovacic@sartura.hr>
+Description:	(RW) Internal factory assigned serial number
+
+What:		/sys/bus/serial/devices/.../version
+Date:		September 2020
+Contact:	Luka Kovacic <luka.kovacic@sartura.hr>
+Description:	(RO) Internal MCU firmware version
+
+What:		/sys/bus/serial/devices/.../protocol_version
+Date:		September 2020
+Contact:	Luka Kovacic <luka.kovacic@sartura.hr>
+Description:	(RO) Internal MCU communication protocol version
+
+What:		/sys/bus/serial/devices/.../power_loss_recovery
+Date:		September 2020
+Contact:	Luka Kovacic <luka.kovacic@sartura.hr>
+Description:	(RW) Host platform power loss recovery settings
+		Value mapping: 0 - Always-On, 1 - Always-Off, 2 - Always-AC, 3 - Always-WA
+
+What:		/sys/bus/serial/devices/.../bootloader_mode
+Date:		September 2020
+Contact:	Luka Kovacic <luka.kovacic@sartura.hr>
+Description:	(RO) Internal MCU bootloader mode status
+		Value mapping:
+		0 - normal mode
+		1 - bootloader mode
+
+What:		/sys/bus/serial/devices/.../power_status
+Date:		September 2020
+Contact:	Luka Kovacic <luka.kovacic@sartura.hr>
+Description:	(RO) Power status indicates the host platform power on method.
+		Value mapping (bitwise list):
+		0x80 - Null
+		0x40 - Firmware flag
+		0x20 - Power loss detection flag (powered off)
+		0x10 - Power loss detection flag (AC mode)
+		0x08 - Button power on
+		0x04 - Wake-on-LAN power on
+		0x02 - RTC alarm power on
+		0x01 - AC recover power on
+
+What:		/sys/bus/serial/devices/.../build_info
+Date:		September 2020
+Contact:	Luka Kovacic <luka.kovacic@sartura.hr>
+Description:	(RO) Internal MCU firmware build date
+		Format: yyyy/mm/dd hh:mm
+
+What:		/sys/bus/serial/devices/.../ac_recovery_status
+Date:		September 2020
+Contact:	Luka Kovacic <luka.kovacic@sartura.hr>
+Description:	(RO) Host platform AC recovery status value
+		Value mapping:
+		0 - board has not been recovered from power down
+		1 - board has been recovered from power down
-- 
2.31.1

