Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2ABA376466
	for <lists+linux-kernel@lfdr.de>; Fri,  7 May 2021 13:22:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235296AbhEGLXf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 May 2021 07:23:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231932AbhEGLXe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 May 2021 07:23:34 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E25AC061574
        for <linux-kernel@vger.kernel.org>; Fri,  7 May 2021 04:22:34 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id p4so7428949pfo.3
        for <linux-kernel@vger.kernel.org>; Fri, 07 May 2021 04:22:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uK5+osygTfkJECGuaQ+nf52n4LESXipwFidcOnVuOn4=;
        b=AlxWGWw5gQDh5aTMudgFgWrKU2Vs4fxblXRW1OLs2CrR0BmTI/19GqMeMczJH2UGU9
         e7Df96ZYdCQ3zU+xXdumrkxhhzmEtrO4W9iZJJR5dEPMRuaTphe86Ci/WZUjz3Daw5Uq
         QmmFy/lkhp8HzgGFbane5k89NVNG3hJcQRjRzpvVCsT6D0orASgeMz/a5juAgbvom4Hb
         Kh3EegoMoQ2BcUfMBsUKvBz2HcAZXNId4+hDt+mZL62cz/nMc5I8e2U0wD9YYPpZIeSz
         r8RBw6mPBuPcpAkaYEKABFSw04bXE062AKNYLt2jwNejLuCK2jDJP+mg9mcg1BpOFBxD
         YFvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uK5+osygTfkJECGuaQ+nf52n4LESXipwFidcOnVuOn4=;
        b=PNNeHR7V0WTtVdH0mIIVmq1eJmLw8aaQDdDAzPCeI2hzi8FDstkKK3Xkg+olN3GEsQ
         iMpnGZY96aLaomyNLrvv9Pd3HfYzv2ZPTFC4Ke/FnadHNz9QGznaHABp0/yMNbx95ejw
         8aEqgRhJOZu8IS2NaKlsrpu1jff7YEmFNNc73dx+uGx/Ukn+qQYcipeNm2mRkMZtz9EL
         GC8hl6Uh6o5E51hgXHF0rW8E4OrZ9kps6VaQc+o5a6osYuKMDdKIolE7GwW0u+tCszFx
         qe1uOHPgsHKj0gE/pM6HrQQLUCXL9dheGfoHIhS4GB7xKqxx5ANf1ag0K9HiMRMWHUQc
         rCJw==
X-Gm-Message-State: AOAM531091M8eofJUmgdFbRmi2o/rh0xbn39X60dMG/vMjsrNK/YPvta
        d3jG/QEV/abaL8DVGnsVf9I=
X-Google-Smtp-Source: ABdhPJyZVE7WlBD2DzfN96Q7lgT6lkh7IbfoIBCm6Lv3qVZGFSgTH/vVuv21a6yoAhkdQvnyMloFbw==
X-Received: by 2002:a05:6a00:c3:b029:28e:d284:c39f with SMTP id e3-20020a056a0000c3b029028ed284c39fmr9859820pfj.4.1620386553798;
        Fri, 07 May 2021 04:22:33 -0700 (PDT)
Received: from bj10918pcu.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id t19sm4372633pgv.75.2021.05.07.04.22.30
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 May 2021 04:22:33 -0700 (PDT)
From:   Xuewen Yan <xuewen.yan94@gmail.com>
To:     vincent.donnefort@arm.com, mingo@redhat.com, peterz@infradead.org,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com
Cc:     rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, linux-kernel@vger.kernel.org,
        zhang.lyra@gmail.com, xuewyan@foxmail.com
Subject: [PATCH v2] sched/pelt: Keep UTIL_AVG_UNCHANGED flag in sync when calculating last_enqueued_diff
Date:   Fri,  7 May 2021 19:20:31 +0800
Message-Id: <20210507112031.23073-1-xuewen.yan94@gmail.com>
X-Mailer: git-send-email 2.29.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xuewen Yan <xuewen.yan@unisoc.com>

Last_enqueued_diff's meaning: "diff = util_est.enqueued(p) - task_util(p)".
When calculating last_enqueued_diff, we add UTIL_AVG_UNCHANGED flag, which
is the LSB, for task_util, but don't add the flag for util_est.enqueued.
However the enqueued's flag had been cleared when the task util changed.
As a result, we add +1 to the diff, this is therefore reducing slightly
UTIL_EST_MARGIN.

Add the flag for util_est.enqueued to have a accurate computation.

Fixes: b89997aa88f0b sched/pelt: Fix task util_est update filtering

Signed-off-by: Xuewen Yan <xuewen.yan@unisoc.com>
---
 kernel/sched/fair.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index e5e457fa9dc8..94d77b4fa601 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -3996,7 +3996,7 @@ static inline void util_est_update(struct cfs_rq *cfs_rq,
 	if (ue.enqueued & UTIL_AVG_UNCHANGED)
 		return;
 
-	last_enqueued_diff = ue.enqueued;
+	last_enqueued_diff = (ue.enqueued | UTIL_AVG_UNCHANGED);
 
 	/*
 	 * Reset EWMA on utilization increases, the moving average is used only
-- 
2.29.0

