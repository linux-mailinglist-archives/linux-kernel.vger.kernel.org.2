Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80A43436FFE
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Oct 2021 04:29:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232384AbhJVCba (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Oct 2021 22:31:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232296AbhJVCb0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Oct 2021 22:31:26 -0400
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57DC8C061224
        for <linux-kernel@vger.kernel.org>; Thu, 21 Oct 2021 19:29:09 -0700 (PDT)
Received: by mail-pf1-x44a.google.com with SMTP id t12-20020a056a00138c00b0044d255ba434so1444578pfg.17
        for <linux-kernel@vger.kernel.org>; Thu, 21 Oct 2021 19:29:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=ppyPwtt5n85t9ULlL3N3xlbKIm0Tw6nUJj2XNXuvqyM=;
        b=pE3noKnzPMT7teGJLrQJpn1gerl+AMcHg8Dbs1ag4fUvRBlJzJBG1sTYH11At0gW5o
         R7uU9pewISmYZsLVrahy3kEnTTNgqNSBFQ/QbU5jbtpIdMdKgjKkShAyYskfrpkKw/fr
         OTcN5LaTiIED26DSiYM9gIp6bM3rXpMdDePStxu6+IGqGTj7ze+uXuBxzbGwbyzxykED
         ER6WL42eFjN2Yo7Pin9BJFAkR7J+t3V7h54btZqtwiFVbArkuPXH1ZMDqqOMvvGLsOsg
         FSYzpGLw9b0/AUKDpizj8flGmTwlSQyS1nqYv45S+YZ10Pzn/9cDsxLp5EYzE/wsJaaF
         1BNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=ppyPwtt5n85t9ULlL3N3xlbKIm0Tw6nUJj2XNXuvqyM=;
        b=dMcEbvBK4nr9qP3swTe5k8jpqVpnmcAF1l9uy/pJ+NTV9xjhaPWYACHr6MPQICcSNW
         ZjS34Um/EfGnUm6F90zmeu6Pmi/6JGS1DUIdOpjS+Zo560zkkvFfa3f4OtJAx3Vv0NZm
         PYoR+Im4CJQ4PZ6iEQclE4BriATNGOKFDGnrjKuwMoZL2MBv7QR/t0txqpymuU3gjqlD
         86qXj+vybgiH0zdX5e84qzz2VAAijxH0psDi0JC1Ap5PoWIM4lBEFWQG3nX/191j7+Nd
         u51KSxa4SJpNqwENJ5LDPtgi97VaS8rbgYw78y5rfIIHcdF+xByQwNcgUguTCcD/mufq
         9UaA==
X-Gm-Message-State: AOAM531FIFKhYowB/UbIZdQBG4sc1QeR8wf+iLJr6FaVNRBAzcI5uD/t
        ExicMen6r650VioJoOgkKOUniWBAd2XH
X-Google-Smtp-Source: ABdhPJwQAVpfNpKQ2duOM0MLmXlIIPimsq+Dsm9f51VuSfRwP2v4psGr6i7e6lSzKHwLnSB3acJA8MnzeCdn
X-Received: from rajat2.mtv.corp.google.com ([2620:15c:202:201:cc25:d9a3:4b5:37b9])
 (user=rajatja job=sendgmr) by 2002:a17:902:db0e:b0:13e:f4d3:84c with SMTP id
 m14-20020a170902db0e00b0013ef4d3084cmr8682802plx.2.1634869748751; Thu, 21 Oct
 2021 19:29:08 -0700 (PDT)
Date:   Thu, 21 Oct 2021 19:28:58 -0700
In-Reply-To: <20211022022859.1888836-1-rajatja@google.com>
Message-Id: <20211022022859.1888836-3-rajatja@google.com>
Mime-Version: 1.0
References: <20211022022859.1888836-1-rajatja@google.com>
X-Mailer: git-send-email 2.33.0.1079.g6e70778dc9-goog
Subject: [PATCH 2/3] i2c: enable async suspend/resume for i2c adapters
From:   Rajat Jain <rajatja@google.com>
To:     Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Wolfram Sang <wsa@kernel.org>, linux-i2c@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        dtor@google.com
Cc:     Rajat Jain <rajatja@google.com>, rajatxjain@gmail.com,
        dbasehore@chromium.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable async suspend/resume of i2c adapters. It enormously helps with
reducing the resume time of systems (as much as 20%-40%) where I2C devices
can take significant time (100s of ms) to resume.

Signed-off-by: Rajat Jain <rajatja@google.com>
---
 drivers/i2c/i2c-core-base.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/i2c/i2c-core-base.c b/drivers/i2c/i2c-core-base.c
index 54964fbe3f03..8d4f2be54e17 100644
--- a/drivers/i2c/i2c-core-base.c
+++ b/drivers/i2c/i2c-core-base.c
@@ -1576,6 +1576,7 @@ static int i2c_register_adapter(struct i2c_adapter *adap)
 	if (res)
 		goto out_reg;
 
+	device_enable_async_suspend(&adap->dev);
 	pm_runtime_no_callbacks(&adap->dev);
 	pm_suspend_ignore_children(&adap->dev, true);
 	pm_runtime_enable(&adap->dev);
-- 
2.33.0.1079.g6e70778dc9-goog

