Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8E0C436FFF
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Oct 2021 04:29:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232403AbhJVCbc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Oct 2021 22:31:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232180AbhJVCb2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Oct 2021 22:31:28 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D6B5C061348
        for <linux-kernel@vger.kernel.org>; Thu, 21 Oct 2021 19:29:11 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id x15-20020a056902102f00b005ba71cd7dbfso2555026ybt.8
        for <linux-kernel@vger.kernel.org>; Thu, 21 Oct 2021 19:29:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=vzQUdY93uV17R+6G8Th/GOFeC3+4FEsDpxtXXZhhmgs=;
        b=EPIcE6GvBrjKsPNVxqqaat57B6owyW5X9cDEKMMaYE5XhESc6lpKEvdWUNG0dER35X
         FHOm3sNngnTML67qiPsr0gA7n0eWOvDoBP8hC+tiGqedyJtDPZ+jkATU6IDPGyzSpdPU
         NbJWkyOUg9XPE7fn5D49t3EoOu7Um3pcnKf7+z1Hz9exsuB7aPb6gTdLaEkWYqgf8noC
         qw+ViDwKtml5G0uo34mjRJKuAaV4tgRruirbP4fgNBGKP4+Jzl9McgTrVIYJLfIinoMA
         PopNitr9a/qIOW3ijuCd3+bLRPpJg2y6+wJextWbG++TfsNpqWT/g635MYbSfGxx3aF5
         V8vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=vzQUdY93uV17R+6G8Th/GOFeC3+4FEsDpxtXXZhhmgs=;
        b=QcjogQvJX+2vYXDFAYI5DScUxynWlaAYneIAWL+VYgKEkMDXvSf7pVeUoWxPyNA5gJ
         tDjRaCW+RZtapwl7SAt2kIgWsoeT+5mL8iFpXeAYmswNhjG/VgWIFFTaPM5qwvlz7oAu
         nl5MVjZ1FNhScrQvkoKl6m8hzcI5fcWrZHDNHCmgw7FmmciX8eqm5Cfe2Ju1zjyuRwJC
         XdKM2HEcBMJTnAq3vLJ5WY5VOYx1X17m2bAGjxzghwoUU9oc9tufZDYbao4NQcWwFSGP
         rfXu1m9Hee+bzmxbRMmM8gajQWLbBccNmRJeEjK5IJnhFjEm6nIKV8KxLgxOI5ZmL/w2
         0UYQ==
X-Gm-Message-State: AOAM533OQBLu2M18ZX6yT41vtB7pwrO26opQuW1cQp6lSBiElOoM0TIj
        A78GwqkoqEdn4+aXDRTLvC6QcX6UUpm0
X-Google-Smtp-Source: ABdhPJw45Ku+iLqKDAWxLO0IAZK55UZm/2cUJLCsdnPLHrj29/HH5/+WviiQLyP3gWnZQiylvF/+8VEm0WXJ
X-Received: from rajat2.mtv.corp.google.com ([2620:15c:202:201:cc25:d9a3:4b5:37b9])
 (user=rajatja job=sendgmr) by 2002:a25:1c08:: with SMTP id
 c8mr10660210ybc.316.1634869750638; Thu, 21 Oct 2021 19:29:10 -0700 (PDT)
Date:   Thu, 21 Oct 2021 19:28:59 -0700
In-Reply-To: <20211022022859.1888836-1-rajatja@google.com>
Message-Id: <20211022022859.1888836-4-rajatja@google.com>
Mime-Version: 1.0
References: <20211022022859.1888836-1-rajatja@google.com>
X-Mailer: git-send-email 2.33.0.1079.g6e70778dc9-goog
Subject: [PATCH 3/3] i2c: enable async suspend/resume on i2c client devices
From:   Rajat Jain <rajatja@google.com>
To:     Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Wolfram Sang <wsa@kernel.org>, linux-i2c@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        dtor@google.com
Cc:     Derek Basehore <dbasehore@chromium.org>, rajatxjain@gmail.com,
        Rajat Jain <rajatja@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Derek Basehore <dbasehore@chromium.org>

This enables the async suspend for i2c client devices. This reduces
the suspend/resume time considerably on platforms where i2c devices
can take a lot of time (hundreds of ms) to resume.

Signed-off-by: Derek Basehore <dbasehore@chromium.org>
Signed-off-by: Rajat Jain <rajatja@google.com>
---
 drivers/i2c/i2c-core-base.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/i2c/i2c-core-base.c b/drivers/i2c/i2c-core-base.c
index 8d4f2be54e17..70d32efb68ef 100644
--- a/drivers/i2c/i2c-core-base.c
+++ b/drivers/i2c/i2c-core-base.c
@@ -1047,6 +1047,7 @@ i2c_new_client_device(struct i2c_adapter *adap, struct i2c_board_info const *inf
 	client->dev.of_node = of_node_get(info->of_node);
 	client->dev.fwnode = info->fwnode;
 
+	device_enable_async_suspend(&client->dev);
 	i2c_dev_set_name(adap, client, info);
 
 	if (info->swnode) {
-- 
2.33.0.1079.g6e70778dc9-goog

