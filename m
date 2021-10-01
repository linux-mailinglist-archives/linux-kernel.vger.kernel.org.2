Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 030AA41EDBA
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Oct 2021 14:44:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354443AbhJAMqb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Oct 2021 08:46:31 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:57124 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353947AbhJAMqa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Oct 2021 08:46:30 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1633092285;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=oIyJDdC53xIoNqfLRWbYB8WyMBpf1JDla/NRP6eGp84=;
        b=V6rYACth5+b7OaGX6468Y8c6WIFDZUnDV/ehWorJP9tMdKFpSd3GxGiDlfEIjSwIOD61sp
        YNkZJvIw5I85QB7JYDdHVztKbMmgfx56N4L5byH7seHRA0x+qHiuY1YsPk40EbaEsK15QN
        /pXJAf3YNsl7T8seTEkNAIlXSi12QFeXOLaMy02y2Gp5QWGdRPtk1xXKEspLVxDswuqNtB
        0d2nUmWqvlv9akvxCxpqyNIaljDyd+N3WbxfDMSbf8mQAKCZP5TvTfqzQpknYUy7yun1CN
        7zEhgVKn2IGmTL+oSvrZeGyGelo6NpI1CEFEg9C6J0pLQ5ZNf0TqS7v6PCKSFA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1633092285;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=oIyJDdC53xIoNqfLRWbYB8WyMBpf1JDla/NRP6eGp84=;
        b=x6Ua6H7dCUmPyAKvHZD6uYS1g+vnrs+BAQC+czWvcuYHjKwni+h3d7gjkIPZ/vvpY6Kgfy
        SbijEk11ibgJOaCw==
To:     "Chang S. Bae" <chang.seok.bae@intel.com>, bp@suse.de,
        luto@kernel.org, mingo@kernel.org, x86@kernel.org
Cc:     len.brown@intel.com, lenb@kernel.org, dave.hansen@intel.com,
        thiago.macieira@intel.com, jing2.liu@intel.com,
        ravi.v.shankar@intel.com, linux-kernel@vger.kernel.org,
        chang.seok.bae@intel.com
Subject: Re: [PATCH v10 01/28] x86/fpu/xstate: Fix the state copy function
 to the XSTATE buffer
In-Reply-To: <20210825155413.19673-2-chang.seok.bae@intel.com>
References: <20210825155413.19673-1-chang.seok.bae@intel.com>
 <20210825155413.19673-2-chang.seok.bae@intel.com>
Date:   Fri, 01 Oct 2021 14:44:45 +0200
Message-ID: <87lf3c6hj6.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Chang,

On Wed, Aug 25 2021 at 08:53, Chang S. Bae wrote:

> Harden copy_uabi_to_xstate() so that it can handle the case where
> __raw_xsave() returns NULL.

That's an implementation detail, but does not explain why this can
happen and what this patch is about.

> This does not happen in practice today, but theoretically could happen
> in the future.

So what does the patch "fix"? When the subject says "Fix..." then I'm
expecting a bug in the code to be fixed.

There is none because the use case which can trip over this does not
exist today. You are adding it later.

Subject: .....: Prepare copy_uabi_to_xstate() to handle dynamic features

or something like that along with a reasonable explanation.

But in a later patch you add in the very same function:

> +    hdr.xfeatures &= fpu->state_mask;

which prevents that already because __raw_xsave_addr() is not invoked
for the zeroed bits in hdr.xfeatures:

>  		if (hdr.xfeatures & mask) {
>  			void *dst = __raw_xsave_addr(xsave, i);

Confused.

I'm not against the change per se, but I'm not accepting changelogs
which make no sense at all. News at 11.

Thanks,

        tglx
