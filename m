Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A7A036F82B
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Apr 2021 11:53:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231671AbhD3JyQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Apr 2021 05:54:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231559AbhD3JyP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Apr 2021 05:54:15 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5BB7C06174A
        for <linux-kernel@vger.kernel.org>; Fri, 30 Apr 2021 02:53:27 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id d14so18099470edc.12
        for <linux-kernel@vger.kernel.org>; Fri, 30 Apr 2021 02:53:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MW4Zu+04I2pf8trbMMxIEZXFmmjHoSTSqQhr0jRymOE=;
        b=Jg+KSRSQPQQcV3bK/ichZmxSYH9xuDnVibtg+xnvKg4exE8C7ddnz172N5eHn3PwJD
         QYGP0E9+OBRF7a22SoawsnEME34Qq2rlXeopqi36sIwqmciTNDp85DbDagJA9asWXJYS
         agBSphrNL6SkQGBstFeUk05XFY6ZeT0j6OzSNq0Qa7FuXvApcPETkkyx0/VTmtj3hP0f
         824rsvyvPH0B/Kox5QvozpSa80Fi4TF0mxgVkZiXWojNQ5zRr8smzm7hGtoaeYj9QbmR
         uHrGLCSF9gi+9EvHNQbstPmzT/DrBGAK1cg13G0wMwb/i4NivmfdtwFXgfcoxVUQkHig
         gVew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MW4Zu+04I2pf8trbMMxIEZXFmmjHoSTSqQhr0jRymOE=;
        b=El08pgYbubbIeOtmSWov5sKYvX7Uql7p0ir+aSKd8E5j0Je5va8WYHdaooFaIJtpDx
         PtNuZubcwrzEgsfHA7toncmk00t0Lz3VQHUh3kEoeQtHu5n05SEW8Q5aWMjwNJp4EF8b
         Cz5CTeZzCkj1xEJiln4gjYa69mx7DrfVwDPrTDISRKG+2Ae4fgsjKrQIgg0JNGV0sBbI
         zIr8XfQvAlINCh58gSjnSkzlIuiVzr8iqcIdLU8xNL+Y4o3p4pZ4WEXTbOtngGM4wLFY
         8nR8zwJC+QnJJ12JvCgrD5tY/kQE23HTzAJEAsLr6WJnNbbuXz9IJfYS+FDuSSAekzvu
         55mQ==
X-Gm-Message-State: AOAM533PguHxp+zlZIsFp/yvnJidh1h4cXZH9GhgS1ZPtlB69Fu9oQqf
        GC5dGVfKijC4VQvxWkrkxe0=
X-Google-Smtp-Source: ABdhPJwSee4pg1QdgjgfGyVgwI4EPInNJPIifgJj/OePWYQkjF1jH3Jw31miPbwh2NBk0PanPgNwdg==
X-Received: by 2002:aa7:c412:: with SMTP id j18mr4820800edq.163.1619776406529;
        Fri, 30 Apr 2021 02:53:26 -0700 (PDT)
Received: from linux.local (host-79-52-107-152.retail.telecomitalia.it. [79.52.107.152])
        by smtp.gmail.com with ESMTPSA id f30sm1626861ejl.62.2021.04.30.02.53.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Apr 2021 02:53:26 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     outreachy-kernel@googlegroups.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Dan Carpenter <dan.carpenter@oracle.com>
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Subject: [Outreachy kernel] [PATCH v2 1/2] staging: rtl8723bs: hal: Remove set but unused variables
Date:   Fri, 30 Apr 2021 11:53:18 +0200
Message-Id: <20210430095319.23226-2-fmdefrancesco@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210430095319.23226-1-fmdefrancesco@gmail.com>
References: <20210430095319.23226-1-fmdefrancesco@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Removed four set but unused variables. Issue detected by gcc.

Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
---

Changes from v1: No changes.

 drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c b/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c
index 082448557b53..96cb4426a0f4 100644
--- a/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c
+++ b/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c
@@ -3900,14 +3900,11 @@ u8 GetHalDefVar8723B(struct adapter *padapter, enum hal_def_variable variable, v
 			u32 cmd;
 			u32 ra_info1, ra_info2;
 			u32 rate_mask1, rate_mask2;
-			u8 curr_tx_rate, curr_tx_sgi, hight_rate, lowest_rate;
 
 			cmd = 0x40000100 | mac_id;
 			rtw_write32(padapter, REG_HMEBOX_DBG_2_8723B, cmd);
 			msleep(10);
 			ra_info1 = rtw_read32(padapter, 0x2F0);
-			curr_tx_rate = ra_info1&0x7F;
-			curr_tx_sgi = (ra_info1>>7)&0x01;
 
 			cmd = 0x40000400 | mac_id;
 			rtw_write32(padapter, REG_HMEBOX_DBG_2_8723B, cmd);
@@ -3916,8 +3913,6 @@ u8 GetHalDefVar8723B(struct adapter *padapter, enum hal_def_variable variable, v
 			ra_info2 = rtw_read32(padapter, 0x2F4);
 			rate_mask1 = rtw_read32(padapter, 0x2F8);
 			rate_mask2 = rtw_read32(padapter, 0x2FC);
-			hight_rate = ra_info2&0xFF;
-			lowest_rate = (ra_info2>>8)  & 0xFF;
 
 		}
 		break;
-- 
2.31.1

