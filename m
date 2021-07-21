Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0EE5A3D0F62
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jul 2021 15:22:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237528AbhGUMlX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jul 2021 08:41:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237482AbhGUMlW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jul 2021 08:41:22 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40392C061766
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jul 2021 06:21:58 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id n1so2159592wri.10
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jul 2021 06:21:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=WRPIeeTtTDR2LlDj5ceBw6T0c+uzv2M4RXSSHHaWqFs=;
        b=UFhxkVVXQS3ors73HPsnbYlHeWCNTcs2Iz05+LH8+Lk+fPxVr3ZD603KlIFn1IpNNl
         AQ80sVRQvS/U2AzDTGEozRhKK8QqvsuqeHMRVuwX6fK9OWLGBGNtXvL5zwAJ81OEKpCY
         ZXWwGPAwkvjydO/Z/sFy6p94UIUOC1gjPv6qbFcEMivAWl+4b5U1hzJ+E8znZX7V3JM0
         rFCvLRIPyPeL/ptyV9m5PAsZCMpObUgo/2kbxH5k6x7bqRruqH1vMjJzLGpjVKFWOu2c
         vVyKkynZzvMEUufvE+rjUfxc6GsKuELp+FRRz2M7gi9HU25RGg2petonAOCsnrGPo1wa
         YgMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=WRPIeeTtTDR2LlDj5ceBw6T0c+uzv2M4RXSSHHaWqFs=;
        b=cM1SPDI00l3LheC5vBuE8vTeistL99EjXiCXB0/StxC46DMPpVdDuAx50zU+oyawZH
         tGimbb6/KY97frQhDqBUYWWPtw1NzJBBfg+Q/szMyf2vcTPGs+Y2gwMbMp1dgwbIIkk3
         6D7KICq9w9BF207t+H0/YJQNdbBrnDEDHANwD1NRfFh5odXoEzuOdhYMdU5LkyWR5CVr
         VzIfu9J8AuQJPq5coMkcqtlFZWdilSpc8BIoBPXFXEiRrrNQNSo04eqfLa0KvpuO2Lua
         mfpPcmSUSVJ450jHiKVgC9YYFDgbOWfPp60Yyahs4wg6qR5mfv7UzZJYO4KmQi7geTZ/
         d4PQ==
X-Gm-Message-State: AOAM5337z1CV+cc2RvlZcPWi+bscrkPkSy17eH990YXyca5NhpxTq049
        YrXx8nciuivcLAhtNinu7W4=
X-Google-Smtp-Source: ABdhPJxGLtNZkhRGgkH+fDbpNRzk2uE2XMlWpIfesuBaMkOIjeVuHqrCu4zkc/GNRl8d3rlaQox/Zg==
X-Received: by 2002:a05:6000:1107:: with SMTP id z7mr43623487wrw.228.1626873716789;
        Wed, 21 Jul 2021 06:21:56 -0700 (PDT)
Received: from ?IPv6:2a02:8084:e84:2480:228:f8ff:fe6f:83a8? ([2a02:8084:e84:2480:228:f8ff:fe6f:83a8])
        by smtp.gmail.com with ESMTPSA id o7sm19509939wrs.52.2021.07.21.06.21.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Jul 2021 06:21:56 -0700 (PDT)
Subject: Re: [PATCH v2] mm/mremap: Don't account pages in vma_to_resize()
To:     Dmitry Safonov <dima@arista.com>, linux-kernel@vger.kernel.org
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Brian Geffon <bgeffon@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Chen Wandun <chenwandun@huawei.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Hugh Dickins <hughd@google.com>,
        Ingo Molnar <mingo@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        John Hubbard <jhubbard@nvidia.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Minchan Kim <minchan@kernel.org>,
        Ralph Campbell <rcampbell@nvidia.com>,
        Russell King <linux@armlinux.org.uk>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Wei Yongjun <weiyongjun1@huawei.com>,
        Will Deacon <will@kernel.org>
