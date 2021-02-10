Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08B0B3174BE
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Feb 2021 00:52:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233895AbhBJXvU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 18:51:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232565AbhBJXu7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 18:50:59 -0500
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3475AC06174A
        for <linux-kernel@vger.kernel.org>; Wed, 10 Feb 2021 15:50:19 -0800 (PST)
Received: by mail-io1-xd29.google.com with SMTP id u8so3843057ior.13
        for <linux-kernel@vger.kernel.org>; Wed, 10 Feb 2021 15:50:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lCi9XXUP0cQtrx8jhRDhF39o9rKH5GcFdbD18whEmTY=;
        b=qyM5iwvEkM/Ws4/4PC10L33v7tv+bcrXDwr2/b/Th/Y7V/fMnQLWoeCTFAu5CvuiNI
         CWE4ieY930AZm9LH2J0DPfFZv1FZRx7hQOaIwJ2o1/1Waqshu+fT8I9PnKlajv1NbLpK
         UOOMmIw63uOAdW3z1/UNj0c4weP16JRwRDqMmhdukY3d8V5rCM4ZS1FLHzrQL1NelvpN
         GsOumhcFkzf3Sy5Vp9yzSVUOVhF6/pxmeO5d4WuGeFd5XUFBySp6Co212IjoZ9dnI6Wx
         GCg7alqByRIgFFDLzgZAzeZ9Z7IpHEhMXjXA568bdRNcZ7RNjMpctYEl+LTqLleefiRF
         vuyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lCi9XXUP0cQtrx8jhRDhF39o9rKH5GcFdbD18whEmTY=;
        b=fVwD5cPf1zbJQVpM72slXmz4buVnuyOmf3BaXIVplR2wOCSqXHF+r5+/eyPX099jXZ
         ejU6xpTkf14nPqLuBpcWNdEn9uKh55Fb5LUVUqkDPNPn3q+/YRIN8SI/SAi7k1gwGbcp
         gsmrgkZcnZsYzdwsdhTXOM4w02ObP5M/PyEjO9Z7Jnd74n+mpJFrh3cPEAh48Ka3x5gM
         MXv+h8KT/n2065ZLpTCZZmoUjyyD2pM0m5aArAfXM2mu5KrRdozgSNHtwTnrk/5kkoXf
         ZqoSa7JYZaBhySpJWmPFWSw9ZmNURPoeGSMxCIItx/v6O7xNWzWoiVkMYNpBzXXsKW6X
         +T6Q==
X-Gm-Message-State: AOAM532+bnfTgmdsgT5g0Aw3VIMe+8Jm1PD3K8IuC0JZx2nSDkZypuTV
        mOx6snORIF0VnJEjzz1mqu5A8MflC5J6kYgzpHk=
X-Google-Smtp-Source: ABdhPJzkfZAz8UHrFjzHXp2Zp6qLC+x1Vtahxyhc+Dj8LOcZbI2b8NKggGnlIRRzId2VvCC8LsDwVgVusrrnYLgtbyk=
X-Received: by 2002:a02:cd37:: with SMTP id h23mr5825957jaq.29.1613001018569;
 Wed, 10 Feb 2021 15:50:18 -0800 (PST)
MIME-Version: 1.0
References: <20210209225907.78405-1-paul.gortmaker@windriver.com>
 <YCQJToq1d63BU55S@smile.fi.intel.com> <20210210175751.GH2743@paulmck-ThinkPad-P72>
In-Reply-To: <20210210175751.GH2743@paulmck-ThinkPad-P72>
From:   Yury Norov <yury.norov@gmail.com>
Date:   Wed, 10 Feb 2021 15:50:07 -0800
Message-ID: <CAAH8bW-oZG_h3F-d9Rc4wUwSZxNPR+sdeY41yZ+BpwAjXSCXWw@mail.gmail.com>
Subject: Re: [PATCH v4 0/8] support for bitmap (and hence CPU) list "N" abbreviation
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Li Zefan <lizefan@huawei.com>, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Josh Triplett <josh@joshtriplett.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 10, 2021 at 9:57 AM Paul E. McKenney <paulmck@kernel.org> wrote:
>
> On Wed, Feb 10, 2021 at 06:26:54PM +0200, Andy Shevchenko wrote:
> > On Tue, Feb 09, 2021 at 05:58:59PM -0500, Paul Gortmaker wrote:
> > > The basic objective here was to add support for "nohz_full=8-N" and/or
> > > "rcu_nocbs="4-N" -- essentially introduce "N" as a portable reference
> > > to the last core, evaluated at boot for anything using a CPU list.
> >
> > I thought we kinda agreed that N is confusing and L is better.
> > N to me is equal to 32 on 32 core system as *number of cores / CPUs*. While L
> > sounds better as *last available CPU number*.
>
> The advantage of "N" is that people will automatically recognize it as
> "last thing" or number of things" because "N" has long been used in
> both senses.  In contrast, someone seeing "0-L" for the first time is
> likely to go "What???".
>
> Besides, why would someone interpret "N" as "number of CPUs" when doing
> that almost always gets you an invalid CPU number?
>
>                                                         Thanx, Paul

I have no strong opinion about a letter, but I like Andy's idea to make it
case-insensitive.

There is another comment from the previous iteration not addressed so far.

This idea of the N notation is to make the bitmap list interface more robust
when we share the configs between different machines. What we have now
is definitely a good thing, but not completely portable except for cases
'N', '0-N' and 'N-N'.

For example, if one user adds rcu_nocbs= '4-N', and it works perfectly fine for
him, another user with s NR_CPUS == 2 will fail to boot with such a config.

This is not a problem of course in case of absolute values because nobody
guaranteed robustness. But this N feature would be barely useful in practice,
except for 'N', '0-N' and 'N-N' as I mentioned before, because there's always
a chance to end up with a broken config.

We can improve on robustness a lot if we take care about this case.For me,
the more reliable interface would look like this:
1. chunks without N work as before.
2. if 'a-N' is passed where a>=N, we drop chunk and print warning message
3. if 'a-N' is passed where a>=N together with a control key, we set last bit
and print warning.

For example, on 2-core CPU:
"4-2" --> error
"4-4" --> error
"4-N" --> drop and warn
"X, 4-N" --> set last bit and warn

Any comments?
