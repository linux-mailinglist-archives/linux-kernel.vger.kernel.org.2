Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7134133DCFF
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 20:00:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240230AbhCPS7i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 14:59:38 -0400
Received: from foss.arm.com ([217.140.110.172]:56978 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240222AbhCPS7d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 14:59:33 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DDC59D6E;
        Tue, 16 Mar 2021 11:59:32 -0700 (PDT)
Received: from [192.168.178.6] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2005E3F70D;
        Tue, 16 Mar 2021 11:59:30 -0700 (PDT)
Subject: Re: [PATCH v3 1/7] sched/fair: Ignore percpu threads for imbalance
 pulls
To:     Chandra Sekhar Lingutla <clingutla@codeaurora.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        linux-kernel@vger.kernel.org
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Qais Yousef <qais.yousef@arm.com>,
        Quentin Perret <qperret@google.com>,
        Pavan Kondeti <pkondeti@codeaurora.org>,
        Rik van Riel <riel@surriel.com>
References: <20210311120527.167870-1-valentin.schneider@arm.com>
 <20210311120527.167870-2-valentin.schneider@arm.com>
 <bdea6c4f-262b-c3cb-637e-d4896e688dd3@arm.com>
 <e113aa70-c26b-c43f-a113-5a3b66793e46@codeaurora.org>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <bdf93696-f863-9029-860f-771432d5ec22@arm.com>
Date:   Tue, 16 Mar 2021 19:59:19 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <e113aa70-c26b-c43f-a113-5a3b66793e46@codeaurora.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chandra,

On 16/03/2021 17:03, Chandra Sekhar Lingutla wrote:
> Hi Dietmar,
> 
> On 3/16/2021 9:19 PM, Dietmar Eggemann wrote:
>> On 11/03/2021 13:05, Valentin Schneider wrote:
>>> From: Lingutla Chandrasekhar <clingutla@codeaurora.org>

[...]

>>> CPUs 2-3 as Bigs with below scenario:
>>> - CPU0 doing newly_idle balancing
>>> - CPU1 running percpu kworker and RT task (small tasks)
>> What's the role of the small RT task here in the story?
> This is to satisfy 'busiest->nr_running > 1' checks.

Ah, I see. Forgot about this bit of the story, the 'if
(busiest->nr_running > 1)' in load_balance().

[...]
