Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F08D420337
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Oct 2021 20:06:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231329AbhJCSIB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Oct 2021 14:08:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230519AbhJCSH7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Oct 2021 14:07:59 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 608AFC0613EC
        for <linux-kernel@vger.kernel.org>; Sun,  3 Oct 2021 11:06:12 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id kk10so677369pjb.1
        for <linux-kernel@vger.kernel.org>; Sun, 03 Oct 2021 11:06:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mG+zemwwv/PEnxn5fB8MDaZgwWqnn7KiJnaQFklCUgU=;
        b=osp0pIgsLLBY6jwEUqtKhsh47rVmxvd919RXWdOfdi6dEMnADelVwcfXNLQH7Oed+A
         4X06OlfZBeVa9tGbmZ6DRqRjvqHBWM2kvd95ON8cyquc1XdlTFRnwrKP8TVbwISIjzJL
         Gh4Tu5yh9ZrfsljRQaizRH2fzdbvaA/yIKYe1RPyN0uXHcnxokjNKC13NZd44PTi67ih
         qL+GpJwa8H2wyVHnCLPngnw9RqtsNhcdKqyKBlso0SmNdj/ko5mLf7mPOoWOjVXnGF/l
         ijVmH7i18ngy5s8hjvVvQJrF3OLG0YangDag+jdqkjlMqfrobY77bdWJdycThqG3/5nP
         Wdjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mG+zemwwv/PEnxn5fB8MDaZgwWqnn7KiJnaQFklCUgU=;
        b=yOndvCrYy2Iu8oDED+t3aZSeLvw4oqqjB2gvisPi5YycPXBniknpXeD9M9o7OcF1/f
         xZZV9zehKwC0vJO0bWZcXtxAPvShUrsLo3ElrDmKiE+x0vXlOuoP6dq/rlS3IT1gwpXi
         qihl5IaZ4nveCEZUybQmFeoeue9NazIAr3k3yhRF0nva9T99oTxmCoHmFVmc0s27jTHI
         Y/WlqC+zp3Dc6NDOU8cML8zlmR9upgwQkc1SjYdWqu8aJLAYQ5MqtmCxAY/ImMAzqpG8
         Pbk+uVrQdSJ3lBmrKyLav6w3gDHYTURML/zlGkJobpsK2qqLKCx/Z9NjBbdCYsFMCwOC
         l39w==
X-Gm-Message-State: AOAM531evEoGGRfUOXNLmx1Vcr3TsagYp1H0nxbIBmOBV2/3orlgibFG
        HFr6MTGQxKP3NWCo07AGR8I=
X-Google-Smtp-Source: ABdhPJzow93dsqjqz8ohtGZG4eNHi2JAR2hmBdTK91dnmD9pCAehKlhlx33VdzTXgzdJ/I/cQqw49g==
X-Received: by 2002:a17:90a:6405:: with SMTP id g5mr31815606pjj.71.1633284371902;
        Sun, 03 Oct 2021 11:06:11 -0700 (PDT)
Received: from athena.bbrouter ([1.186.54.48])
        by smtp.googlemail.com with ESMTPSA id z12sm10596327pjb.52.2021.10.03.11.06.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Oct 2021 11:06:11 -0700 (PDT)
From:   "Gautham R. Shenoy" <gautham.shenoy@gmail.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>
Cc:     linux-kernel@vger.kernel.org,
        "Gautham R. Shenoy" <gautham.shenoy@gmail.com>
Subject: [PATCH (trivial)] sched/fair : Fix the comment for rebalance_domains()
Date:   Sun,  3 Oct 2021 23:35:22 +0530
Message-Id: <20211003180522.13294-1-gautham.shenoy@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The function init_sched_domains() was renamed to sched_init_domains()
by the commit 8d5dc5126bb2 ("sched/topology: Small cleanup"). However,
the comment prior to rebalance_domains() still refers to
init_sched_domains(). Fix the comment to refer to the current name of
the function.

Signed-off-by: Gautham R. Shenoy <gautham.shenoy@gmail.com>
---
 kernel/sched/fair.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 8943dbb94365..93facfb9b974 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -10211,7 +10211,7 @@ void update_max_interval(void)
  * It checks each scheduling domain to see if it is due to be balanced,
  * and initiates a balancing operation if so.
  *
- * Balancing parameters are set up in init_sched_domains.
+ * Balancing parameters are set up in sched_init_domains.
  */
 static void rebalance_domains(struct rq *rq, enum cpu_idle_type idle)
 {
-- 
2.25.1

