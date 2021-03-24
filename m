Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8884E347D56
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 17:11:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229653AbhCXQLV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 12:11:21 -0400
Received: from foss.arm.com ([217.140.110.172]:35674 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229889AbhCXQK7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 12:10:59 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 79D35D6E;
        Wed, 24 Mar 2021 09:10:58 -0700 (PDT)
Received: from e107158-lin (e107158-lin.cambridge.arm.com [10.1.195.57])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3F8BB3F7D7;
        Wed, 24 Mar 2021 09:10:57 -0700 (PDT)
Date:   Wed, 24 Mar 2021 16:10:54 +0000
From:   Qais Yousef <qais.yousef@arm.com>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     Alexander Sverdlin <alexander.sverdlin@nokia.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Ard Biesheuvel <ardb@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v7 2/2] ARM: ftrace: Add MODULE_PLTS support
Message-ID: <20210324161054.pg5272lh45n364ko@e107158-lin>
References: <e726be33-bc03-0515-f430-c5a34ebc3619@nokia.com>
 <20210312172401.36awjh4hmj4cs6ot@e107158-lin.cambridge.arm.com>
 <134e1a2c-daac-7b00-c170-bcca434d08df@gmail.com>
 <20210314220217.4mexdide7sqjfved@e107158-lin>
 <20210321190611.d6a3hbqabts3qq5v@e107158-lin>
 <20210322110106.2bed3d50@gandalf.local.home>
 <20210322163248.id7qplbk6och6kuw@e107158-lin>
 <504d72ec-70a6-7e50-dbbb-16d693ce6150@nokia.com>
 <20210323222230.2d63hdcxq6strbug@e107158-lin>
 <2404ff10-7acc-3946-6592-31508f257f33@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2404ff10-7acc-3946-6592-31508f257f33@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Florian

On 03/23/21 20:37, Florian Fainelli wrote:
> Hi Qais,
> 
> On 3/23/2021 3:22 PM, Qais Yousef wrote:
> > Hi Alexander
> > 
> > On 03/22/21 18:02, Alexander Sverdlin wrote:
> >> Hi Qais,
> >>
> >> On 22/03/2021 17:32, Qais Yousef wrote:
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
> >>
> >> well, I of course prefer v7 as-is, because this review is running longer than two
> >> years and I actually hope these patches to be finally merged at some point.
> >> But you are welcome to optimize them with follow up patches :)
> > 
> > I appreciate that and thanks a lot for your effort. My attempt to review and
> > test here is to help in getting this merged.
> > 
> > FWIW my main concern is about duplicating the range check in
> > ftrace_call_replace() and using magic values that already exist in
> > __arm_gen_branch_{arm, thumb2}() and better remain encapsulated there.
> 
> Your patch in addition to Alexander's patch work for me as well, so feel
> free to add a:
> 
> Tested-by: Florian Fainelli <f.fainelli@gmail.com>
> 
> FWIW, what is nice about Alexander's original patch is that it applies
> relatively cleanly to older kernels as well where this is equally

How old are we talking? Was the conflict that bad for the stable maintainers to
deal with it? ie: would it require sending the backport separately?

> needed. There is not currently any Fixes: tag being provided but maybe
> we should amend the second patch with one?

I'm not sure if this will be considered new feature or a bug fix. FWIW,
tagging it for stable sounds reasonable to me.

Thanks!

--
Qais Yosuef
