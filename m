Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBD6535B57A
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Apr 2021 15:56:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235814AbhDKNw2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Apr 2021 09:52:28 -0400
Received: from conssluserg-02.nifty.com ([210.131.2.81]:36145 "EHLO
        conssluserg-02.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235558AbhDKNwZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Apr 2021 09:52:25 -0400
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175]) (authenticated)
        by conssluserg-02.nifty.com with ESMTP id 13BDppYP012062;
        Sun, 11 Apr 2021 22:51:51 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-02.nifty.com 13BDppYP012062
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1618149111;
        bh=Oyb30frvoJSVJ4PA2guHZ4mc1w6P1MMIsqtUqyXN1qI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=AoA4k+SHDjVBGNsMge6saSW+YFw10VzVGw1K4uf1qCh/DX4ahraNV2StPItKZYu9s
         M+sOnNaLy3XL9llQCChZRX4sOp9doLyVGEyJYAOFgOFMOBwN+u0567NsOV6pGnAqng
         xgC82BlQVl/EhfW/5EGJAdKGgQSvd7RXTcYF3xFk2Cq2SiWlCS6xYa+J9k+DKoc4BL
         ysbswwHdyrOCswpsfr3qZdg1mcWOs7omEgcg8VrKl3WjkScl6FSXEa0uzhvREDcyaL
         D0Z9pEZ+46qJpm6vxBFYBbELEhLq5Vtd702U+9fFxyOfmwTnjlN5kzinPGxmoLqxH2
         YDjXeD/47zmkg==
X-Nifty-SrcIP: [209.85.214.175]
Received: by mail-pl1-f175.google.com with SMTP id y2so4952547plg.5;
        Sun, 11 Apr 2021 06:51:51 -0700 (PDT)
X-Gm-Message-State: AOAM532gcIcglvN/AAHGBypQm1A5JSmCr3P+FBlleZijSuVbuq7Mm9cH
        jtnDbwxjj2nXuvPiByXHozOizstrPRhYWUyy7zo=
X-Google-Smtp-Source: ABdhPJz2+27GG355vfAeOiMfDu8f8zi/pbFEOBa2SaEuW3UZLd+f3WWeJewJ9iWDmnS4NKDSueQw9GThh6DkzRSugeI=
X-Received: by 2002:a17:902:b589:b029:e6:2875:aa4c with SMTP id
 a9-20020a170902b589b02900e62875aa4cmr21888112pls.71.1618149110440; Sun, 11
 Apr 2021 06:51:50 -0700 (PDT)
MIME-Version: 1.0
References: <20210301141827.342315-1-masahiroy@kernel.org>
In-Reply-To: <20210301141827.342315-1-masahiroy@kernel.org>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Sun, 11 Apr 2021 22:51:12 +0900
X-Gmail-Original-Message-ID: <CAK7LNARA9PZ_hv76FDn_LHE-JpOepdLW1w5=0_J6AckigX76HA@mail.gmail.com>
Message-ID: <CAK7LNARA9PZ_hv76FDn_LHE-JpOepdLW1w5=0_J6AckigX76HA@mail.gmail.com>
Subject: Re: [PATCH 1/2] alpha: syscalls: switch to generic syscalltbl.sh
To:     Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>, linux-alpha@vger.kernel.org
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 1, 2021 at 11:18 PM Masahiro Yamada <masahiroy@kernel.org> wrote:
>
> Many architectures duplicate similar shell scripts.
>
> This commit converts alpha to use scripts/syscalltbl.sh.
>
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>

Applied to linux-kbuild.


