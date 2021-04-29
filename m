Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90C6836E51A
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Apr 2021 08:50:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232090AbhD2GvL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Apr 2021 02:51:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238877AbhD2GvH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Apr 2021 02:51:07 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D6A0C06138B
        for <linux-kernel@vger.kernel.org>; Wed, 28 Apr 2021 23:50:20 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id c3so26671345pfo.3
        for <linux-kernel@vger.kernel.org>; Wed, 28 Apr 2021 23:50:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=8Sjs/qcN62tImx0y3y2XAUfVwF7AM9LLy6umWEbVG8w=;
        b=TX7c/xviVNjBLWT+DkxyQEf0lpH8+Gne8DU/X1k3TrZKR0hxNi6Q6Xn+RqV83TYI1l
         XPl0x78hveiDuFh4j3P9AgFtZQaz0fc0IWlXdR/Un13SvhOkx8mbSdrC1iTieLz6Dkji
         U06qF/V0yjF/SCRWftyXtlrZWS5RxdafvCctB9Lxmt3wuAvKG4tIRhxVH5X46eqEmeyB
         AWt2uS56zuXczQOoe47EEDL2OwkAW4bPJuswRQOZxmguleUtH+6oIC0zhfxbKXvqpJms
         EpdU9Wy7VdOJ29OoPA0JxSwxosXnc2eiHsrYwDIR2JcU5Cbm3fpM8NFSwAHfqGjvpD/O
         1fEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=8Sjs/qcN62tImx0y3y2XAUfVwF7AM9LLy6umWEbVG8w=;
        b=LSzNTrt7xkv/qUOsoS6l8PZmnnRLTxWem3jOGX0wtIdkO5EJNylje+4rj/ow3x1R04
         bJpHhDGv9/BZf7QDu9kkOH6xDR8VjP0vBr6Z2bq+qttOHqX2Ept9e4iSQ10ubnij8DqX
         QL4S2vXUwtkByopv3Gbmh3jYxbUgc60i7wPqTT29lGQzHFuGDEL8o2t0xfRbsH4tvdBC
         nfdasMs7mXwbLLWvYpA5ACpaBYOo8TP4NlR8hhe7RWGnPAn4S50lI7pyxP/hNS2MJc66
         r9MQbVN3gqmmePq+8XL2oo7jVdPE+opFO+DC4V558uQwrS1Oy40N5KJtVF19KUN/Kw3n
         cMTA==
X-Gm-Message-State: AOAM533N3a0LOUg15CY4Gl3O1TItpA49aLupvLiHL1+xSsYjrb65VDol
        FFDMrb97pFDFf4VaxWBwGcU=
X-Google-Smtp-Source: ABdhPJxNQVcep5m3uq9y8KxO8imsnoEkxIHzrFfr198Zz0dfHnWmIk9xOz0iJ8C4uBWGBh73TsuA1g==
X-Received: by 2002:aa7:8186:0:b029:27d:edb:c65a with SMTP id g6-20020aa781860000b029027d0edbc65amr6719470pfi.68.1619679020042;
        Wed, 28 Apr 2021 23:50:20 -0700 (PDT)
Received: from mail.google.com ([141.164.41.4])
        by smtp.gmail.com with ESMTPSA id a18sm1507599pgk.66.2021.04.28.23.50.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Apr 2021 23:50:19 -0700 (PDT)
Date:   Thu, 29 Apr 2021 14:50:15 +0800
From:   Changbin Du <changbin.du@gmail.com>
To:     Palmer Dabbelt <palmer@dabbelt.com>
Cc:     changbin.du@gmail.com, Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] riscv: patch: remove lockdep assertion on lock text_mutex
Message-ID: <20210429065015.lqdefm2sagyacmbs@mail.google.com>
References: <20210417023532.354714-1-changbin.du@gmail.com>
 <mhng-6a0fd653-64f8-4d0d-a265-d80cecdc1b84@palmerdabbelt-glaptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <mhng-6a0fd653-64f8-4d0d-a265-d80cecdc1b84@palmerdabbelt-glaptop>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 28, 2021 at 11:20:20PM -0700, Palmer Dabbelt wrote:
