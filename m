Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EED9344749
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 15:33:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231136AbhCVOcz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 10:32:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230245AbhCVOcR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 10:32:17 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25EC3C061574
        for <linux-kernel@vger.kernel.org>; Mon, 22 Mar 2021 07:32:17 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id a7so21635190ejs.3
        for <linux-kernel@vger.kernel.org>; Mon, 22 Mar 2021 07:32:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tbMCb/XmLUDBwRP+A1f4oKC0PLquXQAMQOI8fIrmC/w=;
        b=JMwM/LJ+Zd84CAeZmis8QESvvX2quoADM2t2s4N4uL2DpoTiZePCENjHFBTSri+WkV
         bYJsO3jw5ZXLcZ403tFFBI5zeLTBacR/nCtbdVQbojuF95SZK5swte2tz6epNxLcU+1+
         VFTloh5bsoXc2hSa0lPu9x/SlMSbtfyqqQ/lAJcsS9G3HS5Y7gqxrEVFaIG7qvO2aiE1
         BDnYA3CLELUiE86MWYYPdLGvkI2yA2e3UjNo2lozkeCK5qukNCcOq6KJUijzkYtcPP2e
         4CvSgEDMjGryq5ruhhY/bN8awFyQkr2Bd4FZxzkuqFr0iqcA/nGfnxwSu8jDf6N+rDJV
         wNOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tbMCb/XmLUDBwRP+A1f4oKC0PLquXQAMQOI8fIrmC/w=;
        b=n7nN4eoSrGBhDXO1UG4Hf2H/4+y0h7G8cjjF5SShsym6Fj6h7u8ZqVb+wuU7/ONno1
         EPxq8CjiNN13AiOQ77XpnfC5iKyNm0hrrzb0XmY5qHZs4q/gYsQyitDZ/mb99yrO4EzE
         TaS3K1ed4oMkw1wgyRKmiuNsenjDrRVg6e+wXSUpMv3rQxJKDzPOlQF8D1oJfX8mXL8y
         2fOIv7R0Po0em+UM107yiIyKydA8W7vBKhjTXs6TlrVTcWmuO8/j6i0j+2U8cyOqnbLV
         XKIh87xaFtmir5wXph/+lks1aMJsdEy6jP5AS7I1nmSIW0F8QHAEFzFfeZHdbJGDdhi9
         DbCg==
X-Gm-Message-State: AOAM533j8uT83ota0ryTtAPtUGBSiObibGELNrlzZW7hJJ7qeoxOzkcM
        uR2ClhJWMs5RvlC1OShVTfw=
X-Google-Smtp-Source: ABdhPJw4ThLUrKUJMsWqBzWZUc+urZc6B+0H8nW4GxQdU8f1lma4RLwnDo4v9lUrar5TqwRqczporA==
X-Received: by 2002:a17:906:7194:: with SMTP id h20mr57072ejk.154.1616423535921;
        Mon, 22 Mar 2021 07:32:15 -0700 (PDT)
Received: from agape ([151.57.176.11])
        by smtp.gmail.com with ESMTPSA id k12sm11442121edo.50.2021.03.22.07.32.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Mar 2021 07:32:15 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     joe@perches.com, apw@canonical.com, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, Fabio Aiuto <fabioaiuto83@gmail.com>
Subject: [PATCH 03/11] staging: rtl8723bs: moved function prototype out of core/rtw_ioctl_set.c and core/rtw_mlme.c
Date:   Mon, 22 Mar 2021 15:31:41 +0100
Message-Id: <81ccf18df5ca0acab5bb8da2b675a03626ef57ac.1616422773.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1616422773.git.fabioaiuto83@gmail.com>
References: <cover.1616422773.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

fix the following checkpatch issues:

WARNING: externs should be avoided in .c files
40: FILE: drivers/staging/rtl8723bs/core/rtw_ioctl_set.c:40:
+u8 rtw_do_join(struct adapter *padapter);

WARNING: externs should be avoided in .c files
15: FILE: drivers/staging/rtl8723bs/core/rtw_mlme.c:15:
+extern u8 rtw_do_join(struct adapter *padapter);

moved function prototype in include/rtw_ioctl_set.h

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_ioctl_set.c    | 1 -
 drivers/staging/rtl8723bs/core/rtw_mlme.c         | 2 --
 drivers/staging/rtl8723bs/include/rtw_ioctl_set.h | 2 ++
 3 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_ioctl_set.c b/drivers/staging/rtl8723bs/core/rtw_ioctl_set.c
index cb14855742f7..7d858cae2395 100644
--- a/drivers/staging/rtl8723bs/core/rtw_ioctl_set.c
+++ b/drivers/staging/rtl8723bs/core/rtw_ioctl_set.c
@@ -37,7 +37,6 @@ u8 rtw_validate_ssid(struct ndis_802_11_ssid *ssid)
 	return ret;
 }
 
-u8 rtw_do_join(struct adapter *padapter);
 u8 rtw_do_join(struct adapter *padapter)
 {
 	struct list_head	*plist, *phead;
diff --git a/drivers/staging/rtl8723bs/core/rtw_mlme.c b/drivers/staging/rtl8723bs/core/rtw_mlme.c
index 95cfef118a94..1ee86ec2dee7 100644
--- a/drivers/staging/rtl8723bs/core/rtw_mlme.c
+++ b/drivers/staging/rtl8723bs/core/rtw_mlme.c
@@ -12,8 +12,6 @@
 #include <hal_btcoex.h>
 #include <linux/jiffies.h>
 
-extern u8 rtw_do_join(struct adapter *padapter);
-
 int	rtw_init_mlme_priv(struct adapter *padapter)
 {
 	int	i;
diff --git a/drivers/staging/rtl8723bs/include/rtw_ioctl_set.h b/drivers/staging/rtl8723bs/include/rtw_ioctl_set.h
index 4b929b84040a..55722c1366aa 100644
--- a/drivers/staging/rtl8723bs/include/rtw_ioctl_set.h
+++ b/drivers/staging/rtl8723bs/include/rtw_ioctl_set.h
@@ -28,6 +28,8 @@ u8 rtw_set_802_11_connect(struct adapter *padapter, u8 *bssid, struct ndis_802_1
 u8 rtw_validate_bssid(u8 *bssid);
 u8 rtw_validate_ssid(struct ndis_802_11_ssid *ssid);
 
+u8 rtw_do_join(struct adapter *padapter);
+
 u16 rtw_get_cur_max_rate(struct adapter *adapter);
 
 #endif
-- 
2.20.1

