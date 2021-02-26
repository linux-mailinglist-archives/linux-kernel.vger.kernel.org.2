Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76BB6326224
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Feb 2021 12:50:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230105AbhBZLtd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Feb 2021 06:49:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229835AbhBZLtP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Feb 2021 06:49:15 -0500
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9BC2C061756
        for <linux-kernel@vger.kernel.org>; Fri, 26 Feb 2021 03:48:34 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id mm21so14045299ejb.12
        for <linux-kernel@vger.kernel.org>; Fri, 26 Feb 2021 03:48:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DBG5WvPZaDPwblLH9T9vz8x1fojhLKSAMhdgTzRHk+I=;
        b=Sf73sbSRBO9rG9o0CTmQQrowLuD1E+c4VCkKYIPVcStPfLVZhmNCnt3uA7kLhrj9LC
         qrrdvZ7wy8mRCADG3HhUvoHkSwHImrD6Wd/xqj/Khpu5Ecv+xN5ekKU8joFMW5pdwujE
         04yxGmP6+lrJpliRd3LgTSE6i2aKUQk5pZ23FdgG//tKmY758gDsSzlfC4oAYrMMJvII
         7+r1yuOMKtXt5r/os3gGAynV2s3gh8HsanuK6YJYEodTUTOjUcrBRdIVvWboPMX7x9J8
         AqwaIUMuzfXblBO3GxQV4j1jb2YWo9AJAdr9sEnlRG/LmXx0skqJTNJHMCzG9w3Y5zNQ
         AepA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DBG5WvPZaDPwblLH9T9vz8x1fojhLKSAMhdgTzRHk+I=;
        b=MFK/b2rnwAMbyQg7zoMan5TS9TGiJNsMsNtiiCah4ZxxJQA2dNNQHadbs12pLVLgPB
         winaPnIscoSPFTaVRk2FicvQXJdsUYil8sRJFNZF2LRsOmAQ9ogqOVTP/8KY1a/jpsSo
         jG8uFTgALWV1xlcJy0DWQNo4KLh8EuKoDLY72rpG1a6gG6Z5nC9OIf9MMv5agOz5rAuF
         laLec80iDyJNQu0sTmFG52TZjTZ2MbdLuny5mO8oF/LKQlLTlyqZ7eu0xt2zuGnS/dQJ
         EPvtVlQITt7hXIIIOye9jDMkvz7SXT4YO+sGmBvhSVZtYGlBZ3TsSyUMgo7462jp+9tM
         Yn9g==
X-Gm-Message-State: AOAM533BuyZkJp7VaIZajVvSUfxgTZr/GnUaCgyhJxRTdPT5uhdejcYi
        ePa3bMG7wY4o/D/iKS9CboOw1ilUrCXAKOop
X-Google-Smtp-Source: ABdhPJzI0jJVXXO8VNqIFxaN2M/S15jyvoKq/t+1R3Kr5AWiX2eKWMjdnWp8S0VtgOphX0mDp38BeA==
X-Received: by 2002:a17:906:4088:: with SMTP id u8mr2944879ejj.208.1614340113486;
        Fri, 26 Feb 2021 03:48:33 -0800 (PST)
Received: from ubuntudesktop.lan (205.158.32.217.dyn.plus.net. [217.32.158.205])
        by smtp.gmail.com with ESMTPSA id l6sm2772013edw.90.2021.02.26.03.48.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Feb 2021 03:48:33 -0800 (PST)
From:   Lee Gibson <leegib@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Lee Gibson <leegib@gmail.com>
Subject: [PATCH] staging: rtl8192e: Fix possible buffer overflow in _rtl92e_wx_set_scan
Date:   Fri, 26 Feb 2021 11:48:29 +0000
Message-Id: <20210226114829.316980-1-leegib@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Function _rtl92e_wx_set_scan calls memcpy without checking the length.
A user could control that length and trigger a buffer overflow.
Fix by checking the length is within the maximum allowed size.

Signed-off-by: Lee Gibson <leegib@gmail.com>
---
 drivers/staging/rtl8192e/rtl8192e/rtl_wx.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_wx.c b/drivers/staging/rtl8192e/rtl8192e/rtl_wx.c
index 16bcee13f64b..2acc4f314732 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_wx.c
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_wx.c
@@ -406,6 +406,9 @@ static int _rtl92e_wx_set_scan(struct net_device *dev,
 		struct iw_scan_req *req = (struct iw_scan_req *)b;
 
 		if (req->essid_len) {
+			if (req->essid_len > IW_ESSID_MAX_SIZE)
+				req->essid_len = IW_ESSID_MAX_SIZE;
+
 			ieee->current_network.ssid_len = req->essid_len;
 			memcpy(ieee->current_network.ssid, req->essid,
 			       req->essid_len);
-- 
2.25.1

