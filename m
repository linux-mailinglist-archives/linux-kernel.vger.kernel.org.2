Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA43836576C
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Apr 2021 13:21:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231915AbhDTLVN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Apr 2021 07:21:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231709AbhDTLVD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Apr 2021 07:21:03 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64685C06138A;
        Tue, 20 Apr 2021 04:20:32 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id i190so25313942pfc.12;
        Tue, 20 Apr 2021 04:20:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=GxLL6QnmEPTEzqADHSi/TrcJeIj4iMdkXLkWOx3ig7I=;
        b=f/GxmF//G+P7rb8pmjQBa4IVXX0FDe7U0Qpf6CzuPTbnlj8W6de+iMKco88AZrpQYG
         Ebnz0w00K96fChD1IQvQO4mkrz3MXU8MkwkQPaq/5lBRTPaxlsN5cvUlJYTpSB399BO5
         ksZqBfyuw0pnJF0dLMnQESNcMiMNg39jcqSn2BvYPz0mr6m3ChwPWwMSiYXRQT1wpY13
         gV5wzhhXOGgyscDj+H+UMNUkp/EDMPIgIdFvBKD6TtmxLLalLvAn/7kmumhhVDVgcCh7
         UQgQtCD2aiOxUC/KNxlPOfTi/ZsTVZY+I7qmR2GMSEv3vkWkXlHQ3gMONXUl4eP5SOgM
         e42Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=GxLL6QnmEPTEzqADHSi/TrcJeIj4iMdkXLkWOx3ig7I=;
        b=nEiKJ6tvy4+3Xz9c93w7M6bZ0YlutdyGdHYjxZFnrb29YYLK8iGy4DY2/EOZBqpXA6
         DTXt5mu5heamQTKMNHlpJflQ1qVLwUtmbzxWa/KlqDptrNnE1u0KDcYAjAXNcFFc98tF
         AliSY3EJDJI6c9UD3//n1Ut6H5jXo5/acufw25xc1gtEaM5sG45aORKvfJLhbH/AlFnX
         jyYnriOvA8bvL8UQrYrJ5R8OcbEMQtclkdBg2Hq5GyuXgqwZPeOl3HiKEk67IZCnpRvC
         CF92w191/ig89E/yrstHveifvidXzt8au7dj8K1jSq/FWYdfkMSq1MjEw3d7UYgGQVJJ
         rwFQ==
X-Gm-Message-State: AOAM533WkjSgNqdnbACobkBxzTHYJmxIJnJofocrnjuKZCgM0y1RVdxm
        DCeJRx8t54i5fjr77DMvSt0=
X-Google-Smtp-Source: ABdhPJyELyDhtylazbXz3zPw0msDvBjeWFZFvOQwjzR7F9AVpxWdDuI5ZBq2fwR1DM2L1ddT3f46Hg==
X-Received: by 2002:a65:4d4c:: with SMTP id j12mr16127000pgt.346.1618917632065;
        Tue, 20 Apr 2021 04:20:32 -0700 (PDT)
Received: from VM-0-3-centos.localdomain ([101.32.213.191])
        by smtp.gmail.com with ESMTPSA id s40sm14187367pfw.100.2021.04.20.04.20.30
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 20 Apr 2021 04:20:31 -0700 (PDT)
From:   brookxu <brookxu.cn@gmail.com>
To:     paolo.valente@linaro.org, axboe@kernel.dk, tj@kernel.org
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/8] bfq: limit the IO depth of CLASS_IDLE to 1
Date:   Tue, 20 Apr 2021 19:20:20 +0800
Message-Id: <34edd545a9f6f6b327fc6779fbd17fd3a519ed4c.1618916839.git.brookxu@tencent.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <cover.1618916839.git.brookxu@tencent.com>
References: <cover.1618916839.git.brookxu@tencent.com>
In-Reply-To: <cover.1618916839.git.brookxu@tencent.com>
References: <cover.1618916839.git.brookxu@tencent.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chunguang Xu <brookxu@tencent.com>

The IO depth of queues belong to CLASS_IDLE is limited to 1,
so that it can avoid introducing a larger tail latency under
a device with a larger IO depth. Although limiting the IO
depth may reduce the performance of idle_class, it is
generally not a big problem, because idle_class usually does
not have strict performance requirements.

Signed-off-by: Chunguang Xu <brookxu@tencent.com>
---
 block/bfq-iosched.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index ec482e6..29940ec 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -4808,6 +4808,17 @@ static struct request *__bfq_dispatch_request(struct blk_mq_hw_ctx *hctx)
 	if (!bfqq)
 		goto exit;
 
+	/*
+	 * Here, the IO depth of queues belong to CLASS_IDLE is limited
+	 * to 1, so that it can avoid introducing a larger tail latency
+	 * under a device with a larger IO depth. Although limiting the
+	 * IO depth may reduce the performance of idle_class, it is
+	 * generally not a big problem, because idle_class usually
+	 * does not have strict performance requirements.
+	 */
+	if (bfq_class_idle(bfqq) && bfqq->dispatched)
+		goto exit;
+
 	rq = bfq_dispatch_rq_from_bfqq(bfqd, bfqq);
 
 	if (rq) {
-- 
1.8.3.1

