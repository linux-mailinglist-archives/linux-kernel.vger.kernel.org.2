Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F08C312B24
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Feb 2021 08:38:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229975AbhBHHhf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Feb 2021 02:37:35 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:24752 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229742AbhBHHhd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 02:37:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612769766;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=V0KFY2P39jIBk4Vg3W5acZcrG9X4MOJmJKEvyCltwrM=;
        b=iNcd8TXOby/KI3fstNJ2QcsJqCdy8p+4AJbNyHOzumbcfPFSC1wEEqKjT4GR+1Gvb1qJpM
        i/Bbnpu8TCYv4w0yroiUmYLT2K9vD1LKN1FaXPmNAIThTzQGew7P9AAVG8SpOQ2THm/N2L
        FD7E7OG5fyzlBqOp+Go+0QCQNm1y4nk=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-257-Py117EPPN1-gmFLkRRoA8A-1; Mon, 08 Feb 2021 02:36:03 -0500
X-MC-Unique: Py117EPPN1-gmFLkRRoA8A-1
Received: by mail-ed1-f71.google.com with SMTP id m16so12831870edd.21
        for <linux-kernel@vger.kernel.org>; Sun, 07 Feb 2021 23:36:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=V0KFY2P39jIBk4Vg3W5acZcrG9X4MOJmJKEvyCltwrM=;
        b=BgJ5RkuxR6u+eHKY4J9ScMxVDAQC2onN1RZqck4OVgU9+HFbv7GVX8w6lFQx4/LX82
         GJ17wUsV+gGYMSJM/DRBMzm5ocxItpe/fLR3DLdAQcZk5EerNk8RQqc0SjnqZoJothkW
         HCEq5dcNAdjm6MElj+mzb8P29PeqThGKC7Dx6Fg3167GrKKmhZeR3uuxZaedeWoN39eJ
         TIYUlomZtUK3op36uOegCXQJZOhHxwCz15yhbpF9cZboAydllOK05a8tPf8yg5R0jwil
         uM5gRuFvBQXTJ1UVEUndgkBWFfN8Tn2Lep4oSF8nUYx5PgWKibNsKMyVf+lhAnMcMc0s
         01NA==
X-Gm-Message-State: AOAM5316cEM9Ss2KlWtJrLoJOe9RN96LjiB5soLgPu9usF0IVh/yP3ug
        13Gl0/AjHfILdEH2T3IVlotVsWBXe67uoyqCF3nJkXvgC21weeh2SXeRnnLa2wrhxivLBUguzQk
        LT9PFW68Erko/TbDcNMf6oQDj
X-Received: by 2002:a17:906:dff1:: with SMTP id lc17mr15128098ejc.198.1612769762082;
        Sun, 07 Feb 2021 23:36:02 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwAJU7X6Yy/a4yGaCNEh0FQixHsMuZ0EXqfjV4lhfs/JcK3FCt3IAmkuQZYwi5cGDjdqHxhEg==
X-Received: by 2002:a17:906:dff1:: with SMTP id lc17mr15128080ejc.198.1612769761886;
        Sun, 07 Feb 2021 23:36:01 -0800 (PST)
Received: from localhost.localdomain.com ([151.34.162.6])
        by smtp.gmail.com with ESMTPSA id ec18sm8116317ejb.24.2021.02.07.23.35.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Feb 2021 23:36:01 -0800 (PST)
From:   Juri Lelli <juri.lelli@redhat.com>
To:     peterz@infradead.org, mingo@redhat.com, vincent.guittot@linaro.org,
        tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org, rostedt@goodmis.org,
        dietmar.eggemann@arm.com, bristot@redhat.com, bsegall@google.com,
        mgorman@suse.de, lgoncalv@redhat.com, williams@redhat.com,
        Juri Lelli <juri.lelli@redhat.com>
Subject: [PATCH 0/2] HRTICK reprogramming and optimization
Date:   Mon,  8 Feb 2021 08:35:52 +0100
Message-Id: <20210208073554.14629-1-juri.lelli@redhat.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

Hung tasks and RCU stall cases were reported on systems which were not
100% busy. Investigation of such unexpected cases (no sign of potential
starvation caused by tasks hogging the system) pointed out that the
periodic sched tick timer wasn't serviced anymore after a certain point
and that caused all machinery that depends on it (timers, RCU, etc.) to
stop working as well. This issue was however only reproducible if HRTICK
was enabled.

Looking at core dumps it was found that the rbtree of the hrtimer base
used also for the hrtick was corrupted (i.e. next as seen from the base
root and actual leftmost obtained by traversing the tree are different).
Same base is also used for periodic tick hrtimer, which might get "lost"
if the rbtree gets corrupted.

Much alike what is described in commit 1f71addd34f4c ("tick/sched: Do
not mess with an enqueued hrtimer") there is infact a race window
between hrtimer_set_expires() in hrtick_start and
hrtimer_start_expires() in __hrtick_restart() in which the former might
be operating on an already queued hrtick hrtimer, which might lead to
corruption of the base. Patch 01/02 fixes this case.

While at it, it might be desired to avoid HRTICK overhead in cases where
it is only actually used to service a specific subset of scheduling
classes (currently it services both fair and deadline “at once”). Patch
02/02 proposes an optimization by making HRTICK feature selectable on a
per class basis, so one can, say, enable it only to service DEADLINE and
leave NORMAL task preemption points less fine grained.

Series available at

https://github.com/jlelli/linux.git sched/hrtick-fixes

Hope they both make sense. Comments, questions and suggestions are more
than welcome.

Best,
Juri

Juri Lelli (2):
  sched/features: Fix hrtick reprogramming
  sched/features: Distinguish between NORMAL and DEADLINE hrtick

 kernel/sched/core.c     | 10 ++++------
 kernel/sched/deadline.c |  4 ++--
 kernel/sched/fair.c     |  4 ++--
 kernel/sched/features.h |  1 +
 kernel/sched/sched.h    | 27 +++++++++++++++++++++++++--
 5 files changed, 34 insertions(+), 12 deletions(-)

-- 
2.29.2

