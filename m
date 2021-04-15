Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E135360609
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Apr 2021 11:40:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232174AbhDOJi5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Apr 2021 05:38:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231309AbhDOJii (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Apr 2021 05:38:38 -0400
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 254D4C061574
        for <linux-kernel@vger.kernel.org>; Thu, 15 Apr 2021 02:38:16 -0700 (PDT)
Received: by mail-io1-xd2b.google.com with SMTP id b10so23585824iot.4
        for <linux-kernel@vger.kernel.org>; Thu, 15 Apr 2021 02:38:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OPgFWlOukLXcxKTGO6irUprnq/4nHV4Q9KnPOIDBncA=;
        b=A4Ulwq6Rh/qbp/3COX+y1Bp6wCwZvsZbFa2/shD3RdMtC+Bp4OIHe98dW7NmtRzP6n
         kFz7rAbDa19iXTIbRMlkry6i6mDznRlQNT/ghDF9gkA1GakPRdraf+wcOvIpVSb+tP1N
         9o/GW01w0QH9XZRLwEn/34ZZu5VXGH0udyGiw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OPgFWlOukLXcxKTGO6irUprnq/4nHV4Q9KnPOIDBncA=;
        b=X1ELOxmJfvG4N+RZuzvoGt/aRMgAk1UZnExNgbSDRe//vLIdp82eDYi/rTv4kpp4LN
         vb9/LXqq7zufTC23XmymaytlY2vRm9iZctx2t7vKY1923oqrkoJdkqVoHh3yuasJslwz
         /4Tv7PpyZ6VZlG8HWCXxGcLiyMmYTrkzKiTqI1pV/zABTurzrpvFZB/9PVx+1oExz46Y
         pcFQ7REbesNVAHLkzbzEhAW5hlJ7GROj/XlqU75gG9eLv2oApmBfdidm+mKgTxsN+Rlu
         ZyImfCJsfmql8zcfoOa+nH6cNNGW0RCPlRR7nz8LINInZ+0DcjqftbUG8mX2Zs1jFx9B
         HwkA==
X-Gm-Message-State: AOAM532XEuxqRfD94HOPkPWb8rzRWdJ3Y1RglGpiuq8aw9JxoPopClZC
        C66pTW9FcmXJxir1rujL3mxCV9jPWJvx8+E3oAFsrQ==
X-Google-Smtp-Source: ABdhPJwdINxuPC3DeNObKA/X0KGB4m65O7VqKvz+UAWxyq/kDi5EsER6LyA6HvHO2/qAKdV3IZon/ZHK/o2DFor132A=
X-Received: by 2002:a02:662b:: with SMTP id k43mr1983699jac.139.1618479495616;
 Thu, 15 Apr 2021 02:38:15 -0700 (PDT)
MIME-Version: 1.0
References: <20210412153754.235500-1-revest@chromium.org> <20210412153754.235500-7-revest@chromium.org>
 <CAEf4BzZ6cLio0ZZEkc5iYp9yWg3Fc1ZORBTr85TdoqF-sRU3DQ@mail.gmail.com>
 <CABRcYm+v7xC8WsxYu6BoiEX1vhQSVSX5U-LyUnevGt1tFud5tA@mail.gmail.com> <CAEf4Bzb-Xh_JOWsZwC+fNiC20K_9fzrpfiAMHTYM=6k--+SZaw@mail.gmail.com>
In-Reply-To: <CAEf4Bzb-Xh_JOWsZwC+fNiC20K_9fzrpfiAMHTYM=6k--+SZaw@mail.gmail.com>
From:   Florent Revest <revest@chromium.org>
Date:   Thu, 15 Apr 2021 11:38:04 +0200
Message-ID: <CABRcYm+SFfqzf8Qkt+f3YvXH4pRuA1ckU+YajF3+=B+jRtxs8Q@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 6/6] selftests/bpf: Add a series of tests for bpf_snprintf
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

On Thu, Apr 15, 2021 at 12:16 AM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Wed, Apr 14, 2021 at 2:21 AM Florent Revest <revest@chromium.org> wrote:
> >
> > On Wed, Apr 14, 2021 at 1:21 AM Andrii Nakryiko
> > <andrii.nakryiko@gmail.com> wrote:
> > >
> > > On Mon, Apr 12, 2021 at 8:38 AM Florent Revest <revest@chromium.org> wrote:
> > > >
> > > > This exercises most of the format specifiers.
> > > >
> > > > Signed-off-by: Florent Revest <revest@chromium.org>
> > > > Acked-by: Andrii Nakryiko <andrii@kernel.org>
> > > > ---
> > >
> > > As I mentioned on another patch, we probably need negative tests even
> > > more than positive ones.
> >
> > Agreed.
> >
> > > I think an easy and nice way to do this is to have a separate BPF
> > > skeleton where fmt string and arguments are provided through read-only
> > > global variables, so that user-space can re-use the same BPF skeleton
> > > to simulate multiple cases. BPF program itself would just call
> > > bpf_snprintf() and store the returned result.
> >
> > Ah, great idea! I was thinking of having one skeleton for each but it
> > would be a bit much indeed.
> >
> > Because the format string needs to be in a read only map though, I
> > hope it can be modified from userspace before loading. I'll try it out
> > and see :) if it doesn't work I'll just use more skeletons
>
> You need read-only variables (const volatile my_type). Their contents
> are statically verified by BPF verifier, yet user-space can pre-setup
> it at runtime.

Thanks :) v4 has negative fmt tests
