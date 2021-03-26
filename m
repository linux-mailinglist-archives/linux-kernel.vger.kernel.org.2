Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C51334A9AA
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 15:25:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230293AbhCZOZL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Mar 2021 10:25:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229986AbhCZOZA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Mar 2021 10:25:00 -0400
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9145C0613AA
        for <linux-kernel@vger.kernel.org>; Fri, 26 Mar 2021 07:24:59 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id a11so4347109qto.2
        for <linux-kernel@vger.kernel.org>; Fri, 26 Mar 2021 07:24:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Ydwh/8tj9xjty9zBEBJ/Re07/emPoucIwHUjEe3A74A=;
        b=LJ3XkZB6rzqIf7eYYS/XKHa1JsKrB9VQ1+uAH62sr0AsHP5i0owoavBYpA0RU5/bBM
         JP/jsJ5tcvHgEymkHcQQ5T4oFD37yjyh1v1GZi4kxA8PQZRVd9oSTCuVn+9T99TeJGKH
         8GDktaI3ImgJRaqqj0wy9DuT2Y1oRFO4zXVE5tDYyUV3D/65QViNGRoUitXUw5VWmsrj
         QVyQpxiZjSBbbnGrqXsE6blDC/7v5rSItXg/F+Qtob+OoUb8O9KcZHk9ZDhdpmvYWINw
         ymoUvgSm6eZunFK0HGJxm7rm8WbRP5zTxhZncPauW+L8JH2uP2vzAUzyeD8YKqsmA1KN
         IUmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Ydwh/8tj9xjty9zBEBJ/Re07/emPoucIwHUjEe3A74A=;
        b=hpn3NF3LSrRT5sCZVbygQcy9b9a04E71WCTZlrPfRsxTwNjEqPay45fJZCxcKwSr3Z
         XmMbdwiuJfrIuzFoelUHWVqsOLWryTeSmc8SBtoW1kLyvwd1LOQznQUqF5l2EVUnr5j/
         bJBB46WkRh1wFzVQ7plGmWJskovQxFGWchTuxbk/OP5o7ihsIfGDm9Ks0HLk2s+4PNGh
         q3SN+V3NBvupyntKSXwUwvJd/KkFMCjjAaK/xeouV02teqfEpTSwclAP/SY83IKH7+iJ
         x8Xy/cQxfDQhpGhKnBumACZEcJDUBZn89EAHXj18s9uSEP2IOxU7NEl5HjXERsKH188U
         GXsg==
X-Gm-Message-State: AOAM531tZTVJKJ6e1wQnacF7YoYfoxNBGz+136ut92t47+9JVxmkb2qG
        e4j5Qspu7+65cqFULtZt9KA=
X-Google-Smtp-Source: ABdhPJwYVphBtqkllW+00k/srJBFGtTqM2NqfBjy/EVA46dNgrckmUgHMG7ZyEoWpYTeNtotVaOf5A==
X-Received: by 2002:ac8:1241:: with SMTP id g1mr12424762qtj.177.1616768699165;
        Fri, 26 Mar 2021 07:24:59 -0700 (PDT)
Received: from localhost.localdomain ([156.146.55.149])
        by smtp.gmail.com with ESMTPSA id b27sm6546112qkl.102.2021.03.26.07.24.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Mar 2021 07:24:58 -0700 (PDT)
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     suzuki.poulose@arm.com, leo.yan@linaro.org,
        gregkh@linuxfoundation.org, mathieu.poirier@linaro.org,
        unixbhaskar@gmail.com, linux-kernel@vger.kernel.org
Cc:     rdunlap@infradead.org
Subject: [PATCH] coresight-pmu.h: Fix a typo
Date:   Fri, 26 Mar 2021 19:52:44 +0530
Message-Id: <20210326142244.17504-1-unixbhaskar@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


s/orignally/originally/

Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
---
 include/linux/coresight-pmu.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/coresight-pmu.h b/include/linux/coresight-pmu.h
index 4ac5c081af93..2d5c29e3cb8a 100644
--- a/include/linux/coresight-pmu.h
+++ b/include/linux/coresight-pmu.h
@@ -14,7 +14,7 @@
  * Below are the definition of bit offsets for perf option, and works as
  * arbitrary values for all ETM versions.
  *
- * Most of them are orignally from ETMv3.5/PTM's ETMCR config, therefore,
+ * Most of them are originally from ETMv3.5/PTM's ETMCR config, therefore,
  * ETMv3.5/PTM doesn't define ETMCR config bits with prefix "ETM3_" and
  * directly use below macros as config bits.
  */
--
2.26.2

