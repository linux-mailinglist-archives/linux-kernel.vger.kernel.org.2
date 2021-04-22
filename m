Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE93E367A31
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Apr 2021 08:51:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234913AbhDVGv0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Apr 2021 02:51:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229962AbhDVGvY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Apr 2021 02:51:24 -0400
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4870C06174A
        for <linux-kernel@vger.kernel.org>; Wed, 21 Apr 2021 23:50:49 -0700 (PDT)
Received: by mail-qk1-x736.google.com with SMTP id x11so45299237qkp.11
        for <linux-kernel@vger.kernel.org>; Wed, 21 Apr 2021 23:50:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :organization:user-agent:mime-version:content-transfer-encoding;
        bh=rtDdixl50dEInzVU4EDqe3HYgm+3xRTbWaZMtMKGnEc=;
        b=QXom36jWadvPIRGrs6Z2HWLbuunYIqK2QOPmciTq88qx2jsOebC974zCrnaAarbfbG
         j75FeLb+ks56iceff2Dh8PPqP6/FceRxw1neJq91ABd7OqjH9F1CWI3Tm9pdW/Igy9JF
         6duOLpbEWybYFPYgNfPPaUI6JtkGHsVRYXw8pmT4+bXPJf0hEgn3PQYNWwujW5F3YQgh
         VIIKnmQTYuOrQSwhEsr8t6WS16rBO5Nf7WXkefGe4H8frfwxKssrCMeA3h8KEhSiQrAK
         Ti8TO/VIr2ryDuJyOB7q8J/vGoefSS0gpwkGxNvPPfgM7nZdVYNNOr8YHZIOleYK3nHN
         Ojbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:user-agent:mime-version
         :content-transfer-encoding;
        bh=rtDdixl50dEInzVU4EDqe3HYgm+3xRTbWaZMtMKGnEc=;
        b=phy2z8EK7TXMfj3KrZqFxfacyXKQ3C1OpSSocTm9MIPeN4iDHMT8tIkQTXnjC9Z0jE
         tKe72HJJXDAl89JPpUFrbfYWyM0V1Ld+Jro5rabORM+SU7weJLgwVGLdqJSeTYTGdzRR
         29WIPiOSErvtcJwjyU9zcvKCMeXsE0R5fet4F/Swxhhm6iu4ZpVoBNH6BRMzOALwbJsO
         zjLd5avlH9OjgSp6KD7F2PJVFtNCcaDuVbxf/30AATp8fJiTmwZSXckgJTQGuz1jBVj1
         O4uzumfUbE+JZilN2mPzD4xlpHTJ/daj5/XTRFO3ilJgPRYfzbBr9WAOp5qzXinS/q0R
         2PPw==
X-Gm-Message-State: AOAM5327B6VnbzpRC7ZNoNQQZ1GryL5UvQ6Eqlud/vbg9M+KiUsBSOET
        sXElznufxff9mdyQq9AUbFiIWYrT14w=
X-Google-Smtp-Source: ABdhPJzAFcrT+Qs+l8dTqvqGJX/aDrzfuZm1NwaJkPi+txCgsMnq4XFAgQ5Q9uiBRDrcKkbFLxwUkw==
X-Received: by 2002:a05:620a:579:: with SMTP id p25mr2113901qkp.95.1619074249026;
        Wed, 21 Apr 2021 23:50:49 -0700 (PDT)
Received: from li-908e0a4c-2250-11b2-a85c-f027e903211b.ibm.com ([177.35.200.187])
        by smtp.gmail.com with ESMTPSA id l12sm1562269qtq.34.2021.04.21.23.50.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Apr 2021 23:50:48 -0700 (PDT)
Message-ID: <d0c4a6b8cb669d9321173c4d4ce0062b6f7698d5.camel@gmail.com>
Subject: Re: [PATCH 1/1] powerpc/kernel/iommu: Use largepool as a last
 resort when !largealloc
From:   Leonardo Bras <leobras.c@gmail.com>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Alexey Kardashevskiy <aik@ozlabs.ru>,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        Nicolin Chen <nicoleotsuka@gmail.com>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Date:   Thu, 22 Apr 2021 03:50:44 -0300
In-Reply-To: <20210318174414.684630-2-leobras.c@gmail.com>
References: <20210318174414.684630-1-leobras.c@gmail.com>
         <20210318174414.684630-2-leobras.c@gmail.com>
Organization: IBM
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

FYI: This patch was reviewed when it was part of another patchset:
http://patchwork.ozlabs.org/project/linuxppc-dev/patch/20200817234033.442511-4-leobras.c@gmail.com/


On Thu, 2021-03-18 at 14:44 -0300, Leonardo Bras wrote:
> As of today, doing iommu_range_alloc() only for !largealloc (npages <= 15)
> will only be able to use 3/4 of the available pages, given pages on
> largepool  not being available for !largealloc.
> 
> This could mean some drivers not being able to fully use all the available
> pages for the DMA window.
> 
> Add pages on largepool as a last resort for !largealloc, making all pages
> of the DMA window available.
> 
> Signed-off-by: Leonardo Bras <leobras.c@gmail.com>
> Reviewed-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> ---
>  arch/powerpc/kernel/iommu.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/arch/powerpc/kernel/iommu.c b/arch/powerpc/kernel/iommu.c
> index 3329ef045805..ae6ad8dca605 100644
> --- a/arch/powerpc/kernel/iommu.c
> +++ b/arch/powerpc/kernel/iommu.c
> @@ -255,6 +255,15 @@ static unsigned long iommu_range_alloc(struct device *dev,
>  			pass++;
>  			goto again;
>  
> 
> +		} else if (pass == tbl->nr_pools + 1) {
> +			/* Last resort: try largepool */
> +			spin_unlock(&pool->lock);
> +			pool = &tbl->large_pool;
> +			spin_lock(&pool->lock);
> +			pool->hint = pool->start;
> +			pass++;
> +			goto again;
> +
>  		} else {
>  			/* Give up */
>  			spin_unlock_irqrestore(&(pool->lock), flags);


