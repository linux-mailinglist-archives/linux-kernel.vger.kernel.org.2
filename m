Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06B343464F3
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 17:23:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233277AbhCWQWj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 12:22:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233030AbhCWQWD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 12:22:03 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 135B9C061574
        for <linux-kernel@vger.kernel.org>; Tue, 23 Mar 2021 09:22:03 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id v186so12222785pgv.7
        for <linux-kernel@vger.kernel.org>; Tue, 23 Mar 2021 09:22:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+Ebklfl3SHR/N104RwQtLuvRpZ2abvFafvN8X7QJACg=;
        b=DcWKUsGmP3cKyAx1vWNeOGsSmNWJk/jR0RilrqN8DKg4yjX+UA9xJFYYeAnyMvFIXd
         An2HwChhjiU9u9uoquaEj8Gw/dlbttD9yCbSzlwk54jUR1cylEpSOL0LsQu+R+uy/5gb
         BSEJlWem4hoz9sz6HArDkX3W4YRLh0bwp9XGgiorleDDmKjNKYImSyiqL6Foy9/CvQ94
         wjBbyO6s3+YSJ5CuavjieAqmYBVEkRA2FdywmaRjQs6YKoP+ndSsPfjjRTiHa4yS4oUC
         yH2AOxTLtdKP/JckH3SKkOrx+zBdYD4LcIixq/1iySWQiRAyGGNnyxEe6dg0q+uFFkYO
         RNrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=+Ebklfl3SHR/N104RwQtLuvRpZ2abvFafvN8X7QJACg=;
        b=QjulNU3WJzSqZl/KDC8EO0DzWkwDC0nx0RigFChARgWHcvkYMy8wv85r5jf7GJT7En
         0Fu0tCPayojmp+pn7a3n9dpQ6QohFJuwGz9Y9Ky0nKbMQ5NNbYgHe50FkhDf9cvl8Z9q
         cD0rVkymegmalsX1AEJztfdx7Xauo0BUwP9tOW+WR8G0rgIklzkyMPnQWqzFYSFwzo4k
         rJNyMcpV/iH5IpYV1DMuYZeTFWkGAsYcO4L4OFtaYBkh9tuaQ3woJe8zkrrL/ZIH602f
         4Cfx+7C9C02lshb5PFTP58FdgxoIRo7yimVxYIgHrstVaFrptGlS4mB5prkRxxmo49L9
         aPyA==
X-Gm-Message-State: AOAM5308wXb/SAToJOQe+k5khba13Cn141HPY6DdD99YgXUL/sB93YPL
        sjwRs52Mehw7BQ5Xt2b0FqI=
X-Google-Smtp-Source: ABdhPJyWR9W7ZZcWrejAvzNlbEF6yzUt7ndG3rRf3Esm0ja8PDumtimCFsPZQCsXoMAMN+U2er6xeQ==
X-Received: by 2002:a17:902:f28b:b029:e4:5039:9f03 with SMTP id k11-20020a170902f28bb02900e450399f03mr6781693plc.62.1616516522679;
        Tue, 23 Mar 2021 09:22:02 -0700 (PDT)
Received: from balhae.roam.corp.google.com ([101.235.31.111])
        by smtp.gmail.com with ESMTPSA id e6sm5615766pfc.159.2021.03.23.09.21.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Mar 2021 09:22:02 -0700 (PDT)
Sender: Namhyung Kim <namhyung@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Stephane Eranian <eranian@google.com>,
        Andi Kleen <ak@linux.intel.com>,
        Ian Rogers <irogers@google.com>,
        Song Liu <songliubraving@fb.com>
Subject: [RFC 0/2] perf core: Sharing events with multiple cgroups
Date:   Wed, 24 Mar 2021 01:21:54 +0900
Message-Id: <20210323162156.1340260-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.31.0.rc2.261.g7f71774620-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

This work is to make perf stat more scalable with a lot of cgroups.

Currently we need to open a separate perf_event to count an event in a
cgroup.  For a big machine, this requires lots of events like

  256 cpu x 8 events x 200 cgroups = 409600 events

This is very wasteful and not scalable.  In this case, the perf stat
actually counts exactly same events for each cgroup.  I think we can
just use a single event to measure all cgroups running on that cpu.

So I added new ioctl commands to add per-cgroup counters to an
existing perf_event and to read the per-cgroup counters from the
event.  The per-cgroup counters are updated during the context switch
if tasks' cgroups are different (and no need to change the HW PMU).
It keeps the counters in a hash table with cgroup id as a key.

With this change, average processing time of my internal test workload
which runs tasks in a different cgroup and communicates by pipes
dropped from 11.3 usec to 5.8 usec.

Thanks,
Namhyung


Namhyung Kim (2):
  perf/core: Share an event with multiple cgroups
  perf/core: Support reading group events with shared cgroups

 include/linux/perf_event.h      |  22 ++
 include/uapi/linux/perf_event.h |   2 +
 kernel/events/core.c            | 588 ++++++++++++++++++++++++++++++--
 3 files changed, 585 insertions(+), 27 deletions(-)

-- 
2.31.0.rc2.261.g7f71774620-goog

