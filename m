Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92BF1390A48
	for <lists+linux-kernel@lfdr.de>; Tue, 25 May 2021 22:05:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233220AbhEYUF6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 May 2021 16:05:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231846AbhEYUFz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 May 2021 16:05:55 -0400
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2711C061756
        for <linux-kernel@vger.kernel.org>; Tue, 25 May 2021 13:04:23 -0700 (PDT)
Received: by mail-io1-xd2f.google.com with SMTP id a8so24820132ioa.12
        for <linux-kernel@vger.kernel.org>; Tue, 25 May 2021 13:04:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gHa/jxf5ff+nHL/HwGVIpDxyxV41oUcj3iWDlxx7pRk=;
        b=I3d89PmSYtAAmPdU4bYuuICwd51StJRpwGaGZM5j0MPCjYFxuA6KINZq2/qzt7J4rF
         oEafMbx80NTxz6DzoGZ5vzJhjLTnJrv0LxpzcGDsGKQzAPvIu4be39dXnzUxM18gDITV
         EWdnOICM7SBsjxTA0aNsqqY4lP0Q2GGT46PQg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gHa/jxf5ff+nHL/HwGVIpDxyxV41oUcj3iWDlxx7pRk=;
        b=t63Etr18q0Foti4tPD0eqd4HEGiDq80ExxEVBsHB2zg/FosLRz1VWArus1hQogwkC9
         1iLLNIEVu1LBdSEYCa3hYx02xese4Ajx08bm9I6cwpNeX6vEklVOEm4vPuSYpjf0CfyE
         qusAb3cA5WwfLYPI6TPiQ8hEOhZHBhR+kvQuOVWwiPWxVDt3W26emAha8uCNhmW8456E
         lw/SJEB5/olFk05d1By+9LH+t1wpWGDcDJpAOJpvsz6D7C+GLeAxryozqUN5umdL9RPC
         eSNUJdE0ovEcSeIllvLOmi6Q0zn66KmDD2NO+5okIRYls6NMW2rUw/O8HmNz2vi2s8G/
         /8dQ==
X-Gm-Message-State: AOAM531lfqsbYfgogmp+yh2qDL/y83emOf3N+N6xJ2EMffueWUay8SOD
        3NdRu3Ob/pzPwFSqJ2V/ONXS3WmIubjxEKLqs+6k+g==
X-Google-Smtp-Source: ABdhPJy3QhgMgsWlXogc866Fmq75XIDGlvh7LZ7Gyq9bY4J2KUcupEDm/5ORfhwskrxUR0LgDB+PVTF6FXqUzMIEOLY=
X-Received: by 2002:a6b:e91a:: with SMTP id u26mr23484337iof.83.1621973062946;
 Tue, 25 May 2021 13:04:22 -0700 (PDT)
MIME-Version: 1.0
References: <20210525113732.2648158-1-revest@chromium.org> <CAEf4BzYPbKYB4ky-A9x85OiMTrexV7oRkZ1rzNUErqz9nWNfLQ@mail.gmail.com>
In-Reply-To: <CAEf4BzYPbKYB4ky-A9x85OiMTrexV7oRkZ1rzNUErqz9nWNfLQ@mail.gmail.com>
From:   Florent Revest <revest@chromium.org>
Date:   Tue, 25 May 2021 22:04:12 +0200
Message-ID: <CABRcYmKv92Ko6rhjNcUG4sjkMQR+tEtxbTfTVGYL4JdKHCeYYA@mail.gmail.com>
Subject: Re: [PATCH bpf] libbpf: Move BPF_SEQ_PRINTF and BPF_SNPRINTF to bpf_helpers.h
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        KP Singh <kpsingh@kernel.org>,
        Brendan Jackman <jackmanb@google.com>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 25, 2021 at 9:51 PM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Tue, May 25, 2021 at 4:38 AM Florent Revest <revest@chromium.org> wrote:
> > +#define ___bpf_concat(a, b) a ## b
> > +#define ___bpf_apply(fn, n) ___bpf_concat(fn, n)
> > +#define ___bpf_nth(_, _1, _2, _3, _4, _5, _6, _7, _8, _9, _a, _b, _c, N, ...) N
> > +#define ___bpf_narg(...) \
> > +       ___bpf_nth(_, ##__VA_ARGS__, 12, 11, 10, 9, 8, 7, 6, 5, 4, 3, 2, 1, 0)
>
> wouldn't this conflict if both bpf_tracing.h and bpf_helpers.h are
> included in the same file?

Oh, yeah, somehow I thought that double macro definitions wouldn't
generate warnings but it would, indeed. Silly me :)

> We can probably guard this block with
> custom #ifdef both in bpf_helpers.h and bpf_tracing.h to avoid
> dependency on order of includes?

Indeed, I think the cleanest would be:
#ifndef ___bpf_concat
#define ___bpf_concat(a, b) a ## b
#endif
#ifndef ___bpf_apply
 etc...

I'm sending a v2.
