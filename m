Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F99C3AE19C
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jun 2021 04:13:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230137AbhFUCPf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Jun 2021 22:15:35 -0400
Received: from gw2.atmark-techno.com ([35.74.137.57]:35234 "EHLO
        gw2.atmark-techno.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229937AbhFUCPe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Jun 2021 22:15:34 -0400
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
        by gw2.atmark-techno.com (Postfix) with ESMTPS id 7F21B20D08
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jun 2021 11:03:22 +0900 (JST)
Received: by mail-pj1-f70.google.com with SMTP id s5-20020a17090a7645b029016f7e331ca4so4181339pjl.6
        for <linux-kernel@vger.kernel.org>; Sun, 20 Jun 2021 19:03:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=cPF5UweySrMkbBj5zDiR8HRka2TADsWzHftasg98zJs=;
        b=O9u6C/jvOAMeIpjAQUjeZT7ATyIxOaz4AW7XKzmCcwmqRdl6t0EmOYQqJiTq1YSg1S
         BWEkWIHxDR9bN4+RaU2rJvauOvrCSoL28m6uRuKs3Hi2CycRySq80RW9bbZ1AeDECjLn
         VvUFx1LDVmwOBFHIeQ4t38l9IHa15JfAe6cbNFr1yVac8SZ+pX4aIZq783gXYTod9H6i
         C6qPnhpAqp3vSy4FYZ+k7J1xYOODS3ywlTMQMF9C3WtS+6oY31ejf6fibenVdryYr7wH
         2suwi2NBxgYSsCF9mjFvX4oeSDmoNSdc+EbMacd0E3gn7e1mZhbzMIA5eY5N/Fc5DNAa
         tYOg==
X-Gm-Message-State: AOAM5309FqnrZwWhyoJh2z1IiSZ36s+pzfs+L36VrEuoTNoPMW1Yc9E3
        Tndy9iZsganxAfCoSTO0QzeY0S79hQYaXsr2+VqrcmWqFXDWsvX1eBi3s65AMBmWPQ/ooCSXAjM
        rc7dDKAcKGsnZdQzfjMgKFjP4jg==
X-Received: by 2002:a17:902:e54c:b029:124:5738:cd9b with SMTP id n12-20020a170902e54cb02901245738cd9bmr4032572plf.37.1624241001472;
        Sun, 20 Jun 2021 19:03:21 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwx8Jdi39fuUyMjJ1Kb1I8R8bWjY0P4PsRzQ0H9QhFuNwbpgfwmRCUN81esvdU5Up0p8pQdeA==
X-Received: by 2002:a17:902:e54c:b029:124:5738:cd9b with SMTP id n12-20020a170902e54cb02901245738cd9bmr4032535plf.37.1624241001191;
        Sun, 20 Jun 2021 19:03:21 -0700 (PDT)
Received: from pc-0115 (35.112.198.104.bc.googleusercontent.com. [104.198.112.35])
        by smtp.gmail.com with ESMTPSA id jz10sm4710917pjb.4.2021.06.20.19.03.20
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 20 Jun 2021 19:03:20 -0700 (PDT)
Received: from martinet by pc-0115 with local (Exim 4.94.2)
        (envelope-from <martinet@pc-0115>)
        id 1lv9HR-0013P4-QI; Mon, 21 Jun 2021 11:03:17 +0900
Date:   Mon, 21 Jun 2021 11:03:07 +0900
From:   Dominique MARTINET <dominique.martinet@atmark-techno.com>
To:     Jianxiong Gao <jxgao@google.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Konrad Rzeszutek Wilk <konrad@darnok.org>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Horia =?utf-8?Q?Geant=C4=83?= <horia.geanta@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Lukas Hartmann <lukas@mntmn.com>,
        Aymen Sghaier <aymen.sghaier@nxp.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        Marc Orr <marcorr@google.com>,
        Erdem Aktas <erdemaktas@google.com>,
        Peter Gonda <pgonda@google.com>,
        Chanho Park <chanho61.park@samsung.com>
Subject: Re: swiotlb/caamjr regression (Was: [GIT PULL] (swiotlb)
 stable/for-linus-5.12)
Message-ID: <YM/zWyZlk1bzHWgI@atmark-techno.com>
References: <YL7XXNOnbaDgmTB9@atmark-techno.com>
 <2e899de2-4b69-c4b6-33a6-09fb8949d2fd@nxp.com>
 <20210611062153.GA30906@lst.de>
 <YMM8Ua0HMmErLIQg@0xbeefdead.lan>
 <CAMGD6P1v2JoJoxSuAYL8UjdtCaLCc4K_7xzVkumspeb0qn=LBQ@mail.gmail.com>
 <YMqW+/gQvM+uWUTw@fedora>
 <YMqZswFnSNKk4Z7B@atmark-techno.com>
 <20210617051232.GB27192@lst.de>
 <YMrfWBLsJxCRhX5U@atmark-techno.com>
 <CAMGD6P0=9RE1-q1WHkwR1jymK5jyvN6QgypQ2KgdvBQn0CUTHw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="hJa3fgBh5wrqenuN"
Content-Disposition: inline
In-Reply-To: <CAMGD6P0=9RE1-q1WHkwR1jymK5jyvN6QgypQ2KgdvBQn0CUTHw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--hJa3fgBh5wrqenuN
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Jianxiong Gao wrote on Fri, Jun 18, 2021 at 11:01:59AM -0700:
> > Jianxiong Gao, before spending more time on this, could you also try
> > Chanho Park's patch?
> > https://lore.kernel.org/linux-iommu/20210510091816.GA2084@lst.de/T/#m0d0df6490350a08dcc24c9086c8edc165b402d6f
> >
> I have tested Chanho Parks's patch and it works for us.
> The NVMe driver performs correctly with the patch.
> 
> I have teste the patch on 06af8679449d

Thanks!
(a bit late, but added Chanho Park in Cc...)

I can confirm it also works for our caam problem, as Horia said.

I've also come to term with the use of swiotlb_align_offset() through
testing, or rather many devices seem to have a 0 mask so it will almost
always be cancelled out, so if it works for Jianxiong then it's probably
good enough and I'll just assume that's how the orig_addr has been
designed...

I think it's missing a couple of checks like the one Linus had in his
patch, and would be comfortable with something like the attached patch
(in practice for me exactly the same as the original patch, except I've
added two checks: offsets smaller than orig addr offset are refused as
well as offsets bigger than the mapping size)

I'm sorry Jianxiong but would you be willing to take the time to test
again just to make sure there were no such offsets in your case?


If we're good with that I'll send it as an official v2 keeping Chanho's
from, unless he wants to.


Thanks everyone,
-- 
Dominique



--hJa3fgBh5wrqenuN
Content-Type: text/x-diff; charset=utf-8
Content-Description: swiotlb.patch
Content-Disposition: attachment; filename="swiotlb.patch"

diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index 8ca7d505d61c..23f8d0b168c5 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -334,6 +334,14 @@ void __init swiotlb_exit(void)
 	io_tlb_default_mem = NULL;
 }
 
