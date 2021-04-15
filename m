Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31B1F360B5F
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Apr 2021 16:04:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233413AbhDOOEp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Apr 2021 10:04:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:55372 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233400AbhDOOEn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Apr 2021 10:04:43 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0523461222;
        Thu, 15 Apr 2021 14:04:17 +0000 (UTC)
Subject: Re: [PATCH v3 1/2] binfmt_flat: allow not offsetting data start
To:     Damien Le Moal <damien.lemoal@wdc.com>, uclinux-dev@uclinux.org,
        ugerg@linux-m68k.org, Palmer Dabbelt <palmer@dabbelt.com>,
        linux-riscv@lists.infradead.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-kernel@vger.kernel.org
Cc:     Max Filippov <jcmvbkbc@gmail.com>, Anup Patel <anup.patel@wdc.com>,
        Christoph Hellwig <hch@lst.de>
References: <20210415061502.7248-1-damien.lemoal@wdc.com>
 <20210415061502.7248-2-damien.lemoal@wdc.com>
From:   Greg Ungerer <gerg@linux-m68k.org>
Message-ID: <8ff801ad-6e17-fdd2-6186-5443540947a9@linux-m68k.org>
Date:   Fri, 16 Apr 2021 00:04:15 +1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210415061502.7248-2-damien.lemoal@wdc.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Damien,

On 15/4/21 4:15 pm, Damien Le Moal wrote:
> Commit 2217b9826246 ("binfmt_flat: revert "binfmt_flat: don't offset
> the data start"") restored offsetting the start of the data section by
> a number of words defined by MAX_SHARED_LIBS. As a result, since
> MAX_SHARED_LIBS is never 0, a gap between the text and data sections
> always exists. For architectures which cannot support a such gap
> between the text and data sections (e.g. riscv nommu), flat binary
> programs cannot be executed.
> 
> To allow an architecture to request contiguous text and data sections,
> introduce the config option CONFIG_BINFMT_FLAT_NO_TEXT_DATA_GAP.
> Using this new option, the macro DATA_GAP_WORDS is conditionally
> defined in binfmt_flat.c to MAX_SHARED_LIBS for architectures
> tolerating the text-to-data gap (CONFIG_BINFMT_FLAT_NO_TEXT_DATA_GAP
> disabled case) and to 0 when CONFIG_BINFMT_FLAT_NO_TEXT_DATA_GAP is
> enabled. DATA_GAP_WORDS is used in load_flat_file() to calculate the
> data section length and start position.
> 
> An architecture enabling CONFIG_BINFMT_FLAT_NO_TEXT_DATA_GAP also
> prevents the use of the separate text/data load case (when the flat file
> header flags FLAT_FLAG_RAM and FLAT_FLAG_GZIP are not set with NOMMU
> kernels) and forces the use of a single RAM region for loading
> (equivalent to FLAT_FLAG_RAM being set).

So is it the case that a flat format file on RISC-V will never have
relocations?


> Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
> Acked-by: Palmer Dabbelt <palmerdabbelt@google.com>
> ---
>   fs/Kconfig.binfmt |  3 +++
>   fs/binfmt_flat.c  | 21 +++++++++++++++------
>   2 files changed, 18 insertions(+), 6 deletions(-)
> 
> diff --git a/fs/Kconfig.binfmt b/fs/Kconfig.binfmt
> index c6f1c8c1934e..c6df931d5d45 100644
> --- a/fs/Kconfig.binfmt
> +++ b/fs/Kconfig.binfmt
> @@ -112,6 +112,9 @@ config BINFMT_FLAT_ARGVP_ENVP_ON_STACK
>   config BINFMT_FLAT_OLD_ALWAYS_RAM
>   	bool
>   
> +config BINFMT_FLAT_NO_TEXT_DATA_GAP
> +	bool
> +
>   config BINFMT_FLAT_OLD
>   	bool "Enable support for very old legacy flat binaries"
>   	depends on BINFMT_FLAT
> diff --git a/fs/binfmt_flat.c b/fs/binfmt_flat.c
> index b9c658e0548e..2be29bb964b8 100644
> --- a/fs/binfmt_flat.c
> +++ b/fs/binfmt_flat.c
> @@ -74,6 +74,12 @@
>   #define	MAX_SHARED_LIBS			(1)
>   #endif
>   
> +#ifdef CONFIG_BINFMT_FLAT_NO_TEXT_DATA_GAP
> +#define DATA_GAP_WORDS			(0)
> +#else
> +#define DATA_GAP_WORDS			(MAX_SHARED_LIBS)
> +#endif
> +>   struct lib_info {
>   	struct {
>   		unsigned long start_code;		/* Start of text segment */
> @@ -559,7 +565,10 @@ static int load_flat_file(struct linux_binprm *bprm,
>   	 * case,  and then the fully copied to RAM case which lumps
>   	 * it all together.
>   	 */
> -	if (!IS_ENABLED(CONFIG_MMU) && !(flags & (FLAT_FLAG_RAM|FLAT_FLAG_GZIP))) {
> +	if (!IS_ENABLED(CONFIG_MMU) &&
> +	    !IS_ENABLED(CONFIG_BINFMT_FLAT_NO_TEXT_DATA_GAP) &&

If RISC-V flat format files must always be loaded to RAM then why don't
they set the FLAT_FLAG_RAM when compiled/generated?

Regards
Greg


> +	    !(flags & (FLAT_FLAG_RAM|FLAT_FLAG_GZIP))) {
> +
>   		/*
>   		 * this should give us a ROM ptr,  but if it doesn't we don't
>   		 * really care
> @@ -576,7 +585,7 @@ static int load_flat_file(struct linux_binprm *bprm,
>   			goto err;
>   		}
>   
> -		len = data_len + extra + MAX_SHARED_LIBS * sizeof(unsigned long);
> +		len = data_len + extra + DATA_GAP_WORDS * sizeof(unsigned long);
>   		len = PAGE_ALIGN(len);
>   		realdatastart = vm_mmap(NULL, 0, len,
>   			PROT_READ|PROT_WRITE|PROT_EXEC, MAP_PRIVATE, 0);
> @@ -591,7 +600,7 @@ static int load_flat_file(struct linux_binprm *bprm,
>   			goto err;
>   		}
>   		datapos = ALIGN(realdatastart +
> -				MAX_SHARED_LIBS * sizeof(unsigned long),
> +				DATA_GAP_WORDS * sizeof(unsigned long),
>   				FLAT_DATA_ALIGN);
>   
>   		pr_debug("Allocated data+bss+stack (%u bytes): %lx\n",
> @@ -622,7 +631,7 @@ static int load_flat_file(struct linux_binprm *bprm,
>   		memp_size = len;
>   	} else {
>   
> -		len = text_len + data_len + extra + MAX_SHARED_LIBS * sizeof(u32);
> +		len = text_len + data_len + extra + DATA_GAP_WORDS * sizeof(u32);
>   		len = PAGE_ALIGN(len);
>   		textpos = vm_mmap(NULL, 0, len,
>   			PROT_READ | PROT_EXEC | PROT_WRITE, MAP_PRIVATE, 0);
> @@ -638,7 +647,7 @@ static int load_flat_file(struct linux_binprm *bprm,
>   
>   		realdatastart = textpos + ntohl(hdr->data_start);
>   		datapos = ALIGN(realdatastart +
> -				MAX_SHARED_LIBS * sizeof(u32),
> +				DATA_GAP_WORDS * sizeof(u32),
>   				FLAT_DATA_ALIGN);
>   
>   		reloc = (__be32 __user *)
> @@ -714,7 +723,7 @@ static int load_flat_file(struct linux_binprm *bprm,
>   			ret = result;
>   			pr_err("Unable to read code+data+bss, errno %d\n", ret);
>   			vm_munmap(textpos, text_len + data_len + extra +
> -				MAX_SHARED_LIBS * sizeof(u32));
> +				  DATA_GAP_WORDS * sizeof(u32));
>   			goto err;
>   		}
>   	}
> 
