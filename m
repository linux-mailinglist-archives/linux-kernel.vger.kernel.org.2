Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B0A6362CBB
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Apr 2021 03:59:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235204AbhDQB6L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 21:58:11 -0400
Received: from mail-ed1-f54.google.com ([209.85.208.54]:40817 "EHLO
        mail-ed1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229719AbhDQB6K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 21:58:10 -0400
Received: by mail-ed1-f54.google.com with SMTP id o20so8081577edc.7;
        Fri, 16 Apr 2021 18:57:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Jo74dkJt7xqUoXDWytSGjWDUiJiuB264VMFRwEGPHI4=;
        b=UIyudsLmP3Uko+YcvzfgQlwpKyS74oCxOeUVKCp8J+G6WPBf1EcWZiM4zZ57B3FD08
         K5aj5WeMfmei557pYzF5uMOXFxH74PmblucoHO4D46abnso/vU7T8mrJAcIYAxKZfX7j
         hqW4gAl+fGLdIf5M9cWkLX3+GZlgX9QjBEic63DZhCOLZnHGDk+2gcpBn2Imf0tlGlPd
         rGKsn0uifzbC5XOfTwkEdlzCHQV033JobzU5mBzMxneLADJdjYxNpkaD/8O9bRdE7q6J
         tH5kNRAs5cXRkwN5SBclqUvmLTPYtQDsOPekSEB3I3+yA+E/LkPgnQhIwffYvYHIbrtX
         LVcQ==
X-Gm-Message-State: AOAM530ezCiq/LGTLPzFjfnqmZMOlZkvx/IhQwXLg0VSgHMoAOYK7UJh
        g8WW1KE8ep4SbBSCwXKFw7rY4rzZvMg9Obdz4Ek=
X-Google-Smtp-Source: ABdhPJyIqg5OuLyLoiKaIg7RcVsHIcICQfAyLflM9kU/vz762xy5bBys6eKAw2sljUMooVjAvTvCb3E92clKD/nOYwA=
X-Received: by 2002:aa7:c144:: with SMTP id r4mr13488454edp.222.1618624662590;
 Fri, 16 Apr 2021 18:57:42 -0700 (PDT)
MIME-Version: 1.0
References: <CALCETrW2QHa2TLvnUuVxAAheqcbSZ-5_WRXtDSAGcbG8N+gtdQ@mail.gmail.com>
 <87lf9nk2ku.fsf@oldenburg.str.redhat.com> <CALCETrWxJzf-rm9rqMpdxEtdVe+0OH7XRtWV=UzrgBDiPT=vVQ@mail.gmail.com>
 <CAJvTdKkAzEeAKrEYMU-gBWXoNGyJ09ZGw1gsU0b3uCuo8vrX0A@mail.gmail.com>
 <CALCETrVvapzL79BQNEvOupMHHzriR+n97955tRA+TPE6rgRC4Q@mail.gmail.com>
 <CAJvTdKmDb3TOHbb4w1YNcdYH2Pzr+RsAS_o0q3AFP1Xz55R37g@mail.gmail.com>
 <CALCETrUe4_DvSdq7CRJsUxZm8DSwfHevagxJEbHv88UjcC1Hkg@mail.gmail.com>
 <CAJvTdKmppOcyy=akSo3+dn0KN5GmOKLK5cp3eZ_ymujE-=ExwQ@mail.gmail.com>
 <CALCETrUxc1Y=4XmNthSSCeQfJ_SKNS762Nt3B-CynE-rhRSBGw@mail.gmail.com>
 <CAJvTdKmDskNka9tm5TMZkkP8tYa-K01sz8hAMccRSaAYKNPz5Q@mail.gmail.com>
 <CALCETrVbbDm1P21yG4HWPCuipPdBT6-Kdd5sRZpaZjjQr9euDw@mail.gmail.com>
 <CAJvTdKkSt-O6TkxJmE+Q2VCDqc9AzpovbpafsME2NBUqRpHEJw@mail.gmail.com> <CALCETrV=Q7+D4EZiQDOwqF6O=BfMOxCpLed7=YVUJADayKAJ7Q@mail.gmail.com>
In-Reply-To: <CALCETrV=Q7+D4EZiQDOwqF6O=BfMOxCpLed7=YVUJADayKAJ7Q@mail.gmail.com>
From:   Len Brown <lenb@kernel.org>
Date:   Fri, 16 Apr 2021 21:57:31 -0400
Message-ID: <CAJvTdKnbe91EzHX-ctB1F-a7mCgzFwjCjRt=b-j2D1Gv8quZOg@mail.gmail.com>
Subject: Re: Candidate Linux ABI for Intel AMX and hypothetical new related features
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Willy Tarreau <w@1wt.eu>, Florian Weimer <fweimer@redhat.com>,
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

On Fri, Apr 16, 2021 at 6:14 PM Andy Lutomirski <luto@kernel.org> wrote:

> My point is that every ...

I encourage you to continue to question everything and trust nobody.
While it may cost you a lot in counseling, it is certainly valuable,
at least to me! :-)

I do request, however, that feedback stay specific, stay technical,
and stay on-topic.
We all have plenty of real challenges we can be tackling with our limited time.

> Is there any authoritative guidance at all on what actually happens,
> performance-wise, when someone does AMX math?

Obviously, I can't speak to the performance of AMX itself pre-production,
and somebody who does that for a living will release stuff on or
before release day.

What I've told you about the performance side-effects on the system
(and lack thereof)
from running AMX code is an authoritative answer, and is as much as I
can tell you today.
If I failed to answer a question about AMX, my apologies, please re-ask it.

And if we learn something new between now and release day that is
relevant to this discussion,
I will certainly request to share it.

Our team (Intel Open Source Technology Center) advocated getting the existing
public AMX documentation published as early as possible.  However, if
you are really
nto the details of how AMX works, you may also be interested to know
that the AMX hardware patent filings are fully public ;-)

cheers,
Len Brown, Intel Open Source Technology Center
