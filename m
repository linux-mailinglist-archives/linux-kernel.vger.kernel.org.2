Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36E933AB58F
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jun 2021 16:11:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231648AbhFQONV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Jun 2021 10:13:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:60624 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231145AbhFQONT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jun 2021 10:13:19 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id BC6496128B;
        Thu, 17 Jun 2021 14:11:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623939071;
        bh=Zlbp6xL1xf3PskM9PhEp4wz+OJCI7NfCR625CwcZ8Yg=;
        h=In-Reply-To:References:Date:From:To:Cc:Subject:From;
        b=NrCGPIaTzqu5ZgtwR7rd4dkzl3KvflJ0zn4ZpNUJmEvvMciMWB0lqgX60asfXz/hM
         miCjtznBalwX/KLOM1e4ayyA6j5DORyMLuiUVqjejRmdMjefowOovK7BDB5tMp9vAO
         175v+wvY0tW1qVxrwY4skyjLaarSgHbBjtRsWWWb701cPg/lHS+cBy9AdbC7tyaEQ4
         RwdzkP/6PiRa8Kx//tH4mPa/jvAMKXaw3eR+vF1FtwO9a+Nu3E67pyFg3kkSTC/J5B
         u0tL6iatlaX/ZuPBkjJnhUMN5KT9iuOM/Iz8AW912lIaOqF/A26D1e4nAfbSeEJCUM
         qBE/4AGSp0/UA==
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailauth.nyi.internal (Postfix) with ESMTP id CECC127C005A;
        Thu, 17 Jun 2021 10:11:09 -0400 (EDT)
Received: from imap21 ([10.202.2.71])
  by compute2.internal (MEProxy); Thu, 17 Jun 2021 10:11:09 -0400
X-ME-Sender: <xms:_FfLYJK5MhZLUkYFWI-0xSln2bu582k8oEoh6JkjoL76rAJEOSJuxA>
    <xme:_FfLYFJL4PyLDxVoz1DvzTAuORk0500qCUg_djiKEq4R09MM1vdrqIXUrewi5FhAg
    XcluSWu7vM7wEE3fIg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrfeefuddgjedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvffutgesthdtredtreerjeenucfhrhhomhepfdetnhgu
    hicunfhuthhomhhirhhskhhifdcuoehluhhtoheskhgvrhhnvghlrdhorhhgqeenucggtf
    frrghtthgvrhhnpeeufedtffejtdeuieevgedtfeeffedttedukeeiffekgfejffdtvdff
    ffekjeejudenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuih
    iivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprghnugihodhmvghsmhhtphgruhht
    hhhpvghrshhonhgrlhhithihqdduudeiudekheeifedvqddvieefudeiiedtkedqlhhuth
    hopeepkhgvrhhnvghlrdhorhhgsehlihhnuhigrdhluhhtohdruhhs
X-ME-Proxy: <xmx:_FfLYBsWJLJhtLSlplmYLjKd8BYTYq8uBljKIOgeGMEiKgqm15rp3w>
    <xmx:_FfLYKYXAVU2gOW3KrwKfQUXDy_fx8EVEMdqijgnB2LisIBF1fDRlg>
    <xmx:_FfLYAb6ASoLtbnupY098BcLmmwqAtdajuk8rqpUEW32zA0f9I9KRA>
    <xmx:_VfLYA5OG8liM4ZcfcCId0g8XEh_mtlamhMztsnusQxhAxGHM48qyvERrL0>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id B47A451C0060; Thu, 17 Jun 2021 10:11:08 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.5.0-alpha0-526-gf020ecf851-fm-20210616.001-gf020ecf8
Mime-Version: 1.0
Message-Id: <e01859e4-2042-47fd-a3c6-fd65608b9b22@www.fastmail.com>
In-Reply-To: <YMsQ82bzly2KAUsu@hirez.programming.kicks-ass.net>
References: <cover.1623813516.git.luto@kernel.org>
 <f184d013a255a523116b692db4996c5db2569e86.1623813516.git.luto@kernel.org>
 <1623816595.myt8wbkcar.astroid@bobo.none>
 <YMmpxP+ANG5nIUcm@hirez.programming.kicks-ass.net>
 <617cb897-58b1-8266-ecec-ef210832e927@kernel.org>
 <1623893358.bbty474jyy.astroid@bobo.none>
 <58b949fb-663e-4675-8592-25933a3e361c@www.fastmail.com>
 <c3c7a1cf-1c87-42cc-b2d6-cc2df55e5b57@www.fastmail.com>
 <YMsQ82bzly2KAUsu@hirez.programming.kicks-ass.net>
