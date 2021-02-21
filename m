Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0889320DCC
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Feb 2021 22:05:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230211AbhBUVEY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Feb 2021 16:04:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229985AbhBUVEU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Feb 2021 16:04:20 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 291AEC061574;
        Sun, 21 Feb 2021 13:03:40 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id o10so6616406wmc.1;
        Sun, 21 Feb 2021 13:03:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QpVogwZXK8MPIrBQ4cNdy6joZ0UgMTCKhaogvnww6HU=;
        b=gGGkA0RMlUyTXDedZpkL/fAgmAMdqkR3kTGqfCwoGsItK0Ie5iYwIRpD2EbWCpNcWm
         TLUMkVW+ywGSLfU7ldmNlIFOe35zU7/2l0wCeztJYR6im+HHJeQYjilMvlW8J2lgJHmu
         RcddwhQDnqqO1SiExnzrdk65D3VETWU+OuHw5ashv9vNnnFSgpbHkXtVWSrtxJ9cFIUS
         n1DhAK73ueHfCTQRr+WLvWowbmOyU3rtZKsvYs7CwDeXOa7yLb/3w9Q+5cdF3Ye1MBj5
         tzII5Teu4On4LPpLmNk3Sjxj4zoKZf9Vpp01gMRrb5o2osjoAS7fT81b0AGyqYbmOgQc
         Hejw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QpVogwZXK8MPIrBQ4cNdy6joZ0UgMTCKhaogvnww6HU=;
        b=Pa7Jc8vKuAzALxe4Ck5LfsEK96M4gQqYzZSj+pr/gweJJhJY7wXE8WvtbewF3u2KUd
         k6PAa/3cSetCl2ZPlCxQvPZfVFjY3IS+Ur4cngZPGcHxtKcjf2ugsBDWB/EuUlQ7BHtC
         VdznxDmNONmaKq9Az6/1IsTejhKrkqdzuGV+CHYZibWyt9b3hjn7U/A6I7QOOSk+Xq6e
         XeUQT+QhP8H9QJRnfVoVcPu+bgwbe+aLm5iO4AO1OlqVKzLH8G5QzmFa+wTSzKKHzEOz
         utvkQP40imQMYEhjWPIATuxof/d93caF1ub/VJs9j6xuGH52DyEJqU4y6CtKruo4WMR0
         uOBA==
X-Gm-Message-State: AOAM530wbWoWYJD0JbTeshCffC4feUwFYDPwocm9w5LHNZirb06X9bkt
        K4ivGg/nq8QKPcjvajJ3uhZ9IKVPFgI19Q==
X-Google-Smtp-Source: ABdhPJzFBEco3abKziwfhUNSJSdjJQBC0vBKLxmcQMvYJhtHcebvNHiNQx0VTDowdpew8JJJwlHmBw==
X-Received: by 2002:a1c:7f83:: with SMTP id a125mr17128442wmd.141.1613941418890;
        Sun, 21 Feb 2021 13:03:38 -0800 (PST)
Received: from localhost.localdomain (host-79-22-224-43.retail.telecomitalia.it. [79.22.224.43])
        by smtp.gmail.com with ESMTPSA id b10sm18277956wmh.36.2021.02.21.13.03.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Feb 2021 13:03:38 -0800 (PST)
From:   Elia Devito <eliadevito@gmail.com>
Cc:     Elia Devito <eliadevito@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <mgross@linux.intel.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] platform/x86: hp-wmi: rename "thermal policy" to "thermal profile"
Date:   Sun, 21 Feb 2021 22:02:57 +0100
Message-Id: <20210221210256.68198-1-eliadevito@gmail.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

rename "thermal policy" with the more appropriate term "thermal profile"

Signed-off-by: Elia Devito <eliadevito@gmail.com>
---
 drivers/platform/x86/hp-wmi.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/platform/x86/hp-wmi.c b/drivers/platform/x86/hp-wmi.c
index e94e59283ecb..6d7b91b8109b 100644
--- a/drivers/platform/x86/hp-wmi.c
+++ b/drivers/platform/x86/hp-wmi.c
@@ -85,7 +85,7 @@ enum hp_wmi_commandtype {
 	HPWMI_FEATURE2_QUERY		= 0x0d,
 	HPWMI_WIRELESS2_QUERY		= 0x1b,
 	HPWMI_POSTCODEERROR_QUERY	= 0x2a,
-	HPWMI_THERMAL_POLICY_QUERY	= 0x4c,
+	HPWMI_THERMAL_PROFILE_QUERY	= 0x4c,
 };
 
 enum hp_wmi_command {
@@ -869,19 +869,19 @@ static int __init hp_wmi_rfkill2_setup(struct platform_device *device)
 	return err;
 }
 
-static int thermal_policy_setup(struct platform_device *device)
+static int thermal_profile_setup(struct platform_device *device)
 {
 	int err, tp;
 
-	tp = hp_wmi_read_int(HPWMI_THERMAL_POLICY_QUERY);
+	tp = hp_wmi_read_int(HPWMI_THERMAL_PROFILE_QUERY);
 	if (tp < 0)
 		return tp;
 
 	/*
-	 * call thermal policy write command to ensure that the firmware correctly
+	 * call thermal profile write command to ensure that the firmware correctly
 	 * sets the OEM variables for the DPTF
 	 */
-	err = hp_wmi_perform_query(HPWMI_THERMAL_POLICY_QUERY, HPWMI_WRITE, &tp,
+	err = hp_wmi_perform_query(HPWMI_THERMAL_PROFILE_QUERY, HPWMI_WRITE, &tp,
 							   sizeof(tp), 0);
 	if (err)
 		return err;
@@ -900,7 +900,7 @@ static int __init hp_wmi_bios_setup(struct platform_device *device)
 	if (hp_wmi_rfkill_setup(device))
 		hp_wmi_rfkill2_setup(device);
 
-	thermal_policy_setup(device);
+	thermal_profile_setup(device);
 
 	return 0;
 }
-- 
2.29.2

