Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2798379FAF
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 08:32:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230361AbhEKGbJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 May 2021 02:31:09 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:41865 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230293AbhEKGbH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 May 2021 02:31:07 -0400
Received: from mail-ed1-f72.google.com ([209.85.208.72])
        by youngberry.canonical.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <juerg.haefliger@canonical.com>)
        id 1lgLu4-0002g8-Kj
        for linux-kernel@vger.kernel.org; Tue, 11 May 2021 06:30:00 +0000
Received: by mail-ed1-f72.google.com with SMTP id d6-20020a0564020786b0290387927a37e2so10316313edy.10
        for <linux-kernel@vger.kernel.org>; Mon, 10 May 2021 23:30:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OtH4eWQldqUSkW4yxRjOEpNcMPcTYEmH1QrZivGyJ5I=;
        b=aUxSqOtg7v/Zch1uR9cnMY/CiuClCq/6pJolOc2wtYotFUYfKF5sei5oCPAAqXGlwT
         PYCYFHSLHGEkzgLEFU9qYipScYyuXCUfwy1f/ZdMMUH04+18qdyowgpyyiHzkXcye+50
         4Wj7lm8tmEsL9hR8Pkn9xgn7PPUr02TeWMBUgabUMcj7BJf8hn+fcvZkbXvnYT/h9cUx
         AUOI1Qc682G2w4p2NhhwgNT0hftdR0HJIPaQjd/8U22YTydZIFDNe0cu8/iOv3niPjwC
         sTNjcRxzIAbpbTrtp7yW2ygb0PzkxmaDG/hkctzvr0CrtHmpiXjrF2DIy7MLFfsSaRfz
         ne5A==
X-Gm-Message-State: AOAM531A3I9TYmtf9IeMuqJ2joCRXTKeh4sBE0FbKVDrQNII0URkrf/r
        DFdDVs/l34vnKohG9xkHAD2KH9gCmfTP2ci30w1e0pgSz5yqfbrIvOep/v6aZ18VG+DEuPI88p0
        9oCy1OV4cVW3G8/nvuo+dTGgVlbNFsz2OMGn7O0Bi2g==
X-Received: by 2002:a05:6402:110b:: with SMTP id u11mr35335791edv.356.1620714600385;
        Mon, 10 May 2021 23:30:00 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz0sMPdfW5EZzNP18EtpiuVYKvGJqnPmXoBsW2Wozhs74M15B6ytpkafIoFx8aXfada77AYwQ==
X-Received: by 2002:a05:6402:110b:: with SMTP id u11mr35335779edv.356.1620714600254;
        Mon, 10 May 2021 23:30:00 -0700 (PDT)
Received: from gollum.fritz.box ([194.191.244.86])
        by smtp.gmail.com with ESMTPSA id p22sm13511530edr.4.2021.05.10.23.29.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 May 2021 23:29:59 -0700 (PDT)
From:   Juerg Haefliger <juerg.haefliger@canonical.com>
X-Google-Original-From: Juerg Haefliger <juergh@canonical.com>
To:     wim@linux-watchdog.org, linux@roeck-us.net,
        linux-watchdog@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Juerg Haefliger <juergh@canonical.com>
Subject: [PATCH v2] watchdog: Add {min,max}_timeout sysfs nodes
Date:   Tue, 11 May 2021 08:29:53 +0200
Message-Id: <20210511062953.485252-1-juergh@canonical.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210510131625.21506-1-juergh@canonical.com>
References: <20210510131625.21506-1-juergh@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The valid range for the 'timeout' value is useful information so expose
the min and max timeout values via sysfs.

Signed-off-by: Juerg Haefliger <juergh@canonical.com>
---

v1->v2:
 - replace sprintf() with sysfs_emit().

 drivers/watchdog/watchdog_dev.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/watchdog/watchdog_dev.c b/drivers/watchdog/watchdog_dev.c
index fe68a97973a5..7c1007ab1b71 100644
--- a/drivers/watchdog/watchdog_dev.c
+++ b/drivers/watchdog/watchdog_dev.c
@@ -526,6 +526,24 @@ static ssize_t timeout_show(struct device *dev, struct device_attribute *attr,
 }
 static DEVICE_ATTR_RO(timeout);
 
+static ssize_t min_timeout_show(struct device *dev,
+				struct device_attribute *attr, char *buf)
+{
+	struct watchdog_device *wdd = dev_get_drvdata(dev);
+
+	return sysfs_emit(buf, "%u\n", wdd->min_timeout);
+}
+static DEVICE_ATTR_RO(min_timeout);
+
+static ssize_t max_timeout_show(struct device *dev,
+				struct device_attribute *attr, char *buf)
+{
+	struct watchdog_device *wdd = dev_get_drvdata(dev);
+
+	return sysfs_emit(buf, "%u\n", wdd->max_timeout);
+}
+static DEVICE_ATTR_RO(max_timeout);
+
 static ssize_t pretimeout_show(struct device *dev,
 			       struct device_attribute *attr, char *buf)
 {
@@ -610,6 +628,8 @@ static struct attribute *wdt_attrs[] = {
 	&dev_attr_state.attr,
 	&dev_attr_identity.attr,
 	&dev_attr_timeout.attr,
+	&dev_attr_min_timeout.attr,
+	&dev_attr_max_timeout.attr,
 	&dev_attr_pretimeout.attr,
 	&dev_attr_timeleft.attr,
 	&dev_attr_bootstatus.attr,
-- 
2.27.0

