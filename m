Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BBBD35729D
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 19:03:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354505AbhDGRDs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 13:03:48 -0400
Received: from mx2.suse.de ([195.135.220.15]:59518 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1354499AbhDGRDk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 13:03:40 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1617815008; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xDeNUJWj/KwT4DnPD7aB4HG9X9xq0pFkyBbaBZ5x780=;
        b=JMho7XQI9YwV9l9avF831ZqLC96OjqfQUBZvaXXkSQx5ySX95Tsl3SOGM65NHxoUpfwkHG
        L2gRnDyPL2QZ2OWoEGTD7Lkb43Fvtvx7GZ3FNdDtx08fpB8XUorDTuLRzDEEXMzPRZajpw
        SAOM8um+sRgSBf3zfgsPdqYTkIGzFRI=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 89803B1EF;
        Wed,  7 Apr 2021 17:03:28 +0000 (UTC)
Date:   Wed, 7 Apr 2021 19:03:28 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Jessica Yu <jeyu@kernel.org>,
        Evan Green <evgreen@chromium.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Dave Young <dyoung@redhat.com>, Baoquan He <bhe@redhat.com>,
        Vivek Goyal <vgoyal@redhat.com>, kexec@lists.infradead.org
Subject: Re: [PATCH v3 12/12] kdump: Use vmlinux_build_id to simplify
Message-ID: <20210407170328.x7hgch37o7ezttb6@pathway.suse.cz>
References: <20210331030520.3816265-1-swboyd@chromium.org>
 <20210331030520.3816265-13-swboyd@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210331030520.3816265-13-swboyd@chromium.org>
User-Agent: NeoMutt/20170912 (1.9.0)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 2021-03-30 20:05:20, Stephen Boyd wrote:
> We can use the vmlinux_build_id array here now instead of open coding
> it. This mostly consolidates code.
> 
> Cc: Jiri Olsa <jolsa@kernel.org>
> Cc: Alexei Starovoitov <ast@kernel.org>
> Cc: Jessica Yu <jeyu@kernel.org>
> Cc: Evan Green <evgreen@chromium.org>
> Cc: Hsin-Yi Wang <hsinyi@chromium.org>
> Cc: Dave Young <dyoung@redhat.com>
> Cc: Baoquan He <bhe@redhat.com>
> Cc: Vivek Goyal <vgoyal@redhat.com>
> Cc: <kexec@lists.infradead.org>
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> ---
>  include/linux/crash_core.h |  6 +-----
>  kernel/crash_core.c        | 41 ++------------------------------------
>  2 files changed, 3 insertions(+), 44 deletions(-)
> 
> diff --git a/include/linux/crash_core.h b/include/linux/crash_core.h
> index 206bde8308b2..fb8ab99bb2ee 100644
> --- a/include/linux/crash_core.h
> +++ b/include/linux/crash_core.h
> @@ -39,7 +39,7 @@ phys_addr_t paddr_vmcoreinfo_note(void);
>  #define VMCOREINFO_OSRELEASE(value) \
>  	vmcoreinfo_append_str("OSRELEASE=%s\n", value)
>  #define VMCOREINFO_BUILD_ID(value) \
> -	vmcoreinfo_append_str("BUILD-ID=%s\n", value)
> +	vmcoreinfo_append_str("BUILD-ID=%20phN\n", value)

Please, add also build check that BUILD_ID_MAX == 20.


>  #define VMCOREINFO_PAGESIZE(value) \
>  	vmcoreinfo_append_str("PAGESIZE=%ld\n", value)
>  #define VMCOREINFO_SYMBOL(name) \
> @@ -69,10 +69,6 @@ extern unsigned char *vmcoreinfo_data;
>  extern size_t vmcoreinfo_size;
>  extern u32 *vmcoreinfo_note;
>  
> -/* raw contents of kernel .notes section */
> -extern const void __start_notes __weak;
> -extern const void __stop_notes __weak;
> -
>  Elf_Word *append_elf_note(Elf_Word *buf, char *name, unsigned int type,
>  			  void *data, size_t data_len);
>  void final_note(Elf_Word *buf);
> diff --git a/kernel/crash_core.c b/kernel/crash_core.c
> index 825284baaf46..6b560cf9f374 100644
> --- a/kernel/crash_core.c
> +++ b/kernel/crash_core.c
> @@ -4,6 +4,7 @@
>   * Copyright (C) 2002-2004 Eric Biederman  <ebiederm@xmission.com>
>   */
>  
> +#include <linux/buildid.h>
>  #include <linux/crash_core.h>
>  #include <linux/utsname.h>
>  #include <linux/vmalloc.h>
> @@ -378,51 +379,13 @@ phys_addr_t __weak paddr_vmcoreinfo_note(void)
>  }
>  EXPORT_SYMBOL(paddr_vmcoreinfo_note);
>  
> -#define NOTES_SIZE (&__stop_notes - &__start_notes)
> -#define BUILD_ID_MAX SHA1_DIGEST_SIZE
> -#define NT_GNU_BUILD_ID 3
> -
> -struct elf_note_section {
> -	struct elf_note	n_hdr;
> -	u8 n_data[];
> -};
> -
>  /*
>   * Add build ID from .notes section as generated by the GNU ld(1)
>   * or LLVM lld(1) --build-id option.
>   */
>  static void add_build_id_vmcoreinfo(void)
>  {
> -	char build_id[BUILD_ID_MAX * 2 + 1];
> -	int n_remain = NOTES_SIZE;
> -
> -	while (n_remain >= sizeof(struct elf_note)) {
> -		const struct elf_note_section *note_sec =
> -			&__start_notes + NOTES_SIZE - n_remain;
> -		const u32 n_namesz = note_sec->n_hdr.n_namesz;
> -
> -		if (note_sec->n_hdr.n_type == NT_GNU_BUILD_ID &&
> -		    n_namesz != 0 &&
> -		    !strcmp((char *)&note_sec->n_data[0], "GNU")) {
> -			if (note_sec->n_hdr.n_descsz <= BUILD_ID_MAX) {
> -				const u32 n_descsz = note_sec->n_hdr.n_descsz;
> -				const u8 *s = &note_sec->n_data[n_namesz];
> -
> -				s = PTR_ALIGN(s, 4);
> -				bin2hex(build_id, s, n_descsz);
> -				build_id[2 * n_descsz] = '\0';
> -				VMCOREINFO_BUILD_ID(build_id);
> -				return;
> -			}
> -			pr_warn("Build ID is too large to include in vmcoreinfo: %u > %u\n",
> -				note_sec->n_hdr.n_descsz,
> -				BUILD_ID_MAX);
> -			return;
> -		}
> -		n_remain -= sizeof(struct elf_note) +
> -			ALIGN(note_sec->n_hdr.n_namesz, 4) +
> -			ALIGN(note_sec->n_hdr.n_descsz, 4);
> -	}
> +	VMCOREINFO_BUILD_ID(vmlinux_build_id);
>  }

The function add_build_id_vmcoreinfo() is used in
crash_save_vmcoreinfo_init() in this context:


	VMCOREINFO_OSRELEASE(init_uts_ns.name.release);
	add_build_id_vmcoreinfo();
	VMCOREINFO_PAGESIZE(PAGE_SIZE);

	VMCOREINFO_SYMBOL(init_uts_ns);
	VMCOREINFO_OFFSET(uts_namespace, name);
	VMCOREINFO_SYMBOL(node_online_map);

The function is not longer need. VMCOREINFO_BUILD_ID()
can be used directly:

	VMCOREINFO_OSRELEASE(init_uts_ns.name.release);
	VMCOREINFO_BUILD_ID(vmlinux_build_id);
	VMCOREINFO_PAGESIZE(PAGE_SIZE);

	VMCOREINFO_SYMBOL(init_uts_ns);
	VMCOREINFO_OFFSET(uts_namespace, name);
	VMCOREINFO_SYMBOL(node_online_map);


Best Regards,
Petr


>  
>  static int __init crash_save_vmcoreinfo_init(void)
> -- 
> https://chromeos.dev
