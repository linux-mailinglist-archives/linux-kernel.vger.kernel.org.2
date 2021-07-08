Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB0D13C1890
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jul 2021 19:41:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229779AbhGHRnl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jul 2021 13:43:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229842AbhGHRni (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jul 2021 13:43:38 -0400
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F521C061574
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jul 2021 10:40:56 -0700 (PDT)
Received: by mail-qv1-xf2e.google.com with SMTP id x6so3211494qvx.4
        for <linux-kernel@vger.kernel.org>; Thu, 08 Jul 2021 10:40:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vt-edu.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:organization:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dsqqn0oFRpfJNU7RF3gQ8YyxCGX98EU87z5gYU3nnko=;
        b=uRPOcH8XTnoVmo2ZM0zQb1D7/6L00G4uAgS8zXF69aCXYFc11OGJDj4NpcEh1hgXPd
         9JDPEC/4R16BVyTNBs89pfTyaL+X9DII4cYjqc8leCIw4UGfAtUIzSJyL5GTqKlUTgPZ
         nASMpF1jSY4odaGUchHDNjF5srppXURwZFRa/+tnQh8bRcq7Kfg1miOvBzUaNHOBGCKu
         J2/7EWgs/lvZOC/KbPNXA9rMrv4WEjawfMAHGyH54VKgHqhM4ahJfw8bKawxxQIJGYmH
         AN1YQFepuh4sYeheADKDWbgYUX5mhDbKLy8z2i8j9FLIdGMBsTR7//iRJpagEIa3fr1b
         fBOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:organization
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=dsqqn0oFRpfJNU7RF3gQ8YyxCGX98EU87z5gYU3nnko=;
        b=pBd2t0A05+QlR0qSYM8zg2Vwqrancli2ABVMFGQiNrctt1lizZfK8VW2cW2+oNkigh
         5JSNHUEmS1w34NPzqiLXx7s2HfYGPKpb+cQs6BJcfG0hYNerH7M21mZ2DtbzbxK3YNTL
         BCsz0KGz/Y63fB4zYjA8XpRyCYIGkUB44yAFd/IBsJA+i5IaeDl1pwSKTOLm4JnTBm8B
         f0HL+Qy6vz49Yn6FjahMHOAQLQdiBA4bVXKAYjfBcgihBZMSpfDHw8qYgSnmz03OaMLI
         oOdUE0/hYQosVLCFtSYGPmxXjnUuy3Plsd1STF4+QdI3ZwOwFcZNqhjqonvmeBf6YB8h
         BvIg==
X-Gm-Message-State: AOAM530mFi7Kd2YwK1EeoLzNBNB8UlAUBYCkkA7tG12ajAKdtfLL2+ha
        j4gIT3HXbJAczgUWOWWjpCMeyg==
X-Google-Smtp-Source: ABdhPJwxj47p4sXhRUU94Co+SSSzIihoQUGeQwN0Li3Kbl2UzsWwbj7R9OqMBGckbFgrwT9DjQ624A==
X-Received: by 2002:a0c:f048:: with SMTP id b8mr30755087qvl.56.1625766055798;
        Thu, 08 Jul 2021 10:40:55 -0700 (PDT)
Received: from iron-maiden.localnet ([50.225.136.98])
        by smtp.gmail.com with ESMTPSA id y10sm1203907qta.35.2021.07.08.10.40.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jul 2021 10:40:55 -0700 (PDT)
From:   Carlos Bilbao <bilbao@vt.edu>
To:     James.Bottomley@hansenpartnership.com,
        Joe Perches <joe@perches.com>
Cc:     deller@gmx.de, linux-parisc@vger.kernel.org,
        linux-kernel@vger.kernel.org, andrew@lunn.ch
Subject: [PATCH net-next v2] drivers: parisc: Remove unnecessary #if blocks
Date:   Thu, 08 Jul 2021 13:40:54 -0400
Message-ID: <2661892.BEx9A2HvPv@iron-maiden>
Organization: Virginia Tech
In-Reply-To: <39a7b7c455c6c23f0bfe7403b4957d2c92196d46.camel@perches.com>
References: <1793924.CQOukoFCf9@iron-maiden> <39a7b7c455c6c23f0bfe7403b4957d2c92196d46.camel@perches.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove undefined #ifdefs and #if 0 from these two files.

Signed-off-by: Carlos Bilbao <bilbao@vt.edu>
---
 drivers/parisc/iosapic.c   | 21 -------------
 drivers/parisc/sba_iommu.c | 63 --------------------------------------
 2 files changed, 84 deletions(-)

diff --git a/drivers/parisc/iosapic.c b/drivers/parisc/iosapic.c
index 8a3b0c3a1e92..5ca80beb12cf 100644
--- a/drivers/parisc/iosapic.c
+++ b/drivers/parisc/iosapic.c
@@ -624,27 +624,6 @@ static void iosapic_unmask_irq(struct irq_data *d)
 	iosapic_set_irt_data(vi, &d0, &d1);
 	iosapic_wr_irt_entry(vi, d0, d1);
 
-#ifdef DEBUG_IOSAPIC_IRT
-{
-	u32 *t = (u32 *) ((ulong) vi->eoi_addr & ~0xffUL);
-	printk("iosapic_enable_irq(): regs %p", vi->eoi_addr);
-	for ( ; t < vi->eoi_addr; t++)
-		printk(" %x", readl(t));
-	printk("\n");
-}
-
-printk("iosapic_enable_irq(): sel ");
-{
-	struct iosapic_info *isp = vi->iosapic;
-
-	for (d0=0x10; d0<0x1e; d0++) {
-		d1 = iosapic_read(isp->addr, d0);
-		printk(" %x", d1);
-	}
-}
-printk("\n");
-#endif
-
 	/*
 	 * Issuing I/O SAPIC an EOI causes an interrupt IFF IRQ line is
 	 * asserted.  IRQ generally should not be asserted when a driver
diff --git a/drivers/parisc/sba_iommu.c b/drivers/parisc/sba_iommu.c
index dce4cdf786cd..98bbf40410eb 100644
--- a/drivers/parisc/sba_iommu.c
+++ b/drivers/parisc/sba_iommu.c
@@ -623,13 +623,6 @@ sba_mark_invalid(struct ioc *ioc, dma_addr_t iova, size_t byte_cnt)
 
 	if (byte_cnt > IOVP_SIZE)
 	{
-#if 0
-		unsigned long entries_per_cacheline = ioc_needs_fdc ?
-				L1_CACHE_ALIGN(((unsigned long) pdir_ptr))
-					- (unsigned long) pdir_ptr;
-				: 262144;
-#endif
-
 		/* set "size" field for PCOM */
 		iovp |= get_order(byte_cnt) + PAGE_SHIFT;
 
@@ -637,11 +630,6 @@ sba_mark_invalid(struct ioc *ioc, dma_addr_t iova, size_t byte_cnt)
 			/* clear I/O Pdir entry "valid" bit first */
 			((u8 *) pdir_ptr)[7] = 0;
 			asm_io_fdc(pdir_ptr);
-			if (ioc_needs_fdc) {
-#if 0
-				entries_per_cacheline = L1_CACHE_SHIFT - 3;
-#endif
-			}
 			pdir_ptr++;
 			byte_cnt -= IOVP_SIZE;
 		} while (byte_cnt > IOVP_SIZE);
