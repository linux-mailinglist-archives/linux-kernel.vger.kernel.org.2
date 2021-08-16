Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3391D3EE083
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Aug 2021 01:45:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234408AbhHPXpi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Aug 2021 19:45:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232871AbhHPXph (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Aug 2021 19:45:37 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C0A4C061764
        for <linux-kernel@vger.kernel.org>; Mon, 16 Aug 2021 16:45:05 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id v4so18766763wro.12
        for <linux-kernel@vger.kernel.org>; Mon, 16 Aug 2021 16:45:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DaU8XvMDlRzppvPtqeG4HzfqaAslqIfkw75F7ePCAxM=;
        b=fOAT4e12iv7XULPraUmdJLFCrJ7LxIkc+A9vCqfUGQHKenq/pZw1m6SvnMlievU7HP
         FUuHUBc+ydMTkRegEr9at/wZX42tCyctCEeE6E19nERUIeFau3rWp5p+FcQCnZ9FrR7u
         HecVqwtFegBx6gDoOmQFxcjomSwAyh7d2oY5a/OwVL0RuB+vJyRHj6SZUmfbPt43Cz05
         g9dWlV7/1hxzlQYcc6KbNqrCNuYOgEVAe9od6XoJbIvaZknqlLvx9pF6fsCsUR1JH3r/
         0EWHHUYf+KOagZj8SXvcNzPJW8ixaOtsPzC+XhEjkKEGSVfASqdCO9fmz81ojqTbdndG
         UkEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DaU8XvMDlRzppvPtqeG4HzfqaAslqIfkw75F7ePCAxM=;
        b=NufTGHWzThi1IuccL6QyPOdi2vICCO/dfFqFRFDAkBDsMrWRCHLmwdB98wGtIpmyQw
         vfYDAzYhDVLO91u5w7Gg3EVTy8+SsC6Np0l27gseX8mVLyDTuVQxeV6ywvNp/b5mjsPO
         MFcgIRRqinSW7O7snJCBAmokvjN8FynsnIMjgcyyq7Duik0JD/FvRMfpsMsYzgkMUj+L
         79q7a7qDQdn9tUwoSP65229snYx+SLCWAgri4Z2g50BD1bZjT6YlvOHVxnUxdhyztvl4
         /+lR7CDdlwR/uND182W3NZrXs0rwEawiQH3/njSLybm2K0aPVjYUwXWfbfe0Ies9ZXHH
         TY4A==
X-Gm-Message-State: AOAM531mXyOKN8isHJSHmOLu5xaSiqpYkwR1h/TH/vbb5U86I2kw//Hf
        Qw/jq0bwuHxL0Sv7EU/7AIjoug==
X-Google-Smtp-Source: ABdhPJzYbuWmIuYNmerimksAlMiWnMkhNA51joyTg1+ODwl8ufEIyUYhQUa25ijMVMzTPYS3gDDDMA==
X-Received: by 2002:a5d:6b86:: with SMTP id n6mr528141wrx.65.1629157503656;
        Mon, 16 Aug 2021 16:45:03 -0700 (PDT)
Received: from localhost.localdomain (3.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.6.1.f.d.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:df16::3])
        by smtp.gmail.com with ESMTPSA id w11sm291521wrr.48.2021.08.16.16.45.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Aug 2021 16:45:03 -0700 (PDT)
From:   Phillip Potter <phil@philpotter.co.uk>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, straube.linux@gmail.com,
        martin@kaiser.cx, fmdefrancesco@gmail.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/3] staging: r8188eu: remove set but unused variable from rtl8188e_Add_RateATid
Date:   Tue, 17 Aug 2021 00:44:57 +0100
Message-Id: <20210816234459.132239-2-phil@philpotter.co.uk>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210816234459.132239-1-phil@philpotter.co.uk>
References: <20210816234459.132239-1-phil@philpotter.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove set but unused variable init_rate from the rtl8188e_Add_RateATid
function in hal/rtl8188eu_cmd.c, as this fixes a kernel test robot
warning. Removing the call to get_highest_rate_idx has no side effects
here so is safe.

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Phillip Potter <phil@philpotter.co.uk>
---
 drivers/staging/r8188eu/hal/rtl8188e_cmd.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/rtl8188e_cmd.c b/drivers/staging/r8188eu/hal/rtl8188e_cmd.c
index 6cbda9ab6e3f..4302054c6c83 100644
--- a/drivers/staging/r8188eu/hal/rtl8188e_cmd.c
+++ b/drivers/staging/r8188eu/hal/rtl8188e_cmd.c
@@ -155,7 +155,7 @@ void rtl8188e_Add_RateATid(struct adapter *pAdapter, u32 bitmap, u8 arg, u8 rssi
 {
 	struct hal_data_8188e *haldata = GET_HAL_DATA(pAdapter);
 
-	u8 macid, init_rate, raid, shortGIrate = false;
+	u8 macid, raid, shortGIrate = false;
 
 	macid = arg&0x1f;
 
@@ -167,13 +167,8 @@ void rtl8188e_Add_RateATid(struct adapter *pAdapter, u32 bitmap, u8 arg, u8 rssi
 
 	bitmap |= ((raid<<28)&0xf0000000);
 
-	init_rate = get_highest_rate_idx(bitmap&0x0fffffff)&0x3f;
-
 	shortGIrate = (arg&BIT(5)) ? true : false;
 
-	if (shortGIrate)
-		init_rate |= BIT(6);
-
 	raid = (bitmap>>28) & 0x0f;
 
 	bitmap &= 0x0fffffff;
-- 
2.31.1

