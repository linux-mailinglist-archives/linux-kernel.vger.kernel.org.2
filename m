Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 666DA36CFF6
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Apr 2021 02:21:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238399AbhD1AVh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Apr 2021 20:21:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230368AbhD1AVg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Apr 2021 20:21:36 -0400
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com [IPv6:2607:f8b0:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60223C06175F
        for <linux-kernel@vger.kernel.org>; Tue, 27 Apr 2021 17:20:50 -0700 (PDT)
Received: by mail-il1-x12c.google.com with SMTP id c18so50921926iln.7
        for <linux-kernel@vger.kernel.org>; Tue, 27 Apr 2021 17:20:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LOTlmCK5gq+HHlhNi1fYC1cWCks9ISwEvyUnhRhzW1M=;
        b=MwrGNYRa/2Aplsse0gRT5HfxFK9oxD+6LmaoDXtj7QymXeN0tDgm3bmLUM7UVujror
         nXgZ2spJYrVcQeVgR97GbiOnihpaJ4Vc4qcPAqFLPiNYhTOSWHFAzQunQ74m2MtJaYDf
         8WTvz6zwy5QVkzzAupCjESLAEeQV0C9F/B//0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LOTlmCK5gq+HHlhNi1fYC1cWCks9ISwEvyUnhRhzW1M=;
        b=A3E+eut54DYa3iuChQszDj3hCqpzeajvX+gipVnlJb+w0IHi+8a8ltDSBfpPy5eo6u
         iU2I2r9LsTlqFaBSoaBCZL3wo7XaeBXzsR9itphVXcN4GwwTjr06K2LS5GZgtZSFBbPd
         DwcEpscRfrpp1FymcNTmzvWA0fU7/CgygxxA/mCvQ4yqjSL3W1EBp4WxKhDpxUGe8ZD5
         lnXsNk4Q7WqZL8+AH/bQs9AQFgb+YC0khJt4oAqH3Aly58eMXhRtt3Xg8+sw/664dXnR
         9nxy8tu2LUUwZ1uTfnNTNomMm1iXseYMTjQVw6LRuEInWzQ1xksW1BDRCdoQg0vsoe1W
         B77Q==
X-Gm-Message-State: AOAM532olre/owwg+9wW6GSitsDMhgL/lx/Xz2LJBJmsSzAh0FEwyWy+
        50lBOdcmnliF53d4PjlE4GkQA3hiss8uMrK1cfxnzg==
X-Google-Smtp-Source: ABdhPJzFFwlQ1tOFzeZg8AXbIu6mkRYWUxE8LdfB/Evf09W94HPKywtf7ijgiTpfcK4loo+UjRZ8xz/+ksgnm176+1Y=
X-Received: by 2002:a05:6e02:219d:: with SMTP id j29mr21619919ila.204.1619569249796;
 Tue, 27 Apr 2021 17:20:49 -0700 (PDT)
MIME-Version: 1.0
References: <20210427174313.860948-1-revest@chromium.org> <20210427174313.860948-3-revest@chromium.org>
 <CAADnVQLQmt0-D_e=boXoK=FLRoXv9xzkCwM24zpbZERrEexLCw@mail.gmail.com>
In-Reply-To: <CAADnVQLQmt0-D_e=boXoK=FLRoXv9xzkCwM24zpbZERrEexLCw@mail.gmail.com>
From:   Florent Revest <revest@chromium.org>
Date:   Wed, 28 Apr 2021 02:20:39 +0200
Message-ID: <CABRcYm+eWh5=eM9mgOsCU6-TACi-y5kviCf9Kbqxfzvgq9u5BA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 2/2] bpf: Implement formatted output helpers
 with bstr_printf
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        KP Singh <kpsingh@kernel.org>,
        Brendan Jackman <jackmanb@google.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Steven Rostedt <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 28, 2021 at 1:46 AM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Tue, Apr 27, 2021 at 10:43 AM Florent Revest <revest@chromium.org> wrote:
> > +                       if (fmt[i + 1] == 'B') {
> > +                               if (tmp_buf)  {
> > +                                       err = snprintf(tmp_buf,
> > +                                                      (tmp_buf_end - tmp_buf),
> > +                                                      "%pB",
> ...
> > +                       if ((tmp_buf_end - tmp_buf) < sizeof_cur_ip) {
>
> I removed a few redundant () like above

Oh, sorry about that.

> and applied.

Nice! :)

> >                 if (fmt[i] == 'l') {
> > -                       cur_mod = BPF_PRINTF_LONG;
> > +                       sizeof_cur_arg = sizeof(long);
> >                         i++;
> >                 }
> >                 if (fmt[i] == 'l') {
> > -                       cur_mod = BPF_PRINTF_LONG_LONG;
> > +                       sizeof_cur_arg = sizeof(long long);
> >                         i++;
> >                 }
>
> This bit got me thinking.
> I understand that this is how bpf_trace_printk behaved
> and the sprintf continued the tradition, but I think it will
> surprise bpf users.
> The bpf progs are always 64-bit. The sizeof(long) == 8
> inside any bpf program. So printf("%ld") matches that long.

Yes, this also surprised me.

> The clang could even do type checking to make sure the prog
> is passing the right type into printf() if we add
> __attribute__ ((format (printf))) to bpf_helper_defs.h
> But this sprintf() implementation will trim the value to 32-bit
> to satisfy 'fmt' string on 32-bit archs.
> So bpf program behavior would be different on 32 and 64-bit archs.
> I think that would be confusing, since the rest of bpf prog is
> portable. The progs work the same way on all archs
> (except endianess, of course).
> I'm not sure how to fix it though.
> The sprintf cannot just pass 64-bit unconditionally, since
> bstr_printf on 32-bit archs will process %ld incorrectly.
> The verifier could replace %ld with %Ld.
> The fmt string is a read only string for bpf_snprintf,
> but for bpf_trace_printk it's not and messing with it at run-time
> is not good. Copying the fmt string is not great either.
> Messing with internals of bstr_printf is ugly too.

Indeed, none of these solutions are satisfying.

> Maybe we just have to live with this quirk ?

If we were starting from scratch, maybe just banning %ld could have
been an option, but now that bpf_trace_printk has been behaving like
this for a while, I think it might be best to just keep the behavior
as it is.

> Just add a doc to uapi/bpf.h to discourage %ld and be done?

More doc is always good. Something like "Note: %ld behaves differently
depending on the host architecture, it is recommended to avoid it and
use %d or %lld instead" in the helper description of the three
helpers? If you don't have the time to do it today, I can send a patch
tomorrow.