> On Fri, 16 Apr 2021 19:35:32 PDT (-0700), changbin.du@gmail.com wrote:
> > The function patch_insn_write() expects that the text_mutex is already
> > held. There's a case that text_mutex is acquired by ftrace_run_update_code()
> > under syscall context but then patch_insn_write() will be executed under the
> > migration kthread context as we involves stop machine. So we should remove
> > the assertion, or it can cause warning storm in kernel message.
> > 
> > [  104.641978] ------------[ cut here ]------------
> > [  104.642327] WARNING: CPU: 0 PID: 13 at arch/riscv/kernel/patch.c:63 patch_insn_write+0x166/0x17c
> > [  104.643587] Modules linked in:
> > [  104.644691] CPU: 0 PID: 13 Comm: migration/0 Not tainted 5.12.0-rc7-00067-g9cdbf6467424 #102
> > [  104.644907] Hardware name: riscv-virtio,qemu (DT)
> > [  104.645068] Stopper: multi_cpu_stop+0x0/0x17e <- 0x0
> > [  104.645349] epc : patch_insn_write+0x166/0x17c
> > [  104.645467]  ra : patch_insn_write+0x162/0x17c
> > [  104.645534] epc : ffffffe0000059c6 ra : ffffffe0000059c2 sp : ffffffe002a33c70
> > [  104.645580]  gp : ffffffe0019e5518 tp : ffffffe002a232c0 t0 : ffffffe01295e8a8
> > [  104.645622]  t1 : 0000000000000001 t2 : 0000000000000000 s0 : ffffffe002a33cc0
> > [  104.645675]  s1 : ffffffe000007f72 a0 : 0000000000000000 a1 : ffffffffffffffff
> > [  104.645716]  a2 : 0000000000000001 a3 : 0000000000000000 a4 : 0000000000000001
> > [  104.645757]  a5 : ffffffe0799e45c8 a6 : 00000000000ca097 a7 : 0000000000000000
> > [  104.645798]  s2 : 0000000000000008 s3 : 0000000000000f72 s4 : ffffffe002a33ce0
> > [  104.645839]  s5 : 0000000000000f7a s6 : 0000000000000003 s7 : 0000000000000003
> > [  104.645880]  s8 : 0000000000000004 s9 : 0000000000000002 s10: 0000000000000000
> > [  104.645920]  s11: 0000000000000002 t3 : 0000000000000001 t4 : ffffffe000c615c8
> > [  104.645958]  t5 : 0000000000007fff t6 : 0000000000000380
> > [  104.645998] status: 0000000000000100 badaddr: 0000000000000000 cause: 0000000000000003
> > [  104.646081] Call Trace:
> > [  104.646147] [<ffffffe0000059c6>] patch_insn_write+0x166/0x17c
> > [  104.646280] [<ffffffe0000059ec>] patch_text_nosync+0x10/0x32
> > [  104.646317] [<ffffffe000007d0c>] ftrace_update_ftrace_func+0x74/0xac
> > [  104.646352] [<ffffffe0000d338a>] ftrace_modify_all_code+0x9c/0x144
> > [  104.646387] [<ffffffe0000d3444>] __ftrace_modify_code+0x12/0x1c
> > [  104.646420] [<ffffffe0000c4c2c>] multi_cpu_stop+0xa8/0x17e
> > [  104.646451] [<ffffffe0000c4474>] cpu_stopper_thread+0xb2/0x156
> > [  104.646489] [<ffffffe00003645e>] smpboot_thread_fn+0x102/0x1ea
> > [  104.646524] [<ffffffe0000311b0>] kthread+0x132/0x148
> > [  104.646556] [<ffffffe000002e02>] ret_from_exception+0x0/0x14
> > [  104.646657] ---[ end trace ccf71babb9de4d5b ]---
> > [  104.647444] ------------[ cut here ]------------
> > 
> > Signed-off-by: Changbin Du <changbin.du@gmail.com>
> > ---
> >  arch/riscv/kernel/patch.c | 13 ++++++-------
> >  1 file changed, 6 insertions(+), 7 deletions(-)
> > 
> > diff --git a/arch/riscv/kernel/patch.c b/arch/riscv/kernel/patch.c
> > index 0b552873a577..6d2ed9c15065 100644
> > --- a/arch/riscv/kernel/patch.c
> > +++ b/arch/riscv/kernel/patch.c
> > @@ -49,19 +49,18 @@ static void patch_unmap(int fixmap)
> >  }
> >  NOKPROBE_SYMBOL(patch_unmap);
> > 
> > +
> > +/*
> > + * Before reaching here, it was expected to lock the text_mutex
> > + * already, so we don't need to give another lock here and could
> > + * ensure that it was safe between each cores.
> > + */
> >  static int patch_insn_write(void *addr, const void *insn, size_t len)
> >  {
> >  	void *waddr = addr;
> >  	bool across_pages = (((uintptr_t) addr & ~PAGE_MASK) + len) > PAGE_SIZE;
> >  	int ret;
> > 
> > -	/*
> > -	 * Before reaching here, it was expected to lock the text_mutex
> > -	 * already, so we don't need to give another lock here and could
> > -	 * ensure that it was safe between each cores.
> > -	 */
> > -	lockdep_assert_held(&text_mutex);
> > -
> >  	if (across_pages)
> >  		patch_map(addr + len, FIX_TEXT_POKE1);
> 
> Well, we definately need the lock -- otherwise concurrent callers will
> install conflicting maps for FIX_TEXT_POKE*, step on each other, and install
> the wrong patch.  I just sent out a patch to use an explicit lock here, as
> sharing text_mutex doesn't seem safe.

It has already locked by text_mutex. The real problem is lockdep cannot
handle this case(with stopmachine) or it is a false positive report.

-- 
Cheers,
Changbin Du
