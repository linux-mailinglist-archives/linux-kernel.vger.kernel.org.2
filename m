Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DB59309B09
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Jan 2021 08:59:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229872AbhAaH6Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Jan 2021 02:58:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229641AbhAaHzf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Jan 2021 02:55:35 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC200C06174A;
        Sat, 30 Jan 2021 23:54:54 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id v15so13183977wrx.4;
        Sat, 30 Jan 2021 23:54:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=TlnMMUHzs0gVAUol/fqoFC0sKz26EovlEEypljhkOAU=;
        b=foo2wXFSFIblemDPocX9l0etI+cNHgr9kVmmBmln/H8p47AX3wT/g/iSYQLxl+Hetv
         6wgUh3oGf0vGSWi/Rty1dk82UfLJ2ftOa1Af5M2DuiivB38jYKQXs738xRf1mFAAKBsJ
         6PDxWculAvXNlI5G1lHibIBsGPUXWkGlDcSCRDIqmFWJEWLRQ3INh//laGhITv+Ekv/y
         1bbWchJuosHwugWkds0Ecb0EnwpYuz7YFWqDH3cHuxvs3GZmKstXinf0cuttH/3iQPwB
         C5FubnLJjdgCPbp+MbHDwqB04gZhADrMccQ3P54f44e0/wEdah912jL40tfooN/aMZQL
         SZ/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=TlnMMUHzs0gVAUol/fqoFC0sKz26EovlEEypljhkOAU=;
        b=f4jqaSxydzCnIzOv6NmWILBHbaCU4jthVnDnLRaiAPZ5IPeMa9Al3DbkiR/Dxqnu4V
         N/JVCORArDiptxjPAGmXFIHH7aTB56OQFfAIqBuk8vjTQGMlE+cQ7ohyFy2zkJvtbTSl
         UlRkem8S85wvOl1wbd/F32bPklaRs8qRvsYMrvevQxzFqXxVbol5UhUMdpCgYsdEQQvH
         WwwlRl8jFS/b7LCm6Ja1p6+EQV9/pK+aeAuvn5RV6+srkTKcFh6Mk8ZOhrQ7Ed6zdLFk
         j544poI+xejhNHIwl/Fh2WCan5kjZYiU7TnpBNCcsJGOTlF4+R02g/+RfoKOZwmkWm4O
         q+Gg==
X-Gm-Message-State: AOAM531vIdEAdldXVMRaTJ4KufFDQ+//TjrVPUI4AgfP0TGQYsy4Wd6X
        roKNWNTyn8SQvoyeG6Vo9sQ=
X-Google-Smtp-Source: ABdhPJyCI9dYQOzut+jklS1h+lO1K2qemD54AAaOVMN7mzWvqpHvoFKC4sQqYM9JDv2CCF9o0BMbZw==
X-Received: by 2002:a05:6000:1202:: with SMTP id e2mr953534wrx.328.1612079693359;
        Sat, 30 Jan 2021 23:54:53 -0800 (PST)
