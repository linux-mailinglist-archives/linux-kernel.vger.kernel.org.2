Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2EEEA3F0AC9
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Aug 2021 20:08:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229932AbhHRSJM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Aug 2021 14:09:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230326AbhHRSJJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Aug 2021 14:09:09 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93A6BC061764
        for <linux-kernel@vger.kernel.org>; Wed, 18 Aug 2021 11:08:34 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id o15so2156968wmr.3
        for <linux-kernel@vger.kernel.org>; Wed, 18 Aug 2021 11:08:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ofSH0U+01JxHiJg/B1PA1+0gz0bsRWqHkTdAg4y4t1w=;
        b=02c35UnuRzrOC/nJOIr2PRI0vNvQcVTCma/IBHv6yFDo3uC6hUIMFHv3BQP0xuK+BY
         nxwv7qbtJthCwuLh7Ume/o1L6J2TjqZWLjAHQdyTwooQZs6skZPCO2PdSqcJY1l8qbZ5
         9PkOo8TWdvNA1/2ruhsclHQoHjesPLqWD1PiPYc9xvSmmrNpvYRI2JFwwjndgl+Gb6VV
         3eGIuojh2/2fXLUo21sWdilipuk4mnWRmpZO6AsOxmWZmvIdQsSijgRaf8NUMFsER+EH
         ZsQOYhGEMGEX07z2OURU7FLqiFfHMkUQ/IdnvNhFTOfuUINoiwZZ4xBZFxYLv+p7MW4e
         g+mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ofSH0U+01JxHiJg/B1PA1+0gz0bsRWqHkTdAg4y4t1w=;
        b=Dg3GTeHnd5OZ+JoVDp6kBvdkHfUTlwhyXrK52Z38T3TOuYZt9Aonf0fJ4yhVRGL87d
         2PggyIyuvU/OS9MIk4J3Opka2FzTkAifD7LofPCBVy5XNxSWPj8yFwj78GosbVKxgcOG
         OtxujEme9gWLBGSRjRKN7QDqLZ2qFNFWmIm2P41kByxPUhILsTYhRj4khMuSG3u6aiPU
         I7koFu6Y3WMc0nbbmt3d6u+bcpUGQHDp+59i9KQQdywhLAxs1gI1ER47Tz6tWfLN55mO
         ohq9oyvCUGLcefDBo1tthmEQIs3LXbYhcJKIyfV2sKxJWMNtYT1viu3fxpiifSbJAEZ3
         JjrQ==
X-Gm-Message-State: AOAM530bAzzNzVwdUBv7hBsrTwnk6Jt9NoTbTqk3sKgPwpw8WZvgUM6p
        qGZT+wWl4xxMOHD3KultLdV+rg==
X-Google-Smtp-Source: ABdhPJyhx81TRhuUufUr/GNEg/qE9ZgoMe503XX8SKHVl8i95HGSe3HvFgEfa8rcL8SDTSTJ0EMd/g==
X-Received: by 2002:a1c:32c1:: with SMTP id y184mr9411983wmy.70.1629310112995;
        Wed, 18 Aug 2021 11:08:32 -0700 (PDT)
Received: from localhost.localdomain (3.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.6.1.f.d.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:df16::3])
        by smtp.gmail.com with ESMTPSA id z126sm516337wmc.11.2021.08.18.11.08.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Aug 2021 11:08:32 -0700 (PDT)
From:   Phillip Potter <phil@philpotter.co.uk>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, straube.linux@gmail.com,
        martin@kaiser.cx, fmdefrancesco@gmail.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v3] staging: r8188eu: rename variable within rtl8188e_Add_RateATid
Date:   Wed, 18 Aug 2021 19:08:31 +0100
Message-Id: <20210818180831.67581-1-phil@philpotter.co.uk>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename 'shortGIrate' within the rtl8188e_Add_RateATid function to
'short_gi_rate', to comply with kernel camel case style rules.

Signed-off-by: Phillip Potter <phil@philpotter.co.uk>
---

V1: Was part of another patch which was too large.
V2: Attempted to correct operator spacing issues which were fixed by
    another patch from Michael Straube.
V3: Just corrects camel case issue for 'shortGIrate', and renames
    subject to be more specific.

---
 drivers/staging/r8188eu/hal/rtl8188e_cmd.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/rtl8188e_cmd.c b/drivers/staging/r8188eu/hal/rtl8188e_cmd.c
index cc06ee07974f..3e1a45030bc8 100644
--- a/drivers/staging/r8188eu/hal/rtl8188e_cmd.c
+++ b/drivers/staging/r8188eu/hal/rtl8188e_cmd.c
@@ -155,7 +155,7 @@ void rtl8188e_Add_RateATid(struct adapter *pAdapter, u32 bitmap, u8 arg, u8 rssi
 {
 	struct hal_data_8188e *haldata = GET_HAL_DATA(pAdapter);
 
-	u8 macid, raid, shortGIrate = false;
+	u8 macid, raid, short_gi_rate = false;
 
 	macid = arg & 0x1f;
 
@@ -167,13 +167,13 @@ void rtl8188e_Add_RateATid(struct adapter *pAdapter, u32 bitmap, u8 arg, u8 rssi
 
 	bitmap |= ((raid << 28) & 0xf0000000);
 
-	shortGIrate = (arg & BIT(5)) ? true : false;
+	short_gi_rate = (arg & BIT(5)) ? true : false;
 
 	raid = (bitmap >> 28) & 0x0f;
 
 	bitmap &= 0x0fffffff;
 
-	ODM_RA_UpdateRateInfo_8188E(&haldata->odmpriv, macid, raid, bitmap, shortGIrate);
+	ODM_RA_UpdateRateInfo_8188E(&haldata->odmpriv, macid, raid, bitmap, short_gi_rate);
 }
 
 void rtl8188e_set_FwPwrMode_cmd(struct adapter *adapt, u8 Mode)
-- 
2.31.1

