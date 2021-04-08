Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1EE22358FF2
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 00:43:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232856AbhDHWnl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 18:43:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232265AbhDHWnk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 18:43:40 -0400
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2658C061760
        for <linux-kernel@vger.kernel.org>; Thu,  8 Apr 2021 15:43:28 -0700 (PDT)
Received: by mail-il1-x12a.google.com with SMTP id c15so3193462ilj.1
        for <linux-kernel@vger.kernel.org>; Thu, 08 Apr 2021 15:43:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BpHzUGdRowvtDiAywRoryOv4Gi7gkz05qufslcYFGwQ=;
        b=djDOQN+31Q3Y0BD0vwOBfPXi70LypiFBtpuqpeCFriU/NCgtEMPozpDKoaKhXjVlV8
         koB8B8xzs2WrRH7udq4Hk7l1UsTXs4MR6PNzgcrCoSET+L7QANYZh1rBvlQ1X1kNiZRx
         RT8pLzr7V6VNxmJeit2nTiZJha1NZz8Hi2i7E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BpHzUGdRowvtDiAywRoryOv4Gi7gkz05qufslcYFGwQ=;
        b=SM/kWIQAkGuQ22naqASHfRF+zmfViVxh0NCYytLOeCi94Yt63z4SzWq9ULs9a9vhXb
         gXb+li+fQ+Jrp8kDZWiEfgmAl0iQ3MwrmWHS8rpQ0KNnUhKmfa0bqYUtzeLGA3BnmW4e
         1lJkzo2Xtz3CSdQolzMSMqzhwVo9Ts1xHart7o8Iya+3urr4vpftamFI7oq3ZO8knsAt
         w3x3txb4j2/64x+lAnLS/6zE3ZG1fovNHPe97/8s8CPvNBB1aUgO5U4z98XDyri1HxxE
         1XYuGaVknIe6NfQrp0qNHoO8eEB4K6wEewyDoeGendX6mqlqZGEVcy4K7g+pBiY+YOzx
         r8vA==
X-Gm-Message-State: AOAM531ccBuTRuzqEmyz2PMOgkzZNy1XUlguaEtE7hUq8FI0lF6EmS56
        Zp5Wf9XypqDo7n6PTyw+gWZ/hrzHHM36b9gJnfRUjA==
X-Google-Smtp-Source: ABdhPJx8msL7bB99YO61UT2GqM4482PuBvwTaHZsXCShxzrFGkTW2RnxD93boptXlIlUy3fNz/jTMm6EZkH0H9elcnw=
X-Received: by 2002:a92:c9ca:: with SMTP id k10mr8542214ilq.42.1617921808250;
 Thu, 08 Apr 2021 15:43:28 -0700 (PDT)
MIME-Version: 1.0
References: <20210324022211.1718762-1-revest@chromium.org> <20210324022211.1718762-4-revest@chromium.org>
 <CAEf4Bzbfyd7r4cx8Lcjx7gm8beKxuf=wYW5StM1ZFaVaNL9U-g@mail.gmail.com>
 <CABRcYm+3q7a64heRVHLUu+S6xqmTGg2TuyB=JwD6V8pFiFpz_g@mail.gmail.com> <CAEf4BzbKJ9msu5Y5y_wvAfzeykkBxXp606YFv32iE2DoN=ZVXg@mail.gmail.com>
In-Reply-To: <CAEf4BzbKJ9msu5Y5y_wvAfzeykkBxXp606YFv32iE2DoN=ZVXg@mail.gmail.com>
From:   Florent Revest <revest@chromium.org>
Date:   Fri, 9 Apr 2021 00:43:17 +0200
Message-ID: <CABRcYmK=2O0Ks1eirtFXXnOJue+sbN=aP6m7Ow+zD7Oi5WM2SQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 3/6] bpf: Add a bpf_snprintf helper
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

