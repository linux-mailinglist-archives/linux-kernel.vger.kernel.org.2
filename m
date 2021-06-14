Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FF803A6E3F
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jun 2021 20:31:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233706AbhFNSdW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Jun 2021 14:33:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232688AbhFNSdV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jun 2021 14:33:21 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7A35C061767
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jun 2021 11:31:17 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id d13so9333331ljg.12
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jun 2021 11:31:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5S+UFanMuyRSQ+8Ca0w0RcLwzSDumi9B/Nwwya8yPro=;
        b=nUgVuHh0Ed5yzIP9XnsCl/2oBrCfDxKAUznIjZLGxJOSxlTJzKE9vgumOZrku5o22J
         11tqer3Ed2uD6WKP5yxG39/amYFV+hv79nrJIiar7xqe97BrAaG+9XprduEtV2RnSK2r
         p9tpF95ehjcp10Byfq9DFsXMas5XIMND/FVm1W+nhYUME8D0k+5/yYASECPdNQkAelnY
         Oymy6FVwHqmIlNVJw+DGZN4BldCc2k9LUdCHnynQL827Juhrmr/vYx0LZ7SYvawmhoXU
         Gd0NbWNv63b4HndxdiHKA1koY3bJRgRBFmv77SKUS6u1jruyCz+sKUx8tBxBL7EC+wTR
         3l6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5S+UFanMuyRSQ+8Ca0w0RcLwzSDumi9B/Nwwya8yPro=;
        b=KKs9t2THefdojX37YgCgBN5wTREpOWnYw4Gcy0UlEpyhopnDMDqm4Aqu5SiV2xmrvY
         8iN4DBpBCPJv+U3M6cIEdKA+GB011PsOnVjkj/qUbbX0sBdGvACEH1pY881iZlQzXd5g
         ZOmROJQgkjK72g9gEJQXGzzi5KFu5iWVp9deiaDwU/b3uCZsGGafLzDg8su4xP/n/9en
         5lkt4dV5SzIuGLoMG8e6J9KZDdZVG+lVPxLd9UjvxmoWuUIlD0cl7VUNjx9mw1M2gRor
         1rcVY2sLyBmR32SU+9lXc49PjCmAelzmVDjzX8jyRsgWtxEGuGgujZrbb35dpmB/rr/N
         xWjQ==
X-Gm-Message-State: AOAM531O/ByaXdO9FOohee8i/ccaNBMf5zmnVAtTGqKQ4YpUDuSkBMeh
        nBprVFmobAviajUmWNt6jPs=
X-Google-Smtp-Source: ABdhPJxmiAipr7WMPVw9TMJ10PPpbfh4fi3EOvYxuP6URgWOIbbvYQqiaFjwwr1QERwaXZVbcgb7KQ==
X-Received: by 2002:a05:651c:3c6:: with SMTP id f6mr14053150ljp.456.1623695476301;
        Mon, 14 Jun 2021 11:31:16 -0700 (PDT)
Received: from hyperiorarchmachine.localnet (dcx7x4yffpgq---2xhdgy-3.rev.dnainternet.fi. [2001:14ba:14f7:3c00:8461:5bff:fed3:30ca])
        by smtp.gmail.com with ESMTPSA id k10sm1895967ljm.39.2021.06.14.11.31.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jun 2021 11:31:15 -0700 (PDT)
From:   jarmo.tiitto@gmail.com
To:     Jarmo Tiitto <jarmo.tiitto@gmail.com>,
        Kees Cook <keescook@chromium.org>
Cc:     Sami Tolvanen <samitolvanen@google.com>,
        Bill Wendling <wcw@google.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        clang-built-linux@googlegroups.com, linux-kernel@vger.kernel.org,
        morbo@google.com, jeyu@kernel.org