Date:   Thu, 17 Jun 2021 07:10:41 -0700
From:   "Andy Lutomirski" <luto@kernel.org>
To:     "Peter Zijlstra (Intel)" <peterz@infradead.org>
Cc:     "Nicholas Piggin" <npiggin@gmail.com>,
        "Rik van Riel" <riel@surriel.com>,
        "Andrew Morton" <akpm@linux-foundation.org>,
        "Dave Hansen" <dave.hansen@intel.com>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        linux-mm@kvack.org,
        "Mathieu Desnoyers" <mathieu.desnoyers@efficios.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: =?UTF-8?Q?Re:_[RFC][PATCH]_sched:_Use_lightweight_hazard_pointers_to_gra?=
 =?UTF-8?Q?b_lazy_mms?=
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 17, 2021, at 2:08 AM, Peter Zijlstra wrote:
> On Wed, Jun 16, 2021 at 10:32:15PM -0700, Andy Lutomirski wrote:
> > Here it is.  Not even boot tested!
> 
> It is now, it even builds a kernel.. so it must be perfect :-)
> 
> > https://git.kernel.org/pub/scm/linux/kernel/git/luto/linux.git/commit/?h=sched/lazymm&id=ecc3992c36cb88087df9c537e2326efb51c95e31
> 
> Since I had to turn it into a patch to post, so that I could comment on
> it, I've cleaned it up a little for you.
> 
> I'll reply to self with some notes, but I think I like it.
> 
> ---
>  arch/x86/include/asm/mmu.h |   5 ++
>  include/linux/sched/mm.h   |   3 +
>  kernel/fork.c              |   2 +
>  kernel/sched/core.c        | 138 ++++++++++++++++++++++++++++++++++++---------
>  kernel/sched/sched.h       |  10 +++-
>  5 files changed, 130 insertions(+), 28 deletions(-)
> 
> diff --git a/arch/x86/include/asm/mmu.h b/arch/x86/include/asm/mmu.h
> index 5d7494631ea9..ce94162168c2 100644
> --- a/arch/x86/include/asm/mmu.h
> +++ b/arch/x86/include/asm/mmu.h
> @@ -66,4 +66,9 @@ typedef struct {
>  void leave_mm(int cpu);
>  #define leave_mm leave_mm
>  
> +/* On x86, mm_cpumask(mm) contains all CPUs that might be lazily using mm */
> +#define for_each_possible_lazymm_cpu(cpu, mm) \
> +	for_each_cpu((cpu), mm_cpumask((mm)))
> +
> +
>  #endif /* _ASM_X86_MMU_H */
> diff --git a/include/linux/sched/mm.h b/include/linux/sched/mm.h
> index e24b1fe348e3..5c7eafee6fea 100644
> --- a/include/linux/sched/mm.h
> +++ b/include/linux/sched/mm.h
> @@ -77,6 +77,9 @@ static inline bool mmget_not_zero(struct mm_struct *mm)
>  
>  /* mmput gets rid of the mappings and all user-space */
>  extern void mmput(struct mm_struct *);
> +
> +extern void mm_unlazy_mm_count(struct mm_struct *mm);

You didn't like mm_many_words_in_the_name_of_the_function()? :)

> -	if (mm) {
> -		membarrier_mm_sync_core_before_usermode(mm);
> -		mmdrop(mm);
> -	}

What happened here?

I think that my membarrier work should land before this patch.  Specifically, I want the scheduler to be in a state where nothing depends on the barrier-ness of mmdrop() so that we can change the mmdrop() calls to stop being barriers without our brains exploding trying to understand two different fancy synchronization schemes at the same time.

Other than that I like your cleanups.
