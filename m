Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0231644ABCA
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Nov 2021 11:47:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245443AbhKIKuO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Nov 2021 05:50:14 -0500
Received: from foss.arm.com ([217.140.110.172]:60074 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243061AbhKIKuM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Nov 2021 05:50:12 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A44B6ED1;
        Tue,  9 Nov 2021 02:47:26 -0800 (PST)
Received: from e113632-lin (e113632-lin.cambridge.arm.com [10.1.196.57])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2F4283F7F5;
        Tue,  9 Nov 2021 02:47:25 -0800 (PST)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Yafang Shao <laoar.shao@gmail.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Benjamin Segall <bsegall@google.com>,
        Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH 2/4] sched/fair: Introduce cfs_migration
In-Reply-To: <CALOAHbAHQ0UBn2GqRNWQwH32UPOuFo0b550oi6WCKr8+wFgdsw@mail.gmail.com>
References: <20211104145713.4419-1-laoar.shao@gmail.com> <20211104145713.4419-3-laoar.shao@gmail.com> <87a6iitu3r.mognet@arm.com> <CALOAHbAHQ0UBn2GqRNWQwH32UPOuFo0b550oi6WCKr8+wFgdsw@mail.gmail.com>
Date:   Tue, 09 Nov 2021 10:47:22 +0000
Message-ID: <87tuglsj0l.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/11/21 15:40, Yafang Shao wrote:
> It seems we'd better take the patch[1] I sent several weeks back.
>
> [1]. https://lore.kernel.org/lkml/20210615121551.31138-1-laoar.shao@gmail.com/
>

As Peter stated in that thread, this only reduces the race window and
doesn't eliminate it. The FIFO-1 smpboot idea is still a good one IMO.

> --
> Thanks
> Yafang
