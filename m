Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96AE44595CF
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Nov 2021 20:54:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240300AbhKVT5F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Nov 2021 14:57:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237596AbhKVT5E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Nov 2021 14:57:04 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70EF3C061574
        for <linux-kernel@vger.kernel.org>; Mon, 22 Nov 2021 11:53:55 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id y7so15100617plp.0
        for <linux-kernel@vger.kernel.org>; Mon, 22 Nov 2021 11:53:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=AMkuTcoJTkYSjfeIFypgDSDy28ltI3FST8ly2AlCH+k=;
        b=fUgUK1UtUnhY2xM13JM5thRmVs8VPz82G/yccZNMuKOYiJRMP4SNjGMHXaA06rySdQ
         1XE5W55+qoFXLPQv8MCyyx/CV/G0fkezN+k8QphQDwYSQLXRjoLuYtwcZxENdCKw+KKb
         lngRxJBTZ4ZSye0oek5DWObaYQCvqmWwqDEQel+PnKQVciZ1By15Tshry791B3+1tVVx
         Uy6Wdz1wD+wlG1HLQ1bbdV+XTXRPtf+PV8Sdu8vpQVhQDt0UNWTsZtLZ/WSyasetyQWb
         XXGfqRmY0aEiRUw0coFJHhJlKkf8JNlnMmKOwO3eCE5mZyY/kDoaFoTJh5k6dyhEYwTR
         10bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=AMkuTcoJTkYSjfeIFypgDSDy28ltI3FST8ly2AlCH+k=;
        b=1fLJZ3jYhOYR7EdWXJAErkximF3+BNO8hxhjAJSEjODhPOeMRVKx8lDp2ilhmsKVJE
         bLELNoOTST6J/4ZYD8oR6TIDlv4unVMt6OuEBK3Nk44z1YW0ci9XiXlWu/OhbzJ2PtMp
         DrBNXVRmrcqWOW9AWAy5lXOtifcheFEm+oQfkyXq4XmnLfMIdwId61moRLufaIyjK/og
         GiGfqF5gO+DYmcfLRQHou8NBEHBSmvXcCtWC8SvqfxjTJGeUmlBm4IkD9DL5lWyO42a7
         R6HlZA2Gyxn1reAe8jZwaQaT7GTfDmVDpRZEcyGH5iRfVZdVjMww0xw1ivEMlAKCH5ai
         9jaA==
X-Gm-Message-State: AOAM533U6ybeYjda9VCBurMKmukbvlw62JIaAqPfK+M4vOpmMeUQB36m
        AqHh8zbdYTfNYgdmd3wv5reZ/EpXn/xtVw==
X-Google-Smtp-Source: ABdhPJwM+lCFwmfFMiO8v1VS33gT8JDPpKnUGfSaEXnhaPSeFMpbxHLkG1vZKsQbuPwYXsOsGpkSxA==
X-Received: by 2002:a17:903:22c4:b0:141:deda:a744 with SMTP id y4-20020a17090322c400b00141dedaa744mr112777598plg.25.1637610834850;
        Mon, 22 Nov 2021 11:53:54 -0800 (PST)
Received: from makvihas ([103.238.104.128])
        by smtp.gmail.com with ESMTPSA id t4sm10322369pfq.163.2021.11.22.11.53.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Nov 2021 11:53:54 -0800 (PST)
Date:   Tue, 23 Nov 2021 01:23:50 +0530
From:   Vihas Mak <makvihas@gmail.com>
To:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk
Cc:     gregkh@linuxfoundation.org, straube.linux@gmail.com,
        martin@kaiser.cx, paskripkin@gmail.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: r8188eu: remove unnecessary NULL check
Message-ID: <20211122195350.GA166134@makvihas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

remove unnecessary NULL check surrounding rtw_free_netdev(), as the check
is already performed inside rtw_free_netdev() in
drivers/staging/r8188eu/os_dep/osdep_service.c.

Signed-off-by: Vihas Mak <makvihas@gmail.com>
---
 drivers/staging/r8188eu/os_dep/usb_intf.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/staging/r8188eu/os_dep/usb_intf.c b/drivers/staging/r8188eu/os_dep/usb_intf.c
index 5a35d9fe3fc9..392bd7868519 100644
--- a/drivers/staging/r8188eu/os_dep/usb_intf.c
+++ b/drivers/staging/r8188eu/os_dep/usb_intf.c
@@ -466,8 +466,7 @@ static void rtw_usb_if1_deinit(struct adapter *if1)
 		if1->hw_init_completed);
 	rtw_handle_dualmac(if1, 0);
 	rtw_free_drv_sw(if1);
-	if (pnetdev)
-		rtw_free_netdev(pnetdev);
+	rtw_free_netdev(pnetdev);
 }
 
 static int rtw_drv_init(struct usb_interface *pusb_intf, const struct usb_device_id *pdid)
-- 
2.25.1

