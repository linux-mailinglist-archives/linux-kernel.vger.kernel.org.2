Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A86130BA6E
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 09:59:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232366AbhBBI6I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 03:58:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229466AbhBBI6B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 03:58:01 -0500
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23319C061573
        for <linux-kernel@vger.kernel.org>; Tue,  2 Feb 2021 00:57:21 -0800 (PST)
Received: by mail-il1-x136.google.com with SMTP id a16so692889ilq.5
        for <linux-kernel@vger.kernel.org>; Tue, 02 Feb 2021 00:57:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=oGwAR6bY8VSRQmUwKZ34FKMeypPh0jsTSiLoYBbPc64=;
        b=EEa1m8UfTMdIkJdT6uQshRNB67qXyf9x3s84g2hkFToF1WcifUqTHBDWLLigrf6nK/
         1dHgKQ2vLWuWk6rdMbJ+MYZNrdlAW9ZGcCdlr9nCanSgCGEeQVc18Y/o/AStQ7dPXCN2
         G/84S2z9GuCoxONLys1cRj5XeETwoP/7GnGmuYa/lHNbFqn8mRsga2O3HSAWvqezXx0J
         52Inn+Fd6PkCBjBSFvfGr5yAKiUN7aAdbw0nORI9KcG4mh3c6C/BeBySDOPED2QPeZvO
         hHK75MAHn5ANUg0e1bQuJS0qfXWuhy9Ukc0Yo8YyEIwzBRWVMFu5ILBvES9RZuTki+zE
         nUcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=oGwAR6bY8VSRQmUwKZ34FKMeypPh0jsTSiLoYBbPc64=;
        b=pIt3NGv+MFDZCYHfpb6FfdQlUGUwIcudPPf5Vhhl0NeXGhqi163safNCAZJUv/7b7s
         NwtYYfQEHv+rfKO1b/utLW6/r9XsKEgQSTmP7YLosc81JMUAZrptiK6vyBxC7rcyco0D
         nDXdFlOr6H5fgY5W1RwSt3hVaQuTQG3eArRiUaiS809hrhkniC87Y6Y3mVsStMsFjGCD
         TjrZ7K6bjV9brZR5RtSnBGkQHiFQN5VGiem4x7wVEzljtvhtoCYAO94UNq+OMtSm/q/Y
         4cB75rHA6QzTrq8ihiXtPk/fZ74ti7Ed5KNQnDlspGSAU3N5M7OvjYQztv/7BGm0Xcbj
         XdQQ==
X-Gm-Message-State: AOAM530F0k5/DaZbihn+MZoufE7wyNA8//d0UvMkuwihevLuGkYLcTo0
        uV/6+WdEYELpeQNbweAOciGWvg==
X-Google-Smtp-Source: ABdhPJy/BTGAL3CxSNcLT44HtScvwuY6Ur4oNDxCjia11s3y4xc2HoorkufOuwsOmqinor4VC1jyjg==
X-Received: by 2002:a92:c090:: with SMTP id h16mr420348ile.190.1612256240438;
        Tue, 02 Feb 2021 00:57:20 -0800 (PST)
Received: from google.com ([2620:15c:183:200:78f9:6386:be80:e7fc])
        by smtp.gmail.com with ESMTPSA id k125sm3507818iof.14.2021.02.02.00.57.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Feb 2021 00:57:19 -0800 (PST)
Date:   Tue, 2 Feb 2021 01:57:15 -0700
From:   Yu Zhao <yuzhao@google.com>
To:     linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, page-reclaim@google.com
Subject: Augmented Page Reclaim
Message-ID: <YBkT6175GmMWBvw3@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

======================
Augmented Page Reclaim
======================
We would like to share a work with you and see if there is enough
interest to warrant a run for the mainline. This work is a part of
result from a decade of research and experimentation in memory
overcommit at Google: an augmented page reclaim that, in our
experience, is performant, versatile and, more importantly, simple.

Performance
===========
On Android, our most advanced simulation that generates memory
pressure from realistic user behavior shows 18% fewer low-memory
kills, which in turn reduces cold starts by 16%. This is on top of
per-process reclaim, a predecessor of ``MADV_COLD`` and
``MADV_PAGEOUT``, against background apps.

On Borg (warehouse-scale computers), a similar approach enables us to
identify jobs that underutilize their memory and downsize them
considerably without compromising any of our service level indicators.
Our findings are published in the papers listed below, e.g., 32% of
memory usage on Borg has been idle for at least 2 minutes.

On Chrome OS, our field telemetry reports 96% fewer low-memory tab
discards and 59% fewer OOM kills from fully-utilized devices and no UX
regressions from underutilized devices. Our real-world benchmark that
browses popular websites in multiple tabs demonstrates 51% less CPU
usage from ``kswapd`` and 45% (some) and 52% (full) less PSI on
v5.11-rc6 built from the tree below.

Versatility
===========
Userspace can trigger aging and eviction independently via the
``debugfs`` interface [note]_ for working set estimation, proactive
reclaim, far memory tiering, NUMA-aware job scheduling, etc. The
metrics from the interface are easily interpretable, which allows
intuitive provisioning and discoveries like the Borg example above.
For a warehouse-scale computer, the interface is intended to be a
building block of a closed-loop control system, with a machine
learning algorithm being the controller.

Simplicity
==========
The workflow [note]_ is well defined and each step in it has a clear
meaning. There are no magic numbers or heuristics involved but a few
basic data structures that have negligible memory footprint. This
simplicity has served us well as the scale and the diversity of our
workloads constantly grow.

Repo
====
git pull https://linux-mm.googlesource.com/page-reclaim refs/changes/80/1080/1

Gerrit: https://linux-mm-review.googlesource.com/c/page-reclaim/+/1080

.. [note] See ``Documentation/vm/multigen-lru.rst`` in the tree.

FAQ
===
What is the motivation for this work?
-------------------------------------
In our case, DRAM is a major factor in total cost of ownership, and
improving memory overcommit brings a high return on investment.
Moreover, Google-Wide Profiling has been observing the high CPU
overhead [note]_ from page reclaim.

Why not try to improve the existing code?
-----------------------------------------
We have tried but concluded the two limiting factors [note]_ in the
existing code are fundamental, and therefore changes made atop them
will not result in substantial gains on any of the aspects above.

What particular workloads does it help?
---------------------------------------
This work optimizes page reclaim for workloads that are not IO bound,
because we find they are the norm on servers and clients in the cloud
era. It would most likely help any workloads that share the common
characteristics [note]_ we observed.

How would it benefit the community?
-----------------------------------
Google is committed to promoting sustainable development of the
community. We hope successful adoptions of this work will steadily
climb over time. To that end, we would be happy to learn your
workloads and work with you case by case, and we will do our best to
keep the repo fully maintained. For those whose workloads rely on the
existing code, we will make sure you will not be affected in any way.

References
==========
1. `Long-term SLOs for reclaimed cloud computing resources
   <https://research.google/pubs/pub43017/>`_

2. `Profiling a warehouse-scale computer
   <https://research.google/pubs/pub44271/>`_

3. `Evaluation of NUMA-Aware Scheduling in Warehouse-Scale Clusters
   <https://research.google/pubs/pub48329/>`_

4. `Software-defined far memory in warehouse-scale computers
   <https://research.google/pubs/pub48551/>`_

5. `Borg: the Next Generation
   <https://research.google/pubs/pub49065/>`_
