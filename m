Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD26C314E6F
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Feb 2021 12:49:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230043AbhBILs6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 06:48:58 -0500
Received: from foss.arm.com ([217.140.110.172]:50294 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230148AbhBILqw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 06:46:52 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F0A63ED1;
        Tue,  9 Feb 2021 03:46:06 -0800 (PST)
Received: from e113632-lin (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D59153F73B;
        Tue,  9 Feb 2021 03:46:04 -0800 (PST)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Vincent Guittot <vincent.guittot@linaro.org>,
        Barry Song <song.bao.hua@hisilicon.com>
Cc:     Mel Gorman <mgorman@suse.de>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linuxarm@openeuler.org, "xuwei \(O\)" <xuwei5@huawei.com>,
        "Liguozhu \(Kenneth\)" <liguozhu@hisilicon.com>,
        tiantao6@hisilicon.com, wanghuiqiang@huawei.com,
        "Zengtao \(B\)" <prime.zeng@hisilicon.com>,
        Jonathan Cameron <jonathan.cameron@huawei.com>,
        Guodong Xu <guodong.xu@linaro.org>,
        Meelis Roos <mroos@linux.ee>
Subject: Re: [PATCH v3] sched/topology: fix the issue groups don't span domain->span for NUMA diameter > 2
In-Reply-To: <CAKfTPtCuJoS=Z2nOmeH6y_KTSjw9=hwrZ2N78VgC-ZQwz1d8FQ@mail.gmail.com>
References: <20210209082125.22176-1-song.bao.hua@hisilicon.com> <CAKfTPtCuJoS=Z2nOmeH6y_KTSjw9=hwrZ2N78VgC-ZQwz1d8FQ@mail.gmail.com>
User-Agent: Notmuch/0.21 (http://notmuchmail.org) Emacs/26.3 (x86_64-pc-linux-gnu)
Date:   Tue, 09 Feb 2021 11:46:02 +0000
Message-ID: <jhjzh0dtqf9.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/02/21 10:46, Vincent Guittot wrote:
> On Tue, 9 Feb 2021 at 09:27, Barry Song <song.bao.hua@hisilicon.com> wrote:
>> Real servers which suffer from this problem include Kunpeng920 and 8-node
>> Sun Fire X4600-M2, at least.
>>
>> Here we move to use the *child* domain of the *child* domain of node2's
>> domain2 as the new added sched_group. At the same, we re-use the lower
>> level sgc directly.
>
> Have you evaluated the impact on the imbalance and next_update fields ?
>

sgc->next_update is safe since it's only touched by CPUs that have the
group span as local group (which is never the case for CPUs where we do
this "grandchildren" trick).

I'm a bit less clear about sgc->imbalance. I think it can be set by remote
CPUs, but it should only be cleared when running load_balance() by CPUs
that have that group span as local group, as per:

  int *group_imbalance = &sd_parent->groups->sgc->imbalance;
