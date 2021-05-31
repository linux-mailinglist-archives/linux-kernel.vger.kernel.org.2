Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68A383967FF
	for <lists+linux-kernel@lfdr.de>; Mon, 31 May 2021 20:39:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232185AbhEaSk5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 May 2021 14:40:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:35244 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231997AbhEaSkz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 May 2021 14:40:55 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9106F610A0;
        Mon, 31 May 2021 18:39:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622486355;
        bh=8rX4IxNCvzcy69LrHZsd3l74PlDl84Y02iuH5yw/QWc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RRekc59WlsrhLZ/VYABxxgrKBHNtqkj2Zn9bxI8XA6tjQj5gulfe5GmPuoH2J6cA5
         89pRbyj4pfrwU1ZBJtxdHH7UMMmSn1b427Ee8SUM+98wA6iMAgQ0zLIIQdXrmiSt99
         DrHd+zieXGIgGVmPU9emiANcyGZfpFshie2cZiaKqwmgk1Vi4P9tTG/+EONkcrdGOx
         rLH5SB3vfNICxsTKP3RDMCj5Yt7ma9YBT3F5WMbasslKBD12KvIqGKNDCQLTOUpD8+
         WVhc6/pNGQqakLF2H7B5gHXFpmqCTIJHhk/Dh9oF8DTU0WWl47kIGwKQw6TSVrgBRh
         KeqfUUFSCl6MA==
Date:   Mon, 31 May 2021 11:39:13 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Jarmo Tiitto <jarmo.tiitto@gmail.com>
Cc:     samitolvanen@google.com, wcw@google.com, ndesaulniers@google.com,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com
Subject: Re: [PATCH 2/6] pgo: modules Add definitions in pgo/pgo.h for modules
Message-ID: <YLUtUV3ZSIqPZbX+@Ryzen-9-3900X.localdomain>
References: <20210528200432.459120-1-jarmo.tiitto@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210528200432.459120-1-jarmo.tiitto@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 28, 2021 at 11:04:32PM +0300, Jarmo Tiitto wrote:
> Add new function and struct definitions to pgo/pgo.h
> Few functions are shared by the new machinery so mark them as extern.

This patch probably belongs in 3/6 since these changes are only needed
because of that and this patch is self contained to 'kernel/pgo'.

> Signed-off-by: Jarmo Tiitto <jarmo.tiitto@gmail.com>
> ---
>  kernel/pgo/fs.c  | 13 ++++++++-----
>  kernel/pgo/pgo.h | 39 +++++++++++++++++++++++++++++++++++++++
>  2 files changed, 47 insertions(+), 5 deletions(-)
> 
> diff --git a/kernel/pgo/fs.c b/kernel/pgo/fs.c
> index 1678df3b7d64..575142735273 100644
> --- a/kernel/pgo/fs.c
> +++ b/kernel/pgo/fs.c
> @@ -26,7 +26,7 @@
>  #include <linux/vmalloc.h>
>  #include "pgo.h"
>  
> -static struct dentry *directory;
> +struct dentry *directory;
>  
>  struct prf_private_data {
>  	void *buffer;
> @@ -82,7 +82,7 @@ static void prf_copy_to_buffer(void **buffer, void *src, unsigned long size)
>  	*buffer += size;
>  }
>  
> -static u32 __prf_get_value_size(struct llvm_prf_data *p, u32 *value_kinds)
> +u32 __prf_get_value_size(struct llvm_prf_data *p, u32 *value_kinds)
>  {
>  	struct llvm_prf_value_node **nodes =
>  		(struct llvm_prf_value_node **)p->values;
> @@ -140,7 +140,7 @@ static u32 prf_get_value_size(void)
>  }
>  
>  /* Serialize the profiling's value. */
> -static void prf_serialize_value(struct llvm_prf_data *p, void **buffer)
> +void prf_serialize_value(struct llvm_prf_data *p, void **buffer)
>  {
>  	struct llvm_prf_value_data header;
>  	struct llvm_prf_value_node **nodes =
> @@ -254,7 +254,10 @@ static int prf_serialize(struct prf_private_data *p)
>  	return err;
>  }
>  
> -/* open() implementation for PGO. Creates a copy of the profiling data set. */
> +/*
> + * open() implementation for PGO.
> + * Creates a copy of the profiling data set.
> + */
>  static int prf_open(struct inode *inode, struct file *file)
>  {
>  	struct prf_private_data *data;
> @@ -292,7 +295,7 @@ static ssize_t prf_read(struct file *file, char __user *buf, size_t count,
>  	BUG_ON(!data);
>  
>  	return simple_read_from_buffer(buf, count, ppos, data->buffer,
> -				       data->size);
> +					   data->size);
>  }
>  
>  /* release() implementation for PGO. Release resources allocated by open(). */
> diff --git a/kernel/pgo/pgo.h b/kernel/pgo/pgo.h
> index ddc8d3002fe5..a9ff51abbfd5 100644
> --- a/kernel/pgo/pgo.h
> +++ b/kernel/pgo/pgo.h
> @@ -19,6 +19,11 @@
>  #ifndef _PGO_H
>  #define _PGO_H
>  
> +#include <linux/kernel.h>
> +#include <linux/debugfs.h>
> +#include <linux/fs.h>
> +#include <linux/module.h>
> +
>  /*
>   * Note: These internal LLVM definitions must match the compiler version.
>   * See llvm/include/llvm/ProfileData/InstrProfData.inc in LLVM's source code.
> @@ -200,4 +205,38 @@ __DEFINE_PRF_SIZE(vnds);
>  
>  #undef __DEFINE_PRF_SIZE
>  
> +/* debugfs directory */
> +extern struct dentry *directory;
> +
> +struct prf_mod_private_data {
> +	struct list_head link;
> +	struct rcu_head rcu;
> +
> +	void *buffer;
> +	unsigned long size;
> +
> +	char mod_name[MODULE_NAME_LEN];
> +	struct module *mod;
> +	struct dentry *file;
> +
> +	int current_node;
> +};
> +
> +/* Mutex protecting the prf_mod_list and entries */
> +extern struct mutex prf_mod_lock;
> +
> +/* List of modules profiled */
> +extern struct list_head prf_mod_list;
> +
> +extern void prf_modules_init(void);
> +extern void prf_modules_exit(void);
> +
> +/* Update each modules snapshot of the profiling data. */
> +extern int prf_modules_snapshot(void);
> +
> +/* below funcs are required by prf_modules_snapshot() */
> +extern u32 __prf_get_value_size(struct llvm_prf_data *p, u32 *value_kinds);
> +
> +extern void prf_serialize_value(struct llvm_prf_data *p, void **buffer);
> +
>  #endif /* _PGO_H */
> -- 
> 2.31.1
