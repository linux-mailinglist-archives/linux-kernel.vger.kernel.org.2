Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B65C8397414
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jun 2021 15:26:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233924AbhFAN1p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Jun 2021 09:27:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233584AbhFAN1n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jun 2021 09:27:43 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0808FC061574
        for <linux-kernel@vger.kernel.org>; Tue,  1 Jun 2021 06:26:01 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id e11so19169441ljn.13
        for <linux-kernel@vger.kernel.org>; Tue, 01 Jun 2021 06:26:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IV6gpMfEp5k+C8R/I9/X6EpLVmrNL9faao5o5EuVJmk=;
        b=hMY8JARxtEtSZiUY9XcZ9mNW7BD2HnB8YdaOPB4buvNGlEUFIMojQb4JZMh3SYQUR+
         TEVOIaYQ4owN/8gbpyKIFkxu/bMKHlGWj93DRargz91SyXWSF0XWE2epRqtWMifGipJN
         CX/xmJb9XJSl6ad3HqgM0gHxryz7JdJcM6DX8E1swF1V7DySaYSSeFx9Y3qMStSejp7q
         Za2HtMGYhARVp+hzYCSMRLow91ELXkXfDQ8SUIWt0B+LoWweMgvjwuafN5M+QCVpsYKH
         03fpHCZeJVOo/HDoGdY90n+egU3Y/m7kVUB1CXQbRXbq8nq21YnYW5VbHe9Xp3xYxBuj
         C0UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IV6gpMfEp5k+C8R/I9/X6EpLVmrNL9faao5o5EuVJmk=;
        b=nT8qIe51hwZHcLDSKnr93/yD2goY03s0CzQKSHdMhSGtwtDRr8gaV9npVrKzWxSR32
         N0pSk06pqBmb48Mx6BTpoBJlKDEgTpPNm+X3ev3kYfLkU+KzkaeHRw8TVAtBaFIRIwCQ
         1/u/GxJ0WW+djp2KKyfJAOSArRFAOYvzQ9q7os2YrjOTkXAlbQOkRfVZ9jNMkjQ4gl0O
         3KyS9IGMg80T2YspNm6jiMviMuzO0dd6iBMHuiwvffORR+JNRMUyByxVs6Uh89PDv+yx
         98EWgzr9i4q+SRrIJw1TD7qLMJf3LikVz8ljJnblkvfJ1XnZh9N8OnLW5Wz25S6Ppojc
         dt0Q==
X-Gm-Message-State: AOAM533Rm0FqaoqMS58pLZMpVqCNtL/fgb4vb5oOzRg19ZEkoDM0gSns
        2GlLKDbK5uQxfbPp3R/g4/w=
X-Google-Smtp-Source: ABdhPJxnGodcWOEAfnBXolcIEU9R0RbgxZFtvgyXzCwmEHN7qgeBYOoKwps7hBwhhgnRQKNc5vIc3Q==
X-Received: by 2002:a2e:a314:: with SMTP id l20mr20730990lje.167.1622553959215;
        Tue, 01 Jun 2021 06:25:59 -0700 (PDT)
Received: from hyperiorarchmachine.localnet (dcx7x4yjzw5k---2xbt6t-3.rev.dnainternet.fi. [2001:14ba:14f7:3c00:f496:51ff:fed3:c35])
        by smtp.gmail.com with ESMTPSA id h9sm1677635lfu.305.2021.06.01.06.25.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jun 2021 06:25:58 -0700 (PDT)
From:   jarmo.tiitto@gmail.com
To:     Bill Wendling <morbo@google.com>
Cc:     wcw@google.com, samitolvanen@google.com, ndesaulniers@google.com,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com,
        jeyu@kernel.org
