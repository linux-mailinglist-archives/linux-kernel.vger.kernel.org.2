Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33E5031E489
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Feb 2021 04:31:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230121AbhBRDau (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Feb 2021 22:30:50 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:46122 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229889AbhBRDas (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Feb 2021 22:30:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1613618961;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=DoMp21k95Jp6kwK2dHRqLcGVCEPrre4aoDuTP2Iaam4=;
        b=OamrIEH+VEGnZLPwittGP4uYK8MJoEF9GcmCLk/j+ZYMXvqwe1jmWdVErjlLIrqiNMcwNJ
        n4fCfrZnXE780e0knojYcqd4nAE2B7Q/BlEDX50+NOCCNK3wkDXVK9q6TJ+yALg4NfgaS/
        9H/agavA54aqlus4t0rFUxF/AeU0PZQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-191-51wJf5h3NYaw5muEIpHCEg-1; Wed, 17 Feb 2021 22:29:15 -0500
X-MC-Unique: 51wJf5h3NYaw5muEIpHCEg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 78CB51005501;
        Thu, 18 Feb 2021 03:29:12 +0000 (UTC)
Received: from localhost (ovpn-12-112.pek2.redhat.com [10.72.12.112])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id D3E14100164C;
        Thu, 18 Feb 2021 03:29:08 +0000 (UTC)
Date:   Thu, 18 Feb 2021 11:29:06 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Chen Zhou <chenzhou10@huawei.com>
Cc:     mingo@redhat.com, tglx@linutronix.de, rppt@kernel.org,
        dyoung@redhat.com, catalin.marinas@arm.com, will@kernel.org,
        nsaenzjulienne@suse.de, corbet@lwn.net, John.P.donnelly@oracle.com,
        prabhakar.pkin@gmail.com, horms@verge.net.au, robh+dt@kernel.org,
        arnd@arndb.de, james.morse@arm.com, xiexiuqi@huawei.com,
        guohanjun@huawei.com, huawei.libin@huawei.com,
        wangkefeng.wang@huawei.com, linux-doc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v14 01/11] x86: kdump: replace the hard-coded alignment
 with macro CRASH_ALIGN
Message-ID: <20210218032607.GD2871@MiWiFi-R3L-srv>
References: <20210130071025.65258-1-chenzhou10@huawei.com>
 <20210130071025.65258-2-chenzhou10@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210130071025.65258-2-chenzhou10@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/30/21 at 03:10pm, Chen Zhou wrote:
> Move CRASH_ALIGN to header asm/kexec.h for later use. Besides, the
> alignment of crash kernel regions in x86 is 16M(CRASH_ALIGN), but
> function reserve_crashkernel() also used 1M alignment. So just
> replace hard-coded alignment 1M with macro CRASH_ALIGN.
> 
> Suggested-by: Dave Young <dyoung@redhat.com>
> Suggested-by: Baoquan He <bhe@redhat.com>
> Signed-off-by: Chen Zhou <chenzhou10@huawei.com>
> Tested-by: John Donnelly <John.p.donnelly@oracle.com>
> ---
>  arch/x86/include/asm/kexec.h | 3 +++
>  arch/x86/kernel/setup.c      | 5 +----
>  2 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/x86/include/asm/kexec.h b/arch/x86/include/asm/kexec.h
> index 6802c59e8252..be18dc7ae51f 100644
> --- a/arch/x86/include/asm/kexec.h
> +++ b/arch/x86/include/asm/kexec.h
> @@ -18,6 +18,9 @@
>  
>  # define KEXEC_CONTROL_CODE_MAX_SIZE	2048
>  
> +/* 16M alignment for crash kernel regions */
> +#define CRASH_ALIGN		SZ_16M
> +
>  #ifndef __ASSEMBLY__
>  
>  #include <linux/string.h>
> diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
> index 3412c4595efd..da769845597d 100644
> --- a/arch/x86/kernel/setup.c
> +++ b/arch/x86/kernel/setup.c
> @@ -390,9 +390,6 @@ static void __init memblock_x86_reserve_range_setup_data(void)
>  
>  #ifdef CONFIG_KEXEC_CORE
>  
> -/* 16M alignment for crash kernel regions */
> -#define CRASH_ALIGN		SZ_16M
> -
>  /*
>   * Keep the crash kernel below this limit.
>   *
> @@ -510,7 +507,7 @@ static void __init reserve_crashkernel(void)
>  	} else {
>  		unsigned long long start;
>  
> -		start = memblock_phys_alloc_range(crash_size, SZ_1M, crash_base,
> +		start = memblock_phys_alloc_range(crash_size, CRASH_ALIGN, crash_base,
>  						  crash_base + crash_size);

Looks good to me, thx.

Acked-by: Baoquan He <bhe@redhat.com>

>  		if (start != crash_base) {
>  			pr_info("crashkernel reservation failed - memory is in use.\n");
> -- 
> 2.20.1
> 

