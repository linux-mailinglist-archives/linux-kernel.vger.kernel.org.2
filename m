Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C2C142F5F5
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Oct 2021 16:44:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240679AbhJOOqp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Oct 2021 10:46:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240681AbhJOOqo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Oct 2021 10:46:44 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88011C061570
        for <linux-kernel@vger.kernel.org>; Fri, 15 Oct 2021 07:44:37 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id d9so38816288edh.5
        for <linux-kernel@vger.kernel.org>; Fri, 15 Oct 2021 07:44:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=v0AcRHxbsJqcdNBbA8ZycbNmfq6eGlGuizQ1L+4ECzU=;
        b=W+FWn4Mv/TO5KXHCMg0d0W+CHYKlkF/r179+o7IpLBUW+yvh+E4VDjXbrGum++Dwrr
         ZQnNzBqAEuA9LLXRqri1BiWxli+T3VZLszl85tGCbEWRihjJiAnlK1B8UXxDqmCAufsU
         P8VRPOjQwdKGO2y751hTEtPNOXIqPVhx2tabcBjJFXG4nvDaLyZSwnH1OVjFCcBPPTDf
         h3/SsqeVgD9hob784JuklDmox/3bRQwFNGsN/+O4Xls5bhJufOkrOeB6Mii9lzPCSnOQ
         6vAN6bvY0dH83IS2va0csRDBYQ7mKL/WYDrLWyFq70KW1nyt3uYMtTklBzkIU/YV1p3B
         zw4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=v0AcRHxbsJqcdNBbA8ZycbNmfq6eGlGuizQ1L+4ECzU=;
        b=7xBTTKsgZpR0lJ6jtb5oTunJeNaupz27kCKp8i4KGHBAj6SmE6NxXQgH5eVXhR/bE+
         HT37favaCIWtuml1YgNNunZe8icI8iN7fExiN/Cg/XUdpAEVPHm0zYHfg9EQ17dX8Wgp
         3j8ouHkMfViOKYVAAM0Og4NFNSSqFUAV9OgUn4SDqNUuJ8v5AWfBl5cCIlQBqbrBTRrD
         ReZ+hcw27eVL3b201xmbFTq6mcfDWAfbUHowvjxEFLpcDpb+V5djGHkHGRrCGR/EIO8a
         kod195B0X3woqOzf0UsBkEefbmF1BuYHJ0u3ApgDPHrmVKdjphUaCkQNbCxGFp+IaA2d
         /n4g==
X-Gm-Message-State: AOAM5321KFDnLGZAm+745QQ69jU0qu6Mc00CEarRthCsLleDDTwbq49o
        F3OCiK70aHVRLLpGh0XAFyIMmQ==
X-Google-Smtp-Source: ABdhPJxMzu0t5qDegUTfDOxUEMUyRNB4PVT0CnESzMIapKxxoTzk89iMSV5b32F6EzqnDZ4XfQgClQ==
X-Received: by 2002:a17:907:3353:: with SMTP id yr19mr7070455ejb.508.1634309032135;
        Fri, 15 Oct 2021 07:43:52 -0700 (PDT)
Received: from localhost.localdomain ([83.216.184.132])
        by smtp.gmail.com with ESMTPSA id v28sm4605365edx.21.2021.10.15.07.43.51
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 15 Oct 2021 07:43:51 -0700 (PDT)
From:   Paolo Valente <paolo.valente@linaro.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Paolo Valente <paolo.valente@linaro.org>,
        Grzegorz Kowal <custos.mentis@gmail.com>
Subject: [PATCH BUGFIX 1/1] block, bfq: reset last_bfqq_created on group change
Date:   Fri, 15 Oct 2021 16:43:36 +0200
Message-Id: <20211015144336.45894-2-paolo.valente@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20211015144336.45894-1-paolo.valente@linaro.org>
References: <20211015144336.45894-1-paolo.valente@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit 430a67f9d616 ("block, bfq: merge bursts of newly-created
queues"), BFQ maintains a per-group pointer to the last bfq_queue
created. If such a queue, say bfqq, happens to move to a different
group, then bfqq is no more a valid last bfq_queue created for its
previous group. That pointer must then be cleared. Not resetting such
a pointer may also cause UAF, if bfqq happens to also be freed after
being moved to a different group. This commit performs this missing
reset. As such it fixes commit 430a67f9d616 ("block, bfq: merge bursts
of newly-created queues").

Such a missing reset is most likely the cause of the crash reported in [1].
With some analysis, we found that this crash was due to the
above UAF. And such UAF did go away with this commit applied [1].

Anyway, before this commit, that crash happened to be triggered in
conjunction with commit 2d52c58b9c9b ("block, bfq: honor already-setup
queue merges"). The latter was then reverted by commit ebc69e897e17
("Revert "block, bfq: honor already-setup queue merges""). Yet commit
2d52c58b9c9b ("block, bfq: honor already-setup queue merges") contains
no error related with the above UAF, and can then be restored.

[1] https://bugzilla.kernel.org/show_bug.cgi?id=214503

Fixes: 430a67f9d616 ("block, bfq: merge bursts of newly-created queues")
Tested-by: Grzegorz Kowal <custos.mentis@gmail.com>
Signed-off-by: Paolo Valente <paolo.valente@linaro.org>
---
 block/bfq-cgroup.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/block/bfq-cgroup.c b/block/bfq-cgroup.c
index e2f14508f2d6..85b8e1c3a762 100644
--- a/block/bfq-cgroup.c
+++ b/block/bfq-cgroup.c
@@ -666,6 +666,12 @@ void bfq_bfqq_move(struct bfq_data *bfqd, struct bfq_queue *bfqq,
 		bfq_put_idle_entity(bfq_entity_service_tree(entity), entity);
 	bfqg_and_blkg_put(bfqq_group(bfqq));
 
+	if (entity->parent &&
+	    entity->parent->last_bfqq_created == bfqq)
+		entity->parent->last_bfqq_created = NULL;
+	else if (bfqd->last_bfqq_created == bfqq)
+		bfqd->last_bfqq_created = NULL;
+
 	entity->parent = bfqg->my_entity;
 	entity->sched_data = &bfqg->sched_data;
 	/* pin down bfqg and its associated blkg  */
-- 
2.20.1

