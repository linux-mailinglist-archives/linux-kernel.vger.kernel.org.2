Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21B01447EBA
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Nov 2021 12:17:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237035AbhKHLUe convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 8 Nov 2021 06:20:34 -0500
Received: from foss.arm.com ([217.140.110.172]:49188 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230269AbhKHLUa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Nov 2021 06:20:30 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F05DF2B;
        Mon,  8 Nov 2021 03:17:45 -0800 (PST)
Received: from e113632-lin (e113632-lin.cambridge.arm.com [10.1.196.57])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2FCDD3F800;
        Mon,  8 Nov 2021 03:17:45 -0800 (PST)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Mike Galbraith <efault@gmx.de>, linux-kernel@vger.kernel.org
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>
Subject: Re: [PATCH] sched: Tweak default dynamic preempt mode selection
In-Reply-To: <ff53a94401f8d6abe0303ee381f86bfb475ad354.camel@gmx.de>
References: <20211105104035.3112162-1-valentin.schneider@arm.com> <ff53a94401f8d6abe0303ee381f86bfb475ad354.camel@gmx.de>
Date:   Mon, 08 Nov 2021 11:17:38 +0000
Message-ID: <8735o6uca5.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/11/21 05:40, Mike Galbraith wrote:
> On Fri, 2021-11-05 at 10:40 +0000, Valentin Schneider wrote:
>> Commit c597bfddc9e9 ("sched: Provide Kconfig support for default dynamic
>> preempt mode") changed the selectable config names for the preemption
>> model. This means a config file must now select
>>
>>   CONFIG_PREEMPT_BEHAVIOUR=y
>>
>> rather than
>>
>>   CONFIG_PREEMPT=y
>>
>> to get a preemptible kernel. This means all arch config files need to be
>> updated - right now arm64 defconfig selects CONFIG_PREEMPT=y but ends up
>> with CONFIG_PREEMPT_NONE_BEHAVIOUR=y.
>>
>> Instead, have CONFIG_*PREEMPT be the selectable configs again, and make
>> them select their _BEHAVIOUR equivalent if CONFIG_PREEMPT_DYNAMIC is set.
>
>
> Is there any way to get to PREEMPT_RT in the first selection again as
> well?  I had created a behavior entry for RT (below) and inverted the
> dependency to make it appear in the initial selection again, but that's
> clearly not gonna fly.
>
> Starting with a 5.15 config, to select RT you currently must first
> select a model you don't want, then reject PREEMPT_DYNAMIC and you'll
> be offered the full menu of models immediately. With your patch added,
> that became worse.  After rejecting PREEMPT_DYNAMIC, I had to go
> through new 5.15+ options before finally being offered the full menu.
>

Do you mean at the syncconfig step? I've only really played with upstream
arm64 / x86 defconfigs and didn't have to fight with any prompts, though
yes for x86 the default-y PREEMPT_DYNAMIC makes it a bit annoying to select
PREEMPT_RT.
