Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 766A439B6DD
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Jun 2021 12:16:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230004AbhFDKRq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Jun 2021 06:17:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229964AbhFDKRp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jun 2021 06:17:45 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B134C06174A
        for <linux-kernel@vger.kernel.org>; Fri,  4 Jun 2021 03:15:46 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id p20so10843964ljj.8
        for <linux-kernel@vger.kernel.org>; Fri, 04 Jun 2021 03:15:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qwh3ad/jO1vwDAyksWj1wLjKtFEy5Etgz1pSxk8HShc=;
        b=hQtb6oAe0JmaATT4v/q5L/3Hshu6TO3gM8Rw7T2g78aPl7Q8yzwMXsv/Nw+RGI8y5D
         kFCJduuTHSUG4fjDdikx2bJxP2uT2ZSutbJGNgY8QcAtXOlAw5/kbr6aYg06wMmA5lu3
         gPT5nxMhIrnSeRQnyudliWnZl4wH8QzDZMBWxBheOMno4oJIJGA9YwO1pNhyLSNxdFKY
         EkivYH3/C5hwjP4e7uC4O9ojglha4lhFwKIF2oBpHpeij98qaYQls9O6zocK4LD0ixQ8
         dCoSR5rsBfZ2CPWzoGlpv0RvQOBdu+igN59TSAr3wOnwYCpP9+s82TCWu/T7VvilTZID
         jyrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qwh3ad/jO1vwDAyksWj1wLjKtFEy5Etgz1pSxk8HShc=;
        b=TCH6x7pPBfG3TmpC3UClcOEyFsnIs9tr94TV5XuQRiwTwzwdVtbrmmFDWcmu/Bd38D
         D5tKdVCPe3FdNvUG86AeNod0wRcX5/PVZjIk3DnVQKXqpbxofBbk2WPSsuOsgUAS4N4H
         fHqeMTaVeqP2HH3PtZgNAv4tcEcNqkYR0pNc1AttXLHFZvzdMnsHwKD/TNT5XUcyuP6G
         lb4A8hblIkH4exY5frLeuizDGajy0dIY1YPsuDxHGm8dfUZGVBxWtYbTRjSWrswDKFWh
         aWRZe8bOhPhxHJJDkizLfQ4/NL0kl6VRFmE4uNhEHVU0zI5OE5KtngixCmDndyvKq/EZ
         i1qw==
X-Gm-Message-State: AOAM532oEAK+csubKIpEiTV1R+bg1LjPAFXa0IA2ZOUPmunoNztoo6S0
        duf6S9Z6OI6/WfJpKrB84p8=
X-Google-Smtp-Source: ABdhPJxLOaKwGHNr2MDy3pTCt01XTpEUoenT8mjKwJln29MAvRJFlG6O/cbK+57DuiHMxdc4vMFgRw==
X-Received: by 2002:a2e:9e57:: with SMTP id g23mr2916104ljk.123.1622801744457;
        Fri, 04 Jun 2021 03:15:44 -0700 (PDT)
Received: from hyperiorarchmachine.localnet (dcx7x4ycc2b7s--vdqzfy-3.rev.dnainternet.fi. [2001:14ba:14f7:3c00:42b0:76ff:fe23:6d08])
        by smtp.gmail.com with ESMTPSA id 80sm666520ljf.4.2021.06.04.03.15.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Jun 2021 03:15:43 -0700 (PDT)
From:   Jarmo Tiitto <jarmo.tiitto@gmail.com>
To:     Jarmo Tiitto <jarmo.tiitto@gmail.com>,
        Kees Cook <keescook@chromium.org>
Cc:     Sami Tolvanen <samitolvanen@google.com>,
        Bill Wendling <wcw@google.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        clang-built-linux@googlegroups.com, linux-kernel@vger.kernel.org,
        morbo@google.com
