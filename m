Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BFFE368DE8
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Apr 2021 09:27:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241020AbhDWH1y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Apr 2021 03:27:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229935AbhDWH1x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Apr 2021 03:27:53 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F778C061574
        for <linux-kernel@vger.kernel.org>; Fri, 23 Apr 2021 00:27:17 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id f6-20020a17090a6546b029015088cf4a1eso780067pjs.2
        for <linux-kernel@vger.kernel.org>; Fri, 23 Apr 2021 00:27:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ozlabs-ru.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=bf8XMS3q7qHp98r6O1wqMq+9yKwqUsu4CYn3uOvQmYc=;
        b=ydCpWvopw9Lk7qZ2HRluIsTaAGrAe8HR4OMWDL1CKuxdI9y4l9tejX/UKpXlodSBog
         WxckIsMNYplypAGADIqxuLtT9JoO0qlvaLJruE0GDlPAvcjCAlSSYIl5IbX9gerPcC8Z
         YTiyKViV+F8yugnAphFFyb5x5l0FIRpQTW3FyfxhuGPiZz+iROdHTHcthg7gVI05TDvT
         eke5lHnvPwvoGRK6lIMhdnDHwe4r6nrUAqke1tiF6USnlhtOu3QnytMPuWsMhGG/R2HC
         pKr8yf+gIwwqBg+/k0ZBekkjlqIzp34nMgn8FF/gZnBojBZCmpqYpYDbdydl3cGrJr92
         KRrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=bf8XMS3q7qHp98r6O1wqMq+9yKwqUsu4CYn3uOvQmYc=;
        b=E7h+ofjiBDFB8keqD2gZriah2pmPqBcWfD80kafAaHtBv7BKfg8KfCt9+zVTueZnUs
         m9YDFFuaC9uKCeieuI81IisnD/gyE3V4YUN1/Ii+mcm6mXCwo0nGPcDi2ZV96g/Xe5mO
         KyymWbsTq3Yn73UrSAaLhFje1n83Ajw3GWr04M5VGhP+8iGNr4KW/k+k9zyuMPYhPgza
         b25gWLiO3q3Fj0LNVkTUlS3wNT8tcNkus2fvPpVGVu0m3adwiLM2qN4YLZWazA1t0EFa
         Bc9E26k9ZIJf5KY4aUMzBekchMOD8fAmr/BQ7kkX9KuViiazsSAtBWPMx4bsa1sh2b39
         pd2w==
X-Gm-Message-State: AOAM531iYDohFo8WNiuUm03maMoJMxUrsqaPB2Y+7aC9BqeYeI0daLLM
        bstMeTJpMnfs24kDHdacesg5Yw==
X-Google-Smtp-Source: ABdhPJyOUYCnGYT9dzhCEEikOKwsNfRLyB2bXudUyTdEw0+CdqKyaHjnhi+DUHaW8++t+uOrDA+aUg==
X-Received: by 2002:a17:90b:2314:: with SMTP id mt20mr4269535pjb.99.1619162836833;
        Fri, 23 Apr 2021 00:27:16 -0700 (PDT)
Received: from localhost (ppp121-45-194-51.cbr-trn-nor-bras38.tpg.internode.on.net. [121.45.194.51])
        by smtp.gmail.com with UTF8SMTPSA id h6sm3965789pfb.157.2021.04.23.00.27.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Apr 2021 00:27:16 -0700 (PDT)
Message-ID: <7d0fec07-a663-f683-8d09-39e952cba418@ozlabs.ru>
Date:   Fri, 23 Apr 2021 17:27:06 +1000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:88.0) Gecko/20100101
 Thunderbird/88.0
Subject: Re: [PATCH v3 01/11] powerpc/pseries/iommu: Replace hard-coded page
 shift
Content-Language: en-US
To:     Leonardo Bras <leobras.c@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Joel Stanley <joel@jms.id.au>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Nicolin Chen <nicoleotsuka@gmail.com>,
        Niklas Schnelle <schnelle@linux.ibm.com>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <20210422070721.463912-1-leobras.c@gmail.com>
 <20210422070721.463912-2-leobras.c@gmail.com>
From:   Alexey Kardashevskiy <aik@ozlabs.ru>
In-Reply-To: <20210422070721.463912-2-leobras.c@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 22/04/2021 17:07, Leonardo Bras wrote:
> Some functions assume IOMMU page size can only be 4K (pageshift == 12).
> Update them to accept any page size passed, so we can use 64K pages.
> 
> In the process, some defines like TCE_SHIFT were made obsolete, and then
> removed.
> 
> IODA3 Revision 3.0_prd1 (OpenPowerFoundation), Figures 3.4 and 3.5 show
> a RPN of 52-bit, and considers a 12-bit pageshift, so there should be
> no need of using TCE_RPN_MASK, which masks out any bit after 40 in rpn.
> It's usage removed from tce_build_pSeries(), tce_build_pSeriesLP(), and
> tce_buildmulti_pSeriesLP().


