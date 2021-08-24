Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81DC03F6C28
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Aug 2021 01:22:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233464AbhHXXXQ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 24 Aug 2021 19:23:16 -0400
Received: from mail-ed1-f48.google.com ([209.85.208.48]:35420 "EHLO
        mail-ed1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231745AbhHXXXP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Aug 2021 19:23:15 -0400
Received: by mail-ed1-f48.google.com with SMTP id q17so12242691edv.2
        for <linux-kernel@vger.kernel.org>; Tue, 24 Aug 2021 16:22:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=jt1xPoihlMFualcaA7azQSeNjnGZTnYUqYiE9vCrqw4=;
        b=jkMiwJyiqmQi2v2zemE+XCCtY0YT22oGzKEUXPcKjV5wpeltO+YW+46q12Vsf/JqrY
         UAhuH89VOy0Q0O0nT8V/jsGwUEKbTxu5iaXlOxyy1wSYVyrCT2uT1rqR4z3NcmF4yOSD
         XtCrFFp2VxE07sNYF2dGaN0pVHNOSc38mAdiIHALI9bwdtS4th4eOowXfXWl9tb5AmIs
         74k5NqHsN1wZWAAW3Ov3LtMWkWbMUuuTbokSkYUp9Dz/cmL9xMprIVTb7C5RlLiSf4LU
         q82t5sh09En5ok+2q5OegiUdKsgu+FBPJTb0xcjwQzK+/tnuKNOmC/lKLG0hqaBmOJU5
         iApg==
X-Gm-Message-State: AOAM533wlfq1tmcXizSzKnCO7gbvvV8yfkhpSPYdeB/7iCCWNxr5EHt6
        1JakgOFeU6fCzhriiZ1lXM7LDTEuot509mm4drY=
X-Google-Smtp-Source: ABdhPJziKW6jfdeUb4d4V2qsdARFCHE6mqvY1OCTNOGkaZMl2VuYepfUOwr7MMCOw1oT/1BJc3ZD/XCeYLQ9z6cW0cw=
X-Received: by 2002:a05:6402:35d2:: with SMTP id z18mr14289865edc.92.1629847349638;
 Tue, 24 Aug 2021 16:22:29 -0700 (PDT)
MIME-Version: 1.0
References: <20210730145957.7927-1-chang.seok.bae@intel.com>
 <20210730145957.7927-13-chang.seok.bae@intel.com> <YR00U19168BGoRB9@zn.tnic>
 <3181031.RqgVF4sTRC@tjmaciei-mobl5> <YR1HYRRN0HMTxXrw@zn.tnic>
 <BCC327C2-CF9F-4910-B626-315E515E9A3A@intel.com> <YR14zq2LaExjhFR+@zn.tnic>
In-Reply-To: <YR14zq2LaExjhFR+@zn.tnic>
From:   Len Brown <lenb@kernel.org>
Date:   Tue, 24 Aug 2021 19:22:18 -0400
Message-ID: <CAJvTdKnhn8rOKUJ0VKvM08sFYkvmEsSWBsH2ynncxH9_z49bxA@mail.gmail.com>
Subject: Re: [PATCH v9 12/26] x86/fpu/xstate: Use feature disable (XFD) to
 protect dynamic user state
To:     Borislav Petkov <bp@alien8.de>
Cc:     "Bae, Chang Seok" <chang.seok.bae@intel.com>,
        "Macieira, Thiago" <thiago.macieira@intel.com>,
        "Lutomirski, Andy" <luto@kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@kernel.org" <mingo@kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "Brown, Len" <len.brown@intel.com>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        "Liu, Jing2" <jing2.liu@intel.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 18, 2021 at 5:16 PM Borislav Petkov <bp@alien8.de> wrote:
>
> On Wed, Aug 18, 2021 at 08:43:50PM +0000, Bae, Chang Seok wrote:
> > Maybe I’m missing something, but I wonder what’s the difference
> > from reading XCR0.
>
> Wny, because adding another prctl() is too damn hard?

Adding complexity is easy.  Removing it is the hard part. ;-)

Programmers today know what CPUID and xgetbv(XCR0) mean:
1. feature exists in the HW
2. OS has ability to handle state

This is true for all features.

We are forced to complicate their life for AMX (and subsequent features)
because of the legacy Linux signal ABI.
We require that new apps invoke a system call to tell us that they are
not indeed a legacy
program, but that they are a program that understands if they use an
alt-sig-stack
that it must be big enough to handle whatever current hardware requires.

The secondary motivation for the system call is the desire to give the
kernel a hook
so that it can refuse to give permission for some apps to use AMX,
should the need arise.

Programmers don't like this, but it nobody has figured out a more
programmer-friendly way
to meet these requirements.
And so if they want to use AMX on Linux, they *must* use this new SET syscall.
Since Linux enforces that they use it, they will use it if they want
AMX (or subsequent features).

> prctl(GET_FEATURES_WITH_KERNEL_ASSISTANCE);

The problem is that it adds zero value over the currently used xgetbv(XCR0).
As it adds no value, programmers will not use it.

Sure, if the hardware is re-designed, and Linux is re-designed, and XCR0
can then change at run-time during the lifetime of a program, we have additional
challenges.  (such as legacy code that doesn't expect XCR0 to change
at run-time).
I don't think that this additional system call even begins to address
that theoretical
new world.

But this discussion moot.  If it has no use, it will not get used.
--
Len Brown, Intel Open Source Technology Center
