Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5CE739451D
	for <lists+linux-kernel@lfdr.de>; Fri, 28 May 2021 17:32:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236629AbhE1PeH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 May 2021 11:34:07 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:41870 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233270AbhE1PeE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 May 2021 11:34:04 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1622215949;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wfCUOtFr0WygTFDkR5FKbL+FKBHLtouLyX2xmDMXokY=;
        b=XJHUYo/xVErYy2KSD2fMOaqRQNHK7WQFOUa/rY4p3/O3gHnW3FdxNMVZK5ldM978gRhWvw
        x/a9THMYnlNxTubGss82N/FovVPP5pi8qDEd/1LXAlhm4xkWrhuWALF7hBqvxIuv1cGigI
        FbnX2RsDcGVY4Tws6A0zX4XvFzkfyE6AiyeJOBVzE8oekXJQn5qg7miIHtro/y5GSqSM9V
        zRXIGiR3wgJHEI+rnIOo0xiHQFz44YHTaZ/HaZtKMzz0z85h+CdownR59LPzGxCCWx9TBH
        9O9GlFDk+k0s439trD4K9ZE7POEOk1VlxnSAq68XA1la3LXdYagwH+tBtlH3AA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1622215949;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wfCUOtFr0WygTFDkR5FKbL+FKBHLtouLyX2xmDMXokY=;
        b=Ytn9OwDnX8/ud2+p2S0N5XmEahRWOh7e9ogMSavA2u0i7uq2gVDRiN60Yzkif3BO8hhUDS
        YN7shPb+VW1CP4Bg==
To:     Dave Hansen <dave.hansen@linux.intel.com>, linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org,
        Dave Hansen <dave.hansen@linux.intel.com>, mingo@redhat.com,
        bp@alien8.de, x86@kernel.org, luto@kernel.org, shuah@kernel.org,
        babu.moger@amd.com, dave.kleikamp@oracle.com, linuxram@us.ibm.com,
        bauerman@linux.ibm.com
Subject: Re: [PATCH 0/5] x86/pkeys: PKRU manipulation bug fixes and cleanups
In-Reply-To: <20210527235109.B2A9F45F@viggo.jf.intel.com>
References: <20210527235109.B2A9F45F@viggo.jf.intel.com>
Date:   Fri, 28 May 2021 17:32:28 +0200
Message-ID: <87eedq7u2b.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 27 2021 at 16:51, Dave Hansen wrote:
> Andy Lutomirski recently noted a probable bug in write_pkru(), but
> it was unclear if it was user-visible.  A recent bug report in
> related code[1] forced me to take a look.
>
> Basically, manipulation of XSAVE state is too unstructured.
> get_xsave_addr() gives callers the impression they can read and
> write XSAVE state when there are a lot of pitfalls, like updates
> to xstate.features bits.
>
> As a result, more than one call site screws up the modification
> of PKRU in the XSAVE buffer.  This series fixes that problem up
> and also hopefully carves out a less error-prone path that can
> be reused for other XSAVE features.
>
> This series:
>  * Moves the PKRU manipulation to a more appropriate location,
>    away from the page table code
>  * Wraps get_xsave_addr() with more structured, less error-prone
>    interfaces.
>  * Conditionally hides a pkey debugfs file, eliminating the need
>    for new runtime checks to work with the new interface.
>  * Add a selftest to make it more likely to catch bugs like this
>    in the future.  This improved selftest catches this issue on
>    Intel CPUs.  Without the improvement, it only triggers on AMD.

I think all of this is fundamentaly wrong.

Contrary to FPU state, PKRU has to be updated at context switch
time. There is absolutely no point in having PKRU XSAVES managed.

It's broken in several ways. Anything which clears and loads the FPU
will load the wrong PKRU value. Go figure...

So the right thing is to disable PKRU in XCR0 and on sched out simply do

   task->thread.pkru = read_pkru();

and on sched in

   write_pkru(task->thread.pkru);

Simple, trivial and not going to be wreckaged by anything which fiddles
with xstates. We all know by now that xstates is a trainwreck and not
having stuff like that in there is making the fixes I'm doing way
simpler.

CET will have a similar issue, but we'll discuss that once we have the
existing horrors sorted.

Thanks,

        tglx


