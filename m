Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64A7D367A40
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Apr 2021 08:53:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230232AbhDVGxy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Apr 2021 02:53:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231148AbhDVGxw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Apr 2021 02:53:52 -0400
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 726E7C06174A
        for <linux-kernel@vger.kernel.org>; Wed, 21 Apr 2021 23:53:17 -0700 (PDT)
Received: by mail-qt1-x82a.google.com with SMTP id a18so9318868qtj.10
        for <linux-kernel@vger.kernel.org>; Wed, 21 Apr 2021 23:53:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :organization:user-agent:mime-version:content-transfer-encoding;
        bh=iAm0246eJyOaq+VpTTXw3YrglwQ5iHG6TngAXGPaQRw=;
        b=ekJ/GDgCQ9NOq6O1EftMPEmUOhEniGvpya5e8SR/jPXE4pX8ffj0wdPdXZLh01njBa
         5XU/c3Q1akLwfalBI/qlBGDXoAcS2ORsCDH7bjHm9JVWTzlEPrD/SEMvqoF4doKvliTI
         jf/0t33qLbsc1cnKZUu0t9s4kLhtz//kDPu8Syi2N5/q1+hkzD7CIZno6oIUccb78LdK
         PEBpEz7jKknpO7H1rk37NZ8UD6oe8OeGfS03+d35bWJIM+cORsoc0v8lzmSqt9HcSw1p
         F98iYt29KP018HS+tFvrSjv1TawFoFTeYxyhJ9oelRS4dBqCN+PP0m1eop5mtpTuXAv1
         DFMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:user-agent:mime-version
         :content-transfer-encoding;
        bh=iAm0246eJyOaq+VpTTXw3YrglwQ5iHG6TngAXGPaQRw=;
        b=ZNTPrdtPqFjzNJblMh/y2BiHlMy3qZj3YfpxNhRC4UiNaE2hCqQcoQdMeGvQQEcpen
         +8GgHKisDwrgBF6wJzwzdcQNuAdvyZ9OC/xIZWkzpkbhtB01mMQAE92Bm0ies8DrE7gv
         ur/6/koRZIlmPN4Sn0R7723bQZ7+G3IMLAHfSvjfJo78X8bEcBvw1Rg9PxawttiR2HlQ
         enxelKRgECTO+w96qqBYNMXoi5F7bEI+ng4m5dAMKAtDBAbeHskUNQaB7bRb1A/ViujW
         s57k7wPW0tE4kIvgnHtS001j44g1ho0MC0JMjwHeaI99VYozQobtnoPrOPmf/xaFd0/r
         nYsg==
X-Gm-Message-State: AOAM530cuH40bEUx9OozKyUL9rwVR706kXZ3+bUfQDJE78XxK0nruXcP
        ZvMk2BtVo5SPudSE0xiWN0/rN1se354=
X-Google-Smtp-Source: ABdhPJz6IVp3/kP3Nos6ocKWVEplVJWfejg+HRZjVHCd8geVXas43GYZo3VQvrSby2xDEgzF1C+HFA==
X-Received: by 2002:ac8:7089:: with SMTP id y9mr1695704qto.207.1619074396738;
        Wed, 21 Apr 2021 23:53:16 -0700 (PDT)
Received: from li-908e0a4c-2250-11b2-a85c-f027e903211b.ibm.com ([177.35.200.187])
        by smtp.gmail.com with ESMTPSA id d4sm1761854qtp.23.2021.04.21.23.53.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Apr 2021 23:53:16 -0700 (PDT)
Message-ID: <2f985cdb2a62c52ce2a26118f1966c00176cc4b9.camel@gmail.com>
Subject: Re: [PATCH 1/1] powerpc/kernel/iommu: Align size for
 IOMMU_PAGE_SIZE() to save TCEs
From:   Leonardo Bras <leobras.c@gmail.com>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Alexey Kardashevskiy <aik@ozlabs.ru>,
        Nicolin Chen <nicoleotsuka@gmail.com>,
        Niklas Schnelle <schnelle@linux.ibm.com>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Date:   Thu, 22 Apr 2021 03:53:13 -0300
