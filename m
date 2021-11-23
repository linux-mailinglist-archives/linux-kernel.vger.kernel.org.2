Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA74345A748
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Nov 2021 17:11:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237053AbhKWQO7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Nov 2021 11:14:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236552AbhKWQO6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Nov 2021 11:14:58 -0500
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AFB6C061574
        for <linux-kernel@vger.kernel.org>; Tue, 23 Nov 2021 08:11:50 -0800 (PST)
Received: by mail-ot1-x333.google.com with SMTP id w6-20020a9d77c6000000b0055e804fa524so34458859otl.3
        for <linux-kernel@vger.kernel.org>; Tue, 23 Nov 2021 08:11:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ckGV4VlH3o4N0FnEKWdKWRp2/mLTMGiSVx3IOfpNe1o=;
        b=c+RBw4cHnHXJN5eiqGdZXgCCFI3gJKPOpj9eDXTdXo82jVZsgQanmtKPktQ5xKX2Og
         t0igPqGqXBxiiWoZNtcvQAV2mQFCVX6G7DQKoyIevus2pjdU+i/YNG7xxob4ZAYAbwp/
         X/PfmXzmwTmMfqkdqqbDJ6cOBlKBCBULCMrKWxN74hGfVNdjUXVJiajkYqjw8Gds40sS
         hdjCeXwF9GnyZaXZO1G3aYOAEwejgSkE4V20hEH/8y7fJkPQwzNJnnMOL72DvgnJKkzF
         HLnkgiCZ+xUihGt0v5cIB9p9jDmWO/84inKIsHLvKT0XnQ9Eg4/eOI1Z/V3ftMjNN+dz
         2SSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=ckGV4VlH3o4N0FnEKWdKWRp2/mLTMGiSVx3IOfpNe1o=;
        b=nyFJJMSfL4/3/j47R1OGT7AQVZqVEHE/9psXlhi5UmRCjX9OYcpl4vhqdRs6aqyqQv
         DY9ewdzz8F+L8PXaiS+Ee6ZYvlRyhKRcaCQICKyOm3UkQGK98Z3HQ4SSL1B4coiVGDmE
         vtCfJ/oSRlvBEevc6qEG89uyQlJAYQAfWbBDxK2t6tzELXXU399LTknElEzFw8M462To
         CIHzIj9iKIig3ZLfQDhQsa4InURznbJSdL+j4AQ8r4dEmfjNewygVtNh+ZJcMC1xaPnZ
         KubM9uwo4kQqXnx/xu876KYSld3XLl5n9hppYo0JQGJAWcAV4HtVQ+T8uSsWnNymqoff
         mJxw==
X-Gm-Message-State: AOAM530FeB9auqigFPTDoqgUime5rqSW0DudGXV/dTXPxb7k4dK7WQjA
        xgn7+a68c5wMRxTX0afpIV4=
X-Google-Smtp-Source: ABdhPJzgL2EqGUDWGsx3qgkhYnLWsI6Wj4P0/TyDIG2rgJ1VJFD3NB7S8I5Ot8KLfK7o9j04KTXLig==
X-Received: by 2002:a05:6830:1358:: with SMTP id r24mr5723465otq.8.1637683909801;
        Tue, 23 Nov 2021 08:11:49 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id h14sm2278875ots.22.2021.11.23.08.11.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Nov 2021 08:11:49 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Tue, 23 Nov 2021 08:11:48 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Joel Stanley <joel@jms.id.au>,
        Anton Altaparmakov <anton@tuxera.com>,
        linux-ntfs-dev@lists.sourceforge.net,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH v2] fs: ntfs: Disable NTFS_RW for PPC
Message-ID: <20211123161148.GC2326185@roeck-us.net>
References: <20211122230653.1779162-1-linux@roeck-us.net>
 <CACPK8XfM1e7b6m_QBhJFgXCXhqOajMKGUkWqRGxa5sCKyLxRQg@mail.gmail.com>
 <b63d1758-b434-93c3-164c-b536c7437bdf@roeck-us.net>
 <87a6hvqeq3.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87a6hvqeq3.fsf@mpe.ellerman.id.au>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 23, 2021 at 10:43:48PM +1100, Michael Ellerman wrote:
[ ... ]
> >
> > So we are looking for something like
> >
> > config DISABLE_NTFS_RW
> > 	bool
> > 	default y if PAGE_SIZE_256KB || PPC_256K_PAGES || \
> > 		PAGE_SIZE_64KB || ARM64_64K_PAGES || IA64_PAGE_SIZE_64KB || \
> > 		PARISC_PAGE_SIZE_64KB || PPC_64K_PAGES
> >
> > Anything else ?
> 
> Can we do something like this instead?
> 
> I'm pretty sure it does what we want for NTFS, and also for VMXNET3.
> 
> It is not pretty, but at least keeps the arch specifics out of driver
> Kconfigs.
> 
> cheers
> 
> 
> diff --git a/arch/Kconfig b/arch/Kconfig
> index 26b8ed11639d..d3c4ab249e9c 100644
> --- a/arch/Kconfig
> +++ b/arch/Kconfig
> @@ -991,6 +991,16 @@ config HAVE_ARCH_COMPAT_MMAP_BASES
>  	  and vice-versa 32-bit applications to call 64-bit mmap().
>  	  Required for applications doing different bitness syscalls.
>  
> +config PAGE_SIZE_LESS_THAN_64KB
> +	def_bool y
> +	depends on !ARM64_64K_PAGES
> +	depends on !IA64_PAGE_SIZE_64KB
> +	depends on !PAGE_SIZE_64KB
> +	depends on !PARISC_PAGE_SIZE_64KB
> +	depends on !PPC_64K_PAGES
> +	depends on !PPC_256K_PAGES
> +	depends on !PAGE_SIZE_256KB
> +

Sure, works for me. I'll wait another day or two for additional feedback
before sending out v3.

Guenter

>  # This allows to use a set of generic functions to determine mmap base
>  # address by giving priority to top-down scheme only if the process
>  # is not in legacy mode (compat task, unlimited stack size or
> diff --git a/fs/ntfs/Kconfig b/fs/ntfs/Kconfig
> index 1667a7e590d8..f93e69a61283 100644
> --- a/fs/ntfs/Kconfig
> +++ b/fs/ntfs/Kconfig
> @@ -52,6 +52,7 @@ config NTFS_DEBUG
>  config NTFS_RW
>  	bool "NTFS write support"
>  	depends on NTFS_FS
> +	depends on PAGE_SIZE_LESS_THAN_64KB
>  	help
>  	  This enables the partial, but safe, write support in the NTFS driver.
>  
