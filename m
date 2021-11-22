Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE4D54587DA
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Nov 2021 02:56:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238408AbhKVB65 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Nov 2021 20:58:57 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:39462 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232296AbhKVB64 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Nov 2021 20:58:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1637546150;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=foL2qzsSmwXF+mZ2MGe7BLerROLxedXKdXca4/aLKDo=;
        b=dCVU/eC29y6xGvQhn4VwtaVcifrH/PE5xOqcv2QzBdGnCH6mnsHS/qTU6HGXJxsSRaFiNY
        E+L5oUCYlqqtOyZpjhx5rO6MOLNoJfqboR0SQjPiHqHWb/OsviotTuDZUaar10j8q/5v3O
        o8Gt9TOPxVAS4sqXJy5pMiV3VpzPYFM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-189--M8HS8O5MrKP_GhfL0sfvw-1; Sun, 21 Nov 2021 20:55:46 -0500
X-MC-Unique: -M8HS8O5MrKP_GhfL0sfvw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A77353938D;
        Mon, 22 Nov 2021 01:55:45 +0000 (UTC)
Received: from localhost (ovpn-12-61.pek2.redhat.com [10.72.12.61])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 07FE39808;
        Mon, 22 Nov 2021 01:55:31 +0000 (UTC)
Date:   Mon, 22 Nov 2021 09:55:29 +0800
From:   Baoquan He <bhe@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     kexec@lists.infradead.org, dyoung@redhat.com,
        akpm@linux-foundation.org
Subject: Re: [PATCH 1/3] x86/kexec: fix memory leak of elf header buffer
Message-ID: <20211122015529.GA7968@MiWiFi-R3L-srv>
References: <20211029072424.9109-1-bhe@redhat.com>
 <20211029072424.9109-2-bhe@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211029072424.9109-2-bhe@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/29/21 at 03:24pm, Baoquan He wrote:
> This is reported by kmemleak detector:
> 
> unreferenced object 0xffffc900002a9000 (size 4096):
>   comm "kexec", pid 14950, jiffies 4295110793 (age 373.951s)
>   hex dump (first 32 bytes):
>     7f 45 4c 46 02 01 01 00 00 00 00 00 00 00 00 00  .ELF............
>     04 00 3e 00 01 00 00 00 00 00 00 00 00 00 00 00  ..>.............
>   backtrace:
>     [<0000000016a8ef9f>] __vmalloc_node_range+0x101/0x170
>     [<000000002b66b6c0>] __vmalloc_node+0xb4/0x160
>     [<00000000ad40107d>] crash_prepare_elf64_headers+0x8e/0xcd0
>     [<0000000019afff23>] crash_load_segments+0x260/0x470
>     [<0000000019ebe95c>] bzImage64_load+0x814/0xad0
>     [<0000000093e16b05>] arch_kexec_kernel_image_load+0x1be/0x2a0
>     [<000000009ef2fc88>] kimage_file_alloc_init+0x2ec/0x5a0
>     [<0000000038f5a97a>] __do_sys_kexec_file_load+0x28d/0x530
>     [<0000000087c19992>] do_syscall_64+0x3b/0x90
>     [<0000000066e063a4>] entry_SYSCALL_64_after_hwframe+0x44/0xae
> 
> In crash_prepare_elf64_headers(), a buffer is allocated via vmalloc() to
> store elf headers. While it's not freed back to system correctly when
> kdump kernel is reloaded or unloaded. Then memory leak is caused.
> 
> Fix it by introducing x86 specific function
> arch_kimage_file_post_load_cleanup(), and freeing the buffer there.
> 
> Signed-off-by: Baoquan He <bhe@redhat.com>

It deserves to add a Fixes tag, and this drawback exists since
kexec_file_load added. It wastes one page of memory, or severa pages
depending on the cpu numbers, not sure if it deserves to cc stable.

Fixes: cb1052581e2b ("kexec: implementation of new syscall kexec_file_load")


> ---
>  arch/x86/kernel/machine_kexec_64.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/arch/x86/kernel/machine_kexec_64.c b/arch/x86/kernel/machine_kexec_64.c
> index 131f30fdcfbd..fd8223fa2de5 100644
> --- a/arch/x86/kernel/machine_kexec_64.c
> +++ b/arch/x86/kernel/machine_kexec_64.c
> @@ -511,6 +511,15 @@ int arch_kexec_apply_relocations_add(struct purgatory_info *pi,
>  	       (int)ELF64_R_TYPE(rel[i].r_info), value);
>  	return -ENOEXEC;
>  }
> +
> +int arch_kimage_file_post_load_cleanup(struct kimage *image)
> +{
> +	vfree(image->elf_headers);
> +	image->elf_headers = NULL;
> +	image->elf_headers_sz = 0;
> +
> +	return kexec_image_post_load_cleanup_default(image);
> +}
>  #endif /* CONFIG_KEXEC_FILE */
>  
>  static int
> -- 
> 2.17.2
> 

