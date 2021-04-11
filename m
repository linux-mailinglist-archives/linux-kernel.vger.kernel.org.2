Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB3C935B45F
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Apr 2021 15:16:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235462AbhDKMwp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Apr 2021 08:52:45 -0400
Received: from conssluserg-03.nifty.com ([210.131.2.82]:56482 "EHLO
        conssluserg-03.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229804AbhDKMwo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Apr 2021 08:52:44 -0400
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172]) (authenticated)
        by conssluserg-03.nifty.com with ESMTP id 13BCq9Nc029013
        for <linux-kernel@vger.kernel.org>; Sun, 11 Apr 2021 21:52:09 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-03.nifty.com 13BCq9Nc029013
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1618145530;
        bh=KysGK8ii+KjNMVGt48jKTBvOxWm5/Buxc9UMo0jZoFo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=kjqVhb62z5+/DtDzgBw2Ts5dZYSXO93tpvFUclhBH1BdDQodq9OwdS+1FOyaJ5EG1
         0jMKJx6VEJJLYsJYjkyeOq/VRJQBhDePeNn+oOuMBczu69CfcNtrSuZMhkP8P9K3qj
         1ks3ISt07eFaqMg0H/jv4rWkyo+ySWhS4YqpE04AjyfZ+5Dsi3J1Mewzg28mIq55Qs
         H7hcaY28kjtVrMBdXsXk69OHd12j4XDvlEa+lxpJAQAA2q+6TG3bagUSTES2qdQCQh
         nb4b8GQRVFGBoXou0jLTldeHdIJTonPebLxabUfXsT979MCrMvhkqJjZ31McZTBm1/
         PTh819ezYZYCQ==
X-Nifty-SrcIP: [209.85.210.172]
Received: by mail-pf1-f172.google.com with SMTP id l123so7368457pfl.8
        for <linux-kernel@vger.kernel.org>; Sun, 11 Apr 2021 05:52:09 -0700 (PDT)
X-Gm-Message-State: AOAM5318qNHle5Solk3X7DMz6d3Ctz/pHIVInfcOYU/lDg/dy10URKi5
        TArE7yjxDaRD4Dn3e92oJQnWt6IZ6+K3nBtIXYg=
X-Google-Smtp-Source: ABdhPJw9I2+YhS5Pf4UUWoDElp1ktj7We1LdFeVFiGQtC8pyYagcQUpA/NBCwoLwG3cOGVunk55XIA4AqC1FT1Qnxu4=
X-Received: by 2002:a63:e044:: with SMTP id n4mr11279209pgj.47.1618145529032;
 Sun, 11 Apr 2021 05:52:09 -0700 (PDT)
MIME-Version: 1.0
References: <20210301153019.362742-1-masahiroy@kernel.org>
In-Reply-To: <20210301153019.362742-1-masahiroy@kernel.org>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Sun, 11 Apr 2021 21:51:31 +0900
X-Gmail-Original-Message-ID: <CAK7LNATUgS+5Qo8hWizQUtFWx7Fqst48qETz0fRQjTKPP5FuxQ@mail.gmail.com>
Message-ID: <CAK7LNATUgS+5Qo8hWizQUtFWx7Fqst48qETz0fRQjTKPP5FuxQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] powerpc: syscalls: switch to generic syscalltbl.sh
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>, Ben Gardon <bgardon@google.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Michal Suchanek <msuchanek@suse.de>,
        Nicholas Piggin <npiggin@gmail.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Sean Christopherson <seanjc@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Michael,

On Tue, Mar 2, 2021 at 12:31 AM Masahiro Yamada <masahiroy@kernel.org> wrote:
>
> Many architectures duplicate similar shell scripts.
>
> This commit converts powerpc to use scripts/syscalltbl.sh. This also
> unifies syscall_table_32.h and syscall_table_c32.h.
>
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>


Could you check this series?

Thanks.
Masahiro


