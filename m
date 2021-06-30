Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8B153B8155
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jun 2021 13:31:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234385AbhF3Le0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Jun 2021 07:34:26 -0400
Received: from foss.arm.com ([217.140.110.172]:35878 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234319AbhF3LeX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jun 2021 07:34:23 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E0A8BD6E;
        Wed, 30 Jun 2021 04:31:54 -0700 (PDT)
Received: from e113632-lin (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id ED73A3F5A1;
        Wed, 30 Jun 2021 04:31:51 -0700 (PDT)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Xuewen Yan <xuewen.yan94@gmail.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Benjamin Segall <bsegall@google.com>,
        Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Patrick Bellasi <patrick.bellasi@matbug.net>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Quentin Perret <qperret@google.com>,
        Qais Yousef <qais.yousef@arm.com>
Subject: Re: [PATCH] sched/uclamp: Fix getting unreasonable ucalmp_max when rq is idle
In-Reply-To: <CAB8ipk9TMTbw2WGrbLuewk_CaYxrvMOp2Ui5xiHiwYB4NmoRhA@mail.gmail.com>
References: <20210618072349.503-1-xuewen.yan94@gmail.com> <87fsx093vm.mognet@arm.com> <CAB8ipk9TMTbw2WGrbLuewk_CaYxrvMOp2Ui5xiHiwYB4NmoRhA@mail.gmail.com>
Date:   Wed, 30 Jun 2021 12:31:45 +0100
Message-ID: <87czs38u72.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/06/21 09:24, Xuewen Yan wrote:
> On Tue, Jun 29, 2021 at 9:50 PM Valentin Schneider
> <valentin.schneider@arm.com> wrote:
>> +       min_util = max_t(unsigned long, min_util, READ_ONCE(rq->uclamp[UCLAMP_MIN].value));
>> +       max_util = max_t(unsigned long, max_util, READ_ONCE(rq->uclamp[UCLAMP_MAX].value));
>
> Is it necessary to use max_t here? although it is not the main problem...
>

I got comparison warnings when using a regular max() - the RQ clamp values
are unsigned int, whereas the local variable is unsigned long.

>> +out:
>>         /*
>>          * Since CPU's {min,max}_util clamps are MAX aggregated considering
>>          * RUNNABLE tasks with _different_ clamps, we can end up with an
>
> Thanks!
> xuewen