Subject: Re: [RFC PATCH 4/5] pgo: Add module notifier machinery
Date:   Mon, 14 Jun 2021 21:31:14 +0300
Message-ID: <8638842.4sDhnmlMBm@hyperiorarchmachine>
In-Reply-To: <202106140855.2094DF30BB@keescook>
References: <20210612032425.11425-1-jarmo.tiitto@gmail.com> <20210612032425.11425-5-jarmo.tiitto@gmail.com> <202106140855.2094DF30BB@keescook>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kees Cook wrote maanantaina 14. kes=C3=A4kuuta 2021 19.00.34 EEST:
> On Sat, Jun 12, 2021 at 06:24:25AM +0300, Jarmo Tiitto wrote:
> > Add module notifier callback and register modules
> > into prf_list.
> >=20
> > For each module that has __llvm_prf_{data,cnts,names,vnds} sections
> > The callback creates debugfs <module>.profraw entry and
> > links new prf_object into prf_list.
> >=20
> > This enables profiling for all loaded modules.
> >=20
> > * Moved rcu_read_lock() outside of allocate_node() in order
> >=20
> >   to protect __llvm_profile_instrument_target() from module unload(s)
> >=20
> > Signed-off-by: Jarmo Tiitto <jarmo.tiitto@gmail.com>
> > ---
> > v2: Passed QEMU SMP boot test into minimal Arch Linux distro,
> > module loading and unloading work without warnings.
> > Module profile data looks ok. :-)
> > ---
> >=20
> >  kernel/pgo/fs.c         | 111 ++++++++++++++++++++++++++++++++++++++++
> >  kernel/pgo/instrument.c |  19 ++++---
> >  2 files changed, 122 insertions(+), 8 deletions(-)
> >=20
> > diff --git a/kernel/pgo/fs.c b/kernel/pgo/fs.c
> > index 84b36e61758b..98b982245b58 100644
> > --- a/kernel/pgo/fs.c
> > +++ b/kernel/pgo/fs.c
> > @@ -419,6 +419,110 @@ static const struct file_operations prf_reset_fop=
s =3D=20
{
> >=20
> >  	.llseek		=3D noop_llseek,
> > =20
> >  };
> >=20
> > +static void pgo_module_init(struct module *mod)
> > +{
> > +	struct prf_object *po;
> > +	char fname[MODULE_NAME_LEN + 9]; /* +strlen(".profraw") */
> > +	unsigned long flags;
> > +
> > +	/* add new prf_object entry for the module */
> > +	po =3D kzalloc(sizeof(*po), GFP_KERNEL);
> > +	if (!po)
> > +		goto out;
> > +
> > +	po->mod_name =3D mod->name;
> > +
> > +	fname[0] =3D 0;
> > +	snprintf(fname, sizeof(fname), "%s.profraw", po->mod_name);
> > +
> > +	/* setup prf_object sections */
> > +	po->data =3D mod->prf_data;
> > +	po->data_num =3D prf_get_count(mod->prf_data,
> > +		(char *)mod->prf_data + mod->prf_data_size,=20
sizeof(po->data[0]));
> > +
> > +	po->cnts =3D mod->prf_cnts;
> > +	po->cnts_num =3D prf_get_count(mod->prf_cnts,
> > +		(char *)mod->prf_cnts + mod->prf_cnts_size,=20
sizeof(po->cnts[0]));
> > +
> > +	po->names =3D mod->prf_names;
> > +	po->names_num =3D prf_get_count(mod->prf_names,
> > +		(char *)mod->prf_names + mod->prf_names_size,=20
sizeof(po->names[0]));
> > +
> > +	po->vnds =3D mod->prf_vnds;
> > +	po->vnds_num =3D prf_get_count(mod->prf_vnds,
> > +		(char *)mod->prf_vnds + mod->prf_vnds_size,=20
sizeof(po->vnds[0]));
> > +
> > +	/* create debugfs entry */
> > +	po->file =3D debugfs_create_file(fname, 0600, directory, po,=20
&prf_fops);
> > +	if (!po->file) {
> > +		pr_err("Failed to setup module pgo: %s", fname);
> > +		kfree(po);
> > +		goto out;
> > +	}
> > +
> > +	/* finally enable profiling for the module */
> > +	flags =3D prf_list_lock();
> > +	list_add_tail_rcu(&po->link, &prf_list);
> > +	prf_list_unlock(flags);
> > +
> > +out:
> > +	return;
> > +}
> > +
> > +static int pgo_module_notifier(struct notifier_block *nb, unsigned long
> > event, +				void *pdata)
> > +{
> > +	struct module *mod =3D pdata;
> > +	struct prf_object *po;
> > +	unsigned long flags;
> > +
> > +	if (event =3D=3D MODULE_STATE_LIVE) {
> > +		/* does the module have profiling info? */
> > +		if (mod->prf_data
> > +			&& mod->prf_cnts
> > +			&& mod->prf_names
> > +			&& mod->prf_vnds) {
> > +
> > +			/* setup module profiling */
> > +			pgo_module_init(mod);
> > +		}
> > +	}
> > +
> > +	if (event =3D=3D MODULE_STATE_GOING) {
> > +		/* find the prf_object from the list */
> > +		rcu_read_lock();
> > +
> > +		list_for_each_entry_rcu(po, &prf_list, link) {
> > +			if (strcmp(po->mod_name, mod->name) =3D=3D=20
0)
> > +				goto out_unlock;
> > +		}
> > +		/* no such module */
> > +		po =3D NULL;
> > +
> > +out_unlock:
> > +		rcu_read_unlock();
>=20
> Is it correct to do the unlock before the possible list_del_rcu()?
>=20

Oh, list_del_rcu() should then propably go before unlocking. I'll fix that.

> > +
> > +		if (po) {
> > +			/* remove from profiled modules */
> > +			flags =3D prf_list_lock();
> > +			list_del_rcu(&po->link);
> > +			prf_list_unlock(flags);
> > +
> > +			debugfs_remove(po->file);
> > +			po->file =3D NULL;
> > +
> > +			/* cleanup memory */
> > +			kfree_rcu(po, rcu);
> > +		}
>=20
> Though I thought module load/unload was already under a global lock, so
> maybe a race isn't possible here.
>=20

I searched a bit and found out that module.c/module_mutex is not held during
the module notifier MODULE_STATE_GOING callbacks.
But the callback it only invoked only once per module un/load so I think it=
 is=20
okay.
If I remember correctly, the main reason I moved the tear down code after=20
rcu_read_unlock() was that debugfs_remove() may sleep.


> For the next version of this series, please Cc the module subsystem
> maintainer as well:
> 	Jessica Yu <jeyu@kernel.org>
>=20

OK, after all there is a lot of pointers to the kernel's module subsys.

> > +	}
> > +
> > +	return NOTIFY_OK;
> > +}
> > +
> > +static struct notifier_block pgo_module_nb =3D {
> > +	.notifier_call =3D pgo_module_notifier
> > +};
> > +
> >=20
> >  /* Create debugfs entries. */
> >  static int __init pgo_init(void)
> >  {
> >=20
> > @@ -444,6 +548,7 @@ static int __init pgo_init(void)
> >=20
> >  	/* enable profiling */
> >  	flags =3D prf_list_lock();
> >=20
> > +	prf_vmlinux.mod_name =3D "vmlinux";
> >=20
> >  	list_add_tail_rcu(&prf_vmlinux.link, &prf_list);
> >  	prf_list_unlock(flags);
> >=20
> > @@ -460,6 +565,9 @@ static int __init pgo_init(void)
> >=20
> >  				 &prf_reset_fops))
> >  	=09
> >  		goto err_remove;
> >=20
> > +	/* register module notifer */
> > +	register_module_notifier(&pgo_module_nb);
> > +
> >=20
> >  	/* show notice why the system slower: */
> >  	pr_notice("Clang PGO instrumentation is active.");
> >=20
> > @@ -473,6 +581,9 @@ static int __init pgo_init(void)
> >=20
> >  /* Remove debugfs entries. */
> >  static void __exit pgo_exit(void)
> >  {
> >=20
> > +	/* unsubscribe the notifier and do cleanup. */
> > +	unregister_module_notifier(&pgo_module_nb);
> > +
> >=20
> >  	debugfs_remove_recursive(directory);
> > =20
> >  }
> >=20
> > diff --git a/kernel/pgo/instrument.c b/kernel/pgo/instrument.c
> > index e214c9d7a113..70bab7e4c153 100644
> > --- a/kernel/pgo/instrument.c
> > +++ b/kernel/pgo/instrument.c
> > @@ -33,7 +33,6 @@
> >=20
> >   * ensures that we don't try to serialize data that's only partially
> >   updated.
> >   */
> > =20
> >  static DEFINE_SPINLOCK(pgo_lock);
> >=20
> > -static int current_node;
> >=20
> >  unsigned long prf_lock(void)
> >  {
> >=20
> > @@ -62,8 +61,6 @@ static struct llvm_prf_value_node *allocate_node(stru=
ct
> > llvm_prf_data *p,>=20
> >  	struct llvm_prf_data *data_end;
> >  	int max_vnds;
> >=20
> > -	rcu_read_lock();
> > -
>=20
> Please move these rcu locks change into the patch that introduces them
> to avoid adding those changes here.
>=20
> >  	list_for_each_entry_rcu(po, &prf_list, link) {
> >  =09
> >  		/* get section limits */
> >  		max_vnds =3D prf_vnds_count(po);
> >=20
> > @@ -76,7 +73,6 @@ static struct llvm_prf_value_node *allocate_node(stru=
ct
> > llvm_prf_data *p,>=20
> >  		 */
> >  	=09
> >  		if (memory_contains(po->data, data_end, p,=20
sizeof(*p))) {
> >=20
> > -
> >=20
> >  			if (WARN_ON_ONCE(po->current_node >=3D=20
max_vnds))
> >  		=09
> >  				return NULL; /* Out of=20
nodes */
> >=20
> > @@ -87,7 +83,6 @@ static struct llvm_prf_value_node *allocate_node(stru=
ct
> > llvm_prf_data *p,>=20
> >  	}
> > =20
> >  out:
> > -	rcu_read_unlock();
> >=20
> >  	return vnode;
> > =20
> >  }
> >=20
> > @@ -108,8 +103,14 @@ void __llvm_profile_instrument_target(u64=20
target_value,
> > void *data, u32 index)>=20
> >  	u8 values =3D 0;
> >  	unsigned long flags;
> >=20
> > +	/*
> > +	 * lock the underlying prf_object(s) in place,
> > +	 * so they won't vanish while we are operating on it.
> > +	 */
> > +	rcu_read_lock();
> > +
> >=20
> >  	if (!p || !p->values)
> >=20
> > -		return;
> > +		goto rcu_unlock;
> >=20
> >  	counters =3D (struct llvm_prf_value_node **)p->values;
> >  	curr =3D counters[index];
> >=20
> > @@ -117,7 +118,7 @@ void __llvm_profile_instrument_target(u64 target_va=
lue,
> > void *data, u32 index)>=20
> >  	while (curr) {
> >  =09
> >  		if (target_value =3D=3D curr->value) {
> >  	=09
> >  			curr->count++;
> >=20
> > -			return;
> > +			goto rcu_unlock;
> >=20
> >  		}
> >  	=09
> >  		if (curr->count < min_count) {
> >=20
> > @@ -136,7 +137,7 @@ void __llvm_profile_instrument_target(u64 target_va=
lue,
> > void *data, u32 index)>=20
> >  			curr->value =3D target_value;
> >  			curr->count++;
> >  	=09
> >  		}
> >=20
> > -		return;
> > +		goto rcu_unlock;
> >=20
> >  	}
> >  =09
> >  	/* Lock when updating the value node structure. */
> >=20
> > @@ -156,6 +157,8 @@ void __llvm_profile_instrument_target(u64 target_va=
lue,
> > void *data, u32 index)>=20
> >  out:
> >  	prf_unlock(flags);
> >=20
> > +rcu_unlock:
> > +	rcu_read_unlock();
> >=20
> >  }
> >  EXPORT_SYMBOL(__llvm_profile_instrument_target);
> >=20
> > --
> > 2.32.0
>=20
> --
> Kees Cook




