Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49AF33B695E
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jun 2021 21:57:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237169AbhF1UAD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Jun 2021 16:00:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235853AbhF1UAB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jun 2021 16:00:01 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAB7CC061574
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jun 2021 12:57:34 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id q14so27725943eds.5
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jun 2021 12:57:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=E7Mh34xdwjYl+E1G2SeJlr8Q6SqgwT3wSTbDvOU0YJY=;
        b=UvLOrCLt+VJ6fJ53Lyrp6mIVKpkLmN3g/11/WGbK3TzzfJNJxzfVM9sln0/LNNCOKa
         IQ9OvnPC76kGNOejtbcYfEPKwlvETp/WgFP9RWiHjIqCLN/k7S8rgLtlLsUT8YhJFIel
         Y9K/rnAq+Lw9HW7AOlyzqAQN3fEEKaCNdA2gdNIRBYM0Jp+ojRIFFIxX7+QcuY3gPrl0
         oTFgXcW/quLkQ5Q4IYP/xQYaf2sTlfx5cBQVwZhe9jq3cH7FpUQX+L+Xngn7DVKeEmXA
         l8j0VWbi+1w8WRL7u4os6o/pjSaHdTWOzQkWGU1dAyfqmvlDZUk2KuDhgZhJyiaFz0Yl
         r8+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=E7Mh34xdwjYl+E1G2SeJlr8Q6SqgwT3wSTbDvOU0YJY=;
        b=DXEPN0S1Xc9ht0NC6aOnRkFkujBq5fnXhU0hP1x8SbVV070pG9bQmuGNvx7ff67q61
         gn7e3NWYFwn7epBRzoc6e2Lkd7T5VWbkaAUaFnTYShqB5hXGfq2saU0Ec7x+iSDyGUis
         1yV5g+yS+MT4aiJxj7c2WCVLDZ0iIk6Rt1NRx5S3llHe4hiBe/GX48zf3npiScKKKH8q
         r13eT2/3RoGs1XDpH2q2SGc6Y8MxLkVx8xojG1vwsD64XVYtC+JHiFecasjJup74gMHN
         rO4uM96+sgmtwrWscCPLIjGqNMgb1hm6+edLHcEaVuKRIS8AFG9vaB2MZdt94dyfQXf8
         7JSA==
X-Gm-Message-State: AOAM530FqUX82yQGoO3+4NUYN2ObSeVnc4kw6Ymk37wkofpPnVUu+k96
        yH5n0qPjZ9FA+VR3johZckk=
X-Google-Smtp-Source: ABdhPJytQnkPWReBQtEHlI1ZxsPODXKiCXP1PXhJ7eRkOElwI+IFlrAYQb6Y+cZ3G+vjroRi9j5F2w==
X-Received: by 2002:a05:6402:2813:: with SMTP id h19mr34848542ede.39.1624910253482;
        Mon, 28 Jun 2021 12:57:33 -0700 (PDT)
Received: from gmail.com (94-21-131-96.pool.digikabel.hu. [94.21.131.96])
        by smtp.gmail.com with ESMTPSA id x17sm10350154edr.88.2021.06.28.12.57.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Jun 2021 12:57:33 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Mon, 28 Jun 2021 21:57:31 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH] sched/core: Disable CONFIG_SCHED_CORE by default
Message-ID: <YNopqw/BbJGjOGMq@gmail.com>
References: <YNlxcCpk4shGcPrU@gmail.com>
 <CAHk-=wisVoq7COhA-B+5UAbisJqTn7Sehh-brqn6K3UVuFzoew@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wisVoq7COhA-B+5UAbisJqTn7Sehh-brqn6K3UVuFzoew@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Sun, Jun 27, 2021 at 11:51 PM Ingo Molnar <mingo@kernel.org> wrote:
> >
> >     - Add "Core Scheduling" via CONFIG_SCHED_CORE=y,
> 
> Grr.
> 
> Why is this feature "default y"? I see no reason why anybody would
> enable it outside of cloud providers, which doesn't argue for it being
> on by default.

You are completely right, I missed this. Find below the patch to fix it - 
feel free to apply it directly, will rebase sched/urgent accordingly.

Thanks,

	Ingo

=====================>
From: Ingo Molnar <mingo@kernel.org>
Date: Mon, 28 Jun 2021 21:55:16 +0200
Subject: [PATCH] sched/core: Disable CONFIG_SCHED_CORE by default

This option adds extra overhead to the scheduler, and most users wouldn't want it.

Reported-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/Kconfig.preempt | 1 -
 1 file changed, 1 deletion(-)

diff --git a/kernel/Kconfig.preempt b/kernel/Kconfig.preempt
index bd7c4147b9a8..3654a92e7e70 100644
--- a/kernel/Kconfig.preempt
+++ b/kernel/Kconfig.preempt
@@ -102,7 +102,6 @@ config PREEMPT_DYNAMIC
 
 config SCHED_CORE
 	bool "Core Scheduling for SMT"
-	default y
 	depends on SCHED_SMT
 	help
 	  This option permits Core Scheduling, a means of coordinated task