Received: from felia.fritz.box ([2001:16b8:2d29:6400:618b:2d13:c477:783d])
        by smtp.gmail.com with ESMTPSA id n16sm17687386wmi.5.2021.01.30.23.54.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Jan 2021 23:54:52 -0800 (PST)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Guenter Roeck <linux@roeck-us.net>, linux-hwmon@vger.kernel.org
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-doc@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH for -next] docs: hwmon: rectify table in max16601.rst
Date:   Sun, 31 Jan 2021 08:54:45 +0100
Message-Id: <20210131075445.21222-1-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 90b0f71d62df ("hwmon: (pmbus/max16601) Determine and use number of
populated phases") adjusts content in the table of
./Documentation/hwmon/max16601.rst, but one row went beyond the column's
length.

Hence, make htmldocs warns:

  Documentation/hwmon/max16601.rst:94: WARNING: Malformed table.

Adjust the column length of that table for this longer row to fit.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
applies cleanly on next-20210129

Guenter, please pick this minor fixup for your hwmon-next tree.

 Documentation/hwmon/max16601.rst | 143 +++++++++++++++----------------
 1 file changed, 71 insertions(+), 72 deletions(-)

diff --git a/Documentation/hwmon/max16601.rst b/Documentation/hwmon/max16601.rst
index d16792be7533..d265a2224354 100644
--- a/Documentation/hwmon/max16601.rst
+++ b/Documentation/hwmon/max16601.rst
@@ -53,75 +53,74 @@ Sysfs entries
 
 The following attributes are supported.
 
-======================= =======================================================
-in1_label		"vin1"
-in1_input		VCORE input voltage.
-in1_alarm		Input voltage alarm.
-
-in2_label		"vout1"
-in2_input		VCORE output voltage.
-in2_alarm		Output voltage alarm.
-
-curr1_label		"iin1"
-curr1_input		VCORE input current, derived from duty cycle and output
-			current.
-curr1_max		Maximum input current.
-curr1_max_alarm		Current high alarm.
-
-curr[P+2]_label		"iin1.P"
-curr[P+2]_input		VCORE phase P input current.
-
-curr[N+2]_label		"iin2"
-curr[N+2]_input		VCORE input current, derived from sensor element.
-			'N' is the number of enabled/populated phases.
-
-curr[N+3]_label		"iin3"
-curr[N+3]_input		VSA input current.
-
-curr[N+4]_label		"iout1"
-curr[N+4]_input		VCORE output current.
-curr[N+4]_crit		Critical output current.
-curr[N+4]_crit_alarm	Output current critical alarm.
-curr[N+4]_max		Maximum output current.
-curr[N+4]_max_alarm	Output current high alarm.
-
-curr[N+P+5]_label	"iout1.P"
-curr[N+P+5]_input	VCORE phase P output current.
-
-curr[2*N+5]_label	"iout3"
-curr[2*N+5]_input	VSA output current.
-curr[2*N+5]_highest	Historical maximum VSA output current.
-curr[2*N+5]_reset_history
-			Write any value to reset curr21_highest.
-curr[2*N+5]_crit	Critical output current.
-curr[2*N+5]_crit_alarm	Output current critical alarm.
-curr[2*N+5]_max		Maximum output current.
-curr[2*N+5]_max_alarm	Output current high alarm.
-
-power1_label		"pin1"
-power1_input		Input power, derived from duty cycle and output current.
-power1_alarm		Input power alarm.
-
-power2_label		"pin2"
-power2_input		Input power, derived from input current sensor.
-
-power3_label		"pout"
-power3_input		Output power.
-
-temp1_input		VCORE temperature.
-temp1_crit		Critical high temperature.
-temp1_crit_alarm	Chip temperature critical high alarm.
-temp1_max		Maximum temperature.
-temp1_max_alarm		Chip temperature high alarm.
-
-temp2_input		TSENSE_0 temperature
-temp3_input		TSENSE_1 temperature
-temp4_input		TSENSE_2 temperature
-temp5_input		TSENSE_3 temperature
-
-temp6_input		VSA temperature.
-temp6_crit		Critical high temperature.
-temp6_crit_alarm	Chip temperature critical high alarm.
-temp6_max		Maximum temperature.
-temp6_max_alarm		Chip temperature high alarm.
-======================= =======================================================
+========================= =======================================================
+in1_label		  "vin1"
+in1_input		  VCORE input voltage.
+in1_alarm		  Input voltage alarm.
+
+in2_label		  "vout1"
+in2_input		  VCORE output voltage.
+in2_alarm		  Output voltage alarm.
+
+curr1_label		  "iin1"
+curr1_input		  VCORE input current, derived from duty cycle and output
+			  current.
+curr1_max		  Maximum input current.
+curr1_max_alarm		  Current high alarm.
+
+curr[P+2]_label		  "iin1.P"
+curr[P+2]_input		  VCORE phase P input current.
+
+curr[N+2]_label		  "iin2"
+curr[N+2]_input		  VCORE input current, derived from sensor element.
+			  'N' is the number of enabled/populated phases.
+
+curr[N+3]_label		  "iin3"
+curr[N+3]_input		  VSA input current.
+
+curr[N+4]_label		  "iout1"
+curr[N+4]_input		  VCORE output current.
+curr[N+4]_crit		  Critical output current.
+curr[N+4]_crit_alarm	  Output current critical alarm.
+curr[N+4]_max		  Maximum output current.
+curr[N+4]_max_alarm	  Output current high alarm.
+
+curr[N+P+5]_label	  "iout1.P"
+curr[N+P+5]_input	  VCORE phase P output current.
+
+curr[2*N+5]_label	  "iout3"
+curr[2*N+5]_input	  VSA output current.
+curr[2*N+5]_highest	  Historical maximum VSA output current.
+curr[2*N+5]_reset_history Write any value to reset curr21_highest.
+curr[2*N+5]_crit	  Critical output current.
+curr[2*N+5]_crit_alarm	  Output current critical alarm.
+curr[2*N+5]_max		  Maximum output current.
+curr[2*N+5]_max_alarm	  Output current high alarm.
+
+power1_label		  "pin1"
+power1_input		  Input power, derived from duty cycle and output current.
+power1_alarm		  Input power alarm.
+
+power2_label		  "pin2"
+power2_input		  Input power, derived from input current sensor.
+
+power3_label		  "pout"
+power3_input		  Output power.
+
+temp1_input		  VCORE temperature.
+temp1_crit		  Critical high temperature.
+temp1_crit_alarm	  Chip temperature critical high alarm.
+temp1_max		  Maximum temperature.
+temp1_max_alarm		  Chip temperature high alarm.
+
+temp2_input		  TSENSE_0 temperature
+temp3_input		  TSENSE_1 temperature
+temp4_input		  TSENSE_2 temperature
+temp5_input		  TSENSE_3 temperature
+
+temp6_input		  VSA temperature.
+temp6_crit		  Critical high temperature.
+temp6_crit_alarm	  Chip temperature critical high alarm.
+temp6_max		  Maximum temperature.
+temp6_max_alarm		  Chip temperature high alarm.
+========================= =======================================================
-- 
2.17.1

