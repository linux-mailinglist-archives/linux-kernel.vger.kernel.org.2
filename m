Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9168D403D5F
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Sep 2021 18:09:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345355AbhIHQKJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Sep 2021 12:10:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232904AbhIHQKI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Sep 2021 12:10:08 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F491C061757
        for <linux-kernel@vger.kernel.org>; Wed,  8 Sep 2021 09:09:00 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id m4so4382214ljq.8
        for <linux-kernel@vger.kernel.org>; Wed, 08 Sep 2021 09:08:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=F5ZeFAknLDpJj0gufvdFHOmCevevfl6tESN6kJ6gAYQ=;
        b=K7yBmZ5ODUwzJy0G0jcYOAQOAvzjZ2K4Y7BSVXC/PKjsSnt1W/esVP6NG0CrPEqZLv
         vl4EG3Oho6nNuiO8w8cWwRpynP/MON/EPcKbZHzGYWwDVVwQZqCDcHY5KbbkKxwnRGzQ
         FQmC6QIVNuaqe/2ky5dtaOZcTd7jTkqvfEY6Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=F5ZeFAknLDpJj0gufvdFHOmCevevfl6tESN6kJ6gAYQ=;
        b=RDTLA/BF8E7FqLf9nTX3d0n5ZiCHNUCFBYrskC/zA5Y72OAoxtryf7B6tF/LLew/jB
         SB3NMvKdiCEgVenVmL7BDDY6XKUHWGvPECsrFzh/ZnJ4AUN3XvwppUDi3ypmey2X5sVV
         GWN9SilDrce5c8y58Pr04TG68dGACRa4Gcd42xcO3LaBeXEokitYtrg8jRTMWTS74BZy
         LUE+gLzHtE+GukqzKzxBs2wtnAsrFYX01P3yVfTzEsRjrNA67+4dMOoQlwZmXxKOGhao
         xp3Ov+83v4wYLl3ED59UzJ4cq8hpjWl/R0UFThAOpEjMBSuzbS1bBhPx1RkpF0vRCAnH
         84Pw==
X-Gm-Message-State: AOAM532FTwBUhvQAmdXCYZyOsIZujNUDVw48CZ69o+ukp6WkwDRl8K0+
        ikWPACx4fz+B1WgAdQFq1qyO4cfBjdD1cCb+nCw=
X-Google-Smtp-Source: ABdhPJx9KJbZ0+NecyAisOYvOC47If0Pcs/vkuFwREOz3TT0mu6rqjeufnW+bkcHAQtUs87ZrDZE7w==
X-Received: by 2002:a05:651c:385:: with SMTP id e5mr3351151ljp.35.1631117335494;
        Wed, 08 Sep 2021 09:08:55 -0700 (PDT)
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com. [209.85.208.178])
        by smtp.gmail.com with ESMTPSA id z1sm227129lfu.222.2021.09.08.09.08.50
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Sep 2021 09:08:51 -0700 (PDT)
Received: by mail-lj1-f178.google.com with SMTP id g14so4389525ljk.5
        for <linux-kernel@vger.kernel.org>; Wed, 08 Sep 2021 09:08:50 -0700 (PDT)
X-Received: by 2002:a2e:8107:: with SMTP id d7mr3580653ljg.68.1631117329470;
 Wed, 08 Sep 2021 09:08:49 -0700 (PDT)
MIME-Version: 1.0
References: <20180926182920.27644-2-paulmck@linux.ibm.com> <tip-6e89e831a90172bc3d34ecbba52af5b9c4a447d1@git.kernel.org>
 <YTiXyiA92dM9726M@hirez.programming.kicks-ass.net> <YTiiC1mxzHyUJ47F@hirez.programming.kicks-ass.net>
 <20210908144217.GA603644@rowland.harvard.edu>
In-Reply-To: <20210908144217.GA603644@rowland.harvard.edu>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 8 Sep 2021 09:08:33 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiXJygbW+_1BdSX6M8j6z4w8gRSHVcaD5saihaNJApnoQ@mail.gmail.com>
Message-ID: <CAHk-=wiXJygbW+_1BdSX6M8j6z4w8gRSHVcaD5saihaNJApnoQ@mail.gmail.com>
Subject: Re: [tip:locking/core] tools/memory-model: Add extra ordering for
 locks and remove it for ordinary release/acquire
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Anvin <hpa@zytor.com>,
        Andrea Parri <parri.andrea@gmail.com>,
        Ingo Molnar <mingo@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Vince Weaver <vincent.weaver@maine.edu>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Stephane Eranian <eranian@google.com>,
        Will Deacon <will@kernel.org>,
        linux-tip-commits@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 8, 2021 at 7:42 AM Alan Stern <stern@rowland.harvard.edu> wrote:
>
> there is no reason _in theory_ why a CPU shouldn't reorder and interleave
> the operations to get:

I agree about the theory part.

But I think the LKMM should be the strongest ordering that is reasonable.

And it should take common architecture behavior into account.

IOW, if there is some rare architecture where the above can happen,
but no common sane one allows it in practice, we should strive to make
the LKMM the _stronger_ one.

We sure as hell shouldn't say "RISC-V is potentially very weakly
ordered, so we'll allow that weak ordering".

Because overly weak ordering only causes problems for others. And the
performance arguments for it have historically been garbage anyway.
See the pain powerpc goes through because of bad ordering (and even
more so alpha), and see how arm actually strengthened their ordering
to make everybody happier.

So if this is purely a RISC-V thing, then I think it's entirely reasonable to

        spin_unlock(&r);
        spin_lock(&s);

cannot be reordered.

Strict specifications are not a bad thing, and weak memory ordering is
not inherently good.

             Linus
