Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4287C3479D0
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 14:44:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235448AbhCXNnj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 09:43:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:48904 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234574AbhCXNnX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 09:43:23 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7C1F0619D3;
        Wed, 24 Mar 2021 13:43:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616593402;
        bh=MPmffnqKet7GibAYfcAT0zGmqL6ykoNK5Vgadj8rBEU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=c8s9kISPwKESwNkKfNNuk+ZAgCh6b9krH72tFqb0KOLos12GWAN6SNXdmQJGYpAjp
         CjPhxvpVuFZcYyqQkFsWj1h4WHRcdSo9KgQR/cvLfRGeGXVa3X/guVRgOC1slfQM3C
         FGm7VAWslEveGhilOphGs8fgMfq8VUPA8BHYcJDs/LB6sWD8BB7gfyT8r26Hmliliw
         E8Qs/K5sgoepoB9FVEk+KVHqSIey4x6h+g1rtpTgD6YgDvlYHWp3oCR74Rw1cSFkF9
         bWaeHJwJxkBEeXpixC3qPKOAesvoPzlau7fTZM/2csCnUY71fMa6ZtxasaDs7wZiQL
         E/NWKG3zkBY0Q==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 64A5D40647; Wed, 24 Mar 2021 10:43:20 -0300 (-03)
Date:   Wed, 24 Mar 2021 10:43:20 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Borislav Petkov <bp@alien8.de>, Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>, X86 ML <x86@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH v3 04/21] x86/insn: Add an insn_decode() API
Message-ID: <YFtB+Dir1lWjL2gi@kernel.org>
References: <20210304174237.31945-1-bp@alien8.de>
 <20210304174237.31945-5-bp@alien8.de>
 <CAP-5=fU2D_kmdaLFL7Azm31Czdfdze6EpKg7=uZ+ohbNnb7ssQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP-5=fU2D_kmdaLFL7Azm31Czdfdze6EpKg7=uZ+ohbNnb7ssQ@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Mar 16, 2021 at 06:14:54PM -0700, Ian Rogers escreveu:
> On Thu, Mar 4, 2021 at 9:56 AM Borislav Petkov <bp@alien8.de> wrote:
> > From: Borislav Petkov <bp@suse.de>
> >
> > Users of the instruction decoder should use this to decode instruction
> > bytes. For that, have insn*() helpers return an int value to denote
> > success/failure. When there's an error fetching the next insn byte and
> > the insn falls short, return -ENODATA to denote that.
> >
> > While at it, make insn_get_opcode() more stricter as to whether what has
> > seen so far is a valid insn and if not.
> >
> > Copy linux/kconfig.h for the tools-version of the decoder so that it can
> > use IS_ENABLED().
> >
> > Also, cast the INSN_MODE_KERN dummy define value to (enum insn_mode)
> > for tools use of the decoder because perf tool builds with -Werror and
> > errors out with -Werror=sign-compare otherwise.
> >
> > Signed-off-by: Borislav Petkov <bp@suse.de>
> > Acked-by: Masami Hiramatsu <mhiramat@kernel.org>

> > +++ b/tools/arch/x86/lib/insn.c
> > @@ -11,10 +11,13 @@
> >  #else
> >  #include <string.h>
> >  #endif
> > -#include "../include/asm/inat.h" /* __ignore_sync_check__ */
> > -#include "../include/asm/insn.h" /* __ignore_sync_check__ */
> > +#include <asm/inat.h> /*__ignore_sync_check__ */
> > +#include <asm/insn.h> /* __ignore_sync_check__ */
> 
> Hi, this change is breaking non-x86 builds of perf for me in
> tip.git/master. The reason being that non-x86 builds compile the
> intel-pt-decoder, which includes this file, but don't have their
> include paths set to find tools/arch/x86. I think we want to keep the
> relative paths.

Borislav, was this addressed? Ian?

- Arnaldo
