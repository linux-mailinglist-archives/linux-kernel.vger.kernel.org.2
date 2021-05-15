Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 519D6381A15
	for <lists+linux-kernel@lfdr.de>; Sat, 15 May 2021 19:11:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233410AbhEORM6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 May 2021 13:12:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbhEORMz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 May 2021 13:12:55 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2E95C061573;
        Sat, 15 May 2021 10:11:41 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id n2so2224991wrm.0;
        Sat, 15 May 2021 10:11:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=Yv/SMg0fIXZjNNbdbCRKD2NaAjmoQnkcxhQGmRWvOuQ=;
        b=oKAz9AQ5LnN95wyCVKVkQNiGMTiUA24FwSc6bv8h5CAK7q0GG+B9zgDUyC0Fv8NBYJ
         znJ9bRFBNsFgaJEH+f4/WX253OQ5syY639XlUD7isfstVZLYXIoakhqHY33VyIQ5sO3A
         iCsP3Os21zWukI1fgXDrN2irzqSdWnH4a/5za5PLeio4DLUolXx4FExNKQd7P1xG8GSR
         H3aDktcCxIzgX3Wj/1c20sXy/j+RQETypQxLNQhIY9l8F3U/REVE3ETV5dI23u7Q/LaB
         xWjx2ToMgGU+z59JAk3nqVmTa0weCkr8fzMuMxwQHCWC6IGhws+Kl3RDVVI5+TzNmp/o
         6eNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Yv/SMg0fIXZjNNbdbCRKD2NaAjmoQnkcxhQGmRWvOuQ=;
        b=JHHLtr8X5V6f4JO4aGc41CYBhisynTx0Vabdx7G2wNXJ9EIZtyGFRlaSNDHIBi2+L9
         P84QxykQxlyw5mPUnRtaMsym6IveNLJkCY1O58/2OG3xOvwmXJp5J09KRBAmkQj6+egt
         6V+BWsexMnomByqt8EDGTpOkgbfMM1dImqEbbzrDcF0gP2zUlaITotIMVOwy/YfpNND7
         dDeQPDhJIk4TP99bi9pmZTfZUQtl/vP9Qx8VRDNY0szCec1RxlxdtSJXbO8hdLn4VUNl
         eORErlITRUYZw1FQob0nFaRX9QLa/5vlY7EIYRqXAW0RFs0VteN0Thu75OoLa1uV6liZ
         khFw==
X-Gm-Message-State: AOAM532TKl8k1KbIbZx57m7Dp+KolnAoRmEtqSpQOO8OTscQI0Rgcji6
        Trj7ajrGZk7EQNIfhyV1aGY=
X-Google-Smtp-Source: ABdhPJwa35QKDuZ51e4NQBbEhiDPZ9VOP++SwdFSri2/tJtCV4TBrl6Gn/GaUz5yI092//YDKA5WLg==
X-Received: by 2002:a05:6000:2cf:: with SMTP id o15mr30314865wry.243.1621098700332;
        Sat, 15 May 2021 10:11:40 -0700 (PDT)
Received: from localhost.localdomain ([197.240.82.148])
        by smtp.gmail.com with ESMTPSA id f3sm9740308wrp.7.2021.05.15.10.11.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 May 2021 10:11:39 -0700 (PDT)
From:   Khaled ROMDHANI <khaledromdhani216@gmail.com>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com
Cc:     Khaled ROMDHANI <khaledromdhani216@gmail.com>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH-next] sched: Fix Dereference after null check
Date:   Sat, 15 May 2021 18:11:17 +0100
Message-Id: <20210515171117.23240-1-khaledromdhani216@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The group_cfs_rq derefrence the 'se' variable that could
be passed as NULL pointer. Fix this by adding a check
against the sched entity 'se' before the derefrence.

Addresses-Coverity: ("Dereference after null check")
Signed-off-by: Khaled ROMDHANI <khaledromdhani216@gmail.com>
---
 kernel/sched/fair.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 161b92aa1c79..9be6cdba351d 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -7080,7 +7080,8 @@ static struct task_struct *pick_task_fair(struct rq *rq)
 		}
 
 		se = pick_next_entity(cfs_rq, curr);
-		cfs_rq = group_cfs_rq(se);
+		if (se)
+			cfs_rq = group_cfs_rq(se);
 	} while (cfs_rq);
 
 	return task_of(se);
-- 
2.17.1