> ---
>
>  arch/powerpc/include/asm/Kbuild             |  1 -
>  arch/powerpc/kernel/syscalls/Makefile       | 22 +++----------
>  arch/powerpc/kernel/syscalls/syscalltbl.sh  | 36 ---------------------
>  arch/powerpc/kernel/systbl.S                |  5 ++-
>  arch/powerpc/platforms/cell/spu_callbacks.c |  2 +-
>  5 files changed, 10 insertions(+), 56 deletions(-)
>  delete mode 100644 arch/powerpc/kernel/syscalls/syscalltbl.sh
>
> diff --git a/arch/powerpc/include/asm/Kbuild b/arch/powerpc/include/asm/Kbuild
> index e1f9b4ea1c53..bcf95ce0964f 100644
> --- a/arch/powerpc/include/asm/Kbuild
> +++ b/arch/powerpc/include/asm/Kbuild
> @@ -1,7 +1,6 @@
>  # SPDX-License-Identifier: GPL-2.0
>  generated-y += syscall_table_32.h
>  generated-y += syscall_table_64.h
> -generated-y += syscall_table_c32.h
>  generated-y += syscall_table_spu.h
>  generic-y += export.h
>  generic-y += kvm_types.h
> diff --git a/arch/powerpc/kernel/syscalls/Makefile b/arch/powerpc/kernel/syscalls/Makefile
> index 9e3be295dbba..df21c731c806 100644
> --- a/arch/powerpc/kernel/syscalls/Makefile
> +++ b/arch/powerpc/kernel/syscalls/Makefile
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
> +      cmd_systbl = $(CONFIG_SHELL) $(systbl) --abis $(abis) $< $@
>
>  syshdr_abis_unistd_32 := common,nospu,32
>  $(uapi)/unistd_32.h: $(syscall) $(syshdr) FORCE
> @@ -29,30 +26,21 @@ syshdr_abis_unistd_64 := common,nospu,64
>  $(uapi)/unistd_64.h: $(syscall) $(syshdr) FORCE
>         $(call if_changed,syshdr)
>
> -systbl_abis_syscall_table_32 := common,nospu,32
> -systbl_abi_syscall_table_32 := 32
> +$(kapi)/syscall_table_32.h: abis := common,nospu,32
>  $(kapi)/syscall_table_32.h: $(syscall) $(systbl) FORCE
>         $(call if_changed,systbl)
>
> -systbl_abis_syscall_table_64 := common,nospu,64
> -systbl_abi_syscall_table_64 := 64
> +$(kapi)/syscall_table_64.h: abis := common,nospu,64
>  $(kapi)/syscall_table_64.h: $(syscall) $(systbl) FORCE
>         $(call if_changed,systbl)
>
> -systbl_abis_syscall_table_c32 := common,nospu,32
> -systbl_abi_syscall_table_c32 := c32
> -$(kapi)/syscall_table_c32.h: $(syscall) $(systbl) FORCE
> -       $(call if_changed,systbl)
> -
> -systbl_abis_syscall_table_spu := common,spu
> -systbl_abi_syscall_table_spu := spu
> +$(kapi)/syscall_table_spu.h: abis := common,spu
>  $(kapi)/syscall_table_spu.h: $(syscall) $(systbl) FORCE
>         $(call if_changed,systbl)
>
>  uapisyshdr-y           += unistd_32.h unistd_64.h
>  kapisyshdr-y           += syscall_table_32.h           \
>                            syscall_table_64.h           \
> -                          syscall_table_c32.h          \
>                            syscall_table_spu.h
>
>  uapisyshdr-y   := $(addprefix $(uapi)/, $(uapisyshdr-y))
> diff --git a/arch/powerpc/kernel/syscalls/syscalltbl.sh b/arch/powerpc/kernel/syscalls/syscalltbl.sh
> deleted file mode 100644
> index f7393a7b18aa..000000000000
> --- a/arch/powerpc/kernel/syscalls/syscalltbl.sh
> +++ /dev/null
> @@ -1,36 +0,0 @@
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
> -               printf "__SYSCALL(%s,sys_ni_syscall)\n" "${t_nxt}"
> -               t_nxt=$((t_nxt+1))
> -       done
> -       printf "__SYSCALL(%s,%s)\n" "${t_nxt}" "${t_entry}"
> -}
> -
> -grep -E "^[0-9A-Fa-fXx]+[[:space:]]+${my_abis}" "$in" | sort -n | (
> -       nxt=0
> -       if [ -z "$offset" ]; then
> -               offset=0
> -       fi
> -
> -       while read nr abi name entry compat ; do
> -               if [ "$my_abi" = "c32" ] && [ ! -z "$compat" ]; then
> -                       emit $((nxt+offset)) $((nr+offset)) $compat
> -               else
> -                       emit $((nxt+offset)) $((nr+offset)) $entry
> -               fi
> -               nxt=$((nr+1))
> -       done
> -) > "$out"
> diff --git a/arch/powerpc/kernel/systbl.S b/arch/powerpc/kernel/systbl.S
> index d34276f3c495..cb3358886203 100644
> --- a/arch/powerpc/kernel/systbl.S
> +++ b/arch/powerpc/kernel/systbl.S
> @@ -21,6 +21,7 @@
>  #define __SYSCALL(nr, entry)   .long entry
>  #endif
>
> +#define __SYSCALL_WITH_COMPAT(nr, native, compat)      __SYSCALL(nr, native)
>  .globl sys_call_table
>  sys_call_table:
>  #ifdef CONFIG_PPC64
> @@ -30,8 +31,10 @@ sys_call_table:
>  #endif
>
>  #ifdef CONFIG_COMPAT
> +#undef __SYSCALL_WITH_COMPAT
> +#define __SYSCALL_WITH_COMPAT(nr, native, compat)      __SYSCALL(nr, compat)
>  .globl compat_sys_call_table
>  compat_sys_call_table:
>  #define compat_sys_sigsuspend  sys_sigsuspend
> -#include <asm/syscall_table_c32.h>
> +#include <asm/syscall_table_32.h>
>  #endif
> diff --git a/arch/powerpc/platforms/cell/spu_callbacks.c b/arch/powerpc/platforms/cell/spu_callbacks.c
> index abdef9bcf432..fe0d8797a00a 100644
> --- a/arch/powerpc/platforms/cell/spu_callbacks.c
> +++ b/arch/powerpc/platforms/cell/spu_callbacks.c
> @@ -35,9 +35,9 @@
>   */
>
>  static void *spu_syscall_table[] = {
> +#define __SYSCALL_WITH_COMPAT(nr, entry, compat) __SYSCALL(nr, entry)
>  #define __SYSCALL(nr, entry) [nr] = entry,
>  #include <asm/syscall_table_spu.h>
> -#undef __SYSCALL
>  };
>
>  long spu_sys_callback(struct spu_syscall_block *s)
> --
> 2.27.0
>


-- 
Best Regards
Masahiro Yamada
