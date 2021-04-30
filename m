Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FD6836FE31
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Apr 2021 17:58:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231185AbhD3P7B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Apr 2021 11:59:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230286AbhD3P67 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Apr 2021 11:58:59 -0400
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C07BC06174A
        for <linux-kernel@vger.kernel.org>; Fri, 30 Apr 2021 08:58:10 -0700 (PDT)
Received: by mail-qt1-x831.google.com with SMTP id n22so12382633qtk.9
        for <linux-kernel@vger.kernel.org>; Fri, 30 Apr 2021 08:58:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :organization:user-agent:mime-version:content-transfer-encoding;
        bh=txpnggSRy0s2gYU5zTHUPO9Qh59BlspuRXR7po+v5tA=;
        b=V77eyNJ+FDEzu3uhX7KcS/udKdeOhM1xkLgFWzkH6f4Wo7Df+TixEcBzMvGgEfTYhg
         QZpZ16d88ST5UjWy+pxNbIWBuVlydpDFZSEglY2ardttttEn7bucQC5nujukc1RUQd3M
         0XyrRB1Q+kIN0bIdzGcRTlTBxovKPBvcJCCAZhhDFm0aEWfM9i37mjYVO4WMraaPsi4U
         1/weS/HtRleHsvl4bhOfowXZGPdQVy+gfDKTrgMF4KNIj8S8K80ABBAdUPC96qtFg2VJ
         +ERoCFixHbtL/83N8vg8Qi7PZjF8HHzSKxIsf0gBxa2RuAMs6fPFNpkaYCIF27UTp9Ot
         UHDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:user-agent:mime-version
         :content-transfer-encoding;
        bh=txpnggSRy0s2gYU5zTHUPO9Qh59BlspuRXR7po+v5tA=;
        b=q2tbuHA24T/AcdxZV61l3tTnlMcgtBN0/WKYDGfKd8zrrXq7srJtTJcu5vbmQu4fyV
         WZ0D0X9EwuqQrVXV6+md87KXAJb1gf3y7uueHlIO48nJW/H2defn2XiWJ+gN3ToiPY2C
         GNWIoUfOO26Oa4db3wboQ244oxekXwUwzd8FAYhWvE5UxFcIzwtLDsJJlt5+61cvf9nr
         i5o36TC0J6YQwCFH8APxelvPutnBMjOpMPBy2IfAOenAEBsa5HYwG6DlKpPaIT8vGs6Q
         /UAlar+zcw3rqXjnPMj7v7VLcvVa3Jpoi7JFIT+//4paONdr4FNYCgnQCLyFUH9J2RyW
         GqWQ==
X-Gm-Message-State: AOAM533mhtF+hCK7cJ/ZTmZ1cikg3t8Y5Olhv+LdLF8bEGW599RarR13
        9pEbX8vjKth4iFK9dkBLvoE=
X-Google-Smtp-Source: ABdhPJzBB5lwBJT3CBidEwnCFEsZ0inMPFXsG1Jf5aBj3/N3JcS6JJQTg4HfIpLGEe2E0JSPF08Nsw==
X-Received: by 2002:ac8:6703:: with SMTP id e3mr4924342qtp.247.1619798289826;
        Fri, 30 Apr 2021 08:58:09 -0700 (PDT)
Received: from li-908e0a4c-2250-11b2-a85c-f027e903211b.ibm.com ([2804:14c:482:7b04::1001])
        by smtp.gmail.com with ESMTPSA id 75sm2517661qta.58.2021.04.30.08.58.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Apr 2021 08:58:09 -0700 (PDT)
Message-ID: <dafc859cbd2759d3560364302b492c0dd0df1658.camel@gmail.com>
Subject: Re: [PATCH v3 01/11] powerpc/pseries/iommu: Replace hard-coded page
 shift
