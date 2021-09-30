Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 890F441DA3C
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Sep 2021 14:50:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351113AbhI3Mvw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Sep 2021 08:51:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:43032 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1350997AbhI3Mvu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Sep 2021 08:51:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1633006207;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GL+i3XbXI56oQyuB6S2B9CHfMMTgl5hMmQ3V5SEVJeY=;
        b=ilfEIlzPQ4D+mcARmgQzKEoNenVcvnu5wYiSoch63z9b4MjNsKzpECrPJJBPHPpcRtA2XN
        3F3Df2w02nyC6loyRpNBiU+WLuOhG1NJgPPX7PUsBeBVdn/qfhjp/TJ6e2DuPU/IaZw65p
        iDhDcluXc1/OSJkWD+5JUvxDCzQWLSw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-280-dDb09p5ON36r0bQfFcmMxQ-1; Thu, 30 Sep 2021 08:49:17 -0400
X-MC-Unique: dDb09p5ON36r0bQfFcmMxQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E6E5469723;
        Thu, 30 Sep 2021 12:49:15 +0000 (UTC)
Received: from dhcp-128-65.nay.redhat.com (ovpn-12-72.pek2.redhat.com [10.72.12.72])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 73C415F4E1;
        Thu, 30 Sep 2021 12:49:06 +0000 (UTC)
Date:   Thu, 30 Sep 2021 20:49:02 +0800
From:   Dave Young <dyoung@redhat.com>
To:     Coiby Xu <coiby.xu@gmail.com>
Cc:     kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
        Coiby Xu <coxu@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Eric Biederman <ebiederm@xmission.com>,
        "open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)" 
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] kexec, KEYS: make the code in bzImage64_verify_sig
 public
Message-ID: <YVWyPu3pDvnEfATe@dhcp-128-65.nay.redhat.com>
References: <20210927005004.36367-1-coiby.xu@gmail.com>
 <20210927005004.36367-2-coiby.xu@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210927005004.36367-2-coiby.xu@gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Coiby,
On 09/27/21 at 08:50am, Coiby Xu wrote:
> From: Coiby Xu <coxu@redhat.com>
> 
> The code in bzImage64_verify_sig could make use of system keyrings including
> .buitin_trusted_keys, .secondary_trusted_keys and .platform keyring to verify
> signed kernel image as PE file. Move it to a public function.
> 
> Signed-off-by: Coiby Xu <coiby.xu@gmail.com>
> ---
>  arch/x86/kernel/kexec-bzimage64.c | 13 +------------
>  include/linux/kexec.h             |  3 +++
>  kernel/kexec_file.c               | 15 +++++++++++++++
>  3 files changed, 19 insertions(+), 12 deletions(-)
> 
> diff --git a/arch/x86/kernel/kexec-bzimage64.c b/arch/x86/kernel/kexec-bzimage64.c
> index 170d0fd68b1f..4136dd3be5a9 100644
> --- a/arch/x86/kernel/kexec-bzimage64.c
> +++ b/arch/x86/kernel/kexec-bzimage64.c
> @@ -17,7 +17,6 @@
>  #include <linux/kernel.h>
>  #include <linux/mm.h>
>  #include <linux/efi.h>
> -#include <linux/verification.h>
>  
>  #include <asm/bootparam.h>
>  #include <asm/setup.h>
> @@ -531,17 +530,7 @@ static int bzImage64_cleanup(void *loader_data)
>  #ifdef CONFIG_KEXEC_BZIMAGE_VERIFY_SIG
>  static int bzImage64_verify_sig(const char *kernel, unsigned long kernel_len)
>  {
> -	int ret;
> -
> -	ret = verify_pefile_signature(kernel, kernel_len,
> -				      VERIFY_USE_SECONDARY_KEYRING,
> -				      VERIFYING_KEXEC_PE_SIGNATURE);
> -	if (ret == -ENOKEY && IS_ENABLED(CONFIG_INTEGRITY_PLATFORM_KEYRING)) {
> -		ret = verify_pefile_signature(kernel, kernel_len,
> -					      VERIFY_USE_PLATFORM_KEYRING,
> -					      VERIFYING_KEXEC_PE_SIGNATURE);
> -	}
> -	return ret;
> +	return arch_kexec_kernel_verify_pe_sig(kernel, kernel_len);
>  }
>  #endif
>  
> diff --git a/include/linux/kexec.h b/include/linux/kexec.h
> index 0c994ae37729..d45f32336dbe 100644
> --- a/include/linux/kexec.h
> +++ b/include/linux/kexec.h
> @@ -19,6 +19,7 @@
>  #include <asm/io.h>
>  
>  #include <uapi/linux/kexec.h>
> +#include <linux/verification.h>
>  
>  #ifdef CONFIG_KEXEC_CORE
>  #include <linux/list.h>
> @@ -199,6 +200,8 @@ int arch_kimage_file_post_load_cleanup(struct kimage *image);
>  #ifdef CONFIG_KEXEC_SIG
>  int arch_kexec_kernel_verify_sig(struct kimage *image, void *buf,
>  				 unsigned long buf_len);
> +int arch_kexec_kernel_verify_pe_sig(const char *kernel,
> +				    unsigned long kernel_len);
>  #endif
>  int arch_kexec_locate_mem_hole(struct kexec_buf *kbuf);
>  
> diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
> index 33400ff051a8..85ed6984ad8f 100644
> --- a/kernel/kexec_file.c
> +++ b/kernel/kexec_file.c
> @@ -106,6 +106,21 @@ int __weak arch_kexec_kernel_verify_sig(struct kimage *image, void *buf,
>  {
>  	return kexec_image_verify_sig_default(image, buf, buf_len);
>  }
> +
> +int arch_kexec_kernel_verify_pe_sig(const char *kernel, unsigned long kernel_len)
> +{
> +	int ret;
> +
> +	ret = verify_pefile_signature(kernel, kernel_len,
> +				      VERIFY_USE_SECONDARY_KEYRING,
> +				      VERIFYING_KEXEC_PE_SIGNATURE);
> +	if (ret == -ENOKEY && IS_ENABLED(CONFIG_INTEGRITY_PLATFORM_KEYRING)) {
> +		ret = verify_pefile_signature(kernel, kernel_len,
> +					      VERIFY_USE_PLATFORM_KEYRING,
> +					      VERIFYING_KEXEC_PE_SIGNATURE);
> +	}
> +	return ret;
> +}

Since the function is moved as generic code, the kconfig option
CONFIG_KEXEC_BZIMAGE_VERIFY_SIG can be removed.

Instead a CONFIG_KEXEC_PEFILE_VERIFY_SIG can be added so that it does
not need to be compiled for only platform which support UEFI pefile
signature verification.  And the related arch kexec_file kconfig can
just select it.

Coiby, can you try above?

>  #endif
>  
>  /*
> -- 
> 2.33.0
> 
> 
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec
> 
> 

Thanks
Dave

