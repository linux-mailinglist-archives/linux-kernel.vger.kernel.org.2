Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47918306164
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 17:57:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234713AbhA0Q5T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 11:57:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:35038 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233825AbhA0QzO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 11:55:14 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4316864D99;
        Wed, 27 Jan 2021 16:54:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611766473;
        bh=D9YLBdJdTvUNtknF0Gfd+7SXSDNwVLy+RyPU5K0m1Go=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ISOyAq502Cz78bk8HmAYUdmTvgZNMOXRLMuYjduLnDxuguzbvGQGgf+sSEyb0N1cV
         fzSKKE2DFqadoUCHI2C9JCWBTjawgUo46jgvaqgBvHMnbf9GFvwUmWwweyWKSx5pj5
         IAmxe/7Cyc+8A08/7I3fpUb8KzAgOnklc0xKI3PqC/dy8ETInOVHBxudW4/hxulEW1
         BIy4r8AHvfPULqHRIAmDfbfL3k2wCulXcVQJZuE/9y1RVDwtg/n4zeIkNZe8JrrrpZ
         xxU0ezYStJ5XjQIF4moS2Jop2C3m+oYA0DTYotqmaGWsFh82pKxSCu8ki8hePxVHWo
         rQYbnNT8I6bBg==
Date:   Wed, 27 Jan 2021 16:54:24 +0000
From:   Will Deacon <will@kernel.org>
To:     Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Cc:     zohar@linux.ibm.com, bauerman@linux.ibm.com, robh@kernel.org,
        takahiro.akashi@linaro.org, gregkh@linuxfoundation.org,
        catalin.marinas@arm.com, mpe@ellerman.id.au, james.morse@arm.com,
        sashal@kernel.org, benh@kernel.crashing.org, paulus@samba.org,
        frowand.list@gmail.com, vincenzo.frascino@arm.com,
        mark.rutland@arm.com, dmitry.kasatkin@gmail.com, jmorris@namei.org,
        serge@hallyn.com, pasha.tatashin@soleen.com, allison@lohutok.net,
        masahiroy@kernel.org, bhsharma@redhat.com, mbrugger@suse.com,
        hsinyi@chromium.org, tao.li@vivo.com, christophe.leroy@c-s.fr,
        prsriva@linux.microsoft.com, balajib@linux.microsoft.com,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v15 10/10] arm64: Add IMA log information in kimage used
 for kexec
Message-ID: <20210127165424.GB358@willie-the-truck>
References: <20210115173017.30617-1-nramas@linux.microsoft.com>
 <20210115173017.30617-11-nramas@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210115173017.30617-11-nramas@linux.microsoft.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 15, 2021 at 09:30:17AM -0800, Lakshmi Ramasubramanian wrote:
> Address and size of the buffer containing the IMA measurement log need
> to be passed from the current kernel to the next kernel on kexec.
> 
> Add address and size fields to "struct kimage_arch" for ARM64 platform
> to hold the address and size of the IMA measurement log buffer.
> 
> Update CONFIG_KEXEC_FILE to select CONFIG_HAVE_IMA_KEXEC, if CONFIG_IMA
> is enabled, to indicate that the IMA measurement log information is
> present in the device tree for ARM64.
> 
> Co-developed-by: Prakhar Srivastava <prsriva@linux.microsoft.com>
> Signed-off-by: Prakhar Srivastava <prsriva@linux.microsoft.com>
> Signed-off-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
> Reviewed-by: Thiago Jung Bauermann <bauerman@linux.ibm.com>
> ---
>  arch/arm64/Kconfig             | 1 +
>  arch/arm64/include/asm/kexec.h | 5 +++++
>  2 files changed, 6 insertions(+)
> 
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index 1d466addb078..ea7f7fe3dccd 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -1094,6 +1094,7 @@ config KEXEC
>  config KEXEC_FILE
>  	bool "kexec file based system call"
>  	select KEXEC_CORE
> +	select HAVE_IMA_KEXEC if IMA
>  	help
>  	  This is new version of kexec system call. This system call is
>  	  file based and takes file descriptors as system call argument
> diff --git a/arch/arm64/include/asm/kexec.h b/arch/arm64/include/asm/kexec.h
> index d24b527e8c00..2bd19ccb6c43 100644
> --- a/arch/arm64/include/asm/kexec.h
> +++ b/arch/arm64/include/asm/kexec.h
> @@ -100,6 +100,11 @@ struct kimage_arch {
>  	void *elf_headers;
>  	unsigned long elf_headers_mem;
>  	unsigned long elf_headers_sz;
> +
> +#ifdef CONFIG_IMA_KEXEC
> +	phys_addr_t ima_buffer_addr;
> +	size_t ima_buffer_size;
> +#endif

Why do these need to be in the arch structure instead of 'struct kimage'?

Will
