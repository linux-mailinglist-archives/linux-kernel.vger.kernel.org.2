Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 020BC3F2449
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Aug 2021 03:04:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237397AbhHTBE6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Aug 2021 21:04:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236021AbhHTBEw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Aug 2021 21:04:52 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8AA1C061756
        for <linux-kernel@vger.kernel.org>; Thu, 19 Aug 2021 18:04:15 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id d69-20020a25e6480000b02904f4a117bd74so8261258ybh.17
        for <linux-kernel@vger.kernel.org>; Thu, 19 Aug 2021 18:04:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=Fz9xZWdZQbzEXreJIg4kHD+e/W/OmpIFd4LS057/FbA=;
        b=r6DCS1P3JNlacer91pH+grdrxRZo2ORsdRlN0zvmKidEnAuB3YkruSq39eNAW/0yUM
         8qiYVKfUNccps8LPN4J+HFPFASg83i9C3DnSbhLI6r8VgrORlehruA1S3X1/CLCYOrwX
         tYG1PiYjtQsJbdhLXVU/zEcFfoJWSMEMP5MDnYw/1wW0b9ER72PPvfUj0Dp46rAY2kwF
         g7Heu7CrRGbaXZd0zMNuTPTkopojp1RK9xbOG440gTCbMP7YJdV+CJhBfkXtVxc+wfod
         HulLdAlhEkie8EfA3UaeN/zyLXJaMC+siRX+IT8A2LTfJV0ktA6ItX+IHT2YLAW9ldpS
         euYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=Fz9xZWdZQbzEXreJIg4kHD+e/W/OmpIFd4LS057/FbA=;
        b=ctlJOwCXSAqtIbakoBkD33AunQcbv6a+yfzXfOWFLlITSV1q1oY0/SUlfUDxthhYRD
         rV+sGyaFGGhNX82tvu4hq5blqP2iDA+tT5BOHZnM9HTmLt7M1GxyfYWkFV6JbfKoYHgU
         i8un2kt8luoIZN08y/ePLeNP2dCC9wlRtgnTPjNVzYGBgZ52r+sH5X94ndZ+pnP86PVq
         lYhz3gb83mX8r796RtH9rL0Lmff2yTFiWUPzVEf/I0Z3SSYqIxNXTh7xNoG5BTaInrM9
         2qVcDfGR3hLPvQP64MPBHOoWRkotHRgNDLiSf3r8XIqhl1nqV3w7m9kRsana+rn0zGLe
         gp3Q==
X-Gm-Message-State: AOAM5300EUWFrjjcH4AaEXd/zlBd74TgZ4sYjvl2W/f9hPE2EF+FjKIM
        SJjN4zTq60nx1uwYqcM1c0i5/2OOHkq+
X-Google-Smtp-Source: ABdhPJx6AhXRswnYJ7lUP5tpU2iZ/1K2ZdpzK3K5dnIq71yCTQ5qTHjgOoDh2x7dbSJdaiu7VRKL0FpkXjg5
X-Received: from joshdon.svl.corp.google.com ([2620:15c:2cd:202:23c6:59ba:fc84:7672])
 (user=joshdon job=sendgmr) by 2002:a25:ced4:: with SMTP id
 x203mr21991288ybe.8.1629421454928; Thu, 19 Aug 2021 18:04:14 -0700 (PDT)
Date:   Thu, 19 Aug 2021 18:03:59 -0700
Message-Id: <20210820010403.946838-1-joshdon@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.33.0.rc2.250.ged5fa647cd-goog
Subject: [PATCH v3 0/4] SCHED_IDLE extensions
From:   Josh Don <joshdon@google.com>
To:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Paul Turner <pjt@google.com>,
        Oleg Rombakh <olegrom@google.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Steve Sistare <steven.sistare@oracle.com>,
        Tejun Heo <tj@kernel.org>, Rik van Riel <riel@surriel.com>,
        linux-kernel@vger.kernel.org, Josh Don <joshdon@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series contains improvements/extensions for SCHED_IDLE.

The first patch of the series is the previously mailed patch to add
cgroup support for SCHED_IDLE.

The second patch adds some additional idle accounting.

The third and fourth patches change some idle interactions.

Josh Don (4):
  sched: cgroup SCHED_IDLE support
  sched: account number of SCHED_IDLE entities on each cfs_rq
  sched: reduce sched slice for SCHED_IDLE entities
  sched: adjust sleeper credit for SCHED_IDLE entities

 kernel/sched/core.c  |  25 +++++
 kernel/sched/debug.c |   7 ++
 kernel/sched/fair.c  | 256 +++++++++++++++++++++++++++++++++++++------
 kernel/sched/sched.h |  10 ++
 4 files changed, 267 insertions(+), 31 deletions(-)

-- 
2.33.0.rc2.250.ged5fa647cd-goog