On Thu, Apr 8, 2021 at 12:03 AM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
> On Tue, Apr 6, 2021 at 9:06 AM Florent Revest <revest@chromium.org> wrote:
> > On Fri, Mar 26, 2021 at 11:55 PM Andrii Nakryiko
> > <andrii.nakryiko@gmail.com> wrote:
> > > On Tue, Mar 23, 2021 at 7:23 PM Florent Revest <revest@chromium.org> wrote:
> > > > + *             Formats **%s** and **%p{i,I}{4,6}** require to read kernel
> > > > + *             memory. Reading kernel memory may fail due to either invalid
> > > > + *             address or valid address but requiring a major memory fault. If
> > > > + *             reading kernel memory fails, the string for **%s** will be an
> > > > + *             empty string, and the ip address for **%p{i,I}{4,6}** will be 0.
> > >
> > > would it make sense for sleepable programs to allow memory fault when
> > > reading memory?
> >
> > Probably yes. How would you do that ? I'm guessing that in
> > bpf_trace_copy_string you would call either strncpy_from_X_nofault or
> > strncpy_from_X depending on a condition but I'm not sure which one.
>
> So you'd have different bpf_snprintf_proto definitions for sleepable
> and non-sleepable programs. And each implementation would call
> bpf_printf_prepare() with a flag specifying which copy_string variant
> to use (sleepable or not). So for BPF users it would be the same
> bpf_snprintf() helper, but it would transparently be doing different
> things depending on which BPF program it is being called from. That's
> how we do bpf_get_stack(), for example, see
> bpf_get_stack_proto_pe/bpf_get_stack_proto_raw_tp/bpf_get_stack_proto_tp.
>
> But consider that for a follow up, no need to address right now.

Ok let's keep this separate.

> >
> > > > + *             Not returning error to bpf program is consistent with what
> > > > + *             **bpf_trace_printk**\ () does for now.
> > > > + *
> > > > + *     Return
> > > > + *             The strictly positive length of the formatted string, including
> > > > + *             the trailing zero character. If the return value is greater than
> > > > + *             **str_size**, **str** contains a truncated string, guaranteed to
> > > > + *             be zero-terminated.
> > >
> > > Except when str_size == 0.
> >
> > Right
> >
>
> So I assume you'll adjust the comment? I always find it confusing when
> zero case is allowed but it is not specified what's the behavior is.

Yes, sorry it wasn't clear :) I agree it's worth being explicit.

> > > > +       err = snprintf(str, str_size, fmt, BPF_CAST_FMT_ARG(0, args, mod),
> > > > +               BPF_CAST_FMT_ARG(1, args, mod), BPF_CAST_FMT_ARG(2, args, mod),
> > > > +               BPF_CAST_FMT_ARG(3, args, mod), BPF_CAST_FMT_ARG(4, args, mod),
> > > > +               BPF_CAST_FMT_ARG(5, args, mod), BPF_CAST_FMT_ARG(6, args, mod),
> > > > +               BPF_CAST_FMT_ARG(7, args, mod), BPF_CAST_FMT_ARG(8, args, mod),
> > > > +               BPF_CAST_FMT_ARG(9, args, mod), BPF_CAST_FMT_ARG(10, args, mod),
> > > > +               BPF_CAST_FMT_ARG(11, args, mod));
> > > > +       if (str_size)
> > > > +               str[str_size - 1] = '\0';
> > >
> > > hm... what if err < str_size ?
> >
> > Then there would be two zeroes, one set by snprintf in the middle and
> > one set by us at the end. :| I was a bit lazy there, I agree it would
> > be nicer if we'd do if (err >= str_size) instead.
> >
>
> snprintf() seems to be always zero-terminating the string if str_size
> > 0, and does nothing if str_size == 0, which is exactly what you
> want, so you can just drop that zero termination logic.

Oh, that's right! I was confused by snprintf's documentation "the
resulting string is truncated" but as I read the vsnprintf
implementation I see this is indeed always zero-terminated. Great :)

> > Also makes me wonder what if str == NULL and str_size != 0. I just
> > assumed that the verifier would prevent that from happening but
> > discussions in the other patches make me unsure now.
>
>
> ARG_CONST_SIZE_OR_ZERO should make sure that ARG_PTR_TO_MEM before
> that is a valid initialized memory. But please double-check, of
> course.

Will do.
