Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75F0044F366
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Nov 2021 14:38:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235870AbhKMNkx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Nov 2021 08:40:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:49996 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231672AbhKMNkw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Nov 2021 08:40:52 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2E2B561051;
        Sat, 13 Nov 2021 13:38:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636810680;
        bh=1n037ptkBRztnyf51N7U+6F0EfKr+shikhl40lxA1Us=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mKJYSplWDFT1uwiB+7sF6dcqvvWBAj1moiOYLX+7XQLhItxSnS7GJBzSTw3wikd+i
         cIKu/IzA+ZVTeyyKjfzzOI5ODqnKv5gfX2LKnb3hpOO2gpYcbY0fDwOmWhwCY+gH5f
         GU5GwEGAT0gZI6r42sA/r4CO4nkNA8l5BWrkJzNmP37ds4U6wRIXvefgMlLw2LL4R9
         RZ3Y2Uh2PJuDnuYaN4+/RK2WfyfqVYIRaozgdXlkQ2rg5YP2HRpjoVlgZyuw7U35J2
         W0VeIe0LSsUdhrmHbgceT5Cd/cebWoNTVtjNBYRh7xOvfl0CmYF0KjHEkmeh0+7ej3
         csX2p3gbzRyrQ==
Date:   Sat, 13 Nov 2021 08:37:59 -0500
From:   Sasha Levin <sashal@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] tools/lib/lockdep: drop liblockdep
Message-ID: <YY+/t75dqrkDA9CM@sashalap>
References: <20211112151602.1378857-1-sashal@kernel.org>
 <CAHk-=wiAWDZRzzG8T7fiBBESM9S-Uzy7OFVY9iv-UwjpAbhp-Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <CAHk-=wiAWDZRzzG8T7fiBBESM9S-Uzy7OFVY9iv-UwjpAbhp-Q@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 12, 2021 at 11:16:14AM -0800, Linus Torvalds wrote:
>On Fri, Nov 12, 2021 at 7:16 AM Sasha Levin <sashal@kernel.org> wrote:
>>
>> TL;DR: While a tool like liblockdep is useful, it probably doesn't
>> belong within the kernel tree.
>
>I have eagerly applied this patch, because I wasn't too happy with
>that thing in the first place.

Thank you for providing the room for this experiment nonetheless.

>However - I do note that there's signs of liblockdep in the
>tools/include/ directory still.
>
>Some of those headers may now be dead, and should be removed, but I
>didn't end up trying to figure it out, so I left them alone.
>
>This stupid shell command
>
>    git grep -il liblockdep tools/include/ |
>        sed 's:tools/include/::' |
>        while read i; do echo; echo $i:; echo; git grep $i tools/ ; done
>
>seems to say that yes, the <linux/module.h> header in the tools
>directory is still used, but the rest of them seem to only reference
>other dead headers.
>
>Hmm? It would be lovely to clean those headers up too and get rid of
>them - because those headers are very much part of why I hated the
>whole liblockdep mess, and why I was so happy to immediately apply
>this patch..

Yup, there are remenants in the common header directory which need more
careful auditing before removing. I'll send a follow-up patch during one
of the early -rc cycles.

Thanks!

-- 
Thanks,
Sasha
