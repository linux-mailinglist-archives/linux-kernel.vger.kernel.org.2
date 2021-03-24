Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A00CB347E24
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 17:47:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237009AbhCXQrL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 12:47:11 -0400
Received: from foss.arm.com ([217.140.110.172]:36308 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237102AbhCXQqv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 12:46:51 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E0412D6E;
        Wed, 24 Mar 2021 09:46:50 -0700 (PDT)
Received: from e107158-lin (e107158-lin.cambridge.arm.com [10.1.195.57])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AAA703F7D7;
        Wed, 24 Mar 2021 09:46:49 -0700 (PDT)
Date:   Wed, 24 Mar 2021 16:46:47 +0000
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
Message-ID: <20210324164647.ebqvb7ll3l2fbswr@e107158-lin>
References: <134e1a2c-daac-7b00-c170-bcca434d08df@gmail.com>
 <20210314220217.4mexdide7sqjfved@e107158-lin>
 <20210321190611.d6a3hbqabts3qq5v@e107158-lin>
 <20210322110106.2bed3d50@gandalf.local.home>
 <20210322163248.id7qplbk6och6kuw@e107158-lin>
 <504d72ec-70a6-7e50-dbbb-16d693ce6150@nokia.com>
 <20210323222230.2d63hdcxq6strbug@e107158-lin>
 <25056e99-dfd1-645b-39fc-14f47085a7fe@nokia.com>
 <20210324155700.ktcgpeabk2fuamti@e107158-lin>
 <169a0b1e-beee-bae6-8625-9b9ceb8bb0ea@nokia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <169a0b1e-beee-bae6-8625-9b9ceb8bb0ea@nokia.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/24/21 17:33, Alexander Sverdlin wrote:
> Hello Qais,
> 
> On 24/03/2021 16:57, Qais Yousef wrote:
> >>> FWIW my main concern is about duplicating the range check in
> >>> ftrace_call_replace() and using magic values that already exist in
> >>> __arm_gen_branch_{arm, thumb2}() and better remain encapsulated there.
> >> could you please check the negative limits? I have an opinion, my limits are
> >> correct. I could add extra parameter to arm_gen_branch_link(), but for this
> >> I first need to fix its negative limits, which, I believe, well... Approximate :)
> > Can you elaborate please?
> > 
> > If you look at Arm ARM [1] the ranges are defined in page 347
> > 
> > 	Encoding T1 Even numbers in the range –16777216 to 16777214.
> > 	Encoding T2 Multiples of 4 in the range –16777216 to 16777212.
> > 	Encoding A1 Multiples of 4 in the range –33554432 to 33554428.
> > 	Encoding A2 Even numbers in the range –33554432 to 33554430.
> > 
> > which matches what's in the code (T1 for thumb2 and A1 for arm).
> > 
> > Why do you think it's wrong?
> 
> thanks for checking this! I'll re-send v8 with your proposal.

If you felt some details need tweaking I don't mind, my proposal was an attempt
to help rather than impose.

Thanks!

--
Qais Yousef
