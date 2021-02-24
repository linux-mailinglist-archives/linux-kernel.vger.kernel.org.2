Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B08EF3240C1
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Feb 2021 16:30:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238567AbhBXPYu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Feb 2021 10:24:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235736AbhBXOqm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Feb 2021 09:46:42 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF1AFC0617AA
        for <linux-kernel@vger.kernel.org>; Wed, 24 Feb 2021 06:42:43 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id r3so2118383wro.9
        for <linux-kernel@vger.kernel.org>; Wed, 24 Feb 2021 06:42:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=HokQBU/ghtYugnhNg9omsYh8OE2+9P/WNHGHi5BtboA=;
        b=EFfGqrAUxLxs7rxfUGLf3i6T0VC0f+RwiaqLbB/jSzDZBUoP4NqhOPE15LATWpYsWu
         wyCdt8bFHnke7XVmgeJGm+xmNPRt6umRxgbeH2ROMIi40CWAaPeGQQbCUUy32P4uPMuR
         69K5T1+51WIuUOHX4zeD9uZ/R6SjJcgAVQJ5OAqN88SNJDE++cYVRfLmEWV1QLhzhsA5
         OjYpdcQngjNlMagS3tPN8FBtVMJFFCQAm4DWEmbx2CWy72bBEJ2WACe/5GiyHxrjfcJH
         RbAV5FfcJMuFoImHof3PGbkGfXTow6vgLF9inyz0MySlJngEZp2AUyODX6PH4V/cqsD3
         yV2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=HokQBU/ghtYugnhNg9omsYh8OE2+9P/WNHGHi5BtboA=;
        b=NFV2kurW1JHZk2zVE7dfP4+5tEryFWeGUv1xaouSThxJ2iKuCOnh9JlSzr4mnJ18dW
         1wkRV6hnhzTRKN6Km33R7om2+cSJPR5dU5kCSi/N2ruyIxjRNxlo0qKBloEwoYZyL6sI
         s/t0ZtanMTPkQECa2DAOSC52wKkMlukzhCdH06MFc09OAIIgClwKvdPwUw1Vt6g+7Kav
         spNw9RAAk1vjMYZWBSOxvpCvzeOTMsncgZgnSugol0/P9r3o6S7VJ9L50csGaRUZXpae
         HPvVkuTEx34b0mAAJcXm/FNurTnzpca2ZhkhEOrUn/mjnR3sj6u0THZgd282TVk90zr2
         ZxAA==
X-Gm-Message-State: AOAM531GD6GNHJK7j5NBhSos9zsuHsi8OAunkwHH+3IGiEC245DR1EBE
        NBRGeGdAXYW+/HwV7XM3C6SYdA==
X-Google-Smtp-Source: ABdhPJxeswn6KrlSUcAY2vMoNAOfRftd8Gvei+4zong6S8ryra1+kdYb1YpVaIJ1rIGpAYoBHuhx1w==
X-Received: by 2002:adf:f6cd:: with SMTP id y13mr11491952wrp.309.1614177762464;
        Wed, 24 Feb 2021 06:42:42 -0800 (PST)
Received: from localhost.localdomain (lns-bzn-59-82-252-157-252.adsl.proxad.net. [82.252.157.252])
        by smtp.gmail.com with ESMTPSA id p3sm4170669wro.55.2021.02.24.06.42.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Feb 2021 06:42:41 -0800 (PST)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     rafael@kernel.org, andriy.shevchenko@linux.intel.com
Cc:     linux-kernel@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org (open list:IIO SUBSYSTEM AND DRIVERS)
Subject: [PATCH v2 6/9] iio/drivers/hid-sensor: Use HZ macros
Date:   Wed, 24 Feb 2021 15:42:16 +0100
Message-Id: <20210224144222.23762-6-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210224144222.23762-1-daniel.lezcano@linaro.org>
References: <20210224144222.23762-1-daniel.lezcano@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

HZ unit conversion macros are available in units.h, use them and
remove the duplicate definition.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/iio/common/hid-sensors/hid-sensor-attributes.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/iio/common/hid-sensors/hid-sensor-attributes.c b/drivers/iio/common/hid-sensors/hid-sensor-attributes.c
index 442ff787f7af..dda3b67e494f 100644
--- a/drivers/iio/common/hid-sensors/hid-sensor-attributes.c
+++ b/drivers/iio/common/hid-sensors/hid-sensor-attributes.c
@@ -11,13 +11,12 @@
 #include <linux/kernel.h>
 #include <linux/slab.h>
 #include <linux/time.h>
+#include <linux/units.h>
 
 #include <linux/hid-sensor-hub.h>
 #include <linux/iio/iio.h>
 #include <linux/iio/sysfs.h>
 
-#define HZ_PER_MHZ	1000000L
-
 static struct {
 	u32 usage_id;
 	int unit; /* 0 for default others from HID sensor spec */
-- 
2.17.1

