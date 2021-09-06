Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10B1D401B66
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Sep 2021 14:47:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242270AbhIFMsX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Sep 2021 08:48:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:53460 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231287AbhIFMsW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Sep 2021 08:48:22 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 14F6160F92;
        Mon,  6 Sep 2021 12:47:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630932438;
        bh=CbDkbvxjPcxwXaFEf7t78nf9nMVCe/HPx007TVFxN38=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HKXbS3yGVN07GSb8ZtJbjK6lAm6BP1Oz51r7V1g/Dfer1dsxMgpySv9w2qBpMU+f/
         MRvNidynlIJwODWki9dwhdJR4U8aK8uhuPqVXk2VB88YzOlAn9FhAKx1/hOm3c2R1o
         BV7Oa3JPm+Lo8tTO34aKMekl+yvvkdsImFOu59U/iRBVgPZCHShmIteua0aREurcoe
         AlViNlrPeztEYKZR/JNjqixJcmiVqjl5N14WUZ9l2rBaC3Hffp0ESEGRQdZPZyCtKM
         0NYQp24wguHn2Yyuw9WHNdh0/dSKxBr7iZySUYVWYLuYFswn+q7pPzwFex7w9HJbkW
         huMJUBH+iaXnQ==
From:   alexs@kernel.org
To:     alexs@kernel.org, Ingo Molnar <mingo@redhat.com>,
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
Subject: Re: [PATCH v3 1/4] sched: cgroup SCHED_IDLE support
Date:   Mon,  6 Sep 2021 20:47:02 +0800
Message-Id: <20210820010403.946838-2-joshdon@google.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210820010403.946838-1-joshdon@google.com>
References: <20210820010403.946838-1-joshdon@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.33.0.rc2.250.ged5fa647cd-goog
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

...
 
> For now, we maintain the existing SCHED_IDLE semantics. Future patches
> may make improvements that extend how we treat SCHED_IDLE entities.
> 
> The per-task_group idle field is an integer that currently only holds
> either a 0 or a 1. This is explicitly typed as an integer to allow for
> further extensions to this API. For example, a negative value may
> indicate a highly latency-sensitive cgroup that should be preferred for
> preemption/placement/etc.

Hi Josh,

Sounds there is a ready solutions for colocation problem, isn't there?
I'd like to evaluate its effects if it could be sent out.

Thanks
Alex
> 
