Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DF1332A692
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 17:45:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1578531AbhCBPYu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Mar 2021 10:24:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347841AbhCBNBb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 08:01:31 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B011C061356
        for <linux-kernel@vger.kernel.org>; Tue,  2 Mar 2021 05:00:42 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id v13so8601806edw.9
        for <linux-kernel@vger.kernel.org>; Tue, 02 Mar 2021 05:00:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=IC+uX7A55ypBTZUEdbqQvK9nxwy3mjsxzKOU3rzgORo=;
        b=uE2BAYTYOtNVEHtv5qB2kgf9lNhbgjTATjqt/96UkUA94GzXumD2EJTrZU6rkyVF4d
         teic1RZDrVPBdw32X8fTmTIwGalaQMtKPYr50LfFtOQEoiVe4mnd75BpvqNODd/aaitC
         jykaOEEtZ3OeRExUF8y89yAQldQ+3U6fG2HqbQb3s+r1AtbcWH8eeIGv3Jtang9yNvNv
         nmfKTqZoY+23KrRy7/XetHhlwTUa5DTGb8/4TngJ5JezKe6xP7KDblQbttzZWuZvbTLH
         eHpWk/zfbMmg7BewmBXRUSkyyOv+MAQw8HFv3sMyd82L9r7Tz2YMnCOZF2wbB7iuEp7m
         xbYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=IC+uX7A55ypBTZUEdbqQvK9nxwy3mjsxzKOU3rzgORo=;
        b=fKdh22r1Zm9GVcVCiLn/UslIKFB1rQwk5sIQwKDIukwCnJVUCY1ln0V0QIZ6MIuQwB
         akchaVIiP+l8Saep5c2QU/D9KxYIKjaf1kiml+Xx6cbqf+lXigRGpm85h/muWT6dbDW1
         6hjH7fI8sOF5SMe8zx5ADTkTgjZbUVbPjrXmw5Rkf8c6zq00vlpvuS7i5NgKst+iQ2rB
         SvAGeyOttFwfV1/SrxTMcpY9junX7WaZUEw4nB3tUKYMTQ+rdleTZvyrxxw84jnjA49O
         vXnZDqKKW9Ugj45gK/PiOVrN9cAV8mp6b2S8NLZG4BcOiRmzWikosV20nn2Y0uSbC6cH
         JZRw==
X-Gm-Message-State: AOAM5301q3bV1c6LJtP34zV+nv3gvM8mIfMy9kA2THQoXgISVVF+5Eu2
        yDNSbc/0ORMTzlFQcWKljyK2+Q==
X-Google-Smtp-Source: ABdhPJzYzGuumVIEKMjPWEJ2lec4F4TK3GxdPBs+PeyLPRRMIt8Ucu2MTT+/EZCoWpqKfQSbpHPRNw==
X-Received: by 2002:a50:fc94:: with SMTP id f20mr8995707edq.370.1614690041071;
        Tue, 02 Mar 2021 05:00:41 -0800 (PST)
Received: from ?IPv6:2a02:768:2307:40d6::f9e? ([2a02:768:2307:40d6::f9e])
        by smtp.gmail.com with ESMTPSA id k5sm18051159eja.70.2021.03.02.05.00.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Mar 2021 05:00:40 -0800 (PST)
