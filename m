Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9AF683ED350
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Aug 2021 13:47:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236427AbhHPLsY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Aug 2021 07:48:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236346AbhHPLsR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Aug 2021 07:48:17 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF451C061764
        for <linux-kernel@vger.kernel.org>; Mon, 16 Aug 2021 04:47:45 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id x12so23140304wrr.11
        for <linux-kernel@vger.kernel.org>; Mon, 16 Aug 2021 04:47:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NgfWxpFAcx6Bo1F7gmbTO81OYebjpN4vWBapKz7vG0U=;
        b=F6iDcTUD9L8dW6SvQxfTQ5caDCQEd8+MKFEQE/e8hqQ/uec9L0wToXe3KTYhcF3Ogu
         Z663j54ELQ6l0l2vARdtOK0EQYVGIFdxkEEyl3ELkRAmHYsi/2DuUnGetuz5P0QiyIJY
         3tPNG3/HTsgIJAP4qAhxbQ9RarDKcXugBmkINGnzL6534lvUQLBjWOEKOWGLAYnFyP/X
         7u/pRD4TtRrcTFD+SBiScRxG+yxenaqZQgpmk+z68UaQe4kllolezVmzm9VUlKMsAvQ3
         5/jBWsKuY3iY6XzTZeEH1lu2+tfUPjwrxjsXnAbup4732HrToGI5oUIfHrMJs5hHOA9Z
         wEzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NgfWxpFAcx6Bo1F7gmbTO81OYebjpN4vWBapKz7vG0U=;
        b=idXf5BBoSv0p3eGFMYU8tvWugOd3hJvXyVoOpfY9XSE9tNX95fx5HnpvYdGTvyEXaf
         9LQxwP3W2NDHK21h78BrJx3JUSA7TdEnZxFs2moH5ZvuEzBq6DzZfXH7axj22F4hakde
         7PWCsoqtwSJQxGEgdY9oCuuM9NxS6pDDjs07zfAAob6w8FFoAcg51IZJJoNBzAbUwqSw
         RIO+IamPCYvYSoLlotnOrLqK7QW6CQ+KvF1x8Z8m2HVfulYNVoxEKQiqgiLvrjj0Vc04
         YUbKWxFlx0OeFR0WgMuN6FHhE/SQqvWnyNaHsG4rVtPdL6qyGkKawINsgFblxrAZz07p
         OXTA==
X-Gm-Message-State: AOAM530r8fvl0/JoXoOrssthCVOrlRkvWzRYtUcKqUBAcKsJtqmLNz/v
        LZ3z76Mv5eVgnjPoAqIwo9HY9A==
X-Google-Smtp-Source: ABdhPJxq8f38EoMFyx8avcOLWZlHd45gaOTPYJu3P75rACWNuhrpb6MMOWEf4xzB12msPU7qmwHS4g==
X-Received: by 2002:adf:e107:: with SMTP id t7mr18081214wrz.165.1629114464351;
        Mon, 16 Aug 2021 04:47:44 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e34:ed2f:f020:e1b0:48c1:6199:9cb4])
        by smtp.gmail.com with ESMTPSA id h9sm11360769wrv.84.2021.08.16.04.47.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Aug 2021 04:47:43 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     andriy.shevchenko@linux.intel.com, akpm@linux-foundation.org
Cc:     jic23@kernel.org, linux-kernel@vger.kernel.org, ceggers@arri.de,
        lukasz.luba@arm.com, myungjoo.ham@samsung.com,
        kyungmin.park@samsung.com, lars@metafoo.de, pmeerw@pmeerw.net,
        rui.zhang@intel.com, linux@roeck-us.net, miquel.raynal@bootlin.com,
        mcoquelin.stm32@gmail.com, rafael@kernel.org,
        daniel.lezcano@linaro.org
Subject: [PATCH v3 05/10] iio/drivers/as73211: Use HZ macros
Date:   Mon, 16 Aug 2021 13:47:27 +0200
Message-Id: <20210816114732.1834145-6-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210816114732.1834145-1-daniel.lezcano@linaro.org>
References: <20210816114732.1834145-1-daniel.lezcano@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

HZ unit conversion macros are available in units.h, use them and
remove the duplicate definition.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Reviewed-by: Christian Eggers <ceggers@arri.de>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
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
2.25.1

