Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17CF13D4FBA
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Jul 2021 21:49:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231467AbhGYTIt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Jul 2021 15:08:49 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:35848 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230116AbhGYTIs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Jul 2021 15:08:48 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1627242557;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tLUaa2kek2tqz2VvunMsn2pCNlPFhTozIDZBme0oKhw=;
        b=4gOfKz4NsVSYYgOBQFhH4sgHl6ljb5yF2frHz0MWF5G1DPRwekpyRc03bQc54nzUMSQ6+R
        qHiWw9toLjetdCwGDAhcyQTeUlmhah5dgZRrgLCgWpIpDIyJo9cvtvy/u0yYUbJH5LkNUN
        ZnK0T/uqvwx9isqMVwrhMEqMA0y9LBZHpyfijWCIaHaPZVPhUtMydNGjezF4W2BM6KNMAl
        4V3yU9aVg88cBLLXY7exSAFQESx8VJOrV8is1SzHJM0hBQ22gEyeA142tOuGtjSnGk6O6g
        y38rY57+oxJaxnXPzIiLsu/+V160k9WVnxAi9nJd58I3QPSJ/px5GEFwPzGo3w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1627242557;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tLUaa2kek2tqz2VvunMsn2pCNlPFhTozIDZBme0oKhw=;
        b=EoSIkCPx/j8YQ8ZoZThOLTDm6nTGS5pFMDcc2ufIS7o2hLBZvtL1bOqNkZ7e0lzXCjGlA7
        ADz9ozdiymXLlLDw==
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>
Subject: Re: [GIT pull] core/urgent for v5.14-rc3
In-Reply-To: <CAHk-=wj5BnPvhmFkXuTJKHawi9kRQsFQDO44GQ4XzqJbwupSWw@mail.gmail.com>
References: <162720492071.8837.4047241618315201209.tglx@nanos> <CAHk-=wj5BnPvhmFkXuTJKHawi9kRQsFQDO44GQ4XzqJbwupSWw@mail.gmail.com>
Date:   Sun, 25 Jul 2021 21:49:16 +0200
Message-ID: <878s1unphf.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 25 2021 at 11:06, Linus Torvalds wrote:
> On Sun, Jul 25, 2021 at 2:23 AM Thomas Gleixner <tglx@linutronix.de> wrote:
> So that function definition _should_ have been
>
>     static __always_inline void idle_init(unsigned int cpu)
>
> instead.
>
> Oh well. I'll fix it up as a separate patch. I wish I had done the
> clang build before pushing it out - and I wish the -tip tree started
> tested clang as well at least in _some_ configuration.

Bah, obvious and I overlooked it when staring at the diff. Duly noted
that clang will be part of the procedure soonish.

Thanks,

        tglx
