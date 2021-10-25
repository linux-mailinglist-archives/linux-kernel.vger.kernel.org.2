Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72B69438FC8
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Oct 2021 08:56:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231373AbhJYG6m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Oct 2021 02:58:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229727AbhJYG6k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Oct 2021 02:58:40 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B9E0C061745
        for <linux-kernel@vger.kernel.org>; Sun, 24 Oct 2021 23:56:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=tMpqzvoQkJMhQLbS0C1ZDEhCzSzUf+VL7fFW2UCbKFQ=; b=2q60wzxpnWubAlhqt2u3rz5FQ7
        sJ9iBTzR19YxcrC15C3a2ML/HYxPxSikeH9n9oLJnPMZ0vQzzOS6FRpfZlLbvAek8RNaNXwkOZB9f
        M2RiACykY+CLo50/YHPao6pWY0/W2EY4//wxxPhiSkCbHHY41rFU+gX0RccwOi464tg0j3TkanCmq
        I+8wzKjEj4kwKXw5+uB4mZ3ktGU2xhKG6CvLGs6SosXi9yZ/+e7MkKGN3EuROY1uJNUTQ9dY0Z2GG
        N2lqP+J4RLHhpOCYcEd3YpBgYAEPaxTwixA0LL7gWE59tiUkCB/ouxMZ1anNUQ9j6PIOdBrU4lLN7
        5UyHHSsA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mettn-00FSTF-3k; Mon, 25 Oct 2021 06:55:59 +0000
Date:   Sun, 24 Oct 2021 23:55:59 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     wefu@redhat.com
Cc:     anup.patel@wdc.com, atish.patra@wdc.com, palmerdabbelt@google.com,
        guoren@kernel.org, christoph.muellner@vrull.eu,
        philipp.tomsich@vrull.eu, hch@lst.de, liush@allwinnertech.com,
        lazyparser@gmail.com, drew@beagleboard.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        taiten.peng@canonical.com, aniket.ponkshe@canonical.com,
        heinrich.schuchardt@canonical.com, gordan.markus@canonical.com,
        guoren@linux.alibaba.com, arnd@arndb.de, wens@csie.org,
        maxime@cerno.tech, dlustig@nvidia.com, gfavor@ventanamicro.com,
        andrea.mondelli@huawei.com, behrensj@mit.edu, xinhaoqu@huawei.com,
        huffman@cadence.com, mick@ics.forth.gr,
        allen.baum@esperantotech.com, jscheid@ventanamicro.com,
        rtrauben@gmail.com
Subject: Re: [RESEND PATCH V3 2/2] riscv: add RISC-V Svpbmt extension supports
Message-ID: <YXZU/3/YmRGFrOXK@infradead.org>
References: <20211025040607.92786-1-wefu@redhat.com>
 <20211025040607.92786-3-wefu@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211025040607.92786-3-wefu@redhat.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 25, 2021 at 12:06:07PM +0800, wefu@redhat.com wrote:
>  static inline pmd_t *pud_pgtable(pud_t pud)
>  {
> -	return (pmd_t *)pfn_to_virt(pud_val(pud) >> _PAGE_PFN_SHIFT);
> +	return (pmd_t *)pfn_to_virt((pud_val(pud) & _PAGE_CHG_MASK)
> +						>> _PAGE_PFN_SHIFT);
>  }
>  
>  static inline struct page *pud_page(pud_t pud)
>  {
> -	return pfn_to_page(pud_val(pud) >> _PAGE_PFN_SHIFT);
> +	return pfn_to_page((pud_val(pud) & _PAGE_CHG_MASK)
> +						>> _PAGE_PFN_SHIFT);

>  static inline unsigned long _pmd_pfn(pmd_t pmd)
>  {
> -	return pmd_val(pmd) >> _PAGE_PFN_SHIFT;
> +	return (pmd_val(pmd) & _PAGE_CHG_MASK) >> _PAGE_PFN_SHIFT;
>  }

The "(pud_val(pud) & _PAGE_CHG_MASK) >> _PAGE_PFN_SHIFT" expression begs
for readable and well-documented helper.

> +#define _SVPBMT_PMA		((unsigned long)0x0 << 61)
> +#define _SVPBMT_NC		((unsigned long)0x1 << 61)
> +#define _SVPBMT_IO		((unsigned long)0x2 << 61)

0UL << 61
1UL << 61
...

> +#define _SVPBMT_MASK		(_SVPBMT_PMA | _SVPBMT_NC | _SVPBMT_IO)
> +
> +extern struct __riscv_svpbmt_struct {
> +	unsigned long mask;
> +	unsigned long mt_pma;
> +	unsigned long mt_nc;
> +	unsigned long mt_io;
> +} __riscv_svpbmt;
> +
> +#define _PAGE_MT_MASK		__riscv_svpbmt.mask
> +#define _PAGE_MT_PMA		__riscv_svpbmt.mt_pma
> +#define _PAGE_MT_NC		__riscv_svpbmt.mt_nc
> +#define _PAGE_MT_IO		__riscv_svpbmt.mt_io

Using a struct over individual variables seems a little odd here.

Also why not use the standard names for these _PAGE bits used by
most other architectures?

> -	return (unsigned long)pfn_to_virt(pmd_val(pmd) >> _PAGE_PFN_SHIFT);
> +	return (unsigned long)pfn_to_virt((pmd_val(pmd) & _PAGE_CHG_MASK) >> _PAGE_PFN_SHIFT);

Overly long line, could use a helper.  Btw, what is the point in having
this _PAGE_PFN_SHIFT macro to start with?
