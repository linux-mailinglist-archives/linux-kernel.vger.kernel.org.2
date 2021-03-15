Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA3B833C6C5
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Mar 2021 20:25:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233525AbhCOTZN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 15:25:13 -0400
Received: from foss.arm.com ([217.140.110.172]:37698 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232866AbhCOTYl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 15:24:41 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 581C5ED1;
        Mon, 15 Mar 2021 12:24:41 -0700 (PDT)
Received: from e113632-lin (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DEF863F718;
        Mon, 15 Mar 2021 12:24:39 -0700 (PDT)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Qais Yousef <qais.yousef@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Quentin Perret <qperret@google.com>,
        Pavan Kondeti <pkondeti@codeaurora.org>,
        Rik van Riel <riel@surriel.com>,
        Lingutla Chandrasekhar <clingutla@codeaurora.org>
Subject: Re: [PATCH v3 4/7] sched/fair: Introduce a CPU capacity comparison helper
In-Reply-To: <CAKfTPtCdT4Depo4BX4bT4tsYLxDRcfwx+znKpt7MU5GSTwEtDg@mail.gmail.com>
References: <20210311120527.167870-1-valentin.schneider@arm.com> <20210311120527.167870-5-valentin.schneider@arm.com> <CAKfTPtCdT4Depo4BX4bT4tsYLxDRcfwx+znKpt7MU5GSTwEtDg@mail.gmail.com>
Date:   Mon, 15 Mar 2021 19:24:37 +0000
Message-ID: <87sg4wrzii.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/03/21 15:24, Vincent Guittot wrote:
>> @@ -113,6 +113,13 @@ int __weak arch_asym_cpu_priority(int cpu)
>>   */
>>  #define fits_capacity(cap, max)        ((cap) * 1280 < (max) * 1024)
>>
>> +/*
>> + * The margin used when comparing CPU capacities.
>> + * is 'cap1' noticeably greater than 'cap2'
>> + *
>> + * (default: ~5%)
>> + */
>> +#define capacity_greater(cap1, cap2) ((cap1) * 1024 > (cap2) * 1078)
>
> defined but not used.
>
> Should be merged with next patch which start to use it
>

Will do.
