Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83D4234F38C
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 23:30:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232791AbhC3VaZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 17:30:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233361AbhC3V3T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 17:29:19 -0400
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36865C061764
        for <linux-kernel@vger.kernel.org>; Tue, 30 Mar 2021 14:29:18 -0700 (PDT)
Received: by mail-qk1-x735.google.com with SMTP id y5so17372673qkl.9
        for <linux-kernel@vger.kernel.org>; Tue, 30 Mar 2021 14:29:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LI2U3XlYQmzLnJLb640nhhbnbRdqs9Tedy+pDurchGU=;
        b=jPcNZwZMQDCUvHmnkfOS36Hw/CeWh29H6PrRn4dNxkDi5YFXbdp/iVfLQkO8oT3GGu
         mCQZW+eIwAiRsUvZnjbEy8ym3cyy6ba8dShj+Tx8ZQkexpChUJbeTwpQcAkvlxPneCUv
         9nDStaa0URCW8/PvnwN5QkpFp0jaN2cXgEkgUFB2uDNA+6m+7nfCRelqBg/YL/cPO0Ac
         Mf2RZJwW2SFjkyj4dafwIjKFkr0Sp5yW9HNjEDsOFuqcGcqRBvkKbBIwdIIQN4xTusoa
         yB0aIZE/vAVECzs9aey4EZW/sdxKJNZJav1w8rUoycMr6pQH/uiQRKFU3WCWXQVpsWUX
         n2PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LI2U3XlYQmzLnJLb640nhhbnbRdqs9Tedy+pDurchGU=;
        b=lBS6UUakwu2DKrMicpNlML0lA4XScmML0aqrc4lgdA7kKxY/3Pq9czvCtKXUb6Kf9d
         uXQGxQvXc5sDxS7EZVZZv68WgaXIKXMV1khAt8208VR0NiajI/3st0JRHj1VL7i5Y5WZ
         x2w8aJDM0cjfqIzZJEwxDEl0xW6MVNjTVz4kwmWYt3ddV8TObunPtwST6zbCBkBnFT1T
         8XDaMePIcDnkUGR/URtOOF0Iw9D5EA5oKJ911JtzclI1si8HoiS9GefIEmSujSJ1p6bZ
         ZB3sGFx5tpqq+7MdpD0V/x4C3EjWQYhimSyvG0GPK3aw9fk2hoVAkqbvD0gAfbEqccKY
         KsaA==
X-Gm-Message-State: AOAM531CK/tOpEC9dhQsRtXpHGr56PqrBzjUN6TZF8iDwpSDR/2hOl0g
        Q/UxnDl9k0M6mvj+lDZO/eyGceCLXWugXb5BxFktGQ==
X-Google-Smtp-Source: ABdhPJzcfEjzjzs84yRfPExY+c3sa40G1zzoSg/KirfcnNCMDrFmGPaCDbydTxA9aJ7A+qM3L0zHpsaQKEKxpSJUors=
X-Received: by 2002:a05:620a:126d:: with SMTP id b13mr303030qkl.122.1617139757061;
 Tue, 30 Mar 2021 14:29:17 -0700 (PDT)
MIME-Version: 1.0
References: <20210324214020.34142-1-joel@joelfernandes.org>
 <20210324214020.34142-3-joel@joelfernandes.org> <20210327000943.GQ4746@worktop.programming.kicks-ass.net>
 <CABk29NthG_W_GyBknf1rZ35xbkppdPwosR+6ka=kCs70teoEqA@mail.gmail.com> <YGGkDHWQkYLyrVJW@hirez.programming.kicks-ass.net>
In-Reply-To: <YGGkDHWQkYLyrVJW@hirez.programming.kicks-ass.net>
From:   Josh Don <joshdon@google.com>
Date:   Tue, 30 Mar 2021 14:29:06 -0700
Message-ID: <CABk29NuHgtZdMb8usEk+ZELe8PaVejpJuhuR4DHaN-VmjJ=7eQ@mail.gmail.com>
Subject: Re: [PATCH resend 2/8] sched: core scheduling tagging infrastructure
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Nishanth Aravamudan <naravamudan@digitalocean.com>,
        Julien Desfossez <jdesfossez@digitalocean.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Vineeth Pillai <viremana@linux.microsoft.com>,
        Aaron Lu <aaron.lwe@gmail.com>,
        Aubrey Li <aubrey.intel@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>, torvalds@linux-foundation.org,
        fweisbec@gmail.com, Kees Cook <keescook@chromium.org>,
        Phil Auld <pauld@redhat.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>, vineeth@bitbyteword.org,
        Chen Yu <yu.c.chen@intel.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Agata Gruza <agata.gruza@intel.com>,
        Antonio Gomez Iglesias <antonio.gomez.iglesias@intel.com>,
        graf@amazon.com, konrad.wilk@oracle.com, dfaggioli@suse.com,
        Steven Rostedt <rostedt@goodmis.org>, benbjiang@tencent.com,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        James.Bottomley@hansenpartnership.com, OWeisse@umich.edu,
        Dhaval Giani <dhaval.giani@oracle.com>,
        "Hyser,Chris" <chris.hyser@oracle.com>,
        Hao Luo <haoluo@google.com>,
        Tom Lendacky <thomas.lendacky@amd.com>, dhiatt@digitalocean.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 29, 2021 at 2:55 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> OK, fixed the fails. My tired head made it unconditionally return the
> cookie-id of 'current' instead of task. Pushed out an update.

I see you have the per-task and prctl stuff pulled into your tree. I
can rebase the compound cookie and cgroup api patches on top if you'd
like; not sure if you've already re-ordered it locally. Any other
comments on the former?

> > > Also, we really need a better name than coretag.c.
> >
> > Yea, we don't really otherwise use the phrase "tagging". core_sched.c
> > is probably too confusing given we have sched/core.c.
>
> Right, so I tried core_sched and my fingers already hate it as much as
> kernel/scftorture.c (which I'd assumed my fingers would get used to
> eventually, but noooo).
>
> Looking at kernel/sched/ C is very overrepresented, so we really don't
> want another I think. B, E, G, H, J, K, N, seem to still be available in
> the first half of the alphabet. Maybe, bonghits.c, gabbleduck.c ?

hardware_vuln.c? Tricky to avoid a C with cpu, core, and cookie :)
