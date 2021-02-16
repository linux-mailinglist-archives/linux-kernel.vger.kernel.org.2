Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F43F31D02F
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Feb 2021 19:28:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230121AbhBPS1G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Feb 2021 13:27:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbhBPS1E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Feb 2021 13:27:04 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BB5DC061574
        for <linux-kernel@vger.kernel.org>; Tue, 16 Feb 2021 10:26:24 -0800 (PST)
Date:   Tue, 16 Feb 2021 19:26:19 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1613499981;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=YyMuqAM9gdToLippbhYP80dF7B1jWvu3QHSqOidCy9A=;
        b=OfdZOIBzFHoKO7Nujny6/JG6/AsDkC9ZIjbKYGn/OGL+K4ZSNT4dbT2ulesZJKOHvbxuKe
        lj8toq2Rks2scoBv/BWhOZlaKASqhNDkTXR1ZdEG+sRZPR1TZQj6bM3OUw9O8NIdBbd8e6
        UKDXKQzpmvLtToDa7BHqFfZzfgWLtFAM6IcaAsSviKZNdjn1mR7xZ5PVRsUbYCTZuEo6Sa
        ajjUVXBPV7r11kxbd09Zolm3+LpErlGWl/3/erO+Uv9YrJ66xGKs9ZfAHKVN7LYrEtvnPp
        hCMrqgF3wx65wgw/e3Um2CiQgy6tm+9IsWfzk2PFSyu4momyVWbxf75BV2Sq9g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1613499981;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=YyMuqAM9gdToLippbhYP80dF7B1jWvu3QHSqOidCy9A=;
        b=MRPpuX30PSIs2FHTxC+Dx7lJJToaqa/ctEQhydybR/LRyEU3+DJTunyAYf1qLgXOKuMzCB
        uL1BxU2Z92hiCiCw==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Willy Tarreau <w@1wt.eu>
Subject: Re: [PATCH v3] auxdisplay: Remove in_interrupt() usage.
Message-ID: <20210216182619.xd7h4uwpqcw5kcup@linutronix.de>
References: <20210208190735.ibq44r5pc4cwzt7j@linutronix.de>
 <CANiq72kq_d=5TvdhndP9zkyTD1pHF6WQb+qs01D68DEQH6jVjQ@mail.gmail.com>
 <20210208204136.sv4omzms3nadse6e@linutronix.de>
 <CANiq72mw47Qa9M6i23Dp+_3M8juBnv33PJ-6zFk++SV57G2-cQ@mail.gmail.com>
 <20210209090112.lewvvhnc2y7oyr27@linutronix.de>
 <CANiq72mG3zXA7j9KbC74hQ1BMgw713Hm3WDAcQBjKxgg0fLHeg@mail.gmail.com>
 <20210213165040.vzzieegx4aliyosd@linutronix.de>
 <CANiq72mkkSfbnNM_mmXE-TNKO1orsAeyByMKFy1N6hm+EBA40A@mail.gmail.com>
 <20210216102856.dnaycukt3oqxoszp@linutronix.de>
 <CANiq72mge40Uvqf3mb4uof2gi8ktvhjoodfyJY7uLW4guTnvDw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CANiq72mge40Uvqf3mb4uof2gi8ktvhjoodfyJY7uLW4guTnvDw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-02-16 13:42:19 [+0100], Miguel Ojeda wrote:
> It is not so much about documenting the obvious, but about stating
> that 1) the precondition was properly taken into account and that 2)
> nothing non-obvious is undocumented. When code is changed later on, it
> is much more likely assumptions are broken if not documented.

That should be part of the commit message. You can always rewind to the
commit message that introduce something and check if the commit message
made sense or ignored a detail which made it wrong (or so).

> In fact, from a quick git blame, that seems to be what happened here:
> originally the function could be called from a public function
> intended to be used from inside the kernel; so I assume it was the
> intention to allow calls from softirq contexts. Then it was refactored
> and the check never removed. In this case, the extra check is not a
> big deal, but going in the opposite direction can happen too, and then
> we will have a bug.

So it was needed once, it is not needed anymore. That was my arguing in
v1 about. No word about general removing in_interrupt() from drivers.

> In general, when a patch for a fix is needed, it's usually a good idea
> to add a comment right in the code. Even if only to avoid someone else
> having to backtrack the calls to see it is only called form fs_ops
> etc.

This is not a fix. It just removes not needed code. Also I don't think
that this is a good idea to add a comment to avoid someone to backtrack
/ double check something. If you rely on a comment instead of double
checking that you do is indeed correct you will rely one day on a stale
comment and commit to a bug.

To give you another example: If I would have come along and replaced
GFP_ATOMIC with GFP_KERNEL would you ask for a comment?

Anyway, I'm posting a patch with changes as ordered in a jiffy.

> Cheers,
> Miguel

Sebastian
