Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 297F43414F2
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 06:39:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233886AbhCSFjO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 01:39:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:47322 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233864AbhCSFjH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 01:39:07 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id CF9C564EFD;
        Fri, 19 Mar 2021 05:39:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616132347;
        bh=XCEenlXj3Gp780uL4yHNIigcYxb+wQ/PQEYNF8mdSNo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JOcaJ9umC6aRqiwXsdE7spDYOqueGGeIxsU77mzcuFNuQYvbkNCqYAqDnz8uvKznr
         OXJKT19d4pguIDyUlHul0JjzRKUhQEkTXcPtbsxRn20bmVxTgBX/OeM7yx/XFAecxK
         8CSuUTCuqcsx4KRWE8cYHVO7mfPPjdDHsOsjKRJ31lR2JzxVKoohS/sQyFF+UzZH+l
         ejqaU4gLVya8CdavIfumi25fN0nywxb3l+07ERcReZ+WtIUcIV/T1OO3KbwEpciawZ
         fHUkrgO52CSqUC3U1/oX09HS2qh4LVCbJMsbb8FqFA98b/wqJgiQNGOrExb5OVsxD5
         Gr4Zdd+Vmnymw==
Date:   Fri, 19 Mar 2021 07:38:39 +0200
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     linux-kernel@vger.kernel.org,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Borislav Petkov <bp@alien8.de>, x86@kernel.org,
        linux-sgx@vger.kernel.org
Subject: Re: [PATCH] x86/sgx: fix uninitialized 'nid' variable
Message-ID: <YFQ439+k/2zkdSb5@kernel.org>
References: <202103190514.xH7IrKMe-lkp@intel.com>
 <20210318214933.29341-1-dave.hansen@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210318214933.29341-1-dave.hansen@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 18, 2021 at 02:49:33PM -0700, Dave Hansen wrote:
> The NUMA fallback in __sgx_alloc_epc_page() recently grew an
> additional 'nid' variable to prevent extra trips through the
> fallback loop in case where the thread is migrated around.
> 
> But, the new copy is not properly initialized.  Fix it.
> 
> This was found by some fancy clang that 0day runs.  My gcc
> does not detect it.
> 
> Fixes: 5b8719504e3a ("x86/sgx: Add a basic NUMA allocation scheme to sgx_alloc_epc_page()")
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: Jarkko Sakkinen <jarkko@kernel.org>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: x86@kernel.org
> Cc: linux-sgx@vger.kernel.org


Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

> ---
>  arch/x86/kernel/cpu/sgx/main.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kernel/cpu/sgx/main.c b/arch/x86/kernel/cpu/sgx/main.c
> index 2a0031e4a4dc..1b4d8a0e0915 100644
> --- a/arch/x86/kernel/cpu/sgx/main.c
> +++ b/arch/x86/kernel/cpu/sgx/main.c
> @@ -489,7 +489,7 @@ struct sgx_epc_page *__sgx_alloc_epc_page(void)
>  {
>  	struct sgx_epc_page *page;
>  	int nid_of_current = numa_node_id();
> -	int nid;
> +	int nid = nid_of_current;
>  
>  	if (node_isset(nid_of_current, sgx_numa_mask)) {
>  		page = __sgx_alloc_epc_page_from_node(nid_of_current);
> -- 
> 2.19.1
> 
> 

/Jarkko