Subject: Re: [PATCH v2 1/1] pgo: Fix sleep in atomic section in prf_open()
Date:   Fri, 04 Jun 2021 13:15:43 +0300
Message-ID: <3874710.oRHo3lsn7p@hyperiorarchmachine>
In-Reply-To: <202106031441.FA95440A@keescook>
References: <20210603155318.46346-1-jarmo.tiitto@gmail.com> <202106031441.FA95440A@keescook>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kees Cook wrote perjantaina 4. kes=C3=A4kuuta 2021 0.47.23 EEST:
> On Thu, Jun 03, 2021 at 06:53:17PM +0300, Jarmo Tiitto wrote:
> > In prf_open() the required buffer size can be so large that
> > vzalloc() may sleep thus triggering bug:
> >=20
> > =3D=3D=3D=3D=3D=3D
> >  BUG: sleeping function called from invalid context at include/linux/sc=
hed/mm.h:201
> >  in_atomic(): 1, irqs_disabled(): 1, non_block: 0, pid: 337, name: cat
> >  CPU: 1 PID: 337 Comm: cat Not tainted 5.13.0-rc2-24-hack+ #154
> >  Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 0.0.0 02/06/2=
015
> >  Call Trace:
> >   dump_stack+0xc7/0x134
> >   ___might_sleep+0x177/0x190
> >   __might_sleep+0x5a/0x90
> >   kmem_cache_alloc_node_trace+0x6b/0x3a0
> >   ? __get_vm_area_node+0xcd/0x1b0
> >   ? dput+0x283/0x300
> >   __get_vm_area_node+0xcd/0x1b0
> >   __vmalloc_node_range+0x7b/0x420
> >   ? prf_open+0x1da/0x580
> >   ? prf_open+0x32/0x580
> >   ? __llvm_profile_instrument_memop+0x36/0x50
> >   vzalloc+0x54/0x60
> >   ? prf_open+0x1da/0x580
> >   prf_open+0x1da/0x580
> >   full_proxy_open+0x211/0x370
> >   ....
> > =3D=3D=3D=3D=3D=3D
> >=20
> > Since we can't vzalloc while holding pgo_lock,
> > split the code into steps:
> > * First get buffer size via prf_buffer_size()
> >   and release the lock.
> > * Round up to the page size and allocate the buffer.
> > * Finally re-acquire the pgo_lock and call prf_serialize().
> >   prf_serialize() will now check if the buffer is large enough
> >   and returns -EAGAIN if it is not.
> >=20
> > New in this v2 patch:
> > The -EAGAIN case was determined to be such rare event that
> > running following in a loop:
> >=20
> > $cat /sys/kernel/debug/pgo/vmlinux.profraw > vmlinux.profdata;
> >=20
> > Didn't trigger it, and I don't know if it ever may occur at all.
>=20
> Hm, I remain nervous that it'll pop up when we least expect it. But, I
> went to go look at this, and I don't understand why we need a lock at
> all for prf_buffer_size(). These appear to be entirely static in size.
>=20

I would think the reasoning of taking the pgo_lock for prf_buffer_size() is=
 that because
__prf_get_value_size() walks linked lists that are modified by=20
__llvm_profile_instrument_target() in instrument.c.

However __llvm_profile_instrument_target() looks like it will only append to
llvm_prf_data::values array of  llvm_prf_value_node linked lists, so you mi=
ght be right.

I'll try analyze the prf_buffer_size() better to determine upper bound of m=
emory required,
such that the pgo_lock is absolutely not needed for prf_buffer_size().