> ---
>
>  arch/alpha/kernel/syscalls/Makefile      |  7 ++----
>  arch/alpha/kernel/syscalls/syscalltbl.sh | 32 ------------------------
>  arch/alpha/kernel/systbls.S              |  3 +--
>  3 files changed, 3 insertions(+), 39 deletions(-)
>  delete mode 100644 arch/alpha/kernel/syscalls/syscalltbl.sh
>
> diff --git a/arch/alpha/kernel/syscalls/Makefile b/arch/alpha/kernel/syscalls/Makefile
> index 285aaba832d9..ad2492cb5568 100644
> --- a/arch/alpha/kernel/syscalls/Makefile
> +++ b/arch/alpha/kernel/syscalls/Makefile
> @@ -7,7 +7,7 @@ _dummy := $(shell [ -d '$(uapi)' ] || mkdir -p '$(uapi)')       \
>
>  syscall := $(src)/syscall.tbl
>  syshdr := $(srctree)/$(src)/syscallhdr.sh
> -systbl := $(srctree)/$(src)/syscalltbl.sh
> +systbl := $(srctree)/scripts/syscalltbl.sh
>
>  quiet_cmd_syshdr = SYSHDR  $@
>        cmd_syshdr = $(CONFIG_SHELL) '$(syshdr)' '$<' '$@'       \
> @@ -16,10 +16,7 @@ quiet_cmd_syshdr = SYSHDR  $@
>                    '$(syshdr_offset_$(basetarget))'
>
>  quiet_cmd_systbl = SYSTBL  $@
> -      cmd_systbl = $(CONFIG_SHELL) '$(systbl)' '$<' '$@'       \
> -                  '$(systbl_abis_$(basetarget))'               \
> -                  '$(systbl_abi_$(basetarget))'                \
> -                  '$(systbl_offset_$(basetarget))'
> +      cmd_systbl = $(CONFIG_SHELL) $(systbl) $< $@
>
>  $(uapi)/unistd_32.h: $(syscall) $(syshdr) FORCE
>         $(call if_changed,syshdr)
> diff --git a/arch/alpha/kernel/syscalls/syscalltbl.sh b/arch/alpha/kernel/syscalls/syscalltbl.sh
> deleted file mode 100644
> index 85d78d9309ad..000000000000
> --- a/arch/alpha/kernel/syscalls/syscalltbl.sh
> +++ /dev/null
> @@ -1,32 +0,0 @@
> -#!/bin/sh
> -# SPDX-License-Identifier: GPL-2.0
> -
> -in="$1"
> -out="$2"
> -my_abis=`echo "($3)" | tr ',' '|'`
> -my_abi="$4"
> -offset="$5"
> -
> -emit() {
> -       t_nxt="$1"
> -       t_nr="$2"
> -       t_entry="$3"
> -
> -       while [ $t_nxt -lt $t_nr ]; do
> -               printf "__SYSCALL(%s, sys_ni_syscall, )\n" "${t_nxt}"
> -               t_nxt=$((t_nxt+1))
> -       done
> -       printf "__SYSCALL(%s, %s, )\n" "${t_nxt}" "${t_entry}"
> -}
> -
> -grep -E "^[0-9A-Fa-fXx]+[[:space:]]+${my_abis}" "$in" | sort -n | (
> -       nxt=0
> -       if [ -z "$offset" ]; then
> -               offset=0
> -       fi
> -
> -       while read nr abi name entry ; do
> -               emit $((nxt+offset)) $((nr+offset)) $entry
> -               nxt=$((nr+1))
> -       done
> -) > "$out"
> diff --git a/arch/alpha/kernel/systbls.S b/arch/alpha/kernel/systbls.S
> index 9704f22ed5e3..68f3e4f329eb 100644
> --- a/arch/alpha/kernel/systbls.S
> +++ b/arch/alpha/kernel/systbls.S
> @@ -7,10 +7,9 @@
>
>  #include <asm/unistd.h>
>
> -#define __SYSCALL(nr, entry, nargs) .quad entry
> +#define __SYSCALL(nr, entry) .quad entry
>         .data
>         .align 3
>         .globl sys_call_table
>  sys_call_table:
>  #include <asm/syscall_table.h>
> -#undef __SYSCALL
> --
> 2.27.0
>


-- 
Best Regards
Masahiro Yamada
