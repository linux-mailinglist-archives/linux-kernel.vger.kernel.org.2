Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09EAF355853
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Apr 2021 17:42:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345907AbhDFPmk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Apr 2021 11:42:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345901AbhDFPmg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Apr 2021 11:42:36 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5AD1C06174A
        for <linux-kernel@vger.kernel.org>; Tue,  6 Apr 2021 08:42:27 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id r193so13096476ior.9
        for <linux-kernel@vger.kernel.org>; Tue, 06 Apr 2021 08:42:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6yuM2FMRUJwl6h7NJ7ORzgicbz5nr00WuJkQeXJ1kuA=;
        b=WA8luX17wUAamJDGGrccgiIstP5J/szgoSQdO19y/uI4Q6N+hiHQ1WxgeHrG+gliJa
         fjrlFaywq5PgPCt3KDJvCIqsXPKFnBJGdj+1c6zxEIV3uwyl21FpweyC4V++Ce7DL0Ah
         NDV0mHoHWsM6/0qOBeR3V7Pht9hUfdyAoUyLE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6yuM2FMRUJwl6h7NJ7ORzgicbz5nr00WuJkQeXJ1kuA=;
        b=cmHsLf6EkukHKKse964HZqetY/LejJ5JhFwKF7rnNBGLZa5v7oi0pYObAuGwOazrET
         mxuivh1cbSGVdmJqA8hKfCMtH3CHvujVjWQ4+jdqNvqqVFZSBDmPuiqp5kqmoNHVmfZK
         tmL8yIuTu+BeLehMJBnTEtn+h7NbLAM2ATzIzkW76TU2M7a7bj7Yn6MBrWfRRuWDPpOp
         qT4BZZQMPgvFJCEzrXnBeT6U4kkiqjiSYXyon+mU+c2YTdGun1Q1qVY7u8bZOfBfflEy
         sA4GTawCbXt6+0or2sE0obFHKWeozCaSOztoSZUhB9HajZt7a4gNWbY76VQM/fJfZ3v1
         oPyQ==
X-Gm-Message-State: AOAM533kMKkoWaYiL+BGyDe4Fi7sQyLXFxq0ccFqMf9xwFwY6eP9aFFa
        A8orvlibVIsfgisxn2hPGr9q+G7361aqYgOox3ZeLA==
X-Google-Smtp-Source: ABdhPJzOwwJtjQRciV12szv0027FWcMRRZPyX/sYtasYoDcG1me9lmObLfyOqI131l/gsqCAnMJ04lf50R5OGMBY3XU=
X-Received: by 2002:a05:6638:606:: with SMTP id g6mr29793910jar.52.1617723747119;
 Tue, 06 Apr 2021 08:42:27 -0700 (PDT)
MIME-Version: 1.0
References: <20210324022211.1718762-1-revest@chromium.org> <20210324022211.1718762-5-revest@chromium.org>
 <CAEf4BzbCZnLV6mHqqAX9vcEjxtKzu3a9RFCSs9wbmQWw67gXtA@mail.gmail.com>
In-Reply-To: <CAEf4BzbCZnLV6mHqqAX9vcEjxtKzu3a9RFCSs9wbmQWw67gXtA@mail.gmail.com>
From:   Florent Revest <revest@chromium.org>
Date:   Tue, 6 Apr 2021 17:42:16 +0200
Message-ID: <CABRcYmJA47nk0=f=65H6-sFz-km+wBWwLJWjOz2NbEEboR3kQQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 4/6] libbpf: Initialize the bpf_seq_printf
 parameters array field by field
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Yonghong Song <yhs@fb.com>, KP Singh <kpsingh@kernel.org>,
        Brendan Jackman <jackmanb@chromium.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 27, 2021 at 12:01 AM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Tue, Mar 23, 2021 at 7:23 PM Florent Revest <revest@chromium.org> wrote:
> >
> > When initializing the __param array with a one liner, if all args are
> > const, the initial array value will be placed in the rodata section but
> > because libbpf does not support relocation in the rodata section, any
> > pointer in this array will stay NULL.
> >
> > Fixes: c09add2fbc5a ("tools/libbpf: Add bpf_iter support")
> > Signed-off-by: Florent Revest <revest@chromium.org>
> > ---
> >  tools/lib/bpf/bpf_tracing.h | 26 ++++++++++++++++++++++----
> >  1 file changed, 22 insertions(+), 4 deletions(-)
> >
> > diff --git a/tools/lib/bpf/bpf_tracing.h b/tools/lib/bpf/bpf_tracing.h
> > index f9ef37707888..d9a4c3f77ff4 100644
> > --- a/tools/lib/bpf/bpf_tracing.h
> > +++ b/tools/lib/bpf/bpf_tracing.h
> > @@ -413,6 +413,22 @@ typeof(name(0)) name(struct pt_regs *ctx)                              \
> >  }                                                                          \
> >  static __always_inline typeof(name(0)) ____##name(struct pt_regs *ctx, ##args)
> >
> > +#define ___bpf_fill0(arr, p, x)
>
> can you please double-check that no-argument BPF_SEQ_PRINTF won't
> generate a warning about spurious ';'? Maybe it's better to have zero
> case as `do {} while(0);` ?
>
> > +#define ___bpf_fill1(arr, p, x) arr[p] = x
> > +#define ___bpf_fill2(arr, p, x, args...) arr[p] = x; ___bpf_fill1(arr, p + 1, args)
> > +#define ___bpf_fill3(arr, p, x, args...) arr[p] = x; ___bpf_fill2(arr, p + 1, args)
> > +#define ___bpf_fill4(arr, p, x, args...) arr[p] = x; ___bpf_fill3(arr, p + 1, args)
> > +#define ___bpf_fill5(arr, p, x, args...) arr[p] = x; ___bpf_fill4(arr, p + 1, args)
> > +#define ___bpf_fill6(arr, p, x, args...) arr[p] = x; ___bpf_fill5(arr, p + 1, args)
> > +#define ___bpf_fill7(arr, p, x, args...) arr[p] = x; ___bpf_fill6(arr, p + 1, args)
> > +#define ___bpf_fill8(arr, p, x, args...) arr[p] = x; ___bpf_fill7(arr, p + 1, args)
> > +#define ___bpf_fill9(arr, p, x, args...) arr[p] = x; ___bpf_fill8(arr, p + 1, args)
> > +#define ___bpf_fill10(arr, p, x, args...) arr[p] = x; ___bpf_fill9(arr, p + 1, args)
> > +#define ___bpf_fill11(arr, p, x, args...) arr[p] = x; ___bpf_fill10(arr, p + 1, args)
> > +#define ___bpf_fill12(arr, p, x, args...) arr[p] = x; ___bpf_fill11(arr, p + 1, args)
> > +#define ___bpf_fill(arr, args...) \
> > +       ___bpf_apply(___bpf_fill, ___bpf_narg(args))(arr, 0, args)
>
> cool. this is regular enough to easily comprehend :)
>
> > +
> >  /*
> >   * BPF_SEQ_PRINTF to wrap bpf_seq_printf to-be-printed values
> >   * in a structure.
> > @@ -421,12 +437,14 @@ static __always_inline typeof(name(0)) ____##name(struct pt_regs *ctx, ##args)
> >         ({                                                                  \
> >                 _Pragma("GCC diagnostic push")                              \
> >                 _Pragma("GCC diagnostic ignored \"-Wint-conversion\"")      \
> > +               unsigned long long ___param[___bpf_narg(args)];             \
> >                 static const char ___fmt[] = fmt;                           \
> > -               unsigned long long ___param[] = { args };                   \
> > +               int __ret;                                                  \
> > +               ___bpf_fill(___param, args);                                \
> >                 _Pragma("GCC diagnostic pop")                               \
>
> Let's clean this up a little bit;
> 1. static const char ___fmt should be the very first
> 2. _Pragma scope should be minimal necessary, which includes only
> ___bpf_fill, right?
> 3. Empty line after int __ret; and let's keep three underscores for consistency.
>
>
> > -               int ___ret = bpf_seq_printf(seq, ___fmt, sizeof(___fmt),    \
> > -                                           ___param, sizeof(___param));    \
> > -               ___ret;                                                     \
> > +               __ret = bpf_seq_printf(seq, ___fmt, sizeof(___fmt),         \
> > +                                      ___param, sizeof(___param));         \
> > +               __ret;                                                      \
>
> but actually you don't need __ret at all, just bpf_seq_printf() here, right?

Agreed with everything and also the indentation comment in 5/6, thanks.
