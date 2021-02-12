Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDD19319FE2
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Feb 2021 14:31:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231635AbhBLNak (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Feb 2021 08:30:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230301AbhBLNag (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Feb 2021 08:30:36 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E455C061574
        for <linux-kernel@vger.kernel.org>; Fri, 12 Feb 2021 05:29:56 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id u14so995748wmq.4
        for <linux-kernel@vger.kernel.org>; Fri, 12 Feb 2021 05:29:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=okhXVfXO9rqyp0jAqhXtvd09OfQrsZSHa5AtxiIb/24=;
        b=GPf22FJfNWxvXWaELkKb3p2/5SZUKox8DnbFUDKV2SA67ixIASJ/+e8E/kn1vm/lTw
         EIRta62R+mrvqIeGNXLj6WDORVdv0F5zeIGLxfcYk480p3HOC/NiQZzY+WyZRFqPkQpA
         otIepwHJieSM12AgoqNyNUEXobC234JD2yrLz5nNKUqaUe2UmQG7MJJuy6yTU67O7c2M
         S+hQJxqzm8q951x7/8t9rsCTSchxZP46BIbiJst2QrzGMTBwocbtl6v+Cfcb74ssfwVj
         ylUJV0pe3MmI737kqFKCOCC2kenTuES3ZJWIPQ/c6fNBxD11/CeVCeNKPlWpS8MKINcb
         62zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=okhXVfXO9rqyp0jAqhXtvd09OfQrsZSHa5AtxiIb/24=;
        b=Ud6irBGfne1Huwb03OxecQ15TbKS76iF5PySvlQo95UC4qJnVoudfu6pxflDpplNrp
         RcClwKlGRr5ED9DAga+ab9QlTDGzFjVli67R0dc/dFTHMLTsE0GB1XDwDftUf4WfWbMV
         VcL+uz5ospcgccVdWC9CV1QJJCOovcm56sAjT9XJNUJakiKEAOumAQMknY6Hs4N5W/vy
         q6EoarOoC4gtm9U7cT2TdyMASImoKcfHX1TPT/C9E0MkFNDSAB7fdnLfaLmWByFbQMfD
         6n6w6hXRvYqmatHvNs+/XFj2u19Xp92Yp3zNQRaujJ7+S2g/TszytPnug16gQoDnv2In
         hlDA==
X-Gm-Message-State: AOAM532Nmh3TB+R9cL0yw1L4sy8RAJUn9eOlLw6LKTUaotosV4etrd8R
        pQIkAL9uGUiqJyGhiilScTSKpw==
X-Google-Smtp-Source: ABdhPJzYLujQmycXpEzzgTFDkOxj2tvsMshAqMecxGryTn4ucpM1lld8XeBuWwxHzoJZIboLyex4aA==
X-Received: by 2002:a1c:5608:: with SMTP id k8mr2647662wmb.91.1613136594663;
        Fri, 12 Feb 2021 05:29:54 -0800 (PST)
Received: from localhost.localdomain ([2a01:e0a:f:6020:ad4e:cdb3:8eaf:6329])
        by smtp.gmail.com with ESMTPSA id h13sm10470773wrv.20.2021.02.12.05.29.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Feb 2021 05:29:54 -0800 (PST)
From:   Vincent Guittot <vincent.guittot@linaro.org>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, linux-kernel@vger.kernel.org,
        joel@joelfernandes.org, valentin.schneider@arm.com
Cc:     fweisbec@gmail.com, tglx@linutronix.de, qais.yousef@arm.com,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH 0/7 v2] move update blocked load outside newidle_balance
Date:   Fri, 12 Feb 2021 14:28:42 +0100
Message-Id: <20210212132849.32515-1-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Joel reported long preempt and irq off sequence in newidle_balance because
of a large number of CPU cgroups in use and having to be updated. This
patchset moves the update outside newidle_imblance. This enables to early
abort during the updates in case of pending irq as an example.

Instead of kicking a normal ILB that will wakes up CPU which is already
idle, patch 6 triggers the update of statistics in the idle thread of
the CPU before selecting and entering an idle state.

change on v2:
- Fixed some typos and updated some comments
- Added more cleanup
- Changed to way to trigger ILB in idle thread context to remove a possible
  race condition between the normal softirq ILB and this new mecanism. The
  cpu can already be set in idle_cpus_mask because even if the cpu is added
  later when entering idle, it might not have been removed yet from previous
  idle phase.
  
Vincent Guittot (7):
  sched/fair: remove update of blocked load from newidle_balance
  sched/fair: remove unused return of _nohz_idle_balance
  sched/fair: remove unused parameter of update_nohz_stats
  sched/fair: merge for each idle cpu loop of ILB
  sched/fair: reorder newidle_balance pulled_task tests
  sched/fair: trigger the update of blocked load on newly idle cpu
  sched/fair: reduce the window for duplicated update

 kernel/sched/fair.c  | 114 ++++++++++++++++---------------------------
 kernel/sched/idle.c  |   6 +++
 kernel/sched/sched.h |   3 ++
 3 files changed, 51 insertions(+), 72 deletions(-)

-- 
2.17.1

