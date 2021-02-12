Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A11E931976D
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Feb 2021 01:26:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230332AbhBLAYZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Feb 2021 19:24:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229895AbhBLAYX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Feb 2021 19:24:23 -0500
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02D15C061786
        for <linux-kernel@vger.kernel.org>; Thu, 11 Feb 2021 16:23:43 -0800 (PST)
Received: by mail-qv1-xf2f.google.com with SMTP id e9so2915867qvy.3
        for <linux-kernel@vger.kernel.org>; Thu, 11 Feb 2021 16:23:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=KqTLTsbdrTGVIghcDkYt5epBaafbNevmlo91ukcKzxU=;
        b=Yy799SB63qjaBhZielaGtbPOh1rjmIDChZi+LYiZcpZXC0aWJ2lyTjZgdnzAL7J67p
         taBk6UjxPq6LLWQHYxum9OxangrtJmpXgyizwIGQwIznHoLWmFr68oHvBzDFgwiXB5Th
         ZjOlajrj0t23Ll4Z7WBLQkhLyx0JUd/L2efkN7tV5gxMAK8GwdqayK5xx5uMa/resQi+
         CR23SI3jq6R8mg+n/vRxOaOY4a8Qvzme3WB7ZlZJ3GeZI7n3Jw+0PVX0zLOsPURV+TGV
         yUFyp0ldTVBKWjBVJW1CsZJ+3IBd7YvBZYaiIuJaFtczo439S1SfzapFimEMwhzP1Z83
         i5XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=KqTLTsbdrTGVIghcDkYt5epBaafbNevmlo91ukcKzxU=;
        b=lLlRWBvrrkIKUsqz6U5eqIOkNWdkw8NKuODJVg255NsALKYSg87DxQNOw0TDDHWXO1
         oWptkGJwhHFPoMFgG48So4y0KFevdoNNGutNfvSRoPD8FjwGHVswvki+MM/dgf++NS/2
         rfH2lWsAA9IdRUUmzTYApChR/0xWBtMJWhLm8n4BZJm7vAyUDCbJCMApOjGuXGqNEm+K
         N20tzFYtBMwauDAerR+ZFA3iNMAsmz01HAh9ICR7vcyIt0wcD/9IfwszwIH+pxGUI5du
         rRHD96k19q0JCIHfL35qWK361hnm6wOL7ziQ6NrcweHZF1y9MTzrU3t5ylLLWKx1IQ6z
         KLRw==
X-Gm-Message-State: AOAM530daFTiBlre0R4Y74i5EA7gf01kPL/vp5xJg4JT5TnzxEZhyTMn
        N06ah7x71jKM2wzifPv0Xfw=
X-Google-Smtp-Source: ABdhPJzcLgjAf93023wGBitvdrQdwwuDuSDRJmJa2+CYYFABkHRyorcPUsix9ADjCiP4/ZjetCXDvQ==
X-Received: by 2002:a0c:fd64:: with SMTP id k4mr489415qvs.3.1613089421392;
        Thu, 11 Feb 2021 16:23:41 -0800 (PST)
Received: from localhost ([24.214.13.233])
        by smtp.gmail.com with ESMTPSA id i6sm4634753qti.30.2021.02.11.16.23.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Feb 2021 16:23:40 -0800 (PST)
Date:   Thu, 11 Feb 2021 16:23:39 -0800
From:   Yury Norov <yury.norov@gmail.com>
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
Subject: Re: [PATCH v4 0/8] support for bitmap (and hence CPU) list "N"
 abbreviation
Message-ID: <20210212002339.GA167389@yury-ThinkPad>
References: <20210209225907.78405-1-paul.gortmaker@windriver.com>
 <YCQJToq1d63BU55S@smile.fi.intel.com>
 <20210210175751.GH2743@paulmck-ThinkPad-P72>
 <CAAH8bW-oZG_h3F-d9Rc4wUwSZxNPR+sdeY41yZ+BpwAjXSCXWw@mail.gmail.com>
 <20210211002309.GL2743@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210211002309.GL2743@paulmck-ThinkPad-P72>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 10, 2021 at 04:23:09PM -0800, Paul E. McKenney wrote:
