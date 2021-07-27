Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6B9E3D72A9
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jul 2021 12:12:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236221AbhG0KLI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jul 2021 06:11:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236213AbhG0KLH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jul 2021 06:11:07 -0400
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 919C7C061757
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jul 2021 03:11:07 -0700 (PDT)
Received: by mail-qk1-x749.google.com with SMTP id p14-20020a05620a22eeb02903b94aaa0909so11182452qki.15
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jul 2021 03:11:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=jNe6UiFjL/yCQ11Ml+WOvh6Eo1auwticKxQucNJjbhY=;
        b=p8LPEDRndOuWRUaIz3zsmXtaoE3tspzzxc8YjSvfEPoe5hYHeRRnkf9Jsgn94/4ttG
         PBXhaQLFnvyzeysCrX9jMx3r4fDHFHBdvQNpxSC8GKf9Bck7LwX6Ch/KgDEsUCeW5qFZ
         77+9j5uvdevxkeYaN/3K8NJCMFvRO17wGe6GoyXL+C4mptuyBaSoO4pv9kWCPU+v6uTo
         FVOKqShTrjOWzaSDwB7eku3lACVCMQKUxYZmag6RCIB2Wufzh9NcBUOFs9em4xT+XRrA
         Px5gIXbMzPKey+/zL7VafIdXWq/SVu3KcBek8/sZ6Y3l7qQBtSDp643sAVvSBDjy7Uwn
         P9nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=jNe6UiFjL/yCQ11Ml+WOvh6Eo1auwticKxQucNJjbhY=;
        b=SRLIqwq4tjr1GQYm+OQid1D1QU8ZtPaD29O+U/sRDTcqiFOL+5okmHq/G2Vu0TGyq6
         CUuZnse6Smtl2SwETfmw+wcIeiB1FM7wP7w0fn9xrbYtUIzIMRmTubEfVbDbOBu5mNjg
         YnY+MMzG6tlO+IKIDw/gAJZVY/RfPB01MLjgbQ3HINWRnJtmUf/nekOyjBfZlKuXN/i8
         oR1UD5lE8/n26a6DxTAOjRKNV8L+OmJ0InbFjzCIioHQbNKfGm8J7m8R7LO07m/w38L9
         /8pfRVBBIISBGxA1M6r9iKyG3iSbbQfbk+Kym4QNCl7gtipPb/VDh/1YNTHt+AhNAdJm
         vW6Q==
X-Gm-Message-State: AOAM533TX0lynXvhT6Za5Zgx5TZdrqZFYh5MZCbw7h7heLTO0kb4CMdU
        KoDKVX+a7Ot8Sl/ZSM/2OLmI7VrpxhH6
X-Google-Smtp-Source: ABdhPJzbHAGBDmH4enVITD6iifaJvlrcZpruOSv1EEydJvy2gPRI8lwbfdK8Cij+hq/ZMcMDVlgRUxyuco1m
X-Received: from luke.lon.corp.google.com ([2a00:79e0:d:210:c468:e033:fa2b:3a6])
 (user=qperret job=sendgmr) by 2002:a05:6214:1c1:: with SMTP id
 c1mr21651942qvt.37.1627380666621; Tue, 27 Jul 2021 03:11:06 -0700 (PDT)
Date:   Tue, 27 Jul 2021 11:11:00 +0100
Message-Id: <20210727101103.2729607-1-qperret@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.32.0.432.gabb21c7263-goog
Subject: [PATCH 0/2] A couple of sched_getattr() fixes for DL
From:   Quentin Perret <qperret@google.com>
To:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        linux-kernel@vger.kernel.org
Cc:     Quentin Perret <qperret@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

In the context of [1] it became apparent that the way __getparam_dl()
copies the sched_flags into the dl_entity struct for deadline tasks can
have undesirable side effects. This series fixes two issues in that area
causing sched_getattr() to report stale values or things it shouldn't
report to userspace.

Thanks,
Quentin

[1] https://lore.kernel.org/lkml/ad30be79-8fb2-023d-9936-01f7173164e4@arm.com/

Quentin Perret (2):
  sched/deadline: Fix reset_on_fork reporting of DL tasks
  sched: Don't report SCHED_FLAG_SUGOV in sched_getattr()

 kernel/sched/core.c     | 1 +
 kernel/sched/deadline.c | 7 ++++---
 kernel/sched/sched.h    | 2 ++
 3 files changed, 7 insertions(+), 3 deletions(-)

-- 
2.32.0.432.gabb21c7263-goog

