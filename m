Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7E7C3D0FA3
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jul 2021 15:38:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238161AbhGUM5a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jul 2021 08:57:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238332AbhGUM5L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jul 2021 08:57:11 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7533AC061762
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jul 2021 06:37:47 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id ca14so2446395edb.2
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jul 2021 06:37:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fRJ7RvMKEMa0fIfZ1uQiITrFu/nbTu47gWA816rN7L4=;
        b=Re0xaXWymNrPYzyIEkg758nyjfjcOzurX09W25Tu+ziXm1ofnaFQ7NhHAXAUHpgxP7
         1fAonAD3W357XsWPXtZDj7GmzYvzmYZrGxjXxKMzzzNb2ueoUh0B9Jm3KkcT9EuSwxxw
         WAhbi0Y7vhRT5wbr0oS+/ei9OKkVqacuDbFKe98zRj2ICl1PYkFTlMy48D35Mqb9thNX
         DjEKQEE+Jlru7mIhzshK58ZS2QmA8cdzRJOF8ewirmowaduKQY1qISz2XTk1xmFH7WTT
         cqFimjo+qppaoyCCYHX196N6IotBpAeV3emg4jLUdCw2fB+CvbDTZRLSI9KTgX8xCSSr
         xbnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fRJ7RvMKEMa0fIfZ1uQiITrFu/nbTu47gWA816rN7L4=;
        b=RxC0Gnq1rPrsuMJ+dFl3QFoG8i5vZ/oDd4/NQcVrAcrZMYmVPfebT3KpxvQ+lR7ap9
         6671aBjeavIlCDJ8M8bUZClG5G18RDzGo/1autsP5kuv/agUWEswdmnwArQ/PS7sgUTU
         irP9ekUaVFPbdV90tyzcyvu/n3BHKXlMxk2FwmS3QQ16m51sEawoYnMNLEtyYlc44hGj
         gjuSrzYh3zJ7Ti7YYwSfQW4LoI+KWonKrGKwvImlhTuUMKBaF4MuQkeI5rz/Ywizcb7H
         JZeX1t3RSbwBMUxTRkt/qW41QqOIPtYNRWlxD4V9dZGZpgrd7vDWKsbrBVo+U9psy/ir
         KPMw==
X-Gm-Message-State: AOAM531h21jYgbWDjRtxwpKNMd/jwnhckCTD0ym6/ocVtqXKMNZcg2e6
        v5mERl1P6D+PPhg4fsaJr8u7FCO0k70=
X-Google-Smtp-Source: ABdhPJzNa964HjWEwqhSVeRv2wFeAhWdwIa6wFmV28/brjyNp1Ati3AN9UVdyHIaE2IH/Xbaqj10Ng==
X-Received: by 2002:a50:d642:: with SMTP id c2mr47495898edj.22.1626874665832;
        Wed, 21 Jul 2021 06:37:45 -0700 (PDT)
Received: from agape ([5.171.73.45])
        by smtp.gmail.com with ESMTPSA id hd30sm8300162ejc.29.2021.07.21.06.37.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jul 2021 06:37:45 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     hdegoede@redhat.com, Larry.Finger@lwfinger.net,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 14/16] staging: rtl8723bs: remove unused struct ndis_802_11_ai_reqfi
Date:   Wed, 21 Jul 2021 15:37:21 +0200
Message-Id: <00ed84b66a0a325cb1a09ad6e2d2c0fa19686a88.1626874164.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1626874164.git.fabioaiuto83@gmail.com>
References: <cover.1626874164.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

remove unused struct ndis_802_11_ai_reqfi.

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/include/wlan_bssdef.h | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/staging/rtl8723bs/include/wlan_bssdef.h b/drivers/staging/rtl8723bs/include/wlan_bssdef.h
index 1915b524fd2d..f0977b15c81e 100644
--- a/drivers/staging/rtl8723bs/include/wlan_bssdef.h
+++ b/drivers/staging/rtl8723bs/include/wlan_bssdef.h
@@ -107,12 +107,6 @@ enum {
 #define NDIS_802_11_AI_RESFI_STATUSCODE        2
 #define NDIS_802_11_AI_RESFI_ASSOCIATIONID     4
 
-struct ndis_802_11_ai_reqfi {
-	u16 Capabilities;
-	u16 ListenInterval;
-	NDIS_802_11_MAC_ADDRESS  CurrentAPAddress;
-};
-
 struct ndis_801_11_ai_resfi {
 	u16 Capabilities;
 	u16 StatusCode;
-- 
2.20.1

