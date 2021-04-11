Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E882935B20B
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Apr 2021 08:41:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235051AbhDKGlX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Apr 2021 02:41:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbhDKGlT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Apr 2021 02:41:19 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 023DFC061574
        for <linux-kernel@vger.kernel.org>; Sat, 10 Apr 2021 23:41:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=acFKTT6j+VIJs5Iv9WmiwQ+Ih1xaWJpjPGlz3k/Bpuc=; b=WCUkIBI9Ib2tmGjLv1koAFK6xW
        wnmntCyQWuznBzTiEY5H18tqoRToqfsAJefuz3l+tVWdmuLf1GCa4oDJenwVYdx9GIklbM2naDP0v
        YmG1/hObiuIByileOSBUu2aj1+pUyjtIE2eUgLiOr+9ltXjjyFgcuHO3DCoG6dI+MceYy3rwP2dGM
        HfwmeYA9xZW6xWZD0W4qgqTdWq2z+GG58iU6mH0OKY5pzIq8HdxVpI1VA3ZsS5u09MNFz8X2OgYQm
        bc4lFqMX11kJ9A3RqZ/YD0qPhlyYnte5Xw1xKb6VpzNlk32C4ic7VaG/IQGCHnzCT9Zp8DkPEvw19
        S4RDhfgg==;
Received: from [2601:1c0:6280:3f0::e0e1]
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lVTm4-002ets-4l; Sun, 11 Apr 2021 06:40:49 +0000
Subject: Re: [PATCH 1/1] iommu/vt-d: Fix build error of pasid_enable_wpe()
 with !X86
To:     Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>
Cc:     iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Sanjay Kumar <sanjay.k.kumar@intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        kernel test robot <lkp@intel.com>
References: <20210411062312.3057579-1-baolu.lu@linux.intel.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <6a36c635-5f88-6264-e9c8-62ea6c5d771e@infradead.org>
Date:   Sat, 10 Apr 2021 23:40:45 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210411062312.3057579-1-baolu.lu@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/10/21 11:23 PM, Lu Baolu wrote:
> Commit f68c7f539b6e9 ("iommu/vt-d: Enable write protect for supervisor
> SVM") added pasid_enable_wpe() which hit below compile error with !X86.
> 
> ../drivers/iommu/intel/pasid.c: In function 'pasid_enable_wpe':
> ../drivers/iommu/intel/pasid.c:554:22: error: implicit declaration of function 'read_cr0' [-Werror=implicit-function-declaration]
>   554 |  unsigned long cr0 = read_cr0();
>       |                      ^~~~~~~~
> In file included from ../include/linux/build_bug.h:5,
>                  from ../include/linux/bits.h:22,
>                  from ../include/linux/bitops.h:6,
>                  from ../drivers/iommu/intel/pasid.c:12:
> ../drivers/iommu/intel/pasid.c:557:23: error: 'X86_CR0_WP' undeclared (first use in this function)
>   557 |  if (unlikely(!(cr0 & X86_CR0_WP))) {
>       |                       ^~~~~~~~~~
> ../include/linux/compiler.h:78:42: note: in definition of macro 'unlikely'
>    78 | # define unlikely(x) __builtin_expect(!!(x), 0)
>       |                                          ^
> ../drivers/iommu/intel/pasid.c:557:23: note: each undeclared identifier is reported only once for each function it appears in
>   557 |  if (unlikely(!(cr0 & X86_CR0_WP))) {
>       |                       ^~~~~~~~~~
> ../include/linux/compiler.h:78:42: note: in definition of macro 'unlikely'
>    78 | # define unlikely(x) __builtin_expect(!!(x), 0)
>       |
> 
> Add the missing dependency.
> 
> Cc: Sanjay Kumar <sanjay.k.kumar@intel.com>
> Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
> Cc: Randy Dunlap <rdunlap@infradead.org>
> Reported-by: kernel test robot <lkp@intel.com>
> Reported-by: Randy Dunlap <rdunlap@infradead.org>
> Fixes: f68c7f539b6e9 ("iommu/vt-d: Enable write protect for supervisor SVM")
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>

Acked-by: Randy Dunlap <rdunlap@infradead.org> # build-tested


Thanks.

> ---
>  drivers/iommu/intel/pasid.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/iommu/intel/pasid.c b/drivers/iommu/intel/pasid.c
> index 477b2e1d303c..72646bafc52f 100644
> --- a/drivers/iommu/intel/pasid.c
> +++ b/drivers/iommu/intel/pasid.c
> @@ -551,6 +551,7 @@ static void pasid_flush_caches(struct intel_iommu *iommu,
>  
>  static inline int pasid_enable_wpe(struct pasid_entry *pte)
>  {
> +#ifdef CONFIG_X86
>  	unsigned long cr0 = read_cr0();
>  
>  	/* CR0.WP is normally set but just to be sure */
> @@ -558,6 +559,7 @@ static inline int pasid_enable_wpe(struct pasid_entry *pte)
>  		pr_err_ratelimited("No CPU write protect!\n");
>  		return -EINVAL;
>  	}
> +#endif
>  	pasid_set_wpe(pte);
>  
>  	return 0;
> 


-- 
~Randy

