Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B35C730EE2A
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 09:16:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234909AbhBDIPy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 03:15:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234901AbhBDIPv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 03:15:51 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 659CBC061793
        for <linux-kernel@vger.kernel.org>; Thu,  4 Feb 2021 00:14:36 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id fa16so828605pjb.1
        for <linux-kernel@vger.kernel.org>; Thu, 04 Feb 2021 00:14:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=x7hwBm1kKlbRCUXjrjQz7CyPjQNfq9+xKEIyZstLmMQ=;
        b=oXRtwD8S3IU7qmYkvuuwuGjjF13/SrDBBFsIC6RDA0gMdOXw2QlM6hRE3SJZ6mFLSv
         KomcMdg4+2/7ctxnxSPcDtRdN2BKk7mkig3dr04m8kr9u/wvPbYYjwJJK4Vah3PODknL
         z3Cp83gtMyMIbB+iJdtMRV2t2pH8SNBKpsrE4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=x7hwBm1kKlbRCUXjrjQz7CyPjQNfq9+xKEIyZstLmMQ=;
        b=lMGiaakeOoRHT4xxaH+iO4D3kbkax0eoaJvQrqG5Snc5VHzYFQT2+mnzb87sTYenHd
         LZBiG63oTYtspap/No2z50Uj10vf/BIkT4wU88DX9Fl2zYc20Vr2mCbDw2Ol31LoePxE
         LxQjedFbdDUtkM/W+kWqvqLU3rye57aDnz+gt9RIBWKB77ArTfhMx+Cl+GktmhxdsNgn
         W2gvIVzq7yUgbAPyKl5mxc1DXIHo5Z45TIMGnrBgvfy+gy7zGghRPelTWjtooWvq3Ve5
         glGj5fUlJDlSzSBi1+x3iErTcg9LTyGH0gGevXVDG9hJ5bPDPewlremteoYg7CduNpQB
         6Djw==
X-Gm-Message-State: AOAM5321fN6yPmMY0yZPbJK7/jGJ3Ge+hlYrz1gUnaSOfgsnlFr6/klR
        HM4rxHmQSpoZSBnmVvwUl3P4nw==
X-Google-Smtp-Source: ABdhPJzuP6Azc8rztVE7Z5XDU8FeG4n072jg5T/rqE92DsgySeKm6X8FsaL9Jr4p6Jrn0x4xmz7pXQ==
X-Received: by 2002:a17:90a:701:: with SMTP id l1mr7313673pjl.154.1612426475966;
        Thu, 04 Feb 2021 00:14:35 -0800 (PST)
Received: from hsinyi-z840.tpe.corp.google.com ([2401:fa00:1:10:ed70:6d43:9c6a:2e22])
        by smtp.gmail.com with ESMTPSA id e3sm5091258pgs.60.2021.02.04.00.14.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Feb 2021 00:14:35 -0800 (PST)
From:   Hsin-Yi Wang <hsinyi@chromium.org>
To:     Viresh Kumar <vireshk@kernel.org>, linux-pm@vger.kernel.org
Cc:     Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        linux-kernel@vger.kernel.org,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Saravana Kannan <saravanak@google.com>
Subject: [PATCH v6 3/3] PM / devfreq: Add required OPPs support to passive governor
Date:   Thu,  4 Feb 2021 16:14:24 +0800
Message-Id: <20210204081424.2219311-4-hsinyi@chromium.org>
X-Mailer: git-send-email 2.30.0.365.g02bc693789-goog
In-Reply-To: <20210204081424.2219311-1-hsinyi@chromium.org>
References: <20210204081424.2219311-1-hsinyi@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Saravana Kannan <saravanak@google.com>

Look at the required OPPs of the "parent" device to determine the OPP that
is required from the slave device managed by the passive governor. This
allows having mappings between a parent device and a slave device even when
they don't have the same number of OPPs.

Signed-off-by: Saravana Kannan <saravanak@google.com>
Acked-by: MyungJoo Ham <myungjoo.ham@samsung.com>
Acked-by: Chanwoo Choi <cw00.choi@samsung.com>
Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
---
 drivers/devfreq/governor_passive.c | 25 ++++++++++++++++++-------
 1 file changed, 18 insertions(+), 7 deletions(-)

diff --git a/drivers/devfreq/governor_passive.c b/drivers/devfreq/governor_passive.c
index 63332e4a65ae8..8fd51cc9b991a 100644
--- a/drivers/devfreq/governor_passive.c
+++ b/drivers/devfreq/governor_passive.c
@@ -19,7 +19,7 @@ static int devfreq_passive_get_target_freq(struct devfreq *devfreq,
 			= (struct devfreq_passive_data *)devfreq->data;
 	struct devfreq *parent_devfreq = (struct devfreq *)p_data->parent;
 	unsigned long child_freq = ULONG_MAX;
-	struct dev_pm_opp *opp;
+	struct dev_pm_opp *opp, *p_opp = ERR_PTR(-ENODEV);
 	int i, count, ret = 0;
 
 	/*
@@ -29,7 +29,7 @@ static int devfreq_passive_get_target_freq(struct devfreq *devfreq,
 	 */
 	if (p_data->get_target_freq) {
 		ret = p_data->get_target_freq(devfreq, freq);
-		goto out;
+		return ret;
 	}
 
 	/*
@@ -56,13 +56,22 @@ static int devfreq_passive_get_target_freq(struct devfreq *devfreq,
 	 * list of parent device. Because in this case, *freq is temporary
 	 * value which is decided by ondemand governor.
 	 */
-	opp = devfreq_recommended_opp(parent_devfreq->dev.parent, freq, 0);
-	if (IS_ERR(opp)) {
-		ret = PTR_ERR(opp);
-		goto out;
+	p_opp = devfreq_recommended_opp(parent_devfreq->dev.parent, freq, 0);
+	if (IS_ERR(p_opp)) {
+		ret = PTR_ERR(p_opp);
+		return ret;
 	}
 
-	dev_pm_opp_put(opp);
+	if (devfreq->opp_table && parent_devfreq->opp_table) {
+		opp = dev_pm_opp_xlate_required_opp(parent_devfreq->opp_table,
+						    devfreq->opp_table, p_opp);
+		if (!IS_ERR(opp)) {
+			*freq = dev_pm_opp_get_freq(opp);
+			dev_pm_opp_put(opp);
+		} else
+			ret = PTR_ERR(opp);
+		goto out;
+	}
 
 	/*
 	 * Get the OPP table's index of decided freqeuncy by governor
@@ -89,6 +98,8 @@ static int devfreq_passive_get_target_freq(struct devfreq *devfreq,
 	*freq = child_freq;
 
 out:
+	dev_pm_opp_put(p_opp);
+
 	return ret;
 }
 
-- 
2.30.0.365.g02bc693789-goog