> On Wed, Feb 10, 2021 at 03:50:07PM -0800, Yury Norov wrote:
> > On Wed, Feb 10, 2021 at 9:57 AM Paul E. McKenney <paulmck@kernel.org> wrote:
> > >
> > > On Wed, Feb 10, 2021 at 06:26:54PM +0200, Andy Shevchenko wrote:
> > > > On Tue, Feb 09, 2021 at 05:58:59PM -0500, Paul Gortmaker wrote:
> > > > > The basic objective here was to add support for "nohz_full=8-N" and/or
> > > > > "rcu_nocbs="4-N" -- essentially introduce "N" as a portable reference
> > > > > to the last core, evaluated at boot for anything using a CPU list.
> > > >
> > > > I thought we kinda agreed that N is confusing and L is better.
> > > > N to me is equal to 32 on 32 core system as *number of cores / CPUs*. While L
> > > > sounds better as *last available CPU number*.
> > >
> > > The advantage of "N" is that people will automatically recognize it as
> > > "last thing" or number of things" because "N" has long been used in
> > > both senses.  In contrast, someone seeing "0-L" for the first time is
> > > likely to go "What???".
> > >
> > > Besides, why would someone interpret "N" as "number of CPUs" when doing
> > > that almost always gets you an invalid CPU number?
> > >
> > >                                                         Thanx, Paul
> > 
> > I have no strong opinion about a letter, but I like Andy's idea to make it
> > case-insensitive.
> > 
> > There is another comment from the previous iteration not addressed so far.
> > 
> > This idea of the N notation is to make the bitmap list interface more robust
> > when we share the configs between different machines. What we have now
> > is definitely a good thing, but not completely portable except for cases
> > 'N', '0-N' and 'N-N'.
> > 
> > For example, if one user adds rcu_nocbs= '4-N', and it works perfectly fine for
> > him, another user with s NR_CPUS == 2 will fail to boot with such a config.
> > 
> > This is not a problem of course in case of absolute values because nobody
> > guaranteed robustness. But this N feature would be barely useful in practice,
> > except for 'N', '0-N' and 'N-N' as I mentioned before, because there's always
> > a chance to end up with a broken config.
> > 
> > We can improve on robustness a lot if we take care about this case.For me,
> > the more reliable interface would look like this:
> > 1. chunks without N work as before.
> > 2. if 'a-N' is passed where a>=N, we drop chunk and print warning message
> > 3. if 'a-N' is passed where a>=N together with a control key, we set last bit
> > and print warning.
> > 
> > For example, on 2-core CPU:
> > "4-2" --> error
> > "4-4" --> error
> > "4-N" --> drop and warn
> > "X, 4-N" --> set last bit and warn
> > 
> > Any comments?
> 
> We really don't know the user's intent, and we cannot have complete
> portability without knowing the user's intent.  For example, "4-N" means
> "all but the first four CPUs", in which case an error is appropriate
> because "4-N" makes no more sense on a 2-CPU system than does "4-1".
> I could see a potential desire for some notation for "the last two CPUs",
> but let's please have a real need for such a thing before overengineering
> this patch series any further.
> 
> To get the level of portability you seem to be looking for, we need some
> higher-level automation that knows how many CPUs there are and what
> the intent is.  That automation can then generate the cpumasks for a
> given system.  But for more typical situations, what Paul has now will
> work fine.
> 
> Paul Gortmaker's patch series is doing something useful.  We should
> not let potential future desires prevent us from taking a very useful
> step forward.
> 
> 							Thanx, Paul

No problem, we can do it later if it will become a real concern. 

Can you please remove this series from linux-next unless we finish
the review? It prevents me from applying the series from the LKML.

Yury
