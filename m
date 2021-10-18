Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CEA7D43285C
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Oct 2021 22:20:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233166AbhJRUWU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Oct 2021 16:22:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229941AbhJRUWT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Oct 2021 16:22:19 -0400
Received: from bombadil.infradead.org (unknown [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32F38C06161C
        for <linux-kernel@vger.kernel.org>; Mon, 18 Oct 2021 13:20:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=uLsq3Q5ho+nb6+yvZSaF8DkHFKTenYkgYtLA2QYe3v8=; b=DZWs0bUlAXl+2U7nPd77I8su7s
        inpb62hVDpAkREhOOgZU1JEOpMBFHz7Av8AIFOniagjyshKJdCI2E+2K2h0IKRzwR3Yb2dKB4fNBB
        x6h3SRdiYteRbQR4K9TYM4UjM241LHnCWy3uXSVF3I4AqC87/N6LMSLs91VXMSe9NUkgwAxoH6CsQ
        4o+buV496sqHSVsQg1PjPWNlRokU3jJGuDSk1tEYrEbgaJynoV8+I2TU0QWQ0iNLJXczGNzbxyIT2
        Mwmq+lt1wi7kNLB7+p7v73ij/adUMHHHnL5V8NBhEOuHIsXJSDYHLMAAQAV4maxK1WLcoKGHF07m9
        V74zS5lw==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mcZ78-00HDXm-P8; Mon, 18 Oct 2021 20:20:06 +0000
Date:   Mon, 18 Oct 2021 13:20:06 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     jeyu@kernel.org, linux-kernel@vger.kernel.org, mbenes@suse.com
Subject: Re: [PATCH v2] module: fix validate_section_offset() overflow bug on
 64-bit
Message-ID: <YW3W9t/0axMDXAjv@bombadil.infradead.org>
References: <20211018173511.26542-1-skhan@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211018173511.26542-1-skhan@linuxfoundation.org>
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 18, 2021 at 11:35:11AM -0600, Shuah Khan wrote:
> validate_section_offset() uses unsigned long local variable to
> add/store shdr->sh_offset and shdr->sh_size on all platforms.
> unsigned long is too short when sh_offset is Elf64_Off which
> would be the case on 64bit ELF headers.
> 
> This problem was found while adding an error message to print
> sh_offset and sh_size. If sh_offset + sh_size exceed the size
> of the local variable, the checks for overflow and offset/size
> being too large will not find the problem and call the section
> offset valid. This failure might cause problems later on.
> 
> Fix the overflow problem using the right size local variable when
> CONFIG_64BIT is defined.
> 
> Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
> ---
> Changes since v1:
> - Updated commit log to describe the fix clearly. No code
>   changes.

Thanks! But the implications of your fix is beyond what is described.
Although not a real issue today in practice.

I think we should extend it with something like this, let me know
what you think (I can just ammend the commit log, no resend would
be needed):

Without this fix applied we were shorting the design of modules to
have section headers placed within the 32-bit boundary (4 GiB) instead of
64-bits when on 64-bit architectures (which allows for up to 16,777,216
TiB). In practice this just meant we were limiting modules to below 
4 GiB even on 64-bit systems. This then should not really affect any
real-world use case as modules these days obviously should likely never
exceed 1 GiB in size. A specially crafted invalid module might succeed to
skip validation in validate_section_offset() due to this mistake, but in such
case no impact is observed through code inspection given the correct data
types are used for the copy of the module when needed on move_module() when
the section type is not SHT_NOBITS (which indicates no the section
occupies no space on the file).

  Luis

>  kernel/module.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/kernel/module.c b/kernel/module.c
> index ad03a2357377..84a9141a5e15 100644
> --- a/kernel/module.c
> +++ b/kernel/module.c
> @@ -2942,7 +2942,11 @@ static int module_sig_check(struct load_info *info, int flags)
>  
>  static int validate_section_offset(struct load_info *info, Elf_Shdr *shdr)
>  {
> +#if defined(CONFIG_64BIT)
> +	unsigned long long secend;
> +#else
>  	unsigned long secend;
> +#endif
>  
>  	/*
>  	 * Check for both overflow and offset/size being
> -- 
> 2.30.2
> 
