Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63FD43FBF70
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Aug 2021 01:34:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239071AbhH3Xaj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Aug 2021 19:30:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237832AbhH3Xai (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Aug 2021 19:30:38 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0724FC061575
        for <linux-kernel@vger.kernel.org>; Mon, 30 Aug 2021 16:29:43 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1630366181;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7HyWSSLhpqojr1UwdAGdpxsKYXHH5oUAoRaOQ8SQ0iw=;
        b=H+AhP6br5rdU5Mv/+gvW4DZqFCOtOto2t4wvQBoJk8WhC1nWd59G+g1AlA9LYGqfeJvJo8
        1prWsqxInsUYvWleDsWFRfJCgK0zGtDWh3Hj4e2CHckYe4u3nwNKtiteyp3TSAZMW5uS5Q
        6Py56lzgOVPSXamGLHZ/H8EWuCMVfWu+BE6TuusxwKNI8jZVQw1tg4ADvjfua6PL7LlHtN
        JRz3lJUZKmbexHlzF9QkFJziYkaNU1guXiRMIcj/QtG9bEjjNA3Uax7CUHkZufDVf3gX6J
        jt6oGkYrOp9e+SEJ8JcKuWAcPbZHi83uksGz7Z6clj3JF/vfO9nd/PnBfSD2WA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1630366181;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7HyWSSLhpqojr1UwdAGdpxsKYXHH5oUAoRaOQ8SQ0iw=;
        b=LR2o6qFFOU38x4Ahjp11BJ3HeALzLzE0OwbRqljccugyeTWmfdp5+5lMsl1DqjQtB9+C86
        SgSXU429Lxa+nVDg==
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Ingo Molnar <mingo@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Subject: Re: Question on commit dc7109aaa233 ("futex: Validate waiter
 correctly in futex_proxy_trylock_atomic()")
In-Reply-To: <CAKXUXMzqmN1dYpbYSCXWN9VwHn8+MXj3P=G09qD6=atwrcJ8WA@mail.gmail.com>
References: <CAKXUXMzqmN1dYpbYSCXWN9VwHn8+MXj3P=G09qD6=atwrcJ8WA@mail.gmail.com>
Date:   Tue, 31 Aug 2021 01:29:40 +0200
Message-ID: <87a6kyfr4r.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Lukas,

On Fri, Aug 20 2021 at 13:17, Lukas Bulwahn wrote:
> in commit dc7109aaa233 ("futex: Validate waiter correctly in
> futex_proxy_trylock_atomic()") visible on next-20210819, you add:
>
> +    /*
> +     * Ensure that this is a waiter sitting in futex_wait_requeue_pi()
> +     * and waiting on the 'waitqueue' futex which is always !PI.
> +     */
> +    if (!top_waiter->rt_waiter || top_waiter->pi_state)
> +        ret = -EINVAL;
>
> However, ret is unconditionally reassigned later and erases any
> intended effect of this assignment. This is making that assignment
> above a Dead Store, which clang-analyzer correctly warns about and
> which motivates me to write you an email.
>
> Did you intend to return -EINVAL here? So:
>
> +       if (!top_waiter->rt_waiter || top_waiter->pi_state)
> +               return -EINVAL;

Duh, yes.

> Static analysis tools are as foolish as they are... but every dog has its day...

IOW: Even a blind hen sometimes finds a grain of corn :)

Care to send a patch?

Thanks,

        tglx