Subject: Re: [PATCH 3/6] pgo: modules Add module profile data export machinery.
Date:   Tue, 01 Jun 2021 16:25:57 +0300
Message-ID: <2450763.S1xdTQMYLV@hyperiorarchmachine>
In-Reply-To: <CAGG=3QXtisfabaiVP6y_3sjGsM7cQmPhur8Zqor4qkGrbiXpBA@mail.gmail.com>
References: <20210528200821.459214-1-jarmo.tiitto@gmail.com> <YLU0VAoWG7qa7u24@Ryzen-9-3900X.localdomain> <CAGG=3QXtisfabaiVP6y_3sjGsM7cQmPhur8Zqor4qkGrbiXpBA@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kirjoitit tiistaina 1. kes=C3=A4kuuta 2021 11.33.48 EEST:
> On Mon, May 31, 2021 at 12:09 PM Nathan Chancellor <nathan@kernel.org>=20
wrote:
> > On Fri, May 28, 2021 at 11:08:21PM +0300, Jarmo Tiitto wrote:
> > > PGO profile data is exported from the kernel by
> > > creating debugfs files: pgo/<module>.profraw for each module.
> >=20
> > Again, I do not really have many comments on the actual code as I am not
> > super familiar with it.
> >=20
> > However, fs_mod.c duplicates a lot of the functions in fs.c, which makes
> > maintaining this code even more difficult, especially against LLVM PGO
> > profile data format changes. I just want to make sure I understand this:
> > does PGO currently not work with modules? Or does this patch series just
> > make it so that each module has its own .profraw file so individual
> > modules can be optimized?
> >=20
> > If it is the latter, what is the point? Why would you want to optimize
> > just a module and not the entire kernel, if you already have to go
> > through the profiling steps?
> >=20
> > If it is the former, there has to be a better way to share more of the
> > machinery between fs.c and fs_mod.c than basically duplicating
> > everything because there are some parameters and logic that have to
> > change. I do not have a ton of time to outline exactly what that might
> > look like but for example, prf_fill_header and prf_module_fill_header
> > are basically the same thing aside from the mod parameter and the
> > prf_..._count() calls. It seems like if mod was NULL, you would call the
> > vmlinux versions of the functions.
>=20
> Functions definitely shouldn't be duplicated with only minor changes.
> We should determine a way to combine them.
>=20
> As for whether the original PGO patch supports profiling in modules,
> the answer is "it depends". :-) I believe that clang inserts profiling
> hooks into all code that's compiled with the "-fprofile..." flags.
> This would include the modules of course. In GCOV, it's possible to
> retrieve profiling information for a single file. Jarmo, is that the
> intention of your patches?
>=20
> -bw
>
Thanks for replying Nathan and Bill!

My original motivation for writing this patch was the realization that no
profile data could be obtained from modules using the original patch only.=
=20

My insight when testing the original patch was that the compiler indeed doe=
s=20
instrument+profile all code, including any loaded modules. But this is wher=
e=20
the current instrument.c falls short:
The allocate_node() function may consume nodes from __llvm_prf_vnds_start
that are actually in a module and not in vmlinux.
So llvm_prf_data *p argument may point into an module section, and not into=
=20
__llvm_prf_data_start range.

This can result in early exhaustion of of nodes for vmlinux and less accura=
te=20
profile data. I think this is actually a bug in the original patch.

So no, the PGO does not currently work with modules. And it somewhat works
for vmlinux.

My code confines the llvm_prf_value_node reservation to vmlinux or module i=
n=20
instrument.c based on where the llvm_prf_data *p argument points into.

My next intention with the patch is that vmlinux and each loadable module=20
exports their own, separate profile data file in debugfs/pgo/ like the vmli=
nux=20
already does.
So no file level information like in gcov. Only per whole "module.ko" and t=
he
vmlinux binary.
This way you can inspect what each module is doing individually using "llvm-
profdata show mod.profraw"

=46or PGO final build I intended combining the profile data from vmlinux an=
d all=20
modules with "llvm-profdata merge" into single profile for optimized build.

I agree fully that the current code duplication is bad.
Maybe I should pass in the mod->prf_xxx sections in a struct to the=20
serializing functions?
In that way, the struct can be initialized from either module or the vmlinu=
x=20
sections and all serializing code can share the same code.

Either way, thanks to your questions and info I can try an write better=20
version.=F0=9F=98=83

I have learned a lot, thanks.
=2DJarmo Tiitto

