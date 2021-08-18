Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47E273F0A74
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Aug 2021 19:45:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231285AbhHRRqM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Aug 2021 13:46:12 -0400
Received: from mail.skyhub.de ([5.9.137.197]:49832 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229448AbhHRRqK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Aug 2021 13:46:10 -0400
Received: from zn.tnic (p200300ec2f0cc30025743e574fa309df.dip0.t-ipconnect.de [IPv6:2003:ec:2f0c:c300:2574:3e57:4fa3:9df])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id B5C741EC0545;
        Wed, 18 Aug 2021 19:45:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1629308729;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=Rm1R61L2TyziZYdmq4RN129Oj2rm0BKJ+VZjrBh0K14=;
        b=fA0uWfxS1+n4Q29B8zvlRpHWS77CfXF5wvVNLN+E/VhuJvd0NEntV0hK4kGgKEYe2oBM24
        7X1PxUNLl4sjSIoC/lf3Fa8Au6Q85HHgIHDDyHvFmV8SsQV7++WUAGBZexb45ybYudFNmv
        rQyCecStB5dF8LEmct8qi7FYWVSIoyU=
Date:   Wed, 18 Aug 2021 19:46:09 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Thiago Macieira <thiago.macieira@intel.com>
Cc:     "Chang S. Bae" <chang.seok.bae@intel.com>, luto@kernel.org,
        tglx@linutronix.de, mingo@kernel.org, x86@kernel.org,
        len.brown@intel.com, dave.hansen@intel.com, jing2.liu@intel.com,
        ravi.v.shankar@intel.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v9 12/26] x86/fpu/xstate: Use feature disable (XFD) to
 protect dynamic user state
Message-ID: <YR1HYRRN0HMTxXrw@zn.tnic>
References: <20210730145957.7927-1-chang.seok.bae@intel.com>
 <20210730145957.7927-13-chang.seok.bae@intel.com>
 <YR00U19168BGoRB9@zn.tnic>
 <3181031.RqgVF4sTRC@tjmaciei-mobl5>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <3181031.RqgVF4sTRC@tjmaciei-mobl5>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 18, 2021 at 10:20:58AM -0700, Thiago Macieira wrote:
> Why not?
>
> It could help diagnosing why this code has a failure if XFD is somehow 
> missing. That can happen with hypervisors or future CPUs.

You're new to this...

tools/arch/x86/kcpuid/kcpuid.c should be used for all CPUID querying
needs.

<snipping the SIGILL question for now because it might become moot>

> That's a good question, but I thought it had been discussed and agreed that we 
> didn't want to extend the buffers at the moment the application requested the 
> bits, because it may never need them.

Huh? An application doing prctl(GIVE_ME_AMX) and then it might never
need it? That's only that application's fault then.

> This was probably a defence against applications requesting all bits
> without knowing whether they'll need them at all.

That sounds like a badly programmed application.

> The way the API to userspace is implemented, the only way to find
> out if the kernel supports a given state is to enable it. It's not
> currently possible to ask "do you support AMX tile data?"

Then our API needs improving. An app should be able to ask the kernel
"Do you support AMX?" get a proper answer and act accordingly.

> and then go about the application's merry way until it determines it
> really wants to do matrix multiplications. In the case of applications
> with plugins, they need to have that answer before the load the
> plugin, which usually happens at application start.

I don't see a problem with the app doing at load time:

A: Heey, kernel, do you support AMX?
K: Yes
A: Allocate a dynamic FPU buffer for me then pls.

> I was going to suggest a new API to return the supported bits, but
> hadn't yet because it wasn't required for this patchset to work.

I think you should. The important part is having the API good and
complete.

> So long as that API landed at or before the time a new bit was added,
> userspace would be able to cope. But if the kernel is going to
> allocate the bits at the moment of the system call *and* we wish for
> userspace not to request more than it really needs, then we'll need
> this extra API right now.

No no, once the API hits upstream, it is cast in stone. So it better
be done in full with the patchset, in one go. No later significant API
additions or changes, none especially after apps start using it.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
