Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F57E31E490
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Feb 2021 04:36:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230020AbhBRDfe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Feb 2021 22:35:34 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:29628 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229885AbhBRDfc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Feb 2021 22:35:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1613619246;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=d9YnNO3MbpPkDoXl8YrBEEv+qOhDiCyZjDCW4nbXIvQ=;
        b=CFsd87GuAsC9yUTBC9Jmdu8+/tk2VV834Hh70YWJOyeDYaqTECMhwEdRCFId3W+ci8+5rG
        XtrlAomsaLoZBKgGcIPPuHeOFJZ1ZekkiSJIWo8OGcvOFHh9hcvakoMKh1nwtOxUzoioAi
        VN8UW6xEMRAhA+tWkwVGGMCbdnYpH4I=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-447-aOSWgkEAPimUDD-8gCggqA-1; Wed, 17 Feb 2021 22:34:02 -0500
X-MC-Unique: aOSWgkEAPimUDD-8gCggqA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8068710066F1;
        Thu, 18 Feb 2021 03:33:59 +0000 (UTC)
Received: from localhost (ovpn-12-112.pek2.redhat.com [10.72.12.112])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 84C09100164C;
        Thu, 18 Feb 2021 03:33:55 +0000 (UTC)
Date:   Thu, 18 Feb 2021 11:33:52 +0800
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
Subject: Re: [PATCH v14 02/11] x86: kdump: make the lower bound of crash
 kernel reservation consistent
Message-ID: <20210218033233.GF2871@MiWiFi-R3L-srv>
References: <20210130071025.65258-1-chenzhou10@huawei.com>
 <20210130071025.65258-3-chenzhou10@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210130071025.65258-3-chenzhou10@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/30/21 at 03:10pm, Chen Zhou wrote:
> The lower bounds of crash kernel reservation and crash kernel low
> reservation are different, use the consistent value CRASH_ALIGN.
> 
> Suggested-by: Dave Young <dyoung@redhat.com>
> Signed-off-by: Chen Zhou <chenzhou10@huawei.com>
> Tested-by: John Donnelly <John.p.donnelly@oracle.com>
> ---
>  arch/x86/kernel/setup.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
> index da769845597d..27470479e4a3 100644
> --- a/arch/x86/kernel/setup.c
> +++ b/arch/x86/kernel/setup.c
> @@ -439,7 +439,8 @@ static int __init reserve_crashkernel_low(void)
>  			return 0;
>  	}
>  
> -	low_base = memblock_phys_alloc_range(low_size, CRASH_ALIGN, 0, CRASH_ADDR_LOW_MAX);
> +	low_base = memblock_phys_alloc_range(low_size, CRASH_ALIGN, CRASH_ALIGN,
> +			CRASH_ADDR_LOW_MAX);

Acked-by: Baoquan He <bhe@redhat.com>

>  	if (!low_base) {
>  		pr_err("Cannot reserve %ldMB crashkernel low memory, please try smaller size.\n",
>  		       (unsigned long)(low_size >> 20));
> -- 
> 2.20.1
> 

