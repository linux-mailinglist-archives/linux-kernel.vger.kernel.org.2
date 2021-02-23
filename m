Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0596B323223
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Feb 2021 21:32:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233555AbhBWUbJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Feb 2021 15:31:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231742AbhBWUbE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Feb 2021 15:31:04 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1925C061574
        for <linux-kernel@vger.kernel.org>; Tue, 23 Feb 2021 12:30:23 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id y17so2337568wrs.12
        for <linux-kernel@vger.kernel.org>; Tue, 23 Feb 2021 12:30:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=vQEhhF0/dKLq0SjYrCKXmLIv+2+DjFtHParA2D5ObMA=;
        b=modC1kQJcTwgsN7k9QXOJpFuRQ6sWfaOJjFQ6W+nP0vIGwHjnaYSVAyKPH2xlq43+7
         8St99fOs6itFtjy3T6O/Ff7HkBxwzz3hKFqKukTLRPtQwdBFp800hzgyttg8LxdKiZA0
         63cKiAcSKMiSFrsrCqBMPbGS4LZQ9RrH/LH6og/r6hT86oI2EPU37yLOVFkfAi2Pi5gF
         ZPlUNLWMYJOMtq3iJ3g4XTkUntoV4dDHJ+6UJxQA1bM6sqZ9z7EFhZWzspRdhg8wHGOK
         kz/Jj9ob8XbNNn8FrygY2JosehB3ezSO8jbFAP2lE5ynctIeFwr/r4myMoIKHWXA8vIs
         WzpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=vQEhhF0/dKLq0SjYrCKXmLIv+2+DjFtHParA2D5ObMA=;
        b=JZNd5Gr5bR/83HW8CjnMz4CPLUUOnx0THtZ6chFJU9RekbQAeC0BVKtXoqYEqv/Cs3
         YDfE5liN/6r29GupDGFBygxMYPu0k/qvMm9VBj8RSD7UePFtZi+QdRnTYnqMYbar12Sz
         /+6rZGRvkimn8giULwPEO4+GeecGiyIZdC9DflC6ztEj4IqFJveJ8TwOlWTVNatH3MTz
         p5nurxDpwqHteFhqKv3rveLQnpvCt1LyDjO4K85zl8fCUQOrQHU4zpImtM/cUSXo6k8l
         jhPIrWjcduVknv0MKvqFIPJRm028WW64wEY4rWzrr+O18Apr/2tUJVl8hSlXM9dd4wnv
         zgJQ==
X-Gm-Message-State: AOAM532259kvm524eGOpUyyLp1QYuDmjnLUOK4vNPR9osgWzTEY++j5I
        uzFdlMa+DYAg4iKsjZWMwJp8sA==
X-Google-Smtp-Source: ABdhPJwT+s7YViOE/TANTDz5FHNTMv6ZObW5lEtgL0d5I1mrIwvSCE513bve3SfiXI5bZEJXrmF12g==
X-Received: by 2002:a5d:638a:: with SMTP id p10mr3260480wru.286.1614112222500;
        Tue, 23 Feb 2021 12:30:22 -0800 (PST)
Received: from localhost.localdomain (lns-bzn-59-82-252-157-252.adsl.proxad.net. [82.252.157.252])
        by smtp.gmail.com with ESMTPSA id p3sm18288936wro.55.2021.02.23.12.30.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Feb 2021 12:30:22 -0800 (PST)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     rafael@kernel.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Lukasz Luba <lukasz.luba@arm.com>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 1/2] units: Add the HZ_PER_KHZ macro
Date:   Tue, 23 Feb 2021 21:30:01 +0100
Message-Id: <20210223203004.7219-1-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The macro for the unit conversion for frequency is duplicated in
different places.

Provide this macro in the 'units' header, so it can be reused.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 include/linux/units.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/linux/units.h b/include/linux/units.h
index dcc30a53fa93..218ec0d314b6 100644
--- a/include/linux/units.h
+++ b/include/linux/units.h
@@ -4,6 +4,10 @@
 
 #include <linux/math.h>
 
+#define HZ_PER_KHZ		1000L
+#define KHZ_PER_MHZ		1000L
+#define HZ_PER_MHZ		1000000L
+
 #define MILLIWATT_PER_WATT	1000L
 #define MICROWATT_PER_MILLIWATT	1000L
 #define MICROWATT_PER_WATT	1000000L
-- 
2.17.1

