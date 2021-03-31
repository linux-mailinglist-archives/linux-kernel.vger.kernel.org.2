Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF3ED3501AE
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 15:50:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235793AbhCaNtk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Mar 2021 09:49:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235630AbhCaNtM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Mar 2021 09:49:12 -0400
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90A57C061574;
        Wed, 31 Mar 2021 06:49:11 -0700 (PDT)
Received: by mail-ot1-x32c.google.com with SMTP id v24-20020a9d69d80000b02901b9aec33371so18971003oto.2;
        Wed, 31 Mar 2021 06:49:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=90V6/8WcZ7wZDuZMIocWQ9L7DdYjn1t/LqSZtSrrOEE=;
        b=G49tIdwjULMU2Cqeu4wjE9DJpNFdYzUzXvbGYDhfrshdU49qL96tuafW4r8WWOiXjy
         IiABPvUy/fpQ5dkLiVs0IpHOr877FNBPI1r53vVzV8Jut/ZEXtbaoBcq01axwXVOYjMN
         Y9Qhfn7nFPF9EfrrbFoIZDRXl91tBhgz+o6w2DYYd7krZO9Sv4fbKPfkKTmfLONgLiCb
         XNo2VK3fdv2sCk9IMVBHdhiZB5MdC7ffdF2ThZEsEf4kvRlKHZUGXmqJFRTVicC3I8SS
         AGu67yQjpKh3wJdc5SU27SshiS8c1BI2Gd/EdNLtqJUZreTDG9VQvEvbr5ho4F+wyh0Q
         PCRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=90V6/8WcZ7wZDuZMIocWQ9L7DdYjn1t/LqSZtSrrOEE=;
        b=AEMoQbADkyPfgDpJZ3wSeDuFRBcfNHq3+Ig1+nAP+yg5fmVpRXKokIVbEFT67ZWm4E
         A32/YtQ5Rwsq++S93rpuIuqyGmobsGoPsjGEO6zeFvMc6ZN4QoqL1NdoSS5v3oxuJSLI
         9bPJ0wxftfAdYV8mBzclPEWDORFC+L2V/LnI5DvixUKBP8KNpVXINeQPda3UCwDYF3+w
         EsYkAKQUzzgSZhMCHCEg7Qht6m9oja+DGJKu0ZlzG8qrjMlrwOqglBpNFORvjoD/dCLs
         5JpjrBUDl4+mS2fYVK5UBMxRJ8HjCtaNgWo51BAkJzDm2pvg9rIdRkBdm4tdWJ3v9puH
         U2Kg==
X-Gm-Message-State: AOAM532+6Fxjruq7YuYqPl+HzGL/GWrLvm1xgviRhQOsNVGuDFTZZNuN
        2+qaPG+VwJh1y+qFFfirh2ocDz4wPYY=
X-Google-Smtp-Source: ABdhPJyKZQ/7mfET1BKou4Gs8LrRSiG03Y5/DSZiL29qpaKeu49K/eOB9OGMET8jwk6Qnk8uNZ99+g==
X-Received: by 2002:a9d:5e94:: with SMTP id f20mr2720526otl.150.1617198550279;
        Wed, 31 Mar 2021 06:49:10 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id l81sm448719oif.31.2021.03.31.06.49.09
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 31 Mar 2021 06:49:09 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
To:     Hardware Monitoring <linux-hwmon@vger.kernel.org>
Cc:     linux-kernel@vger.kernel.org, Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Naveen Krishna Chatradhi <nchatrad@amd.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH] hwmon: (amd_energy) Restore visibility of energy counters
Date:   Wed, 31 Mar 2021 06:49:02 -0700
Message-Id: <20210331134902.94720-1-linux@roeck-us.net>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 60268b0e8258 ("hwmon: (amd_energy) modify the visibility of
the counters") restricted visibility of AMD energy counters to work
around a side-channel attack. The attack is described in 'PLATYPUS:
Software-based Power Side-Channel Attacks on x86'. It relies on quick
and accurate power readings.

Limiting power readings to privileged users is annoying. A much better
solution is to make power readings unusable for attacks by randomizing
the time between updates. We can do that by caching energy values for
a short and randomized period of time.

Cc: Naveen Krishna Chatradhi <nchatrad@amd.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Fixes: 60268b0e8258 ("hwmon: (amd_energy) modify the visibility of the counters")
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/amd_energy.c | 28 +++++++++++++++++++---------
 1 file changed, 19 insertions(+), 9 deletions(-)

diff --git a/drivers/hwmon/amd_energy.c b/drivers/hwmon/amd_energy.c
index a86cc8d6d93d..2ee6919eea57 100644
--- a/drivers/hwmon/amd_energy.c
+++ b/drivers/hwmon/amd_energy.c
@@ -18,6 +18,7 @@
 #include <linux/mutex.h>
 #include <linux/processor.h>
 #include <linux/platform_device.h>
+#include <linux/random.h>
 #include <linux/sched.h>
 #include <linux/slab.h>
 #include <linux/topology.h>
@@ -35,6 +36,8 @@
 struct sensor_accumulator {
 	u64 energy_ctr;
 	u64 prev_value;
+	u64 cached_value;
+	unsigned long cache_timeout;
 };
 
 struct amd_energy_data {
@@ -93,6 +96,8 @@ static void accumulate_delta(struct amd_energy_data *data,
 			accum->prev_value + input;
 
 	accum->prev_value = input;
+	accum->cached_value = input;
+	accum->cache_timeout = jiffies + HZ + get_random_int() % HZ;
 	mutex_unlock(&data->lock);
 }
 
@@ -125,16 +130,21 @@ static void amd_add_delta(struct amd_energy_data *data, int ch,
 	u64 input;
 
 	mutex_lock(&data->lock);
-	rdmsrl_safe_on_cpu(cpu, reg, &input);
-	input &= AMD_ENERGY_MASK;
 
 	accum = &data->accums[ch];
-	if (input >= accum->prev_value)
-		input += accum->energy_ctr -
-				accum->prev_value;
-	else
-		input += UINT_MAX - accum->prev_value +
-				accum->energy_ctr;
+	if (!accum->cached_value || time_after(jiffies, accum->cache_timeout)) {
+		rdmsrl_safe_on_cpu(cpu, reg, &input);
+		input &= AMD_ENERGY_MASK;
+
+		if (input >= accum->prev_value)
+			input += accum->energy_ctr - accum->prev_value;
+		else
+			input += UINT_MAX - accum->prev_value + accum->energy_ctr;
+		accum->cached_value = input;
+		accum->cache_timeout = jiffies + HZ + get_random_int() % HZ;
+	} else {
+		input = accum->cached_value;
+	}
 
 	/* Energy consumed = (1/(2^ESU) * RAW * 1000000UL) μJoules */
 	*val = div64_ul(input * 1000000UL, BIT(data->energy_units));
@@ -171,7 +181,7 @@ static umode_t amd_energy_is_visible(const void *_data,
 				     enum hwmon_sensor_types type,
 				     u32 attr, int channel)
 {
-	return 0440;
+	return 0444;
 }
 
 static int energy_accumulator(void *p)
-- 
2.17.1

