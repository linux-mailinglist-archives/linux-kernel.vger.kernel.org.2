Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFBA2407B34
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Sep 2021 03:17:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234577AbhILBTH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Sep 2021 21:19:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229947AbhILBTG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Sep 2021 21:19:06 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2F68C061574;
        Sat, 11 Sep 2021 18:17:52 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id n7-20020a05600c3b8700b002f8ca941d89so4000041wms.2;
        Sat, 11 Sep 2021 18:17:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XhbId2wN0jv4HXPk/iZgFZuH5a2t3J4O7Pys7DCf4C0=;
        b=bv9VsQoaBInkRoLVc9Jv+OkZTNaa2csXmgb6EdtL7zJNh77nZcHaj0DrQtqFSHHS7b
         YAr20zg+C0REEXrC0iMW3/qG+zEwzz8kdG7QEDKuaHZzsX1KDCU6GKjb0iZwonGaN2/W
         rnwnwB/Ue9GsPT0J5WAbSerm5I5p4KykiOG7mIjM725E4/kuKPedF8ZjakjMNfEbsaya
         c4AINrnfOjtfyec0r0E1XFIV7ZNovEJStrTzzIaJ3i62AIb3ljT8dunuOfKaruTP5AJk
         xtVsYJJWpLfsnAm4GcElUCqICVS4ahypNYqol3kxqPEie31YawrEGWlxyvuPDCn6WnB6
         LJsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XhbId2wN0jv4HXPk/iZgFZuH5a2t3J4O7Pys7DCf4C0=;
        b=w+ZEuRTjzSonBBulMsPVHk378fXayuo1aWdEuRZfMg6m7pJmVsOibQ9Vr6MBcSEN92
         IEvxbZhgdS2lzNezGxUVNzbJSvgyMOZbL9Gx7aUDxN1ycM3QR5kiXr3UM21Vl8UXNk7y
         rCEx387iBaDG0DhoOtXcyhV5jCEkO/nsvL6n4vJRUPPH8V1rUj3fpEO1b/dzVGIfbPOQ
         RjCC8RyjXADNYRQjeYfnqbCavuYVT756k7QsFNIzjQU1qeNP55QPsXTT/HrFaJQE1ueh
         QCWuTRb9XyLFTuWBw7XAT0swGMRJVGlLUsD1Y7CC3fS85El1gewIAsr9rLgA1lJFlQ3c
         R7KA==
X-Gm-Message-State: AOAM530unoLw2x6VWET2d3Zgavyr3pkP0Rx17tSV40FAOIJD55YpJIk0
        DfTf/6UufNyaFQvaN3cerHE8pftrfw==
X-Google-Smtp-Source: ABdhPJwHXkkTH8DTbGmya/tqP+NzRrLV7oFmY9BNMOXmt/b1312h/+SugW/k3hFS22zusEs1vuEkKQ==
X-Received: by 2002:a7b:c005:: with SMTP id c5mr4690874wmb.59.1631409471280;
        Sat, 11 Sep 2021 18:17:51 -0700 (PDT)
Received: from localhost.localdomain (88-108-171-137.dynamic.dsl.as9105.com. [88.108.171.137])
        by smtp.gmail.com with ESMTPSA id h15sm2996296wrc.19.2021.09.11.18.17.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Sep 2021 18:17:51 -0700 (PDT)
From:   Jules Irenge <jbi.octave@gmail.com>
To:     jlee@suse.com
Cc:     hdegoede@redhat.com, mgross@linux.intel.com,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jules Irenge <jbi.octave@gmail.com>
Subject: [PATCH] acer-wmi: use __packed instead of __attribute__((packed))
Date:   Sun, 12 Sep 2021 02:17:41 +0100
Message-Id: <20210912011741.30495-1-jbi.octave@gmail.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

checkpatch.pl tool warns about using __attribute__((packed))
"WARNING: __packed is preferred over __attribute__((packed))"
To fix this __attribute__((packed)) is replaced by __packed

Signed-off-by: Jules Irenge <jbi.octave@gmail.com>
---
 drivers/platform/x86/acer-wmi.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/platform/x86/acer-wmi.c b/drivers/platform/x86/acer-wmi.c
index 694b45ed06a2..9c6943e401a6 100644
--- a/drivers/platform/x86/acer-wmi.c
+++ b/drivers/platform/x86/acer-wmi.c
@@ -138,7 +138,7 @@ struct event_return_value {
 	u16 reserved1;
 	u8 kbd_dock_state;
 	u8 reserved2;
-} __attribute__((packed));
+} __packed;
 
 /*
  * GUID3 Get Device Status device flags
@@ -172,33 +172,33 @@ struct func_input_params {
 	u8 app_status;          /* Acer Device Status. LM, ePM, RF Button... */
 	u8 app_mask;		/* Bit mask to app_status */
 	u8 reserved;
-} __attribute__((packed));
+} __packed;
 
 struct func_return_value {
 	u8 error_code;          /* Error Code */
 	u8 ec_return_value;     /* EC Return Value */
 	u16 reserved;
-} __attribute__((packed));
+} __packed;
 
 struct wmid3_gds_set_input_param {     /* Set Device Status input parameter */
 	u8 function_num;        /* Function Number */
 	u8 hotkey_number;       /* Hotkey Number */
 	u16 devices;            /* Set Device */
 	u8 volume_value;        /* Volume Value */
-} __attribute__((packed));
+} __packed;
 
 struct wmid3_gds_get_input_param {     /* Get Device Status input parameter */
 	u8 function_num;	/* Function Number */
 	u8 hotkey_number;	/* Hotkey Number */
 	u16 devices;		/* Get Device */
-} __attribute__((packed));
+} __packed;
 
 struct wmid3_gds_return_value {	/* Get Device Status return value*/
 	u8 error_code;		/* Error Code */
 	u8 ec_return_value;	/* EC Return Value */
 	u16 devices;		/* Current Device Status */
 	u32 reserved;
-} __attribute__((packed));
+} __packed;
 
 struct hotkey_function_type_aa {
 	u8 type;
@@ -210,7 +210,7 @@ struct hotkey_function_type_aa {
 	u16 display_func_bitmap;
 	u16 others_func_bitmap;
 	u8 commun_fn_key_number;
-} __attribute__((packed));
+} __packed;
 
 /*
  * Interface capability flags
-- 
2.32.0

