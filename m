Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8832941CB35
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Sep 2021 19:47:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344699AbhI2RtD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Sep 2021 13:49:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:44628 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S245131AbhI2RtB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Sep 2021 13:49:01 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8312F6135E;
        Wed, 29 Sep 2021 17:47:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632937640;
        bh=jEX9WfFfE7uc4opv3Isth3zecI1A32dpxFg6mdU08xM=;
        h=In-Reply-To:References:Date:From:To:Cc:Subject:From;
        b=LM1gtvuF6QTPazoRV7AFt66j4gUjzHljkibHjf3/NEsFv2QZO9rjpxZGFe8/KAHD0
         riqHZLqqhJBcxYwr/VtdhRf5/H3W3qudXW+X1DfIR0wWVaYYaknxCnJRrYta4OSVFB
         EN0/wmE5CKyEHSKXmsREeDVezXzvHOuO+0MxFddJ51/+FBzyaDzys0EbVTvyMjn010
         TTCf1YJNsh7cmLlhe7AbaDDTsgqQFs1v7bMoshfxq26wI/iUMTWFAPqYCm3slv2Ojr
         cRSgHKh5aEDvQu4yD/pdxIZtUpJQaaSUypxgrbKJCdMyqAAKZalvvMuKBZT1FaaAcL
         +kXeAY7LxnvUA==
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailauth.nyi.internal (Postfix) with ESMTP id A0D8C27C0054;
        Wed, 29 Sep 2021 13:47:18 -0400 (EDT)
Received: from imap48 ([10.202.2.98])
  by compute6.internal (MEProxy); Wed, 29 Sep 2021 13:47:18 -0400
X-ME-Sender: <xms:pqZUYejQq3gPSyw60Yb6EXfyWSApJf73Clf4YaPdF0O9ZDMh0IQgfw>
    <xme:pqZUYfB-rsxB-LzxzBvGaf2LAHgcozjNssTqFr4ckRLsXzPJLZGY3ZpGjwwsNSRRm
    Ub90KIr4QbCP_i-918>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrudekvddgudduhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvufgtsehttdertderredtnecuhfhrohhmpedftehn
    ugihucfnuhhtohhmihhrshhkihdfuceolhhuthhosehkvghrnhgvlhdrohhrgheqnecugg
    ftrfgrthhtvghrnheptdfhheettddvtedvtedugfeuuefhtddugedvleevleefvdetleff
    gfefvdekgeefnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrh
    homheprghnugihodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdduudeiudek
    heeifedvqddvieefudeiiedtkedqlhhuthhopeepkhgvrhhnvghlrdhorhhgsehlihhnuh
    igrdhluhhtohdruhhs
X-ME-Proxy: <xmx:pqZUYWEE-AhDha05eaxaCucivujcLnogeX3M-cOELrqzepcAL5T_xg>
    <xmx:pqZUYXRv2BG77WVKZqkHOjxw3-UzZNNQi8_2kxtVFsmQm6oDkI3hbw>
    <xmx:pqZUYbxwfaBvZ9yIQzQ8bUGxABvUdzbFPrdKS173fdDkftAbCMcazg>
    <xmx:pqZUYQKkcO3DxN1t_FdsEnYX4oeWKIQT27zLDIgLBSZvLs46YP0QtOZm6W8>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 6E53E21E0063; Wed, 29 Sep 2021 13:47:18 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.5.0-alpha0-1303-gb2406efd75-fm-20210922.002-gb2406efd
Mime-Version: 1.0
Message-Id: <fe65a413-44c0-46c3-856f-ed4e554066f6@www.fastmail.com>
In-Reply-To: <YVSlVv/j+WKftUU5@agluck-desk2.amr.corp.intel.com>
References: <87y27nfjel.ffs@tglx>
 <YUyuEjlrcOeCp4qQ@agluck-desk2.amr.corp.intel.com> <87o88jfajo.ffs@tglx>
 <87k0j6dsdn.ffs@tglx> <YU3414QT0J7EN4w9@agluck-desk2.amr.corp.intel.com>
 <a77ee33c-6fa7-468c-8fc0-a0a2ce725e75@www.fastmail.com>
 <YVQ3wc/XjeOHpGCX@hirez.programming.kicks-ass.net> <87r1d78t2e.ffs@tglx>
 <75e95acc-6730-ddcf-d722-66e575076256@kernel.org> <877dez8fqu.ffs@tglx>
 <YVSlVv/j+WKftUU5@agluck-desk2.amr.corp.intel.com>
Date:   Wed, 29 Sep 2021 10:46:58 -0700
From:   "Andy Lutomirski" <luto@kernel.org>
To:     "Tony Luck" <tony.luck@intel.com>,
        "Thomas Gleixner" <tglx@linutronix.de>
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        "Fenghua Yu" <fenghua.yu@intel.com>,
        "Ingo Molnar" <mingo@redhat.com>, "Borislav Petkov" <bp@alien8.de>,
        "Dave Hansen" <dave.hansen@intel.com>,
        "Lu Baolu" <baolu.lu@linux.intel.com>,
        "Joerg Roedel" <joro@8bytes.org>,
        "Josh Poimboeuf" <jpoimboe@redhat.com>,
        "Dave Jiang" <dave.jiang@intel.com>,
        "Jacob Jun Pan" <jacob.jun.pan@intel.com>,
        "Raj Ashok" <ashok.raj@intel.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        iommu@lists.linux-foundation.org,
        "the arch/x86 maintainers" <x86@kernel.org>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 5/8] x86/mmu: Add mm-based PASID refcounting
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, Sep 29, 2021, at 10:41 AM, Luck, Tony wrote:
> On Wed, Sep 29, 2021 at 07:15:53PM +0200, Thomas Gleixner wrote:
>> On Wed, Sep 29 2021 at 09:59, Andy Lutomirski wrote:
>> > On 9/29/21 05:28, Thomas Gleixner wrote:
>> >> Looking at that patch again, none of this muck in fpu__pasid_write() is
>> >> required at all. The whole exception fixup is:
>> >> 
>> >>      if (!user_mode(regs))
>> >>               return false;
>> >> 
>> >>      if (!current->mm->pasid)
>> >>               return false;
>> >> 
>> >>      if (current->pasid_activated)
>> >>      	     return false;
>> >
>> > <-- preemption or BH here: kaboom.
>> 
>> Sigh, this had obviously to run in the early portion of #GP, i.e. before
>> enabling interrupts.
>
> Like this? Obviously with some comment about why this is being done.
>
> diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
> index a58800973aed..a848a59291e7 100644
> --- a/arch/x86/kernel/traps.c
> +++ b/arch/x86/kernel/traps.c
> @@ -536,6 +536,12 @@ DEFINE_IDTENTRY_ERRORCODE(exc_general_protection)
>  	unsigned long gp_addr;
>  	int ret;
> 
> +	if (user_mode(regs) && current->mm->pasid && !current->pasid_activated) {
> +		current->pasid_activated = 1;
> +		wrmsrl(MSR_IA32_PASID, current->mm->pasid | MSR_IA32_PASID_VALID);
> +		return;
> +	}
> +

This could do with a WARN_ON_ONCE(TIF_NEED_LOAD_FPU) imo.

Is instrumentation allowed to touch FPU state?

>  	cond_local_irq_enable(regs);
> 
>  	if (static_cpu_has(X86_FEATURE_UMIP)) {
>
> -Tony
