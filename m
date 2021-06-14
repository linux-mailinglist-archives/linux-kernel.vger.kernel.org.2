Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B03EA3A6E90
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jun 2021 21:08:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233639AbhFNTKR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Jun 2021 15:10:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233507AbhFNTKO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jun 2021 15:10:14 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 506B0C061574
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jun 2021 12:08:11 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id r5so22832644lfr.5
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jun 2021 12:08:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ib71WC/3UL+4kN8wAu0hjCKNoFyLxGNskm1j3/2F/J0=;
        b=sP/OkhF/GE8JhIunUPFh/xQUcoycoxC1nNMPB0GyDxqL8nHwcny55mjSZ3qs/rEw8O
         3MwxPzMYxPjnI58mm0TyRv9zEDhyXWqeynN47SMJP0PlTfqH8wxjrARY0cGmV8Zi5WM/
         u+teIft/zgh+kh4GoR/SZZHsatnS/XxSfGV+Ym1+MAZS9CGhJU6pUhO2SI8xSPT+wsEc
         0zFr8iCteVMwqXxX3VY5wdrjLZrfmKojb+lvi/UM83B/SurHkp9ds7nNqZ8esrdAAafz
         S9faxr0CGsbBYUOr0pm+X5V+bhSBlJjJLSyIT5gt87zr3uk6kmDSsnCS8rgfsHuz29wP
         6ZeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ib71WC/3UL+4kN8wAu0hjCKNoFyLxGNskm1j3/2F/J0=;
        b=cLvKA8iYAaKCu/yU0aI8ir1qbvDGyUQPwYSIzIMDYznG+Qqkbw96qsl2q9vinzhXVP
         97EGhNi1/nCe5e4OYlayf1Ads9B1kGJrHDDACjSXO7FIthHaNUHpLFW3Atfb+a676Bcd
         gKmUxZAma+vvgJTFxzDoZi6iMnsY/TP9V0AzW75j10eaf46GLzkOdaPhydfavmdRsiET
         nBqIdVojcAUn4Kxr0UjmMCFfKIKSMOOpOL6ykZWxOv2hp+70cqlNl62rPKNCeBIDIgYu
         ZiEJ6d4tv0GCmiJD25TNh4F9AKkZafXdWpJeXbb/XCu196i3kqCY2u1T8EVvj73Ctqoo
         vx3g==
X-Gm-Message-State: AOAM530QxB3K5eFP+wx2H1dhJtsdd7ObuMlorV0RQUZA63vWY2K77S+K
        /sAU65sHdBi3y2v8rqot/ic=
X-Google-Smtp-Source: ABdhPJyIPrqAd7P2VXSa/9g9ABIiQQfR+DjRNcuyHzPmojEWn81p28a/0ePbIKRbmLwkmFHqyp9HhQ==
X-Received: by 2002:ac2:530c:: with SMTP id c12mr13315409lfh.514.1623697688361;
        Mon, 14 Jun 2021 12:08:08 -0700 (PDT)
Received: from hyperiorarchmachine.localnet (dcx7x4yffpgq---2xhdgy-3.rev.dnainternet.fi. [2001:14ba:14f7:3c00:8461:5bff:fed3:30ca])
        by smtp.gmail.com with ESMTPSA id x1sm699760lji.19.2021.06.14.12.08.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jun 2021 12:08:07 -0700 (PDT)
From:   jarmo.tiitto@gmail.com
To:     Kees Cook <keescook@chromium.org>
Cc:     Jarmo Tiitto <jarmo.tiitto@gmail.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        Bill Wendling <wcw@google.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        clang-built-linux@googlegroups.com, linux-kernel@vger.kernel.org,
        morbo@google.com
