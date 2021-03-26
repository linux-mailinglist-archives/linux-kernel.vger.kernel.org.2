Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC23B34A549
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 11:09:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229908AbhCZKI4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Mar 2021 06:08:56 -0400
Received: from mail.skyhub.de ([5.9.137.197]:53126 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229779AbhCZKIh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Mar 2021 06:08:37 -0400
Received: from zn.tnic (p4fed36c1.dip0.t-ipconnect.de [79.237.54.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 00A871EC0516;
        Fri, 26 Mar 2021 11:08:33 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1616753314;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=ZLc7fshYKo37ikTzRgiXujejn/o09szUdcbZCih/Npo=;
        b=LRVM0zVhuNBSNy2gNLhdAi/rs4vGZ8GNWL+tF7ODlo2f9NTql6MJZZtHRj50+vdcnBYUtj
        rDHwE6+XK2QpKPAEysyX/Cs5eR4X7dm+CkRQ9niCBxdNnzGw1d8XtGm7Nj7qK7lT90b61t
        9SxmhKmIcAz6vJ3Nb0PlOhBjcd5eM58=
Date:   Fri, 26 Mar 2021 11:06:20 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     libc-alpha <libc-alpha@sourceware.org>,
        "H. J. Lu" <hjl.tools@gmail.com>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Bae, Chang Seok" <chang.seok.bae@intel.com>,
        Florian Weimer <fweimer@redhat.com>,
        Carlos O'Donell <carlos@redhat.com>,
        Rich Felker <dalias@libc.org>
Subject: Re: Why does glibc use AVX-512?
Message-ID: <20210326100620.GA25229@zn.tnic>
References: <CALCETrURmk4ZijJVUtJwouj=_0NPiUvUFr9XMvdniRRFqeU+fg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CALCETrURmk4ZijJVUtJwouj=_0NPiUvUFr9XMvdniRRFqeU+fg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 25, 2021 at 09:38:24PM -0700, Andy Lutomirski wrote:
> I think we should seriously consider solutions in which, for new
> tasks, XCR0 has new giant features (e.g. AMX) and possibly even
> AVX-512 cleared, and programs need to explicitly request enablement.

I totally agree with making this depend on an explicit user request,
but...

> This would allow programs to opt into not saving/restoring across
> signals or to save/restore in buffers supplied when the feature is
> enabled.  This has all kinds of pros and cons, and I'm not sure it's a
> great idea.  But, in the absence of some change to the ABI, the
> default outcome is that, on AMX-enabled kernels on AMX-enabled
> hardware, the signal frame will be more than 8kB, and this will affect
> *every* signal regardless of whether AMX is in use.

... what's stopping the library from issuing that new ABI call before it
starts the app and get <insert fat feature here> automatically enabled
for everything by default?

And then we'll get the lazy FPU thing all over again.

So the ABI should be explicit user interaction or a kernel cmdline param
or so.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
