Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5517935F94C
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 18:57:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352025AbhDNQyv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 12:54:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:46544 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1352065AbhDNQyP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 12:54:15 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id F1919601FC
        for <linux-kernel@vger.kernel.org>; Wed, 14 Apr 2021 16:53:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618419234;
        bh=0jxxX5bMiN78N8jK61NGtfPnyGe/47tNlvQvSWHwgMM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=u6KJ+ZoQpqLiCQpJDNNT/xR8tvLmh399HN4Bcj6hPFNS5OoiW40hsN/35M2F4THwl
         kTjDkxh00iIjyVm3pPbkrVMEp0dpUX8A8MxrFz1QG2kUtXINR4qso+mq0LNgNKfMSp
         gNdcx1bzD8gfRiogkLY+VYLifpMO2ETIlI3oFw3VId6rLwka4Ou49y+jOwb1Znk3lK
         F+tXAZOw8w7n3FLUvMsVWnfLUpmDnr47vsYj0cOMlxMCFSRhYGNA70L/f0PyI9CihE
         n6ggIKpFAJDKR0OU7sdtjS1RbWOmARhTAxYt3O2OLh5X/iJGg51deDFeQRhUZ6wJqL
         sfB085QgwsEwA==
Received: by mail-qv1-f54.google.com with SMTP id i9so10040128qvo.3
        for <linux-kernel@vger.kernel.org>; Wed, 14 Apr 2021 09:53:53 -0700 (PDT)
X-Gm-Message-State: AOAM533+PzhEwyjRn3OzqRSvht3LtB/UE0+45DN0d+jfhFzLBBZPezCJ
        w9rvzgKXmC0wA50fw0Sj7nRsn5WHOp4Ju+cczA==
X-Google-Smtp-Source: ABdhPJx6Qao/9YSuvw7snDFnt5i+qEajx0NvfxNxrvFICYFmp+vk+o9UgY8ZvI2WGExubATPFj79CRrV2xpZwUMTxfc=
X-Received: by 2002:ad4:5a07:: with SMTP id ei7mr20530370qvb.50.1618419233276;
 Wed, 14 Apr 2021 09:53:53 -0700 (PDT)
MIME-Version: 1.0
References: <20210414155412.3697605-1-robh@kernel.org> <20210414155412.3697605-2-robh@kernel.org>
 <CAM9d7cibppJUQuqcxEO9gU-KcHJNsoMJQw=1+_Fw3oXXHEKUCA@mail.gmail.com>
In-Reply-To: <CAM9d7cibppJUQuqcxEO9gU-KcHJNsoMJQw=1+_Fw3oXXHEKUCA@mail.gmail.com>
From:   Rob Herring <robh@kernel.org>
Date:   Wed, 14 Apr 2021 11:53:41 -0500
X-Gmail-Original-Message-ID: <CAL_JsqLEEeJjP1TmSLt=ruQUureSw1gk5sxP7RvMSm=jXAeOtw@mail.gmail.com>
Message-ID: <CAL_JsqLEEeJjP1TmSLt=ruQUureSw1gk5sxP7RvMSm=jXAeOtw@mail.gmail.com>
Subject: Re: [PATCH v8 2/4] libperf: Add evsel mmap support
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Itaru Kitayama <itaru.kitayama@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 14, 2021 at 11:41 AM Namhyung Kim <namhyung@kernel.org> wrote:
>
> Hello,
>
> On Thu, Apr 15, 2021 at 1:07 AM Rob Herring <robh@kernel.org> wrote:
> > +void *perf_evsel__mmap_base(struct perf_evsel *evsel, int cpu, int thread)
> > +{
> > +       if (FD(evsel, cpu, thread) < 0 || MMAP(evsel, cpu, thread) == NULL)
> > +               return NULL;
>
> I think you should check the cpu and the thread is in
> a valid range.  Currently xyarray__entry() simply accesses
> the content without checking the boundaries.

Happy to add a patch to do that if desired, but I think that's
separate from this series. That would be something to add to
xyarray__entry().

Rob
