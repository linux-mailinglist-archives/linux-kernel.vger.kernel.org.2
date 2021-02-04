Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C44730F2A8
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 12:46:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235895AbhBDLpi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 06:45:38 -0500
Received: from foss.arm.com ([217.140.110.172]:56858 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235830AbhBDLp3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 06:45:29 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 15BEED6E;
        Thu,  4 Feb 2021 03:44:44 -0800 (PST)
Received: from [192.168.178.6] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 298063F73B;
        Thu,  4 Feb 2021 03:44:41 -0800 (PST)
Subject: Re: [PATCH 7/8] sched/fair: Attempt misfit active balance when
 migration_type != migrate_misfit
To:     Valentin Schneider <valentin.schneider@arm.com>,
        Qais Yousef <qais.yousef@arm.com>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Quentin Perret <qperret@google.com>,
        Pavan Kondeti <pkondeti@codeaurora.org>,
        Rik van Riel <riel@surriel.com>
References: <20210128183141.28097-1-valentin.schneider@arm.com>
 <20210128183141.28097-8-valentin.schneider@arm.com>
 <20210203151647.ygvlktrivpw4a7qh@e107158-lin> <jhjk0rp2drv.mognet@arm.com>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <aefdb891-8567-4ebc-4308-336159feb305@arm.com>
Date:   Thu, 4 Feb 2021 12:44:40 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <jhjk0rp2drv.mognet@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/02/2021 19:43, Valentin Schneider wrote:
> On 03/02/21 15:16, Qais Yousef wrote:
>> On 01/28/21 18:31, Valentin Schneider wrote:
>>> Giving group_misfit_task a higher group_classify() priority than
>>> group_imbalance doesn't seem like the right thing to do. Instead, make
>>> need_active_balance() return true for any migration_type when the
>>
>> s/need_active_balance()/voluntary_active_balance()/?
>>
>>> destination CPU is idle and the source CPU has a misfit task.
>>>
>>> While at it, add an sd_has_asym_cpucapacity() guard in
>>> need_active_balance().
>>
>> ditto.
>>
> 
> Myes, clearly this has been left to ferment for too long!

Wasn't the migrate_misfit condition moved from
voluntary_active_balance() into need_active_balance() by commit
("sched/fair: Reduce cases for active balance")?
