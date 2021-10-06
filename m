Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2EEFD4249A4
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Oct 2021 00:26:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239856AbhJFW2b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Oct 2021 18:28:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239817AbhJFW2X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Oct 2021 18:28:23 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 204DCC061746
        for <linux-kernel@vger.kernel.org>; Wed,  6 Oct 2021 15:26:31 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id d8so15409437edx.9
        for <linux-kernel@vger.kernel.org>; Wed, 06 Oct 2021 15:26:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lBZYT0fhynhFvmY+AbwXQGydUT7ySSicpN9jOqgvImg=;
        b=lstI2MGlJ7D7jpGC7HmVZpxW8fF077c6BdnmKqCr9IXUzy7typsKPC6zIj3Gx9TVsd
         A7SCcy38xQqzTlIya1rOLDEV6pZ3aR0JoPgI4FGvCx0xEVHL4e3t1XIb72XUAuB2ylsd
         cyjwBcn4JRVa55f9xjJf0O8tIYTzYYRrMEOrk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lBZYT0fhynhFvmY+AbwXQGydUT7ySSicpN9jOqgvImg=;
        b=pJfYDqUvjl2P5qb+dAVy1OH961nxNQyncq+OaOYj8GYavIP7qlX2QUbIQea9I50BlH
         0nl7ma+wC/xA73/TAJJhXy+oArDNaHk9TzZKFSMi0I/ZahAIEDOgb1O9xTWL1FI9mjn3
         i1ujgzuR7cOQwT0+ZAa9fHk6mbiHkBAlFKWDD9zpuyJEAInSD09i/nD3w+WJFnkus5et
         Uzchq4J5OFv1t78u7uz8crgmyfWmlDjSfdq1s/91bt7vlHvmtHhm8Pxz15IkrHk+zcmz
         Ik7gryNeSKx4sU8a1bS4FRYkS9etFf/WwB1i5I7fUXsa9q8ZOlE7koDIO9dYQ6in45H1
         lX+A==
X-Gm-Message-State: AOAM533crNqPJaLoWihV/mof4FpPjpmV9bW0YOOnXg8Jmmv9Rupj1bAr
        OGA6OsuQG60Ne5YJWDU1gRsaGw==
X-Google-Smtp-Source: ABdhPJwk3aPerTQI0yJXxNUsq/JsuRAvSywQe/juC1BH42Fq2XW3TRN0kVXzNDXJCgNzj+2ibJ4RXw==
X-Received: by 2002:a17:906:2a8f:: with SMTP id l15mr1170490eje.156.1633559189771;
        Wed, 06 Oct 2021 15:26:29 -0700 (PDT)
Received: from alco.lan (80.71.134.83.ipv4.parknet.dk. [80.71.134.83])
        by smtp.gmail.com with ESMTPSA id h7sm10557906edt.37.2021.10.06.15.26.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Oct 2021 15:26:29 -0700 (PDT)
From:   Ricardo Ribalda <ribalda@chromium.org>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Yong Zhi <yong.zhi@intel.com>,
        Bingbu Cao <bingbu.cao@intel.com>, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Chiranjeevi Rapolu <chiranjeevi.rapolu@intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>
Cc:     Ricardo Ribalda <ribalda@chromium.org>
Subject: [PATCH v4 4/8] media: ipu3-imgu: imgu_fmt: Handle properly try
Date:   Thu,  7 Oct 2021 00:26:21 +0200
Message-Id: <20211006222625.401122-5-ribalda@chromium.org>
X-Mailer: git-send-email 2.33.0.800.g4c38ced690-goog
In-Reply-To: <20211006222625.401122-1-ribalda@chromium.org>
References: <20211006222625.401122-1-ribalda@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For a try_fmt call, the node noes not need to be enabled.

Fixes v4l2-compliance

fail: v4l2-test-formats.cpp(717): Video Output Multiplanar is valid, but
				  no TRY_FMT was implemented
test VIDIOC_TRY_FMT: FAIL

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/staging/media/ipu3/ipu3-v4l2.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/media/ipu3/ipu3-v4l2.c b/drivers/staging/media/ipu3/ipu3-v4l2.c
index d9f7a854d68c..69ef820619ab 100644
--- a/drivers/staging/media/ipu3/ipu3-v4l2.c
+++ b/drivers/staging/media/ipu3/ipu3-v4l2.c
@@ -696,7 +696,7 @@ static int imgu_fmt(struct imgu_device *imgu, unsigned int pipe, int node,
 
 		/* CSS expects some format on OUT queue */
 		if (i != IPU3_CSS_QUEUE_OUT &&
-		    !imgu_pipe->nodes[inode].enabled) {
+		    !imgu_pipe->nodes[inode].enabled && !try) {
 			fmts[i] = NULL;
 			continue;
 		}
-- 
2.33.0.800.g4c38ced690-goog

