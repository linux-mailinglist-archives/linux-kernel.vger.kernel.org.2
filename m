Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E66640C9B4
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Sep 2021 18:05:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234051AbhIOQGv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Sep 2021 12:06:51 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:44990 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbhIOQGt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Sep 2021 12:06:49 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 073D222296;
        Wed, 15 Sep 2021 16:05:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1631721928; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=LdcHbBnWgBJkZLhfI91fatjdoluwa+ngRYImj4hNKsw=;
        b=Z2CECb+HpdKgJoPke2KE6qM+CoCoBBotOugtyIC/nOe+NQrTpSmNnshRy78LREFhgDiQBv
        i8YcCivfhW5gDUYu38PbY4u0mo1kX3tUNRjThse906PqkMQNnfHcfbPqxBYO90Yd8JE9bc
        OYV403CIzF+YolxvC9bj31cvjhENQEM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1631721928;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=LdcHbBnWgBJkZLhfI91fatjdoluwa+ngRYImj4hNKsw=;
        b=72QXXUVdo3RcUbY60/Jor7fuRCZ/SYVWCSP0x42vgHPBahWnRmsxeRai1WgHefivyjMSif
        9DnJJu1IQaa8+mCA==
Received: from lion.mk-sys.cz (unknown [10.100.200.14])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id CD662A3B90;
        Wed, 15 Sep 2021 16:05:26 +0000 (UTC)
Received: by lion.mk-sys.cz (Postfix, from userid 1000)
        id B2BD7607E0; Wed, 15 Sep 2021 18:05:26 +0200 (CEST)
Date:   Wed, 15 Sep 2021 18:05:26 +0200
From:   Michal Kubecek <mkubecek@suse.cz>
To:     Jisheng Zhang <jszhang3@mail.ustc.edu.cn>
Cc:     Miles Chen <miles.chen@mediatek.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Jisheng Zhang <jszhang@kernel.org>,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-mediatek@lists.infradead.org, wsd_upstream@mediatek.com
Subject: Re: [PATCH] scripts/sorttable: riscv: fix undelcred identifier
 'EM_RISCV' error
Message-ID: <20210915160526.tittz3fewddjrqu3@lion.mk-sys.cz>
References: <20210913030625.4525-1-miles.chen@mediatek.com>
 <20210915215432.02a5e08e@xhacker>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210915215432.02a5e08e@xhacker>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 15, 2021 at 09:54:32PM +0800, Jisheng Zhang wrote:
> On Mon, 13 Sep 2021 11:06:25 +0800
> Miles Chen <miles.chen@mediatek.com> wrote:
> 
> > Fix the following build break by adding a conditional definition
> > of EM_RISCV in order to allow cross-compilation on machines
> > which do not have EM_RISCV definition in their host.
> > 
> > build break log from [1]:
> > scripts/sorttable.c:352:7: error: use of undeclared identifier 'EM_RISCV'
> 
> Looks strange I can't reproduce it. FWICT, this may be seen with some old
> toolchains.

I checked the history and EM_RISCV was added to <elf.h> in glibc 2.24 so
builds on systems with glibc headers < 2.24 should show this error.

Michal

> > [1] https://lore.kernel.org/lkml/e8965b25-f15b-c7b4-748c-d207dda9c8e8@i2se.com/
> > 
> > Cc: Jisheng Zhang <jszhang@kernel.org>
> > Reported-by: Stefan Wahren <stefan.wahren@i2se.com>
> > Fixes: 54fed35fd393 ("riscv: Enable BUILDTIME_TABLE_SORT")
> > Signed-off-by: Miles Chen <miles.chen@mediatek.com>
> 
> Reviewed-by: Jisheng Zhang <jszhang@kernel.org>
> 
> > ---
> >  scripts/sorttable.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> > 
> > diff --git a/scripts/sorttable.c b/scripts/sorttable.c
> > index f355869c65cd..6ee4fa882919 100644
> > --- a/scripts/sorttable.c
> > +++ b/scripts/sorttable.c
> > @@ -54,6 +54,10 @@
> >  #define EM_ARCV2	195
> >  #endif
> >  
> > +#ifndef EM_RISCV
> > +#define EM_RISCV	243
> > +#endif
> > +
> >  static uint32_t (*r)(const uint32_t *);
> >  static uint16_t (*r2)(const uint16_t *);
> >  static uint64_t (*r8)(const uint64_t *);
> 
> 
> 
> _______________________________________________
> Linux-mediatek mailing list
> Linux-mediatek@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-mediatek
