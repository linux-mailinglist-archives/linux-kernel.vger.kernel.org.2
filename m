Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBA2A31E51A
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Feb 2021 05:16:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230132AbhBREP6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Feb 2021 23:15:58 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:44047 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229806AbhBREPt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Feb 2021 23:15:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1613621662;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=emJvmHO6K5DoKcle3XfGbvke6XPq47tbyoxFu4GbpOg=;
        b=V1fJCLTJID2aqb8rKZWsbM8F0gf4muNo4JH3DlgXN92NN5ZJ6+9bhv3Bmhcm7lO6RI1vQY
        sY842zaD8wLlyBOnkVLqcpnTI9Nnzhzox8b7RHKdJPSMI6uBy7Jhk7fq4c5Wxxhuep0Rif
        5uYbI1BSp2p6Yj2QK9FJHrU99jsHwSA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-401-wauykghLNGe1NIrrLr8z8Q-1; Wed, 17 Feb 2021 23:14:18 -0500
X-MC-Unique: wauykghLNGe1NIrrLr8z8Q-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 334E11020C22;
        Thu, 18 Feb 2021 04:14:15 +0000 (UTC)
Received: from localhost (ovpn-12-112.pek2.redhat.com [10.72.12.112])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C7E7A10016F0;
        Thu, 18 Feb 2021 04:14:10 +0000 (UTC)
Date:   Thu, 18 Feb 2021 12:14:07 +0800
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
Subject: Re: [PATCH v14 04/11] x86: kdump: move xen_pv_domain() check and
 insert_resource() to setup_arch()
Message-ID: <20210218041259.GG2871@MiWiFi-R3L-srv>
References: <20210130071025.65258-1-chenzhou10@huawei.com>
 <20210130071025.65258-5-chenzhou10@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210130071025.65258-5-chenzhou10@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/30/21 at 03:10pm, Chen Zhou wrote:
> We will make the functions reserve_crashkernel() as generic, the
> xen_pv_domain() check in reserve_crashkernel() is relevant only to
> x86, the same as insert_resource() in reserve_crashkernel[_low]().
> So move xen_pv_domain() check and insert_resource() to setup_arch()
> to keep them in x86.
> 
> Suggested-by: Mike Rapoport <rppt@kernel.org>
> Signed-off-by: Chen Zhou <chenzhou10@huawei.com>
> Tested-by: John Donnelly <John.p.donnelly@oracle.com>
> ---
>  arch/x86/kernel/setup.c | 19 +++++++++++--------
>  1 file changed, 11 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
> index 086a04235be4..5d676efc32f6 100644
> --- a/arch/x86/kernel/setup.c
> +++ b/arch/x86/kernel/setup.c
> @@ -454,7 +454,6 @@ static int __init reserve_crashkernel_low(void)
>  
>  	crashk_low_res.start = low_base;
>  	crashk_low_res.end   = low_base + low_size - 1;
> -	insert_resource(&iomem_resource, &crashk_low_res);
>  #endif
>  	return 0;
>  }
> @@ -478,11 +477,6 @@ static void __init reserve_crashkernel(void)
>  		high = true;
>  	}
>  
> -	if (xen_pv_domain()) {
> -		pr_info("Ignoring crashkernel for a Xen PV domain\n");
> -		return;
> -	}
> -
>  	/* 0 means: find the address automatically */
>  	if (!crash_base) {
>  		/*
> @@ -529,7 +523,6 @@ static void __init reserve_crashkernel(void)
>  
>  	crashk_res.start = crash_base;
>  	crashk_res.end   = crash_base + crash_size - 1;
> -	insert_resource(&iomem_resource, &crashk_res);
>  }
>  #else
>  static void __init reserve_crashkernel(void)
> @@ -1151,7 +1144,17 @@ void __init setup_arch(char **cmdline_p)
>  	 * Reserve memory for crash kernel after SRAT is parsed so that it
>  	 * won't consume hotpluggable memory.
>  	 */
> -	reserve_crashkernel();
> +	if (xen_pv_domain())
> +		pr_info("Ignoring crashkernel for a Xen PV domain\n");
> +	else {
> +		reserve_crashkernel();
> +#ifdef CONFIG_KEXEC_CORE
> +		if (crashk_res.end > crashk_res.start)
> +			insert_resource(&iomem_resource, &crashk_res);
> +		if (crashk_low_res.end > crashk_low_res.start)
> +			insert_resource(&iomem_resource, &crashk_low_res);
> +#endif

Acked-by: Baoquan He <bhe@redhat.com>

> +	}
>  
>  	memblock_find_dma_reserve();
>  
> -- 
> 2.20.1
> 

