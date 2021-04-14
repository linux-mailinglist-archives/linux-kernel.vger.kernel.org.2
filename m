Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D03CD35FB6D
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 21:14:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352485AbhDNTPP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 15:15:15 -0400
Received: from mail-lf1-f49.google.com ([209.85.167.49]:33679 "EHLO
        mail-lf1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352296AbhDNTPG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 15:15:06 -0400
Received: by mail-lf1-f49.google.com with SMTP id w8so26535289lfr.0
        for <linux-kernel@vger.kernel.org>; Wed, 14 Apr 2021 12:14:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=b6cIT9VGmJ3FjQ4zHXvosZbU4FV4wbSfsEahwVs+lcI=;
        b=AHUHqPQAg1gGrD3MR8VwwrzZyYMB4Ti+prca3HkvTKsDtj400rkTDDidfpE2clSwQD
         Ipe5Wyo57SIBGiU2eRpgmiaMwqNfefADh78bHsTCTLJrif+8LE7HOv1j+ihwJLq4pxfM
         J/n0zIfaF/1KmWNIKD1k2c/PSh37ROolUwERHXVF1HT1fl29UeOJk0C9Fd5iIWhebGFc
         iPhLtI88ax1GH6M6wHmaBa2LTT5IxoiwFtPd1ljHVH2fpgpb09m+8pLpDheWrm1nckmq
         wAa79zzuDmoGSCa06Ua6XozmdOtsS2bnkRa67mzQm3QHcnW+YnTBLqdIlqX6MfJK5//6
         ddwg==
X-Gm-Message-State: AOAM531cN3zZLPrCT2I/Nz1O06pY6cV8kUHTVxqZ/xgIksUDbPjVaCh+
        xGVQTE/X6bdFcofhJFxJ2DV7ww6V1K39U24Kar0=
X-Google-Smtp-Source: ABdhPJxytQYIHr2Zu0kDffOltREjyEXebg7olJUI2PKT5/qjMmW8hQKXLQLv5Bs8lNbqLyR0qwFiri7CtCFqkAsdREI=
X-Received: by 2002:ac2:58fb:: with SMTP id v27mr6610179lfo.374.1618427682328;
 Wed, 14 Apr 2021 12:14:42 -0700 (PDT)
MIME-Version: 1.0
References: <20210414155412.3697605-1-robh@kernel.org> <20210414155412.3697605-2-robh@kernel.org>
 <CAM9d7cibppJUQuqcxEO9gU-KcHJNsoMJQw=1+_Fw3oXXHEKUCA@mail.gmail.com>
 <YHcuIKjNDkOUCupx@kernel.org> <YHczIzjv6Kt3cxI7@kernel.org>
In-Reply-To: <YHczIzjv6Kt3cxI7@kernel.org>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Thu, 15 Apr 2021 04:14:31 +0900
Message-ID: <CAM9d7chYYa5B-QR6xNJG5NeLb0ENv5inLdLMqT_e+8jkRZZCJA@mail.gmail.com>
Subject: Re: [PATCH v8 2/4] libperf: Add evsel mmap support
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Rob Herring <robh@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Jiri Olsa <jolsa@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Itaru Kitayama <itaru.kitayama@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 15, 2021 at 3:23 AM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> Em Wed, Apr 14, 2021 at 03:02:08PM -0300, Arnaldo Carvalho de Melo escreveu:
> > Em Thu, Apr 15, 2021 at 01:41:35AM +0900, Namhyung Kim escreveu:
> > > Hello,
> > >
> > > On Thu, Apr 15, 2021 at 1:07 AM Rob Herring <robh@kernel.org> wrote:
> > > > +void *perf_evsel__mmap_base(struct perf_evsel *evsel, int cpu, int thread)
> > > > +{
> > > > +       if (FD(evsel, cpu, thread) < 0 || MMAP(evsel, cpu, thread) == NULL)
> > > > +               return NULL;
> > >
> > > I think you should check the cpu and the thread is in
> > > a valid range.  Currently xyarray__entry() simply accesses
> > > the content without checking the boundaries.
> >
> > So, since xyarray has the bounds, it should check it, i.e. we need to
> > have a __xyarray__entry() that is what xyarray__entry() does, i.e.
> > assume the values have been bounds checked, then a new method,
> > xyarray__entry() that does bounds check, if it fails, return NULL,
> > otherwise calls __xyarray__entry().
> >
> > I see this is frustrating and I should've chimed in earlier, but at
> > least now this is getting traction, and the end result will be better
> > not just for the feature you've been dilligently working on,
> >
> > Thank you for your persistence,
>
> Re-reading, yeah, this can be done in a separate patch, Namhyung, can I
> have your Reviewed-by? That or an Acked-by?

Sure, for the series:

Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks,
Namhyung
