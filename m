Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 985923DF289
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Aug 2021 18:27:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232252AbhHCQ2E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Aug 2021 12:28:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230444AbhHCQ2D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Aug 2021 12:28:03 -0400
Received: from mail-ua1-x949.google.com (mail-ua1-x949.google.com [IPv6:2607:f8b0:4864:20::949])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16066C061757
        for <linux-kernel@vger.kernel.org>; Tue,  3 Aug 2021 09:27:52 -0700 (PDT)
Received: by mail-ua1-x949.google.com with SMTP id 45-20020a9f22b00000b02902a181c33654so6999171uan.17
        for <linux-kernel@vger.kernel.org>; Tue, 03 Aug 2021 09:27:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=xcdKF8i+1pu0QNFs/CMj/QlbcYnCiXlJVcu/eX7qzmA=;
        b=CDSVRMYu8PSUpk6wXSGgxDIylWEUQV7uQzOuxqGrq6n0tgPQd2W0RFZOnVOxBvdxir
         gYRgbUaTHxCsok5NpNLumXsW4YYuMOpMhE+7hlw8qV8PO3BsgEoqwzTynXpVxLh0Vg3L
         piAw3z8mIuS2s/I2Mzc6xOnmf7QgcROFGj9y0HAq7JtQKgAYkOBZUexckEC9vBrSOWru
         rFswTei9yVyVDXBAVtPiVHTPRKg0NMRKhBgF4EL9OapKJneE3GT/CjhpHUFTvsrtSQ6y
         JueRWQhWJdxRH3rxaZbH8OxqV5zTNMUczOu/1YYPovzGRNPhz7XFARnwmspjkf1KQ2qJ
         fWqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=xcdKF8i+1pu0QNFs/CMj/QlbcYnCiXlJVcu/eX7qzmA=;
        b=FNqlx8et42DMxJH3pYZD/GZGxdgAlIuUQekx47uwuX0Ag3JmyFr7RBFrygu+F4oWTT
         CG+tEdkCACRjvTbzVfx233OpRbjd0Mno8zi35II9b8VoU0K861WTdsaj6ycg6n0Xe38e
         kw6ra8uBwroDFXjXEgLUR1uksL9mSsygJu2W3TBCubm1SvlWwTUdBo+03xA7tSQx1zU9
         waQGwfj7b+3YLQMZAdy73+9ju64L6KTtKFE4LV0DVeAhei43TY+gI1WcJrLRcpCWoFZV
         bNs/8lL/TJgbjCbK7vJkibJGvSquBOCwPdUcmano1Bw5L6OZHVv4G39dDZMzw2RygeNG
         Dw/w==
X-Gm-Message-State: AOAM532qt9JMvqQ27htPh+rbI1kwGc8EghoFr9zM+L9t5kHHgRQbb17E
        tnLb8Es8bfDVD2a90M3a7OrYQkXm0i2gKPYcJ9SqEg==
X-Google-Smtp-Source: ABdhPJxsaBO5bT9DJe8VDIih1GPLXi/ilvOGO3DGbzQD4MwzK7Y64T1x11HpjLMWoXXaZ/XE0IOI2QJdeYjNCHI2RLROtg==
X-Received: from mustash.c.googlers.com ([fda3:e722:ac3:cc00:14:4d90:c0a8:337b])
 (user=richardsonnick job=sendgmr) by 2002:a05:6122:1692:: with SMTP id
 18mr13264491vkl.20.1628008071226; Tue, 03 Aug 2021 09:27:51 -0700 (PDT)
Date:   Tue,  3 Aug 2021 16:27:35 +0000
In-Reply-To: <47e01747a5c648c8809c77055e981e80@huawei.com>
Message-Id: <20210803162739.2363542-1-richardsonnick@google.com>
Mime-Version: 1.0
References: <47e01747a5c648c8809c77055e981e80@huawei.com>
X-Mailer: git-send-email 2.32.0.554.ge1b32706d8-goog
Subject: [PATCH v4] pktgen: Remove redundant clone_skb override
From:   Nicholas Richardson <richardsonnick@google.com>
To:     davem@davemloft.net, kuba@kernel.org
Cc:     nrrichar@ncsu.edu, arunkaly@google.com,
        Nick Richardson <richardsonnick@google.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Leesoo Ahn <dev@ooseel.net>, Ye Bin <yebin10@huawei.com>,
        Di Zhu <zhudi21@huawei.com>,
        Yejune Deng <yejune.deng@gmail.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nick Richardson <richardsonnick@google.com>

When the netif_receive xmit_mode is set, a line is supposed to set
clone_skb to a default 0 value. This line is made redundant due to a
preceding line that checks if clone_skb is more than zero and returns
-ENOTSUPP.

Overriding clone_skb to 0 does not make any difference to the behavior
because if it was positive we return error. So it can be either 0 or
negative, and in both cases the behavior is the same.

Remove redundant line that sets clone_skb to zero.

Signed-off-by: Nick Richardson <richardsonnick@google.com>
---
 net/core/pktgen.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/net/core/pktgen.c b/net/core/pktgen.c
index 7e258d255e90..314f97acf39d 100644
--- a/net/core/pktgen.c
+++ b/net/core/pktgen.c
@@ -1190,11 +1190,6 @@ static ssize_t pktgen_if_write(struct file *file,
 			 * pktgen_xmit() is called
 			 */
 			pkt_dev->last_ok = 1;
-
-			/* override clone_skb if user passed default value
-			 * at module loading time
-			 */
-			pkt_dev->clone_skb = 0;
 		} else if (strcmp(f, "queue_xmit") == 0) {
 			pkt_dev->xmit_mode = M_QUEUE_XMIT;
 			pkt_dev->last_ok = 1;
-- 
2.32.0.554.ge1b32706d8-goog

