Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D08063A1446
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 14:24:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232938AbhFIM0j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 08:26:39 -0400
Received: from mail-pl1-f176.google.com ([209.85.214.176]:34439 "EHLO
        mail-pl1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232797AbhFIM0e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 08:26:34 -0400
Received: by mail-pl1-f176.google.com with SMTP id h1so4786434plt.1
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jun 2021 05:24:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=JUxPE8wCUjEtv9Cm0b9jhJOj/m0Sh9161tmrSowqyJQ=;
        b=1KnkowiNG5w1WYIZwgXJXD0YwmTZmqZVU7K6cNmVl4gR1yeDJ15xJof4fxS0LdoDT6
         AeDPXb3NnzpvommYxb78SJGrd/paSVomlmMvUcVOP1SisWeq+HNBIBVbCWVTWC1vY3rt
         DrvnFirXtre7eOVME2ndB3el/C61OzrYU5u2ne6nhU8LcSSyHG36vX7yivmHoki3079E
         vw62jp8WYUzpJngG0hrxEMayaAxMFDK8JVncD6XUH6R98tCbuL8nIkLK+0tqri49+CuV
         BlADfnOe6rvy3lu6HeOi+YLdCwq16jRfpLJgFP/ylOPh0VuAxCsaGaEhwQwZETbhN6Aq
         6jWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=JUxPE8wCUjEtv9Cm0b9jhJOj/m0Sh9161tmrSowqyJQ=;
        b=fMiDUZOFEYeFC+3Y4vobqguTbQSWAlt2N//G1e2OvnwGWYK3AECSAfyz5Zv28sAto2
         BDyWaow8kMxfPGc0PrMLmkfRQ/vRVL3CIal8tuByTRXUKcfLFUIsEwgzRJnxxytRYmPP
         l2CnczPMoWC5rKt/xhKyEnl0YcRsEGKaWcpn7srmiKSkC3SdRSAhLmr0HHQ2avuLph54
         iJMb82edOQrLOh5nm3jIt5gyJwaUmDQGRzSSzQ4P8D7klT3dWgvL0vLYUikyM/2idZlm
         FWUKrK6hek8ht2mT63Dij7AY1Q42FTEbV/G6prt5y41ml+LCjsXHS6zV0KGC8btfcpIi
         3L4w==
X-Gm-Message-State: AOAM533agdyfgLropBiPzFAi4bM21IiqooeYt0yo4kfoByp0z9c/F30z
        CEGF7sckx3C7F5IBQpfsDiCjDB5oUuSgq13fkHnN6g==
X-Google-Smtp-Source: ABdhPJyDBuVpholVLRm9OnDE6xch0HWKs3yQsnfZep1EYCboAA9mH09JAuNiElC9yBmtflBsCM5R+a/U+bCMZt3EduQ=
X-Received: by 2002:a17:90a:2d8e:: with SMTP id p14mr375378pjd.131.1623241419590;
 Wed, 09 Jun 2021 05:23:39 -0700 (PDT)
MIME-Version: 1.0
References: <YL3RQCJGIw9835Y1@hirez.programming.kicks-ass.net>
 <YL3lQ5QdNV2qwLR/@hirez.programming.kicks-ass.net> <YL3q1qFO9QIRL/BA@hirez.programming.kicks-ass.net>
 <CAKwvOdkuJBwZRigeqdZGevPF9WHyrC5pBAsz6_tWdXAc-wO+1A@mail.gmail.com>
 <e351ac97-4038-61b5-b373-63698a787fc1@kernel.org> <YL+nb235rIfEdye0@hirez.programming.kicks-ass.net>
 <de1a21c0-f20a-cde5-016e-4b8ca92eafa9@kernel.org> <YL+0MO/1Ra1tnzhT@hirez.programming.kicks-ass.net>
 <5dd58dce-c3a7-39e5-8959-b858de95b72c@kernel.org> <CAFJ_xbp5YzYNQWEJLDySyC_bWUsirq=P03k8HHW=B4sH0V_uUg@mail.gmail.com>
 <YMBrqDI0Oxj9+Cr/@hirez.programming.kicks-ass.net>
In-Reply-To: <YMBrqDI0Oxj9+Cr/@hirez.programming.kicks-ass.net>
From:   Lukasz Majczak <lma@semihalf.com>
Date:   Wed, 9 Jun 2021 14:23:28 +0200
Message-ID: <CAFJ_xbodWTQQaJ-3yJ4ZQOiTFFXo6M+cn_F0p157o=80BwrQAw@mail.gmail.com>
Subject: Re: [PATCH v3 16/16] objtool,x86: Rewrite retpoline thunk calls
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        =?UTF-8?B?RsSBbmctcnXDrCBTw7JuZw==?= <maskray@google.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Guenter Roeck <groeck@google.com>,
        Juergen Gross <jgross@suse.com>,
        =?UTF-8?Q?=C5=81ukasz_Bartosik?= <lb@semihalf.com>,
        LKML <linux-kernel@vger.kernel.org>, mbenes@suse.com,
        =?UTF-8?Q?Rados=C5=82aw_Biernacki?= <rad@semihalf.com>,
        upstream@semihalf.com,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Sami Tolvanen <samitolvanen@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

=C5=9Br., 9 cze 2021 o 09:20 Peter Zijlstra <peterz@infradead.org> napisa=
=C5=82(a):
>
> On Wed, Jun 09, 2021 at 09:11:18AM +0200, Lukasz Majczak wrote:
>
> > I'm sorry I was on vacation last week - do you still need the requested=
 debugs?
>
> If the patch here:
>
>   https://lkml.kernel.org/r/YL3q1qFO9QIRL/BA@hirez.programming.kicks-ass.=
net
>
> does not fix things for you (don't think it actually will), then yes,
> please send me the information requested.

Ok, it didn't help. Peter, Josh I have sent you a private email with
requested information.

Best regards
Lukasz
