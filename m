Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F52F316807
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 14:30:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230235AbhBJNaU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 08:30:20 -0500
Received: from mail.skyhub.de ([5.9.137.197]:56348 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229465AbhBJNaP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 08:30:15 -0500
Received: from zn.tnic (p200300ec2f037400315ea78552594295.dip0.t-ipconnect.de [IPv6:2003:ec:2f03:7400:315e:a785:5259:4295])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 2BC3F1EC04A9;
        Wed, 10 Feb 2021 14:29:31 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1612963771;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=5alnFyQqfewF64h4BDFj4Y6OzUELAoQQee6RKH78b38=;
        b=ETRoW+2aEhtNAAnK6ndPfin9XSbWzlEFbMwFZvbpz58zKfvMI65k8/nhzPk644m3RbKNl6
        Jrn6AZy22YRmZiz4JWCh20yb9I063RJQiAqTqew00xvcE+/SYjga05tjDg2oNsrLJisJNm
        P8ElG4uPcI8E4jHVfW53OcNrnhUdWaQ=
Date:   Wed, 10 Feb 2021 14:29:28 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Yonghong Song <yhs@fb.com>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [PATCH v2 08/14] x86/fault: Skip erratum #93 workaround on new
 CPUs
Message-ID: <20210210132928.GB14650@zn.tnic>
References: <cover.1612924255.git.luto@kernel.org>
 <8969c688ee663e99901cf4b0383bc6662ce79707.1612924255.git.luto@kernel.org>
 <CALCETrW8m-4AG4aZUYx35p0kc2aWiUq4p-WCs0+BOtb3WWE3aA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CALCETrW8m-4AG4aZUYx35p0kc2aWiUq4p-WCs0+BOtb3WWE3aA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 09, 2021 at 10:06:02PM -0800, Andy Lutomirski wrote:
> On Tue, Feb 9, 2021 at 6:33 PM Andy Lutomirski <luto@kernel.org> wrote:
> >
> > Erratum #93 applies to the first generation of AMD K8 CPUs.  Skip the
> > workaround on newer CPUs.
> 
> Whoops, this breaks the !CPU_SUP_AMD build.  It needs a fixup like this:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/luto/linux.git/commit/?h=x86/fault&id=06772a3b6918bf6d6d0778946149b7d56ae30d80
> 
> Boris, do you want a v3?

Do we even want to apply patch 8 at all? This has always ran on K8 NPT
CPUs too and those are pretty much obsolete by now so I'm thinking,
leave sleeping dogs lie...?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
