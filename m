Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 980FD35E4C7
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Apr 2021 19:14:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232629AbhDMRPJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Apr 2021 13:15:09 -0400
Received: from foss.arm.com ([217.140.110.172]:45234 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230074AbhDMRPI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Apr 2021 13:15:08 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1C22D11B3;
        Tue, 13 Apr 2021 10:14:48 -0700 (PDT)
Received: from [192.168.178.6] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 67A713F73B;
        Tue, 13 Apr 2021 10:14:46 -0700 (PDT)
Subject: Re: [PATCH] sched: remove the redundant comments
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Hui Su <suhui@zeku.com>, mingo@redhat.com, peterz@infradead.org,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        bsegall@google.com, mgorman@suse.de, bristot@redhat.com,
        linux-kernel@vger.kernel.org
References: <20210412073928.1120823-1-suhui@zeku.com>
 <d9c447fd-d3f5-cb66-b3a9-7f7002594ccc@arm.com>
 <20210413122804.2d69fca6@gandalf.local.home>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <c1bcedd9-a2d3-55db-1821-af2db27517de@arm.com>
Date:   Tue, 13 Apr 2021 19:14:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210413122804.2d69fca6@gandalf.local.home>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/04/2021 18:28, Steven Rostedt wrote:
> On Tue, 13 Apr 2021 10:36:07 +0200
> Dietmar Eggemann <dietmar.eggemann@arm.com> wrote:

[...]

>> Add a
>>
>>   Fixes: 55627e3cd22c ("sched/core: Remove rq->cpu_load[]")
>>
>> line.
> 
> It's just removing a comment. Should it really need a "Fixes" tag, which
> will cause many people to look at it to determine if it should be
> backported to stable?

I see, in this case let's skip it.
