Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B19E41B883
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Sep 2021 22:41:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242735AbhI1Umu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Sep 2021 16:42:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242734AbhI1Umt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Sep 2021 16:42:49 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44B16C06161C
        for <linux-kernel@vger.kernel.org>; Tue, 28 Sep 2021 13:41:09 -0700 (PDT)
Received: from zn.tnic (p200300ec2f13b200371079131a9f19c8.dip0.t-ipconnect.de [IPv6:2003:ec:2f13:b200:3710:7913:1a9f:19c8])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id CEA211EC0755;
        Tue, 28 Sep 2021 22:41:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1632861667;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=LKu4BuTewIGVNUUyP0wPH9scKlbnBgbn6W5c8KgaLdk=;
        b=j92vyIquuwvZLCBWC4lI8tWPzvuJ/l6NswuuKOirNEKmnOWlTC1IGSKf+A2okId/jYQfH9
        /pkgrYi8zchytb/4RBVTiQ8YxSUprt4B0pQHnlHgvwf4BUN3zB25kcJ9Nk3K8AKYo7geBZ
        S3wLCxL5hsqF8KpFa4r8VQIzpD6iHBQ=
Date:   Tue, 28 Sep 2021 22:41:06 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ian Rogers <irogers@google.com>
Subject: Re: [GIT pull] x86/urgent for v5.15-rc3
Message-ID: <YVN94ojuLApdN1IT@zn.tnic>
References: <163265189226.178609.9712455554034472888.tglx@xen13>
 <163265189517.178609.6605494600326137493.tglx@xen13>
 <CAHk-=wj=C2W1VmW1RHU8ErvSjVF2Y=r9uWrnMCiz-U_aa8Dorw@mail.gmail.com>
 <YVC4zz1vCskBMb6I@zn.tnic>
 <CAHk-=whJvs+-kCMynbt9YRVfcyM5TL8wwNhdOX9iygC5y--CHw@mail.gmail.com>
 <YVNXWJEeGOqxXIjf@zn.tnic>
 <CAHk-=whSHDmcAbe=1AhRC8D8WcT6DpCP59kgjZc-wa8TfhxMiw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHk-=whSHDmcAbe=1AhRC8D8WcT6DpCP59kgjZc-wa8TfhxMiw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 28, 2021 at 01:13:49PM -0700, Linus Torvalds wrote:
> Well, cleaner.
> 
> You lost the leXX_to_cpu() part, so now it does the wrong thing if you
> were to cross-build the tooling side on a BE architecture.

Bah, I got carried away with the axe...

And looka here: 1d509f2a6ebc ("x86/insn: Support big endian cross-compiles")
 
> I'm not sure that matters. BE is dead, nobody would ever cross-build
> tooling that way. But maybe a compile-time error, at least, so that
> the problem is obvious.

Yeah, lemme re-add those conversion things - looks like we do use them.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
