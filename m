Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16AF13D9569
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jul 2021 20:40:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230315AbhG1Skf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jul 2021 14:40:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230233AbhG1Ske (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jul 2021 14:40:34 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C454AC061757
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jul 2021 11:40:31 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id j2so4537520edp.11
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jul 2021 11:40:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hMGQipmv4P+6hTmePxpJ22V8LdLQi3CACmtx2vw04NE=;
        b=I/BCzuCVYSBhj+aO3Q4aWDfu6lLss36Xk4btqlTUWsx3V8as8ycmR+abRAbzInVD8U
         GZDoL0hQAv0JekGQ4xpA79Nb5tqPYhOcZIv9ILu9WWKb+/T0f2DcATTLmdswj0vh5QcO
         Lfd7SkdRPLRnQBiwbNH1OwFXVCq2MJZiHhG4o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hMGQipmv4P+6hTmePxpJ22V8LdLQi3CACmtx2vw04NE=;
        b=qhbQKsCsIbubML6q+ksXpnVXb2uqZPHIafVB6ap8mSZnBZRUMfGswMaGhHxQz6LyMT
         mA0oKA9+9ppGVpEBNYGNyUWIOyRTnj8DrtelNq4v5Iy/Vlroo/+46ZNWOLI9+uOhHHSI
         nlrRsFM1+cpDu/E8tINMODjYdJQ4t98jDXZw388it9iq5nkLY7ZrfU4kHofr2mZYS5LH
         eBppTCJPev8T3OOWt+tx6bBp999dh4FLI6onieGENZY7yybAbPTGzgffeR+KeIj2EX60
         K4GkWMVOs9+/lwNXIx+ZaV9yVJ+4pdgl//l5L2zDgM2pcRYTjnWkVbMoJ5pk32mmy3MP
         FUMg==
X-Gm-Message-State: AOAM532xS5FixLJh6iaV+ukRRL6M3p0adTKq6f1ole51swaWnIP7v15E
        /JAdoPmGBANUaUUgDXUzkXX/kPlah5h4rNWSByY=
X-Google-Smtp-Source: ABdhPJxVHfUyTM13m0F6ZEv9Aj940rJvBFmgk8USVAlI2K84r+GWTnW2+6h4yriU9AUwUZ6NLzPJjA==
X-Received: by 2002:aa7:d296:: with SMTP id w22mr1475308edq.170.1627497630295;
        Wed, 28 Jul 2021 11:40:30 -0700 (PDT)
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com. [209.85.208.52])
        by smtp.gmail.com with ESMTPSA id j24sm231216edp.44.2021.07.28.11.40.30
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Jul 2021 11:40:30 -0700 (PDT)
Received: by mail-ed1-f52.google.com with SMTP id da26so4607308edb.1
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jul 2021 11:40:30 -0700 (PDT)
X-Received: by 2002:a2e:9241:: with SMTP id v1mr660028ljg.48.1627497136138;
 Wed, 28 Jul 2021 11:32:16 -0700 (PDT)
MIME-Version: 1.0
References: <20210721202042.GA1472052@paulmck-ThinkPad-P17-Gen-1>
 <20210721202127.2129660-4-paulmck@kernel.org> <20210728173715.GA9416@paulmck-ThinkPad-P17-Gen-1>
 <CAHk-=wjwZzi=Lqsre8C8C4YJiVQNdNnco7jkLq=ohePSPA9JCA@mail.gmail.com> <1810346528.8990.1627495925037.JavaMail.zimbra@efficios.com>
In-Reply-To: <1810346528.8990.1627495925037.JavaMail.zimbra@efficios.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 28 Jul 2021 11:32:00 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiLZYvjcj=ztF9tF0df8mSGKXwbCdxxy-JnoaE72VY5tQ@mail.gmail.com>
Message-ID: <CAHk-=wiLZYvjcj=ztF9tF0df8mSGKXwbCdxxy-JnoaE72VY5tQ@mail.gmail.com>
Subject: Re: [PATCH v2 rcu 04/18] rcu: Weaken ->dynticks accesses and updates
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     paulmck <paulmck@kernel.org>, rcu <rcu@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        kernel-team <kernel-team@fb.com>, Ingo Molnar <mingo@kernel.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        rostedt <rostedt@goodmis.org>,
        David Howells <dhowells@redhat.com>,
        Eric Dumazet <edumazet@google.com>,
        fweisbec <fweisbec@gmail.com>, Oleg Nesterov <oleg@redhat.com>,
        "Joel Fernandes, Google" <joel@joelfernandes.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 28, 2021 at 11:12 AM Mathieu Desnoyers
<mathieu.desnoyers@efficios.com> wrote:
>
> Are the percpu atomics you have in mind different from what is found in
> Documentation/core-api/this_cpu_ops.rst ?
>
> Namely this_cpu_add_return(pcp, val) in this case.

Nope.

Those are only "CPU-atomic", ie atomic wrt interrupts etc.

The RCU code wants SMP-atomic, and it's mainly that we *could* do the
addressing more efficiently.

        Linus
