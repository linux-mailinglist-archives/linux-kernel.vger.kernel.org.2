Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60C7730A0D1
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 05:24:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231355AbhBAEXz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Jan 2021 23:23:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231171AbhBAEXn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Jan 2021 23:23:43 -0500
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA90BC061574
        for <linux-kernel@vger.kernel.org>; Sun, 31 Jan 2021 20:23:03 -0800 (PST)
Received: by mail-pf1-x436.google.com with SMTP id e19so10712067pfh.6
        for <linux-kernel@vger.kernel.org>; Sun, 31 Jan 2021 20:23:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4uwhtzC2WNpeYDFbf4Q0zbAHOoVU25k2GhOmlxKVkiU=;
        b=nXMzZKGOkp7SNbDHo2BeBp8yAqYk73v5fuhG5lKOkqENT85PpYRwZdrQz3NTeDZlqb
         0/yDjEV7kXh8jyomcFCrezlvtebf/Rw8UOSmnVV0oemCJah/zerSkheWvQRnCyWs21Yn
         t8pmLfNnl+fjsrjSWAalQVJAL+aOt26UX+CgdHgxObNRX0hwgzjjqHQzAaahrQPY8ml3
         NMrX1OOdoJV8Vam1FNacd8crvqFr90thFS+NLXlhPahbHTHsuV/sVkcgW/SqY2uLa5Pp
         PB/kUFinqvyPefCx/PGVSEZhYErjMYcjTr3/9uidnBPhebHUt+cSBftJkKhSmos6kJUD
         gA9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4uwhtzC2WNpeYDFbf4Q0zbAHOoVU25k2GhOmlxKVkiU=;
        b=srAYhMDTmpy9iNqLRpIUAyVwTLHbIE0p57gGctgBPr/elsmvMSnQvQSERzRkX2kbjk
         vomvInWCxtlRa15i5atnZIU22u/x9E0VHeuT607mCT+Iivvu5DKCgUesqvhYA8kowj4s
         8fGgvt5hDIwmcLhHcVeBTi+E57DmHX5LJcm7yoavWXZNhS3Vtmp6IoPkzzhiOh95c/Q+
         kBfcsOfipMjdX60nEyozrTjEfUK8y6crFtDpYbimCncNuBVtfHJtUFPkljdZQg7lEpfu
         eLRxTIt5ltVWmdGRYGfk9drCs8z8Wav2FF3g6L9tOxORW0zPQwImpVn1yqsP5kJmaOrj
         yUKw==
X-Gm-Message-State: AOAM5320uFjd+L7uaDf57bDg1JTQnn4JTddnGB7EXqjqY7LB9ctjp6Cb
        5Nxs/z85EZ+UQ5WCosmfMF2z7g==
X-Google-Smtp-Source: ABdhPJzYtWeP4jlWdHO5RS+avsDY6ktQRTDrXz8xjQRwZPmSyLBGbhAtaHvtYJPbQw68C4cERBjKuQ==
X-Received: by 2002:a05:6a00:1353:b029:1c5:8a8d:7ee6 with SMTP id k19-20020a056a001353b02901c58a8d7ee6mr14316656pfu.13.1612153383109;
        Sun, 31 Jan 2021 20:23:03 -0800 (PST)
Received: from localhost ([122.172.59.240])
        by smtp.gmail.com with ESMTPSA id e20sm16315473pgr.48.2021.01.31.20.23.01
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 31 Jan 2021 20:23:02 -0800 (PST)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Rafael Wysocki <rjw@rjwysocki.net>,
        Dmitry Osipenko <digetx@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH V2] opp: Don't ignore clk_get() errors other than -ENOENT
Date:   Mon,  1 Feb 2021 09:52:58 +0530
Message-Id: <61854037cd4d3ac367cfda3f02fd1557b1b3bb8b.1612153322.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.25.0.rc1.19.g042ed3e048af
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Not all devices that need to use OPP core need to have clocks, a missing
clock is fine in which case -ENOENT shall be returned by clk_get().

Anything else is an error and must be handled properly.

Reported-by: Dmitry Osipenko <digetx@gmail.com>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
V2:
- s/ENODEV/ENOENT
- Use dev_err_probe()

Stephen, is the understanding correct that -ENOENT is the only error
returned for missing clocks ?

 drivers/opp/core.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index a518173fd64a..0beb3ee79523 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -1252,6 +1252,8 @@ static struct opp_table *_update_opp_table_clk(struct device *dev,
 					       struct opp_table *opp_table,
 					       bool getclk)
 {
+	int ret;
+
 	/*
 	 * Return early if we don't need to get clk or we have already tried it
 	 * earlier.
@@ -1261,18 +1263,19 @@ static struct opp_table *_update_opp_table_clk(struct device *dev,
 
 	/* Find clk for the device */
 	opp_table->clk = clk_get(dev, NULL);
-	if (IS_ERR(opp_table->clk)) {
-		int ret = PTR_ERR(opp_table->clk);
 
-		if (ret == -EPROBE_DEFER) {
-			dev_pm_opp_put_opp_table(opp_table);
-			return ERR_PTR(ret);
-		}
+	ret = PTR_ERR_OR_ZERO(opp_table->clk);
+	if (!ret)
+		return opp_table;
 
+	if (ret == -ENOENT) {
 		dev_dbg(dev, "%s: Couldn't find clock: %d\n", __func__, ret);
+		return opp_table;
 	}
 
-	return opp_table;
+	dev_pm_opp_put_opp_table(opp_table);
+
+	return ERR_PTR(dev_err_probe(dev, ret, "Couldn't find clock\n"));
 }
 
 /*
-- 
2.25.0.rc1.19.g042ed3e048af

