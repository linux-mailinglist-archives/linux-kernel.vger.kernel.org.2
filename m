Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D263C3A6B10
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jun 2021 17:56:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234442AbhFNP62 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Jun 2021 11:58:28 -0400
Received: from mail-pf1-f176.google.com ([209.85.210.176]:36463 "EHLO
        mail-pf1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233152AbhFNP61 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jun 2021 11:58:27 -0400
Received: by mail-pf1-f176.google.com with SMTP id c12so10869211pfl.3
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jun 2021 08:56:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Xc68Cs5ySmGOkpS+UW9/IL+gexfQMlCf5agz6R20UV0=;
        b=F35PJXH164Vbo9iv97Z9SBeAseF2qly74odqi14JGCFSz5futAuTDFzdzV+XjKcEQa
         e4bVH1SBCZK0Uk/n4S/tFPUzaod7mvTRvliacHh+RdNeNzSxQnU86pvEzd1v4qC3ggtP
         Dmfemyqu3a8GdKtA8ldnoENWsz95CYLTmKjI4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Xc68Cs5ySmGOkpS+UW9/IL+gexfQMlCf5agz6R20UV0=;
        b=NwOG/AWyaPE62oa20FArk1T1FG0Wbp1gNrAGaDX8uKG3mF9ujdxL7hLN8Jb8rSBntw
         uyaP8IO3aMdqG8mVrTI/JutzY0kyCYb9PLsDKf2K0C7LMUN0Ygx7FDh2QPoBoaTQ9/v+
         SX6QDR5u3+GnRiq5yLDoE32XPRRincOOO5M5a5nI5GtwPjvTKVpNWjzYl4crtI5L5XgZ
         R5Jc4G2VLvSZ8LAEYA8RQ6zLbINVrKk9wfddKqYA9AQD/6FqYMSlE7oF9OPwP6fHneof
         mRtCihtjP405MWRaavCvIo6vl8Ok6P/5O8feieZJE/voeHPTdmaJdO8w3DV79+9jBXVo
         qOBQ==
X-Gm-Message-State: AOAM531j/rPJ88t87gPKItou42PNJ18JiqREuLlOEa90BiAp8Llga8wR
        l8QNHtEmh3wE3jdzU/v1BPd8dg==
X-Google-Smtp-Source: ABdhPJwiC7DLwWH2Ft8EAgY+WqTxPgZotL8tLgmWJybCQb7qu6f/SJjO5gmVf64+UInN7fhM/VyHKA==
X-Received: by 2002:a63:1360:: with SMTP id 32mr17842483pgt.233.1623686124674;
        Mon, 14 Jun 2021 08:55:24 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id e2sm13526973pgh.5.2021.06.14.08.55.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jun 2021 08:55:24 -0700 (PDT)
Date:   Mon, 14 Jun 2021 08:55:23 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Jarmo Tiitto <jarmo.tiitto@gmail.com>
Cc:     Sami Tolvanen <samitolvanen@google.com>,
        Bill Wendling <wcw@google.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        clang-built-linux@googlegroups.com, linux-kernel@vger.kernel.org,
        morbo@google.com
Subject: Re: [RFC PATCH 3/5] pgo: Wire up the new more generic code for
 modules
Message-ID: <202106140851.2D4CAB8@keescook>
References: <20210612032425.11425-1-jarmo.tiitto@gmail.com>
 <20210612032425.11425-4-jarmo.tiitto@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210612032425.11425-4-jarmo.tiitto@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 12, 2021 at 06:24:24AM +0300, Jarmo Tiitto wrote:
> prf_open() now uses the inode->i_private to get
> the prf_object for the file. This can be either
> vmlinux.profraw or any module.profraw file.
> 
> The prf_vmlinux object is now added into prf_list and
> allocate_node() scans the list and reserves vnodes
> from corresponding prf_object(s).
> 
> Signed-off-by: Jarmo Tiitto <jarmo.tiitto@gmail.com>
> ---
> note: There is no module notifier code yet,
> so only vmlinux.profraw profile data
> is available with this commit.
> 
> Another thing is that pgo/reset will only
> reset vmlinux.profraw.
> Profile data reset for modules may be added later:
> maybe writing module's name into pgo/reset would reset only
> the specified module's profile data?
> Then writing "all" or zero would atomically reset everything.

Yeah, I think matching the internal naming is right. "vmlinux",
module::name, and "all"?

> I'm bit unsure about the new allocate_node() code since
> it is the first place I had to put rcu_read_lock()
> and the code is likely to change from this.

Comments below...

> ---
>  kernel/pgo/fs.c         | 30 ++++++++++++++++++++-----
>  kernel/pgo/instrument.c | 49 +++++++++++++++++++++++++++--------------
>  kernel/pgo/pgo.h        |  2 ++
>  3 files changed, 60 insertions(+), 21 deletions(-)
> 
> diff --git a/kernel/pgo/fs.c b/kernel/pgo/fs.c
> index 7e269d69bcd7..84b36e61758b 100644
> --- a/kernel/pgo/fs.c
> +++ b/kernel/pgo/fs.c
> @@ -32,8 +32,10 @@ static struct dentry *directory;
>  struct prf_private_data {
>  	void *buffer;
>  	size_t size;
> +	struct prf_object *core;
>  };
>  
> +/* vmlinux's prf core */
>  static struct prf_object prf_vmlinux;
>  
>  /*
> @@ -281,7 +283,6 @@ static int prf_serialize(struct prf_object *po, struct prf_private_data *p, size
>  	prf_serialize_values(po, &buffer);
>  
>  	return 0;
> -
>  }
>  
>  /* open() implementation for PGO. Creates a copy of the profiling data set. */
> @@ -292,13 +293,21 @@ static int prf_open(struct inode *inode, struct file *file)
>  	size_t buf_size;
>  	int err = -EINVAL;
>  
> +	if (WARN_ON(!inode->i_private)) {
> +		/* bug: inode was not initialized by us */
> +		return err;
> +	}
> +
>  	data = kzalloc(sizeof(*data), GFP_KERNEL);
>  	if (!data)
>  		return -ENOMEM;
>  
> +	/* Get prf_object of this inode */
> +	data->core = inode->i_private;
> +
>  	/* Get initial buffer size. */
>  	flags = prf_lock();
> -	data->size = prf_buffer_size(&prf_vmlinux);
> +	data->size = prf_buffer_size(data->core);
>  	prf_unlock(flags);
>  
>  	do {
> @@ -318,12 +327,13 @@ static int prf_open(struct inode *inode, struct file *file)
>  		 * data length in data->size.
>  		 */
>  		flags = prf_lock();
> -		err = prf_serialize(&prf_vmlinux, data, buf_size);
> +		err = prf_serialize(data->core, data, buf_size);
>  		prf_unlock(flags);
>  		/* In unlikely case, try again. */
>  	} while (err == -EAGAIN);
>  
>  	if (err < 0) {
> +
>  		if (data)
>  			vfree(data->buffer);
>  		kfree(data);
> @@ -412,6 +422,8 @@ static const struct file_operations prf_reset_fops = {
>  /* Create debugfs entries. */
>  static int __init pgo_init(void)
>  {
> +	unsigned long flags;
> +
>  	/* Init profiler vmlinux core entry */
>  	memset(&prf_vmlinux, 0, sizeof(prf_vmlinux));
>  	prf_vmlinux.data = __llvm_prf_data_start;
> @@ -430,19 +442,27 @@ static int __init pgo_init(void)
>  	prf_vmlinux.vnds_num = prf_get_count(__llvm_prf_vnds_start,
>  		__llvm_prf_vnds_end, sizeof(__llvm_prf_vnds_start[0]));
>  
> +	/* enable profiling */
> +	flags = prf_list_lock();
> +	list_add_tail_rcu(&prf_vmlinux.link, &prf_list);
> +	prf_list_unlock(flags);
>  
>  	directory = debugfs_create_dir("pgo", NULL);
>  	if (!directory)
>  		goto err_remove;
>  
> -	if (!debugfs_create_file("vmlinux.profraw", 0600, directory, NULL,
> -				 &prf_fops))
> +	prf_vmlinux.file = debugfs_create_file("vmlinux.profraw",
> +		0600, directory, &prf_vmlinux, &prf_fops);
> +	if (!prf_vmlinux.file)
>  		goto err_remove;
>  
>  	if (!debugfs_create_file("reset", 0200, directory, NULL,
>  				 &prf_reset_fops))
>  		goto err_remove;
>  
> +	/* show notice why the system slower: */
> +	pr_notice("Clang PGO instrumentation is active.");
> +

Please pull this change into a separate patch and make it pr_info()
("notice" is, I think, not right here).

>  	return 0;
>  
>  err_remove:
> diff --git a/kernel/pgo/instrument.c b/kernel/pgo/instrument.c
> index 24fdeb79b674..e214c9d7a113 100644
> --- a/kernel/pgo/instrument.c
> +++ b/kernel/pgo/instrument.c
> @@ -24,6 +24,7 @@
>  #include <linux/export.h>
>  #include <linux/spinlock.h>
>  #include <linux/types.h>
> +#include <linux/rculist.h>
>  #include "pgo.h"
>  
>  /*
> @@ -56,22 +57,38 @@ void prf_unlock(unsigned long flags)
>  static struct llvm_prf_value_node *allocate_node(struct llvm_prf_data *p,
>  						 u32 index, u64 value)
>  {
> -	const int max_vnds = prf_get_count(__llvm_prf_vnds_start,
> -		__llvm_prf_vnds_end, sizeof(struct llvm_prf_value_node));
> -
> -	/*
> -	 * Check that p is within vmlinux __llvm_prf_data section.
> -	 * If not, don't allocate since we can't handle modules yet.
> -	 */
> -	if (!memory_contains(__llvm_prf_data_start,
> -		__llvm_prf_data_end, p, sizeof(*p)))
> -		return NULL;
> -
> -	if (WARN_ON_ONCE(current_node >= max_vnds))
> -		return NULL; /* Out of nodes */
> -
> -	/* reserve vnode for vmlinux */
> -	return &__llvm_prf_vnds_start[current_node++];
> +	struct llvm_prf_value_node *vnode = NULL;
> +	struct prf_object *po;
> +	struct llvm_prf_data *data_end;
> +	int max_vnds;
> +
> +	rcu_read_lock();

AIUI, list readers are using rcu_read_lock(), and writers are using
prf_list_lock()?

> +
> +	list_for_each_entry_rcu(po, &prf_list, link) {
> +		/* get section limits */
> +		max_vnds = prf_vnds_count(po);
> +		data_end = po->data + prf_data_count(po);
> +
> +		/*
> +		 * Check that p is within:
> +		 * [po->data, po->data + prf_data_count(po)] section.
> +		 * If yes, allocate vnode from this prf_object.
> +		 */
> +		if (memory_contains(po->data, data_end, p, sizeof(*p))) {
> +
> +
> +			if (WARN_ON_ONCE(po->current_node >= max_vnds))
> +				return NULL; /* Out of nodes */
> +
> +			/* reserve the vnode */
> +			vnode = &po->vnds[po->current_node++];
> +			goto out;
> +		}
> +	}
> +
> +out:
> +	rcu_read_unlock();
> +	return vnode;
>  }
>  
>  /*
> diff --git a/kernel/pgo/pgo.h b/kernel/pgo/pgo.h
> index 44d79e2861e1..59d0aa966fbe 100644
> --- a/kernel/pgo/pgo.h
> +++ b/kernel/pgo/pgo.h
> @@ -19,6 +19,8 @@
>  #ifndef _PGO_H
>  #define _PGO_H
>  
> +#include <linux/rculist.h>
> +
>  /*
>   * Note: These internal LLVM definitions must match the compiler version.
>   * See llvm/include/llvm/ProfileData/InstrProfData.inc in LLVM's source code.
> -- 
> 2.32.0
> 

-- 
Kees Cook
