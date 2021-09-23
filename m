Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E8AA415B5B
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Sep 2021 11:48:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240282AbhIWJt6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Sep 2021 05:49:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240254AbhIWJtv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Sep 2021 05:49:51 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 619CAC061756;
        Thu, 23 Sep 2021 02:48:20 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id i4so24261628lfv.4;
        Thu, 23 Sep 2021 02:48:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Rj6imcicyAJwArWfGem6UG9usNqgXSTnj7QQxGZjpco=;
        b=WMmAyMTMo4A387U6eMNAnZTM1ejObRpnt/b3Eyy3Yg3O+1d25aJ6VEdX+r559luurj
         RgsagUlSglivpfxlfllBvNToOeKG3Ne+faD4rNloygxkw0sNGFhwsxB0WThlpEeGb9rS
         t306CzjQEw0LpzFc9+/m7hOCG6gGnR+gv0fIM6kAby8F2CzovO8GGVoEveBlnlQZVPkJ
         iOlJ99b8Gyah2IfoX+L2gsxaRpYEsTjYFavAWFGwhyXKSbkp8neVU47sRGhfei3ZqQB9
         aCZMCgy5zLymnELxI5Ilpu8bddOb/bAy1ktwDqYqgo5IpODDHTjdzn0TQ/vgLeUpkMAI
         ZW7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Rj6imcicyAJwArWfGem6UG9usNqgXSTnj7QQxGZjpco=;
        b=2MaWJkTmkb+BK5oInDjJRuI5NiQprLLz3N9pAEKM07+Ydk0+3r4a05Mr4OmhIwT5bz
         NDJvf0vr05o1ayRkOp+ugcEIFiIK8zom0CP7jCeDlgp2ZzX81RkMBX9SKpI7Ephq0wce
         Mx0kYjshel2eXw+7q3btq8E13HtALlqnS6HLVKnyiUEst2fqsFMSQBZtpvzLyh5iG5d7
         P7OYJrHIs5BGrz4fwiS//+8TQRDEmYB6uXYhHsfbW+3x9uXnVWwfAOdIjvsiG7PirGz4
         Qcef+Z65kalYyfSmNRDk72bmrjL4rVZptdfncgZ0EkEhTdHKErDOdcYjvsWgcXED+Frt
         7ffg==
X-Gm-Message-State: AOAM531iT0yLgqTDWC8pFibZ0Kq8rOOX8gKNtPXBRjGj4Za6i2qdbhg/
        XUvUWtH7spztCBSJuXqMIppXtLFWhkA=
X-Google-Smtp-Source: ABdhPJyA7nkCHtgF1Ky9sX3Q03wwWW0n+R4IDfZpvb9QcVtZmOB/dlsW9KVdZXH891DMdFXVT5iQ7w==
X-Received: by 2002:a2e:a231:: with SMTP id i17mr4020359ljm.233.1632390498744;
        Thu, 23 Sep 2021 02:48:18 -0700 (PDT)
Received: from home.paul.comp (paulfertser.info. [2001:470:26:54b:226:9eff:fe70:80c2])
        by smtp.gmail.com with ESMTPSA id a7sm411947lfl.243.2021.09.23.02.48.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Sep 2021 02:48:18 -0700 (PDT)
Received: from home.paul.comp (home.paul.comp [IPv6:0:0:0:0:0:0:0:1])
        by home.paul.comp (8.15.2/8.15.2/Debian-14~deb10u1) with ESMTP id 18N9mFr7023381;
        Thu, 23 Sep 2021 12:48:16 +0300
Received: (from paul@localhost)
        by home.paul.comp (8.15.2/8.15.2/Submit) id 18N9mFwr023380;
        Thu, 23 Sep 2021 12:48:15 +0300
From:   Paul Fertser <fercerpav@gmail.com>
To:     linux-hwmon@vger.kernel.org
Cc:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-kernel@vger.kernel.org, Paul Fertser <fercerpav@gmail.com>
Subject: [PATCH v2 3/3] hwmon: tmp421: fix rounding for negative values
Date:   Thu, 23 Sep 2021 12:48:01 +0300
Message-Id: <20210923094801.23332-3-fercerpav@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210923094801.23332-1-fercerpav@gmail.com>
References: <20210922155323.GA3205709@roeck-us.net>
 <20210923094801.23332-1-fercerpav@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Current code produces -24999 for 0b1110011100000000 input in standard
format due to always rounding up rather than "away from zero". Use the
common macro for division, unify and simplify the conversion code along
the way.

Signed-off-by: Paul Fertser <fercerpav@gmail.com>
---

Changes from v1:
 - Trivial rebase

 drivers/hwmon/tmp421.c | 24 ++++++++----------------
 1 file changed, 8 insertions(+), 16 deletions(-)

diff --git a/drivers/hwmon/tmp421.c b/drivers/hwmon/tmp421.c
index 9f0a4db695db..c77c9f3bbd21 100644
--- a/drivers/hwmon/tmp421.c
+++ b/drivers/hwmon/tmp421.c
@@ -100,23 +100,17 @@ struct tmp421_data {
 	s16 temp[4];
 };
 
-static int temp_from_s16(s16 reg)
+static int temp_from_raw(u16 reg, bool extended)
 {
 	/* Mask out status bits */
 	int temp = reg & ~0xf;
 
-	return (temp * 1000 + 128) / 256;
-}
-
-static int temp_from_u16(u16 reg)
-{
-	/* Mask out status bits */
-	int temp = reg & ~0xf;
-
-	/* Add offset for extended temperature range. */
-	temp -= 64 * 256;
+	if (extended)
+		temp = temp - 64 * 256;
+	else
+		temp = (s16)temp;
 
-	return (temp * 1000 + 128) / 256;
+	return DIV_ROUND_CLOSEST(temp * 1000, 256);
 }
 
 static int tmp421_update_device(struct tmp421_data *data)
@@ -175,10 +169,8 @@ static int tmp421_read(struct device *dev, enum hwmon_sensor_types type,
 
 	switch (attr) {
 	case hwmon_temp_input:
-		if (tmp421->config & TMP421_CONFIG_RANGE)
-			*val = temp_from_u16(tmp421->temp[channel]);
-		else
-			*val = temp_from_s16(tmp421->temp[channel]);
+		*val = temp_from_raw(tmp421->temp[channel],
+				     tmp421->config & TMP421_CONFIG_RANGE);
 		return 0;
 	case hwmon_temp_fault:
 		/*
-- 
2.17.1

