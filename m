Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B5AD414AF0
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Sep 2021 15:42:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232838AbhIVNo0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Sep 2021 09:44:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233003AbhIVNoX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Sep 2021 09:44:23 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82A31C061756;
        Wed, 22 Sep 2021 06:42:53 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id e15so11999536lfr.10;
        Wed, 22 Sep 2021 06:42:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lOF37ErIrt4QCm9hfD32diBPJ9qYvrZDIm2Bmis27/E=;
        b=REMfwssb9gkyNN1zQ063pdfB/iO5RBC6SxWxl5yWT8m2NGso+nVADmTJFQkvl1BB26
         dyTNEApex+x7KZZ6JzOENT1d+mkRVTcDqC6oCZonKNdtKUKotQxW7Te3C4q3Wm9VrZXa
         u3OKY9+uAe5Y88jqUrgLkDKaMS+nacUhuV68glw0LaUOQyxrgCD0df5Sv6QUEYNn8D9a
         z7P5Qkjx4MVIJBreEj6zTauE/JerFvKR6/efBPccLImCJqQRmR+9oia4maiyGsl8s0sA
         RMUqNf+EmuNe1G/ch5akAp2oaD0wlczxYxRZ62jp+VTdRVwbBrcqs0Uw7bNMW6J25fVZ
         enVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lOF37ErIrt4QCm9hfD32diBPJ9qYvrZDIm2Bmis27/E=;
        b=S+AXnZfEQBiyIE5qlryuiur9tgFe90e7hWR1sFEscc84zbTlzVuehCOVsbHkOstGzt
         8OAgKHxYWPmiJ+gf3UQe7eAphZFeMYQWpHh8T2oqIZw595lbZeGezetqBPfzJaaIQwhn
         dfr6HyoaHvq4okMZazN+SowYzMqetUYiBdgU5KFluVVkXIOEQSzgInXZxdzo6yQhQ4qs
         y3If/QrwwM3qguNmnqSiJmXHCtp1wP9tR72Z56RsTBF9ujokzpAzOf9e4R+zuB6e1G3m
         efGk6ckpIfCqeG/sFN/pXyZlXcKzoyr+BdrXzZLcuoM7qcEZU5ZW9WijKxEFSpuAKe3A
         NF0A==
X-Gm-Message-State: AOAM532ew8+FG/XtfECnj7gHJsQ5GbJvybtJ1eXzf8W+DC77kCXnTZRi
        cTl6L8Fm+eSlbx1QIpF/lnuDxuOwX7Q=
X-Google-Smtp-Source: ABdhPJzwC1AGAhl37Phjms+cmHYc8VuojgykapdK5JlDg6Linc2JCp91P7QHFEqG5djxTCsQkB3qqw==
X-Received: by 2002:a05:651c:3c3:: with SMTP id f3mr27966863ljp.222.1632318142221;
        Wed, 22 Sep 2021 06:42:22 -0700 (PDT)
Received: from home.paul.comp (paulfertser.info. [2001:470:26:54b:226:9eff:fe70:80c2])
        by smtp.gmail.com with ESMTPSA id y13sm182538lfs.17.2021.09.22.06.42.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Sep 2021 06:42:21 -0700 (PDT)
Received: from home.paul.comp (home.paul.comp [IPv6:0:0:0:0:0:0:0:1])
        by home.paul.comp (8.15.2/8.15.2/Debian-14~deb10u1) with ESMTP id 18MDgJ6j020815;
        Wed, 22 Sep 2021 16:42:20 +0300
Received: (from paul@localhost)
        by home.paul.comp (8.15.2/8.15.2/Submit) id 18MDgJSW020814;
        Wed, 22 Sep 2021 16:42:19 +0300
From:   Paul Fertser <fercerpav@gmail.com>
To:     linux-hwmon@vger.kernel.org
Cc:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-kernel@vger.kernel.org, Paul Fertser <fercerpav@gmail.com>
Subject: [PATCH 3/3] hwmon: tmp421: fix rounding for negative values
Date:   Wed, 22 Sep 2021 16:41:54 +0300
Message-Id: <20210922134154.20766-3-fercerpav@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210922134154.20766-1-fercerpav@gmail.com>
References: <20210922134154.20766-1-fercerpav@gmail.com>
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
 drivers/hwmon/tmp421.c | 24 ++++++++----------------
 1 file changed, 8 insertions(+), 16 deletions(-)

diff --git a/drivers/hwmon/tmp421.c b/drivers/hwmon/tmp421.c
index 9ee4c61531f3..dec3aced3d8b 100644
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
 
 static struct tmp421_data *tmp421_update_device(struct device *dev)
@@ -167,10 +161,8 @@ static int tmp421_read(struct device *dev, enum hwmon_sensor_types type,
 
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

