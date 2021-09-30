Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 815DA41D162
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Sep 2021 04:26:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347753AbhI3C03 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Sep 2021 22:26:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232383AbhI3C02 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Sep 2021 22:26:28 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7154BC06161C
        for <linux-kernel@vger.kernel.org>; Wed, 29 Sep 2021 19:24:46 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id e7so4719030pgk.2
        for <linux-kernel@vger.kernel.org>; Wed, 29 Sep 2021 19:24:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8rR7ZTCy+3CNKefvR24Fg+SdzoKjkoZ4erRtbMPxOWc=;
        b=Oj+HijVfJjOe2HR4jN2qbgqfbsQjGuC67ZNmVDb1BianYNiZXBsx5xcprtEdY6cc/y
         3nbVmrD3prDdduJTUnakd3F63ACjof9ou1F+tE6ZIg3bKrjpDw5i+N0CQl/FzqeZXUJm
         cJ2dXRvq8KSxThXVVEzQEscEX8R+PzFYi5HwY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8rR7ZTCy+3CNKefvR24Fg+SdzoKjkoZ4erRtbMPxOWc=;
        b=JibyR53mRgQyW1qzQFfmVMF7vlhtvacqsgfiR/HimoJaYp1xXxFVmQ9yoX56vb2pI6
         iBMWM/bE2ZjNzp/F4m2CXFj9K+e9bf2m0anMl1dnPHDpQXyIYyojs7mmWXyn1WfU7W4z
         81F3UclK23H0ON4hy65JJK7/ccDJtuyNyQPRfzuOtq6tvXNh+YARV6tlu+22ap30OkAE
         ZBUtyRCNw89FLNg08iHB798eB5d71EGqYU8lMuDZXRvFJ57pvrz6e12Hab7IwqpYZ45d
         NM0WUjzsXsLSOUJtXs4Q/xtVGH/0fyehGNEN4mbuqq9M5UqgN5lDO84yN1McdCbC41wA
         43Ng==
X-Gm-Message-State: AOAM533Vao9HeZosNgW1MVjUYQspyfCWOVFJziqtvHcKpMUwGxQZyWmG
        lGSXz8Zj2dFNjNP8CeTPnhZ4scIhYGeAxw==
X-Google-Smtp-Source: ABdhPJwcEoQvGODnfb682H1gs9yAX0zYZKPae/4Z54ENnZ8MLsybAXVV6FeAqFqnstQSglETLZY34A==
X-Received: by 2002:aa7:9596:0:b0:43e:48:dbeb with SMTP id z22-20020aa79596000000b0043e0048dbebmr1767735pfj.77.1632968685797;
        Wed, 29 Sep 2021 19:24:45 -0700 (PDT)
Received: from pmalani2.mtv.corp.google.com ([2620:15c:202:201:479:c131:ee9:f257])
        by smtp.gmail.com with ESMTPSA id 126sm898070pgi.86.2021.09.29.19.24.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Sep 2021 19:24:45 -0700 (PDT)
From:   Prashant Malani <pmalani@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     Prashant Malani <pmalani@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>
Subject: [PATCH 1/5] platform/chrome: cros_usbpd_notify: Rename cros_ec_pd_command()
Date:   Wed, 29 Sep 2021 19:23:48 -0700
Message-Id: <20210930022403.3358070-2-pmalani@chromium.org>
X-Mailer: git-send-email 2.33.0.685.g46640cef36-goog
In-Reply-To: <20210930022403.3358070-1-pmalani@chromium.org>
References: <20210930022403.3358070-1-pmalani@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename cros_ec_pd_command()_to cros_ec_command() since it can be used
for sending any host command, and not just PD related ones.

This patch does not introduce any functional changes.

Signed-off-by: Prashant Malani <pmalani@chromium.org>
---
 drivers/platform/chrome/cros_usbpd_notify.c | 20 +++++++++-----------
 1 file changed, 9 insertions(+), 11 deletions(-)

diff --git a/drivers/platform/chrome/cros_usbpd_notify.c b/drivers/platform/chrome/cros_usbpd_notify.c
index 48a6617aa12f..e718055f4313 100644
--- a/drivers/platform/chrome/cros_usbpd_notify.c
+++ b/drivers/platform/chrome/cros_usbpd_notify.c
@@ -54,7 +54,7 @@ void cros_usbpd_unregister_notify(struct notifier_block *nb)
 EXPORT_SYMBOL_GPL(cros_usbpd_unregister_notify);
 
 /**
- * cros_ec_pd_command - Send a command to the EC.
+ * cros_ec_command - Send a command to the EC.
  *
  * @ec_dev: EC device
  * @command: EC command
@@ -65,12 +65,12 @@ EXPORT_SYMBOL_GPL(cros_usbpd_unregister_notify);
  *
  * Return: >= 0 on success, negative error number on failure.
  */
-static int cros_ec_pd_command(struct cros_ec_device *ec_dev,
-			      int command,
-			      uint8_t *outdata,
-			      int outsize,
-			      uint8_t *indata,
-			      int insize)
+static int cros_ec_command(struct cros_ec_device *ec_dev,
+			   int command,
+			   uint8_t *outdata,
+			   int outsize,
+			   uint8_t *indata,
+			   int insize)
 {
 	struct cros_ec_command *msg;
 	int ret;
@@ -115,10 +115,8 @@ static void cros_usbpd_get_event_and_notify(struct device  *dev,
 	}
 
 	/* Check for PD host events on EC. */
-	ret = cros_ec_pd_command(ec_dev, EC_CMD_PD_HOST_EVENT_STATUS,
-				 NULL, 0,
-				 (uint8_t *)&host_event_status,
-				 sizeof(host_event_status));
+	ret = cros_ec_command(ec_dev, EC_CMD_PD_HOST_EVENT_STATUS,
+			      NULL, 0, (uint8_t *)&host_event_status, sizeof(host_event_status));
 	if (ret < 0) {
 		dev_warn(dev, "Can't get host event status (err: %d)\n", ret);
 		goto send_notify;
-- 
2.33.0.685.g46640cef36-goog