> >=20
> > Signed-off-by: Jarmo Tiitto <jarmo.tiitto@gmail.com>
> > ---
> >  kernel/pgo/fs.c | 52 ++++++++++++++++++++++++++++++++++++-------------
> >  1 file changed, 38 insertions(+), 14 deletions(-)
> >=20
> > diff --git a/kernel/pgo/fs.c b/kernel/pgo/fs.c
> > index ef985159dad3..9afd6f001a1b 100644
> > --- a/kernel/pgo/fs.c
> > +++ b/kernel/pgo/fs.c
> > @@ -24,13 +24,14 @@
> >  #include <linux/module.h>
> >  #include <linux/slab.h>
> >  #include <linux/vmalloc.h>
> > +#include <linux/mm.h>
> >  #include "pgo.h"
> > =20
> >  static struct dentry *directory;
> > =20
> >  struct prf_private_data {
> >  	void *buffer;
> > -	unsigned long size;
> > +	size_t size;
> >  };
> > =20
> >  /*
> > @@ -213,6 +214,7 @@ static inline unsigned long prf_get_padding(unsigne=
d long size)
> >  	return 7 & (sizeof(u64) - size % sizeof(u64));
> >  }
> > =20
> > +/* Note: caller *must* hold pgo_lock */
> >  static unsigned long prf_buffer_size(void)
> >  {
> >  	return sizeof(struct llvm_prf_header) +
> > @@ -225,18 +227,21 @@ static unsigned long prf_buffer_size(void)
> > =20
> >  /*
> >   * Serialize the profiling data into a format LLVM's tools can underst=
and.
> > + * Note: p->buffer must point into vzalloc()'d
> > + * area of at least prf_buffer_size() in size.
> >   * Note: caller *must* hold pgo_lock.
> >   */
> > -static int prf_serialize(struct prf_private_data *p)
> > +static int prf_serialize(struct prf_private_data *p, size_t buf_size)
> >  {
> >  	int err =3D 0;
> >  	void *buffer;
> > =20
> > +	/* get buffer size, again. */
> >  	p->size =3D prf_buffer_size();
> > -	p->buffer =3D vzalloc(p->size);
> > =20
> > -	if (!p->buffer) {
> > -		err =3D -ENOMEM;
> > +	/* check for unlikely overflow. */
> > +	if (p->size > buf_size) {
> > +		err =3D -EAGAIN;
>=20
> This can just be ENOMEM instead -- it'll never change in size. (But we
> should absolutely keep the check.)
>=20

Ok, I was wondering what return value would be appropriate here.
=20
> >  		goto out;
> >  	}
> > =20
> > @@ -259,27 +264,46 @@ static int prf_open(struct inode *inode, struct f=
ile *file)
> >  {
> >  	struct prf_private_data *data;
> >  	unsigned long flags;
> > -	int err;
> > +	size_t buf_size;
> > +	int err =3D 0;
> > =20
> >  	data =3D kzalloc(sizeof(*data), GFP_KERNEL);
> >  	if (!data) {
> >  		err =3D -ENOMEM;
> > -		goto out;
> > +		goto out_free;
> >  	}
> > =20
> > +	/* get buffer size */
> >  	flags =3D prf_lock();
> > +	buf_size =3D prf_buffer_size();
> > +	prf_unlock(flags);
>=20
> And there's no locking needed here.
>=20
> > =20
> > -	err =3D prf_serialize(data);
> > -	if (unlikely(err)) {
> > -		kfree(data);
> > -		goto out_unlock;
> > +	/* allocate, round up to page size. */
> > +	buf_size =3D PAGE_ALIGN(buf_size);
> > +	data->buffer =3D vzalloc(buf_size);
> > +
> > +	if (!data->buffer) {
> > +		err =3D -ENOMEM;
> > +		goto out_free;
> >  	}
> > =20
> > +	/* try serialize and get actual
> > +	 * data length in data->size
> > +	 */
> > +	flags =3D prf_lock();
> > +	err =3D prf_serialize(data, buf_size);
> > +	prf_unlock(flags);
> > +
> > +	if (err)
> > +		goto out_free;
> > +
> >  	file->private_data =3D data;
> > +	return 0;
> > =20
> > -out_unlock:
> > -	prf_unlock(flags);
> > -out:
> > +out_free:
> > +	if (data)
> > +		vfree(data->buffer);
> > +	kfree(data);
> >  	return err;
> >  }
> > =20
> >=20
> > base-commit: 5d0cda65918279ada060417c5fecb7e86ccb3def
> > --=20
> > 2.31.1
> >=20
>=20
> --=20
> Kees Cook
>=20


=2D-
=2DJarmo


