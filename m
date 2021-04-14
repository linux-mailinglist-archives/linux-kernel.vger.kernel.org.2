Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FC7C35F0B1
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 11:21:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348444AbhDNJWB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 05:22:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347494AbhDNJVz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 05:21:55 -0400
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6795C061574
        for <linux-kernel@vger.kernel.org>; Wed, 14 Apr 2021 02:21:33 -0700 (PDT)
Received: by mail-il1-x12a.google.com with SMTP id c3so10411426ils.5
        for <linux-kernel@vger.kernel.org>; Wed, 14 Apr 2021 02:21:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bHpie5HpZgHlzw3ULYYgfK8HzQppRmaDIQ+JyFmm3tc=;
        b=QlOQDTDC6+TFMXbxL4bxceCqvjswx//Lmdk4CAO1oE//dHahhT8jOfftD/CV4t5y47
         HmNr0TY1RLAy9fNL1hzmQsvrCqMB8p0xE7GaT8rIJJPQrxyV33A0L+bPI51NcJE/OuvE
         uOZNBxO2u/9URtGWy3edZaWD8cqW7AXUapOLY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bHpie5HpZgHlzw3ULYYgfK8HzQppRmaDIQ+JyFmm3tc=;
        b=QScaiaAWOkYYHrYZm7QAgQBYEjA+/EFeWlLYdd7jZGJDIYH9XZwPuvD6+mHZeqelse
         QNg33cTRpE7HpuX2zUDZq5Wjmyqs6awE282hr/B/KG4jwKk6Ot0b23cufBgQwUTqFUoX
         c/992CGizRdWbi0VsI0h8vX7beBK4vRbZkmwQLNd6ApEGGFcPjcPlnBfs3mggnJ7Cdy5
         Ioyr+hTuOFUrwFkXgn41seXdo1sLxKmSoku8amySK02FZBHpcIPnjp/gxlqXP0dhBdOO
         FRYvyQhYNbksqMt8pQ/1kbbnisPnVB1E/Bk4HqRTESimXKGJ23tATJmyGRjkoAj8CCMe
         WfEg==
X-Gm-Message-State: AOAM532GP2LuqUzETy2QTyyOD5JHCG7mPQhftC80j1DOVL0cFHUpDGRA
        cujD9o5KG4OPrBLZOzTmwTLgU9rhZzrdgokAECwzlw==
X-Google-Smtp-Source: ABdhPJzR/Eyk4vNV+pEmINVYnRnn1ZEdPsz4uQSiSwKX1m0Oq6toGUbWmCeUF3zhJ1HwBombj9oKmGbZNmHGLtoLt1g=
X-Received: by 2002:a05:6e02:2182:: with SMTP id j2mr32034994ila.89.1618392093374;
 Wed, 14 Apr 2021 02:21:33 -0700 (PDT)
MIME-Version: 1.0
References: <20210412153754.235500-1-revest@chromium.org> <20210412153754.235500-7-revest@chromium.org>
 <CAEf4BzZ6cLio0ZZEkc5iYp9yWg3Fc1ZORBTr85TdoqF-sRU3DQ@mail.gmail.com>
In-Reply-To: <CAEf4BzZ6cLio0ZZEkc5iYp9yWg3Fc1ZORBTr85TdoqF-sRU3DQ@mail.gmail.com>
From:   Florent Revest <revest@chromium.org>
Date:   Wed, 14 Apr 2021 11:21:22 +0200
Message-ID: <CABRcYm+v7xC8WsxYu6BoiEX1vhQSVSX5U-LyUnevGt1tFud5tA@mail.gmail.com>
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

On Wed, Apr 14, 2021 at 1:21 AM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Mon, Apr 12, 2021 at 8:38 AM Florent Revest <revest@chromium.org> wrote:
> >
> > This exercises most of the format specifiers.
> >
> > Signed-off-by: Florent Revest <revest@chromium.org>
> > Acked-by: Andrii Nakryiko <andrii@kernel.org>
> > ---
>
> As I mentioned on another patch, we probably need negative tests even
> more than positive ones.

Agreed.

> I think an easy and nice way to do this is to have a separate BPF
> skeleton where fmt string and arguments are provided through read-only
> global variables, so that user-space can re-use the same BPF skeleton
> to simulate multiple cases. BPF program itself would just call
> bpf_snprintf() and store the returned result.

Ah, great idea! I was thinking of having one skeleton for each but it
would be a bit much indeed.

Because the format string needs to be in a read only map though, I
hope it can be modified from userspace before loading. I'll try it out
and see :) if it doesn't work I'll just use more skeletons

> Whether we need to validate the verifier log is up to debate (though
> it's not that hard to do by overriding libbpf_print_fn() callback),
> I'd be ok at least knowing that some bad format strings are rejected
> and don't crash the kernel.

Alright :)

>
> >  .../selftests/bpf/prog_tests/snprintf.c       | 81 +++++++++++++++++++
> >  .../selftests/bpf/progs/test_snprintf.c       | 74 +++++++++++++++++
> >  2 files changed, 155 insertions(+)
> >  create mode 100644 tools/testing/selftests/bpf/prog_tests/snprintf.c
> >  create mode 100644 tools/testing/selftests/bpf/progs/test_snprintf.c
> >
>
> [...]