After rereading the patch, I wonder why we had this TCE_RPN_MASK at all 
but what is certain is that this has nothing to do with IODA3 as these 
TCEs are guest phys addresses in pseries and IODA3 is bare metal. Except...


> Most places had a tbl struct, so using tbl->it_page_shift was simple.
> tce_free_pSeriesLP() was a special case, since callers not always have a
> tbl struct, so adding a tceshift parameter seems the right thing to do.
> 
> Signed-off-by: Leonardo Bras <leobras.c@gmail.com>
> Reviewed-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> ---
>   arch/powerpc/include/asm/tce.h         |  8 ------
>   arch/powerpc/platforms/pseries/iommu.c | 39 +++++++++++++++-----------
>   2 files changed, 23 insertions(+), 24 deletions(-)
> 
> diff --git a/arch/powerpc/include/asm/tce.h b/arch/powerpc/include/asm/tce.h
> index db5fc2f2262d..0c34d2756d92 100644
> --- a/arch/powerpc/include/asm/tce.h
> +++ b/arch/powerpc/include/asm/tce.h
> @@ -19,15 +19,7 @@
>   #define TCE_VB			0
>   #define TCE_PCI			1
>   
> -/* TCE page size is 4096 bytes (1 << 12) */
> -
> -#define TCE_SHIFT	12
> -#define TCE_PAGE_SIZE	(1 << TCE_SHIFT)
> -
>   #define TCE_ENTRY_SIZE		8		/* each TCE is 64 bits */
> -
> -#define TCE_RPN_MASK		0xfffffffffful  /* 40-bit RPN (4K pages) */
> -#define TCE_RPN_SHIFT		12
>   #define TCE_VALID		0x800		/* TCE valid */
>   #define TCE_ALLIO		0x400		/* TCE valid for all lpars */
>   #define TCE_PCI_WRITE		0x2		/* write from PCI allowed */
> diff --git a/arch/powerpc/platforms/pseries/iommu.c b/arch/powerpc/platforms/pseries/iommu.c
> index 67c9953a6503..796ab356341c 100644
> --- a/arch/powerpc/platforms/pseries/iommu.c
> +++ b/arch/powerpc/platforms/pseries/iommu.c
> @@ -107,6 +107,8 @@ static int tce_build_pSeries(struct iommu_table *tbl, long index,
>   	u64 proto_tce;
>   	__be64 *tcep;
>   	u64 rpn;
> +	const unsigned long tceshift = tbl->it_page_shift;
> +	const unsigned long pagesize = IOMMU_PAGE_SIZE(tbl);

(nit: only used once)

>   
>   	proto_tce = TCE_PCI_READ; // Read allowed
>   
> @@ -117,10 +119,10 @@ static int tce_build_pSeries(struct iommu_table *tbl, long index,


... this pseries which is not pseriesLP, i.e. no LPAR == bare metal 
pseries such as ancient power5 or cellbe (I guess) and for those 
TCE_RPN_MASK may actually make sense, keep it.

The rest of the patch looks good. Thanks,


>   
>   	while (npages--) {
>   		/* can't move this out since we might cross MEMBLOCK boundary */
> -		rpn = __pa(uaddr) >> TCE_SHIFT;
> -		*tcep = cpu_to_be64(proto_tce | (rpn & TCE_RPN_MASK) << TCE_RPN_SHIFT);
> +		rpn = __pa(uaddr) >> tceshift;
> +		*tcep = cpu_to_be64(proto_tce | rpn << tceshift);
>   
> -		uaddr += TCE_PAGE_SIZE;
> +		uaddr += pagesize;
>   		tcep++;
>   	}
>   	return 0;
> @@ -146,7 +148,7 @@ static unsigned long tce_get_pseries(struct iommu_table *tbl, long index)
>   	return be64_to_cpu(*tcep);
>   }
>   
> -static void tce_free_pSeriesLP(unsigned long liobn, long, long);
> +static void tce_free_pSeriesLP(unsigned long liobn, long, long, long);
>   static void tce_freemulti_pSeriesLP(struct iommu_table*, long, long);
>   
>   static int tce_build_pSeriesLP(unsigned long liobn, long tcenum, long tceshift,
> @@ -166,12 +168,12 @@ static int tce_build_pSeriesLP(unsigned long liobn, long tcenum, long tceshift,
>   		proto_tce |= TCE_PCI_WRITE;
>   
>   	while (npages--) {
> -		tce = proto_tce | (rpn & TCE_RPN_MASK) << tceshift;
> +		tce = proto_tce | rpn << tceshift;
>   		rc = plpar_tce_put((u64)liobn, (u64)tcenum << tceshift, tce);
>   
>   		if (unlikely(rc == H_NOT_ENOUGH_RESOURCES)) {
>   			ret = (int)rc;
> -			tce_free_pSeriesLP(liobn, tcenum_start,
> +			tce_free_pSeriesLP(liobn, tcenum_start, tceshift,
>   			                   (npages_start - (npages + 1)));
>   			break;
>   		}
> @@ -205,10 +207,11 @@ static int tce_buildmulti_pSeriesLP(struct iommu_table *tbl, long tcenum,
>   	long tcenum_start = tcenum, npages_start = npages;
>   	int ret = 0;
>   	unsigned long flags;
> +	const unsigned long tceshift = tbl->it_page_shift;
>   
>   	if ((npages == 1) || !firmware_has_feature(FW_FEATURE_PUT_TCE_IND)) {
>   		return tce_build_pSeriesLP(tbl->it_index, tcenum,
> -					   tbl->it_page_shift, npages, uaddr,
> +					   tceshift, npages, uaddr,
>   		                           direction, attrs);
>   	}
>   
> @@ -225,13 +228,13 @@ static int tce_buildmulti_pSeriesLP(struct iommu_table *tbl, long tcenum,
>   		if (!tcep) {
>   			local_irq_restore(flags);
>   			return tce_build_pSeriesLP(tbl->it_index, tcenum,
> -					tbl->it_page_shift,
> +					tceshift,
>   					npages, uaddr, direction, attrs);
>   		}
>   		__this_cpu_write(tce_page, tcep);
>   	}
>   
> -	rpn = __pa(uaddr) >> TCE_SHIFT;
> +	rpn = __pa(uaddr) >> tceshift;
>   	proto_tce = TCE_PCI_READ;
>   	if (direction != DMA_TO_DEVICE)
>   		proto_tce |= TCE_PCI_WRITE;
> @@ -245,12 +248,12 @@ static int tce_buildmulti_pSeriesLP(struct iommu_table *tbl, long tcenum,
>   		limit = min_t(long, npages, 4096/TCE_ENTRY_SIZE);
>   
>   		for (l = 0; l < limit; l++) {
> -			tcep[l] = cpu_to_be64(proto_tce | (rpn & TCE_RPN_MASK) << TCE_RPN_SHIFT);
> +			tcep[l] = cpu_to_be64(proto_tce | rpn << tceshift);
>   			rpn++;
>   		}
>   
>   		rc = plpar_tce_put_indirect((u64)tbl->it_index,
> -					    (u64)tcenum << 12,
> +					    (u64)tcenum << tceshift,
>   					    (u64)__pa(tcep),
>   					    limit);
>   
> @@ -277,12 +280,13 @@ static int tce_buildmulti_pSeriesLP(struct iommu_table *tbl, long tcenum,
>   	return ret;
>   }
>   
> -static void tce_free_pSeriesLP(unsigned long liobn, long tcenum, long npages)
> +static void tce_free_pSeriesLP(unsigned long liobn, long tcenum, long tceshift,
> +			       long npages)
>   {
>   	u64 rc;
>   
>   	while (npages--) {
> -		rc = plpar_tce_put((u64)liobn, (u64)tcenum << 12, 0);
> +		rc = plpar_tce_put((u64)liobn, (u64)tcenum << tceshift, 0);
>   
>   		if (rc && printk_ratelimit()) {
>   			printk("tce_free_pSeriesLP: plpar_tce_put failed. rc=%lld\n", rc);
> @@ -301,9 +305,11 @@ static void tce_freemulti_pSeriesLP(struct iommu_table *tbl, long tcenum, long n
>   	u64 rc;
>   
>   	if (!firmware_has_feature(FW_FEATURE_STUFF_TCE))
> -		return tce_free_pSeriesLP(tbl->it_index, tcenum, npages);
> +		return tce_free_pSeriesLP(tbl->it_index, tcenum,
> +					  tbl->it_page_shift, npages);
>   
> -	rc = plpar_tce_stuff((u64)tbl->it_index, (u64)tcenum << 12, 0, npages);
> +	rc = plpar_tce_stuff((u64)tbl->it_index,
> +			     (u64)tcenum << tbl->it_page_shift, 0, npages);
>   
>   	if (rc && printk_ratelimit()) {
>   		printk("tce_freemulti_pSeriesLP: plpar_tce_stuff failed\n");
> @@ -319,7 +325,8 @@ static unsigned long tce_get_pSeriesLP(struct iommu_table *tbl, long tcenum)
>   	u64 rc;
>   	unsigned long tce_ret;
>   
> -	rc = plpar_tce_get((u64)tbl->it_index, (u64)tcenum << 12, &tce_ret);
> +	rc = plpar_tce_get((u64)tbl->it_index,
> +			   (u64)tcenum << tbl->it_page_shift, &tce_ret);
>   
>   	if (rc && printk_ratelimit()) {
>   		printk("tce_get_pSeriesLP: plpar_tce_get failed. rc=%lld\n", rc);
> 

-- 
Alexey