References: <20210721131320.522061-1-dima@arista.com>
From:   Dmitry Safonov <0x7f454c46@gmail.com>
Message-ID: <77e28552-7a13-0981-f921-cd027cb73525@gmail.com>
Date:   Wed, 21 Jul 2021 14:21:54 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210721131320.522061-1-dima@arista.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/21/21 2:13 PM, Dmitry Safonov wrote:
> All this vm_unacct_memory(charged) dance seems to complicate the life
> without a good reason. Furthermore, it seems not always done right on
> error-pathes in mremap_to().
> And worse than that: this `charged' difference is sometimes
> double-accounted for growing MREMAP_DONTUNMAP mremap()s in move_vma():
> : if (security_vm_enough_memory_mm(mm, new_len >> PAGE_SHIFT))
> 
> Let's not do this.
> Account memory in mremap() fast-path for growing VMAs or in move_vma()
> for actually moving things. The same simpler way as it's done by
> vm_stat_account(), but with a difference to call
> security_vm_enough_memory_mm() before copying/adjusting VMA.
> 
> Originally noticed by Chen Wandun:
> https://lkml.kernel.org/r/20210717101942.120607-1-chenwandun@huawei.com

The patch by Chen Wandun still makes sense with this v2.
Heh :-)

> 
> Cc: Alexander Viro <viro@zeniv.linux.org.uk>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Andy Lutomirski <luto@kernel.org>
> Cc: Brian Geffon <bgeffon@google.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Chen Wandun <chenwandun@huawei.com>
> Cc: Dan Carpenter <dan.carpenter@oracle.com>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: Dave Jiang <dave.jiang@intel.com>
> Cc: Hugh Dickins <hughd@google.com>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Jason Gunthorpe <jgg@ziepe.ca>
> Cc: John Hubbard <jhubbard@nvidia.com>
> Cc: Kefeng Wang <wangkefeng.wang@huawei.com>
> Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
> Cc: Mike Kravetz <mike.kravetz@oracle.com>
> Cc: Minchan Kim <minchan@kernel.org>
> Cc: Ralph Campbell <rcampbell@nvidia.com>
> Cc: Russell King <linux@armlinux.org.uk>
> Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Vishal Verma <vishal.l.verma@intel.com>
> Cc: Vlastimil Babka <vbabka@suse.cz>
> Cc: Wei Yongjun <weiyongjun1@huawei.com>
> Cc: Will Deacon <will@kernel.org>
> Fixes: e346b3813067 ("mm/mremap: add MREMAP_DONTUNMAP to mremap()")
> Signed-off-by: Dmitry Safonov <dima@arista.com>
> ---
>  mm/mremap.c | 50 ++++++++++++++++++++++----------------------------
>  1 file changed, 22 insertions(+), 28 deletions(-)
> 
> diff --git a/mm/mremap.c b/mm/mremap.c
> index 5989d3990020..b90c8e732e29 100644
> --- a/mm/mremap.c
> +++ b/mm/mremap.c
> @@ -565,6 +565,7 @@ static unsigned long move_vma(struct vm_area_struct *vma,
>  		bool *locked, unsigned long flags,
>  		struct vm_userfaultfd_ctx *uf, struct list_head *uf_unmap)
>  {
> +	long to_account = new_len - old_len;
>  	struct mm_struct *mm = vma->vm_mm;
>  	struct vm_area_struct *new_vma;
>  	unsigned long vm_flags = vma->vm_flags;
> @@ -583,6 +584,9 @@ static unsigned long move_vma(struct vm_area_struct *vma,
>  	if (mm->map_count >= sysctl_max_map_count - 3)
>  		return -ENOMEM;
>  
> +	if (unlikely(flags & MREMAP_DONTUNMAP))
> +		to_account = new_len;
> +
>  	if (vma->vm_ops && vma->vm_ops->may_split) {
>  		if (vma->vm_start != old_addr)
>  			err = vma->vm_ops->may_split(vma, old_addr);
> @@ -604,8 +608,8 @@ static unsigned long move_vma(struct vm_area_struct *vma,
>  	if (err)
>  		return err;
>  
> -	if (unlikely(flags & MREMAP_DONTUNMAP && vm_flags & VM_ACCOUNT)) {
> -		if (security_vm_enough_memory_mm(mm, new_len >> PAGE_SHIFT))
> +	if (vm_flags & VM_ACCOUNT) {
> +		if (security_vm_enough_memory_mm(mm, to_account >> PAGE_SHIFT))
>  			return -ENOMEM;
>  	}
>  
> @@ -613,8 +617,8 @@ static unsigned long move_vma(struct vm_area_struct *vma,
>  	new_vma = copy_vma(&vma, new_addr, new_len, new_pgoff,
>  			   &need_rmap_locks);
>  	if (!new_vma) {
> -		if (unlikely(flags & MREMAP_DONTUNMAP && vm_flags & VM_ACCOUNT))
> -			vm_unacct_memory(new_len >> PAGE_SHIFT);
> +		if (vm_flags & VM_ACCOUNT)
> +			vm_unacct_memory(to_account >> PAGE_SHIFT);
>  		return -ENOMEM;
>  	}
>  
> @@ -708,8 +712,7 @@ static unsigned long move_vma(struct vm_area_struct *vma,
>  }
>  
>  static struct vm_area_struct *vma_to_resize(unsigned long addr,
> -	unsigned long old_len, unsigned long new_len, unsigned long flags,
> -	unsigned long *p)
> +	unsigned long old_len, unsigned long new_len, unsigned long flags)
>  {
>  	struct mm_struct *mm = current->mm;
>  	struct vm_area_struct *vma;
> @@ -768,13 +771,6 @@ static struct vm_area_struct *vma_to_resize(unsigned long addr,
>  				(new_len - old_len) >> PAGE_SHIFT))
>  		return ERR_PTR(-ENOMEM);
>  
> -	if (vma->vm_flags & VM_ACCOUNT) {
> -		unsigned long charged = (new_len - old_len) >> PAGE_SHIFT;
> -		if (security_vm_enough_memory_mm(mm, charged))
> -			return ERR_PTR(-ENOMEM);
> -		*p = charged;
> -	}
> -
>  	return vma;
>  }
>  
> @@ -787,7 +783,6 @@ static unsigned long mremap_to(unsigned long addr, unsigned long old_len,
>  	struct mm_struct *mm = current->mm;
>  	struct vm_area_struct *vma;
>  	unsigned long ret = -EINVAL;
> -	unsigned long charged = 0;
>  	unsigned long map_flags = 0;
>  
>  	if (offset_in_page(new_addr))
> @@ -830,7 +825,7 @@ static unsigned long mremap_to(unsigned long addr, unsigned long old_len,
>  		old_len = new_len;
>  	}
>  
> -	vma = vma_to_resize(addr, old_len, new_len, flags, &charged);
> +	vma = vma_to_resize(addr, old_len, new_len, flags);
>  	if (IS_ERR(vma)) {
>  		ret = PTR_ERR(vma);
>  		goto out;
> @@ -853,7 +848,7 @@ static unsigned long mremap_to(unsigned long addr, unsigned long old_len,
>  				((addr - vma->vm_start) >> PAGE_SHIFT),
>  				map_flags);
>  	if (IS_ERR_VALUE(ret))
> -		goto out1;
> +		goto out;
>  
>  	/* We got a new mapping */
>  	if (!(flags & MREMAP_FIXED))
> @@ -862,12 +857,6 @@ static unsigned long mremap_to(unsigned long addr, unsigned long old_len,
>  	ret = move_vma(vma, addr, old_len, new_len, new_addr, locked, flags, uf,
>  		       uf_unmap);
>  
> -	if (!(offset_in_page(ret)))
> -		goto out;
> -
> -out1:
> -	vm_unacct_memory(charged);
> -
>  out:
>  	return ret;
>  }
> @@ -899,7 +888,6 @@ SYSCALL_DEFINE5(mremap, unsigned long, addr, unsigned long, old_len,
>  	struct mm_struct *mm = current->mm;
>  	struct vm_area_struct *vma;
>  	unsigned long ret = -EINVAL;
> -	unsigned long charged = 0;
>  	bool locked = false;
>  	bool downgraded = false;
>  	struct vm_userfaultfd_ctx uf = NULL_VM_UFFD_CTX;
> @@ -981,7 +969,7 @@ SYSCALL_DEFINE5(mremap, unsigned long, addr, unsigned long, old_len,
>  	/*
>  	 * Ok, we need to grow..
>  	 */
> -	vma = vma_to_resize(addr, old_len, new_len, flags, &charged);
> +	vma = vma_to_resize(addr, old_len, new_len, flags);
>  	if (IS_ERR(vma)) {
>  		ret = PTR_ERR(vma);
>  		goto out;
> @@ -992,10 +980,18 @@ SYSCALL_DEFINE5(mremap, unsigned long, addr, unsigned long, old_len,
>  	if (old_len == vma->vm_end - addr) {
>  		/* can we just expand the current mapping? */
>  		if (vma_expandable(vma, new_len - old_len)) {
> -			int pages = (new_len - old_len) >> PAGE_SHIFT;
> +			long pages = (new_len - old_len) >> PAGE_SHIFT;
> +
> +			if (vma->vm_flags & VM_ACCOUNT) {
> +				if (security_vm_enough_memory_mm(mm, pages)) {
> +					ret = -ENOMEM;
> +					goto out;
> +				}
> +			}
>  
>  			if (vma_adjust(vma, vma->vm_start, addr + new_len,
>  				       vma->vm_pgoff, NULL)) {
> +				vm_unacct_memory(pages);
>  				ret = -ENOMEM;
>  				goto out;
>  			}
> @@ -1034,10 +1030,8 @@ SYSCALL_DEFINE5(mremap, unsigned long, addr, unsigned long, old_len,
>  			       &locked, flags, &uf, &uf_unmap);
>  	}
>  out:
> -	if (offset_in_page(ret)) {
> -		vm_unacct_memory(charged);
> +	if (offset_in_page(ret))
>  		locked = false;
> -	}
>  	if (downgraded)
>  		mmap_read_unlock(current->mm);
>  	else
> 


-- 
Dima