Subject: Re: [RFC PATCH 3/5] pgo: Wire up the new more generic code for modules
Date:   Mon, 14 Jun 2021 22:08:06 +0300
Message-ID: <3322609.HabJG8yQ7u@hyperiorarchmachine>
In-Reply-To: <202106140851.2D4CAB8@keescook>
References: <20210612032425.11425-1-jarmo.tiitto@gmail.com> <20210612032425.11425-4-jarmo.tiitto@gmail.com> <202106140851.2D4CAB8@keescook>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kees Cook wrote maanantaina 14. kes=C3=A4kuuta 2021 18.55.23 EEST:
> On Sat, Jun 12, 2021 at 06:24:24AM +0300, Jarmo Tiitto wrote:
> > prf_open() now uses the inode->i_private to get
> > the prf_object for the file. This can be either
> > vmlinux.profraw or any module.profraw file.
> >=20
> > The prf_vmlinux object is now added into prf_list and
> > allocate_node() scans the list and reserves vnodes
> > from corresponding prf_object(s).
> >=20
> > Signed-off-by: Jarmo Tiitto <jarmo.tiitto@gmail.com>
> > ---
> > note: There is no module notifier code yet,
> > so only vmlinux.profraw profile data
> > is available with this commit.
> >=20
> > Another thing is that pgo/reset will only
> > reset vmlinux.profraw.
> > Profile data reset for modules may be added later:
> > maybe writing module's name into pgo/reset would reset only
> > the specified module's profile data?
> > Then writing "all" or zero would atomically reset everything.
>=20
> Yeah, I think matching the internal naming is right. "vmlinux",
> module::name, and "all"?
>=20
> > I'm bit unsure about the new allocate_node() code since
> > it is the first place I had to put rcu_read_lock()
> > and the code is likely to change from this.
>=20
> Comments below...
>=20
> > ---
> >=20
> >  kernel/pgo/fs.c         | 30 ++++++++++++++++++++-----
> >  kernel/pgo/instrument.c | 49 +++++++++++++++++++++++++++--------------
> >  kernel/pgo/pgo.h        |  2 ++
> >  3 files changed, 60 insertions(+), 21 deletions(-)
> >=20
> > diff --git a/kernel/pgo/fs.c b/kernel/pgo/fs.c
> > index 7e269d69bcd7..84b36e61758b 100644
> > --- a/kernel/pgo/fs.c
> > +++ b/kernel/pgo/fs.c
> > @@ -32,8 +32,10 @@ static struct dentry *directory;
> >=20
> >  struct prf_private_data {
> > =20
> >  	void *buffer;
> >  	size_t size;
> >=20
> > +	struct prf_object *core;
> >=20
> >  };
> >=20
> > +/* vmlinux's prf core */
> >=20
> >  static struct prf_object prf_vmlinux;
> > =20
> >  /*
> >=20
> > @@ -281,7 +283,6 @@ static int prf_serialize(struct prf_object *po, str=
uct
> > prf_private_data *p, size>=20
> >  	prf_serialize_values(po, &buffer);
> >  =09
> >  	return 0;
> >=20
> > -
> >=20
> >  }
> > =20
> >  /* open() implementation for PGO. Creates a copy of the profiling data=
=20
set.
> >  */>=20
> > @@ -292,13 +293,21 @@ static int prf_open(struct inode *inode, struct f=
ile
> > *file)>=20
> >  	size_t buf_size;
> >  	int err =3D -EINVAL;
> >=20
> > +	if (WARN_ON(!inode->i_private)) {
> > +		/* bug: inode was not initialized by us */
> > +		return err;
> > +	}
> > +
> >=20
> >  	data =3D kzalloc(sizeof(*data), GFP_KERNEL);
> >  	if (!data)
> >  =09
> >  		return -ENOMEM;
> >=20
> > +	/* Get prf_object of this inode */
> > +	data->core =3D inode->i_private;
> > +
> >=20
> >  	/* Get initial buffer size. */
> >  	flags =3D prf_lock();
> >=20
> > -	data->size =3D prf_buffer_size(&prf_vmlinux);
> > +	data->size =3D prf_buffer_size(data->core);
> >=20
> >  	prf_unlock(flags);
> >  =09
> >  	do {
> >=20
> > @@ -318,12 +327,13 @@ static int prf_open(struct inode *inode, struct f=
ile
> > *file)>=20
> >  		 * data length in data->size.
> >  		 */
> >  	=09
> >  		flags =3D prf_lock();
> >=20
> > -		err =3D prf_serialize(&prf_vmlinux, data, buf_size);
> > +		err =3D prf_serialize(data->core, data, buf_size);
> >=20
> >  		prf_unlock(flags);
> >  		/* In unlikely case, try again. */
> >  =09
> >  	} while (err =3D=3D -EAGAIN);
> >  =09
> >  	if (err < 0) {
> >=20
> > +
> >=20
> >  		if (data)
> >  	=09
> >  			vfree(data->buffer);
> >  	=09
> >  		kfree(data);
> >=20
> > @@ -412,6 +422,8 @@ static const struct file_operations prf_reset_fops =
=3D {
> >=20
> >  /* Create debugfs entries. */
> >  static int __init pgo_init(void)
> >  {
> >=20
> > +	unsigned long flags;
> > +
> >=20
> >  	/* Init profiler vmlinux core entry */
> >  	memset(&prf_vmlinux, 0, sizeof(prf_vmlinux));
> >  	prf_vmlinux.data =3D __llvm_prf_data_start;
> >=20
> > @@ -430,19 +442,27 @@ static int __init pgo_init(void)
> >=20
> >  	prf_vmlinux.vnds_num =3D prf_get_count(__llvm_prf_vnds_start,
> >  =09
> >  		__llvm_prf_vnds_end,=20
sizeof(__llvm_prf_vnds_start[0]));
> >=20
> > +	/* enable profiling */
> > +	flags =3D prf_list_lock();
> > +	list_add_tail_rcu(&prf_vmlinux.link, &prf_list);
> > +	prf_list_unlock(flags);
> >=20
> >  	directory =3D debugfs_create_dir("pgo", NULL);
> >  	if (!directory)
> >  =09
> >  		goto err_remove;
> >=20
> > -	if (!debugfs_create_file("vmlinux.profraw", 0600, directory, NULL,
> > -				 &prf_fops))
> > +	prf_vmlinux.file =3D debugfs_create_file("vmlinux.profraw",
> > +		0600, directory, &prf_vmlinux, &prf_fops);
> > +	if (!prf_vmlinux.file)
> >=20
> >  		goto err_remove;
> >  =09
> >  	if (!debugfs_create_file("reset", 0200, directory, NULL,
> >  =09
> >  				 &prf_reset_fops))
> >  	=09
> >  		goto err_remove;
> >=20
> > +	/* show notice why the system slower: */
> > +	pr_notice("Clang PGO instrumentation is active.");
> > +
>=20
> Please pull this change into a separate patch and make it pr_info()
> ("notice" is, I think, not right here).
>=20

All rightly then.

> >  	return 0;
> > =20
> >  err_remove:
> > diff --git a/kernel/pgo/instrument.c b/kernel/pgo/instrument.c
> > index 24fdeb79b674..e214c9d7a113 100644
> > --- a/kernel/pgo/instrument.c
> > +++ b/kernel/pgo/instrument.c
> > @@ -24,6 +24,7 @@
> >=20
> >  #include <linux/export.h>
> >  #include <linux/spinlock.h>
> >  #include <linux/types.h>
> >=20
> > +#include <linux/rculist.h>
> >=20
> >  #include "pgo.h"
> > =20
> >  /*
> >=20
> > @@ -56,22 +57,38 @@ void prf_unlock(unsigned long flags)
> >=20
> >  static struct llvm_prf_value_node *allocate_node(struct llvm_prf_data =
*p,
> > =20
> >  						=20
u32 index, u64 value)
> > =20
> >  {
> >=20
> > -	const int max_vnds =3D prf_get_count(__llvm_prf_vnds_start,
> > -		__llvm_prf_vnds_end, sizeof(struct=20
llvm_prf_value_node));
> > -
> > -	/*
> > -	 * Check that p is within vmlinux __llvm_prf_data section.
> > -	 * If not, don't allocate since we can't handle modules yet.
> > -	 */
> > -	if (!memory_contains(__llvm_prf_data_start,
> > -		__llvm_prf_data_end, p, sizeof(*p)))
> > -		return NULL;
> > -
> > -	if (WARN_ON_ONCE(current_node >=3D max_vnds))
> > -		return NULL; /* Out of nodes */
> > -
> > -	/* reserve vnode for vmlinux */
> > -	return &__llvm_prf_vnds_start[current_node++];
> > +	struct llvm_prf_value_node *vnode =3D NULL;
> > +	struct prf_object *po;
> > +	struct llvm_prf_data *data_end;
> > +	int max_vnds;
> > +
> > +	rcu_read_lock();
>=20
> AIUI, list readers are using rcu_read_lock(), and writers are using
> prf_list_lock()?
>=20

Yes, I intended the list readers to use rcu_read_lock() and writers to take=
=20
the prf_list_lock().

Sadly after I sent this patch set I found during more testing that there ar=
e=20
few problems that I need to work on:

There is an lockup that only occurs during bare metal run after +15min, so =
I=20
haven't been able to catch it in VM.
I suspect this is caused by the RCU locking I added such that it results in=
=20
recursive calls into __llvm_profile_instrument_target()

I will try build with CONFIG_PROVE_LOCKING, but I have had problems with
the kernel not getting past cgroup_init_early()... even without my patches
applied. (stock -rc kernel) :-(

> > +
> > +	list_for_each_entry_rcu(po, &prf_list, link) {
> > +		/* get section limits */
> > +		max_vnds =3D prf_vnds_count(po);
> > +		data_end =3D po->data + prf_data_count(po);
> > +
> > +		/*
> > +		 * Check that p is within:
> > +		 * [po->data, po->data + prf_data_count(po)] section.
> > +		 * If yes, allocate vnode from this prf_object.
> > +		 */
> > +		if (memory_contains(po->data, data_end, p,=20
sizeof(*p))) {
> > +
> > +
> > +			if (WARN_ON_ONCE(po->current_node >=3D=20
max_vnds))
> > +				return NULL; /* Out of=20
nodes */
> > +
> > +			/* reserve the vnode */
> > +			vnode =3D &po->vnds[po->current_node++];
> > +			goto out;
> > +		}
> > +	}
> > +
> > +out:
> > +	rcu_read_unlock();
> > +	return vnode;
> >=20
> >  }
> > =20
> >  /*
> >=20
> > diff --git a/kernel/pgo/pgo.h b/kernel/pgo/pgo.h
> > index 44d79e2861e1..59d0aa966fbe 100644
> > --- a/kernel/pgo/pgo.h
> > +++ b/kernel/pgo/pgo.h
> > @@ -19,6 +19,8 @@
> >=20
> >  #ifndef _PGO_H
> >  #define _PGO_H
> >=20
> > +#include <linux/rculist.h>
> > +
> >=20
> >  /*
> > =20
> >   * Note: These internal LLVM definitions must match the compiler versi=
on.
> >   * See llvm/include/llvm/ProfileData/InstrProfData.inc in LLVM's source
> >   code.
> >=20
> > --
> > 2.32.0
>=20
> --
> Kees Cook




