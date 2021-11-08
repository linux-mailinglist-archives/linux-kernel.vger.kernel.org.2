Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 170B1449814
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Nov 2021 16:22:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238975AbhKHPYt convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 8 Nov 2021 10:24:49 -0500
Received: from foss.arm.com ([217.140.110.172]:51290 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231776AbhKHPYr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Nov 2021 10:24:47 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B615BD6E;
        Mon,  8 Nov 2021 07:22:02 -0800 (PST)
Received: from e113632-lin (e113632-lin.cambridge.arm.com [10.1.196.57])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E976D3F718;
        Mon,  8 Nov 2021 07:22:01 -0800 (PST)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Mike Galbraith <efault@gmx.de>, linux-kernel@vger.kernel.org
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>
Subject: Re: [PATCH] sched: Tweak default dynamic preempt mode selection
In-Reply-To: <5543627ee8ac5337a74de4b9671240d617273607.camel@gmx.de>
References: <20211105104035.3112162-1-valentin.schneider@arm.com> <ff53a94401f8d6abe0303ee381f86bfb475ad354.camel@gmx.de> <8735o6uca5.mognet@arm.com> <5543627ee8ac5337a74de4b9671240d617273607.camel@gmx.de>
Date:   Mon, 08 Nov 2021 15:21:56 +0000
Message-ID: <87zgqesmej.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/11/21 13:27, Mike Galbraith wrote:
> On Mon, 2021-11-08 at 11:17 +0000, Valentin Schneider wrote:
>> On 06/11/21 05:40, Mike Galbraith wrote:
>> >
>> > Starting with a 5.15 config, to select RT you currently must first
>> > select a model you don't want, then reject PREEMPT_DYNAMIC and you'll
>> > be offered the full menu of models immediately. With your patch added,
>> > that became worse.  After rejecting PREEMPT_DYNAMIC, I had to go
>> > through new 5.15+ options before finally being offered the full menu.
>> >
>>
>> Do you mean at the syncconfig step?
>
> Um, not sure what that is, but it sounds about right.
>
>> I've only really played with upstream
>> arm64 / x86 defconfigs and didn't have to fight with any prompts, though
>> yes for x86 the default-y PREEMPT_DYNAMIC makes it a bit annoying to select
>> PREEMPT_RT.
>
> As long as RT depends on EXPERT it'll be a bit annoying regardless.  I
> just thought it worth mention that what you want now and what RT will
> presumably want upon merge completion appear to be mutually exclusive.
>

Hmm actually I think your approach should work, i.e. have

  config PREEMPT_DYNAMIC
    depends on [...] && !PREEMPT_RT

rather than

  config PREEMPT_RT
    depends on [...] && !PREEMPT_DYNAMIC

This essentially gives priority to the preemption model type over the
preemption model dynamicness, which I think makes sense. I can fold that in
v2.

>       -Mike
