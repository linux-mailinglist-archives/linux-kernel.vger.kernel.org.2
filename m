Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 219F5361352
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Apr 2021 22:09:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235298AbhDOUKG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Apr 2021 16:10:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:36458 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235282AbhDOUKE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Apr 2021 16:10:04 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C8C646117A
        for <linux-kernel@vger.kernel.org>; Thu, 15 Apr 2021 20:09:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618517380;
        bh=1mFerlxmQDlgP3rSY+LkdD6i+HmMcCUK2bOxuwAOSWQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=kch6TuoYPCfySv1kxwUNrGG2HmtUEFQgruThKzfPKxv7uV0qOpmEuVxVtKdfeVr7J
         qEgbFVPNEvU1V/7u9dkqvP0uQNIZg+fVshu4VSF/W1rOpXqXSj7pPU5cgRGzcgaUX5
         iTklAXBwXyEh664Ovwb5jDQ57xg5VzuXjhkK7jiWd3sQReCz38ydDF6mKfRaD42r0j
         KX6T/8ge8BNsIPKPU5oBiQGbr8ldtGk3jJNZSY65TCj0aKhvHpKuC2QDP4etQk/YLc
         qpvscngE8i4IrzpBxtLxX17GxAm8eSopTmlpy92Ewbav6cvst0KBIH6JaSXxheasAk
         nauiiIdMaXAlg==
Received: by mail-qk1-f174.google.com with SMTP id q136so5655276qka.7
        for <linux-kernel@vger.kernel.org>; Thu, 15 Apr 2021 13:09:40 -0700 (PDT)
X-Gm-Message-State: AOAM531zvv2wTz66FE3zEKwvudujYNYO64TErsJLsKEV+xYGzedq7wLr
        6I4objIo/EI7FdcWHWDwasCJQdF3pGB6RryJLw==
X-Google-Smtp-Source: ABdhPJz/9ZRwMOtBJCgIX1lvMfUNATJrZ1P2pA0oGlYnms0mByoTl1RU5yVk8p8aT3T5ubaLX396zV46vZuGfnK/ynA=
X-Received: by 2002:a37:a2cb:: with SMTP id l194mr5105864qke.364.1618517379973;
 Thu, 15 Apr 2021 13:09:39 -0700 (PDT)
MIME-Version: 1.0
References: <20210414155412.3697605-1-robh@kernel.org> <20210414155412.3697605-2-robh@kernel.org>
 <CAM9d7cibppJUQuqcxEO9gU-KcHJNsoMJQw=1+_Fw3oXXHEKUCA@mail.gmail.com>
 <YHcuIKjNDkOUCupx@kernel.org> <YHczIzjv6Kt3cxI7@kernel.org>
 <CAM9d7chYYa5B-QR6xNJG5NeLb0ENv5inLdLMqT_e+8jkRZZCJA@mail.gmail.com> <YHiV5vqSD3TmUspL@kernel.org>
In-Reply-To: <YHiV5vqSD3TmUspL@kernel.org>
From:   Rob Herring <robh@kernel.org>
Date:   Thu, 15 Apr 2021 15:09:28 -0500
X-Gmail-Original-Message-ID: <CAL_JsqKv2rpMrbYu4Dzq9jsmUGiZyJHzi8MOJMqbRnRbzcrc9w@mail.gmail.com>
Message-ID: <CAL_JsqKv2rpMrbYu4Dzq9jsmUGiZyJHzi8MOJMqbRnRbzcrc9w@mail.gmail.com>
Subject: Re: [PATCH v8 2/4] libperf: Add evsel mmap support
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Namhyung Kim <namhyung@kernel.org>,
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

On Thu, Apr 15, 2021 at 2:37 PM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> Em Thu, Apr 15, 2021 at 04:14:31AM +0900, Namhyung Kim escreveu:
> > On Thu, Apr 15, 2021 at 3:23 AM Arnaldo Carvalho de Melo
> > <acme@kernel.org> wrote:
> > >
> > > Em Wed, Apr 14, 2021 at 03:02:08PM -0300, Arnaldo Carvalho de Melo escreveu:
> > > > Em Thu, Apr 15, 2021 at 01:41:35AM +0900, Namhyung Kim escreveu:
> > > > > Hello,
> > > > >
> > > > > On Thu, Apr 15, 2021 at 1:07 AM Rob Herring <robh@kernel.org> wrote:
> > > > > > +void *perf_evsel__mmap_base(struct perf_evsel *evsel, int cpu, int thread)
> > > > > > +{
> > > > > > +       if (FD(evsel, cpu, thread) < 0 || MMAP(evsel, cpu, thread) == NULL)
> > > > > > +               return NULL;
> > > > >
> > > > > I think you should check the cpu and the thread is in
> > > > > a valid range.  Currently xyarray__entry() simply accesses
> > > > > the content without checking the boundaries.
> > > >
> > > > So, since xyarray has the bounds, it should check it, i.e. we need to
> > > > have a __xyarray__entry() that is what xyarray__entry() does, i.e.
> > > > assume the values have been bounds checked, then a new method,
> > > > xyarray__entry() that does bounds check, if it fails, return NULL,
> > > > otherwise calls __xyarray__entry().
> > > >
> > > > I see this is frustrating and I should've chimed in earlier, but at
> > > > least now this is getting traction, and the end result will be better
> > > > not just for the feature you've been dilligently working on,
> > > >
> > > > Thank you for your persistence,
> > >
> > > Re-reading, yeah, this can be done in a separate patch, Namhyung, can I
> > > have your Reviewed-by? That or an Acked-by?
> >
> > Sure, for the series:
> >
> > Acked-by: Namhyung Kim <namhyung@kernel.org>
>
> Ok, b4 failed on it, probably some missing Reply to, so I'll apply it by
> hand:

That's my fault. A duplicate message-id is the issue. git-send-email
died after patch 1/4 (can't say I've ever had that happen). So in my
attempt to manually resend 2-4, I was off by 1 in the message-id and
duplicated patch 1's message-id. I should have just resent the whole
thing.

Rob
