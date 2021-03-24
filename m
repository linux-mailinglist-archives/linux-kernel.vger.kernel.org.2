Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DEAF13474FC
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 10:48:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232442AbhCXJrh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 05:47:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232500AbhCXJr3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 05:47:29 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F06BC061763;
        Wed, 24 Mar 2021 02:47:28 -0700 (PDT)
Received: from zn.tnic (p200300ec2f0a0800e1aaf92fe048fc85.dip0.t-ipconnect.de [IPv6:2003:ec:2f0a:800:e1aa:f92f:e048:fc85])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id D07BD1EC03A0;
        Wed, 24 Mar 2021 10:47:21 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1616579241;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=srWGc0OqLsvw93jos01M8hInTD8o7TJm1knv6fe7CgA=;
        b=p5BIIlGcz9jFUFUYmrFNzdIRY6HUPV25NcTLUUKsPZmJEf7Op1ZmzfXijK8nXdPMg+wmMu
        bWV4p7zUoaReiDred/SEgjBlQO4RS7qUfJS+l2pn2N3nwsNRu62iF35ji/EWZMGtEHVtBd
        OrqJqNeStTQWLXQn4jXVbI8usLxBWnA=
Date:   Wed, 24 Mar 2021 10:47:20 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     ira.weiny@intel.com
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        Sean Christopherson <seanjc@google.com>,
        Jethro Beekman <jethro@fortanix.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        linux-sgx@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5] x86: Remove unnecessary kmap() from
 sgx_ioc_enclave_init()
Message-ID: <20210324094720.GA5010@zn.tnic>
References: <20210306002058.303796-1-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210306002058.303796-1-ira.weiny@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 05, 2021 at 04:20:58PM -0800, ira.weiny@intel.com wrote:

> Subject: Re: [PATCH v5] x86: Remove unnecessary kmap() from  sgx_ioc_enclave_init()

The tip tree preferred format for patch subject prefixes is
'subsys/component:', e.g. 'x86/apic:', 'x86/mm/fault:', 'sched/fair:',
'genirq/core:'. Please do not use file names or complete file paths as
prefix. 'git log path/to/file' should give you a reasonable hint in most
cases.

> From: Ira Weiny <ira.weiny@intel.com>
> 
> kmap is inefficient and we are trying to reduce the usage in the kernel.

Please use passive voice in your commit message: no "we" or "I", etc,
and describe your changes in imperative mood.

Also, pls read section "2) Describe your changes" in
Documentation/process/submitting-patches.rst for more details.

Bottom line is: personal pronouns are ambiguous in text, especially with
so many parties/companies/etc developing the kernel so let's avoid them
please.

> @@ -615,11 +614,14 @@ static long sgx_ioc_enclave_init(struct sgx_encl *encl, void __user *arg)
>  	if (copy_from_user(&init_arg, arg, sizeof(init_arg)))
>  		return -EFAULT;
>  
> -	initp_page = alloc_page(GFP_KERNEL);
> -	if (!initp_page)
> +	/*
> +	 * sigstruct must be on a page boundry and token on a 512 byte boundry
> +	 * kmalloc() gives us this alignment when allocating PAGE_SIZE bytes

Please integrate scripts/checkpatch.pl into your patch creation
workflow. Some of the warnings/errors *actually* make sense.

WARNING: 'boundry' may be misspelled - perhaps 'boundary'?
#90: FILE: arch/x86/kernel/cpu/sgx/ioctl.c:618:
+        * sigstruct must be on a page boundry and token on a 512 byte boundry
                                       ^^^^^^^

WARNING: 'boundry' may be misspelled - perhaps 'boundary'?
#90: FILE: arch/x86/kernel/cpu/sgx/ioctl.c:618:
+        * sigstruct must be on a page boundry and token on a 512 byte boundry
                                                                       ^^^^^^^

Also, do you see how other comments in this file are proper sentences?
Please formulate yours this way too.

The change itself looks ok.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
