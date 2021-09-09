Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5379405FBC
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Sep 2021 00:51:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346831AbhIIWwh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Sep 2021 18:52:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346669AbhIIWwf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Sep 2021 18:52:35 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A63BBC061575
        for <linux-kernel@vger.kernel.org>; Thu,  9 Sep 2021 15:51:25 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id k23so102348pji.0
        for <linux-kernel@vger.kernel.org>; Thu, 09 Sep 2021 15:51:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=zjfjoKfAyLUu17TUBmafdcx7ZjtKrPqEZ88OWOwwmOo=;
        b=FJ0sSwN5MzU3wz/mLMk/pJRqghJOwHE3n+7an1s3JLsGOce0TKvMypw99AWhb4jWnp
         O1pV5QBv2tuwzyMGfUK8NliQB6n13EeftXaAv7iDEhnapgYg/jallCkSqYJsW0zCsc+U
         ZGlmKtK3LUcyf6suaU0970vHr4G5pthcmO9cc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=zjfjoKfAyLUu17TUBmafdcx7ZjtKrPqEZ88OWOwwmOo=;
        b=2XljkcaWEPWBjXFACbhTz2YzKM96uirGNZmaOW4TgY2BgE+X4/CZPI25r4fKUJv/Gd
         BlziRPBsS5ufl02GBXm/t9+3+tgdu2U5f0PKEM3kerodrI2/GYxXhT5/QblMPpijCb31
         PBeipf/YnTe6c9Is6ZAKerD4VDIcxdCfDoAi2hlbFIlYrRECVyzXV/wxHszWO6JrRO9h
         /Mrch6wmWljECVd7nQbLHKVL6Mvno0h3F+Nx+6a1pjPv8AcsNssFfW0PDqo9nhyJv9mS
         xlsGi5x0vMbhXLujgr2f4VjnSbuomZB64gKjl14T8q4E4pvyfw5EFYPSzinh55CtmCTE
         r9BQ==
X-Gm-Message-State: AOAM533RKwa5wkxtBTFaWhS3UcO2FHR2lTgwGVe74aFwnXywg11QYhxq
        g8I5q8FGRgB/x8Ptq2MwUAQ29g==
X-Google-Smtp-Source: ABdhPJxhhcd9zPLQvqtYq5i5kvuPYbI/YKkJ2K+K0w85jnCSHF1Rt/+xWEKm6txjrbKn/Xe6VSgyjQ==
X-Received: by 2002:a17:90b:957:: with SMTP id dw23mr5938225pjb.125.1631227885202;
        Thu, 09 Sep 2021 15:51:25 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id u21sm3481935pgk.57.2021.09.09.15.51.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Sep 2021 15:51:24 -0700 (PDT)
Date:   Thu, 9 Sep 2021 15:51:23 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     kernel test robot <lkp@intel.com>,
        Matt Porter <mporter@kernel.crashing.org>,
        Alexandre Bounine <alex.bou9@gmail.com>,
        Jing Xiangfeng <jingxiangfeng@huawei.com>,
        Ira Weiny <ira.weiny@intel.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Souptick Joarder <jrdr.linux@gmail.com>,
        "Gustavo A . R . Silva" <gustavoars@kernel.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] rapidio: Avoid bogus __alloc_size warning
Message-ID: <202109091549.FF8E0C61E2@keescook>
References: <20210909161409.2250920-1-keescook@chromium.org>
 <20210909132752.4bde36ccf50720e56160f00c@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210909132752.4bde36ccf50720e56160f00c@linux-foundation.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 09, 2021 at 01:27:52PM -0700, Andrew Morton wrote:
> On Thu,  9 Sep 2021 09:14:09 -0700 Kees Cook <keescook@chromium.org> wrote:
> 
> > GCC 9.3 (but not later) incorrectly evaluates the arguments to
> > check_copy_size(), getting seemingly confused by the size being returned
> > from array_size(). Instead, perform the calculation once, which both
> > makes the code more readable and avoids the bug in GCC.
> > 
> >    In file included from arch/x86/include/asm/preempt.h:7,
> >                     from include/linux/preempt.h:78,
> >                     from include/linux/spinlock.h:55,
> >                     from include/linux/mm_types.h:9,
> >                     from include/linux/buildid.h:5,
> >                     from include/linux/module.h:14,
> >                     from drivers/rapidio/devices/rio_mport_cdev.c:13:
> >    In function 'check_copy_size',
> >        inlined from 'copy_from_user' at include/linux/uaccess.h:191:6,
> >        inlined from 'rio_mport_transfer_ioctl' at drivers/rapidio/devices/rio_mport_cdev.c:983:6:
> >    include/linux/thread_info.h:213:4: error: call to '__bad_copy_to' declared with attribute error: copy destination size is too small
> >      213 |    __bad_copy_to();
> >          |    ^~~~~~~~~~~~~~~
> > 
> > But the allocation size and the copy size are identical:
> > 
> > 	transfer = vmalloc(array_size(sizeof(*transfer), transaction.count));
> > 	if (!transfer)
> > 		return -ENOMEM;
> > 
> > 	if (unlikely(copy_from_user(transfer,
> > 				    (void __user *)(uintptr_t)transaction.block,
> > 				    array_size(sizeof(*transfer), transaction.count)))) {
> 
> That's an "error", not a warning.  Or is this thanks to the new -Werror?

This is a "regular" error (__bad_copy_to() uses __compiletime_error()).

> Either way, I'm inclined to cc:stable on this, because use of gcc-9 on
> older kernels will be a common thing down the ages.
> 
> If it's really an "error" on non-Werror kernels then definitely cc:stable.

I would expect that as only being needed if __alloc_size was backported
to -stable, which seems unlikely.

-- 
Kees Cook
