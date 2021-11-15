Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FBEB451C1C
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Nov 2021 01:10:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351556AbhKPAMt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Nov 2021 19:12:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349747AbhKOV3B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Nov 2021 16:29:01 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D4F9C061229
        for <linux-kernel@vger.kernel.org>; Mon, 15 Nov 2021 13:12:55 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1637010773;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fMg6PRGHFyMnRKcSWWdIjV/tEeqqS7jgOA5IYp5dU1o=;
        b=DfBXh0tS1Mvkb5sOWI+u7gmf0TZHY91bn4lFc4waeXs2ugMyh7I5yFK+z/d/OBNxdcIDcc
        7P2qONGm2q462axc2a5fGbnr7IyJ1lxLHaMy1gWnW3BhlELsz7Cvr1w/20steG1ebOjXsr
        Xhe8l/E2ujGpitw5w9tX5wgI6QgmBGtnKrK4FIBMeD2gnM511ZToH0i4quwcmIXr3DDAdW
        wRMn9bRK9cTGCaQ8RkkmXJZBRdIyhALXSU6WOa1j3OW8YDfnE3dufwkJ5vofmxsT37+KYw
        rSfrGMmUW/pekl//7br0CYG1kCVRGRypK+VdCleA+mXYoBZpbFbS3igJRVy54g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1637010773;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fMg6PRGHFyMnRKcSWWdIjV/tEeqqS7jgOA5IYp5dU1o=;
        b=M3Dg5kpMWlvy21DeCbJ742SN98pNC4RXU2wdzuoieGexLnWRuCIVWw0IFFq6M0i7f8Th0l
        pERvA1oyvY9P7BBg==
To:     Andy Lutomirski <luto@kernel.org>,
        Asit K Mallick <asit.k.mallick@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Brown, Len" <len.brown@intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Bae, Chang Seok" <chang.seok.bae@intel.com>,
        Arjan van de Ven <arjan@linux.intel.com>
Cc:     Andrew Cooper <andrew.cooper3@citrix.com>
Subject: Re: Revisiting XFD-based AMX and heterogenous systems
In-Reply-To: <0f03a9e2-4611-4b5c-962f-93a7e1d2bde8@www.fastmail.com>
References: <0f03a9e2-4611-4b5c-962f-93a7e1d2bde8@www.fastmail.com>
Date:   Mon, 15 Nov 2021 22:12:52 +0100
Message-ID: <8735nx6s2z.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Andy,

On Mon, Nov 15 2021 at 11:59, Andy Lutomirski wrote:
> So I suggest that we go back and switch to the XCR0 model.  Tasks will
> start out with AMX clear in XCR0.  If they want AMX, they issue a
> prctl asking for AMX, AMX gets set in XCR0, and the tasks need to be
> able to tolerate the XCR0 change.

We can do that, but that still want's XFD for avoiding allocating large
buffers for all tasks in such a process which never use that feature.

Aside of that as we all know context switching XCR0 sucks.

> Then, if Intel ever wants to expose the full Alder Lake physical
> capabilities and support efficiency cores and AVX-512 on the same
> boot, we can have a mode in which tasks start with AVX-512 clear in
> XCR0 and can opt in with prctl.  This will require HPC-like apps to be
> recompiled or run with a special wrapper bit will otherwise expose the
> full HW capabilities. (Of course this assumes that Intel sets up MSRs
> or ucode or whatever to support this.)

If software needs to be recompiled or wrapped anyway then Intel can just
provide XFD support for AVX512 if it wants to expose this at runtime on
those CPUs.

As that needs to be implemented for AMX anyway the logical consequence
for user space is:

    available = arch_prctl(ARCH_GET_XCOMP_SUPP);        // Same as XCR0
    permitted = arch_prctl(ARCH_GET_XCOMP_PERM);        // XRC0 & permission bits

and work from there. If done with future XFD support for other features
than AMX in mind (even retroactively added for AVX512) then this should
be straight forward to adjust.

For the kernel adding XFD for AVX512 even conditionally based on a CPUID
bit is pretty straight forward now. It needs a small change to the way
how we distinguish XFD based and unconditional features, but that's
trivial effort compared to going for XCR0 switching with all its
downsides.

Thanks,

        tglx
