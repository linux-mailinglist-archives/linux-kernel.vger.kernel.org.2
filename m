Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A76D41921B
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Sep 2021 12:19:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233806AbhI0KUu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Sep 2021 06:20:50 -0400
Received: from mail.skyhub.de ([5.9.137.197]:47532 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233757AbhI0KUs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Sep 2021 06:20:48 -0400
Received: from zn.tnic (p200300ec2f088a001ce91a9f1eb42005.dip0.t-ipconnect.de [IPv6:2003:ec:2f08:8a00:1ce9:1a9f:1eb4:2005])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 322C01EC05A1;
        Mon, 27 Sep 2021 12:19:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1632737946;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=f4MqafVCNG9kQr5L9z8VSqXx2Ma3qxv7FQsATXeZraw=;
        b=eWR8rXeCLXbVadonrYrld91+PX3WGYs0yBy8kFtzJ2bsXpiT16fEsylR8/tXeI4gR0X6gr
        Gau2aQ1aJexMU43g6fQL/H2EIIPZDCUvqeVvdWxFv18ndHOjiY0RH8XnTv/YjWlmYDUpjH
        5yQUDd7/P1l2AOVREMziz5yn1xYFEu0=
Date:   Mon, 27 Sep 2021 12:19:00 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Lai Jiangshan <jiangshanlai@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        Lai Jiangshan <laijs@linux.alibaba.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, Joerg Roedel <jroedel@suse.de>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Brijesh Singh <brijesh.singh@amd.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Juergen Gross <jgross@suse.com>, Chester Lin <clin@suse.com>
Subject: Re: [PATCH V2 02/41] x86/traps: Remove stack-protector from traps.c
Message-ID: <YVGalJLOyK235XvG@zn.tnic>
References: <20210926150838.197719-1-jiangshanlai@gmail.com>
 <20210926150838.197719-3-jiangshanlai@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210926150838.197719-3-jiangshanlai@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 26, 2021 at 11:07:59PM +0800, Lai Jiangshan wrote:
> diff --git a/arch/x86/kernel/Makefile b/arch/x86/kernel/Makefile
> index 8f4e8fa6ed75..0e054e2304c6 100644
> --- a/arch/x86/kernel/Makefile
> +++ b/arch/x86/kernel/Makefile
> @@ -48,6 +48,9 @@ KCOV_INSTRUMENT		:= n
>  
>  CFLAGS_head$(BITS).o	+= -fno-stack-protector
>  
> +CFLAGS_REMOVE_traps.o		= -fstack-protector -fstack-protector-strong

Why this too?

> +CFLAGS_traps.o			+= -fno-stack-protector

Isn't this enough to disable stack protector for this file?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
