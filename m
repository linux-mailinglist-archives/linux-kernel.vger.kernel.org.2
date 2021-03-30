Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B13D34DDD7
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 03:58:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230296AbhC3B53 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Mar 2021 21:57:29 -0400
Received: from mailout3.samsung.com ([203.254.224.33]:15733 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229971AbhC3B5W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Mar 2021 21:57:22 -0400
Received: from epcas2p3.samsung.com (unknown [182.195.41.55])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20210330015720epoutp039213b373cb4356b9040769ea645973cc~w-Ba68rjg1991919919epoutp03R
        for <linux-kernel@vger.kernel.org>; Tue, 30 Mar 2021 01:57:20 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20210330015720epoutp039213b373cb4356b9040769ea645973cc~w-Ba68rjg1991919919epoutp03R
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1617069440;
        bh=5ZScrmmcxQqatNI31ZwuXxeZ6LsYrfSRPMYPmdr2K9w=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=pLdbZCXpiiQm97M9EslG3cpp0UdvTrTgiWAnvjtqEjajApjtQ2nQ2np+yNGCICYuG
         o1cAPRVHjepK4oMS8ICSAPrE5X1YRZg+Yd1x+whDJn7p4blOQkHmiji4yKqfN4G0sR
         +qkMg08T7ugC3bETuopIvkyHtyKIUNsO9cObFQeA=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas2p3.samsung.com (KnoxPortal) with ESMTP id
        20210330015720epcas2p3bb3c2b6a3d3dbb18e9351b4e5c3d49ad~w-Bamq8zO2902829028epcas2p3i;
        Tue, 30 Mar 2021 01:57:20 +0000 (GMT)
Received: from epsmges2p4.samsung.com (unknown [182.195.40.188]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4F8XdB1nZKz4x9Q1; Tue, 30 Mar
        2021 01:57:18 +0000 (GMT)
Received: from epcas2p2.samsung.com ( [182.195.41.54]) by
        epsmges2p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        63.55.52511.B7582606; Tue, 30 Mar 2021 10:57:15 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas2p2.samsung.com (KnoxPortal) with ESMTPA id
        20210330015714epcas2p2ff49cae56de7225cf76da93af75a5154~w-BVhR6980124901249epcas2p2y;
        Tue, 30 Mar 2021 01:57:14 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20210330015714epsmtrp1239db5aaf5f3b4a3dd7222b7d7ab60db~w-BVgfzxq1023010230epsmtrp1w;
        Tue, 30 Mar 2021 01:57:14 +0000 (GMT)
X-AuditID: b6c32a48-50fff7000000cd1f-f6-6062857b3a85
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        E1.AE.08745.A7582606; Tue, 30 Mar 2021 10:57:14 +0900 (KST)
Received: from ubuntu (unknown [12.36.155.120]) by epsmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20210330015714epsmtip2a13505d1ea2d8fd211cd90a775f43f97~w-BVWsFpS2382823828epsmtip2U;
        Tue, 30 Mar 2021 01:57:14 +0000 (GMT)
Date:   Tue, 30 Mar 2021 10:44:39 +0900
From:   Hyunsoon Kim <h10.kim@samsung.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, dseok.yi@samsung.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: add ___GFP_NOINIT flag which disables zeroing on
 alloc
Message-ID: <20210330014439.GA53009@ubuntu>
MIME-Version: 1.0
In-Reply-To: <61a2df08-2681-34fc-3407-921993c8a1f5@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFuphk+LIzCtJLcpLzFFi42LZdljTTLe6NSnBYMVMEYs569ewWXxd/4vZ
        4sq0P4wWl3fNYbO4t+Y/qwOrx6ZPk9g9Tsz4zeLxft9VNo++LasYPT5vkgtgjcqxyUhNTEkt
        UkjNS85PycxLt1XyDo53jjc1MzDUNbS0MFdSyEvMTbVVcvEJ0HXLzAFarqRQlphTChQKSCwu
        VtK3synKLy1JVcjILy6xVUotSMkpMDQs0CtOzC0uzUvXS87PtTI0MDAyBapMyMk4vWkia8Ft
        hYrlG/IbGD9JdTFyckgImEjsv9bP3MXIxSEksINRYuX3WUwQzidGidn/HkJlPjNKNLY3scG0
        nPp5CapqF6PEzlf3oKqeMEpMvXgIrIpFQFViwuXXjCA2m4CGxO0pM9lBbBEge1PbBmYQm1mg
        XOLn/INgtrBAoMT1rn8sXYwcHLwC2hLHTkuChHkFBCVOznzCAmJzCthJNL97ygZSIiqgIvHq
        YD3EPR/ZJfqmS0LYLhLLuy8xQtjCEq+Ob2GHsKUkXva3Qdn1ErMvnwQ7WUJgAqPEy3P9TBAJ
        Y4lZz9oZIU7LkLh4pIERZJeEgLLEkVssEGE+iY7Df9khwrwSHW1CEJ2KEitOzIQaLy7R1rid
        GcL2kJi36jU0qE4zSnxZ3MwygVF+FpLPZiHZBmHrSCzY/YltFtAKZgFpieX/OCBMTYn1u/QX
        MLKuYhRLLSjOTU8tNiowQY7qTYzgZKnlsYNx9tsPeocYmTgYDzFKcDArifAKH0hMEOJNSays
        Si3Kjy8qzUktPsRoCoylicxSosn5wHSdVxJvaGpkZmZgaWphamZkoSTOW2TwIF5IID2xJDU7
        NbUgtQimj4mDU6qBaW/yiVjtj3dPXeLS/cn556n08eQIN8/1U8St0s3npMceb7fzvFp1603V
        1qL3As0+T369NBTmfV796e6fR8ecPrQeX+Ia/KD4gl1PnOPRw4r/ubvYmoViy5paz7fujmmq
        e6+2raKuOLDJaLvOwmouB/tlLHvqnLbZ9nN9iZ1om5w1LfnVr8OXDsu27BevLM11+PM4R1xq
        0rp1i/0vmll8UDJ5uP1VrZNQTEql35xG3jma20174xtMv87X/7flTXuP6vdDFhuyt9wt50xQ
        uvqyYOVMhrCIt23fnrY8Uv7m87lphqO8mtMSrdKAjnO7l2T6iKzVnN2w7+Lq5Fy99CaviXee
        n311McH5xQFBY4+VSizFGYmGWsxFxYkA2+aQbB8EAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrELMWRmVeSWpSXmKPExsWy7bCSvG5Va1KCwbm1ZhZz1q9hs/i6/hez
        xZVpfxgtLu+aw2Zxb81/VgdWj02fJrF7nJjxm8Xj/b6rbB59W1YxenzeJBfAGsVlk5Kak1mW
        WqRvl8CV8XLNJZaC2XIVT5pvsjYwnpboYuTkkBAwkTj18xJTFyMXh5DADkaJxx9nM0IkxCWe
        LrkAZQtL3G85wgpR9IhRYmrfCyaQBIuAqsSEy6/BitgENCRuT5nJDmKLANmb2jYwg9jMAuUS
        P+cfBLOFBQIlrnf9Y+li5ODgFdCWOHZaEmLmaUaJXXPXs4DU8AoISpyc+YQFoldL4sa/l0wg
        9cwC0hLL/3GAhDkF7CSa3z1lAwmLCqhIvDpYP4FRcBaS5llImmchNC9gZF7FKJlaUJybnlts
        WGCUl1quV5yYW1yal66XnJ+7iREc7FpaOxj3rPqgd4iRiYPxEKMEB7OSCK/wgcQEId6UxMqq
        1KL8+KLSnNTiQ4zSHCxK4rwXuk7GCwmkJ5akZqemFqQWwWSZODilGpiWPTPJu+1ksmOmds20
        iReSz+rqPJO81Of17K+sa8j3qSfTAx0Lvx6eoWXZWbvJRCv17NeOXbNMZ/14cqi7IfNp//Uj
        S35djlIJWNdY4xGiaFATNuPhA8azJ67x//1mfuFoBlf0TZnPffsb6/m+nuoXUXfyCZyp+vau
        dC7njZXhE3/zy5x2Oa57+cE1aaWzIjrJzn+m3jt48sUMV3fOb55bvvRXl9x9++PqoS3ye251
        hKa9bTWYXRywhu1nCnsux6THYTdeqywp7nrscEppd9bHzGrfpZf7puWHchycXLNQynpda/+O
        dL1iHS+DozM+xIS8jZ25Iebk7NnNUUsdd/rs2L/66t/NM4vdF75OkdvOqsRSnJFoqMVcVJwI
        AFqAbnTlAgAA
X-CMS-MailID: 20210330015714epcas2p2ff49cae56de7225cf76da93af75a5154
X-Msg-Generator: CA
Content-Type: multipart/mixed;
        boundary="----T2cFxz24vRWZtMc1tCBiz7vL2X.qeMy6RKNliPrPFkM53-8y=_29e05_"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20210329054156epcas2p31650fa755e6cbcc55c4f33a79878256f
References: <CGME20210329054156epcas2p31650fa755e6cbcc55c4f33a79878256f@epcas2p3.samsung.com>
        <1616995751-83180-1-git-send-email-h10.kim@samsung.com>
        <61a2df08-2681-34fc-3407-921993c8a1f5@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

------T2cFxz24vRWZtMc1tCBiz7vL2X.qeMy6RKNliPrPFkM53-8y=_29e05_
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline

On Mon, Mar 29, 2021 at 12:53:48PM +0200, David Hildenbrand wrote:
> On 29.03.21 07:29, Hyunsoon Kim wrote:
> >This patch allows programmer to avoid zero initialization on page
> >allocation even when the kernel config "CONFIG_INIT_ON_ALLOC_DEFAULT"
> >is enabled. The configuration is made to prevent uninitialized
> >heap memory flaws, and Android has applied this for security and
> >deterministic execution times. Please refer to below.
> >
> >https://android-review.googlesource.com/c/kernel/common/+/1235132
> >
> >However, there is a case that the zeroing page memory is unnecessary
> >when the page is used on specific purpose and will be zeroed
> >automatically by hardware that accesses the memory through DMA.
> >For instance, page allocation used for IP packet reception from Exynos
> >modem is solely used for packet reception. Although the page will be
> >freed eventually and reused for some other purpose, initialization at
> >that moment of reuse will be sufficient to avoid uninitialized heap
> >memory flaws. To support this kind of control, this patch creates new
> >gfp type called ___GFP_NOINIT, that allows no zeroing at the moment
> >of page allocation, called by many related APIs such as page_frag_alloc,
> >alloc_pages, etc.
> >
> >Signed-off-by: Hyunsoon Kim <h10.kim@samsung.com>
> >---
> >  include/linux/gfp.h | 2 ++
> >  include/linux/mm.h  | 4 +++-
> >  2 files changed, 5 insertions(+), 1 deletion(-)
> >
> >diff --git a/include/linux/gfp.h b/include/linux/gfp.h
> >index 8572a14..4ddd947 100644
> >--- a/include/linux/gfp.h
> >+++ b/include/linux/gfp.h
> >@@ -58,6 +58,8 @@ struct vm_area_struct;
> >  #else
> >  #define ___GFP_NOLOCKDEP	0
> >  #endif
> >+#define ___GFP_NOINIT		0x1000000u
> >+
> >  /* If the above are modified, __GFP_BITS_SHIFT may need updating */
> >  /*
> >diff --git a/include/linux/mm.h b/include/linux/mm.h
> >index 8ba4342..06a23bb 100644
> >--- a/include/linux/mm.h
> >+++ b/include/linux/mm.h
> >@@ -2907,7 +2907,9 @@ static inline void kernel_unpoison_pages(struct page *page, int numpages) { }
> >  DECLARE_STATIC_KEY_FALSE(init_on_alloc);
> >  static inline bool want_init_on_alloc(gfp_t flags)
> >  {
> >-	if (static_branch_unlikely(&init_on_alloc))
> >+	if (flags & ___GFP_NOINIT)
> >+		return false;
> >+	else if (static_branch_unlikely(&init_on_alloc))
> >  		return true;
> >  	return flags & __GFP_ZERO;
> >  }
> >
> 
> We discussed that in the past - whatever leaves the buddy shall be
> initialized. This is a security feature, not something random kernel modules
> should be able to hack around.
> 
> We also discussed back then to allow other allocators to eventually be able
> to optimize in the future if we are sure it really makes sense. Then,
> however, we need a new API that is not available to random modules, instead
> of exposing ___GFP_NOINIT to anybody out there in the system.
> 
> Nacked-by: David Hildenbrand <david@redhat.com>
> 
> -- 
> Thanks,
> 
> David / dhildenb

If you don't mind, may i ask you exactly what security flaws you are expecting
from uninitialized value allocation? I can think of below scenario:

1. Security related value is freed by security system.
2. Malicious module get allocation to the memory region that is freed by above.
3. Malicious module uses that uninitialized value, and breach the security.

Could you please confirm that I am think in the right way? If so, isn't it
possible to make the security system to zero on free? I am not talking about
CONFIG_INIT_ON_FREE_DEFAULT_ON. I am just suggesting that isn't it better to
make programs that generate important values to be forced to initialize on
free, instead of making whole system to zeroing on alloc always, resulting
in performance downgrade? I think this approach can make enhancement.

Thanks,

------T2cFxz24vRWZtMc1tCBiz7vL2X.qeMy6RKNliPrPFkM53-8y=_29e05_
Content-Type: text/plain; charset="utf-8"


------T2cFxz24vRWZtMc1tCBiz7vL2X.qeMy6RKNliPrPFkM53-8y=_29e05_--
