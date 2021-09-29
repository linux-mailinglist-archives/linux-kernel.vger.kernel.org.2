Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80A2E41CC4C
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Sep 2021 21:06:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346388AbhI2THi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Sep 2021 15:07:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244887AbhI2THh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Sep 2021 15:07:37 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08675C06161C
        for <linux-kernel@vger.kernel.org>; Wed, 29 Sep 2021 12:05:56 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id p20-20020a25d814000000b005b6a75a370cso4737453ybg.14
        for <linux-kernel@vger.kernel.org>; Wed, 29 Sep 2021 12:05:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=dGvsdehaCfU+q8mM5gCc9rOf0ufeFm/BjPG12OnT8ao=;
        b=nxryhbopP8wCQGLugzS4weXpMDdfM0hbU4s3GPu6Jhv6OBVZtQxqRdPxWTna1CI6i1
         0jfwzAZZb5H5MQackBSm92VrbxhRVwTFWBkA6Z8Srx0G3WiRzCILW9fHEeT94aknCu0m
         ESp5Ousi9x7PaVzYXGr2h1KPsJV0UuUv1ELr0AsHzV6LWxkEh5O06rgE/Ej73cOncrbg
         PMkjAe8gKQSFtco9y5jzbzAX6/0SZyk112cdjwBOHW5uvW0elqEbTxpWUR1oir2FfMX6
         7vsvAvbAgiGmDGtwCXIt3ULLQrlE6p5DqPJJVErbAdL7Lb1gwxGPvZlE3rMHmYaElOr9
         GYug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=dGvsdehaCfU+q8mM5gCc9rOf0ufeFm/BjPG12OnT8ao=;
        b=qjDjKq/2lsbCbd6zXgSD+lFpxXFCMFplGjd7UEMba0zHhza/JN+2NOTvPWbHyR5Vp2
         hJ+XKnaL7Na0Vw43fgHscZOoF/eGVBLjGt0aH/GYxPh4MQBsRfTFKXhnOBxRzFf6rnPF
         PCdD1vPrMpWpuBhdR6MNQOdSKnDy4tg8iCaw6A2Lph/zc7fs7Vw5GaLAJVB5rubkpNMI
         atSYS5c0j2vbnMEqq6RZlNMFla/zPhMlC9FKV2nq0R27Ri5nBYN/FCj+qv1Wh/iXhrRg
         UnlbzaKRE6Tw6vAXjJYatQNxOwVK06SreQW1JLDPYUiyRqVPs1TEdV+e2yUT1VJq4pqY
         zTOw==
X-Gm-Message-State: AOAM531Bn/Cq31CtqVhQyqY8vWVRdae8tt4IjdHIBmlIANDvT2b63UGB
        SSKOuUzvCVQtu86OIfk1wHcpI4lXmjRW+Qk=
X-Google-Smtp-Source: ABdhPJwsnFWoD2ZJtHWFRv11jrueWzuCt2Dl/3t78BcWP6WQaMsROvMdZUTEv9JC4sMHxNJ+A2ojIK1zNl2WZys=
X-Received: from saravanak.san.corp.google.com ([2620:15c:2d:3:1dea:d6fb:56d7:8fff])
 (user=saravanak job=sendgmr) by 2002:a25:b11b:: with SMTP id
 g27mr1704690ybj.13.1632942355211; Wed, 29 Sep 2021 12:05:55 -0700 (PDT)
Date:   Wed, 29 Sep 2021 12:05:49 -0700
Message-Id: <20210929190549.860541-1-saravanak@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.33.0.685.g46640cef36-goog
Subject: [PATCH v2] driver core: Reject pointless SYNC_STATE_ONLY device links
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
v1 -> v2:
- Moved the check higher up in the function.

 drivers/base/core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index 15986cc2fe5e..249da496581a 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -687,7 +687,8 @@ struct device_link *device_link_add(struct device *consumer,
 {
 	struct device_link *link;
 
-	if (!consumer || !supplier || flags & ~DL_ADD_VALID_FLAGS ||
+	if (!consumer || !supplier || consumer == supplier ||
+	    flags & ~DL_ADD_VALID_FLAGS ||
 	    (flags & DL_FLAG_STATELESS && flags & DL_MANAGED_LINK_FLAGS) ||
 	    (flags & DL_FLAG_SYNC_STATE_ONLY &&
 	     (flags & ~DL_FLAG_INFERRED) != DL_FLAG_SYNC_STATE_ONLY) ||
-- 
2.33.0.685.g46640cef36-goog

