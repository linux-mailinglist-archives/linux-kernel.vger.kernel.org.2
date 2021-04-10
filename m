Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CFE635AE21
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Apr 2021 16:21:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234902AbhDJOVP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Apr 2021 10:21:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234841AbhDJOVG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Apr 2021 10:21:06 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4D54C06138C
        for <linux-kernel@vger.kernel.org>; Sat, 10 Apr 2021 07:20:51 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id l4so12997188ejc.10
        for <linux-kernel@vger.kernel.org>; Sat, 10 Apr 2021 07:20:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=M8UGOlW3y8/Y6JrVp5NlfqqjWEIFU9lAyoBNMh7m3sA=;
        b=Vatkr4V3Llan1pSq9hiPUt9WCjQMwXnAwvCRQxJzMhIpq/BYQLSs8w5p4zSueGDq5L
         D+UbJe6xFOhknkHv7s4Ewizpbgzcw8oAkJUDJXe66J1wc1lHp3/t5fEvVYgIVsnPMnTk
         GxfQXQGTG9AKSUQ32PrFrV+YWcT15o6uOd4qjoNq1ztWR8Vf2Jtnqt+zOblhuEGpf1hG
         wCEGVRzBlCtDc0ky+U69QEmnv6EqMEmy7H93fUOnJN3So93g4bthWdUEbQNEwJWHrEem
         JEGiYHQLFOss+hZQedFPxhsurxJbuzTWEv+PrUlQWl4qvKNyLmfYDyLNJOW8aPYWOqnI
         Yy3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=M8UGOlW3y8/Y6JrVp5NlfqqjWEIFU9lAyoBNMh7m3sA=;
        b=PW42JoEICP7jYiaxJxv5Ap+mec1JqrsfD130A6i8nyp8BME7DakG5R3rYpQlXsujG1
         T//pwWne2kX/GXbZ0auvhbbxCGFNxVEMUKzDu9zlWvFXXCL4L1l4bvQ7Evmw0tUUss9j
         f4WrtZKxXL8R9guQ/QkpUDOIP7uOSzpvxb592lLZ+AHe0KhQbGyZuGEki3ffdFBwj9yx
         yUoy38QlFm8wYgjQx4kMGGSZQwFMAFnltNMyIAlrw8T8MMNc3RkcFJNX0ZSmKeluuAK7
         KP0w1oZzxBe/7FqaYmUzZlXxJghzIDGpiAQ75i+KaDGqhdbAKLxPnt0cPwnb2hGMzVOI
         s31A==
X-Gm-Message-State: AOAM533MdtJPvA1w5nWNA5NM+Jhz8SnEfOTKIcis9tKSLDRpfAmSdOYY
        bP53qZqaZAETmqkS7LHx2E6NqXePUBOc8g==
X-Google-Smtp-Source: ABdhPJzUeQpIHDSTHnnlZ2VzBHMm9XbYg5vOG3T0gEzo/Z913Gs1GitHLjyOh5uIU6WA/LkFhXH7og==
X-Received: by 2002:a17:906:1284:: with SMTP id k4mr19493961ejb.409.1618064450390;
        Sat, 10 Apr 2021 07:20:50 -0700 (PDT)
Received: from agape ([5.171.81.28])
        by smtp.gmail.com with ESMTPSA id jo12sm2699349ejb.52.2021.04.10.07.20.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Apr 2021 07:20:50 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 06/25] staging: rtl8723bs: remove unused code blocks guarded by DEBUG_RTL871X
Date:   Sat, 10 Apr 2021 16:20:19 +0200
Message-Id: <c7b590b7ae7fad08cd913462ab385db9230ede4d.1618064274.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1618064274.git.fabioaiuto83@gmail.com>
References: <cover.1618064274.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

remove unused code blocks guarded by never set DEBUG_RTL871X

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_debug.c    | 35 -------------------
 drivers/staging/rtl8723bs/core/rtw_mlme_ext.c | 20 -----------
 2 files changed, 55 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_debug.c b/drivers/staging/rtl8723bs/core/rtw_debug.c
index c48a8b80af4c..d3ee7b7f6fde 100644
--- a/drivers/staging/rtl8723bs/core/rtw_debug.c
+++ b/drivers/staging/rtl8723bs/core/rtw_debug.c
@@ -12,41 +12,6 @@
 
 u32 GlobalDebugLevel = _drv_err_;
 
-#ifdef DEBUG_RTL871X
-
-	u64 GlobalDebugComponents = \
-			_module_rtl871x_xmit_c_ |
-			_module_xmit_osdep_c_ |
-			_module_rtl871x_recv_c_ |
-			_module_recv_osdep_c_ |
-			_module_rtl871x_mlme_c_ |
-			_module_mlme_osdep_c_ |
-			_module_rtl871x_sta_mgt_c_ |
-			_module_rtl871x_cmd_c_ |
-			_module_cmd_osdep_c_ |
-			_module_rtl871x_io_c_ |
-			_module_io_osdep_c_ |
-			_module_os_intfs_c_|
-			_module_rtl871x_security_c_|
-			_module_rtl871x_eeprom_c_|
-			_module_hal_init_c_|
-			_module_hci_hal_init_c_|
-			_module_rtl871x_ioctl_c_|
-			_module_rtl871x_ioctl_set_c_|
-			_module_rtl871x_ioctl_query_c_|
-			_module_rtl871x_pwrctrl_c_|
-			_module_hci_intfs_c_|
-			_module_hci_ops_c_|
-			_module_hci_ops_os_c_|
-			_module_rtl871x_ioctl_os_c|
-			_module_rtl8712_cmd_c_|
-			_module_hal_xmit_c_|
-			_module_rtl8712_recv_c_ |
-			_module_mp_ |
-			_module_efuse_;
-
-#endif /* DEBUG_RTL871X */
-
 #include <rtw_version.h>
 
 void dump_drv_version(void *sel)
diff --git a/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c b/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
index e2217df30000..f19a15a3924b 100644
--- a/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
+++ b/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
@@ -4402,20 +4402,7 @@ static void process_80211d(struct adapter *padapter, struct wlan_bssid_ex *bssid
 		}
 		chplan_ap.Len = i;
 
-#ifdef DEBUG_RTL871X
-		i = 0;
-		while ((i < chplan_ap.Len) && (chplan_ap.Channel[i] != 0)) {
-			i++;
-		}
-#endif
-
 		memcpy(chplan_sta, pmlmeext->channel_set, sizeof(chplan_sta));
-#ifdef DEBUG_RTL871X
-		i = 0;
-		while ((i < MAX_CHANNEL_NUM) && (chplan_sta[i].ChannelNum != 0)) {
-			i++;
-		}
-#endif
 
 		memset(pmlmeext->channel_set, 0, sizeof(pmlmeext->channel_set));
 		chplan_new = pmlmeext->channel_set;
@@ -4543,13 +4530,6 @@ static void process_80211d(struct adapter *padapter, struct wlan_bssid_ex *bssid
 		}
 
 		pmlmeext->update_channel_plan_by_ap_done = 1;
-
-#ifdef DEBUG_RTL871X
-		k = 0;
-		while ((k < MAX_CHANNEL_NUM) && (chplan_new[k].ChannelNum != 0)) {
-			k++;
-		}
-#endif
 	}
 
 	/*  If channel is used by AP, set channel scan type to active */
-- 
2.20.1

