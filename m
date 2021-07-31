Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0C253DC1EA
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Jul 2021 02:24:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234968AbhGaAYL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jul 2021 20:24:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234624AbhGaAYG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jul 2021 20:24:06 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BD0EC06175F
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jul 2021 17:24:00 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id b7so13343761wri.8
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jul 2021 17:24:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2g9UxZdEMaE3vJpbZr7oUx7+ltJAKf8EpUn9f9NHS/M=;
        b=tDUzHE9F5VKYFHLG+JqcR6W1Tk3jroM48O/zhCTNz0hL0PtS3/vd4oZ0e1iotWbk+o
         +4Kucc4SdoJBtnDODJyIBJcsCMM4jbl5rMiW+tOYNR50LJceSMe/0/cawq6tqEIMtBBA
         X95D/7sH3ow79EYXbr6qtZTeAU6e+D0ciM6bY+iWYH6wEVE9p/RTQhvjmqIh8V+dIffs
         gSZ9aIlnsvnLJR0xJwflCDj/al4Ql7T5GGgpLyVm0x9AtSEnkyvESU+EPcOmfpCygUgj
         Gkx1fuwiyM/oizJENQ5VzVlgmfsrQWp0Cs8uZfhKm8I3sMKUWnGi8b+FB3BsbFqpDnWj
         kWyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2g9UxZdEMaE3vJpbZr7oUx7+ltJAKf8EpUn9f9NHS/M=;
        b=sxA2RIhjG3nKxLNskp8Lmn2kJVY+NaND0nQBIFCutCgo2nIYRx2aGE0jR5zUonggxp
         EpbuSl7lqd3HV8Ae1CFIJKE/2R2+Zzx6ctIFIcQtkcL872nPGVAlDNETLgWCo3J/FV0R
         NVx3V5petfDyF5LAd1JW8L14BiGmroqFFSElOv9LEXz5NS2nFeLqhVUcIM3BjVELQTcX
         yZWj2/exxBfIw2n+Uq0NQJ+iyqji+/1OXCH24TdSvgT7XBabYsEED/kEmDUSmmzgy4pa
         maKTLlh8TYDbYsgu6bl+DjQnYfbqUmTYOJc7dkvQ2JJKkxF/u3euAZFbw5AgWN6XfKBb
         bBBw==
X-Gm-Message-State: AOAM531xUEFlRStFV4JQVW4jVWnnVPe75t9qof+8tcoaxnvwwb67H1E7
        N4KSvuJIptnB/EmlZcpkfd7ogA==
X-Google-Smtp-Source: ABdhPJxJrdq3cu9ogGW8zQYmGUxG+Z4jjERVvTy24sNbxGKObEVYOe62SR5fNvOVe8unRX8i8l+hbQ==
X-Received: by 2002:adf:e10c:: with SMTP id t12mr5695730wrz.36.1627691039097;
        Fri, 30 Jul 2021 17:23:59 -0700 (PDT)
Received: from localhost.localdomain (3.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.6.1.f.d.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:df16::3])
        by smtp.gmail.com with ESMTPSA id x9sm3236011wmj.41.2021.07.30.17.23.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jul 2021 17:23:58 -0700 (PDT)
From:   Phillip Potter <phil@philpotter.co.uk>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH 05/14] staging: r8188eu: remove ASSERT ifndef and macro definition
Date:   Sat, 31 Jul 2021 01:23:44 +0100
Message-Id: <20210731002353.68479-6-phil@philpotter.co.uk>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210731002353.68479-1-phil@philpotter.co.uk>
References: <20210731002353.68479-1-phil@philpotter.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove ASSERT ifndef and macro definition from include/odm_debug.h, as
these are unused and therefore superfluous.

Signed-off-by: Phillip Potter <phil@philpotter.co.uk>
---
 drivers/staging/r8188eu/include/odm_debug.h | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/staging/r8188eu/include/odm_debug.h b/drivers/staging/r8188eu/include/odm_debug.h
index ef0d6b84b2d5..c70fe73e3339 100644
--- a/drivers/staging/r8188eu/include/odm_debug.h
+++ b/drivers/staging/r8188eu/include/odm_debug.h
@@ -68,10 +68,6 @@
 #define RT_PRINTK(fmt, args...)				\
 	DbgPrint( "%s(): " fmt, __func__, ## args);
 
-#ifndef ASSERT
-	#define ASSERT(expr)
-#endif
-
 #define ODM_RT_TRACE(pDM_Odm, comp, level, fmt)				\
 	if (((comp) & pDM_Odm->DebugComponents) &&			\
 	    (level <= pDM_Odm->DebugLevel)) {				\
-- 
2.31.1

