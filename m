Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0D00331E35
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Mar 2021 06:13:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229527AbhCIFL2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Mar 2021 00:11:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbhCIFLG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Mar 2021 00:11:06 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1234::107])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22958C06174A
        for <linux-kernel@vger.kernel.org>; Mon,  8 Mar 2021 21:11:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:Subject:Sender:
        Reply-To:Cc:Content-ID:Content-Description;
        bh=phSls5/z7pMWFoWfKnD4G0cKXJ2g4WG/8VLnlH/vZp4=; b=PXby+zrMmIjZdegwlDTz33sgPR
        igZOAAyXuOcPG4Bc3JguGNQGxiSLYNbEtm1wOvwY838krEJESHBoeXz4PnLpC0LofHMfZCLst3us2
        xx0AY/MKddouSQ5YO2cpteiPPLHhaqpilPTh8IQmVi/BkHXx0X1w9t2uILHdySjrwsJjidYt8jSwM
        NV3MfxUszzYqOY2oVCtAiax2hxLQ1AONGQWD0guPwy/y+HNzBjAD6uBFnG7Zry80Gj5pNyucdWkfG
        KEWT5NvmZrydD7j8CH2FY1hpnM9C/KgGV2O/NH/qe380BWPn7QiylTPAujx2v0zP07mH7ECwCwSdR
        qrKGbSWw==;
Received: from [2601:1c0:6280:3f0::3ba4]
        by merlin.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lJUe4-000cFt-Gy; Tue, 09 Mar 2021 05:11:01 +0000
Subject: Re: [PATCH] arch: x86: kernel: Adjust the words to suit sentences in
 the file vmlinux.lds.S
To:     Bhaskar Chowdhury <unixbhaskar@gmail.com>, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, x86@kernel.org, hpa@zytor.com,
        keescook@chromium.org, jpoimboe@redhat.com, jroedel@suse.de,
        hjl.tools@gmail.com, nivedita@alum.mit.edu, inglorion@google.com,
        linux-kernel@vger.kernel.org
References: <20210309034144.3283899-1-unixbhaskar@gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <5bed08e7-ce2b-438a-5ba1-37ee27078be8@infradead.org>
Date:   Mon, 8 Mar 2021 21:10:56 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210309034144.3283899-1-unixbhaskar@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/8/21 7:41 PM, Bhaskar Chowdhury wrote:
> 
> 
> s/percpu/per CPU/
> s/baremetal/bare metal/
> 
> Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>

Yeah, "bare metal" is a little better than "baremetal".

OTOH, "percpu" is a kernel construct's name. It doesn't have to
be proper English IMHO. (2 cents worth)

> ---
>  arch/x86/kernel/vmlinux.lds.S | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/kernel/vmlinux.lds.S b/arch/x86/kernel/vmlinux.lds.S
> index efd9e9ea17f2..592a44ad13b1 100644
> --- a/arch/x86/kernel/vmlinux.lds.S
> +++ b/arch/x86/kernel/vmlinux.lds.S
> @@ -217,7 +217,7 @@ SECTIONS
> 
>  #if defined(CONFIG_X86_64) && defined(CONFIG_SMP)
>  	/*
> -	 * percpu offsets are zero-based on SMP.  PERCPU_VADDR() changes the
> +	 * per CPU offsets are zero-based on SMP.  PERCPU_VADDR() changes the
>  	 * output PHDR, so the next output section - .init.text - should
>  	 * start another segment - init.
>  	 */
> @@ -262,7 +262,7 @@ SECTIONS
>  	/*
>  	 * start address and size of operations which during runtime
>  	 * can be patched with virtualization friendly instructions or
> -	 * baremetal native ones. Think page table operations.
> +	 * bare metal native ones. Think page table operations.
>  	 * Details in paravirt_types.h
>  	 */
>  	. = ALIGN(8);
> --


-- 
~Randy

