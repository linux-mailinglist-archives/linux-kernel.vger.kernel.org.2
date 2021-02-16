Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A180E31D2D5
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Feb 2021 23:49:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231285AbhBPWs6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Feb 2021 17:48:58 -0500
Received: from mail2.protonmail.ch ([185.70.40.22]:16912 "EHLO
        mail2.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229722AbhBPWs4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Feb 2021 17:48:56 -0500
Date:   Tue, 16 Feb 2021 22:48:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me; s=protonmail;
        t=1613515692; bh=qIkeq0EmUbgFJre2aLRfF/Ecx0jyZANhITMmHKF8p+I=;
        h=Date:To:From:Cc:Reply-To:Subject:From;
        b=VZyOwjrT+kdZOFbsonNpI3erUtx4gWiY605NhB/gnHlfEVH6FAzzMwk76i0qI8va9
         RGVVJ6aMMKRYvDG3dAgq8gUPllIVfIXPTUmJjqzlrA8SGa5/jy+Ec19Kj738KogHDs
         xRTzCJww2QW5XwPBEQg7oQrbK5C9YgCLRvkMM7E+TjmoZHw7qEwGIYYxXQ4/vNdYwF
         OnNBZOkIeL9faWzMaif3yONhFEsj1JqXvpvOr3ZiNrrct5Y6fUJtBgBh62mZNWhAbL
         2UjJHqMaXz2N6yxYCshaxmxNbkwHlBOhPJCicDDMG1aESBVAwv2ihIAGBqMtV2ic4C
         tZkoF49fdb3Sw==
To:     Kees Cook <keescook@chromium.org>
From:   Alexander Lobakin <alobakin@pm.me>
Cc:     Alexander Lobakin <alobakin@pm.me>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Bill Wendling <morbo@google.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        George Burgess IV <gbiv@google.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Will Deacon <will@kernel.org>
Reply-To: Alexander Lobakin <alobakin@pm.me>
Subject: Re: [GIT PULL] clang-lto for v5.12-rc1
Message-ID: <20210216224751.7367-1-alobakin@pm.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.2 required=10.0 tests=ALL_TRUSTED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF shortcircuit=no
        autolearn=disabled version=3.4.4
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on
        mailout.protonmail.ch
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kees Cook <keescook@chromium.org>
Date: Tue, 16 Feb 2021 12:34:37 -0800

> Hi Linus,
>=20
> Please pull this Clang Link Time Optimization series for v5.12-rc1. This
> has been in linux-next for the entire last development cycle, and is
> built on the work done preparing[0] for LTO by arm64 folks, tracing folks=
,
> etc. This series includes the core changes as well as the remaining piece=
s
> for arm64 (LTO has been the default build method on Android for about
> 3 years now, as it is the prerequisite for the Control Flow Integrity
> protections). While x86 LTO support is done[1], there is still some
> on-going clean-up work happening for objtool[2] that should hopefully
> land by the v5.13 merge window.
>=20
> For merge log posterity, and as detailed in commit dc5723b02e52 ("kbuild:
> add support for Clang LTO"), here is the lt;dr to do an LTO build:
>=20
> =09make LLVM=3D1 LLVM_IAS=3D1 defconfig
> =09scripts/config -e LTO_CLANG_THIN
> =09make LLVM=3D1 LLVM_IAS=3D1
>=20
> (To do a cross-compile of arm64, add "CROSS_COMPILE=3Daarch64-linux-gnu-"
> and "ARCH=3Darm64" to the "make" command lines.)
>=20
> Thanks!
>=20
> -Kees
>=20
> [0] https://git.kernel.org/linus/3c09ec59cdea5b132212d97154d625fd34e436dd
> [1] https://github.com/samitolvanen/linux/commits/clang-lto
> [2] https://lore.kernel.org/lkml/cover.1611263461.git.jpoimboe@redhat.com=
/
>=20
> The following changes since commit e71ba9452f0b5b2e8dc8aa5445198cd9214a6a=
62:
>=20
>   Linux 5.11-rc2 (2021-01-03 15:55:30 -0800)
>=20
> are available in the Git repository at:
>=20
>   https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/cla=
ng-lto-v5.12-rc1
>=20
> for you to fetch changes up to 112b6a8e038d793d016e330f53acb9383ac504b3:
>=20
>   arm64: allow LTO to be selected (2021-01-14 08:21:10 -0800)
>=20
> ----------------------------------------------------------------
> clang-lto for v5.12-rc1
>=20
> Provide build infrastructure for arm64 Clang LTO.
>=20
> ----------------------------------------------------------------
> Sami Tolvanen (16):
>       tracing: move function tracer options to Kconfig
>       kbuild: add support for Clang LTO
>       kbuild: lto: fix module versioning
>       kbuild: lto: limit inlining
>       kbuild: lto: merge module sections
>       kbuild: lto: add a default list of used symbols
>       init: lto: ensure initcall ordering
>       init: lto: fix PREL32 relocations
>       PCI: Fix PREL32 relocations for LTO
>       modpost: lto: strip .lto from module names
>       scripts/mod: disable LTO for empty.c
>       efi/libstub: disable LTO
>       drivers/misc/lkdtm: disable LTO for rodata.o
>       arm64: vdso: disable LTO
>       arm64: disable recordmcount with DYNAMIC_FTRACE_WITH_REGS
>       arm64: allow LTO to be selected

Seems like you forgot the fix from [0], didn't you?

>  .gitignore                            |   1 +
>  Makefile                              |  45 ++++--
>  arch/Kconfig                          |  90 ++++++++++++
>  arch/arm64/Kconfig                    |   4 +
>  arch/arm64/kernel/vdso/Makefile       |   3 +-
>  drivers/firmware/efi/libstub/Makefile |   2 +
>  drivers/misc/lkdtm/Makefile           |   1 +
>  include/asm-generic/vmlinux.lds.h     |  11 +-
>  include/linux/init.h                  |  79 ++++++++--
>  include/linux/pci.h                   |  27 +++-
>  init/Kconfig                          |   1 +
>  kernel/trace/Kconfig                  |  16 ++
>  scripts/Makefile.build                |  48 +++++-
>  scripts/Makefile.lib                  |   6 +-
>  scripts/Makefile.modfinal             |   9 +-
>  scripts/Makefile.modpost              |  25 +++-
>  scripts/generate_initcall_order.pl    | 270 ++++++++++++++++++++++++++++=
++++++
>  scripts/link-vmlinux.sh               |  70 +++++++--
>  scripts/lto-used-symbollist.txt       |   5 +
>  scripts/mod/Makefile                  |   1 +
>  scripts/mod/modpost.c                 |  16 +-
>  scripts/mod/modpost.h                 |   9 ++
>  scripts/mod/sumversion.c              |   6 +-
>  scripts/module.lds.S                  |  24 +++
>  24 files changed, 707 insertions(+), 62 deletions(-)
>  create mode 100755 scripts/generate_initcall_order.pl
>  create mode 100644 scripts/lto-used-symbollist.txt
>=20
> --=20
> Kees Cook
>=20

[0] https://lore.kernel.org/lkml/20210121184544.659998-1-alobakin@pm.me

Al

