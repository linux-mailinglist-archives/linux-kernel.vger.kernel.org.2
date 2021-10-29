Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74D8943FD58
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Oct 2021 15:27:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231734AbhJ2N3u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Oct 2021 09:29:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231675AbhJ2N3s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Oct 2021 09:29:48 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 689E6C061766
        for <linux-kernel@vger.kernel.org>; Fri, 29 Oct 2021 06:27:20 -0700 (PDT)
Received: from zn.tnic (p200300ec2f124b005f7fe4c191bfb5ca.dip0.t-ipconnect.de [IPv6:2003:ec:2f12:4b00:5f7f:e4c1:91bf:b5ca])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id C76421EC06BD;
        Fri, 29 Oct 2021 15:27:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1635514038;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=sw+2PIhSpcLWfJtxZOmkTEWOVehuhGr0FEtJRzFlr5w=;
        b=UPRTQyLdJhPX5upR5T+RK7QwDEU0jGpUGy7VlXfeOGxCdrCZrVSOyJjOPt3HI4XOpmIOrn
        x8h5/CqtQPTKEFsGhoF/zXw55cWUmKbENrIkP0ApSLPikEE0gkv9PrFbyF81Wkp0xitRnY
        qI75z+RK/QllPek1CbG7u3fbMMkSBQY=
Date:   Fri, 29 Oct 2021 15:27:14 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Elyes HAOUAS <ehaouas@noos.fr>
Cc:     x86@kernel.org, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] arch/x86/boot/compressed: Remove unneeded whitespaces
 before tabs
Message-ID: <YXv2slNHl9g0TU87@zn.tnic>
References: <20211029123952.5207-1-ehaouas@noos.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211029123952.5207-1-ehaouas@noos.fr>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Oct 29, 2021 at 02:39:53PM +0200, Elyes HAOUAS wrote:
> Signed-off-by: Elyes HAOUAS <ehaouas@noos.fr>
> ---
> 
> diff --git a/arch/x86/boot/compressed/Makefile b/arch/x86/boot/compressed/Makefile
> index 431bf7f846c3..e6fae0b6cce8 100644
> --- a/arch/x86/boot/compressed/Makefile
> +++ b/arch/x86/boot/compressed/Makefile
> @@ -139,8 +139,8 @@ suffix-$(CONFIG_KERNEL_GZIP)	:= gz
>  suffix-$(CONFIG_KERNEL_BZIP2)	:= bz2
>  suffix-$(CONFIG_KERNEL_LZMA)	:= lzma
>  suffix-$(CONFIG_KERNEL_XZ)	:= xz
> -suffix-$(CONFIG_KERNEL_LZO) 	:= lzo
> -suffix-$(CONFIG_KERNEL_LZ4) 	:= lz4
> +suffix-$(CONFIG_KERNEL_LZO)	:= lzo
> +suffix-$(CONFIG_KERNEL_LZ4)	:= lz4
>  suffix-$(CONFIG_KERNEL_ZSTD)	:= zst
>  
>  quiet_cmd_mkpiggy = MKPIGGY $@
> diff --git a/arch/x86/boot/compressed/vmlinux.lds.S b/arch/x86/boot/compressed/vmlinux.lds.S
> index 112b2375d021..d97d255b1103 100644
> --- a/arch/x86/boot/compressed/vmlinux.lds.S
> +++ b/arch/x86/boot/compressed/vmlinux.lds.S
> @@ -31,7 +31,7 @@ SECTIONS
>  		*(.rodata..compressed)
>  	}
>  	.text :	{
> -		_text = .; 	/* Text */
> +		_text = .;	/* Text */
>  		*(.text)
>  		*(.text.*)
>  		_etext = . ;
> -- 

a couple of things:

1. When sending patches, always run them through checkpatch before that
- some of the warnings make sense:

./scripts/checkpatch.pl /tmp/ehaouas.01
WARNING: Missing commit description - Add an appropriate one

total: 0 errors, 1 warnings, 18 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/tmp/ehaouas.01 has style problems, please review.

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.

2. When submitting patches, always make sure you CC lkml like I've done.

3. I took your whitespace cleanup patch because you seemed new and I
thought you'd like to get your feet wet.

But, that doesn't mean that I would like to see more whitespace
cleanup patches. They get in the way when one does git archeology and
tries to find which patch changed which line. IOW, if you want to
learn more about hacking the kernel, I'd suggest you start reading
Documentation/process/ on how the collaboration process looks like.

Then, you can start testing the kernel on your machines and see if all
works.

If there's a bug, you can try to report it - that's also explained
there.

And then you can do some further reading on how to get involved by
searching the net:

https://duckduckgo.com/?q=getting+involved+with+kernel+development&ia=web

Doing those things is a lot more beneficial than doing whitespace
cleanup patches.

If you have questions along the way, feel free to ask them.

HTH.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
