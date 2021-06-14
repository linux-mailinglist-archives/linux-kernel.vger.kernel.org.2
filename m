Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF5CE3A6B29
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jun 2021 18:01:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234175AbhFNQDA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Jun 2021 12:03:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233152AbhFNQC6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jun 2021 12:02:58 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55995C061574
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jun 2021 09:00:39 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id k15so10874788pfp.6
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jun 2021 09:00:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=A/YrRFRLaVHO1+sPzFsBtD9ot5MF3cKN262LxR6KfXw=;
        b=VmvGSd/M0hMCoAINvkgpn/C7SBvaCkFFXMAnoKnl5I4lxyzCcJK+OOKh8MJYLMjdsC
         O460iJithsValhtXy2H+iytvEogj/FgLjSiLedcoly9cKaiKTudoaceCZs/xpjz4cNAe
         Yv3Grcp5wfcAykM6c1qwfAWC99Bd8Szkl9JEs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=A/YrRFRLaVHO1+sPzFsBtD9ot5MF3cKN262LxR6KfXw=;
        b=F+4hmD0s2Q9iPs8hRUzESFu1K5n1UNooD7bCCO4rpnCwb/e5mJU1rFcwl/bK9wE3Fj
         SuRemDFoujOnpmccNPJXrV6mLG4HDjJbF2i+fccibqMU0oHtUr3J9hiqA62kwVR55CVo
         Vt8Fe5CA/U/Z1Ca8eLCaLUuFhmY5KWkKy6PyQXK0oJOQ9Dgxdxi4jEqpofkttq+sbJJ5
         T+QFRjFBPET/QAsGxvd4LClrbzLvxhZhx5+dSnXSVVYkthWXf0nqSiXcspng+IupZM3m
         iETmtbA1p39bMY+b9RLqjyRo3e1S5bLBhhhvpBVgchw0qUFPZqMPxeQKDUPQ6TSVOmYw
         2t2g==
X-Gm-Message-State: AOAM5334JHDr+XROnMD+tCKbAMN5tzVPxjwyTKOhe1kc16x1Q7p+BG5i
        xXGx5/q75sdmoM2M9viEKzLluQ==
X-Google-Smtp-Source: ABdhPJzIjMkPfZxvwE8qBFnjblq0arhcCk3xBhQrTQv1nIo8/LK7FcVWbuTodG/fW84e+Y2/GjVziA==
X-Received: by 2002:a05:6a00:88b:b029:2de:33b3:76c9 with SMTP id q11-20020a056a00088bb02902de33b376c9mr22662665pfj.30.1623686438816;
        Mon, 14 Jun 2021 09:00:38 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id h12sm13414232pfq.72.2021.06.14.09.00.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jun 2021 09:00:35 -0700 (PDT)
Date:   Mon, 14 Jun 2021 09:00:34 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Jarmo Tiitto <jarmo.tiitto@gmail.com>
Cc:     Sami Tolvanen <samitolvanen@google.com>,
        Bill Wendling <wcw@google.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        clang-built-linux@googlegroups.com, linux-kernel@vger.kernel.org,
        morbo@google.com
Subject: Re: [RFC PATCH 4/5] pgo: Add module notifier machinery
Message-ID: <202106140855.2094DF30BB@keescook>
References: <20210612032425.11425-1-jarmo.tiitto@gmail.com>
 <20210612032425.11425-5-jarmo.tiitto@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210612032425.11425-5-jarmo.tiitto@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 12, 2021 at 06:24:25AM +0300, Jarmo Tiitto wrote:
