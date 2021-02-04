Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB5BC30FC18
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 20:00:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239465AbhBDS60 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 13:58:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239292AbhBDSmR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 13:42:17 -0500
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55A92C06178C
        for <linux-kernel@vger.kernel.org>; Thu,  4 Feb 2021 10:41:32 -0800 (PST)
Received: by mail-lj1-x229.google.com with SMTP id f19so4658878ljn.5
        for <linux-kernel@vger.kernel.org>; Thu, 04 Feb 2021 10:41:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QilnL1GiLc35zL0JKgGqLLH0jCvxrl7AURnizvwxOrk=;
        b=wwOS3lN7TXu7QWeoGhYz2RQIaOHUMrxwlkR7ONEgKZc8tcuOjeXZTXB1WKjKgAsbTt
         yBmSE3VnOWAKWOMUea3DJjb2qXnmzvGek24oz8Rn6MMVgsK6wQrdn+irVG6eFfiwAFAq
         /d6esWbvjJAsIQ26Ihjbz7XJe2at9o+eKRRE8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QilnL1GiLc35zL0JKgGqLLH0jCvxrl7AURnizvwxOrk=;
        b=ocyD7F4TNPKrZnvM+9K/QpTMKLCnQiPJQJcMYNQ+HR6hexerP80wxXQBUqsadbn+Id
         4Am35Cq3uRkaokveupZ23Kq/BEn+DQnc+d5/E4k+iMV5tMeWsNZLIDNplpU/ZZqcTeJC
         L2miLJqy8rmv5M8IMBhjx+Ye6dsz0tzCHl/lDpukiIoiiyoK93uDq2K2zf8yaX1d9XTk
         j7AAGyVSB9IoRmp4KlKjd/dbHjjMoHq30ZSnCL0VhDmNL9K3lKfdUbd7d/Cl6Yn0ksFC
         yb9e+uhj717WaxddP3lMZjY7sqX5Mr0QC2ZH5DQ+nDfQbcChMkYGk6ZDXlEm2HCJVuYp
         wzlg==
X-Gm-Message-State: AOAM532wtCh70Uezxzi6RoIKFl9L0vLLoNzOEBihj9g3O6U4+dET2++E
        CxVY92fAN3psCI/y8Tautf8dO7tp/+TmgGetUKu5Bw==
X-Google-Smtp-Source: ABdhPJwJtrhYEdPaQdR6fHW3cU2NP6bOoOiL2TtDHuAX1Y9bu5c2RTiAw480hYJajzznm79yfeZHPAMVBc9ok0h1jMo=
X-Received: by 2002:a2e:9b57:: with SMTP id o23mr427754ljj.314.1612464090601;
 Thu, 04 Feb 2021 10:41:30 -0800 (PST)
MIME-Version: 1.0
References: <CABWYdi3HjduhY-nQXzy2ezGbiMB1Vk9cnhW2pMypUa+P1OjtzQ@mail.gmail.com>
 <CABWYdi27baYc3ShHcZExmmXVmxOQXo9sGO+iFhfZLq78k8iaAg@mail.gmail.com>
 <20210203214448.2703930e@oasis.local.home> <20210204030948.dmsmwyw6fu5kzgey@treble>
In-Reply-To: <20210204030948.dmsmwyw6fu5kzgey@treble>
From:   Ivan Babrou <ivan@cloudflare.com>
Date:   Thu, 4 Feb 2021 10:41:18 -0800
Message-ID: <CABWYdi15x=-2qenWSdX_ONSha_Pz7GFJrx8axN6CJS5cWxTTSg@mail.gmail.com>
Subject: Re: BUG: KASAN: stack-out-of-bounds in unwind_next_frame+0x1df5/0x2650
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        kernel-team <kernel-team@cloudflare.com>,
        Ignat Korchagin <ignat@cloudflare.com>,
        Hailong liu <liu.hailong6@zte.com.cn>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Miroslav Benes <mbenes@suse.cz>,
        Julien Thierry <jthierry@redhat.com>,
        Jiri Slaby <jirislaby@kernel.org>, kasan-dev@googlegroups.com,
        linux-mm@kvack.org, linux-kernel <linux-kernel@vger.kernel.org>,
        Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>, dm-devel@redhat.com,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andriin@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Robert Richter <rric@kernel.org>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Linux Kernel Network Developers <netdev@vger.kernel.org>,
        bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 3, 2021 at 7:10 PM Josh Poimboeuf <jpoimboe@redhat.com> wrote:

> This line gives a big clue:
>
>   [160676.608966][    C4] RIP: 0010:0xffffffffc17d814c
>
> That address, without a function name, most likely means that it was
> running in some generated code (mostly likely BPF) when it got
> interrupted.

We do have eBPF/XDP in our environment.

> Right now, the ORC unwinder tries to fall back to frame pointers when it
> encounters generated code:
>
>         orc = orc_find(state->signal ? state->ip : state->ip - 1);
>         if (!orc)
>                 /*
>                  * As a fallback, try to assume this code uses a frame pointer.
>                  * This is useful for generated code, like BPF, which ORC
>                  * doesn't know about.  This is just a guess, so the rest of
>                  * the unwind is no longer considered reliable.
>                  */
>                 orc = &orc_fp_entry;
>                 state->error = true;
>         }
>
> Because the ORC unwinder is guessing from that point onward, it's
> possible for it to read the KASAN stack redzone, if the generated code
> hasn't set up frame pointers.  So the best fix may be for the unwinder
> to just always bypass KASAN when reading the stack.
>
> The unwinder has a mechanism for detecting and warning about
> out-of-bounds, and KASAN is short-circuiting that.
>
> This should hopefully get rid of *all* the KASAN unwinder warnings, both
> crypto and networking.

It definitely worked on my dm-crypt case, and I've tried it without
your previous AVX related patch. I will apply it to our tree and
deploy to the staging KASAN environment to see how it fares with
respect to networking stacks. Feel free to ping me if I don't get back
to you with the results on Monday.

Thanks for looking into this!
