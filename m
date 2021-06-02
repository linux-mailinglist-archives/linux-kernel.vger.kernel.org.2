Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14BED399391
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 21:34:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229702AbhFBTfl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 15:35:41 -0400
Received: from mail-pl1-f169.google.com ([209.85.214.169]:42639 "EHLO
        mail-pl1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229586AbhFBTfh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 15:35:37 -0400
Received: by mail-pl1-f169.google.com with SMTP id v13so1623067ple.9
        for <linux-kernel@vger.kernel.org>; Wed, 02 Jun 2021 12:33:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=4e1fH+i/4Nf38IYF0J8GBj+xdjCqFkdwdWN2L+YElMY=;
        b=Ne32eZA/sGKOBjJXF16uA1Y7T7rMhnXh2Ziva3sUZQP7FIVtan8BXlbrdVQNOmpa4p
         mo/McA3nj5bdJ8g+VPCr8ob3beUa2nLTODFoxdssvqecrarIo41wLITRf0AJXYuPjaQ1
         ue/xanHzLqGBHkNJaokCOOu1NKQaUL25OIc0E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=4e1fH+i/4Nf38IYF0J8GBj+xdjCqFkdwdWN2L+YElMY=;
        b=dc7AGA/JC1XatcqtlccScAkDlXlMgwrAL6CVPXyyhmnMhOiIxhvGcFd/hKNqmMNbI8
         npwhEyRAr7q6SzY2HfB5aDm4icNTnIx99X733KkdsohRZxuJs4IftZ3yul4rp3q3MLgi
         N/Nij/aNO+SAQx+FZsGct0s0/otEi9JjUFc2OSq9HR7VUgOv1LHQvE+p6O/Fp24FM0eC
         zj4WMoOFM2wFTipkiEVkaY7b8krrXiKeOqGQuxVz6BGjbJr1l3lgZ2Ht6WAczFzw+C8P
         E/97mSobAwXP64Ln9kTNUWvLF3wBLbk454i5h7ffAWDM45hEk23Q51NPYhtGgjDylPat
         lbDQ==
X-Gm-Message-State: AOAM531c/iSAQritgxw0iegoIyYrrNqffzqUXSoACciMiDkiGOrxfKG6
        ZAX13GU7mv1w7kzgyZy67e8MVQ==
X-Google-Smtp-Source: ABdhPJzjgGtjqvUgiVc2BReU2BmJawBbl2m8YPOEjnFEOGPI2Ik7hFRqbL7Rng0mBo3lXOCsMHkAfQ==
X-Received: by 2002:a17:90a:f304:: with SMTP id ca4mr27502271pjb.177.1622662361679;
        Wed, 02 Jun 2021 12:32:41 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id u23sm31828pgk.38.2021.06.02.12.32.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jun 2021 12:32:41 -0700 (PDT)
Date:   Wed, 2 Jun 2021 12:32:40 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Arnd Bergmann <arnd@kernel.org>, Fangrui Song <maskray@google.com>,
        Will Deacon <will@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        David Brazdil <dbrazdil@google.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] arm64: vmlinux.lds.S: keep .entry.tramp.text section
Message-ID: <202106021231.A1B7A10@keescook>
References: <20210226140352.3477860-1-arnd@kernel.org>
 <202102261256.AF256702@keescook>
 <20210227043257.k3aernmnzsvitp7c@google.com>
 <20210316104530.GA7309@arm.com>
 <20210316162745.GA20565@arm.com>
 <CAK8P3a07nPbbP095LJ84Z5hP3Ce53fb_+0Zav8PUA+7R_92gMw@mail.gmail.com>
 <20210316190921.GB28565@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210316190921.GB28565@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 16, 2021 at 07:09:23PM +0000, Catalin Marinas wrote:
> On Tue, Mar 16, 2021 at 05:39:27PM +0100, Arnd Bergmann wrote:
> > On Tue, Mar 16, 2021 at 5:27 PM Catalin Marinas <catalin.marinas@arm.com> wrote:
> > > On Tue, Mar 16, 2021 at 10:45:32AM +0000, Catalin Marinas wrote:
> > > > On Fri, Feb 26, 2021 at 08:32:57PM -0800, Fangrui Song wrote:
> > > > > On 2021-02-26, Kees Cook wrote:
> > > > > > On Fri, Feb 26, 2021 at 03:03:39PM +0100, Arnd Bergmann wrote:
> > > > > > > From: Arnd Bergmann <arnd@arndb.de>
> > > > > > >
> > > > > > > When building with CONFIG_LD_DEAD_CODE_DATA_ELIMINATION,
> > > > > > > I sometimes see an assertion
> > > > > > >
> > > > > > >  ld.lld: error: Entry trampoline text too big
> > > > > >
> > > > > > Heh, "too big" seems a weird report for having it discarded. :)
> > > > > >
> > > > > > Any idea on this Fangrui?
> > > > > >
> > > > > > ( I see this is https://github.com/ClangBuiltLinux/linux/issues/1311 )
> > > > >
> > > > > This diagnostic is from an ASSERT in arch/arm64/kernel/vmlinux.lds
> > > > >
> > > > >   ASSERT((__entry_tramp_text_end - __entry_tramp_text_start) == (1 << 16),
> > > > >    "Entry trampoline text too big")
> > > >
> > > > Can we not change the ASSERT to be <= PAGE_SIZE instead?
> > >
> > > Ah, that won't work as I suspect we still need the trampoline section.
> > >
> > > Arnd, do you know why this section disappears? I did a simple test with
> > > defconfig + LD_DEAD_CODE_DATA_ELIMINATION and the trampoline section is
> > > still around.
> > 
> > If I remember correctly, this showed up when CONFIG_ARM_SDE_INTERFACE
> > is disabled, which dropped the only reference into this section.
> > If that doesn't make sense, I can try digging through the old build logs to
> > reproduce the problem.
> 
> I suspected this as well but still worked for me when disabling it.
> 
> Anyway, I don't think identifying the exact option is necessary. With
> CONFIG_UNMAP_KERNEL_AT_EL0=y we need this section around even if only
> __entry_tramp_text_start/end are referenced.
> 
> In this case we happened to detect this issue because of the ASSERT in
> vmlinux.lds.S but I wonder what else the linker drops with this dead
> code elimination that we may not notice (it seems to remove about 500KB
> from the resulting image in my test).
> 
> I'll push these two patches to -next for wider coverage before deciding
> on mainline (though the option may not get much testing as it's hidden
> behind EXPERT and default n).

I don't see this in -next? Catalin, do you want me to pick it up as part
of my collecting various linker fixes?

-Kees

-- 
Kees Cook
