Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B77B9383A41
	for <lists+linux-kernel@lfdr.de>; Mon, 17 May 2021 18:42:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243434AbhEQQny (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 May 2021 12:43:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242061AbhEQQnm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 May 2021 12:43:42 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE796C0612AB
        for <linux-kernel@vger.kernel.org>; Mon, 17 May 2021 08:53:23 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id 27so3643845pgy.3
        for <linux-kernel@vger.kernel.org>; Mon, 17 May 2021 08:53:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=F2QBpAAF++uWH6CxS2YX3b9qpY1ggeZ6Y1tZ4KY25HY=;
        b=jAPqhJq6lwJYhWZL3sGNCzW5kQwuxbRa7eapGo0FDnsbS9I4G4jD55IAqlrFcWTSId
         OB/lf7hTKTWzuTc3tBDEOUHHzILFsEplNAJM6ZJfuQ5zfQK5wd0uOY1lNJWPg2DYHu8W
         aBhmPKW3ZDkV4iSO3VPB5/Au+tDdTKsf+IDSCq2mxcbWATOII374ANzAl5/w2Web+Hbm
         ZohnJIsmDY2cjIb6uSdvEq6pTU/ZZBCXT9qgUuAmLInU8H0R7TiyxWBgQHtcziXsSbsf
         SDDXhEDLxOLOKHrpxGNRv/RYCN+KDDb7sGO0y/vb80kjrIaAm6A4JJlzJUx8mHaM2RlR
         t3eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=F2QBpAAF++uWH6CxS2YX3b9qpY1ggeZ6Y1tZ4KY25HY=;
        b=FRzFx4GVC88EpAGIKZ2/378wV95OBCAF+Uy3Es+xtAIqGB5sD6H9yLjr3M0lf+TsMI
         5c/X7D3jtfza05LFKLopcazyaeY4nWjPrw0YII/EhvkVwvpLcSJrRu42bp4JP+XCEiQh
         DyJeK5pr0wLTM34kZpG5Ku89hedx8A+GirJdKGwvMqk8vT69EKbPMpjvtCxPwdTzEiAS
         oy8xBaBa00y0VVazFxeotAP9kt/pzgPHyAHpXSx1qQ7hb4cmblBIrZabgS+Cbj1nGzhK
         W9hkkMMuryOZLlQtjsxnZXeS/XGANtcylJNK17/6t3HveZuvEb2BbzNpw75KZafR9YPT
         Ggxw==
X-Gm-Message-State: AOAM530DGFxOiaZV1eYDdAIyd+WKchu5LsO0riuqachWrc1Ub5v+JA9P
        0/WygMmhqYwCy66lJdAkC/k=
X-Google-Smtp-Source: ABdhPJzU6fIFr1C7AGK5qoUaBq4gRzKSFRfaOhpc8WHiSr/G1AETnQfD/J2QXHrZE2JHH1y3edl2mA==
X-Received: by 2002:a62:1a4b:0:b029:24e:ba53:aaa4 with SMTP id a72-20020a621a4b0000b029024eba53aaa4mr304822pfa.63.1621266803306;
        Mon, 17 May 2021 08:53:23 -0700 (PDT)
Received: from wuchi.mioffice.cn ([2408:8607:1b00:a:4a4d:7eff:feb5:2e68])
        by smtp.gmail.com with ESMTPSA id jz7sm2190306pjb.32.2021.05.17.08.53.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 May 2021 08:53:22 -0700 (PDT)
From:   Chi Wu <wuchi.zero@gmail.com>
To:     akpm@linux-foundation.org
Cc:     jack@suse.cz, linux-kernel@vger.kernel.org, tan.hu@zte.com.cn,
        Chi Wu <wuchi.zero@gmail.com>
Subject: [PATCH] lib/flex_proportions.c: Use abs() when percpu_counter is negative.
Date:   Mon, 17 May 2021 23:53:06 +0800
Message-Id: <20210517155306.11113-1-wuchi.zero@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The value of percpu_counter_read() may become negative after
running percpu_counter_sum() in fprop_reflect_period_percpu().
The value of variable 'num' will be zero in fprop_fraction_percpu()
when using percpu_counter_read_positive(), but if using the abs of
percpu_counter_read() will be close to the correct value.

Signed-off-by: Chi Wu <wuchi.zero@gmail.com>
---
 lib/flex_proportions.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/lib/flex_proportions.c b/lib/flex_proportions.c
index 451543937524..3ac79ca2c441 100644
--- a/lib/flex_proportions.c
+++ b/lib/flex_proportions.c
@@ -147,7 +147,7 @@ void fprop_fraction_single(struct fprop_global *p,
 		seq = read_seqcount_begin(&p->sequence);
 		fprop_reflect_period_single(p, pl);
 		num = pl->events;
-		den = percpu_counter_read_positive(&p->events);
+		den = abs(percpu_counter_read(&p->events));
 	} while (read_seqcount_retry(&p->sequence, seq));
 
 	/*
@@ -209,7 +209,7 @@ static void fprop_reflect_period_percpu(struct fprop_global *p,
 			val = percpu_counter_sum(&pl->events);
 
 		percpu_counter_add_batch(&pl->events,
-			-val + (val >> (period-pl->period)), PROP_BATCH);
+			-val + (val >> (period - pl->period)), PROP_BATCH);
 	} else
 		percpu_counter_set(&pl->events, 0);
 	pl->period = period;
@@ -234,8 +234,8 @@ void fprop_fraction_percpu(struct fprop_global *p,
 	do {
 		seq = read_seqcount_begin(&p->sequence);
 		fprop_reflect_period_percpu(p, pl);
-		num = percpu_counter_read_positive(&pl->events);
-		den = percpu_counter_read_positive(&p->events);
+		num = abs(percpu_counter_read(&pl->events));
+		den = abs(percpu_counter_read(&p->events));
 	} while (read_seqcount_retry(&p->sequence, seq));
 
 	/*
-- 
2.17.1

