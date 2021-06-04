Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DBC739BFF6
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Jun 2021 20:56:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230302AbhFDS6Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Jun 2021 14:58:16 -0400
Received: from mail-lj1-f174.google.com ([209.85.208.174]:33663 "EHLO
        mail-lj1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229810AbhFDS6P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jun 2021 14:58:15 -0400
Received: by mail-lj1-f174.google.com with SMTP id o8so12891212ljp.0
        for <linux-kernel@vger.kernel.org>; Fri, 04 Jun 2021 11:56:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MAY7KM/K0wP2g2AnxgxdYeWiUARA3nmMx/CzXqNh5J8=;
        b=ILKJc/Mav+UPrVq/nRH3LXx5XPRG4deEPpGqPf0OLbxHbhYbvIWD/nVaHVVo/0TKu0
         s9pBx2hwEFZ7GqyXhTa78xIoF5sYlpyM608nf/SIkgZa7bPVxqPszqJxCdQXXXNa1DyY
         /QNzow1odGMNaN9fHmSPR6WtoRzo9cTfUK3Bu7A4FvmTmhSB6aAVte85eheGTcQZ+ib9
         OERYSFMlsC25mo1f9HXpX8XvUk1Cek2HAV+ymRj/rIxV1BsXGhmm3xSMj4lLqkGM1TVa
         fofIMGv/yK3ZOD7YISxMitNtPUydzIIxANR65nc68i/mDh/DJaK8arbKunf+8pAUPpUz
         s/tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MAY7KM/K0wP2g2AnxgxdYeWiUARA3nmMx/CzXqNh5J8=;
        b=r0OXk1r4fqpOZh9BVvIlBHQIiKUBbL8fdYCnSg18bhwDUbX/UkaYxDTyq31pPmVkV/
         +vH9w8vb9BgeMSxxkfYKcMazbe+57eSGzvUJg9gboUG1gutA2WHeUlH/0Sinrxy/vFpY
         k2q130jzx/4uT13xjUtNW45TgY46E+G4GVJsGnSoYUvPwqOACT/M+lVqZ3UUTe1ao6y+
         IN7QL3aIzDOYwJjg56rlYurVqdzHD/1Zubb1PD3EgKUDZ/XjDYkPSxjG3w1NUSzO5EYj
         7qgPjR6Ph+vhv9oIz7YoigSeZqYn3s9BD7vSU+L+/wbz04yzua2NuFBfJGhOit5eNCsb
         A5nQ==
X-Gm-Message-State: AOAM531zx/O06g1woB1EZNaD0Wkca2kxckS8NLYUj/3fn8TRnSDFpoUG
        sixZI0wFuuHR3QwOnL6hgbYs4qXHmPcvFD+S6f9W8A==
X-Google-Smtp-Source: ABdhPJxl5/Re/Rr0Zge/fNM8dXYYUz70xFkk3awqJRm9fa8erhejah5WI9ZmMJkR6yJCNW529LV8pKaCUXDTZ3w3LLs=
X-Received: by 2002:a2e:b6d2:: with SMTP id m18mr4278071ljo.233.1622832916471;
 Fri, 04 Jun 2021 11:55:16 -0700 (PDT)
MIME-Version: 1.0
References: <CAK7LNAS_LpZnweujqVwZ1kL0eDYR726k35U_yx1djqNE0bk6Rw@mail.gmail.com>
 <20210522012626.2811297-1-ndesaulniers@google.com> <20210526170904.GB19831@willie-the-truck>
In-Reply-To: <20210526170904.GB19831@willie-the-truck>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Fri, 4 Jun 2021 11:55:04 -0700
Message-ID: <CAKwvOd=Ah8LL2XDXQE9=t1hGNTxfeGEmVkVdhUBoQ5P_9eAWhA@mail.gmail.com>
Subject: Re: [PATCH v2] Makefile: fix GDB warning with CONFIG_RELR
To:     Will Deacon <will@kernel.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Lee Jones <lee.jones@linaro.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Fangrui Song <maskray@google.com>,
        Elliot Berman <eberman@quicinc.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        Peter Collingbourne <pcc@google.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Nathan Chancellor <nathan@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 26, 2021 at 10:09 AM Will Deacon <will@kernel.org> wrote:
>
> On Fri, May 21, 2021 at 06:26:24PM -0700, Nick Desaulniers wrote:
> > GDB produces the following warning when debugging kernels built with
> > CONFIG_RELR:
> >
> > BFD: /android0/linux-next/vmlinux: unknown type [0x13] section `.relr.dyn'
> >
> > when loading a kernel built with CONFIG_RELR into GDB. It can also
> > prevent debugging symbols using such relocations.
> >
> > Peter sugguests:
> >   [That flag] means that lld will use dynamic tags and section type
> >   numbers in the OS-specific range rather than the generic range. The
> >   kernel itself doesn't care about these numbers; it determines the
> >   location of the RELR section using symbols defined by a linker script.
> >
> > Link: https://github.com/ClangBuiltLinux/linux/issues/1057
> > Suggested-by: Peter Collingbourne <pcc@google.com>
> > Reviewed-by: Nathan Chancellor <nathan@kernel.org>
> > Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
> > ---
> > Changes V1 -> V2:
> > * rebase
> > * pick up Nathan's reviewed by tag.
> >
> >  Makefile                      | 2 +-
> >  scripts/tools-support-relr.sh | 3 ++-
> >  2 files changed, 3 insertions(+), 2 deletions(-)
>
> Does lld support RELR relocations for any architectures other than arm64? If

Yes; from what I can tell it's not an architecture specific relocation
type. Combing through LLVM's sources, it seems Fuchsia sets it always
(at least when using lld) and I'm pretty sure they support x86.  At
least I don't get any errors out of LLD when building with
--pack-dyn-relocs=relr on x86.

I can force on RELR for x86 kernel builds with:
```
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 0045e1b44190..513272c77827 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -2117,6 +2117,7 @@ config PHYSICAL_START

 config RELOCATABLE
        bool "Build a relocatable kernel"
+       select ARCH_HAS_RELR
        default y
        help
          This builds a kernel image that retains relocation information
```
That builds (it won't boot because we don't have the machinery in the
kernel to self relocate that type, yet).

> so, is the "--use-android-relr-tags" option supported on all of those as
> well?

I believe so; no issues building with this patch and with the above
diff applied on x86. All that flag does is change the elf section type
from SHT_RELR to SHT_ANDROID_RELR.

pcc@ can correct me if I'm wrong.
-- 
Thanks,
~Nick Desaulniers
