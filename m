Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13831324FBE
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Feb 2021 13:16:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233797AbhBYMPq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Feb 2021 07:15:46 -0500
Received: from foss.arm.com ([217.140.110.172]:56850 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230142AbhBYMP3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Feb 2021 07:15:29 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B9F8CD6E;
        Thu, 25 Feb 2021 04:14:41 -0800 (PST)
Received: from e113632-lin (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F147B3F73D;
        Thu, 25 Feb 2021 04:14:39 -0800 (PST)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Qais Yousef <qais.yousef@arm.com>
Subject: Re: [PATCH 0/7 v4] move update blocked load outside newidle_balance
In-Reply-To: <CAKfTPtDjVBP676kzW-5QF8nMyD1+WNnJWH4=gKPVV+55tm3Cng@mail.gmail.com>
References: <20210224133007.28644-1-vincent.guittot@linaro.org> <jhjblc95mo0.mognet@arm.com> <CAKfTPtDjVBP676kzW-5QF8nMyD1+WNnJWH4=gKPVV+55tm3Cng@mail.gmail.com>
User-Agent: Notmuch/0.21 (http://notmuchmail.org) Emacs/26.3 (x86_64-pc-linux-gnu)
Date:   Thu, 25 Feb 2021 12:14:37 +0000
Message-ID: <jhj1rd45ope.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/02/21 09:05, Vincent Guittot wrote:
>> One last thing for patch 7: mayhaps we could do a tad better to avoid
>> duplicate updates going through a heapful of leaf cfs rqs, see
>>
>>   http://lore.kernel.org/r/jhj4kiht7oh.mognet@arm.com
>
> rq->last_blocked_load_update_tick is there only to filter duplicate
> update during _nohz_idle_balance but not for other normal LB.
>

Right, update_nohz_stats() is now only used in _nohz_idle_balance()...
IIUC the pattern being covered here would be a CPUX getting kicked for nohz
stats/balance, then some CPUX-N (so it gets picked by find_new_ilb())
entering idle and getting kick in turn (less than a jiffy apart). 

