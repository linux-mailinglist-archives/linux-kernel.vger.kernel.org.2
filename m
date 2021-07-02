Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 184D43BA3A1
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jul 2021 19:27:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229984AbhGBR31 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jul 2021 13:29:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbhGBR30 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jul 2021 13:29:26 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA16DC061762
        for <linux-kernel@vger.kernel.org>; Fri,  2 Jul 2021 10:26:53 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id t17so19481261lfq.0
        for <linux-kernel@vger.kernel.org>; Fri, 02 Jul 2021 10:26:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=edd9L3CEPcJHV5zapgkcsAIDFKhBznCgAd4DR45iEkA=;
        b=Gn+Ulz0H+dsihLGXHosjw4LgAGNp/flTQvg1QBhXBxVUKf9fkGpRmpOdOHN6e0M/nh
         6UyQod6JG4Cf0/TOTpVzoZWCzK7ZsiZErIVEZKq4guI0UuJ4hstjhraYbyMlvbMlsjkY
         DCwsldR0SQfgZGIr3zMpfzjLcr1HNaaX2TPG/8s1lIUC0lTe7BrrsbLo9ikpRLNlOEtt
         B2eST6v9ZAcInXdCub2D0NcZvt4MsEvfnNzt3lYgL1zRn6dM3JqpLL1gH/5obsaeYIfJ
         RqU/X9/7zIp3cwxXOv0ldG0AcDMRSjotbwCkYExRMhOuv+BfT8zvuagxMjNgI26aRyGq
         AKng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=edd9L3CEPcJHV5zapgkcsAIDFKhBznCgAd4DR45iEkA=;
        b=qOxTynHvWtlttGjm0Ty+mB9VU6dYDCSi/H31eBISSbM3NVU5ZCh4iMxy5GYCbYoufP
         Dy8Dj1Ytbp+IQey+U3+qsVB9NtHyc/frjTHg8dAGRSZGxvICZ0oYqwrtyyVMHZ5UWn6f
         m3GfhY0hDm8Xtr6nr4NJ7on38XEaNF4XVi28azgiKHthiOquK812SRgyRj+RbgHfl3Kb
         OJHzJ+V1KCD8qVXW8THmaXvV+NHpd7MlYZYLJVG6fkC6N8l6TzYReE31RgkMGUwlz919
         q/JrvVDPyPkPCNgFyyOstD/uVPFrM0WzO6swoXRCmJD2OGu7pcELve69kkj02ihq3ae7
         o3Vg==
X-Gm-Message-State: AOAM532wpWe5LfjCABE7Fw3kI74D2OKUG/syGxY6+Ts0q8HeEwxfTUB9
        X3tgNFgyvDucqAFe7dDgT+vWq6aZaILqW/ShdfWpDg==
X-Google-Smtp-Source: ABdhPJx6AK6A7QidgByqyYB0D/cBFzXeo2JsDENjhahT8G8xPdAZmE/05ZV8pzwoo1w2gnNYpDEISgHSxE4rr3wFgWw=
X-Received: by 2002:a05:6512:3e24:: with SMTP id i36mr520821lfv.368.1625246811859;
 Fri, 02 Jul 2021 10:26:51 -0700 (PDT)
MIME-Version: 1.0
References: <202106281231.E99B92BB13@keescook> <CAHk-=whqCT0BeqBQhW8D-YoLLgp_eFY=8Y=9ieREM5xx0ef08w@mail.gmail.com>
 <202106291311.20AB10D04@keescook> <CAHk-=wg8M2DyA=bWtnGsAOVqYU-AusxYcpXubUO2htb6qPU9dg@mail.gmail.com>
 <CAGG=3QXrOnN3-3r-VGDpmikKRpaK_p5hM_qHGprDDMuFNKuifA@mail.gmail.com> <YN8NGLPQ4Cqanc48@hirez.programming.kicks-ass.net>
In-Reply-To: <YN8NGLPQ4Cqanc48@hirez.programming.kicks-ass.net>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Fri, 2 Jul 2021 10:26:40 -0700
Message-ID: <CAKwvOd=-qdp6xcuVb-fSni6X-0UuJ6GM5+TJdWSkAfvNmqfZ+w@mail.gmail.com>
Subject: Re: [GIT PULL] Clang feature updates for v5.14-rc1
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Bill Wendling <morbo@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Bill Wendling <wcw@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Fangrui Song <maskray@google.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Jarmo Tiitto <jarmo.tiitto@gmail.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Miguel Ojeda <ojeda@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        Will Deacon <will@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 2, 2021 at 5:57 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Fri, Jul 02, 2021 at 05:46:46AM -0700, Bill Wendling wrote:
> > On Tue, Jun 29, 2021 at 2:04 PM Linus Torvalds
> > <torvalds@linux-foundation.org> wrote:
> > >
> > > On Tue, Jun 29, 2021 at 1:44 PM Kees Cook <keescook@chromium.org> wrote:
> > > > >
> > > > > And it causes the kernel to be bigger and run slower.
> > > >
> > > > Right -- that's expected. It's not designed to be the final kernel
> > > > someone uses. :)
> > >
> > > Well, from what I've seen, you actually want to run real loads in
> > > production environments for PGO to actually be anything but a bogus
> > > "performance benchmarks only" kind of thing.
> > >
> > The reason we use PGO in this way is because we _cannot_ release a
> > kernel into production that hasn't had PGO applied to it. The
> > performance of a non-PGO'ed kernel is a non-starter for rollout. We
> > try our best to replicate this environment for the benchmarks, which
> > is the only sane way to do this. I can't imagine that we're the only
> > ones who run up against this chicken-and-egg problem.
> >
> > For why we don't use sampling, PGO gives a better performance boost
> > from an instrumented kernel rather than a sampled profile. I'll work
> > on getting statistics to show this.
>
> I've asked this before; *what* is missing from LBR samples that's
> reponsible for the performance gap?

Are we able to collect LBR samples from __init code?  I can imagine
trying to launch perf from init/pid 1, but I suspect at that point
it's way too late.

Increasingly, boot times of hosts (and virtualized guests) are
becoming important to us, both in the datacenters and on mobile.
-- 
Thanks,
~Nick Desaulniers
