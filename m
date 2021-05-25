Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 038C538FE62
	for <lists+linux-kernel@lfdr.de>; Tue, 25 May 2021 12:04:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231634AbhEYKFu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 May 2021 06:05:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231521AbhEYKFs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 May 2021 06:05:48 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A98FC061574
        for <linux-kernel@vger.kernel.org>; Tue, 25 May 2021 03:04:19 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id x18so18910138pfi.9
        for <linux-kernel@vger.kernel.org>; Tue, 25 May 2021 03:04:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ingics-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=57ECND8nPavSh6NMH2Nmej1tsV8ESrkOIEhL0JKqaQg=;
        b=LDBiiby7gI8qQMr5tgtnfSpGxe0mkQs1iXPPENTeNI/qsU9NY0jwm67ETwmT5TwFF7
         Khrwqhsq8xvj9jna33LA5ZFBdzutRU6taE9/RAnBS5P6Uq8RUNLS+uBxHvPUg1TVQCkG
         /0uZ3kCMKLd8w95Tblzj49D8TI3Jc8qJE1ehCQpcgPnDKRG8N2Y3GHRvM9WPZq+fOasg
         JCB97Wov+TGg5Cz2ni/dxikfeik0tr6A1r5+wS14DWF8caGBhyvrkcO+yaDEQuzdnCkE
         8oQJLjAeJoyUkRyXSDj9PWOnpwmr6NxLinsA7imM4VSC79K9EWu+vPzfpl2+NX8ZphND
         Wbyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=57ECND8nPavSh6NMH2Nmej1tsV8ESrkOIEhL0JKqaQg=;
        b=S/NvgMYi/gMHngV6FjVAXVr7pZsw/WU6k4p1icCY0nD4CojbTMXNDLxwlDTC2SB8h2
         hkzK7JT4/QbEZPxxbfpZmar92Z6p6PGIHlMwrhBw8AekCWIC7gU+2QYdNYAMQFTHHdDv
         CbFjzygfS1toDmEckhaEwaiZ5SFnEaRBx/mWisxfrIQyptsWMQeEfQ/bnhpeGFC38dbI
         PRQA9k+VSaufUbI2CeR4jPcIMjKfOd+dDMRYiuD15plVFxQK4r3ZnVRP/xXsByTczSVb
         z4cS1LGX4dk54gY6LQ6ivpY//uLcnvBeGJGhJZeJU5Hi6IT4uKqDq4t9HnuQzyLgly2w
         X22w==
X-Gm-Message-State: AOAM531uaQ3B4IfCvXWYwKuOb6+Ce1tx6xbPmvKYcg0jc2m11sR591w7
        JJJHcaXFNf1Mt0Px8HjYz0waUYLasiZ5zMV9
X-Google-Smtp-Source: ABdhPJyNYSADZiSauCmehE7HTmQIlKofXEvGKjy2Smi9Z8vqHtf++Pc6so2j6TVrdIqhg8h381Db2Q==
X-Received: by 2002:a63:d45:: with SMTP id 5mr18100732pgn.72.1621937058736;
        Tue, 25 May 2021 03:04:18 -0700 (PDT)
Received: from localhost.localdomain (122-117-179-2.HINET-IP.hinet.net. [122.117.179.2])
        by smtp.gmail.com with ESMTPSA id np1sm1586495pjb.13.2021.05.25.03.04.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 May 2021 03:04:18 -0700 (PDT)
From:   Axel Lin <axel.lin@ingics.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        linux-power@fi.rohmeurope.com, Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Axel Lin <axel.lin@ingics.com>
Subject: [PATCH] regulator: bd9576: Constify the voltage tables
Date:   Tue, 25 May 2021 18:04:05 +0800
Message-Id: <20210525100405.2506483-1-axel.lin@ingics.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Also use unsigned int instead of int for the voltage tables.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/regulator/bd9576-regulator.c | 34 ++++++++++++++++------------
 1 file changed, 20 insertions(+), 14 deletions(-)

diff --git a/drivers/regulator/bd9576-regulator.c b/drivers/regulator/bd9576-regulator.c
index 204a2da054f5..8e63169eebae 100644
--- a/drivers/regulator/bd9576-regulator.c
+++ b/drivers/regulator/bd9576-regulator.c
@@ -21,20 +21,26 @@
 #define BD957X_VOUTS4_BASE_VOLT	1030000
 #define BD957X_VOUTS34_NUM_VOLT	32
 
-static int vout1_volt_table[] = {5000000, 4900000, 4800000, 4700000, 4600000,
-				 4500000, 4500000, 4500000, 5000000, 5100000,
-				 5200000, 5300000, 5400000, 5500000, 5500000,
-				 5500000};
-
-static int vout2_volt_table[] = {1800000, 1780000, 1760000, 1740000, 1720000,
-				 1700000, 1680000, 1660000, 1800000, 1820000,
-				 1840000, 1860000, 1880000, 1900000, 1920000,
-				 1940000};
-
-static int voutl1_volt_table[] = {2500000, 2540000, 2580000, 2620000, 2660000,
-				  2700000, 2740000, 2780000, 2500000, 2460000,
-				  2420000, 2380000, 2340000, 2300000, 2260000,
-				  2220000};
+static const unsigned int vout1_volt_table[] = {
+	5000000, 4900000, 4800000, 4700000, 4600000,
+	4500000, 4500000, 4500000, 5000000, 5100000,
+	5200000, 5300000, 5400000, 5500000, 5500000,
+	5500000
+};
+
+static const unsigned int vout2_volt_table[] = {
+	1800000, 1780000, 1760000, 1740000, 1720000,
+	1700000, 1680000, 1660000, 1800000, 1820000,
+	1840000, 1860000, 1880000, 1900000, 1920000,
+	1940000
+};
+
+static const unsigned int voutl1_volt_table[] = {
+	2500000, 2540000, 2580000, 2620000, 2660000,
+	2700000, 2740000, 2780000, 2500000, 2460000,
+	2420000, 2380000, 2340000, 2300000, 2260000,
+	2220000
+};
 
 struct bd957x_regulator_data {
 	struct regulator_desc desc;
-- 
2.25.1

