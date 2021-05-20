Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A94F038B710
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 21:16:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237378AbhETTR4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 15:17:56 -0400
Received: from mail-ed1-f45.google.com ([209.85.208.45]:46886 "EHLO
        mail-ed1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237612AbhETTRv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 15:17:51 -0400
Received: by mail-ed1-f45.google.com with SMTP id r11so20619335edt.13;
        Thu, 20 May 2021 12:16:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HqMs01SwhIzac61wHIqbpImRVDJ7bAhjZqygW+SGW5k=;
        b=lhRSKBUssk+/Zt+EfKfXtRgVQPw6l6JekPVo6nFAKKxaykCQJpEtRsevixmB0D9390
         Ev2sW6y7l00FEA3pgo25ycb3IkvrRgQZT4btpu2ZjqywRZmGlpInW2Hj4tRGky0j91mr
         sG/5kwa4RZc6oHOI/376xxs7IzCBiZL53uZD/C6owP0dzDVXNh+HVgJF6Q4FZL1es014
         cTy34J4aMd2yrnezlpD/cgJSNY2pr91UaQLEUI0LvFjLCUAFkJoBmIWeO24FTTBHwqLT
         TTGFo4P8G6QwLRlIzx2xjmhss/IrhpldyBVwP7EoyKWwRK/3XCPm28PCZ2+uGvqKorAp
         2X2g==
X-Gm-Message-State: AOAM532gaUH8jze/uhkrVyCrZm3CsjrdLYcsjlPXaAeqw67BE5gHXoXI
        hhY23r6WfWxdhSPdIRTYRmCC26U6tcLOOSo0pYU=
X-Google-Smtp-Source: ABdhPJyh43njdKBMqfGDgRouJG4tcrfxgxr8+9fee8ftTi2kkTl4QjUJ4jlGUE7IFuDfm/ed932lAGPXA1M5uOR40M4=
X-Received: by 2002:a05:6402:2789:: with SMTP id b9mr6665889ede.122.1621538188915;
 Thu, 20 May 2021 12:16:28 -0700 (PDT)
MIME-Version: 1.0
References: <20210415044258.GA6318@zn.tnic> <20210415052938.GA2325@1wt.eu>
 <20210415054713.GB6318@zn.tnic> <CAJvTdKnjzAMh3N_c7KP3kA=e0LgYHgCANg44oJp3LcSm7dtbSQ@mail.gmail.com>
 <20210419141454.GE9093@zn.tnic> <CAJvTdK=p8mgO3xw9sRxu0c7NTNTG109M442b3UZh8TqLLfkC1Q@mail.gmail.com>
 <20210419191539.GH9093@zn.tnic> <CAJvTdK=VnG94ECcRVoUi8HrCbVEKc8X4_JmRTkqe+vTttf0Wsg@mail.gmail.com>
 <20210419215809.GJ9093@zn.tnic> <CAJvTdKn6JHo02karEs0e5g+6SimS5VUcXKjCkX35WY+xkgAgxw@mail.gmail.com>
 <YIMmwhEr46VPAZa4@zn.tnic> <CAJvTdKnhXnynybS4eNEF_EtF26auyb-mhKLNd1D9_zvCrchZsw@mail.gmail.com>
 <8735uxmucw.ffs@nanos.tec.linutronix.de> <CAJvTdK=6B8fXasshqOoMknAt25vWPDW6LVLovOhnmY10ZEdL1Q@mail.gmail.com>
 <eebc971a-dc5f-6ae6-c5f7-d303e56212b2@kernel.org>
In-Reply-To: <eebc971a-dc5f-6ae6-c5f7-d303e56212b2@kernel.org>
From:   Len Brown <lenb@kernel.org>
Date:   Thu, 20 May 2021 15:16:17 -0400
Message-ID: <CAJvTdKk3JvKzvEb+x9H-zSGEz9iSDQ=WdFLaOA38f+GxCPVj0g@mail.gmail.com>
Subject: Re: Candidate Linux ABI for Intel AMX and hypothetical new related features
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>, Willy Tarreau <w@1wt.eu>,
        Florian Weimer <fweimer@redhat.com>,
        "Bae, Chang Seok" <chang.seok.bae@intel.com>,
        Dave Hansen <dave.hansen@intel.com>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-abi@vger.kernel.org,
        "libc-alpha@sourceware.org" <libc-alpha@sourceware.org>,
        Rich Felker <dalias@libc.org>, Kyle Huey <me@kylehuey.com>,
        Keno Fischer <keno@juliacomputing.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 19, 2021 at 7:29 PM Andy Lutomirski <luto@kernel.org> wrote:

> > It is established that there exists application code that counts on
> > this opaque state being complete so that it can do a user-space
> > XRESTORE instead of a sigreturn(2).
>
> Is this established?
>
> Note that the specific case of a user program doing XRSTOR will work
> just fine if we omit the allocation of non-in-use states from the
> buffer, at least by my reading of the pseudocode.

Yes, your understanding is correct -- XRESTOR works as one would expect.

> The case that would
> break is if user code then assumes that it can XSAVE back to the same
> buffer.

The other case that would break is if the concept of what features
were supported
(eg. XCR0) changed between when the context was saved and when it was
subsequently restored.  Yes, if a feature appeared, you'd get INIT;
but if a feature went away, you would fault.

I've been told that user-space software exists that does this.  If I can find
specific examples, I'll share that.

thanks,
Len Brown, Intel Open Source Technology Center
