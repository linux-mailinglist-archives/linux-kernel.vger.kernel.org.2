Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 751593FF247
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Sep 2021 19:23:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346622AbhIBRYj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Sep 2021 13:24:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346582AbhIBRYi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Sep 2021 13:24:38 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6B27C061575
        for <linux-kernel@vger.kernel.org>; Thu,  2 Sep 2021 10:23:39 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id s10so5909999lfr.11
        for <linux-kernel@vger.kernel.org>; Thu, 02 Sep 2021 10:23:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gOotsDMeLtXCPmS2rPy5ur44v/otffxT4MMMsT0RtEQ=;
        b=Phjx5hB2D3ogRbLkacxeviaM+E9cJCzn9UYv426hI5lv5Uq5/rd0E/V/H9RCzWbWNP
         ghmZ9zz8rXdUaliKNzBA3WzVry0tIyHH7i5/BHVv3SmMYwRKW1LM8sJj9s96GnApyn9C
         TFwQc3xR8Uc5d82GA3ar4SycARwSXs1C787uUkuzeRI6jK/9O+g4J1aLSOXOjsU6V/Oa
         8uU8/T63NfS+kqkRftvpMCNiiT7NO8aik6EI5RGcf6P02ue8i53u0ABVtUtuKajkDq3A
         PsxR0kjxdibULtUZOntAty5PpooeFMZk1tXUcRjxwoOl/TBR2ySSiWGJLSjwHvoT2JMR
         7fvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gOotsDMeLtXCPmS2rPy5ur44v/otffxT4MMMsT0RtEQ=;
        b=Q+MVlZdcKj/2NWlgOZyKLoagKRo1ApIjdb1i5rslMuzCLPfany8lW71ftKC6gcnlgP
         wNDy9EQjPNOKllQSd10pypOp+HFjhjBolWaR/f8wkBHcnWE+FuI851omnrnYCoKxnWNF
         gODz5bKk3bDOmTQLISzide19tdhQF3CPTpOynQVZ4A1FgyPqXe7PHbsio8A/nKjzz6sh
         vIgPlYepBwoduQ7GdfSFOI87qoVJdaKhHdAI1Bfmdle0zOsN921+P3ISAYfs57nxhljI
         zC5HzLxp41uKzA8NZgtzMaZjOwLr41+9t4QgJQGmaQ/63cd74GwcgYmxRA9U4P48TA0W
         dTqg==
X-Gm-Message-State: AOAM532F5LcbzYvVPoXAdqsoBufYq6nBkjwBtjLFNo0/qk9Rt6dJbuj4
        6w/3AajwqaaxcshadZz1dV1MvTHz3RMyaGDSZTgzmw==
X-Google-Smtp-Source: ABdhPJzzJYqCduB6DND9GkbDNaXzVtJtiRbiT/aFt0iGPUjRUSdaTdMDe0QVS7o1cT+/VEoMcDPRphcBzxwg/K8Cde0=
X-Received: by 2002:a05:6512:ad3:: with SMTP id n19mr3360083lfu.297.1630603417930;
 Thu, 02 Sep 2021 10:23:37 -0700 (PDT)
MIME-Version: 1.0
References: <20210831175025.27570-1-jiangshanlai@gmail.com>
 <20210831175025.27570-3-jiangshanlai@gmail.com> <YTCGov+vvAMvso7q@suse.de>
 <1f327579-e62a-df65-0763-e88243829db3@linux.alibaba.com> <YTCsWpSmPYvXa1xz@hirez.programming.kicks-ass.net>
 <4c589fef-8c98-a6fc-693f-b205a7710e42@linux.alibaba.com> <YTC+FTo4uLLdyBxA@hirez.programming.kicks-ass.net>
 <YTDS/p/bnsTFzNES@hirez.programming.kicks-ass.net> <CAKwvOdmhUzR0QfAU+nVRtSPu11vg9yvyJ09Pb8q1X6CEfez=8w@mail.gmail.com>
 <CANiq72=OH0FYLnRfiVt5kjC39bZZsmjsMLCAAfh9iN1KQyzBaw@mail.gmail.com>
In-Reply-To: <CANiq72=OH0FYLnRfiVt5kjC39bZZsmjsMLCAAfh9iN1KQyzBaw@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 2 Sep 2021 10:23:27 -0700
Message-ID: <CAKwvOdmuLN3F2Fk+WsEg1=EwDC48Z1jzBsBq_q2+uKkEpj5-Yg@mail.gmail.com>
Subject: Re: [PATCH 02/24] x86/traps: Move arch/x86/kernel/traps.c to arch/x86/entry/
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Miguel Ojeda <ojeda@kernel.org>,
        =?UTF-8?Q?Martin_Li=C5=A1ka?= <mliska@suse.cz>,
        Lai Jiangshan <laijs@linux.alibaba.com>,
        Joerg Roedel <jroedel@suse.de>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Brijesh Singh <brijesh.singh@amd.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Chester Lin <clin@suse.com>, Juergen Gross <jgross@suse.com>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        linux-toolchains@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 2, 2021 at 10:19 AM Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
>
> On Thu, Sep 2, 2021 at 7:05 PM Nick Desaulniers <ndesaulniers@google.com> wrote:
> >
> > The above 2 hunks should go in include/linux/compiler_attributes.h,
> > but yes.  I'd been meaning to send such a patch; it's nice to have
>
> Note that `compiler_attributes.h` does not keep attributes that depend
> on config options.

Sure, I'd drop the config check and define it conditionally on the
__has_attribute check alone. Does it hurt to mark functions as
__attribute__((no_stack_protector)) when we're not building with
-fstack-protector*? Nope!

> On one hand, I feel we should put them there. On the other hand, I
> want to avoid making a mess again since the purpose of the file is to
> keep things clean for the majority of attributes.
>
> Perhaps we should do a middle-ground, and only allow those that depend
> on a single config option, i.e. no nesting `#if`s or complex
> conditions.
-- 
Thanks,
~Nick Desaulniers
