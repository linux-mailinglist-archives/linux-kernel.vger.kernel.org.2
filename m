Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3C0C414AED
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Sep 2021 15:42:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232605AbhIVNoS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Sep 2021 09:44:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232385AbhIVNoP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Sep 2021 09:44:15 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AF32C061574;
        Wed, 22 Sep 2021 06:42:45 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id z24so12054528lfu.13;
        Wed, 22 Sep 2021 06:42:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZR/F/tAdeYtP0BuXmGIaoBGFpWAWS9oXF4q6CXrSt+8=;
        b=RlPXqdhg5O+9K6Aooi4Oe0pSO4FXKyo7eQXFdGOeyCaIRwTNCkYw+5UJt8SmHfuWdh
         ZHkRuNjdLPLSsjy7a3EACTCu1Bt1vox1KGcq8ZUneSHLI9zVXMcMhnuFRDV5b/9aQCv1
         yUpag+uUZV5n/AJbHNv3xBhezw3zfn/M7xnn4pal71SnxyRz1VAz5eamCVH4h4EJ5tA+
         T+NX/MeyooGp3b5z5C0PmgoqUvQWrLS2JL3VoJCTJ6GOyW90BHNueOJtA1dILe6rxzJ+
         xObUlsUwUBzvZ7Kca7yXySkBuazF5inyXxi/A0S6RVEzcnwK0s+G9v7vq4Nxv7KZIkgB
         PqAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZR/F/tAdeYtP0BuXmGIaoBGFpWAWS9oXF4q6CXrSt+8=;
        b=5SFhxIzXSO3hZ0ACXq3QBuX7ujVGmz1XCxh7ygRwynq982XS2HsA+x0tf1GGBDjPtx
         Ka62tj2IoolRYX8LlRBslmbsgPWlQAQMruunWPQIfPTaFmkZO1zeciLn8daGO3CS91Fd
         AQofKMiYDRNkCbNikRKW8Ybz0qF7+wEyMyvLWwM4i0xDQ5hfg9W8IWEbpKKhsl7xY/qx
         se37pEZCtcMv66uEAp2USckwx7N2g+zifTNPyW2SFPqgUXMBosIR5MpwNYkbIAmwvgLd
         VI/z306qtPOts/LylYj1AL3YdGTethGfICdrSEZ0sNcWn0cCOYU3lDaat0ITa1xqVQOh
         ldxg==
X-Gm-Message-State: AOAM531Pr4q5VlDACjec2wPs5XfLLDDVQaz4CyV/V83j53Kax+4IO9yb
        qFkCzp3VgYkUjnU5DX3d0zg5kQdI0m0=
X-Google-Smtp-Source: ABdhPJxDBDAte4lqxgQllzAVk7Y5eMZPUdHA9gjrGvoqnd9w+WwBMU0yva+Wdm0W0K3KiOLTtPAK6A==
X-Received: by 2002:a05:6512:3091:: with SMTP id z17mr27336263lfd.246.1632318140763;
        Wed, 22 Sep 2021 06:42:20 -0700 (PDT)
Received: from home.paul.comp (paulfertser.info. [2001:470:26:54b:226:9eff:fe70:80c2])
        by smtp.gmail.com with ESMTPSA id r12sm168495ljc.40.2021.09.22.06.42.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Sep 2021 06:42:20 -0700 (PDT)
Received: from home.paul.comp (home.paul.comp [IPv6:0:0:0:0:0:0:0:1])
        by home.paul.comp (8.15.2/8.15.2/Debian-14~deb10u1) with ESMTP id 18MDgHGf020811;
        Wed, 22 Sep 2021 16:42:18 +0300
Received: (from paul@localhost)
        by home.paul.comp (8.15.2/8.15.2/Submit) id 18MDgHYD020810;
        Wed, 22 Sep 2021 16:42:17 +0300
From:   Paul Fertser <fercerpav@gmail.com>
To:     linux-hwmon@vger.kernel.org
Cc:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-kernel@vger.kernel.org, Paul Fertser <fercerpav@gmail.com>
Subject: [PATCH 2/3] hwmon: tmp421: report /PVLD condition
Date:   Wed, 22 Sep 2021 16:41:53 +0300
Message-Id: <20210922134154.20766-2-fercerpav@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210922134154.20766-1-fercerpav@gmail.com>
References: <20210922134154.20766-1-fercerpav@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For both local and remote sensors all the supported ICs can report an
"undervoltage lockout" condition which means the conversion wasn't
properly performed due to insufficient power supply voltage and so the
measurement results can't be trusted.

Signed-off-by: Paul Fertser <fercerpav@gmail.com>
---
 drivers/hwmon/tmp421.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/hwmon/tmp421.c b/drivers/hwmon/tmp421.c
index 6175ed4b10bd..9ee4c61531f3 100644
--- a/drivers/hwmon/tmp421.c
+++ b/drivers/hwmon/tmp421.c
@@ -174,10 +174,10 @@ static int tmp421_read(struct device *dev, enum hwmon_sensor_types type,
 		return 0;
 	case hwmon_temp_fault:
 		/*
-		 * The OPEN bit signals a fault. This is bit 0 of the temperature
-		 * register (low byte).
+		 * Any of OPEN or /PVLD bits indicate a hardware mulfunction
+		 * and the conversion result may be incorrect
 		 */
-		*val = tmp421->temp[channel] & 0x01;
+		*val = !!(tmp421->temp[channel] & 0x03);
 		return 0;
 	default:
 		return -EOPNOTSUPP;
@@ -190,9 +190,6 @@ static umode_t tmp421_is_visible(const void *data, enum hwmon_sensor_types type,
 {
 	switch (attr) {
 	case hwmon_temp_fault:
-		if (channel == 0)
-			return 0;
-		return 0444;
 	case hwmon_temp_input:
 		return 0444;
 	default:
-- 
2.17.1

