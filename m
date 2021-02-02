Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F18030B45F
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 02:04:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229872AbhBBBCm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 20:02:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:48792 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229554AbhBBBCl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 20:02:41 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id B9CF564EDE
        for <linux-kernel@vger.kernel.org>; Tue,  2 Feb 2021 01:02:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612227721;
        bh=FWrqTsy+RDdR4LtnRiT0C8ouxsmTWFMv+IV8m9NZyuo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=dmNQyrpFSmPJN7ludg46GbvNjRnYRCjSKD7nYX3tA0I09uM/N2LCHBEU44HVXb3ko
         MbiwNFh3OMeNupg73pPk3F0/Tzsr6GCyPz+jC1F7RxHZ6ijuEMjPgz8w6XJRE4wE8l
         RxxOILvfnIS0Wx/3wxsdbnTxF3U+YRsizKnKW8Gw/boM9Mat4ncBdGy4Si7+q4B0M7
         2oWZRUMwr9nC3igQlFwxEBRUGNkh2QPOxVib5VCW6rGE5gAGrN001k1DMz5W/fCpJd
         sGZfeiDMJF8RXA/QlarxeYsAgjQl8oSPJ1liFjy3F9mNYQwiFSODSErfI8OhLpyLmB
         ypuZOQzYo8q0A==
Received: by mail-ej1-f49.google.com with SMTP id p20so7969272ejb.6
        for <linux-kernel@vger.kernel.org>; Mon, 01 Feb 2021 17:02:00 -0800 (PST)
X-Gm-Message-State: AOAM531ANtNPjX+ntOoOYy2VWE95djJuxV2ogmm12wuFeloZYffW97Ox
        wQIq2WHCadZ1MsVyI9Ou4kcHtXxnzM0w41Ie2dLDSQ==
X-Google-Smtp-Source: ABdhPJw/UiI008dSLxzxjjYvSIDT2Xqg3ZcvhBP/sHuotZYCO0qVF1YvyWcr311rlgnVpe9t9U4XSf/XMFXv8NtYh5E=
X-Received: by 2002:a17:906:c824:: with SMTP id dd4mr18960828ejb.253.1612227719358;
 Mon, 01 Feb 2021 17:01:59 -0800 (PST)
MIME-Version: 1.0
References: <cover.1612113550.git.luto@kernel.org> <5b0ad34afeeee15032393367b0945a5032903162.1612113550.git.luto@kernel.org>
 <20210201091418.GC3229269@infradead.org>
In-Reply-To: <20210201091418.GC3229269@infradead.org>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Mon, 1 Feb 2021 17:01:48 -0800
X-Gmail-Original-Message-ID: <CALCETrVsZovppYs0GFk9rpfU_cPVuHc=-YvmW2P08EqWpDTL+Q@mail.gmail.com>
Message-ID: <CALCETrVsZovppYs0GFk9rpfU_cPVuHc=-YvmW2P08EqWpDTL+Q@mail.gmail.com>
Subject: Re: [PATCH 09/11] x86/fault: Rename no_context() to kernelmode_fixup_or_oops()
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Andy Lutomirski <luto@kernel.org>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Yonghong Song <yhs@fb.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 1, 2021 at 1:14 AM Christoph Hellwig <hch@infradead.org> wrote:
>
> On Sun, Jan 31, 2021 at 09:24:40AM -0800, Andy Lutomirski wrote:
> > +             kernelmode_fixup_or_oops(regs, error_code, address, pkey, si_code);
>
> >       if (!user_mode(regs)) {
> > -             no_context(regs, error_code, address, SIGBUS, BUS_ADRERR);
> > +             kernelmode_fixup_or_oops(regs, error_code, address, SIGBUS, BUS_ADRERR);
>
> These overly long lines are a little annoying..

It's not that long, and Linus seems to think you should make your
terminal wider :)

--Andy