> > > Modules are register into the profiler via module notifier callback
> > > similiar to gcov/base.c. Note that if module does not have
> > > __llvm_prf_xxx
> > > sections required the module ignored.
> > >=20
> > > Also there is no "reset" support for yet for these files.
> > >=20
> > > Signed-off-by: Jarmo Tiitto <jarmo.tiitto@gmail.com>
> > > ---
> > >=20
> > >  kernel/pgo/Makefile     |   2 +-
> > >  kernel/pgo/fs.c         |  54 ++++--
> > >  kernel/pgo/fs_mod.c     | 415 ++++++++++++++++++++++++++++++++++++++=
++
> > >  kernel/pgo/instrument.c |  12 +-
> > >  kernel/pgo/pgo.h        |  11 +-
> > >  5 files changed, 466 insertions(+), 28 deletions(-)
> > >  create mode 100644 kernel/pgo/fs_mod.c
> > >=20
> > > diff --git a/kernel/pgo/Makefile b/kernel/pgo/Makefile
> > > index 41e27cefd9a4..662b7dfdfbe9 100644
> > > --- a/kernel/pgo/Makefile
> > > +++ b/kernel/pgo/Makefile
> > > @@ -2,4 +2,4 @@
> > >=20
> > >  GCOV_PROFILE :=3D n
> > >  PGO_PROFILE  :=3D n
> > >=20
> > > -obj-y        +=3D fs.o instrument.o
> > > +obj-y        +=3D fs.o fs_mod.o instrument.o
> > > diff --git a/kernel/pgo/fs.c b/kernel/pgo/fs.c
> > > index 575142735273..5471d270a5bb 100644
> > > --- a/kernel/pgo/fs.c
> > > +++ b/kernel/pgo/fs.c
> > > @@ -227,15 +227,15 @@ static unsigned long prf_buffer_size(void)
> > >=20
> > >   * Serialize the profiling data into a format LLVM's tools can
> > >   understand.
> > >   * Note: caller *must* hold pgo_lock.
> > >   */
> > >=20
> > > -static int prf_serialize(struct prf_private_data *p)
> > > +static int prf_serialize(struct prf_private_data *p, unsigned long
> > > *buf_size)> >=20
> > >  {
> > > =20
> > >       int err =3D 0;
> > >       void *buffer;
> > >=20
> > > -     p->size =3D prf_buffer_size();
> > > -     p->buffer =3D vzalloc(p->size);
> > > +     /* re-check buffer size */
> > > +     *buf_size =3D prf_buffer_size();
> > >=20
> > > -     if (!p->buffer) {
> > > +     if (p->size < *buf_size || !p->buffer) {
> > >=20
> > >               err =3D -ENOMEM;
> > >               goto out;
> > >      =20
> > >       }
> > >=20
> > > @@ -262,7 +262,8 @@ static int prf_open(struct inode *inode, struct f=
ile
> > > *file)> >=20
> > >  {
> > > =20
> > >       struct prf_private_data *data;
> > >       unsigned long flags;
> > >=20
> > > -     int err;
> > > +     unsigned long buf_size;
> > > +     int err =3D 0;
> > >=20
> > >       data =3D kzalloc(sizeof(*data), GFP_KERNEL);
> > >       if (!data) {
> > >=20
> > > @@ -270,18 +271,41 @@ static int prf_open(struct inode *inode, struct
> > > file *file)> >=20
> > >               goto out;
> > >      =20
> > >       }
> > >=20
> > > +     /* estimate amount of memory needed:
> > > +      * can't vzalloc() while prf_lock() is held:
> > > +      * CONFIG_DEBUG_ATOMIC_SLEEP complains.
> > > +      * So first get buffer size, release the lock,
> > > +      * vzalloc(), re-lock and try serialize.
> > > +      */
> > >=20
> > >       flags =3D prf_lock();
> > >=20
> > > +     buf_size =3D prf_buffer_size();
> > >=20
> > > -     err =3D prf_serialize(data);
> > > -     if (unlikely(err)) {
> > > -             kfree(data);
> > > -             goto out_unlock;
> > > -     }
> > > +     do {
> > > +             prf_unlock(flags);
> > >=20
> > > -     file->private_data =3D data;
> > > +             /* resize buffer */
> > > +             if (data->size < buf_size && data->buffer) {
> > > +                     vfree(data->buffer);
> > > +                     data->buffer =3D NULL;
> > > +             }
> > > +
> > > +             if (!data->buffer) {
> > > +                     data->size =3D buf_size;
> > > +                     data->buffer =3D vzalloc(data->size);
> > >=20
> > > -out_unlock:
> > > +                     if (!data->buffer) {
> > > +                             err =3D -ENOMEM;
> > > +                             goto out;
> > > +                     }
> > > +             }
> > > +             /* try serialize */
> > > +             flags =3D prf_lock();
> > > +     } while (prf_serialize(data, &buf_size));
> > >=20
> > >       prf_unlock(flags);
> > >=20
> > > +
> > > +     data->size =3D buf_size;
> > > +     file->private_data =3D data;
> > > +
> > >=20
> > >  out:
> > >       return err;
> > > =20
> > >  }
> > >=20
> > > @@ -363,6 +387,8 @@ static const struct file_operations prf_reset_fop=
s =3D
> > > {
> > >=20
> > >  /* Create debugfs entries. */
> > >  static int __init pgo_init(void)
> > >  {
> > >=20
> > > +     pr_notice("Clang PGO profile data available.");
> > > +
> > >=20
> > >       directory =3D debugfs_create_dir("pgo", NULL);
> > >       if (!directory)
> > >      =20
> > >               goto err_remove;
> > >=20
> > > @@ -375,6 +401,8 @@ static int __init pgo_init(void)
> > >=20
> > >                                &prf_reset_fops))
> > >              =20
> > >               goto err_remove;
> > >=20
> > > +     prf_modules_init();
> > > +
> > >=20
> > >       return 0;
> > > =20
> > >  err_remove:
> > > @@ -385,6 +413,8 @@ static int __init pgo_init(void)
> > >=20
> > >  /* Remove debugfs entries. */
> > >  static void __exit pgo_exit(void)
> > >  {
> > >=20
> > > +     prf_modules_exit();
> > > +
> > >=20
> > >       debugfs_remove_recursive(directory);
> > > =20
> > >  }
> > >=20
> > > diff --git a/kernel/pgo/fs_mod.c b/kernel/pgo/fs_mod.c
> > > new file mode 100644
> > > index 000000000000..0808d44227f1
> > > --- /dev/null
> > > +++ b/kernel/pgo/fs_mod.c
> > > @@ -0,0 +1,415 @@
> > > +// SPDX-License-Identifier: GPL-2.0
> > > +/*
> > > + * Copyright (C) 2021 Jarmo Tiitto
> > > + *
> > > + * Author:
> > > + *   Jarmo Tiitto <jarmo.tiitto@gmail.com>
> > > + *
> > > + * Based on the clang PGO kernel patch by:
> > > + *  Sami Tolvanen <samitolvanen@google.com>
> > > + *
> > > + * This software is licensed under the terms of the GNU General Publ=
ic
> > > + * License version 2, as published by the Free Software Foundation, =
and
> > > + * may be copied, distributed, and modified under those terms.
> > > + *
> > > + * This program is distributed in the hope that it will be useful,
> > > + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> > > + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> > > + * GNU General Public License for more details.
> > > + *
> > > + */
> > > +
> > > +#define pr_fmt(fmt)  "pgo: " fmt
> > > +
> > > +#include <linux/kernel.h>
> > > +#include <linux/debugfs.h>
> > > +#include <linux/fs.h>
> > > +#include <linux/module.h>
> > > +#include <linux/slab.h>
> > > +#include <linux/vmalloc.h>
> > > +#include "pgo.h"
> > > +
> > > +/*
> > > + * PGO profile data reporting for modules:
> > > + * We maintain one debugfs pgo/<module>.profraw file per module.
> > > + */
> > > +
> > > +
> > > +DEFINE_MUTEX(prf_mod_lock);
> > > +LIST_HEAD(prf_mod_list);
> > > +
> > > +struct prf_mod_data {
> > > +     void *buffer;
> > > +     unsigned long size;
> > > +};
> > > +
> > > +/* these are trivial, but each one differs a bit */
> > > +static inline unsigned long prf_mod_data_size(struct module *mod)
> > > +{
> > > +     return mod->prf_data_size;
> > > +}
> > > +
> > > +static inline unsigned long prf_mod_data_count(struct module *mod)
> > > +{
> > > +     return mod->prf_data_size / sizeof(struct llvm_prf_data);
> > > +}
> > > +
> > > +static inline unsigned long prf_mod_cnts_size(struct module *mod)
> > > +{
> > > +     return mod->prf_cnts_num * sizeof(mod->prf_cnts[0]);
> > > +}
> > > +
> > > +static inline unsigned long prf_mod_cnts_count(struct module *mod)
> > > +{
> > > +     return mod->prf_cnts_num;
> > > +}
> > > +
> > > +static inline unsigned long prf_mod_names_size(struct module *mod)
> > > +{
> > > +     return mod->prf_names_num * sizeof(mod->prf_names[0]);
> > > +}
> > > +
> > > +static inline unsigned long prf_mod_names_count(struct module *mod)
> > > +{
> > > +     return mod->prf_names_num;
> > > +}
> > > +
> > > +static inline unsigned long prf_mod_vnds_size(struct module *mod)
> > > +{
> > > +     return mod->prf_vnds_size;
> > > +}
> > > +
> > > +static inline unsigned long prf_mod_vnds_count(struct module *mod)
> > > +{
> > > +     return mod->prf_vnds_size / sizeof(struct llvm_prf_value_node);
> > > +}
> > > +
> > > +/*
> > > + * Raw profile data format:
> > > + *
> > > + *   - llvm_prf_header
> > > + *   - __llvm_prf_data
> > > + *   - __llvm_prf_cnts
> > > + *   - __llvm_prf_names
> > > + *   - zero padding to 8 bytes
> > > + *   - for each llvm_prf_data in __llvm_prf_data:
> > > + *           - llvm_prf_value_data
> > > + *                   - llvm_prf_value_record + site count array
> > > + *                           - llvm_prf_value_node_data
> > > + *                           ...
> > > + *                   ...
> > > + *           ...
> > > + */
> > > +
> > > +static void prf_module_fill_header(struct module *mod, void **buffer)
> > > +{
> > > +     struct llvm_prf_header *header =3D *(struct llvm_prf_header
> > > **)buffer;
> > > +
> > > +#ifdef CONFIG_64BIT
> > > +     header->magic =3D LLVM_INSTR_PROF_RAW_MAGIC_64;
> > > +#else
> > > +     header->magic =3D LLVM_INSTR_PROF_RAW_MAGIC_32;
> > > +#endif
> > > +     header->version =3D LLVM_VARIANT_MASK_IR_PROF |
> > > LLVM_INSTR_PROF_RAW_VERSION; +     header->data_size =3D
> > > prf_mod_data_count(mod);
> > > +     header->padding_bytes_before_counters =3D 0;
> > > +     header->counters_size =3D prf_mod_cnts_count(mod);
> > > +     header->padding_bytes_after_counters =3D 0;
> > > +     header->names_size =3D prf_mod_names_count(mod);
> > > +     header->counters_delta =3D (u64)mod->prf_cnts;
> > > +     header->names_delta =3D (u64)mod->prf_names;
> > > +     header->value_kind_last =3D LLVM_INSTR_PROF_IPVK_LAST;
> > > +
> > > +     *buffer +=3D sizeof(*header);
> > > +}
> > > +
> > > +/*
> > > + * Copy the source into the buffer, incrementing the pointer into
> > > buffer in the + * process.
> > > + */
> > > +static void prf_copy_to_buffer(void **buffer, const void *src, unsig=
ned
> > > long size) +{
> > > +     memcpy(*buffer, src, size);
> > > +     *buffer +=3D size;
> > > +}
> > > +
> > > +/* extern u32 __prf_get_value_size(struct llvm_prf_data *p, u32
> > > *value_kinds) */ +
> > > +static u32 prf_module_get_value_size(struct module *mod)
> > > +{
> > > +     u32 size =3D 0;
> > > +     struct llvm_prf_data *p;
> > > +     struct llvm_prf_data *start =3D mod->prf_data;
> > > +     struct llvm_prf_data *end =3D start + prf_mod_data_count(mod);
> > > +
> > > +     for (p =3D start; p < end; p++)
> > > +             size +=3D __prf_get_value_size(p, NULL);
> > > +
> > > +     return size;
> > > +}
> > > +
> > > +/* Serialize the profiling's value.
> > > + * extern void prf_serialize_value(struct llvm_prf_data *p, void
> > > **buffer)
> > > + */
> > > +
> > > +static void prf_module_serialize_values(struct module *mod, void
> > > **buffer)
> > > +{
> > > +     struct llvm_prf_data *p;
> > > +     struct llvm_prf_data *start =3D mod->prf_data;
> > > +     struct llvm_prf_data *end =3D start + prf_mod_data_count(mod);
> > > +
> > > +     for (p =3D start; p < end; p++)
> > > +             prf_serialize_value(p, buffer);
> > > +}
> > > +
> > > +static inline unsigned long prf_get_padding(unsigned long size)
> > > +{
> > > +     return 7 & (sizeof(u64) - size % sizeof(u64));
> > > +}
> > > +
> > > +static unsigned long prf_module_buffer_size(struct module *mod)
> > > +{
> > > +     return sizeof(struct llvm_prf_header) +
> > > +                     prf_mod_data_size(mod)  +
> > > +                     prf_mod_cnts_size(mod) +
> > > +                     prf_mod_names_size(mod) +
> > > +                     prf_get_padding(prf_mod_names_size(mod)) +
> > > +                     prf_module_get_value_size(mod);
> > > +}
> > > +
> > > +/*
> > > + * Serialize the profiling data into a format LLVM's tools can
> > > understand.
> > > + * Note: caller *must* hold pgo_lock and hold reference to the modul=
e.
> > > + */
> > > +static int prf_module_serialize(struct module *mod, struct prf_mod_d=
ata
> > > *p, unsigned long *buf_size) +{
> > > +     int err =3D 0;
> > > +     void *buffer;
> > > +
> > > +     /* re-check buffer size */
> > > +     *buf_size =3D prf_module_buffer_size(mod);
> > > +
> > > +     if (p->size < *buf_size || !p->buffer) {
> > > +             err =3D -ENOMEM;
> > > +             goto out;
> > > +     }
> > > +
> > > +     buffer =3D p->buffer;
> > > +
> > > +     prf_module_fill_header(mod, &buffer);
> > > +     prf_copy_to_buffer(&buffer, mod->prf_data,=20
> > > prf_mod_data_size(mod));
> > > +     prf_copy_to_buffer(&buffer, mod->prf_cnts,=20
> > > prf_mod_cnts_size(mod));
> > > +     prf_copy_to_buffer(&buffer, mod->prf_names,
> > > prf_mod_names_size(mod));
> > > +     buffer +=3D prf_get_padding(prf_mod_names_size(mod));
> > > +
> > > +     prf_module_serialize_values(mod, &buffer);
> > > +
> > > +out:
> > > +     return err;
> > > +}
> > > +
> > > +/* open() implementation for module PGO. */
> > > +static int prf_module_open(struct inode *inode, struct file *file)
> > > +{
> > > +     struct prf_mod_private_data *data;
> > > +     struct prf_mod_data *pinfo;
> > > +     struct module *mod;
> > > +     unsigned long flags;
> > > +     unsigned long buf_size =3D 0;
> > > +     int err =3D 0;
> > > +
> > > +     mutex_lock(&prf_mod_lock);
> > > +     data =3D inode->i_private; /* see: pgo_module_notifier() */
> > > +
> > > +     BUG_ON(!data);
> > > +
> > > +     /* grab the module */
> > > +     mod =3D READ_ONCE(data->mod);
> > > +     if (mod && try_module_get(mod)) {
> > > +             // Is it live?
> > > +             if (mod->state !=3D MODULE_STATE_LIVE) {
> > > +                     err =3D -EAGAIN;
> > > +                     goto put_unlock;
> > > +             }
> > > +
> > > +             pinfo =3D kzalloc(sizeof(*pinfo), GFP_KERNEL);
> > > +             if (!pinfo) {
> > > +                     err =3D -ENOMEM;
> > > +                     goto put_unlock;
> > > +             }
> > > +
> > > +             mutex_unlock(&prf_mod_lock);
> > > +
> > > +             /* estimate amount of memory needed:
> > > +              * can't vzalloc() while prf_lock() is held
> > > +              * and prf_module_buffer_size() only works while it is
> > > held..
> > > +              */
> > > +             flags =3D prf_lock();
> > > +             buf_size =3D prf_module_buffer_size(mod);
> > > +             do {
> > > +                     prf_unlock(flags);
> > > +
> > > +                     /* resize buffer */
> > > +                     if (pinfo->size < buf_size && pinfo->buffer) {
> > > +                             vfree(pinfo->buffer);
> > > +                             pinfo->buffer =3D NULL;
> > > +                     }
> > > +
> > > +                     if (!pinfo->buffer) {
> > > +                             pinfo->size =3D buf_size;
> > > +                             pinfo->buffer =3D vzalloc(pinfo->size);
> > > +
> > > +                             if (!pinfo->buffer) {
> > > +                                     err =3D -ENOMEM;
> > > +                                     goto out;
> > > +                             }
> > > +                     }
> > > +
> > > +                     /* try serialize */
> > > +                     flags =3D prf_lock();
> > > +
> > > +             } while (prf_module_serialize(mod, pinfo, &buf_size));
> > > +
> > > +             prf_unlock(flags);
> > > +
> > > +             /* success! */
> > > +             pinfo->size =3D buf_size;
> > > +             file->private_data =3D pinfo;
> > > +
> > > +             module_put(mod);
> > > +             return err;
> > > +     }
> > > +
> > > +put_unlock:
> > > +     module_put(mod);
> > > +     mutex_unlock(&prf_mod_lock);
> > > +out:
> > > +     return err;
> > > +}
> > > +
> > > +/* read() implementation for PGO. */
> > > +static ssize_t prf_module_read(struct file *file, char __user *buf,
> > > size_t count, +                     loff_t *ppos)
> > > +{
> > > +     struct prf_mod_data *pinfo =3D file->private_data;
> > > +
> > > +     BUG_ON(!pinfo);
> > > +
> > > +     return simple_read_from_buffer(buf, count, ppos, pinfo->buffer,
> > > +                                        pinfo->size);
> > > +}
> > > +
> > > +/* release() implementation for PGO. Release resources allocated by
> > > open(). */ +static int prf_module_release(struct inode *inode, struct
> > > file *file) +{
> > > +     struct prf_mod_data *pinfo =3D file->private_data;
> > > +
> > > +     if (pinfo) {
> > > +             vfree(pinfo->buffer);
> > > +             kfree(pinfo);
> > > +             file->private_data =3D 0;
> > > +     }
> > > +     return 0;
> > > +}
> > > +
> > > +static const struct file_operations prf_mod_fops =3D {
> > > +     .owner          =3D THIS_MODULE,
> > > +     .open           =3D prf_module_open,
> > > +     .read           =3D prf_module_read,
> > > +     .llseek         =3D default_llseek,
> > > +     .release        =3D prf_module_release
> > > +};
> > > +
> > > +static void prf_module_free(struct rcu_head *rcu)
> > > +{
> > > +     struct prf_mod_private_data *data;
> > > +
> > > +     data =3D container_of(rcu, struct prf_mod_private_data, rcu);
> > > +
> > > +     debugfs_remove(data->file);
> > > +
> > > +     kfree(data);
> > > +}
> > > +
> > > +static int pgo_module_notifier(struct notifier_block *nb, unsigned l=
ong
> > > event, +                             void *pdata)
> > > +{
> > > +     struct module *mod =3D pdata;
> > > +     struct prf_mod_private_data *data;
> > > +     char fsname[MODULE_NAME_LEN + 9]; // +strlen(".profraw")
> > > +
> > > +     if (event =3D=3D MODULE_STATE_LIVE) {
> > > +             /* does the module have profiling info? */
> > > +             if (mod->prf_data
> > > +                       && mod->prf_cnts
> > > +                       && mod->prf_names
> > > +                       && mod->prf_vnds) {
> > > +                     /* add module prf_mod_private_data entry */
> > > +                     data =3D kzalloc(sizeof(*data), GFP_KERNEL);
> > > +
> > > +                     fsname[0] =3D 0;
> > > +                     snprintf(fsname, sizeof(fsname), "%s.profraw",
> > > mod->name); +
> > > +                     mutex_lock(&prf_mod_lock);
> > > +
> > > +                     data->file =3D debugfs_create_file(fsname, 0600,
> > > directory, data, &prf_mod_fops); +                     if (!data->fil=
e)
> > > {
> > > +                             pr_err("Failed setup module pgo: %s",
> > > fsname); +                             kfree(data);
> > > +                             mutex_unlock(&prf_mod_lock);
> > > +                             return NOTIFY_OK;
> > > +                     }
> > > +
> > > +                     WRITE_ONCE(data->mod, mod);
> > > +
> > > +                     list_add_tail_rcu(&data->link, &prf_mod_list);
> > > +                     mutex_unlock(&prf_mod_lock);
> > > +             }
> > > +     }
> > > +     if (event =3D=3D MODULE_STATE_GOING) {
> > > +             /* remove module from the list */
> > > +             rcu_read_lock();
> > > +             list_for_each_entry_rcu(data, &prf_mod_list, link) {
> > > +                     if (strcmp(data->mod->name, mod->name) =3D=3D 0=
) {
> > > +
> > > +                             mutex_lock(&prf_mod_lock);
> > > +                             /* remofe from profiled modules */
> > > +                             list_del_rcu(&data->link);
> > > +                             /* mark it stale */
> > > +                             WRITE_ONCE(data->mod, NULL);
> > > +                             mutex_unlock(&prf_mod_lock);
> > > +                             call_rcu(&data->rcu, prf_module_free);
> > > +                             break;
> > > +                     }
> > > +             }
> > > +             rcu_read_unlock();
> > > +     }
> > > +
> > > +     return NOTIFY_OK;
> > > +}
> > > +
> > > +static struct notifier_block pgo_module_nb =3D {
> > > +     .notifier_call =3D pgo_module_notifier
> > > +};
> > > +
> > > +void prf_modules_init(void)
> > > +{
> > > +     register_module_notifier(&pgo_module_nb);
> > > +}
> > > +
> > > +void prf_modules_exit(void)
> > > +{
> > > +     struct prf_mod_private_data *p;
> > > +
> > > +     /* unsubscribe the notifier and do cleanup. */
> > > +     unregister_module_notifier(&pgo_module_nb);
> > > +
> > > +     rcu_read_lock();
> > > +     list_for_each_entry_rcu(p, &prf_mod_list, link) {
> > > +             /* delete nodes */
> > > +             list_del(&p->link);
> > > +             WRITE_ONCE(p->mod, NULL);
> > > +             call_rcu(&p->rcu, prf_module_free);
> > > +     }
> > > +     rcu_read_unlock();
> > > +}
> > > \ No newline at end of file
> > > diff --git a/kernel/pgo/instrument.c b/kernel/pgo/instrument.c
> > > index 464b3bc77431..98cfa11a7b76 100644
> > > --- a/kernel/pgo/instrument.c
> > > +++ b/kernel/pgo/instrument.c
> > > @@ -139,11 +139,11 @@ EXPORT_SYMBOL(__llvm_profile_instrument_target);
> > >=20
> > >  /* Counts the number of times a range of targets values are seen. */
> > >  void __llvm_profile_instrument_range(u64 target_value, void *data,
> > >=20
> > > -                                  u32 index, s64 precise_start,
> > > -                                  s64 precise_last, s64 large_value);
> > > +                                      u32 index, s64 precise_start,
> > > +                                      s64 precise_last, s64
> > > large_value);
> > >=20
> > >  void __llvm_profile_instrument_range(u64 target_value, void *data,
> > >=20
> > > -                                  u32 index, s64 precise_start,
> > > -                                  s64 precise_last, s64 large_value)
> > > +                                      u32 index, s64 precise_start,
> > > +                                      s64 precise_last, s64
> > > large_value)
> > >=20
> > >  {
> > > =20
> > >       if (large_value !=3D S64_MIN && (s64)target_value >=3D large_va=
lue)
> > >      =20
> > >               target_value =3D large_value;
> > >=20
> > > @@ -176,9 +176,9 @@ static u64 inst_prof_get_range_rep_value(u64 valu=
e)
> > >=20
> > >   * defined in compiler-rt/include/profile/InstrProfData.inc.
> > >   */
> > > =20
> > >  void __llvm_profile_instrument_memop(u64 target_value, void *data,
> > >=20
> > > -                                  u32 counter_index);
> > > +                                      u32 counter_index);
> > >=20
> > >  void __llvm_profile_instrument_memop(u64 target_value, void *data,
> > >=20
> > > -                                  u32 counter_index)
> > > +                                      u32 counter_index)
> > >=20
> > >  {
> > > =20
> > >       u64 rep_value;
> > >=20
> > > diff --git a/kernel/pgo/pgo.h b/kernel/pgo/pgo.h
> > > index a9ff51abbfd5..2840da63c7cd 100644
> > > --- a/kernel/pgo/pgo.h
> > > +++ b/kernel/pgo/pgo.h
> > > @@ -212,17 +212,13 @@ struct prf_mod_private_data {
> > >=20
> > >       struct list_head link;
> > >       struct rcu_head rcu;
> > >=20
> > > -     void *buffer;
> > > -     unsigned long size;
> > > -
> > > -     char mod_name[MODULE_NAME_LEN];
> > >=20
> > >       struct module *mod;
> > >       struct dentry *file;
> > >      =20
> > >       int current_node;
> > > =20
> > >  };
> > >=20
> > > -/* Mutex protecting the prf_mod_list and entries */
> > > +/* Mutex protecting the prf_mod_list */
> > >=20
> > >  extern struct mutex prf_mod_lock;
> > > =20
> > >  /* List of modules profiled */
> > >=20
> > > @@ -231,10 +227,7 @@ extern struct list_head prf_mod_list;
> > >=20
> > >  extern void prf_modules_init(void);
> > >  extern void prf_modules_exit(void);
> > >=20
> > > -/* Update each modules snapshot of the profiling data. */
> > > -extern int prf_modules_snapshot(void);
> > > -
> > > -/* below funcs are required by prf_modules_snapshot() */
> > > +/* below funcs are required by prf_modules */
> > >=20
> > >  extern u32 __prf_get_value_size(struct llvm_prf_data *p, u32
> > >  *value_kinds);
> > > =20
> > >  extern void prf_serialize_value(struct llvm_prf_data *p, void
> > >  **buffer);
> > >=20
> > > --
> > > 2.31.1


