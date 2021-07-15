Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90DFE3CA84B
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jul 2021 20:57:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239660AbhGOTAb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jul 2021 15:00:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:29792 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234996AbhGOSxb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jul 2021 14:53:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1626375036;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Ajo5pEoABKRkdq+bnCfkdDE2HRwtDgm2wvZbZ9VLVZ8=;
        b=i6kE4if4BrkNMBFM54QTgw4hS3JbdPYCjp5ZeaJg5hC80bOiDCfNPSGPkEOCVDcKtindzw
        ZRJEWZaKS0iT9sSoO+3Zm8FLqEs8wa4Rw2ZtcnnGDYAQHKeV1yI/F9cxsFH+yAjPJ5xMoM
        wISqmAZvV3HEB3BwK5AqwlLRwRTp6DE=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-321-y6YhzUx0O86XnZhyQwd2JA-1; Thu, 15 Jul 2021 14:50:35 -0400
X-MC-Unique: y6YhzUx0O86XnZhyQwd2JA-1
Received: by mail-qk1-f197.google.com with SMTP id y5-20020a37af050000b02903a9c3f8b89fso4533849qke.2
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jul 2021 11:50:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Ajo5pEoABKRkdq+bnCfkdDE2HRwtDgm2wvZbZ9VLVZ8=;
        b=irz6WmCFeAvBzLzHR9hiivgBrSiwu3mUx3KScp1gsGl7ENFSfrxb76s4UcwlWftuBp
         ZGIffsGfp27i0VqYCtePxochpAY52F3Tv/0oCtI/+j6O6QXgl+/wnMTKlL+prjvrFd13
         gcdG9AzEqyoo2kZCbO6TU/06/+zCLPSLejUtwGFD1ByAbcUh0WQatAD7keZfB2bwTfS8
         O37qze38vD6VTu90ypJj/IrMN0FTwGlzwEFq1gX5ExKpueuFaKV/f4OkICHFXFWggTyH
         QRJ/e5Uh9aufTFcNq7GaUWU1bxupfKVCBjAOGhFXYhzA5660/y+ndfUAU9i8XciE9M11
         aASw==
X-Gm-Message-State: AOAM530Gj29ZstOr4nyvz4ywhTnlGmSuw228roQsnkz6D36LteYWi+pH
        jB2ypkvuLC9STI26sx6TtyfZBIU2vOr2rdiS4zHhsvkpObF5Li8ZhTIueGiVHWqFyY60K/NSH/X
        sPt/A1J5CzcPKdtGuLrgBoI3z
X-Received: by 2002:a37:6516:: with SMTP id z22mr5535728qkb.203.1626375035101;
        Thu, 15 Jul 2021 11:50:35 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzaJBbwU0SqGt6eHeIVQYvxpX46Wf+EuOQUC/AtpPiJpD1RZFiUPvltMICDKtggPapZlPUikQ==
X-Received: by 2002:a37:6516:: with SMTP id z22mr5535708qkb.203.1626375034888;
        Thu, 15 Jul 2021 11:50:34 -0700 (PDT)
Received: from t490s (bras-base-toroon474qw-grc-65-184-144-111-238.dsl.bell.ca. [184.144.111.238])
        by smtp.gmail.com with ESMTPSA id o10sm2281394qtv.62.2021.07.15.11.50.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jul 2021 11:50:34 -0700 (PDT)
Date:   Thu, 15 Jul 2021 14:50:33 -0400
From:   Peter Xu <peterx@redhat.com>
To:     kernel test robot <lkp@intel.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        clang-built-linux@googlegroups.com, kbuild-all@lists.01.org,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Jerome Glisse <jglisse@redhat.com>
Subject: Re: [PATCH v4 06/26] shmem/userfaultfd: Handle uffd-wp special pte
 in page fault handler
Message-ID: <YPCDeYZxaeV+N5m/@t490s>
References: <20210714222117.47648-7-peterx@redhat.com>
 <202107151452.ClaDCF2a-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <202107151452.ClaDCF2a-lkp@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 15, 2021 at 02:20:21PM +0800, kernel test robot wrote:
> Hi Peter,
> 
> Thank you for the patch! Yet something to improve:
> 
> [auto build test ERROR on linus/master]
> [also build test ERROR on v5.14-rc1 next-20210714]
> [cannot apply to hnaz-linux-mm/master asm-generic/master linux/master]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch]
> 
> url:    https://github.com/0day-ci/linux/commits/Peter-Xu/userfaultfd-wp-Support-shmem-and-hugetlbfs/20210715-062718
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 8096acd7442e613fad0354fc8dfdb2003cceea0b
> config: x86_64-randconfig-r021-20210714 (attached as .config)
> compiler: clang version 13.0.0 (https://github.com/llvm/llvm-project 0e49c54a8cbd3e779e5526a5888c683c01cc3c50)
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # install x86_64 cross compiling tool for clang build
>         # apt-get install binutils-x86-64-linux-gnu
>         # https://github.com/0day-ci/linux/commit/8b3e70f40b8333a803e642ed5c8cce738985881c
>         git remote add linux-review https://github.com/0day-ci/linux
>         git fetch --no-tags linux-review Peter-Xu/userfaultfd-wp-Support-shmem-and-hugetlbfs/20210715-062718
>         git checkout 8b3e70f40b8333a803e642ed5c8cce738985881c
>         # save the attached .config to linux build tree
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross ARCH=x86_64 
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All errors (new ones prefixed by >>):
> 
> >> mm/memory.c:4167:6: error: implicit declaration of function 'uffd_disable_fault_around' [-Werror,-Wimplicit-function-declaration]
>            if (uffd_disable_fault_around(vmf->vma))
>                ^
>    1 error generated.
> 
> 
> vim +/uffd_disable_fault_around +4167 mm/memory.c
> 
>   4159	
>   4160	/* Return true if we should do read fault-around, false otherwise */
>   4161	static inline bool should_fault_around(struct vm_fault *vmf)
>   4162	{
>   4163		/* No ->map_pages?  No way to fault around... */
>   4164		if (!vmf->vma->vm_ops->map_pages)
>   4165			return false;
>   4166	
> > 4167		if (uffd_disable_fault_around(vmf->vma))
>   4168			return false;
>   4169	
>   4170		return fault_around_bytes >> PAGE_SHIFT > 1;
>   4171	}
>   4172	
> 
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

Will squash this into the patch:

---8<---
diff --git a/include/linux/userfaultfd_k.h b/include/linux/userfaultfd_k.h
index c4228acd1d80..4382240de7c3 100644
--- a/include/linux/userfaultfd_k.h
+++ b/include/linux/userfaultfd_k.h
@@ -283,6 +283,11 @@ static inline bool pte_swp_uffd_wp_special(pte_t pte)
        return false;
 }
 
+static inline bool uffd_disable_fault_around(struct vm_area_struct *vma)
+{
+       return false;
+}
+
 #endif /* CONFIG_USERFAULTFD */
 
 #endif /* _LINUX_USERFAULTFD_K_H */
---8<---

Thanks,

-- 
Peter Xu

