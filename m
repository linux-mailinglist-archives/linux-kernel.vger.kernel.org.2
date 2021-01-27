Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A9CA305AF7
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 13:15:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237203AbhA0MNR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 07:13:17 -0500
Received: from a1.mail.mailgun.net ([198.61.254.60]:19185 "EHLO
        a1.mail.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237628AbhA0MHy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 07:07:54 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1611749251; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=EqiDWjPo+X9wccaEmeGJTMQUAbJMu5ihEcMoZw5OG6c=; b=hhmntpo+WHr9bTENO5TwxIx2hzvZJ1pGTDqkVQXmBbKbbOvv3DIW+Gz/xA8wtzgP1qm4auI7
 Tg+pJz3OdrhbvWYXPE2Ev3QOJt/ren5/KtClw4iZBc8YJhjz+HcaT51g5B7ICAwfrYIs5rjC
 LzjTgMHpjC7+bz8qhCxQSj+Z5pU=
X-Mailgun-Sending-Ip: 198.61.254.60
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n03.prod.us-east-1.postgun.com with SMTP id
 601157602c36b2106d78913e (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 27 Jan 2021 12:06:56
 GMT
Sender: vjitta=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 8D592C43461; Wed, 27 Jan 2021 12:06:55 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from vjitta-linux.qualcomm.com (unknown [202.46.22.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: vjitta)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id DEC7CC433CA;
        Wed, 27 Jan 2021 12:06:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org DEC7CC433CA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=vjitta@codeaurora.org
From:   vjitta@codeaurora.org
To:     minchan@kernel.org, glider@google.com, akpm@linux-foundation.org,
        dan.j.williams@intel.com, broonie@kernel.org, mhiramat@kernel.org
Cc:     linux-kernel@vger.kernel.org, vjitta@codeaurora.org,
        ylal@codeaurora.org, vinmenon@codeaurora.org
Subject: [PATCH v6 1/2] lib: stackdepot: Add support to configure STACK_HASH_SIZE
Date:   Wed, 27 Jan 2021 17:36:37 +0530
Message-Id: <1611749198-24316-1-git-send-email-vjitta@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yogesh Lal <ylal@codeaurora.org>

Use CONFIG_STACK_HASH_ORDER to configure STACK_HASH_SIZE.

Aim is to have configurable value for  STACK_HASH_SIZE,
so depend on use case one can configure it.

One example is of Page Owner, CONFIG_PAGE_OWNER works only
if page_owner=on via kernel parameter on CONFIG_PAGE_OWNER
configured system. Thus, unless admin enable it via command
line option, the stackdepot will just waste 8M memory without
any customer.

Making it configurable and use lower value helps to enable
features like CONFIG_PAGE_OWNER without any significant overhead.

Signed-off-by: Yogesh Lal <ylal@codeaurora.org>
Signed-off-by: Vinayak Menon <vinmenon@codeaurora.org>
Signed-off-by: Vijayanand Jitta <vjitta@codeaurora.org>
Reviewed-by: Minchan Kim <minchan@kernel.org>
Reviewed-by: Alexander Potapenko <glider@google.com>
---
 lib/Kconfig      | 9 +++++++++
 lib/stackdepot.c | 3 +--
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/lib/Kconfig b/lib/Kconfig
index b46a9fd..96ee125 100644
--- a/lib/Kconfig
+++ b/lib/Kconfig
@@ -651,6 +651,15 @@ config STACKDEPOT
 	bool
 	select STACKTRACE
 
+config STACK_HASH_ORDER
+	int "stack depot hash size (12 => 4KB, 20 => 1024KB)"
+	range 12 20
+	default 20
+	depends on STACKDEPOT
+	help
+	 Select the hash size as a power of 2 for the stackdepot hash table.
+	 Choose a lower value to reduce the memory impact.
+
 config SBITMAP
 	bool
 
diff --git a/lib/stackdepot.c b/lib/stackdepot.c
index 2caffc6..dff8521 100644
--- a/lib/stackdepot.c
+++ b/lib/stackdepot.c
@@ -142,8 +142,7 @@ static struct stack_record *depot_alloc_stack(unsigned long *entries, int size,
 	return stack;
 }
 
-#define STACK_HASH_ORDER 20
-#define STACK_HASH_SIZE (1L << STACK_HASH_ORDER)
+#define STACK_HASH_SIZE (1L << CONFIG_STACK_HASH_ORDER)
 #define STACK_HASH_MASK (STACK_HASH_SIZE - 1)
 #define STACK_HASH_SEED 0x9747b28c
 
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
2.7.4

