Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B562036D57F
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Apr 2021 12:14:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238774AbhD1KO7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Apr 2021 06:14:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:26939 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230122AbhD1KO5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Apr 2021 06:14:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1619604849;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VZQFPoKi/jBr5ugRoKa9A9hXUQTIKV1zSbQv433oqxE=;
        b=TaZMfflQRCGjuo2wpBoDvMfl2IByP67Y2x+QKAyw8GrEgHoxNnqKom0HIt9TU/rx1HZmEx
        T5l6YLOmtuOc84gpJJgFNUNMh5d20i9eI9NbGF3Lfobji76hp9npsQBe+5N9dqTvzJxqOj
        aAVXAbetpUmHKYTznf09AA2qo1olYUE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-482-GgvlVxVTMCuTzEJ3xmECvQ-1; Wed, 28 Apr 2021 06:14:04 -0400
X-MC-Unique: GgvlVxVTMCuTzEJ3xmECvQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 28D39803620;
        Wed, 28 Apr 2021 10:14:03 +0000 (UTC)
Received: from localhost (ovpn-13-87.pek2.redhat.com [10.72.13.87])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B49746060F;
        Wed, 28 Apr 2021 10:13:58 +0000 (UTC)
Date:   Wed, 28 Apr 2021 18:13:55 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Jessica Yu <jeyu@kernel.org>,
        Evan Green <evgreen@chromium.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Dave Young <dyoung@redhat.com>,
        Vivek Goyal <vgoyal@redhat.com>, kexec@lists.infradead.org
Subject: Re: [PATCH v5 13/13] kdump: Use vmlinux_build_id to simplify
Message-ID: <20210428101355.GB8374@localhost.localdomain>
References: <20210420215003.3510247-1-swboyd@chromium.org>
 <20210420215003.3510247-14-swboyd@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210420215003.3510247-14-swboyd@chromium.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/20/21 at 02:50pm, Stephen Boyd wrote:
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
>  include/linux/crash_core.h | 12 ++++-----
>  kernel/crash_core.c        | 50 ++------------------------------------
>  2 files changed, 8 insertions(+), 54 deletions(-)
> 
> diff --git a/include/linux/crash_core.h b/include/linux/crash_core.h
> index 206bde8308b2..de62a722431e 100644
> --- a/include/linux/crash_core.h
> +++ b/include/linux/crash_core.h
> @@ -38,8 +38,12 @@ phys_addr_t paddr_vmcoreinfo_note(void);
>  
>  #define VMCOREINFO_OSRELEASE(value) \
>  	vmcoreinfo_append_str("OSRELEASE=%s\n", value)
> -#define VMCOREINFO_BUILD_ID(value) \
> -	vmcoreinfo_append_str("BUILD-ID=%s\n", value)
> +#define VMCOREINFO_BUILD_ID()						\
> +	({								\
> +		static_assert(sizeof(vmlinux_build_id) == 20);		\
> +		vmcoreinfo_append_str("BUILD-ID=%20phN\n", vmlinux_build_id); \

Since there has been static_assert at above, can we remove the magic
number '20'? 

And I checked format_decode(), didn't find which type corresponds to
'N', could you tell?

Other than these, this patch looks good to me, thanks for the effort.

Thanks
Baoquan

> +	})
> +
>  #define VMCOREINFO_PAGESIZE(value) \
>  	vmcoreinfo_append_str("PAGESIZE=%ld\n", value)
>  #define VMCOREINFO_SYMBOL(name) \
> @@ -69,10 +73,6 @@ extern unsigned char *vmcoreinfo_data;
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
> index 825284baaf46..29cc15398ee4 100644
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
> @@ -378,53 +379,6 @@ phys_addr_t __weak paddr_vmcoreinfo_note(void)
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
> -/*
> - * Add build ID from .notes section as generated by the GNU ld(1)
> - * or LLVM lld(1) --build-id option.
> - */
> -static void add_build_id_vmcoreinfo(void)
> -{
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
> -}
> -
>  static int __init crash_save_vmcoreinfo_init(void)
>  {
>  	vmcoreinfo_data = (unsigned char *)get_zeroed_page(GFP_KERNEL);
> @@ -443,7 +397,7 @@ static int __init crash_save_vmcoreinfo_init(void)
>  	}
>  
>  	VMCOREINFO_OSRELEASE(init_uts_ns.name.release);
> -	add_build_id_vmcoreinfo();
> +	VMCOREINFO_BUILD_ID();
>  	VMCOREINFO_PAGESIZE(PAGE_SIZE);
>  
>  	VMCOREINFO_SYMBOL(init_uts_ns);
> -- 
> https://chromeos.dev
> 
> 
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec
> 

