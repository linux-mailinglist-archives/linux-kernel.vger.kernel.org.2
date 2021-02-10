Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BEA5A316AC6
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 17:10:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232059AbhBJQKn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 11:10:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:54784 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230489AbhBJQKk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 11:10:40 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 62DDB64E79
        for <linux-kernel@vger.kernel.org>; Wed, 10 Feb 2021 16:09:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612973399;
        bh=qkJZIAItpLuMeUw4ojssOOi4gB0ScOne5y6B9A84OKY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=pihK3FOVKFZVSqkBgE3x1SCat94rZavRbHZ74WoGc5Fh36QpamObEZ6XcrNouOBQb
         k8xF7T91ZfDPsVQ8lyjIx0sde5ckGM4iuhBGpd0jLy8Lhx7au0ye3m2wPDq1NWhdOh
         mPCthEtxaik45A1TPK+Q/iL2eEqU9c+ChQQWzjHyEDJHpUAmJVBpik7g+imSPVRLkR
         i3hNdJCJIQVOBzJWUUhljMHGREq+MftnxME9s69m03aA2P0OLfYiATOwq0KP+Eiz5o
         fYuqrB5739feZT2N6S9alymrDNiITXGAj+Zb9ubHdmQ+x05WeDR44NsZnWylPqvr8v
         fAEimAm5NZM/Q==
Received: by mail-ej1-f42.google.com with SMTP id y9so5115032ejp.10
        for <linux-kernel@vger.kernel.org>; Wed, 10 Feb 2021 08:09:59 -0800 (PST)
X-Gm-Message-State: AOAM532MR10sQauHhu67LqR7bxUzlfBP5ZrX5UTF7rVfXwzsC/IbywKz
        9Z5s5WOPZixTtpTCVOJkRQ8eTdXjWlYOr8+v10lvLw==
X-Google-Smtp-Source: ABdhPJyTgQ6foi+FhtPesOcGnNrjqZCS9eHuiG/0PuajOqAwU/l/X1qj8nAmwHBM5mFE3NMtKBVKxamemJYxyeMpjn0=
X-Received: by 2002:a17:906:b09a:: with SMTP id x26mr3691344ejy.199.1612973397900;
 Wed, 10 Feb 2021 08:09:57 -0800 (PST)
MIME-Version: 1.0
References: <cover.1612924255.git.luto@kernel.org> <8969c688ee663e99901cf4b0383bc6662ce79707.1612924255.git.luto@kernel.org>
 <CALCETrW8m-4AG4aZUYx35p0kc2aWiUq4p-WCs0+BOtb3WWE3aA@mail.gmail.com> <20210210132928.GB14650@zn.tnic>
In-Reply-To: <20210210132928.GB14650@zn.tnic>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Wed, 10 Feb 2021 08:09:45 -0800
X-Gmail-Original-Message-ID: <CALCETrXYBSsgqe4ANqZWWC6ziuoWT6KPLOz+ZCCVGGG5qWjO3Q@mail.gmail.com>
Message-ID: <CALCETrXYBSsgqe4ANqZWWC6ziuoWT6KPLOz+ZCCVGGG5qWjO3Q@mail.gmail.com>
Subject: Re: [PATCH v2 08/14] x86/fault: Skip erratum #93 workaround on new CPUs
To:     Borislav Petkov <bp@alien8.de>
Cc:     Andy Lutomirski <luto@kernel.org>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Yonghong Song <yhs@fb.com>,
        Masami Hiramatsu <mhiramat@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 10, 2021 at 5:29 AM Borislav Petkov <bp@alien8.de> wrote:
>
> On Tue, Feb 09, 2021 at 10:06:02PM -0800, Andy Lutomirski wrote:
> > On Tue, Feb 9, 2021 at 6:33 PM Andy Lutomirski <luto@kernel.org> wrote:
> > >
> > > Erratum #93 applies to the first generation of AMD K8 CPUs.  Skip the
> > > workaround on newer CPUs.
> >
> > Whoops, this breaks the !CPU_SUP_AMD build.  It needs a fixup like this:
> >
> > https://git.kernel.org/pub/scm/linux/kernel/git/luto/linux.git/commit/?h=x86/fault&id=06772a3b6918bf6d6d0778946149b7d56ae30d80
> >
> > Boris, do you want a v3?
>
> Do we even want to apply patch 8 at all? This has always ran on K8 NPT
> CPUs too and those are pretty much obsolete by now so I'm thinking,
> leave sleeping dogs lie...?

I think we do want this patch.  Without it, there's a fairly sizeable
range of bogus RIP values that will result in applying the fixup
instead of properly oopsing, even on new CPUs.
