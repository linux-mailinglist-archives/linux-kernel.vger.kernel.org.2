Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15B47373DA1
	for <lists+linux-kernel@lfdr.de>; Wed,  5 May 2021 16:25:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232582AbhEEO0m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 May 2021 10:26:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231792AbhEEO0k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 May 2021 10:26:40 -0400
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43343C061574
        for <linux-kernel@vger.kernel.org>; Wed,  5 May 2021 07:25:43 -0700 (PDT)
Received: by mail-il1-x134.google.com with SMTP id j12so1875694ils.4
        for <linux-kernel@vger.kernel.org>; Wed, 05 May 2021 07:25:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PYIRtGGIsk1yNbWCE56gr4ny4GvEit0XmHd+klLpptA=;
        b=dZqtmzDDVMaAYS+sL7UHhE+FDvTb4Hj13ZdSs0/7JAwKm31+AdZ6sMfKcd76n8BgRn
         lFoCblDXNkV2AtMUX/wDT4KFq3e6vGIy1U2CBSxft/phzyKPEEBhiUkqOc6D5ICoxIqi
         jjiKvybZ/l4+NmrXpaELjdhZIiBqJt0yMfyo0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PYIRtGGIsk1yNbWCE56gr4ny4GvEit0XmHd+klLpptA=;
        b=Xr/iRzOu1LcKntXWI7TwbsmOwUuyH0mAnAn6ZVIpeTy2gvv2T6hnk1a4eNLpMRjAWQ
         vYF4KhxuK8PzAZLMnwU0hqOunzyoSE7ji9Yb1u68SQ86Grk1JM9iznocDe8Iyz2+ls88
         ZQYq39s3SIhlX4xNt21Skboi6Inwv/EFuITKMw5bJ5ueCA4Yh4xqLThWqBciwInH0bGP
         M638FBADzeIGUZZ9ueSK6+0kY/osQx1CN6vZSOP2JS95GgpZuEmHR2+lFZzuP2MAK8Qv
         gvCS+hszVM9fC6BucvXpH/qdY/JNSC3c5B8y5iD32js0gDtPbBTxncE4hF69pOXwQsQi
         lrwA==
X-Gm-Message-State: AOAM533SzAA3VC1bFts7glRUJWwBCDT/uP3fI4kwmPOuu/b0ntXCBLZL
        i+UmcCspuyIsILSw44NBSeoOt3nbg+9PRpfErxcv9w==
X-Google-Smtp-Source: ABdhPJzQ+FLLDFINxcYPEDpoV3NLKb3eYCmr8yiohiGGpphSrlhrFuvjG4+xzoo3aJi/AsPa4UB3m9FuEe/8u17gHy4=
X-Received: by 2002:a92:de11:: with SMTP id x17mr25128360ilm.42.1620224742374;
 Wed, 05 May 2021 07:25:42 -0700 (PDT)
MIME-Version: 1.0
References: <20210419155243.1632274-1-revest@chromium.org> <20210419155243.1632274-7-revest@chromium.org>
 <CAEf4BzZUM4hb9owhompwARabRvRbCYxBrpgXSdXM8RRm42tU1A@mail.gmail.com>
 <CABRcYm+=XSt_U-19eYXU8+XwDUXoBGQMROMbm6xk9P9OHnUW_A@mail.gmail.com>
 <CAEf4BzZnkYDAm2R+5R9u4YEdZLj=C8XQmpT=iS6Qv0Ne7cRBGw@mail.gmail.com>
 <CABRcYmLn2S2g-QTezy8qECsU2QNSQ6wyjhuaHpuM9dzq97mZ7g@mail.gmail.com>
 <2db39f1c-cedd-b9e7-2a15-aef203f068eb@rasmusvillemoes.dk> <CABRcYmJdTZAhdD_2OVAu-hOnYX-bgvrrbnUjaV23tzp-c+9_8w@mail.gmail.com>
 <CAEf4BzaHqvxuosYP32WLSs_wxeJ9FfR2wGRKqsocXHCJUXVycw@mail.gmail.com>
 <CABRcYm+pO94dFW83SZCtKQE8x6PkRicr+exGD3CNwGwQUYmFcw@mail.gmail.com> <f0888d2a-3a31-e454-001c-e46cc21b1664@rasmusvillemoes.dk>
