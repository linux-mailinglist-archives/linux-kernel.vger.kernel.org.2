Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E26A0347D23
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 16:57:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236903AbhCXP5Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 11:57:25 -0400
Received: from foss.arm.com ([217.140.110.172]:35550 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236883AbhCXP5E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 11:57:04 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DC726D6E;
        Wed, 24 Mar 2021 08:57:03 -0700 (PDT)
Received: from e107158-lin (e107158-lin.cambridge.arm.com [10.1.195.57])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A529C3F7D7;
        Wed, 24 Mar 2021 08:57:02 -0700 (PDT)
Date:   Wed, 24 Mar 2021 15:57:00 +0000
From:   Qais Yousef <qais.yousef@arm.com>
To:     Alexander Sverdlin <alexander.sverdlin@nokia.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Ard Biesheuvel <ardb@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Florian Fainelli <f.fainelli@gmail.com>
Subject: Re: [PATCH v7 2/2] ARM: ftrace: Add MODULE_PLTS support
Message-ID: <20210324155700.ktcgpeabk2fuamti@e107158-lin>
References: <e726be33-bc03-0515-f430-c5a34ebc3619@nokia.com>
 <20210312172401.36awjh4hmj4cs6ot@e107158-lin.cambridge.arm.com>
 <134e1a2c-daac-7b00-c170-bcca434d08df@gmail.com>
 <20210314220217.4mexdide7sqjfved@e107158-lin>
 <20210321190611.d6a3hbqabts3qq5v@e107158-lin>
 <20210322110106.2bed3d50@gandalf.local.home>
 <20210322163248.id7qplbk6och6kuw@e107158-lin>
 <504d72ec-70a6-7e50-dbbb-16d693ce6150@nokia.com>
 <20210323222230.2d63hdcxq6strbug@e107158-lin>
 <25056e99-dfd1-645b-39fc-14f47085a7fe@nokia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <25056e99-dfd1-645b-39fc-14f47085a7fe@nokia.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Alexander

On 03/24/21 10:04, Alexander Sverdlin wrote:
> Hi Qais,
> 
> On 23/03/2021 23:22, Qais Yousef wrote:
> >>> Yes you're right. I was a bit optimistic on CONFIG_DYNAMIC_FTRACE will imply
> >>> CONFIG_ARM_MODULE_PLTS is enabled too.
> >>>
> >>> It only has an impact on reducing ifdefery when calling
> >>>
> >>> 	ftrace_call_replace_mod(rec->arch.mod, ...)
> >>>
> >>> Should be easy to wrap rec->arch.mod with its own accessor that will return
> >>> NULL if !CONFIG_ARM_MODULE_PLTS or just ifdef the functions.
> >>>
> >>> Up to Alexander to pick what he prefers :-)
> >> well, I of course prefer v7 as-is, because this review is running longer than two
> >> years and I actually hope these patches to be finally merged at some point.
> >> But you are welcome to optimize them with follow up patches :)
> > I appreciate that and thanks a lot for your effort. My attempt to review and
> > test here is to help in getting this merged.
> > 
> > FWIW my main concern is about duplicating the range check in
> > ftrace_call_replace() and using magic values that already exist in
> > __arm_gen_branch_{arm, thumb2}() and better remain encapsulated there.
> 
> could you please check the negative limits? I have an opinion, my limits are
> correct. I could add extra parameter to arm_gen_branch_link(), but for this
> I first need to fix its negative limits, which, I believe, well... Approximate :)

Can you elaborate please?

If you look at Arm ARM [1] the ranges are defined in page 347

	Encoding T1 Even numbers in the range –16777216 to 16777214.
	Encoding T2 Multiples of 4 in the range –16777216 to 16777212.
	Encoding A1 Multiples of 4 in the range –33554432 to 33554428.
	Encoding A2 Even numbers in the range –33554432 to 33554430.

which matches what's in the code (T1 for thumb2 and A1 for arm).

Why do you think it's wrong?

Thanks

--
Qais Yousef

[1] https://developer.arm.com/documentation/ddi0406/latest/
