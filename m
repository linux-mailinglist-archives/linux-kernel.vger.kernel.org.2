Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9CB3320D86
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Feb 2021 21:15:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230355AbhBUUOl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Feb 2021 15:14:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230253AbhBUUOb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Feb 2021 15:14:31 -0500
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E93F5C061574
        for <linux-kernel@vger.kernel.org>; Sun, 21 Feb 2021 12:13:50 -0800 (PST)
Received: by mail-pf1-x42b.google.com with SMTP id x129so547648pfx.7
        for <linux-kernel@vger.kernel.org>; Sun, 21 Feb 2021 12:13:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=/MZ9AB1W/dbMxNAhi0KVsZwY+q1BgLJr0bsgnEfCTfU=;
        b=DVDQIQXK+lI9FpI6XKZUP6PmT5GpG9Z156YuDP8RxuG1v1wWrZVtpbILjt3BqmHsZ3
         FVqyLQHPHoHQR2YhRGwp/AVMEbhK9fh0UWR7LptW4rCAsyuajOUuA1lCzLidHd7wuB5I
         B8V2INwsSsjBgq/EAb9+ckUhcvYepGTg9kCikInWdVlWwBR4qOzMbMQLPqZdm6/iRpuU
         kg3/y0JYEtK8FMWQIC7rRjPkWLGdgF5/LPjfMAtpbD80CzC7dEsyYG6SUuaBwQyXZj5A
         MAhPCsHxDyFXyj5WbhpnJ4fJRVOtKjhF42BrsgsqrW1GK6oZuctlKQXEyO8xYnHt0Xgn
         LFqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=/MZ9AB1W/dbMxNAhi0KVsZwY+q1BgLJr0bsgnEfCTfU=;
        b=TyLv45yMS6NtngTvh2elflLy2cUUzIVTaySmImTnfvk36qKq8z/v8Sc49c5Us7eB4S
         X/bZOiwqvKIP29lF6wX3oNlE/5ULAQm6GlJcqv4nrRJhU49iBsnPdfIzy2WP4IPWW3K9
         TFVCqqgN/ObG6LSejzypzqLe3fErkLZ0SfzcfthIWFEi2bc9ePe9dRET9kTrGa2Hnv8y
         2In6OmDx0LGIZ6rg4vzAiQthkSDj1DavCDX1nXQfWSou5uC15MxlfR0y51eG4tBLF9Xi
         uV+7Zci+dEmeyzkW9+P7B0iCn/KYzsB2OpX++fME4sFRPgXmyvTM9eJirh3f5+rZBFtK
         n0KA==
X-Gm-Message-State: AOAM532vviSUYsB3zq9ReFTgPp2xds7hWELOGN0HorVdX6jQmqy3lA+A
        cwlygsN/3qRJId9VfOC1mBY=
X-Google-Smtp-Source: ABdhPJwtgU7vD26cxEIVe/yhegDad+EYPOJnY1UOXSx4VulhokUGnczz28OKEbIkI6UQrEcSL3ljfw==
X-Received: by 2002:aa7:80c6:0:b029:1b6:92ae:a199 with SMTP id a6-20020aa780c60000b02901b692aea199mr11068478pfn.71.1613938430430;
        Sun, 21 Feb 2021 12:13:50 -0800 (PST)
Received: from rayare.domain.name ([106.51.141.71])
        by smtp.googlemail.com with ESMTPSA id d4sm12721532pfq.101.2021.02.21.12.13.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Feb 2021 12:13:49 -0800 (PST)
From:   chakravarthikulkarni <chakravarthikulkarni2021@gmail.com>
Cc:     chakravarthikulkarni2021@gmail.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: ks7010: Replace macros with do while loop.
Date:   Mon, 22 Feb 2021 01:43:24 +0530
Message-Id: <20210221201327.12714-1-chakravarthikulkarni2021@gmail.com>
X-Mailer: git-send-email 2.17.1
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit fix errors found in checkpath.pl.
Error message is:
<Macros with complex values should be enclosed in parentheses.>
It is a good idea to keep complex macros in do while loop.
Otherwise result may have side effect.

Signed-off-by: chakravarthikulkarni <chakravarthikulkarni2021@gmail.com>
---
 drivers/staging/ks7010/ks_hostif.h | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/staging/ks7010/ks_hostif.h b/drivers/staging/ks7010/ks_hostif.h
index 39138191a556..955499054d10 100644
--- a/drivers/staging/ks7010/ks_hostif.h
+++ b/drivers/staging/ks7010/ks_hostif.h
@@ -498,20 +498,20 @@ struct hostif_mic_failure_request {
 #define TX_RATE_FIXED		5
 
 /* 11b rate */
-#define TX_RATE_1M	(u8)(10 / 5)	/* 11b 11g basic rate */
-#define TX_RATE_2M	(u8)(20 / 5)	/* 11b 11g basic rate */
-#define TX_RATE_5M	(u8)(55 / 5)	/* 11g basic rate */
-#define TX_RATE_11M	(u8)(110 / 5)	/* 11g basic rate */
+#define TX_RATE_1M	do { (u8) (10 / 5) } while (0)	/* 11b 11g basic rate */
+#define TX_RATE_2M	do { (u8) (20 / 5) } while (0)	/* 11b 11g basic rate */
+#define TX_RATE_5M	do { (u8) (55 / 5) } while (0)	/* 11g basic rate */
+#define TX_RATE_11M	do { (u8) (110 / 5) } while (0)	/* 11g basic rate */
 
 /* 11g rate */
-#define TX_RATE_6M	(u8)(60 / 5)	/* 11g basic rate */
-#define TX_RATE_12M	(u8)(120 / 5)	/* 11g basic rate */
-#define TX_RATE_24M	(u8)(240 / 5)	/* 11g basic rate */
-#define TX_RATE_9M	(u8)(90 / 5)
-#define TX_RATE_18M	(u8)(180 / 5)
-#define TX_RATE_36M	(u8)(360 / 5)
-#define TX_RATE_48M	(u8)(480 / 5)
-#define TX_RATE_54M	(u8)(540 / 5)
+#define TX_RATE_6M	do { (u8) (60 / 5) } while (0)	/* 11g basic rate */
+#define TX_RATE_12M	do { (u8) (120 / 5) } while (0)	/* 11g basic rate */
+#define TX_RATE_24M	do { (u8) (240 / 5) } while (0)	/* 11g basic rate */
+#define TX_RATE_9M	do { (u8) (90 / 5) } while (0)
+#define TX_RATE_18M	do { (u8) (180 / 5) } while (0)
+#define TX_RATE_36M	do { (u8) (360 / 5) } while (0)
+#define TX_RATE_48M	do { (u8) (480 / 5) } while (0)
+#define TX_RATE_54M	do { (u8) (540 / 5) } while (0)
 
 static inline bool is_11b_rate(u8 rate)
 {
-- 
2.17.1