@@ -1081,36 +1069,6 @@ static const struct dma_map_ops sba_ops = {
 	.free_pages =		dma_common_free_pages,
 };
 
-
-/**************************************************************************
-**
-**   SBA PAT PDC support
-**
-**   o call pdc_pat_cell_module()
-**   o store ranges in PCI "resource" structures
-**
-**************************************************************************/
-
-static void
-sba_get_pat_resources(struct sba_device *sba_dev)
-{
-#if 0
-/*
-** TODO/REVISIT/FIXME: support for directed ranges requires calls to
-**      PAT PDC to program the SBA/LBA directed range registers...this
-**      burden may fall on the LBA code since it directly supports the
-**      PCI subsystem. It's not clear yet. - ggg
-*/
-PAT_MOD(mod)->mod_info.mod_pages   = PAT_GET_MOD_PAGES(temp);
-	FIXME : ???
-PAT_MOD(mod)->mod_info.dvi         = PAT_GET_DVI(temp);
-	Tells where the dvi bits are located in the address.
-PAT_MOD(mod)->mod_info.ioc         = PAT_GET_IOC(temp);
-	FIXME : ???
-#endif
-}
-
-
 /**************************************************************
 *
 *   Initialization and claim
@@ -1548,26 +1506,6 @@ static void sba_hw_init(struct sba_device *sba_dev)
 
 	}
 
-
-#if 0
-printk("sba_hw_init(): mem_boot 0x%x 0x%x 0x%x 0x%x\n", PAGE0->mem_boot.hpa,
-	PAGE0->mem_boot.spa, PAGE0->mem_boot.pad, PAGE0->mem_boot.cl_class);
-
-	/*
-	** Need to deal with DMA from LAN.
-	**	Maybe use page zero boot device as a handle to talk
-	**	to PDC about which device to shutdown.
-	**
-	** Netbooting, j6k v5.0 firmware says:
-	** 	mem_boot hpa 0xf4008000 sba 0x0 pad 0x0 cl_class 0x1002
-	** ARGH! invalid class.
-	*/
-	if ((PAGE0->mem_boot.cl_class != CL_RANDOM)
-		&& (PAGE0->mem_boot.cl_class != CL_SEQU)) {
-			pdc_io_reset();
-	}
-#endif
-
 	if (!IS_PLUTO(sba_dev->dev)) {
 		ioc_ctl = READ_REG(sba_dev->sba_hpa+IOC_CTRL);
 		DBG_INIT("%s() hpa 0x%lx ioc_ctl 0x%Lx ->",
@@ -1948,7 +1886,6 @@ static int __init sba_driver_callback(struct parisc_device *dev)
 	sba_dev->name = dev->name;
 	sba_dev->sba_hpa = sba_addr;
 
-	sba_get_pat_resources(sba_dev);
 	sba_hw_init(sba_dev);
 	sba_common_init(sba_dev);
 
-- 
2.25.1