+/*
+ * Return the offset into a iotlb slot required to keep the device happy.
+ */
+static unsigned int swiotlb_align_offset(struct device *dev, u64 addr)
+{
+	return addr & dma_get_min_align_mask(dev) & (IO_TLB_SIZE - 1);
+}
+
 /*
  * Bounce: copy the swiotlb buffer from or back to the original dma location
  */
@@ -346,10 +354,31 @@ static void swiotlb_bounce(struct device *dev, phys_addr_t tlb_addr, size_t size
 	size_t alloc_size = mem->slots[index].alloc_size;
 	unsigned long pfn = PFN_DOWN(orig_addr);
 	unsigned char *vaddr = phys_to_virt(tlb_addr);
+	unsigned int tlb_offset, orig_addr_offset;
 
 	if (orig_addr == INVALID_PHYS_ADDR)
 		return;
 
+	tlb_offset = tlb_addr & (IO_TLB_SIZE - 1);
+	orig_addr_offset = swiotlb_align_offset(dev, orig_addr);
+	if (tlb_offset < orig_addr_offset) {
+		dev_WARN_ONCE(dev, 1,
+			"Access before mapping start detected. orig offset %u, requested offset %u.\n",
+			orig_addr_offset, tlb_offset);
+		return;
+	}
+
+	tlb_offset -= orig_addr_offset;
+	if (tlb_offset > alloc_size) {
+		dev_WARN_ONCE(dev, 1,
+			"Buffer overflow detected. Allocation size: %zu. Mapping size: %zu+%u.\n",
+			alloc_size, size, tlb_offset);
+		return;
+	}
+
+	orig_addr += tlb_offset;
+	alloc_size -= tlb_offset;
+
 	if (size > alloc_size) {
 		dev_WARN_ONCE(dev, 1,
 			"Buffer overflow detected. Allocation size: %zu. Mapping size: %zu.\n",
@@ -390,14 +419,6 @@ static void swiotlb_bounce(struct device *dev, phys_addr_t tlb_addr, size_t size
 
 #define slot_addr(start, idx)	((start) + ((idx) << IO_TLB_SHIFT))
 
-/*
- * Return the offset into a iotlb slot required to keep the device happy.
- */
-static unsigned int swiotlb_align_offset(struct device *dev, u64 addr)
-{
-	return addr & dma_get_min_align_mask(dev) & (IO_TLB_SIZE - 1);
-}
-
 /*
  * Carefully handle integer overflow which can occur when boundary_mask == ~0UL.
  */

--hJa3fgBh5wrqenuN--
