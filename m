Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96ECE4150FD
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Sep 2021 22:06:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237447AbhIVUHV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Sep 2021 16:07:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237362AbhIVUHH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Sep 2021 16:07:07 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A08EC061760
        for <linux-kernel@vger.kernel.org>; Wed, 22 Sep 2021 13:05:36 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id q11so10343993wrr.9
        for <linux-kernel@vger.kernel.org>; Wed, 22 Sep 2021 13:05:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+tX+tSWqrqfKGbOTZFpi65+Rb/F0bC4ddpqsmevyBtA=;
        b=JvJYtmVPlo3ZyRjebVwZQo/atvNnPUmwOUs7hPE3gSrHUvrQUyw2grwl0A63PgqlvS
         Jk1a1IumVfg3alXBln1WJrq5rZ/FTseSD7UROJDeWb662fWWwqF2J7dW2ZIXxpgpcqjd
         zdbgIOIwB/Kn1wBqBABJmUQTFwpX166/CjMb3JLqv4+34fm0ShLlX3lMYcojgCbZp7zC
         sYwTMPPcqr2oTbeBYZijo0r3vurGYc9YgNtPQSmksWqxxceBI4+ODHnYRLa1fesME5Un
         ZIHMkeflFqdlQGkuFR3wg0RYGFZPJxEDdxGYoBNMBw5LEHp1/+NcBgTKo0BCYLKTMaxF
         BB8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+tX+tSWqrqfKGbOTZFpi65+Rb/F0bC4ddpqsmevyBtA=;
        b=BUxsngcAuD/YJ9wrG+bnoVOta0SFFj27HfXp2PpHogUrWUpS47/ddaNLvBI4nISb10
         X7gWLVKJX6ZBq5f8DQv71SD17fnreoNRsM3C/RQ9qnJkktMA7OcRpk5ah7TlousGhIaW
         vXE9gPB0f6VA4cWovJb/hbF/9Pu6UTGa2rqBogqfBmGf9QCI+8I9x36LAOHFcKCA66PX
         XbwiALD0eiMVozeqtsiRWJrtj8hTT3/O3A1y6qZ3cmrSdGXaZSqhWqsk46zfwcDF/tTY
         YDyu4wro8USyEjrS9HZdpO3QrvhBJH2jtaLXMq9XSf63WkZWOeQb2EFiCbsbYTbLfZVB
         xLHA==
X-Gm-Message-State: AOAM532PuujCuhbDqUW2+0AFgNIje7WJ3boDIv1l5oEr4fp+BeFIj8JI
        syKYkS0CyesDNdRZWNtKrQk=
X-Google-Smtp-Source: ABdhPJwP2tEIGefXVF7kAwJkhJECjpul16GHEZsooTWUZILyBaib3+HGtaOmunsjYHkpxP06oiBG2w==
X-Received: by 2002:a05:600c:19ca:: with SMTP id u10mr12573608wmq.167.1632341135138;
        Wed, 22 Sep 2021 13:05:35 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::cde])
        by smtp.gmail.com with ESMTPSA id e2sm3219761wra.40.2021.09.22.13.05.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Sep 2021 13:05:34 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 11/47] staging: r8188eu: remove rtw_get_timestampe_from_ie()
Date:   Wed, 22 Sep 2021 22:03:44 +0200
Message-Id: <20210922200420.9693-12-straube.linux@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210922200420.9693-1-straube.linux@gmail.com>
References: <20210922200420.9693-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Function rtw_get_timestampe_from_ie() is not used, remove it.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_mlme.c    | 5 -----
 drivers/staging/r8188eu/include/rtw_mlme.h | 1 -
 2 files changed, 6 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_mlme.c b/drivers/staging/r8188eu/core/rtw_mlme.c
index fb5952d5f1e4..456933475c16 100644
--- a/drivers/staging/r8188eu/core/rtw_mlme.c
+++ b/drivers/staging/r8188eu/core/rtw_mlme.c
@@ -290,11 +290,6 @@ u16 rtw_get_capability(struct wlan_bssid_ex *bss)
 	return le16_to_cpu(val);
 }
 
-u8 *rtw_get_timestampe_from_ie(u8 *ie)
-{
-	return ie + 0;
-}
-
 u8 *rtw_get_beacon_interval_from_ie(u8 *ie)
 {
 	return ie + 8;
diff --git a/drivers/staging/r8188eu/include/rtw_mlme.h b/drivers/staging/r8188eu/include/rtw_mlme.h
index e0fec3ac55de..9dc9f9b94850 100644
--- a/drivers/staging/r8188eu/include/rtw_mlme.h
+++ b/drivers/staging/r8188eu/include/rtw_mlme.h
@@ -598,7 +598,6 @@ void _rtw_free_network_queue(struct adapter *padapter, u8 isfreeall);
 int rtw_if_up(struct adapter *padapter);
 
 u8 *rtw_get_capability_from_ie(u8 *ie);
-u8 *rtw_get_timestampe_from_ie(u8 *ie);
 u8 *rtw_get_beacon_interval_from_ie(u8 *ie);
 
 void rtw_joinbss_reset(struct adapter *padapter);
-- 
2.33.0

