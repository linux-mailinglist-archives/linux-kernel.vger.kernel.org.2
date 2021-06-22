Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA4C63B0591
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jun 2021 15:11:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231874AbhFVNN3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Jun 2021 09:13:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231358AbhFVNMn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jun 2021 09:12:43 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CB3EC061756
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jun 2021 06:10:27 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id n7so23615750wri.3
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jun 2021 06:10:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NzFrqHGl0cYS27Ypm4XF1HD4hXM1cpi1KCAV815SAkE=;
        b=m3dsRsg1n3meWWr7UOpxI8c2ZbuWWgT7QaS4DTjMq/7pwvhjhnYKRpXUS+RQVi92Rh
         DVJWWsyXTlxRoZAupHBKGotTAKp7nGYuZMgzM1LREO7Ny7hNcaLiJJt2wlwwponr9JCE
         nMc7cm/7YUcbtgJ9YTplUZKBETjxlGQx2mBjoksJkjUKyKpHVygYzuDs4lEDFAuQ5MK5
         3Sz5FkGVjeOCBuUyWYM6y1TgYkAIPFnmflqrYr0XZCeLV6BJq7fFB7088MBsf84olAVU
         VvhWNy3PVvSblXX5O3U3sJXI5gte0ZbnNU/Zhiic4erA+Yb2jv//BZqowZePpa9AK99L
         LmOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NzFrqHGl0cYS27Ypm4XF1HD4hXM1cpi1KCAV815SAkE=;
        b=HQNc52vrv3hXRP8TLTp+pYLdogiZS4vb0zPlaI6WpSP5gg2mr0/2aXwuKr97W7XG8S
         GpB7hpaRJBMOZxXRCLh4X3ZWu8tst/cdMRGdecxlck7fIa5gQhSlmy59yX9Z12m5lfa8
         Ky8lSj2Em7VQPQ5zMygCGwNHBwn24Hmhv2Im+PmmqvQr52UUR9oph5k2NC+4KPl5XaIB
         dMZicxkiMTt/8NDcO851sXDhX4F8SrqXtNU22XmrpT8XmpapDmnj+6vgbKYdawn99gwu
         6WYFgc6EgkqPI2kf7yIfExzCFCpadRPoG5WBs8IoQmpFzDRTx+/H6U3ACpStIDpCAAtk
         LzCA==
X-Gm-Message-State: AOAM5318IO8vxsl+voK9fVknmyEXPEvSAYvW/g5DLMLUAfCWksYAinDa
        GshWRP+TKdc8QSUde3jYK7VZWktqD9uOLg==
X-Google-Smtp-Source: ABdhPJx3KuCSb6H/0ivB59nBbcz2C0Ge7IiwKZyo5f+S4FSkFZEunM0RpNO+IMoBCF2i8W0aOOye/A==
X-Received: by 2002:adf:e449:: with SMTP id t9mr4913875wrm.40.1624367425972;
        Tue, 22 Jun 2021 06:10:25 -0700 (PDT)
Received: from agape ([5.171.73.108])
        by smtp.gmail.com with ESMTPSA id l12sm21334613wro.32.2021.06.22.06.10.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jun 2021 06:10:25 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     hdegoede@redhat.com, Larry.Finger@lwfinger.net,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v3 15/17] staging: rtl8723bs: remove obsolete 5Ghz comments
Date:   Tue, 22 Jun 2021 15:09:59 +0200
Message-Id: <608f0b08ffae821d695cb2eadcffbd592912c906.1624367072.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1624367071.git.fabioaiuto83@gmail.com>
References: <cover.1624367071.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

remove obsolete 5Ghz comments.

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c | 2 --
 drivers/staging/rtl8723bs/os_dep/wifi_regd.c      | 4 ----
 2 files changed, 6 deletions(-)

diff --git a/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c b/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
index 8514cfb3d7e0..427f0b88abd7 100644
--- a/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
+++ b/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
@@ -202,8 +202,6 @@ rtw_cfg80211_default_mgmt_stypes[NUM_NL80211_IFTYPES] = {
 
 static int rtw_ieee80211_channel_to_frequency(int chan, int band)
 {
-	/* see 802.11 17.3.8.3.2 and Annex J
-	* there are overlapping channel numbers in 5GHz and 2GHz bands */
 	if (band == NL80211_BAND_2GHZ) {
 		if (chan == 14)
 			return 2484;
diff --git a/drivers/staging/rtl8723bs/os_dep/wifi_regd.c b/drivers/staging/rtl8723bs/os_dep/wifi_regd.c
index 0084589499b9..5eef1d68c6f0 100644
--- a/drivers/staging/rtl8723bs/os_dep/wifi_regd.c
+++ b/drivers/staging/rtl8723bs/os_dep/wifi_regd.c
@@ -44,10 +44,6 @@ static const struct ieee80211_regdomain rtw_regdom_rd = {
 
 static int rtw_ieee80211_channel_to_frequency(int chan, int band)
 {
-	/* see 802.11 17.3.8.3.2 and Annex J
-	 * there are overlapping channel numbers in 5GHz and 2GHz bands
-	 */
-
 	/* NL80211_BAND_2GHZ */
 	if (chan == 14)
 		return 2484;
-- 
2.20.1

