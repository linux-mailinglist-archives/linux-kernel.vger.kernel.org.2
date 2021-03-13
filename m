Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9EF333A0E0
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Mar 2021 21:05:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234402AbhCMUFJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Mar 2021 15:05:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233635AbhCMUFJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Mar 2021 15:05:09 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDF58C061574
        for <linux-kernel@vger.kernel.org>; Sat, 13 Mar 2021 12:05:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=FklQoEi8PnG+2CDky0Uq1toklxESBk4ZU9VRSAQNu8g=; b=rbe+a0CkmoLyc2L7lW/LP9e3ml
        kgxQAfMuITn7Ac4FmLN8cxcndahl0Y/ZiRviDR8T93a2ZLioweQJi5DzDRJ2llu+/7Xe+gluKyIYf
        JcybtnH9Ijd4W195aW3NvNx3o3KO3Cz1dUlCAGh/pDkB9Naui6KqSYtku1E9GfeMHYg2T0h7HhAYc
        L17PV/l3xw1inNkesSBiSviSJFL3Qr91CRoe4oleg/6NPSc7H+zrcEaYzrzUhu9nAokPgYfkAQfvp
        3tcVdQJTrdnTNUHqLmVq7jG3Q3tL2QeUT/CKeMYM/W/pfVYBBo5QHTLEYebGSjlaKcfSNQlIY7pU8
        JWhCceWw==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lLAUR-00EjDY-If; Sat, 13 Mar 2021 20:04:08 +0000
Date:   Sat, 13 Mar 2021 20:03:59 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     akpm@linux-foundation.org, ziy@nvidia.com,
        william.kucharski@oracle.com, vbabka@suse.cz,
        richard.weiyang@linux.alibaba.com, peterx@redhat.com,
        anshuman.khandual@arm.com, thomas_os@shipmail.org,
        rcampbell@nvidia.com, aneesh.kumar@linux.ibm.com,
        yang.shi@linux.alibaba.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH 1/6] mm/huge_memory.c: rework the function
 vma_adjust_trans_huge()
Message-ID: <20210313200359.GL2577561@casper.infradead.org>
References: <20210313103225.16607-1-linmiaohe@huawei.com>
 <20210313103225.16607-2-linmiaohe@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210313103225.16607-2-linmiaohe@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 13, 2021 at 05:32:19AM -0500, Miaohe Lin wrote:
> +static inline void try_to_split_huge_pmd_address(struct vm_area_struct *vma, unsigned long address)
> +{
> +	if (address & ~HPAGE_PMD_MASK &&
> +	    range_in_vma(vma, address & HPAGE_PMD_MASK,
> +			 (address & HPAGE_PMD_MASK) + HPAGE_PMD_SIZE))
> +		split_huge_pmd_address(vma, address, false, NULL);
> +}

This isn't "try to split".  This is "split if needed".  I think the
comments also need to be moved up here.

I'm not even sure this is really an improvement.
