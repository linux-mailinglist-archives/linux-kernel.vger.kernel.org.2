Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8C584259AA
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Oct 2021 19:40:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243347AbhJGRl7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Oct 2021 13:41:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242882AbhJGRl4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Oct 2021 13:41:56 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15AD6C061570
        for <linux-kernel@vger.kernel.org>; Thu,  7 Oct 2021 10:40:03 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id ls14-20020a17090b350e00b001a00e2251c8so5679943pjb.4
        for <linux-kernel@vger.kernel.org>; Thu, 07 Oct 2021 10:40:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=bb1PkufxTe67IhpBxyKhxa8OO+NUTrwc7Sa3gVKgQik=;
        b=QdfITAjwVIWvpjbba2nldZcuwI42UwAeKz/mh7y2UX41AOpUsHwg3GSQ9xCeCDkhnC
         HANw7QQld2O14WtMeHp4d9JBofQ7cXYRXi1Xgn7ardWnp5M0vOMmhkWIOzxQZi+DGU63
         T6fdi0CRBNgETYeE+MQPfbL80xYR+qc2vxEp0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=bb1PkufxTe67IhpBxyKhxa8OO+NUTrwc7Sa3gVKgQik=;
        b=aKlkFYK1tYqpVTjyIgPX5pwv7D0MD1FIu+bTiAVf7eibl8QW9oiRKiUvN1tHW5eY8a
         AevFZ19bUk9QjzOX5GtivEeUPm/ipH123RyzaFvmf9zMpA7A506NTTxB2I5bbHvINT24
         NQtmZwkceJ+2m7BS2iq7bOmGAxu3r8eetaASqwqpxZslZy+JJ+SOi8ysJ+mGf704IrsN
         nuqRoWYygLeERkkK7oCTZrRUYg7DSzMitLzCDoaDLzUki+AuTxSwiLYomEfLoCejEVev
         9cPDmVVMvn0DUbKMxci6nAYFhJUfRJljGMIVa6jBPvBf8U0L65ebvWUpbkNNK7vMbY0y
         yJbg==
X-Gm-Message-State: AOAM533MaTtAEBDp1HExSXijIU4nxVNuDc5u3kDBwiIV+LdAYYF9T0w5
        DL+N+mm3Xf9D6klRJ1gPBn/ZX0u8cTdXCA==
X-Google-Smtp-Source: ABdhPJy2dPjsVPaV/5Jd9g8K/7TyeNi/lc7GoBrxtoOJyFRPBerhbrZK09W53FOLQm3NxYo+UK6g5A==
X-Received: by 2002:a17:90a:1a58:: with SMTP id 24mr6997975pjl.45.1633628402419;
        Thu, 07 Oct 2021 10:40:02 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id t3sm111954pgo.51.2021.10.07.10.40.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Oct 2021 10:40:01 -0700 (PDT)
Date:   Thu, 7 Oct 2021 10:40:01 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Alexey Dobriyan <adobriyan@gmail.com>
Cc:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ELF: fix overflow in total mapping size calculation
Message-ID: <202110071038.B589687@keescook>
References: <YVmd7D0M6G/DcP4O@localhost.localdomain>
 <202110051929.37279B6B4A@keescook>
 <YV8sQ5vhD+V6XLXx@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YV8sQ5vhD+V6XLXx@localhost.localdomain>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 07, 2021 at 08:20:03PM +0300, Alexey Dobriyan wrote:
> On Tue, Oct 05, 2021 at 07:31:09PM -0700, Kees Cook wrote:
> > On Sun, Oct 03, 2021 at 03:11:24PM +0300, Alexey Dobriyan wrote:
> > > Kernel assumes that ELF program headers are ordered by mapping address,
> > > but doesn't enforce it. It is possible to make mapping size extremely huge
> > > by simply shuffling first and last PT_LOAD segments.
> > > 
> > > As long as PT_LOAD segments do not overlap, it is silly to require
> > > sorting by v_addr anyway because mmap() doesn't care.
> > > 
> > > Don't assume PT_LOAD segments are sorted and calculate min and max
> > > addresses correctly.
> > 
> > Nice! Yes, this all make sense.
> > 
> > > 
> > > Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
> > > ---
> > > 
> > >  fs/binfmt_elf.c |   23 +++++++++++------------
> > >  1 file changed, 11 insertions(+), 12 deletions(-)
> > > 
> > > --- a/fs/binfmt_elf.c
> > > +++ b/fs/binfmt_elf.c
> > > @@ -93,7 +93,7 @@ static int elf_core_dump(struct coredump_params *cprm);
> > >  #define ELF_CORE_EFLAGS	0
> > >  #endif
> > >  
> > > -#define ELF_PAGESTART(_v) ((_v) & ~(unsigned long)(ELF_MIN_ALIGN-1))
> > > +#define ELF_PAGESTART(_v) ((_v) & ~(int)(ELF_MIN_ALIGN-1))
> > 
> > Errr, this I don't like. I assume this is because of the min() use
> > below?
> 
> Yes, this is to shut up the warning.
> 
> The macro is slightly incorrect because "_v" can be either uint32_t or
> uint64_t. But standard ALIGN macros are slightly incorrect too.

Right, but "int" is neither 64-sized nor unsigned. :P I would just leave
this macro as-is.

> 
> I don't want to clean this particular mess right now. Those are separate stables.
> 
> > >  #define ELF_PAGEOFFSET(_v) ((_v) & (ELF_MIN_ALIGN-1))
> > >  #define ELF_PAGEALIGN(_v) (((_v) + ELF_MIN_ALIGN - 1) & ~(ELF_MIN_ALIGN - 1))
> > >  
> > > @@ -399,22 +399,21 @@ static unsigned long elf_map(struct file *filep, unsigned long addr,
> > >  	return(map_addr);
> > >  }
> > >  
> > > -static unsigned long total_mapping_size(const struct elf_phdr *cmds, int nr)
> > > +static unsigned long total_mapping_size(const struct elf_phdr *phdr, int nr)
> > >  {
> > > -	int i, first_idx = -1, last_idx = -1;
> > > +	elf_addr_t min_addr = -1;
> > > +	elf_addr_t max_addr = 0;
> > > +	bool pt_load = false;
> > > +	int i;
> > >  
> > >  	for (i = 0; i < nr; i++) {
> > > -		if (cmds[i].p_type == PT_LOAD) {
> > > -			last_idx = i;
> > > -			if (first_idx == -1)
> > > -				first_idx = i;
> > > +		if (phdr[i].p_type == PT_LOAD) {
> > > +			min_addr = min(min_addr, ELF_PAGESTART(phdr[i].p_vaddr));
> > > +			max_addr = max(max_addr, phdr[i].p_vaddr + phdr[i].p_memsz);
> > 
> > How about:
> > 		min_addr = min_t(elf_addr_t, min_addr, ELF_PAGESTART(phdr[i].p_vaddr));
> > 		max_addr = max_t(elf_addr_t, max_addr, phdr[i].p_vaddr + phdr[i].p_memsz);
> 
> No! The proper fix is to fix ELF_PAGESTART().

Why? The warning from min() is about making sure there isn't an
unexpected type conversion. min_t() uses an explicit type, so why not
the above?

-- 
Kees Cook
