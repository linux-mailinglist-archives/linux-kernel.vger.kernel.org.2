Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52737459FEA
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Nov 2021 11:16:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235400AbhKWKTp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Nov 2021 05:19:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235337AbhKWKTn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Nov 2021 05:19:43 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A302C061574
        for <linux-kernel@vger.kernel.org>; Tue, 23 Nov 2021 02:16:35 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id 137so14673540wma.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 Nov 2021 02:16:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+9ryz7vgzdzT6CvTKvKSjwgyGJQO+uKj904pYNg7wxo=;
        b=bJPVpuq7XVHbUY1uVa9BDx32xiWj+E/dXiOA2K8YH0JsrSM/0Yz2DTxvdw3ukTYEjD
         8PcKDlTpscb4fVjWbDuCeLB/myyS9GaJt8XWmMHg26cbZTp0mBd1sqAn/6b6+zryrP17
         iIA93PwkXQZkHxhe0q05SuIfwd2tn8S+67pHHdxmubhtDPpguWKrJQGlB16DjSsbZQkK
         w/UgohphraUfWeI/6HPWOw1WR80LddAOWEE1tPTgisQq1y+p5s3vuygoAmQ5EaMgd0Jd
         VNC6bkUXpaCXt+XTLmLVlt3ZtrkgpT3zmz8/jWv4/At+JMOZ+gOD/5GE8uc5QTMZnFEN
         yWxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+9ryz7vgzdzT6CvTKvKSjwgyGJQO+uKj904pYNg7wxo=;
        b=Y2Wo//0tfiffJqBPm8CUBMNSKNv8yaNdn75rGNIXYeAUHzAUeJp6Y5BoDpLnLyt9Yn
         WAYpb+Sd7lyXprb/wsN6anJkveQjRYwQm1qZj/na1ylVe9+h+bvSFw1NlN/0LNBhtqNx
         fBXDy3YO05BlPXrrBEHchyKMY5NoDsYvBj+KIUF9KAHCcGOv4ziBgfpDjuHJWaDrr33a
         6dZdITY6sqAdgA1+sN04kS3rDde7L1YRX5SNvwAXdLAFBRInwjzc4i1Y2UjB3v1QAwYA
         TfiOD8Kj1VZOvZRribUeY1EsNDkxwxGzYlFgtnCVC+ab+22iA/FTK8YHxIp/5V2scuOk
         IlwQ==
X-Gm-Message-State: AOAM531W/O7Tlzs5kWkkqK6GnvI/qTDBm+7ieN43NnRHU8IrSKqBP8TX
        GECvPo4Agk2BEJwhUuXz8HUTmM1oRedJyw==
X-Google-Smtp-Source: ABdhPJyhwXTYNLFK5FtrMOjYw903pgiOyYbiwRL92lijRyE0DGper/vX/qmi2+7p0FV7FoSCovPedg==
X-Received: by 2002:a05:600c:22d0:: with SMTP id 16mr1589838wmg.37.1637662593926;
        Tue, 23 Nov 2021 02:16:33 -0800 (PST)
Received: from localhost.localdomain ([2a01:e34:ed2f:f020:3c04:dd20:bbdc:7a85])
        by smtp.gmail.com with ESMTPSA id v8sm11492662wrd.84.2021.11.23.02.16.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Nov 2021 02:16:33 -0800 (PST)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     daniel.lezcano@linaro.org, rafael@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Greg KH <gregkh@linuxfoundation.org>,
        Daniel Lezcano <daniel.lezcano@kernel.org>
Subject: [PATCH 2/2] powercap/drivers/dtpm: Reduce trace verbosity
Date:   Tue, 23 Nov 2021 11:16:01 +0100
Message-Id: <20211123101601.2433340-2-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211123101601.2433340-1-daniel.lezcano@linaro.org>
References: <20211123101601.2433340-1-daniel.lezcano@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The traces when registering a powerzone is at the pr_info level and
should be changed to pr_debug as requested by Greg-KH.

Cc: Greg KH <gregkh@linuxfoundation.org>
Link: https://lkml.kernel.org/r/YGAnRx8SiZHFPpY6@kroah.com
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/powercap/dtpm.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/powercap/dtpm.c b/drivers/powercap/dtpm.c
index b9fac786246a..0fe70687c198 100644
--- a/drivers/powercap/dtpm.c
+++ b/drivers/powercap/dtpm.c
@@ -382,7 +382,7 @@ void dtpm_unregister(struct dtpm *dtpm)
 {
 	powercap_unregister_zone(pct, &dtpm->zone);
 
-	pr_info("Unregistered dtpm node '%s'\n", dtpm->zone.name);
+	pr_debug("Unregistered dtpm node '%s'\n", dtpm->zone.name);
 }
 
 /**
@@ -453,8 +453,8 @@ int dtpm_register(const char *name, struct dtpm *dtpm, struct dtpm *parent)
 		dtpm->power_limit = dtpm->power_max;
 	}
 
-	pr_info("Registered dtpm node '%s' / %llu-%llu uW, \n",
-		dtpm->zone.name, dtpm->power_min, dtpm->power_max);
+	pr_debug("Registered dtpm node '%s' / %llu-%llu uW, \n",
+		 dtpm->zone.name, dtpm->power_min, dtpm->power_max);
 
 	mutex_unlock(&dtpm_lock);
 
-- 
2.25.1

