Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CEEFA368717
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Apr 2021 21:19:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238919AbhDVTUX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Apr 2021 15:20:23 -0400
Received: from foss.arm.com ([217.140.110.172]:55178 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238468AbhDVTUT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Apr 2021 15:20:19 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id ADD031474;
        Thu, 22 Apr 2021 12:19:44 -0700 (PDT)
Received: from e113632-lin (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3E6F73F694;
        Thu, 22 Apr 2021 12:19:43 -0700 (PDT)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Vincent Guittot <vincent.guittot@linaro.org>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Qais Yousef <qais.yousef@arm.com>,
        Quentin Perret <qperret@google.com>,
        Pavan Kondeti <pkondeti@codeaurora.org>,
        Rik van Riel <riel@surriel.com>,
        Lingutla Chandrasekhar <clingutla@codeaurora.org>
Subject: Re: [PATCH 2/2] sched/fair: Relax task_hot() for misfit tasks
In-Reply-To: <c88ec0a7-b69c-5ab1-5302-65573a3b050f@arm.com>
References: <20210415175846.494385-1-valentin.schneider@arm.com> <20210415175846.494385-3-valentin.schneider@arm.com> <20210416135113.GA16445@vingu-book> <87blaakxji.mognet@arm.com> <CAKfTPtCLNeSzMLO_7uhj13k6CgtzAMhcW5aXJTYUOSYJZi220w@mail.gmail.com> <878s5bvrij.mognet@arm.com> <c88ec0a7-b69c-5ab1-5302-65573a3b050f@arm.com>
Date:   Thu, 22 Apr 2021 20:19:40 +0100
Message-ID: <87pmymt9df.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/04/21 19:29, Dietmar Eggemann wrote:
> Just to make sure I can follow the conversation ...
>
> In case you:
>
> (1) return 1 instead of -1
>
> (2) keep the `env->idle != CPU_NOT_IDLE` check
>
> (3) and remove the `dst_grp_type == group_has_spare` check
>
> you are pretty much back to what you had in [PATCH v3 7/7] directly in
> task_hot() except:
>
> (4) the 'if (p fits on src_cpu && p !fits dst_cpu) => tsk_cache_hot) check?

Pretty much, I'll now filter the return value of task_hot() rather than
affect it directly.
