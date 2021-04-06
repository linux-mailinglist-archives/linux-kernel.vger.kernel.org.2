Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FEBF35584B
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Apr 2021 17:40:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244164AbhDFPkv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Apr 2021 11:40:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233999AbhDFPku (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Apr 2021 11:40:50 -0400
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com [IPv6:2607:f8b0:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 697EDC061756
        for <linux-kernel@vger.kernel.org>; Tue,  6 Apr 2021 08:40:41 -0700 (PDT)
Received: by mail-il1-x135.google.com with SMTP id d10so13475439ils.5
        for <linux-kernel@vger.kernel.org>; Tue, 06 Apr 2021 08:40:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/i6oRBuCC1nnDdk8f5MbgBKgjuwAQ5G7EynnRn+CM2U=;
        b=jNGs8/kzK6fF4rFABzfWwSKeIItGRig5tl4meXpRcksf4WjzMzD5Kw6Fwdzxl6OEyT
         xfQnEyG92W3AEuG4rzQahom4jtzNpMAw+dpQrzqHP9ZtX6OVv43FlC59IrxkWUEj2ecS
         GPzo8PQJebMdfdDMgHHWXnKpMn8FcDTndvWWc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/i6oRBuCC1nnDdk8f5MbgBKgjuwAQ5G7EynnRn+CM2U=;
        b=kLWh6GDiw/EL2sFUJNppRlY02qdJ2TcxDcLG754SVD/7zov/oda6VZphyDGvvZvvIn
         Bnd99hyhZE1UyfgrT1ukhOXfkppubdDzkcNMZbykIw6hmlxsPRVyCEAnDwGZIZqpDdYR
         e4wPfEQw5xtAtnZ1fF9x5/g9PvNC5MIjoQEXu+qqj4D+lG6/O0gzX+FlJP55OSVVHH75
         UvRxHjN+dUi1iXJeye6k6jGF91KdtnrVuvfX8H/Twn8uxGRi1QMXwOQM6YsWvMtsQN+y
         12LyovyAoK0vT4OOhYGKeB1WAJ01UQrCSzYGy7PjYob4a37+AE6PbIrNzeVReuCliaPU
         BHkg==
X-Gm-Message-State: AOAM530W+gmWB6I+fkerW7U/Fhr/c81lmnrWMcK0Y7XrKPfjk0F8DW8q
        M/sTs/Mt1QbkNm12G8llnh7/A1YIcxMM/IWaZdu3fg==
X-Google-Smtp-Source: ABdhPJyy0Kus26xdVGm4mg3woI6tVGuaURUUcH6bXPAT0XCsNbcTjHptv5f2ARgt/+EB/ozLBWgBLRIKYX9IbT1/Ems=
X-Received: by 2002:a92:c9ca:: with SMTP id k10mr9636555ilq.42.1617723640967;
 Tue, 06 Apr 2021 08:40:40 -0700 (PDT)
MIME-Version: 1.0
References: <20210324022211.1718762-1-revest@chromium.org> <20210324022211.1718762-7-revest@chromium.org>
 <CAEf4Bzb1z2KOHsMTrSP2t3S0iT3UrYMAWsO1_OqD_EYMECsZ-w@mail.gmail.com>
In-Reply-To: <CAEf4Bzb1z2KOHsMTrSP2t3S0iT3UrYMAWsO1_OqD_EYMECsZ-w@mail.gmail.com>
From:   Florent Revest <revest@chromium.org>
Date:   Tue, 6 Apr 2021 17:40:30 +0200
Message-ID: <CABRcYmJZ856joqkSxThS6Kv0m9ZGufUCffQ4OwCTWALg907O5g@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 6/6] selftests/bpf: Add a series of tests for bpf_snprintf
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

On Sat, Mar 27, 2021 at 12:05 AM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Tue, Mar 23, 2021 at 7:23 PM Florent Revest <revest@chromium.org> wrote:
> >
> > This exercises most of the format specifiers when things go well.
> >
> > Signed-off-by: Florent Revest <revest@chromium.org>
> > ---
>
> Looks good. Please add a no-argument test case as well.

Agreed

> Acked-by: Andrii Nakryiko <andrii@kernel.org>
>
> >  .../selftests/bpf/prog_tests/snprintf.c       | 65 +++++++++++++++++++
> >  .../selftests/bpf/progs/test_snprintf.c       | 59 +++++++++++++++++
> >  2 files changed, 124 insertions(+)
> >  create mode 100644 tools/testing/selftests/bpf/prog_tests/snprintf.c
> >  create mode 100644 tools/testing/selftests/bpf/progs/test_snprintf.c
> >
>
> [...]
>
> > +
> > +SEC("raw_tp/sys_enter")
> > +int handler(const void *ctx)
> > +{
> > +       /* Convenient values to pretty-print */
> > +       const __u8 ex_ipv4[] = {127, 0, 0, 1};
> > +       const __u8 ex_ipv6[] = {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1};
> > +       const char str1[] = "str1";
> > +       const char longstr[] = "longstr";
> > +       extern const void schedule __ksym;
>
> oh, fancy. I'd move it out of this function into global space, though,
> to make it more apparent. I almost missed that it's a special one.

Just schedule? Alright.
