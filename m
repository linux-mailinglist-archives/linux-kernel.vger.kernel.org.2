Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CA3D35E201
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Apr 2021 16:55:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231858AbhDMOzn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Apr 2021 10:55:43 -0400
Received: from foss.arm.com ([217.140.110.172]:43588 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231378AbhDMOzl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Apr 2021 10:55:41 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6360D106F;
        Tue, 13 Apr 2021 07:55:21 -0700 (PDT)
Received: from e113632-lin (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 99ACC3F694;
        Tue, 13 Apr 2021 07:55:19 -0700 (PDT)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Peter Zijlstra <peterz@infradead.org>, mingo@kernel.org,
        mgorman@suse.de, juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        bristot@redhat.com, joshdon@google.com
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org, greg@kroah.com,
        linux@rasmusvillemoes.dk
Subject: Re: [PATCH v2 7/9] sched,debug: Convert sysctl sched_domains to debugfs
In-Reply-To: <20210412102001.485107586@infradead.org>
References: <20210412101421.609526370@infradead.org> <20210412102001.485107586@infradead.org>
Date:   Tue, 13 Apr 2021 15:55:15 +0100
Message-ID: <87lf9mmdyk.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/04/21 12:14, Peter Zijlstra wrote:
> Stop polluting sysctl, move to debugfs for SCHED_DEBUG stuff.
>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Reviewed-by: Dietmar Eggemann <dietmar.eggemann@arm.com>

On my Juno (2+4 big.LITTLE), sys/kernel/debug/sched/domains/ is now empty.

I think that's because of unregister_sched_domain_sysctl() -
debugfs_remove() is recursive, and I do get a case where we rebuild the
domains but no CPU has been added or removed (we rebuild the domains when
cpufreq kicks in, it's part of the big.LITTLE ponies).

Do we actually still need that unregister? From a brief glance it looks
like we could throw it out.
