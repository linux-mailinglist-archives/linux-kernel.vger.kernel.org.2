Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4210936B6AA
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Apr 2021 18:22:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234508AbhDZQXF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Apr 2021 12:23:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234124AbhDZQXD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Apr 2021 12:23:03 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18A4EC061574
        for <linux-kernel@vger.kernel.org>; Mon, 26 Apr 2021 09:22:21 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id o16so15601117plg.5
        for <linux-kernel@vger.kernel.org>; Mon, 26 Apr 2021 09:22:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=rko65LO4DxbTh3O7hfaOBltkKiQCpxvYvt+sfJxHHjs=;
        b=UzyYH0cPly19SZDaNZvrxY7wraZvDynCqhy+Su85Dy9SP5Nq30jyjWGAc6QV7ZfiRT
         1SMpToxvkib53nOxpS/TmjVbG7M/jdiSfVDEKFNKgh2zFty6m9LTYSfVG/h3kqkVkyF+
         KlGAdn2djjDFY0TH+AxeVcsvUqa8m6rb/PVoLet15vbG83r9uDXWlypBS/4w8GrW1eEu
         +T/QpUBKumK1e/LVvS6OFmJuFhdxPEQFPE6Oqo42Rq+iv6l0khcPfZlODT/VILl+uo9e
         rQvtIIom2t1Hcit6GS+6rSInYhIBdnfRVZemB+8cyy9B92xAsanANtBiV6PmR5mhxnYy
         17Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=rko65LO4DxbTh3O7hfaOBltkKiQCpxvYvt+sfJxHHjs=;
        b=IrGV73cB5Uk+iXeQuj499kZHiNaAorie/ktwxX37M5r39ivxHlYnnZdEVwsVN7m2Fd
         haV7tVmkzTtM84vYYtVx145NKgddkRtsTCNQQ1GDZdDAXCzPlFNM4SXfda3FnJ54bU/v
         lDqi+cCrIktkmDHFzb/9xIhls5lPDW2i7YAnOUUPLN/I5CUvouhTiZ+EwOMZFnmyivjR
         KIWz9mrBewGo+fqRF4LqbzKjYwzOfBOANuNJdAzw4Bgt8jhwy6tI8zCWfWd8w8XPnOFG
         pxEtxB3EQTZLtUOm6kEuINdDfYn1f1ZKsT2c0IZCUF0sXRldbYrXeV255b3A6gNleEKw
         rmYw==
X-Gm-Message-State: AOAM531/jyM5KtMIQIkq+hMDzhreQUYhPmqdETr/VxbzTf5HKFj1ZdES
        3Zw8pIOUYx3g9cXi54EA7LbhFw==
X-Google-Smtp-Source: ABdhPJzozzzjzWNK0ZL2n3cHXGo1FjqGar2a2nR53Tgj0jeuPdApbhB5plxcjTZtRM0aF34/rPIfbg==
X-Received: by 2002:a17:902:109:b029:ec:9f64:c53d with SMTP id 9-20020a1709020109b02900ec9f64c53dmr19027688plb.83.1619454140491;
        Mon, 26 Apr 2021 09:22:20 -0700 (PDT)
Received: from google.com (240.111.247.35.bc.googleusercontent.com. [35.247.111.240])
        by smtp.gmail.com with ESMTPSA id f18sm195252pfe.49.2021.04.26.09.22.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Apr 2021 09:22:19 -0700 (PDT)
Date:   Mon, 26 Apr 2021 16:22:15 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Borislav Petkov <bp@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PULL] x86/sgx for v5.13
Message-ID: <YIbot8szBpbsSGuw@google.com>
References: <YIaWh9VSEMQnn5E2@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YIaWh9VSEMQnn5E2@zn.tnic>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 26, 2021, Borislav Petkov wrote:
> Hi Linus,
> 
> please pull the SGX pile of updates for v5.13.
> 
> Thx.
> 
> ---
> 
> The following changes since commit 1e28eed17697bcf343c6743f0028cc3b5dd88bf0:
> 
>   Linux 5.12-rc3 (2021-03-14 14:41:02 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_sgx_for_v5.13
> 
> for you to fetch changes up to 523caed9efbb049339706b124185c9358c1b6477:
> 
>   x86/sgx: Mark sgx_vepc_vm_ops static (2021-04-12 19:48:32 +0200)
> 
> ----------------------------------------------------------------
> Add the guest side of SGX support in KVM guests. Work by Sean

This is all host side code, there are no guest specific changes required.  Maybe
"Add the non-KVM kernel bits for SGX support in KVM guests."

Thanks!

> Christopherson, Kai Huang and Jarkko Sakkinen. Along with the usual
> fixes, cleanups and improvements.
> 
> ----------------------------------------------------------------
> Dave Hansen (1):
>       selftests/sgx: Improve error detection and messages
> 
> Ira Weiny (1):
>       x86/sgx: Remove unnecessary kmap() from sgx_ioc_enclave_init()
> 
> Jarkko Sakkinen (3):
>       x86/sgx: Replace section->init_laundry_list with sgx_dirty_page_list
>       x86/sgx: Add a basic NUMA allocation scheme to sgx_alloc_epc_page()
>       x86/sgx: Do not update sgx_nr_free_pages in sgx_setup_epc_section()
> 
> Kai Huang (4):
>       x86/cpufeatures: Make SGX_LC feature bit depend on SGX bit
>       x86/sgx: Wipe out EREMOVE from sgx_free_epc_page()
>       x86/sgx: Initialize virtual EPC driver even when SGX driver is disabled
>       x86/sgx: Add helper to update SGX_LEPUBKEYHASHn MSRs
> 
> Sean Christopherson (10):
>       x86/cpufeatures: Add SGX1 and SGX2 sub-features
>       x86/sgx: Add SGX_CHILD_PRESENT hardware error code
>       x86/sgx: Introduce virtual EPC for use by KVM guests
>       x86/cpu/intel: Allow SGX virtualization without Launch Control support
>       x86/sgx: Expose SGX architectural definitions to the kernel
>       x86/sgx: Move ENCLS leaf definitions to sgx.h
>       x86/sgx: Add SGX2 ENCLS leaf definitions (EAUG, EMODPR and EMODT)
>       x86/sgx: Add encls_faulted() helper
>       x86/sgx: Add helpers to expose ECREATE and EINIT to KVM
>       x86/sgx: Move provisioning device creation out of SGX driver
> 
> Tianjia Zhang (1):
>       selftests/sgx: Use getauxval() to simplify test code
> 
> Wei Yongjun (1):
>       x86/sgx: Mark sgx_vepc_vm_ops static
