Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F339425AC9
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Oct 2021 20:31:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234200AbhJGSdi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Oct 2021 14:33:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231340AbhJGSdh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Oct 2021 14:33:37 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F823C061570
        for <linux-kernel@vger.kernel.org>; Thu,  7 Oct 2021 11:31:43 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id y12so13312444eda.4
        for <linux-kernel@vger.kernel.org>; Thu, 07 Oct 2021 11:31:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=6LwfThH1T+dtzaaoOR7FbBXxaA+5ZtH4LGikgiOctTM=;
        b=Fbys/hX/KwxhLeHeUdym/Ow/lT3k4R9FyxvX7TI52UOEaF/lUT6EgKzEEiBn2vdXqt
         b6wVZd9pfZBiJrs6sAjcFXS/oCEjyXrDRT3lv+80P6U4/fkKZOy4qxGl2RHrjgPwYv3w
         e7ie+Zlh4MgXgLLfKAi+8FH56XCjt6FpeR+bgDjrgDX/gaEp6GBy7rnNPs/bsUiP/GJz
         RRwm9QRYUuzLLw0LAW77yfIgr/iOjFztj80PAvi0ex7Vd7fNiejBhe+EnLaU/M4JrKTu
         d7ruN+4kySzmPJERzCXelSFM0hcU7QhZFeIsWR5mA8GJVpse7+i86AzFunGasRraZqdV
         QFKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=6LwfThH1T+dtzaaoOR7FbBXxaA+5ZtH4LGikgiOctTM=;
        b=gG0USRpxcnFOIdRxgxduiv/AZoGvRLl5GCsQByHb3x/wc4K0VrVZmB55hvFlpcn0Wh
         GgxOSRkIhDciHhI5zgNb3tu5YXEM0pu45H5qb0SbgGxTdPzHnCe7ADWhvDSaWer2pU1w
         WC0jj5A8jQHQETmXyptIDab8V4Horwh9JTBCC0qZiV314klRjYLhHSH2fP2UvAYcYgve
         um7tzdqnmx4tsgi+itqDn0dN4rXT+zFcvbxl6NA6NfkPmsrMpAQcWN0eQttqK9cmydy3
         FJr8BoYsEdxrAn/gbkgYPSYEwc9I6V/U1QMPYqIg2++3f0uh7GYOTUqj2f32xFEraeiU
         nXOg==
X-Gm-Message-State: AOAM531knDl2pqNKj9J2bvIHd111LJFoVQWgEfnvZec3g7VJ+K9a2PEc
        7shLuLqi1zUsPyJVNo10tg==
X-Google-Smtp-Source: ABdhPJxgOobkWg36mdl0tiOhIhQIdu+6nIgO2C5yiy/zSCUWJIzj8KpBM7gGBIsmCQxBDB3l9ZGS0Q==
X-Received: by 2002:a05:6402:280b:: with SMTP id h11mr7266098ede.78.1633631501906;
        Thu, 07 Oct 2021 11:31:41 -0700 (PDT)
Received: from localhost.localdomain ([46.53.254.50])
        by smtp.gmail.com with ESMTPSA id v13sm67464ejh.62.2021.10.07.11.31.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Oct 2021 11:31:41 -0700 (PDT)
Date:   Thu, 7 Oct 2021 21:31:40 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ELF: fix overflow in total mapping size calculation
Message-ID: <YV89DPAbNxjZfPY+@localhost.localdomain>
References: <YVmd7D0M6G/DcP4O@localhost.localdomain>
 <202110051929.37279B6B4A@keescook>
 <YV8sQ5vhD+V6XLXx@localhost.localdomain>
 <202110071038.B589687@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <202110071038.B589687@keescook>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 07, 2021 at 10:40:01AM -0700, Kees Cook wrote:
> On Thu, Oct 07, 2021 at 08:20:03PM +0300, Alexey Dobriyan wrote:
> > On Tue, Oct 05, 2021 at 07:31:09PM -0700, Kees Cook wrote:
> > > On Sun, Oct 03, 2021 at 03:11:24PM +0300, Alexey Dobriyan wrote:
> > > > Kernel assumes that ELF program headers are ordered by mapping address,
> > > > but doesn't enforce it. It is possible to make mapping size extremely huge
> > > > by simply shuffling first and last PT_LOAD segments.
> > > > 
> > > > As long as PT_LOAD segments do not overlap, it is silly to require
> > > > sorting by v_addr anyway because mmap() doesn't care.
> > > > 
> > > > Don't assume PT_LOAD segments are sorted and calculate min and max
> > > > addresses correctly.
> > > 
> > > Nice! Yes, this all make sense.
> > > 
> > > > 
> > > > Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
> > > > ---
> > > > 
> > > >  fs/binfmt_elf.c |   23 +++++++++++------------
> > > >  1 file changed, 11 insertions(+), 12 deletions(-)
> > > > 
> > > > --- a/fs/binfmt_elf.c
> > > > +++ b/fs/binfmt_elf.c
> > > > @@ -93,7 +93,7 @@ static int elf_core_dump(struct coredump_params *cprm);
> > > >  #define ELF_CORE_EFLAGS	0
> > > >  #endif
> > > >  
> > > > -#define ELF_PAGESTART(_v) ((_v) & ~(unsigned long)(ELF_MIN_ALIGN-1))
> > > > +#define ELF_PAGESTART(_v) ((_v) & ~(int)(ELF_MIN_ALIGN-1))
> > > 
> > > Errr, this I don't like. I assume this is because of the min() use
> > > below?
> > 
> > Yes, this is to shut up the warning.
> > 
> > The macro is slightly incorrect because "_v" can be either uint32_t or
> > uint64_t. But standard ALIGN macros are slightly incorrect too.
> 
> Right, but "int" is neither 64-sized nor unsigned. :P I would just leave
> this macro as-is.

"int" will be promoted to either "unsigned int" or to whatever 64-bit
ELF type is, it is enough to fix warnings, it will be sign extended
correctly.
