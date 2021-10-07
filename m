Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1158425940
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Oct 2021 19:20:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243332AbhJGRWP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Oct 2021 13:22:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243314AbhJGRWB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Oct 2021 13:22:01 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA1BBC061755
        for <linux-kernel@vger.kernel.org>; Thu,  7 Oct 2021 10:20:06 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id t16so4007136eds.9
        for <linux-kernel@vger.kernel.org>; Thu, 07 Oct 2021 10:20:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=yKsD+bnBh7ZowB88TXB3Da8yHTszLtLZ5FscyLH62G8=;
        b=qzJrudNAbjJ/u+lxCUM3pJBXvEy8hefF83Q86cfsnLIin8POqkGg0iuOyBIR4DlTp0
         K2oM59cTFvIVXUM3XbgezLXqKRoa8rVCPeK94yyzT8E6iDfmrIPKTapu3/Qzf4FNUrEm
         /F9kl8OSoIsJvd++1BVBabNT2J9ORCI9wjGML666IbcpYE4nV5CMOHHOgqxkfMSLTiVU
         gSH2G2QJ8eR4bCJv9eF5NQni6/OBtEESs4WV9YWEThjGTrKbAyZejJ7Ve+d3sXznupud
         iNFEiG/gVwSrDr6qmfpqTFuWscx8Pls0/026nK0PEc/WfbRZU9T3UXrFVZTV61pDMnIi
         lAKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=yKsD+bnBh7ZowB88TXB3Da8yHTszLtLZ5FscyLH62G8=;
        b=ASPoTpC3kAl7FlyGTwhD1MQ+gIjQaMPBeaJkd6IpPA7L8t2qG0EIz0QnHxIinRPR8a
         x4BjOcQC9xl4+Z2RW/8gjqKc0ysSdPMlIzY7+Z0x/YINuj9u3uSNffE4/XidCWF2PExo
         JAAjRW+gwlRB0DNJyVnU7HBUi6ACzYXffQUvxfs2dPvbASrSQ6MPvOT7LlBBIQWvSCU4
         c7kF6htYyabUCMd51VwIz/U/IPXl6aZnBtU4eBRMiR6WvMOnuRsvgMKACuDUpj18Xmuj
         YxykQPR8jDnmRDvxbrToYsWGALKC4JT1WvcXYAUCvjqHOjHkMOtOS2eqydWpuzrKcU7n
         JySw==
X-Gm-Message-State: AOAM531Sm5cu1UdRbimEZCJzazhxc78BQj1R9YyBl9FcXa1Qhmf7AW5I
        DO+DZ/tdsCW40IEWRZADtuDiKXEPfA==
X-Google-Smtp-Source: ABdhPJx8BYLOJmIwk+xBK893swv1kTtzx0xJKr7m4H59dRnP4dxtfrlc6GiZr32dobuooNI4/mJ4wg==
X-Received: by 2002:a50:eb9a:: with SMTP id y26mr7684875edr.186.1633627205494;
        Thu, 07 Oct 2021 10:20:05 -0700 (PDT)
Received: from localhost.localdomain ([46.53.254.50])
        by smtp.gmail.com with ESMTPSA id n10sm4937ejk.86.2021.10.07.10.20.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Oct 2021 10:20:05 -0700 (PDT)
Date:   Thu, 7 Oct 2021 20:20:03 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ELF: fix overflow in total mapping size calculation
Message-ID: <YV8sQ5vhD+V6XLXx@localhost.localdomain>
References: <YVmd7D0M6G/DcP4O@localhost.localdomain>
 <202110051929.37279B6B4A@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <202110051929.37279B6B4A@keescook>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 05, 2021 at 07:31:09PM -0700, Kees Cook wrote:
> On Sun, Oct 03, 2021 at 03:11:24PM +0300, Alexey Dobriyan wrote:
> > Kernel assumes that ELF program headers are ordered by mapping address,
> > but doesn't enforce it. It is possible to make mapping size extremely huge
> > by simply shuffling first and last PT_LOAD segments.
> > 
> > As long as PT_LOAD segments do not overlap, it is silly to require
> > sorting by v_addr anyway because mmap() doesn't care.
> > 
> > Don't assume PT_LOAD segments are sorted and calculate min and max
> > addresses correctly.
> 
> Nice! Yes, this all make sense.
> 
> > 
> > Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
> > ---
> > 
> >  fs/binfmt_elf.c |   23 +++++++++++------------
> >  1 file changed, 11 insertions(+), 12 deletions(-)
> > 
> > --- a/fs/binfmt_elf.c
> > +++ b/fs/binfmt_elf.c
> > @@ -93,7 +93,7 @@ static int elf_core_dump(struct coredump_params *cprm);
> >  #define ELF_CORE_EFLAGS	0
> >  #endif
> >  
> > -#define ELF_PAGESTART(_v) ((_v) & ~(unsigned long)(ELF_MIN_ALIGN-1))
> > +#define ELF_PAGESTART(_v) ((_v) & ~(int)(ELF_MIN_ALIGN-1))
> 
> Errr, this I don't like. I assume this is because of the min() use
> below?

Yes, this is to shut up the warning.

The macro is slightly incorrect because "_v" can be either uint32_t or
uint64_t. But standard ALIGN macros are slightly incorrect too.

I don't want to clean this particular mess right now. Those are separate stables.

> >  #define ELF_PAGEOFFSET(_v) ((_v) & (ELF_MIN_ALIGN-1))
> >  #define ELF_PAGEALIGN(_v) (((_v) + ELF_MIN_ALIGN - 1) & ~(ELF_MIN_ALIGN - 1))
> >  
> > @@ -399,22 +399,21 @@ static unsigned long elf_map(struct file *filep, unsigned long addr,
> >  	return(map_addr);
> >  }
> >  
> > -static unsigned long total_mapping_size(const struct elf_phdr *cmds, int nr)
> > +static unsigned long total_mapping_size(const struct elf_phdr *phdr, int nr)
> >  {
> > -	int i, first_idx = -1, last_idx = -1;
> > +	elf_addr_t min_addr = -1;
> > +	elf_addr_t max_addr = 0;
> > +	bool pt_load = false;
> > +	int i;
> >  
> >  	for (i = 0; i < nr; i++) {
> > -		if (cmds[i].p_type == PT_LOAD) {
> > -			last_idx = i;
> > -			if (first_idx == -1)
> > -				first_idx = i;
> > +		if (phdr[i].p_type == PT_LOAD) {
> > +			min_addr = min(min_addr, ELF_PAGESTART(phdr[i].p_vaddr));
> > +			max_addr = max(max_addr, phdr[i].p_vaddr + phdr[i].p_memsz);
> 
> How about:
> 		min_addr = min_t(elf_addr_t, min_addr, ELF_PAGESTART(phdr[i].p_vaddr));
> 		max_addr = max_t(elf_addr_t, max_addr, phdr[i].p_vaddr + phdr[i].p_memsz);

No! The proper fix is to fix ELF_PAGESTART().
