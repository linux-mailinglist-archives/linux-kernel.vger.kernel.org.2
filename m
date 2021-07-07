Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D13063BE5D1
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jul 2021 11:47:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231300AbhGGJud (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jul 2021 05:50:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231252AbhGGJuc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jul 2021 05:50:32 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42B84C061574
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jul 2021 02:47:52 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1625651268;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mfWgJW7OBjkWrCCfQOJpHn9zaDjfJNraAT0ZOEnusZg=;
        b=RnxvCzd9Pd2rztCWzGG1sD9+uVKgt9xm72WEz9FiDMqmbvW08zhVUq9G4pv6LWh818qjGw
        ZA4dxVi0OVIoPUtUufPifEVsjx4pBzxW7V/30q+ogBmd0IGUmG/bcNHhJuGBALckoX+7gj
        y3xv/6qa/WzJ4lfadRjl4wGZAlgSFkETJVt/SXPcs7zRFRw6uNYaLGHiVuBmWlocKGcMvD
        oVc1PuNTEXjWDl4CDxUvXZNLQv5JAADF01jIahZyoaAAMVNkjhddhknpbtQB/0luPOMydy
        82fNPhLiA3RKpbXNxpZvkzeSeeAOfMTmpNN8YTyneGEYAA+wghDGZ1dCsk7vOQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1625651268;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mfWgJW7OBjkWrCCfQOJpHn9zaDjfJNraAT0ZOEnusZg=;
        b=eQMs9j0BXXvD8+TOq33EC4Iz7VQdtuowVl4CSgyoimECraqt80T6ZSpWbrHxGL01J699Mi
        HC8E7W/Iz5Bn2tAQ==
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>
Cc:     Christian Brauner <christian.brauner@ubuntu.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [GIT PULL] sigqueue cache fix
In-Reply-To: <CAHk-=wjrd6-ZHyQGznpM+O0CtTHjzZ5P2Ozddh68WmDH9c+hBg@mail.gmail.com>
References: <YNQwgTR3n3mSO9+3@gmail.com> <CAHk-=wiebYt6ZG4Cp8fWqVnNqxMN4pybDZQ6gwsTWFc0XP=XPw@mail.gmail.com> <CAHk-=wgEyk9X5NefUL7gaqXOSDkdzCEDi6RafxGvG+Uq8rGrgA@mail.gmail.com> <CAHk-=wiJq0Ns7_AFRW+rvZcD_m+1t5cYgvQRO-Gbp8TEK1x1bQ@mail.gmail.com> <YNlapAKObfeVPoQO@gmail.com> <CAHk-=wjLNCm5kNnbHkw38c1t80FAPVYmNOOiTvdqedNm1SQRZg@mail.gmail.com> <YNoZIVgboj6YKo3V@gmail.com> <CAHk-=wjrd6-ZHyQGznpM+O0CtTHjzZ5P2Ozddh68WmDH9c+hBg@mail.gmail.com>
Date:   Wed, 07 Jul 2021 11:47:47 +0200
Message-ID: <878s2iqwu4.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

On Mon, Jun 28 2021 at 12:02, Linus Torvalds wrote:
> And as the whole - and only - point of the sigqueue cache was a very
> subtle performance and latency issue, I don't think we want to use
> locks or atomics. It's why my revert commit suggests re-purposing the
> "percpu_cmpxchg()" functionality: that would likely be a good model at
> least for x86 and arm.
>
> But while we have "percpu_cmpxchg()", I don't think we currently don't
> really have that kind of operation where it
>
>  (a) works on a non-percpu variable (but we can force casts, I guess)
>
>  (b) has "acquire" semantics
>
> We do have the *atomic* cmpxchg with acquire semantics, but atomics
> are rather more expensive than we'd probably really want.

first of all, sorry for being non-responsive on this. I'll have a fresh
look at this with your comments in mind and be more careful.

Thanks,

        tglx
