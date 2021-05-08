Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06C07377106
	for <lists+linux-kernel@lfdr.de>; Sat,  8 May 2021 11:46:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230360AbhEHJq4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 May 2021 05:46:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbhEHJqz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 May 2021 05:46:55 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0AA8C061574;
        Sat,  8 May 2021 02:45:54 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1620467152;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5V2mnN+5XyzmdPeCcUBgDC7Wx1AGdBSa3j7Jt0jotPs=;
        b=CZYCg9X7S7igLlH+mfktuCfAw9b5bCzbEJVFe6O7ePWZ7I7QO5OIXPJD3jRYqLowd1SPYb
        2B86xDKW1uZaMqC0wQSe5+xlBukX+ONjgUZ82A9yhGvzs2LwmCyhMJD4DoHlN+J+NBhzTR
        CzEWA9RgjZC42E8ANWYxhHIZ6UM4MjEiGm9zM/34vMzBbKm5v7Ka4T097onibDuyUpGZ0T
        ryc0JDJ+0RqOEbQ2wtKhtpoLRUnhC7N3B/y18I2klpW/26CKl4SWvH6CeVpoUocSF2yQU0
        /uPShmU0vzPFtI27o7EoI65YvO9vYBT97tbJWXBZ+UiubgOYP+tMQcwKAT1deA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1620467152;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5V2mnN+5XyzmdPeCcUBgDC7Wx1AGdBSa3j7Jt0jotPs=;
        b=zHTsBSRc19KD3cm1gZrWLNvxGiUh6wLowBlz2y+Ue3Xj74pJhIPwAS2ZxAx7g9JGn8UQaM
        yC2RJDGUuqKpg8DQ==
To:     Len Brown <lenb@kernel.org>, Borislav Petkov <bp@alien8.de>
Cc:     Willy Tarreau <w@1wt.eu>, Andy Lutomirski <luto@kernel.org>,
        Florian Weimer <fweimer@redhat.com>,
        "Bae\, Chang Seok" <chang.seok.bae@intel.com>,
        Dave Hansen <dave.hansen@intel.com>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-abi@vger.kernel.org,
        "libc-alpha\@sourceware.org" <libc-alpha@sourceware.org>,
        Rich Felker <dalias@libc.org>, Kyle Huey <me@kylehuey.com>,
        Keno Fischer <keno@juliacomputing.com>
Subject: Re: Candidate Linux ABI for Intel AMX and hypothetical new related features
In-Reply-To: <CAJvTdKnhXnynybS4eNEF_EtF26auyb-mhKLNd1D9_zvCrchZsw@mail.gmail.com>
References: <20210415044258.GA6318@zn.tnic> <20210415052938.GA2325@1wt.eu> <20210415054713.GB6318@zn.tnic> <CAJvTdKnjzAMh3N_c7KP3kA=e0LgYHgCANg44oJp3LcSm7dtbSQ@mail.gmail.com> <20210419141454.GE9093@zn.tnic> <CAJvTdK=p8mgO3xw9sRxu0c7NTNTG109M442b3UZh8TqLLfkC1Q@mail.gmail.com> <20210419191539.GH9093@zn.tnic> <CAJvTdK=VnG94ECcRVoUi8HrCbVEKc8X4_JmRTkqe+vTttf0Wsg@mail.gmail.com> <20210419215809.GJ9093@zn.tnic> <CAJvTdKn6JHo02karEs0e5g+6SimS5VUcXKjCkX35WY+xkgAgxw@mail.gmail.com> <YIMmwhEr46VPAZa4@zn.tnic> <CAJvTdKnhXnynybS4eNEF_EtF26auyb-mhKLNd1D9_zvCrchZsw@mail.gmail.com>
Date:   Sat, 08 May 2021 11:45:51 +0200
Message-ID: <8735uxmucw.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 02 2021 at 11:27, Len Brown wrote:
> On Fri, Apr 23, 2021 at 3:58 PM Borislav Petkov <bp@alien8.de> wrote:
> Here is how it works:
>
> 1. The kernel boots and sees the feature in CPUID.
>
> 2. If the kernel supports that feature, it sets XCR0[feature].
>
>     For some features, there may be a bunch of kernel support,
>     while simple features may require only state save/restore.
>
> 2a.  If the kernel doesn't support the feature, XCR0[feature] remains cleared.
>
> 3. user-space sees the feature in CPUID
>
> 4. user-space sees for the feature via xgetbv[XCR0]
>
> 5. If the feature is enabled in XCR0, the user happily uses it.
>
>     For AMX, Linux implements "transparent first use"
>     so that it doesn't have to allocate 8KB context switch
>     buffers for tasks that don't actually use AMX.
>     It does this by arming XFD for all tasks, and taking a #NM
>     to allocate a context switch buffer only for those tasks
>     that actually execute AMX instructions.
>
> 5a. If the feature is not enabled in XCR0, and the tasks uses
>     those instructions anway, the hardware delivers a #UD
>     and the kernel kills the process with a signal.

Where is #6 which describes the signal interaction?

Thanks,

        tglx
