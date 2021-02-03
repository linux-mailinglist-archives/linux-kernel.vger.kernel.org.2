Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B85030E402
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 21:26:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231951AbhBCU02 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 15:26:28 -0500
Received: from mail.skyhub.de ([5.9.137.197]:41238 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231215AbhBCU01 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 15:26:27 -0500
Received: from zn.tnic (p200300ec2f0c84001e2b7e52dd5f0f2b.dip0.t-ipconnect.de [IPv6:2003:ec:2f0c:8400:1e2b:7e52:dd5f:f2b])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 2667A1EC030F;
        Wed,  3 Feb 2021 21:25:46 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1612383946;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=h7qLws0nAUhJDyIxSlIK0rNtDKdIIXXM5jI8Qr98KgI=;
        b=TGK4qCFUwRZEAsmGau1EAa4oEY1aMHQ3QaT5jgOmtPOGMugGPM7CTqcMDUasYz6hhQohiU
        h2Lgs8xIWWQVjdM8OauVJBalpY7MYcuVRB9zbm3sndO3LgzNsiSLQxXtE3O56IHcw+MZsT
        WgxR6SaZomKGv8XbDvDISjeU5w4zfpI=
Date:   Wed, 3 Feb 2021 21:25:42 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Andy Lutomirski <luto@amacapital.net>
Cc:     Andy Lutomirski <luto@kernel.org>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Yonghong Song <yhs@fb.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 09/11] x86/fault: Rename no_context() to
 kernelmode_fixup_or_oops()
Message-ID: <20210203202542.GM13819@zn.tnic>
References: <20210203193949.GI13819@zn.tnic>
 <88AA1DD6-615B-4049-B335-F2F40F85EF08@amacapital.net>
 <20210203200729.GL13819@zn.tnic>
 <CALCETrU_LTyc5oKPtO2pkKjRdPV4Pdzw4_TmcuyVUfTGfkB6jA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CALCETrU_LTyc5oKPtO2pkKjRdPV4Pdzw4_TmcuyVUfTGfkB6jA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 03, 2021 at 12:14:24PM -0800, Andy Lutomirski wrote:
> Hmm.  I'm not convinced this is really much better.  Maybe it is.  Let
> me think about it.  I feel like it's somehow too close to the previous
> tangle where too many functions did too many different things.

I know what you mean.

Well, we can put it aside for now since you'll likely do more cleanup
here and it might become unnecessary after you're done. :-)

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
