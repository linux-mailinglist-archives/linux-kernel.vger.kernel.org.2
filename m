Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9AF543318DB
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Mar 2021 21:50:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230410AbhCHUtx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 15:49:53 -0500
Received: from mout.gmx.net ([212.227.15.18]:51611 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229446AbhCHUtY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 15:49:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1615236528;
        bh=eW3FmKI3f6eEnR8vKP4nGcTwspkDUBDdt71YZnAPzJI=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=Y8wKY+/Lxnf6tNRl053jUShriFzf4j16g2FjsaYzhNkMyOpvR281bngk447x4ghG4
         zU0/F7lDZbkBmDULvd9vfFNAtKqVP47il/EgVhfdjGmgsepZtBhq8dU4cCLeEKMFCF
         vwLHSyTEW0nR8azkxIlBWEGffoUJvTxHM30VdVh4=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.20.60] ([92.116.147.164]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MmULr-1m1XBB2LI1-00iV2T; Mon, 08
 Mar 2021 21:48:48 +0100
Subject: Re: [PATCH 1/2] parisc: syscalls: switch to generic syscalltbl.sh
To:     Masahiro Yamada <masahiroy@kernel.org>,
        "James E . J . Bottomley" <James.Bottomley@HansenPartnership.com>,
        linux-parisc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Firoz Khan <firoz.khan@linaro.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        John David Anglin <dave.anglin@bell.net>,
        Randy Dunlap <rdunlap@infradead.org>,
        YiFei Zhu <yifeifz2@illinois.edu>
References: <20210301145823.359770-1-masahiroy@kernel.org>
From:   Helge Deller <deller@gmx.de>
Message-ID: <41623bcf-4cc5-b41e-4968-039035311ae9@gmx.de>
Date:   Mon, 8 Mar 2021 21:48:27 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210301145823.359770-1-masahiroy@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:00OMrUo0TFKpmjPUgTsHdAOP+AGcWPUERGqzV8cNsJ/rltU3kew
 ydco+OWWYWiUW69JZpHml6OgWCcyODqN/S3AZvVKx7pp7GeqNYcF4PvlwDzblFe64i1lZaE
 B6/vohKFv7VVSVocy8FpZUJ0TRukHC/cEY1LCwU5gfgWECAmjHaQQ7t4tkaI30ooB9ZxU2Z
 zFWKfUcmqhqSKXgl8Wbgg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:EBx4f9p+Gu4=:0yoFrZptu55kpdUdm97YnC
 FCHg/NQopNKTdtPJAnMxJYV7wlj7ii+N+st4S5CNsYuPymcJ0LT3wwRooGoPCfRuf7v/+X58b
 JPvulvLSmO0z/wgTjGijoes4AJ9clnuLtf6rNZDxwCOPzlhYy7VkI3ngB/ZMudJr6ORPkKOOl
 ug16n0GRuEak0ncBnur1cJo74/4xf6hq2YkecDl/Fu8ZFGWnXqvQZitYzOv6khn/jpxEinv5v
 OGXYPfe8BAiDvqrEzq2lo71MHMhaAKWUd3JsUKnVGvn8vOh0rgDYamY1oQG1ipNwXrMg5hc8M
 ZrQnqti1snl0e3XELSZFaW4WxZtJDkF4/gukEznIm5nJzrrIrE/uQXdj14TYCRZbphciiIVvA
 zBki/YhEAmlJzer713p4yXBDJ7lZC3+VwZq+DcV9a5UdWPo5Z/kVqZzEygZ4vz7JquCTngK6u
 OXhsrkDF5VrHillEF29gMhy7x24xsPHamIQ6ECAVdxZQtnkEa8askanwI0/mzqvlMhUERuoRD
 aZMBTlJwiwM61XlOe4ZuDBUdal/XgeZpuQEefQjHcwOxc+g/s+VDwqI2+aM1r3mZpa6y3Vd+f
 oodCkScQVgMzKsCENaa+l5kf1EfqiYEPXzKsXbAmOv9qNqpKhQS8Lp6ye8c3yq2yQjgdTQ4YL
 Dev9Ty1Z8UZT/iMEBJuO/fkmLsM8pEukp4yX8YL2t/QJ1SYLNhdc02ML/dqO+2Eh3jCMTki9K
 2gRnXkoIkhM1tpKB3Wha9rnqRhFtEkzh3oQVB4W9P5aMDBZqqZpGll00IKDBg39hjrXC/Ojb8
 gWY8c5iwYL8QsQN0YIsRjxrgYJTUV50hmSX57tt8wl+wx/xpDo0vj0lxjon/dYufszkUtT9We
 SKNZDCLzPVJRJAH5HJLQ==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/1/21 3:58 PM, Masahiro Yamada wrote:
> Many architectures duplicate similar shell scripts.
>
> This commit converts parisc to use scripts/syscalltbl.sh. This also
> unifies syscall_table_64.h and syscall_table_c32.h.
>
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>

For both patches:
Acked-by: Helge Deller <deller@gmx.de>

Masahiro, will you push it upstream, or should I take it through the paris=
c tree?

Helge

> ---
>
>   arch/parisc/include/asm/Kbuild            |  1 -
>   arch/parisc/kernel/syscall.S              | 16 +++++-----
>   arch/parisc/kernel/syscalls/Makefile      | 19 ++++--------
>   arch/parisc/kernel/syscalls/syscalltbl.sh | 36 -----------------------
>   4 files changed, 12 insertions(+), 60 deletions(-)
>   delete mode 100644 arch/parisc/kernel/syscalls/syscalltbl.sh
>
> diff --git a/arch/parisc/include/asm/Kbuild b/arch/parisc/include/asm/Kb=
uild
> index 4406475a2304..e6e7f74c8ac9 100644
> --- a/arch/parisc/include/asm/Kbuild
> +++ b/arch/parisc/include/asm/Kbuild
> @@ -1,7 +1,6 @@
>   # SPDX-License-Identifier: GPL-2.0
>   generated-y +=3D syscall_table_32.h
>   generated-y +=3D syscall_table_64.h
> -generated-y +=3D syscall_table_c32.h
>   generic-y +=3D kvm_para.h
>   generic-y +=3D mcs_spinlock.h
>   generic-y +=3D user.h
> diff --git a/arch/parisc/kernel/syscall.S b/arch/parisc/kernel/syscall.S
> index 322503780db6..3f24a0af1e04 100644
> --- a/arch/parisc/kernel/syscall.S
> +++ b/arch/parisc/kernel/syscall.S
> @@ -919,24 +919,24 @@ ENTRY(lws_table)
>   END(lws_table)
>   	/* End of lws table */
>
> +#ifdef CONFIG_64BIT
> +#define __SYSCALL_WITH_COMPAT(nr, native, compat)	__SYSCALL(nr, compat)
> +#else
> +#define __SYSCALL_WITH_COMPAT(nr, native, compat)	__SYSCALL(nr, native)
> +#endif
>   #define __SYSCALL(nr, entry)	ASM_ULONG_INSN entry
>   	.align 8
>   ENTRY(sys_call_table)
>   	.export sys_call_table,data
> -#ifdef CONFIG_64BIT
> -#include <asm/syscall_table_c32.h>   /* Compat syscalls */
> -#else
> -#include <asm/syscall_table_32.h>    /* 32-bit native syscalls */
> -#endif
> +#include <asm/syscall_table_32.h>    /* 32-bit syscalls */
>   END(sys_call_table)
>
>   #ifdef CONFIG_64BIT
>   	.align 8
>   ENTRY(sys_call_table64)
> -#include <asm/syscall_table_64.h>    /* 64-bit native syscalls */
> +#include <asm/syscall_table_64.h>    /* 64-bit syscalls */
>   END(sys_call_table64)
>   #endif
> -#undef __SYSCALL
>
>   	/*
>   		All light-weight-syscall atomic operations
> @@ -961,5 +961,3 @@ END(lws_lock_start)
>   	.previous
>
>   .end
> -
> -
> diff --git a/arch/parisc/kernel/syscalls/Makefile b/arch/parisc/kernel/s=
yscalls/Makefile
> index 283f64407b07..11424f1c8d9e 100644
> --- a/arch/parisc/kernel/syscalls/Makefile
> +++ b/arch/parisc/kernel/syscalls/Makefile
> @@ -7,7 +7,7 @@ _dummy :=3D $(shell [ -d '$(uapi)' ] || mkdir -p '$(uapi=
)')	\
>
>   syscall :=3D $(src)/syscall.tbl
>   syshdr :=3D $(srctree)/$(src)/syscallhdr.sh
> -systbl :=3D $(srctree)/$(src)/syscalltbl.sh
> +systbl :=3D $(srctree)/scripts/syscalltbl.sh
>
>   quiet_cmd_syshdr =3D SYSHDR  $@
>         cmd_syshdr =3D $(CONFIG_SHELL) '$(syshdr)' '$<' '$@'	\
> @@ -16,10 +16,7 @@ quiet_cmd_syshdr =3D SYSHDR  $@
>   		   '$(syshdr_offset_$(basetarget))'
>
>   quiet_cmd_systbl =3D SYSTBL  $@
> -      cmd_systbl =3D $(CONFIG_SHELL) '$(systbl)' '$<' '$@'	\
> -		   '$(systbl_abis_$(basetarget))'		\
> -		   '$(systbl_abi_$(basetarget))'		\
> -		   '$(systbl_offset_$(basetarget))'
> +      cmd_systbl =3D $(CONFIG_SHELL) $(systbl) --abis $(abis) $< $@
>
>   syshdr_abis_unistd_32 :=3D common,32
>   $(uapi)/unistd_32.h: $(syscall) $(syshdr) FORCE
> @@ -29,23 +26,17 @@ syshdr_abis_unistd_64 :=3D common,64
>   $(uapi)/unistd_64.h: $(syscall) $(syshdr) FORCE
>   	$(call if_changed,syshdr)
>
> -systbl_abis_syscall_table_32 :=3D common,32
> +$(kapi)/syscall_table_32.h: abis :=3D common,32
>   $(kapi)/syscall_table_32.h: $(syscall) $(systbl) FORCE
>   	$(call if_changed,systbl)
>
> -systbl_abis_syscall_table_64 :=3D common,64
> +$(kapi)/syscall_table_64.h: abis :=3D common,64
>   $(kapi)/syscall_table_64.h: $(syscall) $(systbl) FORCE
>   	$(call if_changed,systbl)
>
> -systbl_abis_syscall_table_c32 :=3D common,32
> -systbl_abi_syscall_table_c32 :=3D c32
> -$(kapi)/syscall_table_c32.h: $(syscall) $(systbl) FORCE
> -	$(call if_changed,systbl)
> -
>   uapisyshdr-y		+=3D unistd_32.h unistd_64.h
>   kapisyshdr-y		+=3D syscall_table_32.h		\
> -			   syscall_table_64.h		\
> -			   syscall_table_c32.h
> +			   syscall_table_64.h
>
>   uapisyshdr-y	:=3D $(addprefix $(uapi)/, $(uapisyshdr-y))
>   kapisyshdr-y	:=3D $(addprefix $(kapi)/, $(kapisyshdr-y))
> diff --git a/arch/parisc/kernel/syscalls/syscalltbl.sh b/arch/parisc/ker=
nel/syscalls/syscalltbl.sh
> deleted file mode 100644
> index f7393a7b18aa..000000000000
> --- a/arch/parisc/kernel/syscalls/syscalltbl.sh
> +++ /dev/null
> @@ -1,36 +0,0 @@
> -#!/bin/sh
> -# SPDX-License-Identifier: GPL-2.0
> -
> -in=3D"$1"
> -out=3D"$2"
> -my_abis=3D`echo "($3)" | tr ',' '|'`
> -my_abi=3D"$4"
> -offset=3D"$5"
> -
> -emit() {
> -	t_nxt=3D"$1"
> -	t_nr=3D"$2"
> -	t_entry=3D"$3"
> -
> -	while [ $t_nxt -lt $t_nr ]; do
> -		printf "__SYSCALL(%s,sys_ni_syscall)\n" "${t_nxt}"
> -		t_nxt=3D$((t_nxt+1))
> -	done
> -	printf "__SYSCALL(%s,%s)\n" "${t_nxt}" "${t_entry}"
> -}
> -
> -grep -E "^[0-9A-Fa-fXx]+[[:space:]]+${my_abis}" "$in" | sort -n | (
> -	nxt=3D0
> -	if [ -z "$offset" ]; then
> -		offset=3D0
> -	fi
> -
> -	while read nr abi name entry compat ; do
> -		if [ "$my_abi" =3D "c32" ] && [ ! -z "$compat" ]; then
> -			emit $((nxt+offset)) $((nr+offset)) $compat
> -		else
> -			emit $((nxt+offset)) $((nr+offset)) $entry
> -		fi
> -		nxt=3D$((nr+1))
> -	done
> -) > "$out"
>

