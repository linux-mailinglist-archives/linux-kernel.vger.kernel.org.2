Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87F39419036
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Sep 2021 09:50:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233316AbhI0HwE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Sep 2021 03:52:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233242AbhI0HwC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Sep 2021 03:52:02 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF85CC061570
        for <linux-kernel@vger.kernel.org>; Mon, 27 Sep 2021 00:50:24 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1632729023;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/+deSq9rOWIvBiQYRPvbHul+z/t+GBYEYh3S8sMe7MA=;
        b=NuZXnrB04EZld3JVdHMv2FapJxcB/Pe8VN0ysQ4RtvDR7fqttfjp71xz0v6f3+dpXkP5mC
        DUYHgll7JAsUv9P5IzLZqctWSGRRnychVSf2C/W5pk5p6wV0eIA4dhUmLKzoVImwf6cb3/
        E8rMIRspWHPCIQ89SZ9jCAY4nLaqt8grx49TeKjbq29Ocd07btIkAmiGOfo3HZNymfXR4q
        rjn59bEsA4U8gE8saLSm4ZAHozfnvlfNDCNqPdj7aId/FMliYhRv+tRb7zeFJ+pxBwpbnr
        soHOskplSA9ZHgxnvlwRJkzNISzCvmMFKSQtjIt8QoxwsSRu6inzIPrQkpHqTw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1632729023;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/+deSq9rOWIvBiQYRPvbHul+z/t+GBYEYh3S8sMe7MA=;
        b=egBTZT0Co7Hoeow4NStj6BJh/1IVxt0zKxH3jVlt41tEPOrEQ8DQC5etsZwG+TQ/0dZT0v
        zD5aRDyXxUT+BNCA==
To:     Lai Jiangshan <laijs@linux.alibaba.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        linux-kernel@vger.kernel.org
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>,
        "Chang S . Bae" <chang.seok.bae@intel.com>,
        Sasha Levin <sashal@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH V2 01/41] x86/entry: Fix swapgs fence
In-Reply-To: <445de475-c223-be11-325f-fa6679e45cb0@linux.alibaba.com>
References: <20210926150838.197719-1-jiangshanlai@gmail.com>
 <20210926150838.197719-2-jiangshanlai@gmail.com> <87r1dbawzq.ffs@tglx>
 <9312a767-f1d3-d283-80a9-e6b3854252e1@linux.alibaba.com>
 <445de475-c223-be11-325f-fa6679e45cb0@linux.alibaba.com>
Date:   Mon, 27 Sep 2021 09:50:22 +0200
Message-ID: <875yumbgox.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Lai,

On Mon, Sep 27 2021 at 11:27, Lai Jiangshan wrote:
> On 2021/9/27 09:10, Lai Jiangshan wrote:
>
> The commit c75890700455 ("x86/entry/64: Remove unneeded kernel CR3 switching")
> ( https://lore.kernel.org/all/20200419144049.1906-2-laijs@linux.alibaba.com/ )
> also made it wrong.

Duh, did not spot that either.

> When the SWITCH_TO_KERNEL_CR3 in the path is removed, FENCE_SWAPGS_USER_ENTRY
> should also be changed to FENCE_SWAPGS_KERNEL_ENTRY. (Or just jmp to
> .Lerror_entry_done_lfence which has FENCE_SWAPGS_KERNEL_ENTRY already.)

Yes.

> And FENCE_SWAPGS_USER_ENTRY could be documented with "it should be followed with
> serializing operations such as SWITCH_TO_KERNEL_CR3".

It does not matter whether the serializing is before or after. The
problem is:

    if (from_user)
    	swapgs();

can take the wrong path speculatively which means the speculation is
then based on the wrong GS.

We have these sequences in the non paranoid entries:

    if (from_user) {
       pti_switch_cr3();
       swapgs();
    }

    if (from_user) {
       swapgs();
       pti_switch_cr3();
    }

and with mitigation these become:

    if (from_user) {
       pti_switch_cr3();
       swapgs();
       lfence_if_not_pti();
    } else {
       lfence();
    }

    if (from_user) {
       swapgs();
       lfence_if_not_pti();
       pti_switch_cr3();
    } else {
       lfence();
    }

When PTI is enabled then the CR3 write is sufficient because it's fully
serializing. If PTI is off the LFENCE is required. On which side the CR3
write is before or after SWAPGS does not matter. 

>  Or we can add a SWAPGS_AND_SWITCH_TO_KERNEL_CR3 to combine them.

No. We really don't want to go there.

Thanks,

        tglx