In-Reply-To: <20210318174414.684630-1-leobras.c@gmail.com>
References: <20210318174414.684630-1-leobras.c@gmail.com>
Organization: IBM
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

This patch was also reviewed when it was part of another patchset:
http://patchwork.ozlabs.org/project/linuxppc-dev/patch/20200911170738.82818-4-leobras.c@gmail.com/

On Thu, 2021-03-18 at 14:44 -0300, Leonardo Bras wrote:
> Currently both iommu_alloc_coherent() and iommu_free_coherent() align the
> desired allocation size to PAGE_SIZE, and gets system pages and IOMMU
> mappings (TCEs) for that value.
> 
> When IOMMU_PAGE_SIZE < PAGE_SIZE, this behavior may cause unnecessary
> TCEs to be created for mapping the whole system page.
> 
> Example:
> - PAGE_SIZE = 64k, IOMMU_PAGE_SIZE() = 4k
> - iommu_alloc_coherent() is called for 128 bytes
> - 1 system page (64k) is allocated
> - 16 IOMMU pages (16 x 4k) are allocated (16 TCEs used)
> 
> It would be enough to use a single TCE for this, so 15 TCEs are
> wasted in the process.
> 
> Update iommu_*_coherent() to make sure the size alignment happens only
> for IOMMU_PAGE_SIZE() before calling iommu_alloc() and iommu_free().
> 
> Also, on iommu_range_alloc(), replace ALIGN(n, 1 << tbl->it_page_shift)
> with IOMMU_PAGE_ALIGN(n, tbl), which is easier to read and does the
> same.
> 
> Signed-off-by: Leonardo Bras <leobras.c@gmail.com>
> Reviewed-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> ---
>  arch/powerpc/kernel/iommu.c | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/powerpc/kernel/iommu.c b/arch/powerpc/kernel/iommu.c
> index 5b69a6a72a0e..3329ef045805 100644
> --- a/arch/powerpc/kernel/iommu.c
> +++ b/arch/powerpc/kernel/iommu.c
> @@ -851,6 +851,7 @@ void *iommu_alloc_coherent(struct device *dev, struct iommu_table *tbl,
>  	unsigned int order;
>  	unsigned int nio_pages, io_order;
>  	struct page *page;
> +	size_t size_io = size;
>  
> 
>  	size = PAGE_ALIGN(size);
>  	order = get_order(size);
> @@ -877,8 +878,9 @@ void *iommu_alloc_coherent(struct device *dev, struct iommu_table *tbl,
>  	memset(ret, 0, size);
>  
> 
>  	/* Set up tces to cover the allocated range */
> -	nio_pages = size >> tbl->it_page_shift;
> -	io_order = get_iommu_order(size, tbl);
> +	size_io = IOMMU_PAGE_ALIGN(size_io, tbl);
> +	nio_pages = size_io >> tbl->it_page_shift;
> +	io_order = get_iommu_order(size_io, tbl);
>  	mapping = iommu_alloc(dev, tbl, ret, nio_pages, DMA_BIDIRECTIONAL,
>  			      mask >> tbl->it_page_shift, io_order, 0);
>  	if (mapping == DMA_MAPPING_ERROR) {
> @@ -893,10 +895,9 @@ void iommu_free_coherent(struct iommu_table *tbl, size_t size,
>  			 void *vaddr, dma_addr_t dma_handle)
>  {
>  	if (tbl) {
> -		unsigned int nio_pages;
> +		size_t size_io = IOMMU_PAGE_ALIGN(size, tbl);
> +		unsigned int nio_pages = size_io >> tbl->it_page_shift;
>  
> 
> -		size = PAGE_ALIGN(size);
> -		nio_pages = size >> tbl->it_page_shift;
>  		iommu_free(tbl, dma_handle, nio_pages);
>  		size = PAGE_ALIGN(size);
>  		free_pages((unsigned long)vaddr, get_order(size));