In-Reply-To: <f0888d2a-3a31-e454-001c-e46cc21b1664@rasmusvillemoes.dk>
From:   Florent Revest <revest@chromium.org>
Date:   Wed, 5 May 2021 16:25:31 +0200
Message-ID: <CABRcYmLvR-9WS2M7d3vYmgapVuEHXqXTY1gv3PmfW5DzhDCbHA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v5 6/6] selftests/bpf: Add a series of tests for bpf_snprintf
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Yonghong Song <yhs@fb.com>, KP Singh <kpsingh@kernel.org>,
        Brendan Jackman <jackmanb@chromium.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 5, 2021 at 8:55 AM Rasmus Villemoes
<linux@rasmusvillemoes.dk> wrote:
>
> On 28/04/2021 16.59, Florent Revest wrote:
> > On Tue, Apr 27, 2021 at 8:03 PM Andrii Nakryiko
> > <andrii.nakryiko@gmail.com> wrote:
> >>
> >> On Tue, Apr 27, 2021 at 2:51 AM Florent Revest <revest@chromium.org> wrote:
> >>>
> >>> On Tue, Apr 27, 2021 at 8:35 AM Rasmus Villemoes
> >>> <linux@rasmusvillemoes.dk> wrote:
> >>>> Probably the test cases are not run in parallel, but this is the kind of
> >>>> thing that would give those symptoms.
> >>>
> >>> I think it's a separate issue from what Andrii reported though because
> >>> the flaky test exercises the bpf_snprintf helper and this buf spinlock
> >>> bug you just found only affects the bpf_trace_printk helper.
> >>>
> >>> That being said, it does smell a little bit like a concurrency issue
> >>> too, indeed. The bpf_snprintf test program is a raw_tp/sys_enter so it
> >>> attaches to all syscall entries and most likely gets executed many
> >>> more times than necessary and probably on parallel CPUs. The "pad_out"
> >>> buffer they write to is unique and not locked so maybe the test's
> >>> userspace reads pad_out while another CPU is writing on it and if the
> >>> string output goes through a stage where it is "    4 0000" before
> >>> being "    4 000", we might read at the wrong time. That being said, I
> >>> would find it weird that this happens as much as 50% of the time and
> >>> always specifically on that test case.
> >>>
> >>> Andrii could you maybe try changing the prog type to
> >>> "tp/syscalls/sys_enter_nanosleep" on the machine where you can
> >>> reproduce this bug ?
> >>
> >> Yes, it helps. I can't repro it easily anymore.
> >
> > Good, so it does sound like a concurrency issue indeed
> >
> >> I think the right fix, though, should be to filter by tid, not change the tracepoint.
> >
> > Agreed, I'll send a patch for that today. :)
> >
> >> I think what's happening is we see the string right before bstr_printf
> >> does zero-termination with end[-1] = '\0'; So in some cases we see
> >> truncated string, in others we see untruncated one.
> >
> > Makes sense but I still wonder why it happens so often (50% of the
> > time is really a lot) and why it is consistently that one test case
> > that fails and not the "overflow" case for example. But I'm confident
> > that this is not a bug in the helper now and that the tid filter will
> > fix the test.
> >
>
> If the caller, or one of its sibling threads, inspects the buffer before
> (v)snprintf has returned it's very obviously a bug in the caller. As for

Absolutely

> why that particular case exposes the race: It seems to be the only one
> that "expects" an insanely long result, and it takes a very very long
> time (several cycles per byte I'd assume) for the vsnprintf code to very
> carefully go through the
>
>   if (buf < end)
>      *buf = /* '0' or ' ' or whatever it is it is emitting here */
>   buf++;
>
> 900k times. So there's simply a very large window where the buffer
> contents is "    4 0000" while number() is still 'emitting' 0s until
> control returns to vsnprintf() which does that final end[-1] = '\0'.

Aaah, of course, it makes complete sense! :) Thank you Rasmus
