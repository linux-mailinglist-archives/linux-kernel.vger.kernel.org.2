Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22F7C336BAF
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Mar 2021 06:33:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229772AbhCKFcy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Mar 2021 00:32:54 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:29739 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229606AbhCKFcX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Mar 2021 00:32:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1615440742;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0MOfd/bEGZqrvXqQeTRkt3JSczTsL8Nc19791LwQRsk=;
        b=IuTFbWZHQ1p+72fM9PBZSXABLwPfijSjhe6fVP+Z+1kYuAGEuXg60xUZAY1wxgoZd2oElw
        FlKGJ8KR1v2YjUEPrPQ2rv8NA3bHJ3M8qZ7+qeVYMewkU6kskGU+AAB8973aAfO3OPl+CH
        ybMnXfauvNvbNZJkORfFrStbVqUcnVY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-235-hRZQVlZKNmipWqIHdqs62A-1; Thu, 11 Mar 2021 00:32:18 -0500
X-MC-Unique: hRZQVlZKNmipWqIHdqs62A-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D444957;
        Thu, 11 Mar 2021 05:32:16 +0000 (UTC)
Received: from localhost (ovpn-12-68.pek2.redhat.com [10.72.12.68])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 3307F60C13;
        Thu, 11 Mar 2021 05:32:15 +0000 (UTC)
Date:   Thu, 11 Mar 2021 13:32:13 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Jia-Ju Bai <baijiaju1990@gmail.com>
Cc:     ebiederm@xmission.com, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org, akpm@linux-foundation.org
Subject: Re: [PATCH] kernel: kexec_file: fix error return code of
 kexec_calculate_store_digests()
Message-ID: <20210311053213.GH2962@MiWiFi-R3L-srv>
References: <20210309083904.24321-1-baijiaju1990@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210309083904.24321-1-baijiaju1990@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/09/21 at 12:39am, Jia-Ju Bai wrote:
> When vzalloc() returns NULL to sha_regions, no error return code of
> kexec_calculate_store_digests() is assigned.
> To fix this bug, ret is assigned with -ENOMEM in this case.
> 
> Fixes: a43cac0d9dc2 ("kexec: split kexec_file syscall code to kexec_file.c")
> Reported-by: TOTE Robot <oslab@tsinghua.edu.cn>
> Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
> ---
>  kernel/kexec_file.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
> index 5c3447cf7ad5..33400ff051a8 100644
> --- a/kernel/kexec_file.c
> +++ b/kernel/kexec_file.c
> @@ -740,8 +740,10 @@ static int kexec_calculate_store_digests(struct kimage *image)
>  
>  	sha_region_sz = KEXEC_SEGMENT_MAX * sizeof(struct kexec_sha_region);
>  	sha_regions = vzalloc(sha_region_sz);
> -	if (!sha_regions)
> +	if (!sha_regions) {
> +		ret = -ENOMEM;
>  		goto out_free_desc;

A good catch. Even though the chance of failure is very small, it does
cause issue if happened.

Acked-by: Baoquan He <bhe@redhat.com>

Thanks
Baoquan

> +	}
>  
>  	desc->tfm   = tfm;
>  
> -- 
> 2.17.1
> 
> 
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec
> 

