Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BDA431E786
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Feb 2021 09:40:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230446AbhBRIf3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Feb 2021 03:35:29 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:60957 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231250AbhBRHcp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Feb 2021 02:32:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1613633477;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=MnV8BsWsjwH7peotIX7G2PVOFrZQTedhCt87aYcboVo=;
        b=AGz3UzH033TI9vledAvJU5aJoghgGSa2nXcfcLe7swDi2cKjzfByRuJWpZfkViO3TLXlKq
        TM1bO2kHTquEsFkStjCBei8PIU91dblDnqxgFY7+sDF9WEyDZvyCFTFZyKjxQbgNJCMzEH
        YHJAWq1XrJEBVWrjfEKc16FmuomKa2U=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-4-36TG0Bi-NdSHuWcSGq9n-g-1; Thu, 18 Feb 2021 02:31:13 -0500
X-MC-Unique: 36TG0Bi-NdSHuWcSGq9n-g-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CC291814329;
        Thu, 18 Feb 2021 07:31:10 +0000 (UTC)
Received: from localhost (ovpn-12-112.pek2.redhat.com [10.72.12.112])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C05B35D9D2;
        Thu, 18 Feb 2021 07:31:06 +0000 (UTC)
Date:   Thu, 18 Feb 2021 15:31:04 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Chen Zhou <chenzhou10@huawei.com>, rppt@kernel.org
Cc:     mingo@redhat.com, tglx@linutronix.de, dyoung@redhat.com,
        catalin.marinas@arm.com, will@kernel.org, nsaenzjulienne@suse.de,
        corbet@lwn.net, John.P.donnelly@oracle.com,
        prabhakar.pkin@gmail.com, horms@verge.net.au, robh+dt@kernel.org,
        arnd@arndb.de, james.morse@arm.com, xiexiuqi@huawei.com,
        guohanjun@huawei.com, huawei.libin@huawei.com,
        wangkefeng.wang@huawei.com, linux-doc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kexec@lists.infradead.org
Subject: Re: [PATCH v14 09/11] x86, arm64: Add ARCH_WANT_RESERVE_CRASH_KERNEL
 config
Message-ID: <20210218073104.GI2871@MiWiFi-R3L-srv>
References: <20210130071025.65258-1-chenzhou10@huawei.com>
 <20210130071025.65258-10-chenzhou10@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210130071025.65258-10-chenzhou10@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/30/21 at 03:10pm, Chen Zhou wrote:
> We make the functions reserve_crashkernel[_low]() as generic for
> x86 and arm64. Since reserve_crashkernel[_low]() implementations
> are quite similar on other architectures as well, we can have more
> users of this later.
> 
> So have CONFIG_ARCH_WANT_RESERVE_CRASH_KERNEL in arch/Kconfig and
> select this by X86 and ARM64.
> 
> Suggested-by: Mike Rapoport <rppt@kernel.org>
> Suggested-by: Baoquan He <bhe@redhat.com>
> Signed-off-by: Chen Zhou <chenzhou10@huawei.com>
> ---
>  arch/Kconfig        | 3 +++
>  arch/arm64/Kconfig  | 1 +
>  arch/x86/Kconfig    | 2 ++
>  kernel/crash_core.c | 7 ++-----
>  4 files changed, 8 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/Kconfig b/arch/Kconfig
> index 24862d15f3a3..0ca1ff5bb157 100644
> --- a/arch/Kconfig
> +++ b/arch/Kconfig
> @@ -24,6 +24,9 @@ config KEXEC_ELF
>  config HAVE_IMA_KEXEC
>  	bool
>  
> +config ARCH_WANT_RESERVE_CRASH_KERNEL
> +	bool
> +
>  config SET_FS
>  	bool
>  
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index f39568b28ec1..09365c7ff469 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -82,6 +82,7 @@ config ARM64
>  	select ARCH_WANT_FRAME_POINTERS
>  	select ARCH_WANT_HUGE_PMD_SHARE if ARM64_4K_PAGES || (ARM64_16K_PAGES && !ARM64_VA_BITS_36)
>  	select ARCH_WANT_LD_ORPHAN_WARN
> +	select ARCH_WANT_RESERVE_CRASH_KERNEL if KEXEC_CORE
>  	select ARCH_HAS_UBSAN_SANITIZE_ALL
>  	select ARM_AMBA
>  	select ARM_ARCH_TIMER
> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index 21f851179ff0..e6926fcb4a40 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -12,6 +12,7 @@ config X86_32
>  	depends on !64BIT
>  	# Options that are inherently 32-bit kernel only:
>  	select ARCH_WANT_IPC_PARSE_VERSION
> +	select ARCH_WANT_RESERVE_CRASH_KERNEL if KEXEC_CORE
>  	select CLKSRC_I8253
>  	select CLONE_BACKWARDS
>  	select GENERIC_VDSO_32
> @@ -28,6 +29,7 @@ config X86_64
>  	select ARCH_HAS_GIGANTIC_PAGE
>  	select ARCH_SUPPORTS_INT128 if CC_HAS_INT128
>  	select ARCH_USE_CMPXCHG_LOCKREF
> +	select ARCH_WANT_RESERVE_CRASH_KERNEL if KEXEC_CORE
>  	select HAVE_ARCH_SOFT_DIRTY
>  	select MODULES_USE_ELF_RELA
>  	select NEED_DMA_MAP_STATE
> diff --git a/kernel/crash_core.c b/kernel/crash_core.c
> index 8479be270c0b..2c5783985db5 100644
> --- a/kernel/crash_core.c
> +++ b/kernel/crash_core.c
> @@ -320,9 +320,7 @@ int __init parse_crashkernel_low(char *cmdline,
>   * --------- Crashkernel reservation ------------------------------
>   */
>  
> -#ifdef CONFIG_KEXEC_CORE
> -
> -#if defined(CONFIG_X86) || defined(CONFIG_ARM64)
> +#ifdef CONFIG_ARCH_WANT_RESERVE_CRASH_KERNEL
>  static int __init reserve_crashkernel_low(void)
>  {
>  #ifdef CONFIG_64BIT
> @@ -450,8 +448,7 @@ void __init reserve_crashkernel(void)
>  	crashk_res.start = crash_base;
>  	crashk_res.end   = crash_base + crash_size - 1;
>  }
> -#endif
> -#endif /* CONFIG_KEXEC_CORE */
> +#endif /* CONFIG_ARCH_WANT_RESERVE_CRASH_KERNEL */

Why don't you move the dummy reserve_crashkernel() here too?

#ifdef CONFIG_ARCH_WANT_RESERVE_CRASH_KERNEL
#ifdef CONFIG_KEXEC_CORE
...
  '...the real crashkernel reservation code...'
...
#else                     
static void __init reserve_crashkernel(void)
{
}                                               
#endif
#endif /* CONFIG_ARCH_WANT_RESERVE_CRASH_KERNEL */

Like this, you don't need those two dummy reserve_crashkernel() in x86
and arm64?

Thanks
Baoquan

>  
>  Elf_Word *append_elf_note(Elf_Word *buf, char *name, unsigned int type,
>  			  void *data, size_t data_len)
> -- 
> 2.20.1
> 

