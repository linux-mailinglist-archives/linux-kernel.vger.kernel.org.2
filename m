Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E0513809E6
	for <lists+linux-kernel@lfdr.de>; Fri, 14 May 2021 14:52:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233758AbhENMyB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 May 2021 08:54:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231265AbhENMxb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 May 2021 08:53:31 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED45CC061574
        for <linux-kernel@vger.kernel.org>; Fri, 14 May 2021 05:52:19 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1620996738;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=yGqHox/vbo9cV1U03PZyd/lnASbLdNPLsWZby87FFBs=;
        b=1tJEOp9SS11AS8VM25VsmA7KvgTmrPQubsqgQmZ6oH7JPk1qnnUPULYSEiddggcagboDvC
        VMEROV88evToHYLGrkFXVzYdl5LMnY5AjRG2LYnU54fiYR7QVVjEDjNnGXNi/FKZUBLj0A
        9pfUHLJ5XMUO8Z4iIpg6RmpGjUf2k5grYBMrobs51Z4Nauw7BKhMlmns7IRRa+0klJMZzR
        A4womsWWvfuX9VzIZ48Xbnyvq7Uu3HxFj58vbDG9ZSYT0jwmgU7ZkhJCE22qUFUPhaIMyd
        307+4QhjjdpjDDbksrdCrkZvp0Lnp6DyHOn7o6WmBL/FbFiH7LWryyY7yJ1IJA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1620996738;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=yGqHox/vbo9cV1U03PZyd/lnASbLdNPLsWZby87FFBs=;
        b=Alp1btOULeS4sKOZBRTdxrFQ9OFP3/Ik4kJ1VZaADZUbePSKrZ8rabAEtr64WeLGtm8x+M
        sif1bLtreZZBbTBA==
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Alexey Dobriyan <adobriyan@gmail.com>, mingo@redhat.com,
        Borislav Petkov <bp@alien8.de>, linux-kernel@vger.kernel.org,
        x86@kernel.org, Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 1/4] sched: make nr_running() return 32-bit
In-Reply-To: <YJz4TmZ7fmKFchRe@gmail.com>
References: <20210422200228.1423391-1-adobriyan@gmail.com> <87fsyr5wtj.ffs@nanos.tec.linutronix.de> <YJz4TmZ7fmKFchRe@gmail.com>
Date:   Fri, 14 May 2021 14:52:18 +0200
Message-ID: <87wns14gvx.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo,

On Thu, May 13 2021 at 11:58, Ingo Molnar wrote:
> * Thomas Gleixner <tglx@linutronix.de> wrote:
>
> You often won't see these effects in the 'size vmlinux' output, because 
> function alignment padding reserves usually hide 1-2 byte size improvements 
> in generated code.

I'm not that stupid. And I certainly looked where this comes from.

> More importantly, the maintenance benchmark in these cases is not whether a 
> change actively helps every architecture we care about - but whether the 
> change is a *disadvantage* for them - and it isn't here.

That's clearly documented in the changelogs of these patches, right?

> Changes that primarily benefit one common architecture, while not others, 
> are still eligible for upstream merging if they otherwise meet the quality 
> threshold and don't hurt the other architectures.

That has been proven by compile testing the relevant architectures as
documented in the changelog, right?

> TL;DR:
>
> This benefits from this series are small, but are far from 'useless churn', 
> unless we want to arbitrarily cut off technically valid contributions that 
> improve generated code, data structure size and code readability, submitted 
> by a long-time contributor who has contributed over 1,300 patches to the 
> kernel already, just because we don't think these add up a significant 
> enough benefit?
>
> No doubt the quality barrier must be and is higher for smaller changes - 
> but this series IMO passed that barrier.
>
> Anyway, I've Cc:-ed Linus and Greg, if you are advocating for some sort of 
> cut-off threshold for small but measurable improvements from long-time 
> contributors, it should probably be clearly specified & documented in 
> Documentation/SubmittingPatches ...

What I'm arguing about is already documented:

  Quantify optimizations and trade-offs.  If you claim improvements in
  performance, memory consumption, stack footprint, or binary size,
  include numbers that back them up.

That series fails to provide any of this and it does not matter whether
this comes from a long time contributor or from a newbie.

Long term contributors are not excempt from documented process. In fact
they should lead by example.

If you as a maintainer put different measures on newbies and long-time
contrinbutors then you pretty much have proven the point the UMN people
tried to make (in the wrong way).

Thanks,

        tglx
