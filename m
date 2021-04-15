Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66F8F361014
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Apr 2021 18:24:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233426AbhDOQZO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Apr 2021 12:25:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:42944 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232769AbhDOQZL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Apr 2021 12:25:11 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9CCAB611AB
        for <linux-kernel@vger.kernel.org>; Thu, 15 Apr 2021 16:24:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618503888;
        bh=VYxHahJBforwe3MfNV0e6RnvHNGnmfHfYrMKb8oKV9s=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=rXPA0h80WaVpCx89GVFcTOw3HtWUAQvIh+b7FMxm941WEq3OiP144lHVm5oVlwSl/
         /neWcCWZ3lg4Hj1aEAUpJpgQ/H5FuoBSSfG3QtEMT3QmxygeTKba2aphak9AuW3dcB
         /EHZudsFe0lKKCEiAWSiFJtIbjqm7ubllgnh3kUe3wvBLZ90zUxOLeu5R+TFVup+DH
         sTKRUWxheJnAxUQ6xQEPLh5JMGY+FWtVTk3Mm99FYK9jwTRDeUavVNuXJP0dZ5kC5t
         ERIUHb2b/DVL3MTKmWLiIb/dYJAwTHkk85eCn9sFU3lZ6x37nUAxDNyyw2SmJUDGWH
         CkrRCtN0oaWFw==
Received: by mail-ed1-f54.google.com with SMTP id i3so3138424edt.1
        for <linux-kernel@vger.kernel.org>; Thu, 15 Apr 2021 09:24:48 -0700 (PDT)
X-Gm-Message-State: AOAM533+O9VUK3ZzecQJ+pqr5AF21qTMxlRWL28JLtbEJkg9UEZf/yt9
        NeVQ4BMnesA3ED46Azcb37ZoP8uHGggEydgufvJv9w==
X-Google-Smtp-Source: ABdhPJxZiAPHDDqVvIe+erjFzL3KmpFZL0uuTEMD4aqgRxs/U4w22d7FbjnhR0mktjNYjWWXuZwd4MBN/h6ZpD0ONg0=
X-Received: by 2002:aa7:c144:: with SMTP id r4mr5324339edp.222.1618503887222;
 Thu, 15 Apr 2021 09:24:47 -0700 (PDT)
MIME-Version: 1.0
References: <CALCETrW2QHa2TLvnUuVxAAheqcbSZ-5_WRXtDSAGcbG8N+gtdQ@mail.gmail.com>
 <87lf9nk2ku.fsf@oldenburg.str.redhat.com> <CALCETrWxJzf-rm9rqMpdxEtdVe+0OH7XRtWV=UzrgBDiPT=vVQ@mail.gmail.com>
 <CAJvTdKkAzEeAKrEYMU-gBWXoNGyJ09ZGw1gsU0b3uCuo8vrX0A@mail.gmail.com>
 <CALCETrVvapzL79BQNEvOupMHHzriR+n97955tRA+TPE6rgRC4Q@mail.gmail.com>
 <CAJvTdKmDb3TOHbb4w1YNcdYH2Pzr+RsAS_o0q3AFP1Xz55R37g@mail.gmail.com>
 <CALCETrUe4_DvSdq7CRJsUxZm8DSwfHevagxJEbHv88UjcC1Hkg@mail.gmail.com> <CAJvTdKmppOcyy=akSo3+dn0KN5GmOKLK5cp3eZ_ymujE-=ExwQ@mail.gmail.com>
In-Reply-To: <CAJvTdKmppOcyy=akSo3+dn0KN5GmOKLK5cp3eZ_ymujE-=ExwQ@mail.gmail.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Thu, 15 Apr 2021 09:24:35 -0700
X-Gmail-Original-Message-ID: <CALCETrUxc1Y=4XmNthSSCeQfJ_SKNS762Nt3B-CynE-rhRSBGw@mail.gmail.com>
Message-ID: <CALCETrUxc1Y=4XmNthSSCeQfJ_SKNS762Nt3B-CynE-rhRSBGw@mail.gmail.com>
Subject: Re: Candidate Linux ABI for Intel AMX and hypothetical new related features
To:     Len Brown <lenb@kernel.org>
Cc:     Andy Lutomirski <luto@kernel.org>, Willy Tarreau <w@1wt.eu>,
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

On Wed, Apr 14, 2021 at 2:48 PM Len Brown <lenb@kernel.org> wrote:
>

>
> > Then I take the transition penalty into and out of AMX code (I'll
> > believe there is no penalty when I see it -- we've had a penalty with
> > VEX and with AVX-512) and my program runs *slower*.
>
> If you have a clear definition of what "transition penalty" is, please share it.

Given the generally awful state of Intel's documentation about these
issues, it's quite hard to tell for real.  But here are some examples.

VEX: Figures 11-1 ("AVX-SSE Transitions in the Broadwell, and Prior
Generation Microarchitectures") and 11-2 ("AVX-SSE Transitions in the
Skylake Microarchitecture").  We *still* have a performance regression
in the upstream kernel because, despite all common sense, the CPUs
consider LDMXCSR to be an SSE instruction and VLDMXCSR to be an AVX
instruction despite the fact that neither one of them touch the XMM or
YMM state at all.

AVX-512:

https://lore.kernel.org/linux-crypto/CALCETrU06cuvUF5NDSm8--dy3dOkxYQ88cGWaakOQUE4Vkz88w@mail.gmail.com/

https://travisdowns.github.io/blog/2020/01/17/avxfreq1.html





>
> Lacking one, I'll assume you are referring to the
> impact on turbo frequency of using AMX hardware?
>
> Again...
>
> On the hardware that supports AMX, there is zero impact on frequency
> due to the presence of AMX state, whether modified or unmodified.
>
> We resolved on another thread that Linux will never allow entry
> into idle with modified AMX state, and so AMX will have zero impact
> on the ability of the process to enter deep power-saving C-states.
>
> It is true that AMX activity is considered when determining max turbo.
> (as it must be)
> However, the *release* of the turbo credits consumed by AMX is
> "several orders of magnitude" faster on this generation
> than it was for AVX-512 on pre-AMX hardware.

What is the actual impact of a trivial function that initializes the
tile config, does one tiny math op, and then does TILERELEASE?

> Yes, the proposal, and the working patch set on the list, context
> switches XFD -- which is exactly what that hardware was designed to do.
> If the old and new tasks have the same value of XFD, the MSR write is skipped.
>
> I'm not aware of any serious proposal to context-switch XCR0,
> as it would break the current programming model, where XCR0
> advertises what the OS supports.  It would also impact performance,
> as every write to XCR0 necessarily provokes a VMEXIT.

You're arguing against a nonsensical straw man.

In the patches, *as submitted*, if you trip the XFD #NM *once* and you
are the only thread on the system to do so, you will eat the cost of a
WRMSR on every subsequent context switch.  This is not free.  If we
use XCR0 (I'm not saying we will -- I'm just mentioning at a
possibility), then the penalty is presumably worse due to the VMX
issue.
