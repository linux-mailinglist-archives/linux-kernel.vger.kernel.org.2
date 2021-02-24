Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F557323A68
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Feb 2021 11:22:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234754AbhBXKUj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Feb 2021 05:20:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232560AbhBXKU3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Feb 2021 05:20:29 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78615C061574
        for <linux-kernel@vger.kernel.org>; Wed, 24 Feb 2021 02:19:47 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id d11so1323681wrj.7
        for <linux-kernel@vger.kernel.org>; Wed, 24 Feb 2021 02:19:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=/FE7tvrvqoJrGxZtO1M2WLOCJzVWjV9STY44PZX27ks=;
        b=I+hKBBRhc37miRhiK8ZHrqDkDbC9ZQjaR5dVS+zd58oLtjUmKZm5Zq5kbd4+AwzinV
         L5Mykd0nm3IjEea2Rzw8z3ekuMvJHPInvHCZx/h8DGBqUQooGetyjVlF+7RgyAP8R8hQ
         mgBlVMqp4d9I1wwMJ7mYi/kTGeFmNrgu9a+43IKP3OYuJ+1N3j2N/z3Y4Wed9txt1qQV
         YE5Yu0tgHe4NGY6kWQHm/bgOf0NQXzC0aqwOG4C+y0QK0NZCcHJM6aPY6paaRZV5aoBl
         fG+XXh+JXLPl7e9TwPOy4rAkFYKSXm2aMjZQ50wtP3BngAZEVQIFWHIOI5yBQ9wanzEE
         VwdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/FE7tvrvqoJrGxZtO1M2WLOCJzVWjV9STY44PZX27ks=;
        b=hCa9NRJjZHq4dSeltZetgjD33wTdeRJEJZrz4XFHCbtDccepz9WzsJgudC3m7+gyt6
         10CmcOPTVXh+Ck25RIqkkvl78KvR/naf0/+l5VcdHSdfNeCnhAPaop/7y/w5gZr+3dnj
         Yp4h9HA1Uy1+tA4bJs2g0bXIqK3AqtlfOgNrKyx3Gt0gBFlEG4Z5LW9PcjBzPZt0cK72
         wI66Qu50/Q8TzV7uL0IMC6XQl8rf6zFxFsHNoiNeruHxvQMOe3We1lmLKVN4hnyYBpr1
         W7EwDhWXgEB7cM7Je4u85NOaeoGWL5Hg08n8ZaJ8OMxuZQVlm64yas/v9nA0MElCs04O
         39Jw==
X-Gm-Message-State: AOAM530rZaoRJNDBJXv3A8hGDNUMaa19acqnwisSQrIanXNbDgOGgEBq
        XFpw6SWj5uu2ZgWazFTZ0EZ7wg==
X-Google-Smtp-Source: ABdhPJyKndYC691It/7gqXtAE5RbW9Z17Tm2vdDWURKYH/LNKjlcRD8BPcuGIEs1+3EkHAospr4whg==
X-Received: by 2002:adf:f941:: with SMTP id q1mr31859042wrr.189.1614161986271;
        Wed, 24 Feb 2021 02:19:46 -0800 (PST)
Received: from myrica ([2001:1715:4e26:a7e0:116c:c27a:3e7f:5eaf])
        by smtp.gmail.com with ESMTPSA id v5sm2015023wmh.2.2021.02.24.02.19.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Feb 2021 02:19:45 -0800 (PST)
Date:   Wed, 24 Feb 2021 11:19:27 +0100
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     Fenghua Yu <fenghua.yu@intel.com>
Cc:     Joerg Roedel <joro@8bytes.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Jacob Jun Pan <jacob.jun.pan@intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        iommu@lists.linux-foundation.org, zhangfei.gao@foxmail.com,
        linux-mm@kvack.org
Subject: Re: [PATCH v6 08/12] fork: Clear PASID for new mm
Message-ID: <YDYoL/zZ9YaGgwSV@myrica>
References: <1594684087-61184-1-git-send-email-fenghua.yu@intel.com>
 <1594684087-61184-9-git-send-email-fenghua.yu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1594684087-61184-9-git-send-email-fenghua.yu@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Fenghua,

[Trimmed the Cc list]

On Mon, Jul 13, 2020 at 04:48:03PM -0700, Fenghua Yu wrote:
> When a new mm is created, its PASID should be cleared, i.e. the PASID is
> initialized to its init state 0 on both ARM and X86.

I just noticed this patch was dropped in v7, and am wondering whether we
could still upstream it. Does x86 need a child with a new address space
(!CLONE_VM) to inherit the PASID of the parent?  That doesn't make much
sense with regard to IOMMU structures - same PASID indexing multiple PGDs?

Currently iommu_sva_alloc_pasid() assumes mm->pasid is always initialized
to 0 and fails on forked tasks. I'm trying to figure out how to fix this.
Could we clear the pasid on fork or does it break the x86 model?

Thanks,
Jean

> 
> Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
> Reviewed-by: Tony Luck <tony.luck@intel.com>
> ---
> v2:
> - Add this patch to initialize PASID value for a new mm.
> 
>  include/linux/mm_types.h | 2 ++
>  kernel/fork.c            | 8 ++++++++
>  2 files changed, 10 insertions(+)
> 
> diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
> index d61285cfe027..d60d2ec10881 100644
> --- a/include/linux/mm_types.h
> +++ b/include/linux/mm_types.h
> @@ -22,6 +22,8 @@
>  #endif
>  #define AT_VECTOR_SIZE (2*(AT_VECTOR_SIZE_ARCH + AT_VECTOR_SIZE_BASE + 1))
>  
> +/* Initial PASID value is 0. */
> +#define INIT_PASID	0
>  
>  struct address_space;
>  struct mem_cgroup;
> diff --git a/kernel/fork.c b/kernel/fork.c
> index 142b23645d82..43b5f112604d 100644
> --- a/kernel/fork.c
> +++ b/kernel/fork.c
> @@ -1007,6 +1007,13 @@ static void mm_init_owner(struct mm_struct *mm, struct task_struct *p)
>  #endif
>  }
>  
> +static void mm_init_pasid(struct mm_struct *mm)
> +{
> +#ifdef CONFIG_IOMMU_SUPPORT
> +	mm->pasid = INIT_PASID;
> +#endif
> +}
> +
>  static void mm_init_uprobes_state(struct mm_struct *mm)
>  {
>  #ifdef CONFIG_UPROBES
> @@ -1035,6 +1042,7 @@ static struct mm_struct *mm_init(struct mm_struct *mm, struct task_struct *p,
>  	mm_init_cpumask(mm);
>  	mm_init_aio(mm);
>  	mm_init_owner(mm, p);
> +	mm_init_pasid(mm);
>  	RCU_INIT_POINTER(mm->exe_file, NULL);
>  	mmu_notifier_subscriptions_init(mm);
>  	init_tlb_flush_pending(mm);
> -- 
> 2.19.1
> 