From:   Leonardo Bras <leobras.c@gmail.com>
To:     Alexey Kardashevskiy <aik@ozlabs.ru>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Joel Stanley <joel@jms.id.au>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Nicolin Chen <nicoleotsuka@gmail.com>,
        Niklas Schnelle <schnelle@linux.ibm.com>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Date:   Fri, 30 Apr 2021 12:58:03 -0300
In-Reply-To: <7d0fec07-a663-f683-8d09-39e952cba418@ozlabs.ru>
References: <20210422070721.463912-1-leobras.c@gmail.com>
         <20210422070721.463912-2-leobras.c@gmail.com>
         <7d0fec07-a663-f683-8d09-39e952cba418@ozlabs.ru>
Organization: IBM
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Alexey!

On Fri, 2021-04-23 at 17:27 +1000, Alexey Kardashevskiy wrote:
> 
> On 22/04/2021 17:07, Leonardo Bras wrote:
> > Some functions assume IOMMU page size can only be 4K (pageshift == 12).
> > Update them to accept any page size passed, so we can use 64K pages.
> > 
> > In the process, some defines like TCE_SHIFT were made obsolete, and then
> > removed.
> > 
> > IODA3 Revision 3.0_prd1 (OpenPowerFoundation), Figures 3.4 and 3.5 show
> > a RPN of 52-bit, and considers a 12-bit pageshift, so there should be
> > no need of using TCE_RPN_MASK, which masks out any bit after 40 in rpn.
> > It's usage removed from tce_build_pSeries(), tce_build_pSeriesLP(), and
> > tce_buildmulti_pSeriesLP().
> 
> 
> After rereading the patch, I wonder why we had this TCE_RPN_MASK at all 
> but what is certain is that this has nothing to do with IODA3 as these 
> TCEs are guest phys addresses in pseries and IODA3 is bare metal. Except...
> 
> 
> > Most places had a tbl struct, so using tbl->it_page_shift was simple.
> > tce_free_pSeriesLP() was a special case, since callers not always have a
> > tbl struct, so adding a tceshift parameter seems the right thing to do.
> > 
> > Signed-off-by: Leonardo Bras <leobras.c@gmail.com>
> > Reviewed-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> > ---
> >   arch/powerpc/include/asm/tce.h         |  8 ------
> >   arch/powerpc/platforms/pseries/iommu.c | 39 +++++++++++++++-----------
> >   2 files changed, 23 insertions(+), 24 deletions(-)
> > 
> > diff --git a/arch/powerpc/include/asm/tce.h b/arch/powerpc/include/asm/tce.h
> > index db5fc2f2262d..0c34d2756d92 100644
> > --- a/arch/powerpc/include/asm/tce.h
> > +++ b/arch/powerpc/include/asm/tce.h
> > @@ -19,15 +19,7 @@
> >   #define TCE_VB			0
> >   #define TCE_PCI			1
> >   
> > 
> > -/* TCE page size is 4096 bytes (1 << 12) */
> > -
> > -#define TCE_SHIFT	12
> > -#define TCE_PAGE_SIZE	(1 << TCE_SHIFT)
> > -
> >   #define TCE_ENTRY_SIZE		8		/* each TCE is 64 bits */
> > -
> > -#define TCE_RPN_MASK		0xfffffffffful  /* 40-bit RPN (4K pages) */
> > -#define TCE_RPN_SHIFT		12
> >   #define TCE_VALID		0x800		/* TCE valid */
> >   #define TCE_ALLIO		0x400		/* TCE valid for all lpars */
> >   #define TCE_PCI_WRITE		0x2		/* write from PCI allowed */
> > diff --git a/arch/powerpc/platforms/pseries/iommu.c b/arch/powerpc/platforms/pseries/iommu.c
> > index 67c9953a6503..796ab356341c 100644
> > --- a/arch/powerpc/platforms/pseries/iommu.c
> > +++ b/arch/powerpc/platforms/pseries/iommu.c
> > @@ -107,6 +107,8 @@ static int tce_build_pSeries(struct iommu_table *tbl, long index,
> >   	u64 proto_tce;
> >   	__be64 *tcep;
> >   	u64 rpn;
> > +	const unsigned long tceshift = tbl->it_page_shift;
> > +	const unsigned long pagesize = IOMMU_PAGE_SIZE(tbl);
> 
> (nit: only used once)
> 
> >   
> > 
> >   	proto_tce = TCE_PCI_READ; // Read allowed
> >   
> > 
> > @@ -117,10 +119,10 @@ static int tce_build_pSeries(struct iommu_table *tbl, long index,
> 
> 
> ... this pseries which is not pseriesLP, i.e. no LPAR == bare metal 
> pseries such as ancient power5 or cellbe (I guess) and for those 
> TCE_RPN_MASK may actually make sense, keep it.
> 
> The rest of the patch looks good. Thanks,
> 
> 
> >   
> > 
> >   	while (npages--) {
> >   		/* can't move this out since we might cross MEMBLOCK boundary */
> > -		rpn = __pa(uaddr) >> TCE_SHIFT;
> > -		*tcep = cpu_to_be64(proto_tce | (rpn & TCE_RPN_MASK) << TCE_RPN_SHIFT);
> > +		rpn = __pa(uaddr) >> tceshift;
> > +		*tcep = cpu_to_be64(proto_tce | rpn << tceshift);
> >   
> > 
> > -		uaddr += TCE_PAGE_SIZE;
> > +		uaddr += pagesize;
> >   		tcep++;
> >   	}
> >   	return 0;
> > @@ -146,7 +148,7 @@ static unsigned long tce_get_pseries(struct iommu_table *tbl, long index)
> >   	return be64_to_cpu(*tcep);
> >   }
> >   
> > 
> > -static void tce_free_pSeriesLP(unsigned long liobn, long, long);
> > +static void tce_free_pSeriesLP(unsigned long liobn, long, long, long);
> >   static void tce_freemulti_pSeriesLP(struct iommu_table*, long, long);
> >   
> > 
> >   static int tce_build_pSeriesLP(unsigned long liobn, long tcenum, long tceshift,
> > @@ -166,12 +168,12 @@ static int tce_build_pSeriesLP(unsigned long liobn, long tcenum, long tceshift,
> >   		proto_tce |= TCE_PCI_WRITE;
> >   
> > 
> >   	while (npages--) {
> > -		tce = proto_tce | (rpn & TCE_RPN_MASK) << tceshift;
> > +		tce = proto_tce | rpn << tceshift;
> >   		rc = plpar_tce_put((u64)liobn, (u64)tcenum << tceshift, tce);
> >   
> > 
> >   		if (unlikely(rc == H_NOT_ENOUGH_RESOURCES)) {
> >   			ret = (int)rc;
> > -			tce_free_pSeriesLP(liobn, tcenum_start,
> > +			tce_free_pSeriesLP(liobn, tcenum_start, tceshift,
> >   			                   (npages_start - (npages + 1)));
> >   			break;
> >   		}
> > @@ -205,10 +207,11 @@ static int tce_buildmulti_pSeriesLP(struct iommu_table *tbl, long tcenum,
> >   	long tcenum_start = tcenum, npages_start = npages;
> >   	int ret = 0;
> >   	unsigned long flags;
> > +	const unsigned long tceshift = tbl->it_page_shift;
> >   
> > 
> >   	if ((npages == 1) || !firmware_has_feature(FW_FEATURE_PUT_TCE_IND)) {
> >   		return tce_build_pSeriesLP(tbl->it_index, tcenum,
> > -					   tbl->it_page_shift, npages, uaddr,
> > +					   tceshift, npages, uaddr,
> >   		                           direction, attrs);
> >   	}
> >   
> > 
> > @@ -225,13 +228,13 @@ static int tce_buildmulti_pSeriesLP(struct iommu_table *tbl, long tcenum,
> >   		if (!tcep) {
> >   			local_irq_restore(flags);
> >   			return tce_build_pSeriesLP(tbl->it_index, tcenum,
> > -					tbl->it_page_shift,
> > +					tceshift,
> >   					npages, uaddr, direction, attrs);
> >   		}
> >   		__this_cpu_write(tce_page, tcep);
> >   	}
> >   
> > 
> > -	rpn = __pa(uaddr) >> TCE_SHIFT;
> > +	rpn = __pa(uaddr) >> tceshift;
> >   	proto_tce = TCE_PCI_READ;
> >   	if (direction != DMA_TO_DEVICE)
> >   		proto_tce |= TCE_PCI_WRITE;
> > @@ -245,12 +248,12 @@ static int tce_buildmulti_pSeriesLP(struct iommu_table *tbl, long tcenum,
> >   		limit = min_t(long, npages, 4096/TCE_ENTRY_SIZE);
> >   
> > 
> >   		for (l = 0; l < limit; l++) {
> > -			tcep[l] = cpu_to_be64(proto_tce | (rpn & TCE_RPN_MASK) << TCE_RPN_SHIFT);
> > +			tcep[l] = cpu_to_be64(proto_tce | rpn << tceshift);
> >   			rpn++;
> >   		}
> >   
> > 
> >   		rc = plpar_tce_put_indirect((u64)tbl->it_index,
> > -					    (u64)tcenum << 12,
> > +					    (u64)tcenum << tceshift,
> >   					    (u64)__pa(tcep),
> >   					    limit);
> >   
> > 
> > @@ -277,12 +280,13 @@ static int tce_buildmulti_pSeriesLP(struct iommu_table *tbl, long tcenum,
> >   	return ret;
> >   }
> >   
> > 
> > -static void tce_free_pSeriesLP(unsigned long liobn, long tcenum, long npages)
> > +static void tce_free_pSeriesLP(unsigned long liobn, long tcenum, long tceshift,
> > +			       long npages)
> >   {
> >   	u64 rc;
> >   
> > 
> >   	while (npages--) {
> > -		rc = plpar_tce_put((u64)liobn, (u64)tcenum << 12, 0);
> > +		rc = plpar_tce_put((u64)liobn, (u64)tcenum << tceshift, 0);
> >   
> > 
> >   		if (rc && printk_ratelimit()) {
> >   			printk("tce_free_pSeriesLP: plpar_tce_put failed. rc=%lld\n", rc);
> > @@ -301,9 +305,11 @@ static void tce_freemulti_pSeriesLP(struct iommu_table *tbl, long tcenum, long n
> >   	u64 rc;
> >   
> > 
> >   	if (!firmware_has_feature(FW_FEATURE_STUFF_TCE))
> > -		return tce_free_pSeriesLP(tbl->it_index, tcenum, npages);
> > +		return tce_free_pSeriesLP(tbl->it_index, tcenum,
> > +					  tbl->it_page_shift, npages);
> >   
> > 
> > -	rc = plpar_tce_stuff((u64)tbl->it_index, (u64)tcenum << 12, 0, npages);
> > +	rc = plpar_tce_stuff((u64)tbl->it_index,
> > +			     (u64)tcenum << tbl->it_page_shift, 0, npages);
> >   
> > 
> >   	if (rc && printk_ratelimit()) {
> >   		printk("tce_freemulti_pSeriesLP: plpar_tce_stuff failed\n");
> > @@ -319,7 +325,8 @@ static unsigned long tce_get_pSeriesLP(struct iommu_table *tbl, long tcenum)
> >   	u64 rc;
> >   	unsigned long tce_ret;
> >   
> > 
> > -	rc = plpar_tce_get((u64)tbl->it_index, (u64)tcenum << 12, &tce_ret);
> > +	rc = plpar_tce_get((u64)tbl->it_index,
> > +			   (u64)tcenum << tbl->it_page_shift, &tce_ret);
> >   
> > 
> >   	if (rc && printk_ratelimit()) {
> >   		printk("tce_get_pSeriesLP: plpar_tce_get failed. rc=%lld\n", rc);
> > 
> 


