Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30B1B3240C2
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Feb 2021 16:30:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238586AbhBXPZC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Feb 2021 10:25:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235732AbhBXOqm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Feb 2021 09:46:42 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C877BC061793
        for <linux-kernel@vger.kernel.org>; Wed, 24 Feb 2021 06:42:38 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id l12so2141957wry.2
        for <linux-kernel@vger.kernel.org>; Wed, 24 Feb 2021 06:42:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=RlLY69dl0FNKKcCh7g/+fwlPd3uLKJlhP5Zykbo8eos=;
        b=mPYPZVu/FfUNUfxpNy7RV3MqNsdIWmrMQYP8/qAU8NR0URMVo7rV/JNEYEpXp9v1X8
         EpRvph7XIQGY2L56Q/ouJ3UbI09/HlGmhzxVEXpjZur9VVbpXaZszc8gWsQZtllzQS+k
         LoMdCAGpXKpjAe30zFN6pD/YdMxTJ9oRzEp61cmHfRx51M+M7GrZVmhQSAFA/wi2tjQB
         NotVbXtcnDwdQBHUrVKkgjo8QHAFG1AmG0sYTeDoebk9N+4ZhQPxcfjzQU4EB85lYVi7
         I0hsnfMNRHdtX2DJNyuICQjF4+AwdmZVr8NLj1moHdpr3EE3QJ/quccOfqj8BwvImcza
         NVyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=RlLY69dl0FNKKcCh7g/+fwlPd3uLKJlhP5Zykbo8eos=;
        b=DaRhraR6T3mMqFgk5PcvkpItLQOK8IuEDShw5Ydi6bo/N7ZJJOAlmy+hT8OmOKZtna
         tHvq8Xidb8flir0dYpqK4m0iiV10xpwrZXAsCZa7sMKNwBcgm8CfOtVnHVUjiA9C5ss5
         Dmh861s7IhCNU4knko1ftALoqhcV63YQqsI6bJ3jMHLnEAxPZ5lN7Eejq1wYtz9RvhW/
         tFRFxdXVbvbYRgNW+FpQWUdAAiJugYQ/UudhQnsd/byCk2lK0ZGQ6Q5YMn1h4gB6TF8j
         toQz+VrHL79KP9V4T2g92RQKbjB94W6eWO4SApTbsX7v8kDhivl0CFUNKRd6MF3qVK9i
         qmWA==
X-Gm-Message-State: AOAM531c/1tp9Mwe0mELzaMLOk9HzzsazGcdCS1pU45txgksutbBmx1z
        b7tVlA4nwY2R+WA077+ZHjugzw==
X-Google-Smtp-Source: ABdhPJwcXbOVFQ7pcprfedminlYKezPtRgM8WYzRegU/uPGj0NJQ8H65qUeZOEh+uRBtDy+jVjsO7g==
X-Received: by 2002:a5d:63d2:: with SMTP id c18mr529839wrw.277.1614177757504;
        Wed, 24 Feb 2021 06:42:37 -0800 (PST)
Received: from localhost.localdomain (lns-bzn-59-82-252-157-252.adsl.proxad.net. [82.252.157.252])
        by smtp.gmail.com with ESMTPSA id p3sm4170669wro.55.2021.02.24.06.42.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Feb 2021 06:42:37 -0800 (PST)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     rafael@kernel.org, andriy.shevchenko@linux.intel.com
Cc:     linux-kernel@vger.kernel.org, Christian Eggers <ceggers@arri.de>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org (open list:AMS AS73211 DRIVER)
Subject: [PATCH v2 4/9] iio/drivers/as73211: Use HZ macros
Date:   Wed, 24 Feb 2021 15:42:14 +0100
Message-Id: <20210224144222.23762-4-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210224144222.23762-1-daniel.lezcano@linaro.org>
References: <20210224144222.23762-1-daniel.lezcano@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

HZ unit conversion macros are available in units.h, use them and
remove the duplicate definition.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Reviewed-by: Christian Eggers <ceggers@arri.de>
---
 drivers/iio/light/as73211.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/iio/light/as73211.c b/drivers/iio/light/as73211.c
index 7b32dfaee9b3..3ba2378df3dd 100644
--- a/drivers/iio/light/as73211.c
+++ b/drivers/iio/light/as73211.c
@@ -24,8 +24,7 @@
 #include <linux/module.h>
 #include <linux/mutex.h>
 #include <linux/pm.h>
-
-#define HZ_PER_KHZ 1000
+#include <linux/units.h>
 
 #define AS73211_DRV_NAME "as73211"
 
-- 
2.17.1

