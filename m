Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DCA533E19F
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 23:44:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231614AbhCPWoT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 18:44:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231491AbhCPWnz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 18:43:55 -0400
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com [IPv6:2607:f8b0:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 766AEC06175F
        for <linux-kernel@vger.kernel.org>; Tue, 16 Mar 2021 15:43:55 -0700 (PDT)
Received: by mail-il1-x12c.google.com with SMTP id r7so14288478ilb.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 Mar 2021 15:43:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9XAvuFWdmQy3xZ0tIrqdndnKRShiZqASvPAH/JmjKcM=;
        b=UWVV8y4Sms4pRvVLpUwFx+5lwn1JhWB442QGbQclv+PFIsweohMIvYDf0nRydc4ooV
         vkB9Qzw7nmdW/p1UgSUvesCp9PFuqY1v6Ymw7l1QvKBzHggK/+JGpQMY36dBrS5HE7GY
         iWligzASsWKwh/bJ8aoOmJ5kehUcr9q1qyfYg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9XAvuFWdmQy3xZ0tIrqdndnKRShiZqASvPAH/JmjKcM=;
        b=Xs0eUX5bOJGeY2s/zGyEmJe0+fhjy4m5l/cycXd2y4n/CLXxoCtddVvmFrPngT5p8r
         7MgkfOU9uwVfTeoD3ztC9VVoT+5C7WlmIk1O7YY1oWJt2OfWwlp5w1uvjD1E5zI0Ygfo
         uZ/lBiP3AB1umVMHo8jgI+qvgpcRGhBSvFq9KMYw0xeSopxlqF3jt2KFFmz3SiMGEaqn
         m+2om2eGHvMxE0osSjiYIqAfQ6HhGkoDeJbEckVCvDwaeUbytsTTMzKisu4BWr71kfgj
         T6RuheBqFOtVG0NjpgoD+L7GwLdav0hGcG1m0fJOvVTnI0cBCXfOwIKu/HAOYN9ZbZf7
         eSTg==
X-Gm-Message-State: AOAM531JqX70hnn5zFukco1aQ9Iax8iSr7oZnJVQruYoTIk01FiNun0h
        XGPfj3U+wggPlhScnYC/h5Y6rPGrBUreVt/kkdulDQ==
X-Google-Smtp-Source: ABdhPJzict47n9jer7cRQ+Z8026T+dgw52nvIcQAU8k+eKtHQyeihQXP3vbyJj30cV7iMCXIqkE/sd1pGDlKYS3BLFM=
X-Received: by 2002:a92:c04b:: with SMTP id o11mr5240203ilf.42.1615934634809;
 Tue, 16 Mar 2021 15:43:54 -0700 (PDT)
MIME-Version: 1.0
References: <20210310220211.1454516-1-revest@chromium.org> <20210310220211.1454516-4-revest@chromium.org>
 <CAEf4BzZmQ3C=DfSRckM0AUXhz2MeghwhF6RLspS2u44sx0LP-g@mail.gmail.com>
In-Reply-To: <CAEf4BzZmQ3C=DfSRckM0AUXhz2MeghwhF6RLspS2u44sx0LP-g@mail.gmail.com>
From:   Florent Revest <revest@chromium.org>
Date:   Tue, 16 Mar 2021 23:43:43 +0100
Message-ID: <CABRcYmK2o0odG+OkE=-s2QYZ-i=twqup0z_9_9pSh2ipTLLeEg@mail.gmail.com>
Subject: Re: [PATCH bpf-next 3/5] libbpf: Initialize the bpf_seq_printf
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

On Tue, Mar 16, 2021 at 5:36 AM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
> On Wed, Mar 10, 2021 at 2:02 PM Florent Revest <revest@chromium.org> wrote:
> > +#define ___bpf_build_param0(narg, x)
> > +#define ___bpf_build_param1(narg, x) ___param[narg - 1] = x
> > +#define ___bpf_build_param2(narg, x, args...) ___param[narg - 2] = x; \
> > +                                             ___bpf_build_param1(narg, args)
> > +#define ___bpf_build_param3(narg, x, args...) ___param[narg - 3] = x; \
> > +                                             ___bpf_build_param2(narg, args)
> > +#define ___bpf_build_param4(narg, x, args...) ___param[narg - 4] = x; \
> > +                                             ___bpf_build_param3(narg, args)
> > +#define ___bpf_build_param5(narg, x, args...) ___param[narg - 5] = x; \
> > +                                             ___bpf_build_param4(narg, args)
> > +#define ___bpf_build_param6(narg, x, args...) ___param[narg - 6] = x; \
> > +                                             ___bpf_build_param5(narg, args)
> > +#define ___bpf_build_param7(narg, x, args...) ___param[narg - 7] = x; \
> > +                                             ___bpf_build_param6(narg, args)
> > +#define ___bpf_build_param8(narg, x, args...) ___param[narg - 8] = x; \
> > +                                             ___bpf_build_param7(narg, args)
> > +#define ___bpf_build_param9(narg, x, args...) ___param[narg - 9] = x; \
> > +                                             ___bpf_build_param8(narg, args)
> > +#define ___bpf_build_param10(narg, x, args...) ___param[narg - 10] = x; \
> > +                                              ___bpf_build_param9(narg, args)
> > +#define ___bpf_build_param11(narg, x, args...) ___param[narg - 11] = x; \
> > +                                              ___bpf_build_param10(narg, args)
> > +#define ___bpf_build_param12(narg, x, args...) ___param[narg - 12] = x; \
> > +                                              ___bpf_build_param11(narg, args)
>
> took me some time to get why the [narg - 12] :) it makes sense, but
> then I started wondering why not
>
> #define ___bpf_build_param12(narg, x, args...)
> ___bpf_build_param11(narg, args); ___param[11] = x
>
> ? seems more straightforward, no?

