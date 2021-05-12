Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5AC137EB81
	for <lists+linux-kernel@lfdr.de>; Thu, 13 May 2021 00:20:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380776AbhELTcc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 May 2021 15:32:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346489AbhELRNg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 May 2021 13:13:36 -0400
Received: from mail-qv1-xf4a.google.com (mail-qv1-xf4a.google.com [IPv6:2607:f8b0:4864:20::f4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1EFBC0612F1
        for <linux-kernel@vger.kernel.org>; Wed, 12 May 2021 10:10:46 -0700 (PDT)
Received: by mail-qv1-xf4a.google.com with SMTP id d11-20020a0cdb0b0000b02901c0da4391d5so19536008qvk.12
        for <linux-kernel@vger.kernel.org>; Wed, 12 May 2021 10:10:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=PXODettiudEJAl3QLXIii2j1h/vSRPebc7EbOxNgBmo=;
        b=f98rcg/95teB9HFcgpwBS7gGtFdesugKlc5az7RUWdj441yY/U8zMdfxVK8Zkpo7rd
         Oxn6Sntph6Hmg1Cpn2M5Y5UAjvi6ieUKIkZPJx2cCbZAq4pPyUBhbHY79YZH3TMtpSnA
         GU5H2LNalltyeVYhNgn4sRgmtu5RLyA3dXhtX8NmJDQW0RYjrwNPSZJW9nl6ecU6ZabY
         pQ6UdtyVzvnAqklH0DiCHOwtx69aNkTR9CldOgjvv5vJcbDtqK7hwnbWSUjQcYIc/veY
         oEz15GJN7DVPXzI1ajyCrYnFcGHObtuc58dn0q7hz4tb34Y42Czd5K/XNvWShCf1gv3u
         WPqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=PXODettiudEJAl3QLXIii2j1h/vSRPebc7EbOxNgBmo=;
        b=EvS5wojBh4H+8myJsLxvbwOz0aHw9PbC8phhIXaafT2/l3U45CN40PDW4TePyBq0h6
         hyFwaKucGIW1yE0m5hbylWHTNuKv8v84e45tIxZHNlf11rQRS0o1pL/Ip0RZjPDn7sVM
         Aio9uMnCrYHxJfVKhVvU9w8k4N5RQO5U/pWmYZapl5L6LUbs7XVZatNoxogYTSMqau+D
         13VNDG581N3PyRcWXNdHvcKZB/rQ/6XAZmyRwexY4F+hwLfe+6upGMbWuR07sJ4rYT5W
         wCx3YHgCjqiqSyxv9CEZaqcfm6hKfPYSJQsCXtEfNVb+sZN4JGXqlep63BHMX1atKinx
         0Jjg==
X-Gm-Message-State: AOAM532yNYUlPLh6NqKK1cFAzD0R8Su9sTV0GEQQG4Gr/H8eBAC8bDJh
        GVAWK4FH6nsO7be0ES53ufQihEeeBXbXupnm
X-Google-Smtp-Source: ABdhPJzomWSMXPl3e1djwKEST9tCuVHZ8Yg+H7hpq6SMi1Z1tZy8PzyAYUndQbpCcuEuhm3wdxQGHNVN7MYj72pF
X-Received: from chu-dev-docker.c.googlers.com ([fda3:e722:ac3:10:7f:e700:c0a8:80f])
 (user=linchuyuan job=sendgmr) by 2002:a05:6214:30a:: with SMTP id
 i10mr9734120qvu.42.1620839446135; Wed, 12 May 2021 10:10:46 -0700 (PDT)
Date:   Wed, 12 May 2021 17:10:43 +0000
Message-Id: <20210512171043.2433694-1-linchuyuan@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.31.1.607.g51e8a6a459-goog
Subject: [PATCH] hwmon: adm1272: enable adm1272 temperature reporting
From:   Chu Lin <linchuyuan@google.com>
To:     linchuyuan@gmail.com, jasonling@google.com, zhongqil@google.com,
        linux@roeck-us.net, jdelvare@suse.com, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Chu Lin <linchuyuan@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

adm1272 supports temperature reporting but it is disabled by default.

Tested:
ls temp1_*
temp1_crit           temp1_highest        temp1_max
temp1_crit_alarm     temp1_input          temp1_max_alarm

cat temp1_input
26642

Signed-off-by: Chu Lin <linchuyuan@google.com>
---
 drivers/hwmon/pmbus/adm1275.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/hwmon/pmbus/adm1275.c b/drivers/hwmon/pmbus/adm1275.c
index e7997f37b266..0be1b5777d2f 100644
--- a/drivers/hwmon/pmbus/adm1275.c
+++ b/drivers/hwmon/pmbus/adm1275.c
@@ -611,11 +611,13 @@ static int adm1275_probe(struct i2c_client *client)
 		tindex = 8;
 
 		info->func[0] |= PMBUS_HAVE_PIN | PMBUS_HAVE_STATUS_INPUT |
-			PMBUS_HAVE_VOUT | PMBUS_HAVE_STATUS_VOUT;
+			PMBUS_HAVE_VOUT | PMBUS_HAVE_STATUS_VOUT |
+			PMBUS_HAVE_TEMP | PMBUS_HAVE_STATUS_TEMP;
 
-		/* Enable VOUT if not enabled (it is disabled by default) */
-		if (!(config & ADM1278_VOUT_EN)) {
-			config |= ADM1278_VOUT_EN;
+		/* Enable VOUT & TEMP1 if not enabled (disabled by default) */
+		if ((config & (ADM1278_VOUT_EN | ADM1278_TEMP1_EN)) !=
+		    (ADM1278_VOUT_EN | ADM1278_TEMP1_EN)) {
+			config |= ADM1278_VOUT_EN | ADM1278_TEMP1_EN;
 			ret = i2c_smbus_write_byte_data(client,
 							ADM1275_PMON_CONFIG,
 							config);
@@ -625,10 +627,6 @@ static int adm1275_probe(struct i2c_client *client)
 				return -ENODEV;
 			}
 		}
-
-		if (config & ADM1278_TEMP1_EN)
-			info->func[0] |=
-				PMBUS_HAVE_TEMP | PMBUS_HAVE_STATUS_TEMP;
 		if (config & ADM1278_VIN_EN)
 			info->func[0] |= PMBUS_HAVE_VIN;
 		break;
-- 
2.31.1.607.g51e8a6a459-goog

