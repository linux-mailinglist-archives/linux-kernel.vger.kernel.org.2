Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 522ED3ED34D
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Aug 2021 13:47:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236360AbhHPLsQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Aug 2021 07:48:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236272AbhHPLsN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Aug 2021 07:48:13 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E7C5C061764
        for <linux-kernel@vger.kernel.org>; Mon, 16 Aug 2021 04:47:41 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id h13so23229432wrp.1
        for <linux-kernel@vger.kernel.org>; Mon, 16 Aug 2021 04:47:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VHUfT+XcOecMxPt9gAEShVQ5wqUhNFG8PZTMlFZZDk8=;
        b=F3wqrgFMCoFl96cv3jJPZEF7i20q4s4b2pWd6RBU9iHO/dpgPZ11NAClTCuKr4LJGb
         8AiJz04c9lNMsXv459SzMN4+U6QcjiQfr/Sqk9+pdsVHG25hfHO+kta4ljJakjJKpgOf
         yEtrbmX69An8pI/qd1/0fSn1ZuolwloPSrybWCEyhsnn8RhlYJ1dtpjqiL6ujJqld6cv
         xu1uN6lNeLDEUMxt65Wlx3Lq8NFlPUC3y2AzYT1wD94Xexg0kvt0dmdWFJun9lNB1Req
         QsXHLmYQ6Br0hfBBMWNbwyF7Bc2cGf/0+nnBsoECHhlDekuLxTY0fdx3ef7SXC0xN152
         9AFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VHUfT+XcOecMxPt9gAEShVQ5wqUhNFG8PZTMlFZZDk8=;
        b=i+Eyvgb2eZEgTCnl8M5ge6RKKJc5JoUGKFp7/XUEc7uB3qoRVMLlqeEZ0iOdDjc2jN
         wL921+jYhmIcvL3940V2ylT4kLOAqmEmGdrfsMhXa7Yix2sbhsgk/ZtaX4buirXQ/4EM
         +TcwHwet4wbW36CffgWJwGl0R35zDqPW0412FeX3UhBpljGfqrdBRtqxY6E8ZHQQZj5S
         GysDtZsHFZPsFq0j1Oqp48y9qTwZOOc5xZfOqh02O+Iu/AbuPzIudSGA6WCBXhQkQYcF
         UUMaC0ttqKaJVwYkL/f0S3qFnWGfWdC/Sd5Ke//aIx3o6FzahpVuTB09/wMNW/h/vnqP
         0fLA==
X-Gm-Message-State: AOAM530s6EQVTtWA66Qz3kJwiL8OX/9QZ+KmQ0Lkf+4upEjk6NPdmRVJ
        pAi9cvZVBNfvAyZxnx6ElvbObg==
X-Google-Smtp-Source: ABdhPJzyELHaVPzn3E6DxQ6OwOuGWaUh3vYmoTdZA1ejekUcUsJl5TfB7PK5yogoTUM04JYOd/GWoA==
X-Received: by 2002:adf:a29c:: with SMTP id s28mr17596834wra.318.1629114460082;
        Mon, 16 Aug 2021 04:47:40 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e34:ed2f:f020:e1b0:48c1:6199:9cb4])
        by smtp.gmail.com with ESMTPSA id h9sm11360769wrv.84.2021.08.16.04.47.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Aug 2021 04:47:39 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     andriy.shevchenko@linux.intel.com, akpm@linux-foundation.org
Cc:     jic23@kernel.org, linux-kernel@vger.kernel.org, ceggers@arri.de,
        lukasz.luba@arm.com, myungjoo.ham@samsung.com,
        kyungmin.park@samsung.com, lars@metafoo.de, pmeerw@pmeerw.net,
        rui.zhang@intel.com, linux@roeck-us.net, miquel.raynal@bootlin.com,
        mcoquelin.stm32@gmail.com, rafael@kernel.org,
        daniel.lezcano@linaro.org
Subject: [PATCH v3 02/10] units: Add the HZ macros
Date:   Mon, 16 Aug 2021 13:47:24 +0200
Message-Id: <20210816114732.1834145-3-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210816114732.1834145-1-daniel.lezcano@linaro.org>
References: <20210816114732.1834145-1-daniel.lezcano@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The macros for the unit conversion for frequency are duplicated in
different places.

Provide these macros in the 'units' header, so they can be reused.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Reviewed-by: Christian Eggers <ceggers@arri.de>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 include/linux/units.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/linux/units.h b/include/linux/units.h
index ff51d3cfc6a0..8b8dc8a84d93 100644
--- a/include/linux/units.h
+++ b/include/linux/units.h
@@ -4,6 +4,10 @@
 
 #include <linux/math.h>
 
+#define HZ_PER_KHZ		1000UL
+#define KHZ_PER_MHZ		1000UL
+#define HZ_PER_MHZ		1000000UL
+
 #define MILLIWATT_PER_WATT	1000UL
 #define MICROWATT_PER_MILLIWATT	1000UL
 #define MICROWATT_PER_WATT	1000000UL
-- 
2.25.1

