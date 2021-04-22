Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F4C8367DA0
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Apr 2021 11:23:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235486AbhDVJYE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Apr 2021 05:24:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230285AbhDVJYD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Apr 2021 05:24:03 -0400
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B0E1C06174A
        for <linux-kernel@vger.kernel.org>; Thu, 22 Apr 2021 02:23:28 -0700 (PDT)
Received: by mail-io1-xd2e.google.com with SMTP id a11so1715809ioo.0
        for <linux-kernel@vger.kernel.org>; Thu, 22 Apr 2021 02:23:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eRm1Yf5sTvd6CmDZjG6Wbzpb1CEEhSmYwR4MOXqWvnk=;
        b=MU0RsJW2CkWz5Xt47Hkc9ag+JfoW1jaF+N1PE+80/xlaZNQYK7WPSd1a+vWFZuNFpg
         6luBBb5f/29ANd7g++NItHljpLJInqAhg5cqBVB8MQP1vFMU6uJPKkibXvDfajxjgUMC
         HW7IvOvm7b5qBVHIBoVhzt85GDI8rfgtkXCgk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eRm1Yf5sTvd6CmDZjG6Wbzpb1CEEhSmYwR4MOXqWvnk=;
        b=INvJySEEVLdQGJJdt+eQApVX9GQq+Xwbsac5u7m9367lH8k2bpxgkToNZDD08gNVBf
         TlPRJROAOMvP6r7pCTSRf0qQL/JlI5RXsrqdUPBto3q8wI2iuPD7xZz6e63z/6XOfCRY
         UabnP8O5BtjwmC6ADPgrbm0PTAIs/zbS7M7FGt6NTu+nDS8Xj/x8ctKkLJZ1FlBDXzYz
         p14ejvsRdMLYy51A3KlBsF88UN+lQlv0TmntLBmY7lWhBxxQdNbfqpwtu1jHKhI+ZRRG
         zESG7QT/DE1s95cwMkIGZOlUgr7r6dJFP0ek7xgtIUv2Kjbbj97TafxXS29pcn+fG0ME
         +sqw==
X-Gm-Message-State: AOAM531keX96/cU/nq3BYqeg8CYAtrCfpBCCBo4FyxyhS6B2t/mfCcxF
        MhhvLlPAIDtsZTD2BwNMSxsMvPbnVXvyVMQ3iw3NaQ==
X-Google-Smtp-Source: ABdhPJwAlMY5jWK3WXu9xMqm8qcZHXIFVVJ52fCHW+xkGuIxQ92mGFFt7ErtdJv3MMgm4aMDfGScDIAG0n9hvPcVuBw=
X-Received: by 2002:a6b:590e:: with SMTP id n14mr2065164iob.130.1619083407853;
 Thu, 22 Apr 2021 02:23:27 -0700 (PDT)
MIME-Version: 1.0
References: <20210421190736.1538217-1-linux@rasmusvillemoes.dk>
 <CAEf4Bza6-Unvr7QmcbvVtNDPc4BNzf8zMaU4XardNqB_GnGDHw@mail.gmail.com> <236995f6-30ee-8047-624c-08d0a1552dc1@rasmusvillemoes.dk>
In-Reply-To: <236995f6-30ee-8047-624c-08d0a1552dc1@rasmusvillemoes.dk>
From:   Florent Revest <revest@chromium.org>
Date:   Thu, 22 Apr 2021 11:23:17 +0200
Message-ID: <CABRcYmJFfdCU_QxX+gYRWc+7BSbmTWX84o_WT=oBg_CPr8qS=g@mail.gmail.com>
Subject: Re: [PATCH] bpf: remove pointless code from bpf_do_trace_printk()
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alan Maguire <alan.maguire@oracle.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        bpf <bpf@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 22, 2021 at 9:13 AM Rasmus Villemoes
<linux@rasmusvillemoes.dk> wrote:
>
> On 22/04/2021 05.32, Andrii Nakryiko wrote:
> > On Wed, Apr 21, 2021 at 6:19 PM Rasmus Villemoes
> > <linux@rasmusvillemoes.dk> wrote:
> >>
> >> The comment is wrong. snprintf(buf, 16, "") and snprintf(buf, 16,
> >> "%s", "") etc. will certainly put '\0' in buf[0]. The only case where
> >> snprintf() does not guarantee a nul-terminated string is when it is
> >> given a buffer size of 0 (which of course prevents it from writing
> >> anything at all to the buffer).
> >>
> >> Remove it before it gets cargo-culted elsewhere.
> >>
> >> Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
> >> ---
> >>  kernel/trace/bpf_trace.c | 3 ---
> >>  1 file changed, 3 deletions(-)
> >>
> >
> > The change looks good to me, but please rebase it on top of the
> > bpf-next tree. This is not a bug, so it doesn't have to go into the
> > bpf tree. As it is right now, it doesn't apply cleanly onto bpf-next.

FWIW the idea of the patch also looks good to me :)

> Thanks for the pointer. Looking in next-20210420, it seems to me that
>
> commit d9c9e4db186ab4d81f84e6f22b225d333b9424e3
> Author: Florent Revest <revest@chromium.org>
> Date:   Mon Apr 19 17:52:38 2021 +0200
>
>     bpf: Factorize bpf_trace_printk and bpf_seq_printf
>
> is buggy. In particular, these two snippets:
>
> +#define BPF_CAST_FMT_ARG(arg_nb, args, mod)                            \
> +       (mod[arg_nb] == BPF_PRINTF_LONG_LONG ||                         \
> +        (mod[arg_nb] == BPF_PRINTF_LONG && __BITS_PER_LONG == 64)      \
> +         ? (u64)args[arg_nb]                                           \
> +         : (u32)args[arg_nb])
>
>
> +       ret = snprintf(buf, sizeof(buf), fmt, BPF_CAST_FMT_ARG(0, args,
> mod),
> +               BPF_CAST_FMT_ARG(1, args, mod), BPF_CAST_FMT_ARG(2,
> args, mod));
>
> Regardless of the casts done in that macro, the type of the resulting
> expression is that resulting from C promotion rules. And (foo ? (u64)bla
> : (u32)blib) has type u64, which is thus the type the compiler uses when
> building the vararg list being passed into snprintf(). C simply doesn't
> allow you to change types at run-time in this way.
>
> It probably works fine on x86-64, which passes the first six or so
> argument in registers, va_start() puts those registers into the va_list
> opaque structure, and when it comes time to do a va_arg(int), just the
> lower 32 bits are used. It is broken on i386 and other architectures
> where arguments are passed on the stack (and for x86-64 as well had
> there been a few more arguments) and va_arg(ap, int) is essentially ({
> int res = *(int *)ap; ap += 4; res; }) [or maybe it's -= 4 because stack
> direction etc., that's not really relevant here].
>
> Rasmus

Thank you Rasmus :)

It seems that we went offtrack in
https://lore.kernel.org/bpf/CAEf4BzZVEGM4esi-Rz67_xX_RTDrgxViy0gHfpeauECR5bmRNA@mail.gmail.com/
and we do need something like "88a5c690b6 bpf: fix bpf_trace_printk on
32 bit archs". Thinking about it again, it's clearer now why the
__BPF_TP_EMIT macro emits 2^3=8 different __trace_printk() indeed.

In the case of bpf_trace_printk with a maximum of 3 args, it's
relatively cheap; but for bpf_seq_printf and bpf_snprintf which accept
up to 12 arguments, that would be 2^12=4096 calls. Until now
bpf_seq_printf has just ignored this problem and just considered
everything as u64, I wonder if that'd be the best approach for these
two helpers anyway.
