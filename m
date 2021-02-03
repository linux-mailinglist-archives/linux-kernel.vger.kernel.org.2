Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12AF830D643
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 10:28:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233380AbhBCJ1T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 04:27:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233245AbhBCJYv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 04:24:51 -0500
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2A9DC061786
        for <linux-kernel@vger.kernel.org>; Wed,  3 Feb 2021 01:24:10 -0800 (PST)
Received: by mail-pg1-x529.google.com with SMTP id z21so16917357pgj.4
        for <linux-kernel@vger.kernel.org>; Wed, 03 Feb 2021 01:24:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BUo70dpbWZG2th1HyMSGNG98xfWBgw6XoNhP4iRnwRU=;
        b=PolVeq0gP5/5egZAteKRDbawZu0yybIhpZS9jypjX6nuquWFQZse/nNqVIeb+heNWi
         Q0zRn4kap/a+7AQ9cXHDGy7CortJiwMhtX2oj3GgaueNYvoSA3qeT0WNepyeP4OTBVYq
         8+2xK4PGN4APrnQwi+kxVKdeeNdFK/NYOECzQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BUo70dpbWZG2th1HyMSGNG98xfWBgw6XoNhP4iRnwRU=;
        b=Ag1Hbn2oawdYJXW56jKn7iksKgfz/OtLvteh43cZbCoab411HbxkEx/BBcIWekjIhv
         l1D7aV8HngKWmqG0Kvp75+pKWh2aqGvkzpo5AFzq/GL+N7xik86MSGP3tXPr9kjyXG+u
         giOVzjU1bvG+2S+J0wqb4Nau1HCLCQ5POyfoIdbE05f5oyLgPZ1bqCSTxCRPET8v7Z/r
         o12+e3OrhoV624A8WFPOj7u8gpJUhDBTnqSnu2xE6/befknOOLUqA4A3ho3yoQvqJcfu
         V5vqliKUze46QGWAMxTnjZDzgS47GmaY56qzgFveiWtoCkx1NnP8pcK1JX91sTvfw/1N
         8XDQ==
X-Gm-Message-State: AOAM533GAV6XXk2oFLCSejckeuoO7/5JB/NFB9oGeAw7jjHLPf1WYRyN
        +JDsz5dDuGXNAYQOC8gvZa7PXA==
X-Google-Smtp-Source: ABdhPJypAXiKQeV7+kTP25ChJV2GX9+q7S7jk6HODiK/eZQUPss02etbFuNRkSxR/FZIxIESY3Y0+g==
X-Received: by 2002:a63:5223:: with SMTP id g35mr2660671pgb.255.1612344250566;
        Wed, 03 Feb 2021 01:24:10 -0800 (PST)
Received: from hsinyi-z840.tpe.corp.google.com ([2401:fa00:1:10:743e:7944:50c8:ff72])
        by smtp.gmail.com with ESMTPSA id u20sm932294pjy.36.2021.02.03.01.24.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Feb 2021 01:24:10 -0800 (PST)
From:   Hsin-Yi Wang <hsinyi@chromium.org>
To:     Viresh Kumar <vireshk@kernel.org>, linux-pm@vger.kernel.org
Cc:     Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        linux-kernel@vger.kernel.org,
        "MyungJoo Ham )" <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Saravana Kannan <saravanak@google.com>
Subject: [PATCH v5 2/3] PM / devfreq: Cache OPP table reference in devfreq
Date:   Wed,  3 Feb 2021 17:23:59 +0800
Message-Id: <20210203092400.1791884-3-hsinyi@chromium.org>
X-Mailer: git-send-email 2.30.0.365.g02bc693789-goog
In-Reply-To: <20210203092400.1791884-1-hsinyi@chromium.org>
References: <20210203092400.1791884-1-hsinyi@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Saravana Kannan <saravanak@google.com>

The OPP table can be used often in devfreq. Trying to get it each time can
be expensive, so cache it in the devfreq struct.

Signed-off-by: Saravana Kannan <saravanak@google.com>
Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>
Acked-by: MyungJoo Ham <myungjoo.ham@samsung.com>
Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
---
 drivers/devfreq/devfreq.c | 6 ++++++
 include/linux/devfreq.h   | 2 ++
 2 files changed, 8 insertions(+)

diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
index 6aa10de792b33..a5899c9ae16fc 100644
--- a/drivers/devfreq/devfreq.c
+++ b/drivers/devfreq/devfreq.c
@@ -757,6 +757,8 @@ static void devfreq_dev_release(struct device *dev)
 	if (devfreq->profile->exit)
 		devfreq->profile->exit(devfreq->dev.parent);
 
+	if (devfreq->opp_table)
+		dev_pm_opp_put_opp_table(devfreq->opp_table);
 	mutex_destroy(&devfreq->lock);
 	kfree(devfreq);
 }
@@ -844,6 +846,10 @@ struct devfreq *devfreq_add_device(struct device *dev,
 	}
 
 	devfreq->suspend_freq = dev_pm_opp_get_suspend_opp_freq(dev);
+	devfreq->opp_table = dev_pm_opp_get_opp_table(dev);
+	if (IS_ERR(devfreq->opp_table))
+		devfreq->opp_table = NULL;
+
 	atomic_set(&devfreq->suspend_count, 0);
 
 	dev_set_name(&devfreq->dev, "%s", dev_name(dev));
diff --git a/include/linux/devfreq.h b/include/linux/devfreq.h
index b6d3bae1c74d8..26ea0850be9bb 100644
--- a/include/linux/devfreq.h
+++ b/include/linux/devfreq.h
@@ -137,6 +137,7 @@ struct devfreq_stats {
  *		using devfreq.
  * @profile:	device-specific devfreq profile
  * @governor:	method how to choose frequency based on the usage.
+ * @opp_table:	Reference to OPP table of dev.parent, if one exists.
  * @nb:		notifier block used to notify devfreq object that it should
  *		reevaluate operable frequencies. Devfreq users may use
  *		devfreq.nb to the corresponding register notifier call chain.
@@ -173,6 +174,7 @@ struct devfreq {
 	struct device dev;
 	struct devfreq_dev_profile *profile;
 	const struct devfreq_governor *governor;
+	struct opp_table *opp_table;
 	struct notifier_block nb;
 	struct delayed_work work;
 
-- 
2.30.0.365.g02bc693789-goog

