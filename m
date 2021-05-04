Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E128372845
	for <lists+linux-kernel@lfdr.de>; Tue,  4 May 2021 11:49:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230115AbhEDJuI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 May 2021 05:50:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229953AbhEDJuI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 May 2021 05:50:08 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58E88C061574
        for <linux-kernel@vger.kernel.org>; Tue,  4 May 2021 02:49:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=v3J7n0hMzc3/Uwkfxm+uPhLPqR/xUmsvFlQQlOHA4BQ=; b=ZF3tmLP+ojR8CRA9/luv0dP0CN
        gFCKteEbOlbaK71zAm74XEikY61qWY5gRdfVEjq6XvHDxrH9G4R+5lJrchZ1kxqg94HFxzbME8/7C
        zDlDSSxX/yMksEGN4/NLBJH2pfwfW2ha8jE2VeLGhIudxIBAN3bbbG8XZu08GKjcxmH13NZaXvJCf
        NleyOy0rycCz4gXGXNcLYNVd9li9S5jUuTHcEvmUMDQgbf3drHWg6tMuST4vpuGXOcUnxw56wCCGs
        5diH8vsIjZzdreWyCGya9IWRuFYfvNoxNRvf/tuwRBHdNyZXMWwUM5No0PhbcWzjsUtVnTLrdYbCS
        pzUZ9fvg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1ldrfx-00FuWt-9T; Tue, 04 May 2021 09:49:09 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 8464830022A;
        Tue,  4 May 2021 11:49:08 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 6B9A1207C950B; Tue,  4 May 2021 11:49:08 +0200 (CEST)
Date:   Tue, 4 May 2021 11:49:08 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     Andi Kleen <ak@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        kasan-dev <kasan-dev@googlegroups.com>
Subject: Re: [PATCH] stackdepot: Use a raw spinlock in stack depot
Message-ID: <YJEYlAo2HU8KfyxI@hirez.programming.kicks-ass.net>
References: <20210504024358.894950-1-ak@linux.intel.com>
 <CACT4Y+a5g5JeLJFPJEUxPFbMLXGkYEAJkK3MBctnn7UA-iTkXA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACT4Y+a5g5JeLJFPJEUxPFbMLXGkYEAJkK3MBctnn7UA-iTkXA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 04, 2021 at 09:23:34AM +0200, Dmitry Vyukov wrote:
> So why is this a false positive that we just need to silence?

No, it's a correctness issue for PREEMPT_RT.

> I see LOCKDEP is saying we are doing something wrong, and your
> description just describes how we are doing something wrong :)
> If this is a special false positive case, it would be good to have a
> comment on DEFINE_RAW_SPINLOCK explaining why we are using it.

Documentation/locking/locktypes.rst has the low-down IIRC

> I wonder why we never saw this on syzbot. Is it an RT kernel or some
> other special config?

IIRC the kernel isn't really PROVE_RAW_LOCK_NESTING=y clean yet, so
mostly these checks aren't on by default. printk() used to be a common
offender, but I've not checked the very latest printk status to see if
that got fixed meanwhile.

> A similar issue was discussed recently for RT kernel:
> https://groups.google.com/g/kasan-dev/c/MyHh8ov-ciU/m/nahiuqFLAQAJ
> And I think it may be fixable in the same way -- make stackdepot not
> allocate in contexts where it's not OK to allocate.

That would be preferable I think.