Subject: Re: [PATCH 1/2] microblaze: syscalls: switch to generic syscalltbl.sh
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
References: <20210301142303.343727-1-masahiroy@kernel.org>
From:   Michal Simek <monstr@monstr.eu>
Message-ID: <3db0da0d-0e08-8301-f028-4a5a7bd232f5@monstr.eu>
Date:   Tue, 2 Mar 2021 14:00:39 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210301142303.343727-1-masahiroy@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/1/21 3:23 PM, Masahiro Yamada wrote:
> Many architectures duplicate similar shell scripts.
> 
> This commit converts microblaze to use scripts/syscalltbl.sh.
> 
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---
> 
>  arch/microblaze/kernel/syscall_table.S        |  3 +-
>  arch/microblaze/kernel/syscalls/Makefile      |  7 ++--
>  arch/microblaze/kernel/syscalls/syscalltbl.sh | 32 -------------------
>  3 files changed, 3 insertions(+), 39 deletions(-)
>  delete mode 100644 arch/microblaze/kernel/syscalls/syscalltbl.sh
> 
> diff --git a/arch/microblaze/kernel/syscall_table.S b/arch/microblaze/kernel/syscall_table.S
> index ce006646f741..3bc60a2b159e 100644
> --- a/arch/microblaze/kernel/syscall_table.S
> +++ b/arch/microblaze/kernel/syscall_table.S
> @@ -1,6 +1,5 @@
>  /* SPDX-License-Identifier: GPL-2.0 */
>  
> -#define __SYSCALL(nr, entry, nargs) .long entry
> +#define __SYSCALL(nr, entry) .long entry
>  ENTRY(sys_call_table)
>  #include <asm/syscall_table.h>
> -#undef __SYSCALL
> diff --git a/arch/microblaze/kernel/syscalls/Makefile b/arch/microblaze/kernel/syscalls/Makefile
> index 285aaba832d9..ad2492cb5568 100644
> --- a/arch/microblaze/kernel/syscalls/Makefile
> +++ b/arch/microblaze/kernel/syscalls/Makefile
> @@ -7,7 +7,7 @@ _dummy := $(shell [ -d '$(uapi)' ] || mkdir -p '$(uapi)')	\
>  
>  syscall := $(src)/syscall.tbl
>  syshdr := $(srctree)/$(src)/syscallhdr.sh
> -systbl := $(srctree)/$(src)/syscalltbl.sh
> +systbl := $(srctree)/scripts/syscalltbl.sh
>  
>  quiet_cmd_syshdr = SYSHDR  $@
>        cmd_syshdr = $(CONFIG_SHELL) '$(syshdr)' '$<' '$@'	\
> @@ -16,10 +16,7 @@ quiet_cmd_syshdr = SYSHDR  $@
>  		   '$(syshdr_offset_$(basetarget))'
>  
>  quiet_cmd_systbl = SYSTBL  $@
> -      cmd_systbl = $(CONFIG_SHELL) '$(systbl)' '$<' '$@'	\
> -		   '$(systbl_abis_$(basetarget))'		\
> -		   '$(systbl_abi_$(basetarget))'		\
> -		   '$(systbl_offset_$(basetarget))'
> +      cmd_systbl = $(CONFIG_SHELL) $(systbl) $< $@
>  
>  $(uapi)/unistd_32.h: $(syscall) $(syshdr) FORCE
>  	$(call if_changed,syshdr)
> diff --git a/arch/microblaze/kernel/syscalls/syscalltbl.sh b/arch/microblaze/kernel/syscalls/syscalltbl.sh
> deleted file mode 100644
> index 85d78d9309ad..000000000000
> --- a/arch/microblaze/kernel/syscalls/syscalltbl.sh
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
> -	t_nxt="$1"
> -	t_nr="$2"
> -	t_entry="$3"
> -
> -	while [ $t_nxt -lt $t_nr ]; do
> -		printf "__SYSCALL(%s, sys_ni_syscall, )\n" "${t_nxt}"
> -		t_nxt=$((t_nxt+1))
> -	done
> -	printf "__SYSCALL(%s, %s, )\n" "${t_nxt}" "${t_entry}"
> -}
> -
> -grep -E "^[0-9A-Fa-fXx]+[[:space:]]+${my_abis}" "$in" | sort -n | (
> -	nxt=0
> -	if [ -z "$offset" ]; then
> -		offset=0
> -	fi
> -
> -	while read nr abi name entry ; do
> -		emit $((nxt+offset)) $((nr+offset)) $entry
> -		nxt=$((nr+1))
> -	done
> -) > "$out"
> 

Applied both.
M

-- 
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Xilinx Microblaze
Maintainer of Linux kernel - Xilinx Zynq ARM and ZynqMP ARM64 SoCs
U-Boot custodian - Xilinx Microblaze/Zynq/ZynqMP/Versal SoCs