Unless I'm misunderstanding something, I don't think this would work.
The awkward "narg - 12" comes from the fact that these variadic macros
work by taking the first argument out of the variadic arguments (x
followed by args) and calling another macro with what's left (args).

So if you do __bpf_build_param(arg1, arg2) you will have
__bpf_build_param2() called with arg1 and __bpf_build_param1() called
with arg2. And if you do __bpf_build_param(arg1, arg2, arg3) you will
have __bpf_build_param3() called with arg1, __bpf_build_param2()
called with arg2, and __bpf_build_param1() called with arg3.
Basically, things are inverted, the position at which you need to
insert in ___param evolves in the opposite direction of the X after
___bpf_build_param which is the number of arguments left.

No matter in which order __bpf_build_paramX calls
__bpf_build_param(X-1) (before or after setting ___param[n]) you will
be unable to know just from the macro name at which cell in __param
you need to write the argument. (except for __bpf_build_param12 which
is an exception, because the max number of arg is 12, if this macro
gets called, then we know that narg=12 and we will always write at
__param[0])

That being said, I share your concern that this code is hard to read.
So instead of giving narg to each macro, I tried to give a pos
argument which indicates in which cell the macro should write. pos is
basically a counter that goes from 0 to narg as macros go from narg to
0.

#define ___bpf_fill0(array, pos, x)
#define ___bpf_fill1(array, pos, x) array[pos] = x
#define ___bpf_fill2(array, pos, x, args...) array[pos] = x;
___bpf_fill1(array, pos + 1, args)
#define ___bpf_fill3(array, pos, x, args...) array[pos] = x;
___bpf_fill2(array, pos + 1, args)
#define ___bpf_fill4(array, pos, x, args...) array[pos] = x;
___bpf_fill3(array, pos + 1, args)
#define ___bpf_fill5(array, pos, x, args...) array[pos] = x;
___bpf_fill4(array, pos + 1, args)
#define ___bpf_fill6(array, pos, x, args...) array[pos] = x;
___bpf_fill5(array, pos + 1, args)
#define ___bpf_fill7(array, pos, x, args...) array[pos] = x;
___bpf_fill6(array, pos + 1, args)
#define ___bpf_fill8(array, pos, x, args...) array[pos] = x;
___bpf_fill7(array, pos + 1, args)
#define ___bpf_fill9(array, pos, x, args...) array[pos] = x;
___bpf_fill8(array, pos + 1, args)
#define ___bpf_fill10(array, pos, x, args...) array[pos] = x;
___bpf_fill9(array, pos + 1, args)
#define ___bpf_fill11(array, pos, x, args...) array[pos] = x;
___bpf_fill10(array, pos + 1, args)
#define ___bpf_fill12(array, pos, x, args...) array[pos] = x;
___bpf_fill11(array, pos + 1, args)
#define ___bpf_fill(array, args...) \
___bpf_apply(___bpf_fill, ___bpf_narg(args))(array, 0, args)

I hope this makes things a bit clearer ? (I often joke that BPF is
written in preprocessor... :p)
