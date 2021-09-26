Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACD9D418A76
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Sep 2021 20:15:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229623AbhIZSRd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Sep 2021 14:17:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbhIZSRc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Sep 2021 14:17:32 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EFC7C061570
        for <linux-kernel@vger.kernel.org>; Sun, 26 Sep 2021 11:15:56 -0700 (PDT)
Received: from zn.tnic (p200300ec2f244100f19bf647f200420d.dip0.t-ipconnect.de [IPv6:2003:ec:2f24:4100:f19b:f647:f200:420d])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id EA2B31EC066B;
        Sun, 26 Sep 2021 20:15:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1632680150;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=fNvNg2tQCPBngIh8cZ+bthoMYvzEVXLpip43Fl7TJyU=;
        b=E2NgKNWeVsrukcYmyOfTy+7FE7myy3yMYIj6mw3JyNwMay+iJEIIHW0Ul7wvWCik/PY5ab
        cc+CEQG6LSHwNnYoq8cBBLBw7LzI7BhW4aEFmJsU/IZj9n8x4pnXVvWQKcZdM8nuMXjgCV
        rsP0KAk2NdPmKkSYN0i/L+3KKSTIdxM=
Date:   Sun, 26 Sep 2021 20:15:43 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ian Rogers <irogers@google.com>
Subject: Re: [GIT pull] x86/urgent for v5.15-rc3
Message-ID: <YVC4zz1vCskBMb6I@zn.tnic>
References: <163265189226.178609.9712455554034472888.tglx@xen13>
 <163265189517.178609.6605494600326137493.tglx@xen13>
 <CAHk-=wj=C2W1VmW1RHU8ErvSjVF2Y=r9uWrnMCiz-U_aa8Dorw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHk-=wj=C2W1VmW1RHU8ErvSjVF2Y=r9uWrnMCiz-U_aa8Dorw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 26, 2021 at 10:21:18AM -0700, Linus Torvalds wrote:
> On Sun, Sep 26, 2021 at 3:30 AM Thomas Gleixner <tglx@linutronix.de> wrote:
> >
> >  - Prevent undefined behaviour to the potential unaligned accesss in the
> >    instroction decoder library.
> 
> What a horrible fix that is.
> 
> This is why we have "get_unaligned()". It might use memcpy()
> internally on some architectures (it doesn't really any more - Arnd
> cleaned it all up and now it uses a pointer that is marked unaligned),
> but more importantly it explains _why_ something is done the way it's
> done, rather than be an odd memcpy().
> 
> Oh well. The memcpy works, and compilers will do the right thing for
> it, but it's ugly.
> 
> In this case, it's actually *doubly* ugly, though, because we
> literally have functions to "load unaligned data in little-endian
> format".
> 
> So instead of doing a "memcpy()", followed by a magic special macro
> that does a "switch (sizeof(t))" and does a "le*_to_cpu()" on the
> result, the code could  literally have used the functions that do this
> all for them.
> 
> Ugh. Pulled. But it's ugly.

Yeah, that came up during review:

https://lore.kernel.org/lkml/CAP-5=fU2XBoOa2=00VCuWYqsLUzMSMzUXY63ZJt9rz-NJ+vYwA@mail.gmail.com/

and the follow-on messages and AFAICT the only hurdle to using
get_unaligned() is exporting it into tools/ for use by the version of
the insn decoder there in tools/arch/x86/lib/insn.c.

There's this other rather "theoretical" thing of Intel PT
decoding being done on any arch but get_unaligned() from
include/asm-generic/unaligned.h looks as generic and as arch-agnostic as
they get, to me...

But let me add the gents to Cc.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
