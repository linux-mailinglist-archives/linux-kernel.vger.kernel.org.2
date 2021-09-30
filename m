Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27A5E41D164
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Sep 2021 04:26:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347781AbhI3C1R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Sep 2021 22:27:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232383AbhI3C1R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Sep 2021 22:27:17 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 763DDC06161C
        for <linux-kernel@vger.kernel.org>; Wed, 29 Sep 2021 19:25:33 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id g2so3617209pfc.6
        for <linux-kernel@vger.kernel.org>; Wed, 29 Sep 2021 19:25:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XwVLFAEFzZUQGnglhLw+6tyOWP3u/X7638qPqZuKRBM=;
        b=ZltSaS1VxMY4yYiB0DleWFvU4Oxn/hWfB7IpqynOWW9BmUare+UI22P6RcmKF0RaQO
         a+pkPsGsRWUWrErwbjSbv2M9QOyTs4KYLKZH1VlGpCh6Cut1t6D5bACViDrwwGdCe0eZ
         v5SahE1AE7EYt6lRBfS966qMNQkh6EY6O284w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XwVLFAEFzZUQGnglhLw+6tyOWP3u/X7638qPqZuKRBM=;
        b=b3ABkUjJFbKfwdhbvI+TztAmqhG38eBur1nz4d+sTS56wFB9WWDr531Ufrltoo4t0y
         duFUcRoj6Sqgj0v4GeR74QCXvlcTqZ5rfZPnQd6TfI7I3pf01eOGWQQ6kqmB/vJ+ur73
         GFbllY/7NFDk89/OuMKv/4toOsGA/YMID8TDt6jdJWjujqoBoWBIkIEeX76DbkaHqBTt
         +1tpz3SfOXIAGkb6s2mhPFC85bA6yedzc1QUku6HkknhNOfiKVDFj9sTkTWQbyQW3ya5
         xj3sV8yjCT8Bsf/9q2yZLTFdAOJQGrisrbG3aYVbUUxqnmjolSQggcpl00VOCfjD5bwl
         Sjwg==
X-Gm-Message-State: AOAM530VArPXwjkHsZtWp15OUA2YJ1zpXHeBZMC+TaAN2fU0YR821fkU
        9Ql/9nsylgLuHUZSGFjLSA5p77PpR+WlXg==
X-Google-Smtp-Source: ABdhPJwkMohUe0OJ1Fb2a//nKuuPh1Hfsyk8H8ACimvhrJ9NP7cJyxQvxWjbxWloCMn35hmeZJWpbw==
X-Received: by 2002:a05:6a00:22c3:b0:447:b30c:ed36 with SMTP id f3-20020a056a0022c300b00447b30ced36mr3041255pfj.82.1632968732722;
        Wed, 29 Sep 2021 19:25:32 -0700 (PDT)
Received: from pmalani2.mtv.corp.google.com ([2620:15c:202:201:479:c131:ee9:f257])
        by smtp.gmail.com with ESMTPSA id 126sm898070pgi.86.2021.09.29.19.25.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Sep 2021 19:25:32 -0700 (PDT)
From:   Prashant Malani <pmalani@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     Prashant Malani <pmalani@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>
Subject: [PATCH 3/5] platform/chrome: cros_ec_proto: Make data pointers void
Date:   Wed, 29 Sep 2021 19:23:52 -0700
Message-Id: <20210930022403.3358070-4-pmalani@chromium.org>
X-Mailer: git-send-email 2.33.0.685.g46640cef36-goog
In-Reply-To: <20210930022403.3358070-1-pmalani@chromium.org>
References: <20210930022403.3358070-1-pmalani@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the input and output data pointers for cros_ec_command() to
void pointers so that the callers don't have to cast their custom
structs to uint8_t *.

Signed-off-by: Prashant Malani <pmalani@chromium.org>
---
 drivers/platform/chrome/cros_ec_proto.c     | 4 ++--
 drivers/platform/chrome/cros_usbpd_notify.c | 2 +-
 include/linux/platform_data/cros_ec_proto.h | 4 ++--
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/platform/chrome/cros_ec_proto.c b/drivers/platform/chrome/cros_ec_proto.c
index 67009b604630..fd114b57bca2 100644
--- a/drivers/platform/chrome/cros_ec_proto.c
+++ b/drivers/platform/chrome/cros_ec_proto.c
@@ -925,9 +925,9 @@ EXPORT_SYMBOL_GPL(cros_ec_get_sensor_count);
  */
 int cros_ec_command(struct cros_ec_device *ec_dev,
 		    int command,
-		    uint8_t *outdata,
+		    void *outdata,
 		    int outsize,
-		    uint8_t *indata,
+		    void *indata,
 		    int insize)
 {
 	struct cros_ec_command *msg;
diff --git a/drivers/platform/chrome/cros_usbpd_notify.c b/drivers/platform/chrome/cros_usbpd_notify.c
index 39afdad897ce..860509474f05 100644
--- a/drivers/platform/chrome/cros_usbpd_notify.c
+++ b/drivers/platform/chrome/cros_usbpd_notify.c
@@ -72,7 +72,7 @@ static void cros_usbpd_get_event_and_notify(struct device  *dev,
 
 	/* Check for PD host events on EC. */
 	ret = cros_ec_command(ec_dev, EC_CMD_PD_HOST_EVENT_STATUS,
-			      NULL, 0, (uint8_t *)&host_event_status, sizeof(host_event_status));
+			      NULL, 0, &host_event_status, sizeof(host_event_status));
 	if (ret < 0) {
 		dev_warn(dev, "Can't get host event status (err: %d)\n", ret);
 		goto send_notify;
diff --git a/include/linux/platform_data/cros_ec_proto.h b/include/linux/platform_data/cros_ec_proto.h
index 20b17c43caeb..f833473c5f44 100644
--- a/include/linux/platform_data/cros_ec_proto.h
+++ b/include/linux/platform_data/cros_ec_proto.h
@@ -231,8 +231,8 @@ bool cros_ec_check_features(struct cros_ec_dev *ec, int feature);
 
 int cros_ec_get_sensor_count(struct cros_ec_dev *ec);
 
-int cros_ec_command(struct cros_ec_device *ec_dev, int command, uint8_t *outdata, int outsize,
-		    uint8_t *indata, int insize);
+int cros_ec_command(struct cros_ec_device *ec_dev, int command, void *outdata, int outsize,
+		    void *indata, int insize);
 
 /**
  * cros_ec_get_time_ns() - Return time in ns.
-- 
2.33.0.685.g46640cef36-goog

