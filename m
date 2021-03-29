Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27E7834CA55
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Mar 2021 10:40:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233777AbhC2Igy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Mar 2021 04:36:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233953AbhC2IWi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Mar 2021 04:22:38 -0400
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FA70C061574
        for <linux-kernel@vger.kernel.org>; Mon, 29 Mar 2021 01:22:38 -0700 (PDT)
Received: by mail-qv1-xf2c.google.com with SMTP id o19so6084989qvu.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 Mar 2021 01:22:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=protocubo.io; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pFX+Tz+rEN0+9Vsov9EqDkuW92yjtKRmUMQ/vRcw69s=;
        b=Xf2NpZDiG1wAEvcMjalq9edHulvwkltxcQaZq+RVUr3/GEH4KDqHbcuTPmM3ADB5gz
         lfEMKL3HctEy+/t5GXwTUJos8dVAEud5Xh6mUEEQcyDy7CjQKaekZbQImQ6MHlrVLDwP
         6ubpxpJjUdQ/ptgdqulRAK/XFOYMv69712wUXrqJoho9S6WQ8tN9S27DbY76ULn14+yV
         Odba+dYOZ6cQVc5925jEUBTiSlheezwseWthHAF2S7FJeLfoXwsOfIe1gahFmZ5Ii8YW
         8e/fAD9xGX7+VsQcE0QWE8P5WeJ5jb1X0e2EssZSCyJhrcxfZ3sfgIFsd3VRGlRqxmG2
         wXLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pFX+Tz+rEN0+9Vsov9EqDkuW92yjtKRmUMQ/vRcw69s=;
        b=NW2TGiTLAX14LxhhUm2YlCwnUvYJC/E3380XGL5/1JNPBNhl8MWNItXSKscfANc/hm
         Tp+2EuBGh5PbNVec2FivJtMR7xJx3oyA4jRGWlizQQ26ewXkLenQ/s2zsa1QAXQQD9qg
         qC8WTl4gel8KaWlX3EFfKSIPkXjMtl0n8dR9DAFD0M1XTI+WBK3vz0Q86u2K2umRo6Hs
         1r8YZu9wuNOHkdvpYMAnMJhrEGqnNPeZSu8ksTpB88TjT1BZTvblxVfIn7EVrL2BEgWD
         gkmq0zR9ApIHVOaXHmY1FeGn5ysYQNemQVk9yJwqtcN8RxWQmZ1TmbK/uPuszn8hU8OE
         P2tA==
X-Gm-Message-State: AOAM531B8r1E8soMjAYB6IrrX0V1Ns0RHYzrw6Kn1BIImZXDE9MwCzGF
        +Qg+UmCQvkXh7dfqLq4rJUyq5jlhgfulsw==
X-Google-Smtp-Source: ABdhPJxvfWope6tzVCK0RePEwSgpVm61Rwt6KBlNGoVj+R5g54jCcLI20dGEV8NPkCs0CLWxqrFanQ==
X-Received: by 2002:ad4:4e53:: with SMTP id eb19mr24598391qvb.8.1617006157635;
        Mon, 29 Mar 2021 01:22:37 -0700 (PDT)
Received: from calvin.localdomain ([2804:14d:5c5a:802e:bdc9:ded9:cc08:a4e9])
        by smtp.gmail.com with ESMTPSA id n1sm5323412qtp.76.2021.03.29.01.22.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Mar 2021 01:22:37 -0700 (PDT)
From:   Jonas Malaco <jonas@protocubo.io>
To:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>
Cc:     Jonas Malaco <jonas@protocubo.io>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] hwmon: (nzxt-kraken2) mark and order concurrent accesses
Date:   Mon, 29 Mar 2021 05:22:01 -0300
Message-Id: <20210329082211.86716-1-jonas@protocubo.io>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To avoid a spinlock, the driver explores concurrent memory accesses
between _raw_event and _read, having the former updating fields on a
data structure while the latter could be reading from them.  Because
these are "plain" accesses, those are data races according to the Linux
kernel memory model (LKMM).

Data races are undefined behavior in both C11 and LKMM.  In practice,
the compiler is free to make optimizations assuming there is no data
race, including load tearing, load fusing and many others,[1] most of
which could result in corruption of the values reported to user-space.

Prevent undesirable optimizations to those concurrent accesses by
marking them with READ_ONCE() and WRITE_ONCE().  This also removes the
data races, according to the LKMM, because both loads and stores to each
location are now "marked" accesses.

As a special case, use smp_load_acquire() and smp_load_release() when
loading and storing ->updated, as it is used to track the validity of
the other values, and thus has to be stored after and loaded before
them.  These imply READ_ONCE()/WRITE_ONCE() but also ensure the desired
order of memory accesses.

[1] https://lwn.net/Articles/793253/

Signed-off-by: Jonas Malaco <jonas@protocubo.io>
---
 drivers/hwmon/nzxt-kraken2.c | 23 ++++++++++++++++-------
 1 file changed, 16 insertions(+), 7 deletions(-)

diff --git a/drivers/hwmon/nzxt-kraken2.c b/drivers/hwmon/nzxt-kraken2.c
index 89f7ea4f42d4..f4fbc8771930 100644
--- a/drivers/hwmon/nzxt-kraken2.c
+++ b/drivers/hwmon/nzxt-kraken2.c
@@ -46,16 +46,22 @@ static int kraken2_read(struct device *dev, enum hwmon_sensor_types type,
 			u32 attr, int channel, long *val)
 {
 	struct kraken2_priv_data *priv = dev_get_drvdata(dev);
+	unsigned long expires;
 
-	if (time_after(jiffies, priv->updated + STATUS_VALIDITY * HZ))
+	/*
+	 * Order load from ->updated before the data it refers to.
+	 */
+	expires = smp_load_acquire(&priv->updated) + STATUS_VALIDITY * HZ;
+
+	if (time_after(jiffies, expires))
 		return -ENODATA;
 
 	switch (type) {
 	case hwmon_temp:
-		*val = priv->temp_input[channel];
+		*val = READ_ONCE(priv->temp_input[channel]);
 		break;
 	case hwmon_fan:
-		*val = priv->fan_input[channel];
+		*val = READ_ONCE(priv->fan_input[channel]);
 		break;
 	default:
 		return -EOPNOTSUPP; /* unreachable */
@@ -119,12 +125,15 @@ static int kraken2_raw_event(struct hid_device *hdev,
 	 * and that the missing steps are artifacts of how the firmware
 	 * processes the raw sensor data.
 	 */
-	priv->temp_input[0] = data[1] * 1000 + data[2] * 100;
+	WRITE_ONCE(priv->temp_input[0], data[1] * 1000 + data[2] * 100);
 
-	priv->fan_input[0] = get_unaligned_be16(data + 3);
-	priv->fan_input[1] = get_unaligned_be16(data + 5);
+	WRITE_ONCE(priv->fan_input[0], get_unaligned_be16(data + 3));
+	WRITE_ONCE(priv->fan_input[1], get_unaligned_be16(data + 5));
 
-	priv->updated = jiffies;
+	/*
+	 * Order store to ->updated after the data it refers to.
+	 */
+	smp_store_release(&priv->updated, jiffies);
 
 	return 0;
 }

base-commit: 644b9af5c605762feffac96bd7ea2499e0197656
-- 
2.31.1

