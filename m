Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49C32444ADC
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Nov 2021 23:30:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230139AbhKCWck (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Nov 2021 18:32:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229728AbhKCWcj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Nov 2021 18:32:39 -0400
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF2E2C061714
        for <linux-kernel@vger.kernel.org>; Wed,  3 Nov 2021 15:30:02 -0700 (PDT)
Received: by mail-il1-x12f.google.com with SMTP id w10so4175731ilc.13
        for <linux-kernel@vger.kernel.org>; Wed, 03 Nov 2021 15:30:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0RTQmT2qEoeRXNJDGTe+Cy/M7zjSsz0CZeWCPpV13nI=;
        b=k0ndu3PgkpfnKJbC7v6jWcEN6hxAzwH/7qvoiaIZiJCmwYIcCW8g3mfw4tUAl4/lIb
         5dZSngF/HNur43bgeDjOSIr7mVBqJzKx4EpEBAjqkVkRfIqliteDh4ZfSe3BG5q+TBDq
         NEYxDcpnbMjDbuiNdXY3Ur27gFowHMqSvPShSibf4fNgEv+GOkJ2QB4YpNmUyoO6LE40
         PLoZ6sgNAjRWgvmqmyXF6MswiI13Uz66IoeW6GwRcevb2fhnxV9UnIGseE4pTwyfiU+r
         z6aFjr4gMq1c1tECF4hb1JhgqVjVPZX5YSS7HxYdBieCAL0+XmEt+gMRlq/iAHNXpy0R
         uSiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0RTQmT2qEoeRXNJDGTe+Cy/M7zjSsz0CZeWCPpV13nI=;
        b=ksGaMbltr9XjP3/COKzm5BigiN3h8lypoaU+wXkX9G9KEjnyL6ik+JRynjvc7SqmrB
         KA9pwX5dl5+5vFcJQrZdWbSJTpa6AWK4w7so2SSWYncE7S49C4JKFsx7+DURzZokaxNV
         GBWjVLtraqImlNCh8wTt2zvO8LvTs5yjf0bAIrEYDG9m1po0TGqJsPQp+l1R2+f5hghU
         Qw4O4QWw3DM4ZmJ6Cfe/lr+0O7ScP3bnDSyDEGRvlbVwg9u8TkGhQUc0mxlqrBSmZOyQ
         DpSYmOW5f6C9R859qllwBgOftWi5lnady/oPPF0SRHsIA26Wm3BwUbuLnfuv0F3PD04s
         KvCQ==
X-Gm-Message-State: AOAM532KQ0vU7tI2z6TblmCQ4ZKGkugF2SUWtxiUAVjuEqLTgfl4mi/T
        puLernOXKg4tHoY9fjUciqQwijRLJWsDnp85r8a5EA==
X-Google-Smtp-Source: ABdhPJx2aZnFkiybQ6cU3s0pAoSmVnun9265iqsI7ZiWCE1Rue7rQDh+wb0p3zqUs+FaGKxr1RWoxsDFsV7/b/kj6m8=
X-Received: by 2002:a05:6e02:b22:: with SMTP id e2mr10430693ilu.73.1635978602155;
 Wed, 03 Nov 2021 15:30:02 -0700 (PDT)
MIME-Version: 1.0
References: <20211029224929.379505-1-namhyung@kernel.org> <YYFGxwFMvTRN5KBI@krava>
 <CAM9d7cjPq7=HoPAi3Cd3crcNJO8hWu0cU8j4qOTqSMxd7M6BqQ@mail.gmail.com>
 <YYI5EwCjBojR+1QW@krava> <CABPqkBSHo3Gznor1e8M_Ue0XO8Z-HZt326q8N9kLWz4+jKkt-w@mail.gmail.com>
 <YYJzPkcUz2pcuspX@kernel.org> <CABPqkBQkqehAvpfJk77WZpXezrVO6cAj=9ktKFgL=C_m84_Dgg@mail.gmail.com>
 <YYL5FaKQ1ZvGwd08@kernel.org>
In-Reply-To: <YYL5FaKQ1ZvGwd08@kernel.org>
From:   Stephane Eranian <eranian@google.com>
Date:   Wed, 3 Nov 2021 15:29:50 -0700
Message-ID: <CABPqkBTr10pcbY0v5mM23PKDWdWg3CNywH4HLSGfy4ab8d6+=g@mail.gmail.com>
Subject: Re: [PATCH v3] perf evsel: Fix missing exclude_{host,guest} setting
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 3, 2021 at 2:03 PM Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
>
> Em Wed, Nov 03, 2021 at 10:35:04AM -0700, Stephane Eranian escreveu:
> > On Wed, Nov 3, 2021 at 4:32 AM Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
> > > Em Wed, Nov 03, 2021 at 12:44:12AM -0700, Stephane Eranian escreveu:
> > > > On Wed, Nov 3, 2021 at 12:24 AM Jiri Olsa <jolsa@redhat.com> wrote:
> > > > > > If the pmu doesn't support host/guest filtering, pmu/bla1/G
> > > > > > may count something.  Not sure if it's better to error out.
> > > > > > But the cycles:G and instructions:G should result in 0
> > > > > > in case there's no VM running.
>
> > > > > hm, I think if pmu doesn't support host/guest filtering then
> > > > > I think 'pmu/bla1/G' should error, no? better no number than
> > > > > bad number
>
> > > > Yes, it should in my opinion.
>
> > > Yeah, I thought about this yesterday (holiday here).
>
> > Otherwise you create the illusion that you are monitoring in guest
> > mode when you are not.
>
> > The question is: how can the tool know which modifiers are supported
> > per pmu model?
>
> As things stand kernel-wise, we should just do capability querying, i.e.
> if the user asks for a feature not available for a specific PMU, we
> should refuse and provide a helpful error message to the user.
>
> If the PMUs in the kernel had some kind of mask that stated what of the
> 'struct perf_event_attr' selectable features are supported, then we
> would just be able to avoid bothering the kernel asking for unsupported
> stuff.
>
I think we could add something like that in the sysfs entry for each
PMU instance.
that would avoid all these perf_event_open() calls and trying to
decipher the error
code.

> Just for exclude_guest we don't even need to have
> evsel->pmu->missing_features.exclude_guest, as this is a hard error, no
> point in caching previous capability queries.
>
> - Arnaldo
