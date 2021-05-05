Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3AAC9373BD8
	for <lists+linux-kernel@lfdr.de>; Wed,  5 May 2021 14:59:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233304AbhEENAo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 May 2021 09:00:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231899AbhEENAo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 May 2021 09:00:44 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0D75C06174A
        for <linux-kernel@vger.kernel.org>; Wed,  5 May 2021 05:59:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=MyjiuFoKvP+y8MeTP52CcLCZRkso8M1o4FdkOQlWxdQ=; b=lrpNhBCxq8BjDB+s4HNKY5vvoZ
        1iGbRZJCGbg1lEJn/bn+Isxk9Ow6uE641bGLaxa1nKNUd/y6cUdlbyz48rCgByZGQyDrcGuJ5j+nQ
        rJN6BBRW0F1hHGCgcgKbkwEu1f+PetAbtu6yc+H9d3hyCMgm9j0USMtwgjNBRo0gJlUngUiSN7YJz
        GKs9eQ2wVJl2ovP9hkYXUBrMU5uM4B2KQc4QfAstRRSembUX7hSnJ0Q6pA0ge5MpUdUDjKjRAO7oJ
        fGDq7ynqfxC510FjQ04Faykz0oJVhhpKgbG8JToh/nn3zrIoefPXFnKOUU3B6xy0E8jxwTtg1gThv
        wpQIl55w==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1leH7o-001Fy1-JO; Wed, 05 May 2021 12:59:36 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id ECB8A3001CD;
        Wed,  5 May 2021 14:59:35 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id AA23E203E67C4; Wed,  5 May 2021 14:59:35 +0200 (CEST)
Date:   Wed, 5 May 2021 14:59:35 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Adhemerval Zanella <adhemerval.zanella@linaro.org>,
        Lukasz Majewski <lukma@denx.de>,
        Florian Weimer <fweimer@redhat.com>,
        Carlos O'Donell <carlos@redhat.com>,
        "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Ingo Molnar <mingo@kernel.org>,
        Darren Hart <dvhart@infradead.org>,
        Andrei Vagin <avagin@gmail.com>,
        Kurt Kanzenbach <kurt@linutronix.de>
Subject: Re: [patch 0/6] futex: Bugfixes and FUTEX_LOCK_PI2
Message-ID: <YJKWt2vlr74WR5tx@hirez.programming.kicks-ass.net>
References: <20210422194417.866740847@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210422194417.866740847@linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 22, 2021 at 09:44:17PM +0200, Thomas Gleixner wrote:
> The following series started off looking into supporting selectable clocks
> for FUTEX_LOCK_PI which is hardcoded to CLOCK_REALTIME and cannot be
> changed.
> 
> On the way I found two bugs related to the timeout handling:
> 
>   - The allowance for FUTEX_WAIT to use FUTEX_CLOCK_REALTIME is broken and
>     never worked.
> 
>   - The recent time namespace support wreckaged FUTEX_LOCK_PI timeouts when
>     the task belongs to a namespace which has an CLOCK_MONOTONIC offset.
> 
> Both should have been caught by that Gleixner dude when merging them,
> but it seems he's getting old.
> 
> Not having a selectable clock for PI futexes is inconsistent because all
> other interfaces have it. Unfortunately this was figured out by glibc folks
> quite some time ago, but nobody told us :(
> 
> The nasty hack to support it would be to treat FUTEX_CLOCK_REALTIME inverse
> for FUTEX_LOCK_PI, but that's a horrible idea. Adding a new flag to the
> futex op, i.e. FUTEX_CLOCK_MONOTONIC would be possible, but that's yet
> another variant which makes is harder for libraries to have a consistent
> clock selection handling.
> 
> So I went the way to let FUTEX_LOCK_PI alone and to add FUTEX_LOCK_PI2
> which handles the clocks the same way as the other operands.
> 
> Thoughts?

With the missing FUTEX_LOCK_PI2 in #6, as spotted by André Almeida, fixed:

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>

It's all somewhat sad, but I don't see any other way out of this. Using
LOCK_PI2 will be a fairly horrible pile of hacks on the userspace side
of things given they need to first detect it's presence etc., but that
seems unavoidable whatever we do :/