> Add module notifier callback and register modules
> into prf_list.
> 
> For each module that has __llvm_prf_{data,cnts,names,vnds} sections
> The callback creates debugfs <module>.profraw entry and
> links new prf_object into prf_list.
> 
> This enables profiling for all loaded modules.
> 
> * Moved rcu_read_lock() outside of allocate_node() in order
>   to protect __llvm_profile_instrument_target() from module unload(s)
> 
> Signed-off-by: Jarmo Tiitto <jarmo.tiitto@gmail.com>
> ---
> v2: Passed QEMU SMP boot test into minimal Arch Linux distro,
> module loading and unloading work without warnings.
> Module profile data looks ok. :-)
> ---
>  kernel/pgo/fs.c         | 111 ++++++++++++++++++++++++++++++++++++++++
>  kernel/pgo/instrument.c |  19 ++++---
>  2 files changed, 122 insertions(+), 8 deletions(-)
> 
> diff --git a/kernel/pgo/fs.c b/kernel/pgo/fs.c
> index 84b36e61758b..98b982245b58 100644
> --- a/kernel/pgo/fs.c
> +++ b/kernel/pgo/fs.c
> @@ -419,6 +419,110 @@ static const struct file_operations prf_reset_fops = {
>  	.llseek		= noop_llseek,
>  };
>  
> +static void pgo_module_init(struct module *mod)
> +{
> +	struct prf_object *po;
> +	char fname[MODULE_NAME_LEN + 9]; /* +strlen(".profraw") */
> +	unsigned long flags;
> +
> +	/* add new prf_object entry for the module */
> +	po = kzalloc(sizeof(*po), GFP_KERNEL);
> +	if (!po)
> +		goto out;
> +
> +	po->mod_name = mod->name;
> +
> +	fname[0] = 0;
> +	snprintf(fname, sizeof(fname), "%s.profraw", po->mod_name);
> +
> +	/* setup prf_object sections */
> +	po->data = mod->prf_data;
> +	po->data_num = prf_get_count(mod->prf_data,
> +		(char *)mod->prf_data + mod->prf_data_size, sizeof(po->data[0]));
> +
> +	po->cnts = mod->prf_cnts;
> +	po->cnts_num = prf_get_count(mod->prf_cnts,
> +		(char *)mod->prf_cnts + mod->prf_cnts_size, sizeof(po->cnts[0]));
> +
> +	po->names = mod->prf_names;
> +	po->names_num = prf_get_count(mod->prf_names,
> +		(char *)mod->prf_names + mod->prf_names_size, sizeof(po->names[0]));
> +
> +	po->vnds = mod->prf_vnds;
> +	po->vnds_num = prf_get_count(mod->prf_vnds,
> +		(char *)mod->prf_vnds + mod->prf_vnds_size, sizeof(po->vnds[0]));
> +
> +	/* create debugfs entry */
> +	po->file = debugfs_create_file(fname, 0600, directory, po, &prf_fops);
> +	if (!po->file) {
> +		pr_err("Failed to setup module pgo: %s", fname);
> +		kfree(po);
> +		goto out;
> +	}
> +
> +	/* finally enable profiling for the module */
> +	flags = prf_list_lock();
> +	list_add_tail_rcu(&po->link, &prf_list);
> +	prf_list_unlock(flags);
> +
> +out:
> +	return;
> +}
> +
> +static int pgo_module_notifier(struct notifier_block *nb, unsigned long event,
> +				void *pdata)
> +{
> +	struct module *mod = pdata;
> +	struct prf_object *po;
> +	unsigned long flags;
> +
> +	if (event == MODULE_STATE_LIVE) {
> +		/* does the module have profiling info? */
> +		if (mod->prf_data
> +			&& mod->prf_cnts
> +			&& mod->prf_names
> +			&& mod->prf_vnds) {
> +
> +			/* setup module profiling */
> +			pgo_module_init(mod);
> +		}
> +	}
> +
> +	if (event == MODULE_STATE_GOING) {
> +		/* find the prf_object from the list */
> +		rcu_read_lock();
> +
> +		list_for_each_entry_rcu(po, &prf_list, link) {
> +			if (strcmp(po->mod_name, mod->name) == 0)
> +				goto out_unlock;
> +		}
> +		/* no such module */
> +		po = NULL;
> +
> +out_unlock:
> +		rcu_read_unlock();

Is it correct to do the unlock before the possible list_del_rcu()?

> +
> +		if (po) {
> +			/* remove from profiled modules */
> +			flags = prf_list_lock();
> +			list_del_rcu(&po->link);
> +			prf_list_unlock(flags);
> +
> +			debugfs_remove(po->file);
> +			po->file = NULL;
> +
> +			/* cleanup memory */
> +			kfree_rcu(po, rcu);
> +		}

Though I thought module load/unload was already under a global lock, so
maybe a race isn't possible here.

For the next version of this series, please Cc the module subsystem
maintainer as well:
	Jessica Yu <jeyu@kernel.org>

> +	}
> +
> +	return NOTIFY_OK;
> +}
> +
> +static struct notifier_block pgo_module_nb = {
> +	.notifier_call = pgo_module_notifier
> +};
> +
>  /* Create debugfs entries. */
>  static int __init pgo_init(void)
>  {
> @@ -444,6 +548,7 @@ static int __init pgo_init(void)
>  
>  	/* enable profiling */
>  	flags = prf_list_lock();
> +	prf_vmlinux.mod_name = "vmlinux";
>  	list_add_tail_rcu(&prf_vmlinux.link, &prf_list);
>  	prf_list_unlock(flags);
>  
> @@ -460,6 +565,9 @@ static int __init pgo_init(void)
>  				 &prf_reset_fops))
>  		goto err_remove;
>  
> +	/* register module notifer */
> +	register_module_notifier(&pgo_module_nb);
> +
>  	/* show notice why the system slower: */
>  	pr_notice("Clang PGO instrumentation is active.");
>  
> @@ -473,6 +581,9 @@ static int __init pgo_init(void)
>  /* Remove debugfs entries. */
>  static void __exit pgo_exit(void)
>  {
> +	/* unsubscribe the notifier and do cleanup. */
> +	unregister_module_notifier(&pgo_module_nb);
> +
>  	debugfs_remove_recursive(directory);
>  }
>  
> diff --git a/kernel/pgo/instrument.c b/kernel/pgo/instrument.c
> index e214c9d7a113..70bab7e4c153 100644
> --- a/kernel/pgo/instrument.c
> +++ b/kernel/pgo/instrument.c
> @@ -33,7 +33,6 @@
>   * ensures that we don't try to serialize data that's only partially updated.
>   */
>  static DEFINE_SPINLOCK(pgo_lock);
> -static int current_node;
>  
>  unsigned long prf_lock(void)
>  {
> @@ -62,8 +61,6 @@ static struct llvm_prf_value_node *allocate_node(struct llvm_prf_data *p,
>  	struct llvm_prf_data *data_end;
>  	int max_vnds;
>  
> -	rcu_read_lock();
> -

Please move these rcu locks change into the patch that introduces them
to avoid adding those changes here.

>  	list_for_each_entry_rcu(po, &prf_list, link) {
>  		/* get section limits */
>  		max_vnds = prf_vnds_count(po);
> @@ -76,7 +73,6 @@ static struct llvm_prf_value_node *allocate_node(struct llvm_prf_data *p,
>  		 */
>  		if (memory_contains(po->data, data_end, p, sizeof(*p))) {
>  
> -
>  			if (WARN_ON_ONCE(po->current_node >= max_vnds))
>  				return NULL; /* Out of nodes */
>  
> @@ -87,7 +83,6 @@ static struct llvm_prf_value_node *allocate_node(struct llvm_prf_data *p,
>  	}
>  
>  out:
> -	rcu_read_unlock();
>  	return vnode;
>  }
>  
> @@ -108,8 +103,14 @@ void __llvm_profile_instrument_target(u64 target_value, void *data, u32 index)
>  	u8 values = 0;
>  	unsigned long flags;
>  
> +	/*
> +	 * lock the underlying prf_object(s) in place,
> +	 * so they won't vanish while we are operating on it.
> +	 */
> +	rcu_read_lock();
> +
>  	if (!p || !p->values)
> -		return;
> +		goto rcu_unlock;
>  
>  	counters = (struct llvm_prf_value_node **)p->values;
>  	curr = counters[index];
> @@ -117,7 +118,7 @@ void __llvm_profile_instrument_target(u64 target_value, void *data, u32 index)
>  	while (curr) {
>  		if (target_value == curr->value) {
>  			curr->count++;
> -			return;
> +			goto rcu_unlock;
>  		}
>  
>  		if (curr->count < min_count) {
> @@ -136,7 +137,7 @@ void __llvm_profile_instrument_target(u64 target_value, void *data, u32 index)
>  			curr->value = target_value;
>  			curr->count++;
>  		}
> -		return;
> +		goto rcu_unlock;
>  	}
>  
>  	/* Lock when updating the value node structure. */
> @@ -156,6 +157,8 @@ void __llvm_profile_instrument_target(u64 target_value, void *data, u32 index)
>  
>  out:
>  	prf_unlock(flags);
> +rcu_unlock:
> +	rcu_read_unlock();
>  }
>  EXPORT_SYMBOL(__llvm_profile_instrument_target);
>  
> -- 
> 2.32.0
> 

-- 
Kees Cook
