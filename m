Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A17D241BBEB
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Sep 2021 02:51:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243510AbhI2Aws (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Sep 2021 20:52:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243501AbhI2Awr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Sep 2021 20:52:47 -0400
Received: from mail-qt1-x84a.google.com (mail-qt1-x84a.google.com [IPv6:2607:f8b0:4864:20::84a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D866C06161C
        for <linux-kernel@vger.kernel.org>; Tue, 28 Sep 2021 17:51:07 -0700 (PDT)
Received: by mail-qt1-x84a.google.com with SMTP id 61-20020aed2143000000b002a6a0f52ce7so3184942qtc.0
        for <linux-kernel@vger.kernel.org>; Tue, 28 Sep 2021 17:51:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=0fbgzU17/L6gCSctp5uafuGxGxUSFOjn6R3vNJQW8SI=;
        b=GfkC/QnM0arXkNMHt73wpj2b2QOkl6k8E8l9xDDjT4vKjuEtJv7mzYmWmsz5yldmRO
         UnX5dyhPB4u5A3k1y7o2/Eeaf/V0WiB7+wmAr9yST1HkkEape0U5CjHC5vrajomJdfk+
         Oz/3OatMJcG5MfzinSbIEebyyszmlHLj345yZPvHYyTWHIxkZZa+81Nf193JlPnGRmbo
         CSSw5QGKRytyXZWCw4VlCJ8pldXa9T+4uF4fvDgRjooxpJG61R3bVXt2+deZdtM0uAJ2
         0ge9TzgUFyUgetZXR2pNmo8PZXYzuI413PANn19xtnROVnnVX3lMAGln1Zg2xrGfzTVD
         cvYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=0fbgzU17/L6gCSctp5uafuGxGxUSFOjn6R3vNJQW8SI=;
        b=evllcxhSrIKhnhHFQnVvYBfe7zE93Z7gx6/lVwGeULFFRYpyLSE/reeS2RxGWruMUc
         wN/MBaiGVuppIWTptCyqcSXPBSh1hyZHmir/eCpRiQCJq4IR08asAP8LQMxj5/Dnartp
         KOEgFovYXpGOr0L2xHGr9Ayl/+9kyEJn9u2546mmwt1Z3DkOtuFgDv4roXsdFWxvtoqF
         z0dTOuqk60MVnZyh90qEy2V0fbnjJ0D6iU10qLjBVLPy+Xe8kUSh/YukZQZSkNLkSzzL
         XJaBawPt0I+EOxGpp8R4PuDieYQoRk7NqrGykEkRjf5sMchiZ0C5sd92pG5EjfT/dQ2r
         GaqA==
X-Gm-Message-State: AOAM533a9ign2sVTvFmKDH5oklcG89B5WqAph91qqH5bvItG/HFiAEBx
        gnKY2dOERnnlwtB2S4o6tMtH1dbN3EGcqVM=
X-Google-Smtp-Source: ABdhPJyjfKK7fxOV+7Ngi9SQrqA9b0TnYQPSv0g73SlQF0G+JamXVey1jXdRafQ4zNsm7kLZLsBWXjzX63R7KB0=
X-Received: from saravanak.san.corp.google.com ([2620:15c:2d:3:5241:a7e9:90c9:9c91])
 (user=saravanak job=sendgmr) by 2002:a0c:e1ce:: with SMTP id
 v14mr8752533qvl.28.1632876666449; Tue, 28 Sep 2021 17:51:06 -0700 (PDT)
Date:   Tue, 28 Sep 2021 17:51:02 -0700
Message-Id: <20210929005103.698172-1-saravanak@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.33.0.685.g46640cef36-goog
Subject: [PATCH v1] driver core: Reject pointless SYNC_STATE_ONLY device links
From:   Saravana Kannan <saravanak@google.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Saravana Kannan <saravanak@google.com>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>, kernel-team@android.com,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SYNC_STATE_ONLY device links intentionally allow cycles because cyclic
sync_state() dependencies are valid and necessary.

However a SYNC_STATE_ONLY device link where the consumer and the supplier
are the same device is pointless because the device link would be deleted
as soon as the device probes (because it's also the consumer) and won't
affect when the sync_state() callback is called. It's a waste of CPU cycles
and memory to create this device link. So reject any attempts to create
such a device link.

Fixes: 05ef983e0d65 ("driver core: Add device link support for SYNC_STATE_ONLY flag")
Reported-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Saravana Kannan <saravanak@google.com>
---
 drivers/base/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index 15986cc2fe5e..eed27933ac4d 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -716,7 +716,7 @@ struct device_link *device_link_add(struct device *consumer,
 	 * SYNC_STATE_ONLY link, we don't check for reverse dependencies
 	 * because it only affects sync_state() callbacks.
 	 */
-	if (!device_pm_initialized(supplier)
+	if (!device_pm_initialized(supplier) || consumer == supplier
 	    || (!(flags & DL_FLAG_SYNC_STATE_ONLY) &&
 		  device_is_dependent(consumer, supplier))) {
 		link = NULL;
-- 
2.33.0.685.g46640cef36-goog

