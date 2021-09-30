Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70C6841D165
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Sep 2021 04:26:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347789AbhI3C1i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Sep 2021 22:27:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232383AbhI3C1h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Sep 2021 22:27:37 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68CB8C06161C
        for <linux-kernel@vger.kernel.org>; Wed, 29 Sep 2021 19:25:55 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id bb10so2921452plb.2
        for <linux-kernel@vger.kernel.org>; Wed, 29 Sep 2021 19:25:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iuKw5RK0A3zy4lwzx7GTLDEhVHyxHi4KmkFv9kF/zkY=;
        b=EnKVp+GUySn4HXdV45FAE+5eKKP+c2GHeGGMsuhaSCaiOl1ojRZV78tmJz+htXZZ5L
         astTNjT4qEUartN0c+b8V4RGKS+mm/yM93ZBJivo4F3ZfmT1U9ZuOBM4H9u+PN1LTrG5
         UB+VLVuRxrjmhsKdRcsZDGX7qJbgKkdyyJ/Cc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iuKw5RK0A3zy4lwzx7GTLDEhVHyxHi4KmkFv9kF/zkY=;
        b=tuh14PSc0CXLFHMZmLfYepkVGY1pjv6W21A2fKHfsY/Hpraik1huU6xhat3hBAA6L0
         RTGx/QGjfJNz5M5oZ2hxcShTN8R97LXa+2SkkZhK0cQkiCzcYtZFjNVs1cM+lL8UEMh9
         4GBQVAS7gJXl5cVdFV+wClZmrloeZ0E17idR0cpJrDq7A/SnoqAlnVW6prIV0nX8tywi
         i6bIAAMpGXKcnsWYwwiX4zGzKl9Jof/Fjc3H8gVmYP4H/hwmSbUrFYMBCvB9hTgqY65s
         /lqejXX8PNovhS4K8Tr3NPk0TBSg8Sy+v2DqmIRdffFreR3o3sKkeytB8RcYOIOOwPkN
         KNJA==
X-Gm-Message-State: AOAM5311jCD15zlgXZVBS+7L8xxnD3OW2tvm0J8bSlAMTN2ig99oB58R
        bfsrHR7O5nKijvOMmH+sgkIhzv9+Uou+6g==
X-Google-Smtp-Source: ABdhPJxkwzjvuRxD0JAPkuRvpDAalI5wcFeUVQGI6ahYQdORFgAhdlKO5ro9kJC0CZj9we1Ntbw6oA==
X-Received: by 2002:a17:90b:4a4c:: with SMTP id lb12mr10019190pjb.55.1632968754805;
        Wed, 29 Sep 2021 19:25:54 -0700 (PDT)
Received: from pmalani2.mtv.corp.google.com ([2620:15c:202:201:479:c131:ee9:f257])
        by smtp.gmail.com with ESMTPSA id 126sm898070pgi.86.2021.09.29.19.25.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Sep 2021 19:25:54 -0700 (PDT)
From:   Prashant Malani <pmalani@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     Prashant Malani <pmalani@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>
Subject: [PATCH 4/5] platform/chrome: cros_ec_proto: Add version for ec_command
Date:   Wed, 29 Sep 2021 19:23:54 -0700
Message-Id: <20210930022403.3358070-5-pmalani@chromium.org>
X-Mailer: git-send-email 2.33.0.685.g46640cef36-goog
In-Reply-To: <20210930022403.3358070-1-pmalani@chromium.org>
References: <20210930022403.3358070-1-pmalani@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a version parameter to cros_ec_command() for callers that may want
to specify which version of the host command they would like to use.

Signed-off-by: Prashant Malani <pmalani@chromium.org>
---
 drivers/platform/chrome/cros_ec_proto.c     | 3 +++
 drivers/platform/chrome/cros_usbpd_notify.c | 2 +-
 include/linux/platform_data/cros_ec_proto.h | 4 ++--
 3 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/platform/chrome/cros_ec_proto.c b/drivers/platform/chrome/cros_ec_proto.c
index fd114b57bca2..a9f1867e5d8f 100644
--- a/drivers/platform/chrome/cros_ec_proto.c
+++ b/drivers/platform/chrome/cros_ec_proto.c
@@ -915,6 +915,7 @@ EXPORT_SYMBOL_GPL(cros_ec_get_sensor_count);
  * cros_ec_command - Send a command to the EC.
  *
  * @ec_dev: EC device
+ * @version: EC command version
  * @command: EC command
  * @outdata: EC command output data
  * @outsize: Size of outdata
@@ -924,6 +925,7 @@ EXPORT_SYMBOL_GPL(cros_ec_get_sensor_count);
  * Return: >= 0 on success, negative error number on failure.
  */
 int cros_ec_command(struct cros_ec_device *ec_dev,
+		    unsigned int version,
 		    int command,
 		    void *outdata,
 		    int outsize,
@@ -937,6 +939,7 @@ int cros_ec_command(struct cros_ec_device *ec_dev,
 	if (!msg)
 		return -ENOMEM;
 
+	msg->version = version;
 	msg->command = command;
 	msg->outsize = outsize;
 	msg->insize = insize;
diff --git a/drivers/platform/chrome/cros_usbpd_notify.c b/drivers/platform/chrome/cros_usbpd_notify.c
index 860509474f05..91ce6be91aac 100644
--- a/drivers/platform/chrome/cros_usbpd_notify.c
+++ b/drivers/platform/chrome/cros_usbpd_notify.c
@@ -71,7 +71,7 @@ static void cros_usbpd_get_event_and_notify(struct device  *dev,
 	}
 
 	/* Check for PD host events on EC. */
-	ret = cros_ec_command(ec_dev, EC_CMD_PD_HOST_EVENT_STATUS,
+	ret = cros_ec_command(ec_dev, 0, EC_CMD_PD_HOST_EVENT_STATUS,
 			      NULL, 0, &host_event_status, sizeof(host_event_status));
 	if (ret < 0) {
 		dev_warn(dev, "Can't get host event status (err: %d)\n", ret);
diff --git a/include/linux/platform_data/cros_ec_proto.h b/include/linux/platform_data/cros_ec_proto.h
index f833473c5f44..9d370816a419 100644
--- a/include/linux/platform_data/cros_ec_proto.h
+++ b/include/linux/platform_data/cros_ec_proto.h
@@ -231,8 +231,8 @@ bool cros_ec_check_features(struct cros_ec_dev *ec, int feature);
 
 int cros_ec_get_sensor_count(struct cros_ec_dev *ec);
 
-int cros_ec_command(struct cros_ec_device *ec_dev, int command, void *outdata, int outsize,
-		    void *indata, int insize);
+int cros_ec_command(struct cros_ec_device *ec_dev, unsigned int version, int command, void *outdata,
+		    int outsize, void *indata, int insize);
 
 /**
  * cros_ec_get_time_ns() - Return time in ns.
-- 
2.33.0.685.g46640cef36-goog

