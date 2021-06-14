Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C7983A6AF2
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jun 2021 17:52:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234053AbhFNPxl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Jun 2021 11:53:41 -0400
Received: from mail-pf1-f181.google.com ([209.85.210.181]:35576 "EHLO
        mail-pf1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233910AbhFNPxj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jun 2021 11:53:39 -0400
Received: by mail-pf1-f181.google.com with SMTP id h12so10863283pfe.2
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jun 2021 08:51:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=8qXeARDYuQsLS9D8sVeex1QzQKpRZqM4RtDuxL1tv14=;
        b=G8Ho3xNVo/FgbmHr8DoT3qoxbDBfyfGayrqW7YmXRvJ0NIUncut5NNiw9C4C5wUgHQ
         jBhb3/bABU5/LJTTknwx6icB0oU2ndDyyKZKZC3OYD3tJ7DYnQ3mP/dip8T2vf6ewLGa
         r7EdhjmDZL6pCQPI68RBZl8Sai1O7759xEUIw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=8qXeARDYuQsLS9D8sVeex1QzQKpRZqM4RtDuxL1tv14=;
        b=MNZG9N+xSXOaXjVc3PfYhSpCmT1XQeYQjh0/Qqk7Me2HS6KBkktieXKjFjObHmbed8
         2GRk6KnRDxC93Zm198sJYwAaD+tC25+MkKXcCntTxINuTETRfochA/YjsP9E5RLCagJy
         869oZt4SQHdl7qNeKEBZu+kA4gzhE0jD40l1xXgmnFvTj5dq6pvXggo4uGanmh9OxQ/e
         LcNq9syKV1Q8w5ftWinpIv09P+nvNAogPwNkBiN7kAlOR/wG8vzp8pe+fRt65mX99csU
         WfXBxMHXHZbyjIjBIpW1BTcHoJnHWtfet2I0Hi1S/07qa8DjTo5B3fl5YuCHZxDQ/9pi
         HBDQ==
X-Gm-Message-State: AOAM5301d0StaIKUHOkl1V2irPHkGPJjLrSFGYqFIJ2AHkK6rlLFDFIO
        1cG1R51hDFCt1EXHysJvYwblTg==
X-Google-Smtp-Source: ABdhPJyC78BiIQJr1Yu6JDOM6akEGPSJoO0KlFthR2A30hV85MQCm9knWcG7HhExfUTdFtFldu8RXA==
X-Received: by 2002:a62:8f81:0:b029:2e9:c6d9:df67 with SMTP id n123-20020a628f810000b02902e9c6d9df67mr22526082pfd.52.1623685836890;
        Mon, 14 Jun 2021 08:50:36 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id 35sm13574654pgs.35.2021.06.14.08.50.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jun 2021 08:50:36 -0700 (PDT)
Date:   Mon, 14 Jun 2021 08:50:35 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Jarmo Tiitto <jarmo.tiitto@gmail.com>
Cc:     Sami Tolvanen <samitolvanen@google.com>,
        Bill Wendling <wcw@google.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        clang-built-linux@googlegroups.com, linux-kernel@vger.kernel.org,
        morbo@google.com
Subject: Re: [RFC PATCH 5/5] pgo: Cleanup code in pgo/fs.c
Message-ID: <202106140849.F65DB86@keescook>
References: <20210612032425.11425-1-jarmo.tiitto@gmail.com>
 <20210612032425.11425-6-jarmo.tiitto@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210612032425.11425-6-jarmo.tiitto@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 12, 2021 at 06:24:26AM +0300, Jarmo Tiitto wrote:
> Cleanups to comments and punctuation.
> Cleanup return path in pgo_module_init.

Can you include these changes in the patches that introduce the various
comments, etc? It looks like most (all?) are from patches in this
series.

-Kees

> 
> Signed-off-by: Jarmo Tiitto <jarmo.tiitto@gmail.com>
> ---
>  kernel/pgo/fs.c | 47 +++++++++++++++++++++++------------------------
>  1 file changed, 23 insertions(+), 24 deletions(-)
> 
> diff --git a/kernel/pgo/fs.c b/kernel/pgo/fs.c
> index 98b982245b58..855d5e3050fa 100644
> --- a/kernel/pgo/fs.c
> +++ b/kernel/pgo/fs.c
> @@ -294,7 +294,7 @@ static int prf_open(struct inode *inode, struct file *file)
>  	int err = -EINVAL;
>  
>  	if (WARN_ON(!inode->i_private)) {
> -		/* bug: inode was not initialized by us */
> +		/* Bug: inode was not initialized by us. */
>  		return err;
>  	}
>  
> @@ -302,7 +302,7 @@ static int prf_open(struct inode *inode, struct file *file)
>  	if (!data)
>  		return -ENOMEM;
>  
> -	/* Get prf_object of this inode */
> +	/* Get prf_object of this inode. */
>  	data->core = inode->i_private;
>  
>  	/* Get initial buffer size. */
> @@ -425,17 +425,17 @@ static void pgo_module_init(struct module *mod)
>  	char fname[MODULE_NAME_LEN + 9]; /* +strlen(".profraw") */
>  	unsigned long flags;
>  
> -	/* add new prf_object entry for the module */
> +	/* Add new prf_object entry for the module. */
>  	po = kzalloc(sizeof(*po), GFP_KERNEL);
>  	if (!po)
> -		goto out;
> +		return; /* -ENOMEM */
>  
>  	po->mod_name = mod->name;
>  
>  	fname[0] = 0;
>  	snprintf(fname, sizeof(fname), "%s.profraw", po->mod_name);
>  
> -	/* setup prf_object sections */
> +	/* Setup prf_object sections. */
>  	po->data = mod->prf_data;
>  	po->data_num = prf_get_count(mod->prf_data,
>  		(char *)mod->prf_data + mod->prf_data_size, sizeof(po->data[0]));
> @@ -452,20 +452,19 @@ static void pgo_module_init(struct module *mod)
>  	po->vnds_num = prf_get_count(mod->prf_vnds,
>  		(char *)mod->prf_vnds + mod->prf_vnds_size, sizeof(po->vnds[0]));
>  
> -	/* create debugfs entry */
> +	/* Create debugfs entry. */
>  	po->file = debugfs_create_file(fname, 0600, directory, po, &prf_fops);
>  	if (!po->file) {
>  		pr_err("Failed to setup module pgo: %s", fname);
>  		kfree(po);
> -		goto out;
> -	}
>  
> -	/* finally enable profiling for the module */
> -	flags = prf_list_lock();
> -	list_add_tail_rcu(&po->link, &prf_list);
> -	prf_list_unlock(flags);
> +	} else {
> +		/* Finally enable profiling for the module. */
> +		flags = prf_list_lock();
> +		list_add_tail_rcu(&po->link, &prf_list);
> +		prf_list_unlock(flags);
> +	}
>  
> -out:
>  	return;
>  }
>  
> @@ -477,33 +476,33 @@ static int pgo_module_notifier(struct notifier_block *nb, unsigned long event,
>  	unsigned long flags;
>  
>  	if (event == MODULE_STATE_LIVE) {
> -		/* does the module have profiling info? */
> +		/* Does the module have profiling info? */
>  		if (mod->prf_data
>  			&& mod->prf_cnts
>  			&& mod->prf_names
>  			&& mod->prf_vnds) {
>  
> -			/* setup module profiling */
> +			/* Setup module profiling. */
>  			pgo_module_init(mod);
>  		}
>  	}
>  
>  	if (event == MODULE_STATE_GOING) {
> -		/* find the prf_object from the list */
> +		/* Find the prf_object from the list. */
>  		rcu_read_lock();
>  
>  		list_for_each_entry_rcu(po, &prf_list, link) {
>  			if (strcmp(po->mod_name, mod->name) == 0)
>  				goto out_unlock;
>  		}
> -		/* no such module */
> +		/* No such module. */
>  		po = NULL;
>  
>  out_unlock:
>  		rcu_read_unlock();
>  
>  		if (po) {
> -			/* remove from profiled modules */
> +			/* Remove from profiled modules. */
>  			flags = prf_list_lock();
>  			list_del_rcu(&po->link);
>  			prf_list_unlock(flags);
> @@ -511,7 +510,7 @@ static int pgo_module_notifier(struct notifier_block *nb, unsigned long event,
>  			debugfs_remove(po->file);
>  			po->file = NULL;
>  
> -			/* cleanup memory */
> +			/* Cleanup memory. */
>  			kfree_rcu(po, rcu);
>  		}
>  	}
> @@ -528,7 +527,7 @@ static int __init pgo_init(void)
>  {
>  	unsigned long flags;
>  
> -	/* Init profiler vmlinux core entry */
> +	/* Init profiler vmlinux core entry. */
>  	memset(&prf_vmlinux, 0, sizeof(prf_vmlinux));
>  	prf_vmlinux.data = __llvm_prf_data_start;
>  	prf_vmlinux.data_num = prf_get_count(__llvm_prf_data_start,
> @@ -546,7 +545,7 @@ static int __init pgo_init(void)
>  	prf_vmlinux.vnds_num = prf_get_count(__llvm_prf_vnds_start,
>  		__llvm_prf_vnds_end, sizeof(__llvm_prf_vnds_start[0]));
>  
> -	/* enable profiling */
> +	/* Enable profiling. */
>  	flags = prf_list_lock();
>  	prf_vmlinux.mod_name = "vmlinux";
>  	list_add_tail_rcu(&prf_vmlinux.link, &prf_list);
> @@ -565,10 +564,10 @@ static int __init pgo_init(void)
>  				 &prf_reset_fops))
>  		goto err_remove;
>  
> -	/* register module notifer */
> +	/* Register module notifer. */
>  	register_module_notifier(&pgo_module_nb);
>  
> -	/* show notice why the system slower: */
> +	/* Show notice why the system slower: */
>  	pr_notice("Clang PGO instrumentation is active.");
>  
>  	return 0;
> @@ -581,7 +580,7 @@ static int __init pgo_init(void)
>  /* Remove debugfs entries. */
>  static void __exit pgo_exit(void)
>  {
> -	/* unsubscribe the notifier and do cleanup. */
> +	/* Unsubscribe the notifier and do cleanup. */
>  	unregister_module_notifier(&pgo_module_nb);
>  
>  	debugfs_remove_recursive(directory);
> -- 
> 2.32.0
> 

-- 
Kees Cook
