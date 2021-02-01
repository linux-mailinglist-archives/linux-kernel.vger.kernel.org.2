Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67BE030A17A
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 06:37:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229556AbhBAFgw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 00:36:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229630AbhBAF0n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 00:26:43 -0500
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1813FC0613D6
        for <linux-kernel@vger.kernel.org>; Sun, 31 Jan 2021 21:26:00 -0800 (PST)
Received: by mail-pg1-x533.google.com with SMTP id v19so11268445pgj.12
        for <linux-kernel@vger.kernel.org>; Sun, 31 Jan 2021 21:26:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=91o0myz+OYjbq2S4/NdrE8Isv+oJfr2OuqWuu9fDksw=;
        b=N2xMkSOUSAc+oT9FQfwpQA7uPggfFo3pOTROUEvkANVwa4TGZKn35uTePU6O4h170e
         enucBKq6/cNO/7kddk8PCsI3jof1d3JzeY+lMUjhPchI16p8QKT7EzZZhs8ojH816dYU
         FAIGbPl5+fvB2CcaQsHM04t621XCTiHlq0qsw1gOO4cocgd/4+AafFrqXrMmvARmxlE+
         agQCra2fX0Lzkzv9hR6L0P2lqjDM9RSVmk7d5+vI/FaiOeYRBrtImtwfTI+yavPlE4iy
         VVCRAaeBJMjaN3BdWYz5gQBu3awpTpY5DTikwmtKeDmScxkDuXxdcaZAHKnCTq+pa2h8
         ws1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=91o0myz+OYjbq2S4/NdrE8Isv+oJfr2OuqWuu9fDksw=;
        b=sdhcPIRfa5x1JniVmUUep7BWOi19Tt+/mkOpIJmKzonBqJ1m8EXO9vd4kwVRrV2LD6
         7YbfCiRJhbcfxSM7WRSMoO8I+1Xf6eCUsRLJ4jwfa/FSvqFj/riMeIR+Cw26+U1uquHv
         OXntI+NlRhq+o80fmMVzHmPe18JO+BjxBO+W42c7SUkG1QSukKW7XQ5G74kBOPfpyHRG
         wCYkhY7sJ8oD5RlWZao2yoacvG3lSYDRO/4reoOurX1/jYJYnbzd/1qt0nyhs2HJOD5O
         d6uf9001gsZm2nc9eQ/odibi1icBcrvMR6TU/9efIx8Fvkn7sDeUDJigYMqm10UE176z
         6Nrw==
X-Gm-Message-State: AOAM533Pf0Xvii8qkXVggioHvRXxqC5CD5QAdTfp99uNmeHNLS9j8R46
        TZ4pZjLbF1VogB+xwiAGjHu3Fw==
X-Google-Smtp-Source: ABdhPJzUcPTHQA8k77ijiYBqvC+F8P5F2wA4IqcVKAkZvWaObGn2gG7KuPiDK+7DeYtTGwy1NTzduA==
X-Received: by 2002:aa7:842b:0:b029:1bf:3390:5c82 with SMTP id q11-20020aa7842b0000b02901bf33905c82mr14315509pfn.36.1612157159550;
        Sun, 31 Jan 2021 21:25:59 -0800 (PST)
Received: from localhost ([122.172.59.240])
        by smtp.gmail.com with ESMTPSA id y16sm16385433pgg.20.2021.01.31.21.25.58
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 31 Jan 2021 21:25:58 -0800 (PST)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] opp: Fix "foo * bar" should be "foo *bar"
Date:   Mon,  1 Feb 2021 10:55:53 +0530
Message-Id: <2f66b83d10ed4a1c4523b7263f8a29097622858c.1612157127.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.25.0.rc1.19.g042ed3e048af
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix checkpatch warning:

ERROR: "foo * bar" should be "foo *bar".

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 include/linux/pm_opp.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/pm_opp.h b/include/linux/pm_opp.h
index 25e47ab937b9..c6c7d73eb015 100644
--- a/include/linux/pm_opp.h
+++ b/include/linux/pm_opp.h
@@ -148,7 +148,7 @@ struct opp_table *dev_pm_opp_set_prop_name(struct device *dev, const char *name)
 void dev_pm_opp_put_prop_name(struct opp_table *opp_table);
 struct opp_table *dev_pm_opp_set_regulators(struct device *dev, const char * const names[], unsigned int count);
 void dev_pm_opp_put_regulators(struct opp_table *opp_table);
-struct opp_table *dev_pm_opp_set_clkname(struct device *dev, const char * name);
+struct opp_table *dev_pm_opp_set_clkname(struct device *dev, const char *name);
 void dev_pm_opp_put_clkname(struct opp_table *opp_table);
 struct opp_table *dev_pm_opp_register_set_opp_helper(struct device *dev, int (*set_opp)(struct dev_pm_set_opp_data *data));
 void dev_pm_opp_unregister_set_opp_helper(struct opp_table *opp_table);
@@ -347,7 +347,7 @@ static inline struct opp_table *dev_pm_opp_set_regulators(struct device *dev, co
 
 static inline void dev_pm_opp_put_regulators(struct opp_table *opp_table) {}
 
-static inline struct opp_table *dev_pm_opp_set_clkname(struct device *dev, const char * name)
+static inline struct opp_table *dev_pm_opp_set_clkname(struct device *dev, const char *name)
 {
 	return ERR_PTR(-ENOTSUPP);
 }
-- 
2.25.0.rc1.19.g042ed3e048af

