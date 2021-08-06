Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D4E43E31F2
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Aug 2021 00:51:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245635AbhHFWwI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Aug 2021 18:52:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244611AbhHFWwH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Aug 2021 18:52:07 -0400
Received: from mail-oo1-xc30.google.com (mail-oo1-xc30.google.com [IPv6:2607:f8b0:4864:20::c30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 072E4C0613CF;
        Fri,  6 Aug 2021 15:51:50 -0700 (PDT)
Received: by mail-oo1-xc30.google.com with SMTP id s21-20020a4ae5550000b02902667598672bso2620435oot.12;
        Fri, 06 Aug 2021 15:51:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mxn7llJ5mZ0hc2ANTwcNCtoQg7U/UkmI/LGIHOAc8EE=;
        b=U3oMmwKAQziuR7DJ97t0wQ0+qI2imBrqiFWvdXM0cBnNVVlRy/jfZJvUaKQjUnEwUl
         aD2lAarJtc2qGWZHpFDjKwL+tEdPXUOB3PlSqrhTDRq0+tvVfd8IzgSDgWX9IE4+TKRS
         xF/fk5nlTN15q/S8nhLRH/ZS7f7SJqe9BRzXkGXz5I9CAnzWKPJdL75akvyipojo5M2O
         psLE9dq5Di0H9h+Fds5z5ZDl9FuNOcFPSu938dx1zUytGSqCWW4VSNyxolZjzcWusm4u
         bzPJ2UxU/A77wKPQvnYFOTy3DooDqoYU55NHMe5VEXr5fBHzt1Oz+kHcsqVVNjhoUJ54
         1ppg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mxn7llJ5mZ0hc2ANTwcNCtoQg7U/UkmI/LGIHOAc8EE=;
        b=DHA0C/ssJCEt1GVYHwwleGsYzO55+wlNb3OxhMREcgT5b3jyWCr1BWGpsNuIO2q0ut
         9THQHik9F7ybMI5YHpq32uORBjBvyFy7ohwEI5UTK6l8eur0xwJgmMhSHXNbI3FyGbR+
         1KpPVNVyMIIs8AEP/88RmRXeBR6HCPNwdRoESvAl1Ewj315R0IdZ7KAKFPNzX4ATuqkI
         w+p9Ebmn9ENcc5fi5YkhUetm6j5/Yz0EDOJsx7E8omK6lj31vpdg9X+gTVrJolotq2X3
         xKfkYQVrk4cY3whWGN9XJrkvG5MqNACWW9Bns9dimarXVXRb/+9JJbZ6YerrPBne0DvY
         rUTQ==
X-Gm-Message-State: AOAM533YGsM6IKXJ5Nebsi6wqaJGS7JslLotlAe9aiR0NMx+qoQcSZj1
        ueoTndtPxEcS0kLfhRvio76gS8QSPuE=
X-Google-Smtp-Source: ABdhPJzEiY/mdoLGpKdu+X5ieV7KcHPjb6jgu4o6xwcrppAhlvDaotoMJjqXIn3H8Ta4eO6R7PWrKA==
X-Received: by 2002:a4a:6507:: with SMTP id y7mr5598750ooc.38.1628290309336;
        Fri, 06 Aug 2021 15:51:49 -0700 (PDT)
Received: from fstone04p1.aus.stglabs.ibm.com ([129.41.86.7])
        by smtp.gmail.com with ESMTPSA id g1sm1783966otk.21.2021.08.06.15.51.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Aug 2021 15:51:48 -0700 (PDT)
From:   Brandon Wyman <bjwyman@gmail.com>
To:     Joel Stanley <joel@jms.id.au>, openbmc@lists.ozlabs.org,
        Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org, Eddie James <eajames@linux.ibm.com>
Cc:     "B. J. Wyman" <bjwyman@gmail.com>
Subject: [PATCH v2] hwmon: (pmbus/ibm-cffps) Fix write bits for LED control
Date:   Fri,  6 Aug 2021 22:51:31 +0000
Message-Id: <20210806225131.1808759-1-bjwyman@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "B. J. Wyman" <bjwyman@gmail.com>

When doing a PMBus write for the LED control on the IBM Common Form
Factor Power Supplies (ibm-cffps), the DAh command requires that bit 7
be low and bit 6 be high in order to indicate that you are truly
attempting to do a write.

Signed-off-by: Brandon Wyman <bjwyman@gmail.com>
---
V1 -> V2: Use full name instead of initials in Signed-off-by line.
---
 drivers/hwmon/pmbus/ibm-cffps.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/hwmon/pmbus/ibm-cffps.c b/drivers/hwmon/pmbus/ibm-cffps.c
index 5668d8305b78..df712ce4b164 100644
--- a/drivers/hwmon/pmbus/ibm-cffps.c
+++ b/drivers/hwmon/pmbus/ibm-cffps.c
@@ -50,9 +50,9 @@
 #define CFFPS_MFR_VAUX_FAULT			BIT(6)
 #define CFFPS_MFR_CURRENT_SHARE_WARNING		BIT(7)
 
-#define CFFPS_LED_BLINK				BIT(0)
-#define CFFPS_LED_ON				BIT(1)
-#define CFFPS_LED_OFF				BIT(2)
+#define CFFPS_LED_BLINK				(BIT(0) | BIT(6))
+#define CFFPS_LED_ON				(BIT(1) | BIT(6))
+#define CFFPS_LED_OFF				(BIT(2) | BIT(6))
 #define CFFPS_BLINK_RATE_MS			250
 
 enum {
-- 
2.25.1

