Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1489330E2BA
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 19:44:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233076AbhBCSoc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 13:44:32 -0500
Received: from foss.arm.com ([217.140.110.172]:45066 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232524AbhBCSoE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 13:44:04 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8D9A0143B;
        Wed,  3 Feb 2021 10:43:19 -0800 (PST)
Received: from e113632-lin (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3BB003F719;
        Wed,  3 Feb 2021 10:43:18 -0800 (PST)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Qais Yousef <qais.yousef@arm.com>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Quentin Perret <qperret@google.com>,
        Pavan Kondeti <pkondeti@codeaurora.org>,
        Rik van Riel <riel@surriel.com>
Subject: Re: [PATCH 7/8] sched/fair: Attempt misfit active balance when migration_type != migrate_misfit
In-Reply-To: <20210203151647.ygvlktrivpw4a7qh@e107158-lin>
References: <20210128183141.28097-1-valentin.schneider@arm.com> <20210128183141.28097-8-valentin.schneider@arm.com> <20210203151647.ygvlktrivpw4a7qh@e107158-lin>
User-Agent: Notmuch/0.21 (http://notmuchmail.org) Emacs/26.3 (x86_64-pc-linux-gnu)
Date:   Wed, 03 Feb 2021 18:43:16 +0000
Message-ID: <jhjk0rp2drv.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/02/21 15:16, Qais Yousef wrote:
> On 01/28/21 18:31, Valentin Schneider wrote:
>> Giving group_misfit_task a higher group_classify() priority than
>> group_imbalance doesn't seem like the right thing to do. Instead, make
>> need_active_balance() return true for any migration_type when the
>
> s/need_active_balance()/voluntary_active_balance()/?
>
>> destination CPU is idle and the source CPU has a misfit task.
>> 
>> While at it, add an sd_has_asym_cpucapacity() guard in
>> need_active_balance().
>
> ditto.
>

Myes, clearly this has been left to ferment for too long!
