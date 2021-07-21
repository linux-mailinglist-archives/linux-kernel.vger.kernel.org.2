Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 979033D196A
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jul 2021 23:50:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230005AbhGUVJl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jul 2021 17:09:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:55776 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229850AbhGUVJj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jul 2021 17:09:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1626904215;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mPmN8sJkfymkPUXPwPH3Wq9PCWu/VANbjmJ5RH7HOTE=;
        b=UXVuNVy4Rtb7zUZw1JLotzf1ccpWstxnv/FBqFTGQL2D/zJ/2aJIMOSnh9pEPqxIMymfOm
        b9z1ORZhIizs7zMvYhNk10ug85RtejGKNF2FLy62eEkfpoAT4elRS7fhH4ClQWV40M/XTA
        PdvZ2r/2XMSqDwQPOvdshrr2dL9ACC8=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-151-dzL6mtEsPTOQ9K_gP_3wGQ-1; Wed, 21 Jul 2021 17:50:14 -0400
X-MC-Unique: dzL6mtEsPTOQ9K_gP_3wGQ-1
Received: by mail-qt1-f200.google.com with SMTP id w13-20020ac843cd0000b0290251f0b91196so2286562qtn.14
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jul 2021 14:50:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=mPmN8sJkfymkPUXPwPH3Wq9PCWu/VANbjmJ5RH7HOTE=;
        b=P2Mq77xCzGglbtRyoymygaWolalefLyEuLmJ7St/mZv5wehMFQPfEOoiAJL0/r4VZd
         DPeo8E9ULvq82viYg8fV/KaF/nQuBrpcNUlKXGTlwridRc1GGKxk3qOeDEf9+x5m3LeO
         BcVn5PE+1ga3fJaL53XZENVK+X0iTBrmJQN+GAwBJMj2BmskE2CZJXPKEX9zsSzbWfCD
         dZ93a/E/dE6b9AOrIU/Cvjh3WhaXGgRgtoexiTlpsJ+KprS3FGGzJ6KPJTeozzkiy6Ld
         XtHN32ntu2w2jrI8rKrNCQ2qPDUUtkIwXD9CPYPHr3aqRujGIzHkfUJNeNgHqoq5mhxQ
         UbxA==
X-Gm-Message-State: AOAM530gEhaHBs2GAumEW3aqQCSUYqEtqYOubUOk1hGmA6CyWgo9av6w
        hWlPpsZd7JaLokuQbRQFJaWs5eEoNQ269hqN9UA+qjtQRkRSaFKZ382PV0REyvFMsqaep0cOxXs
        IvKTPi+7uucX+NzN5N+GO/lJY
X-Received: by 2002:a05:620a:e14:: with SMTP id y20mr36949604qkm.335.1626904213903;
        Wed, 21 Jul 2021 14:50:13 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyUWTbLjNWzwmzZVRpOjvzJV5EqTVFguc6bo+55jLpqedNVEMhn0/g6qiiobE/wzCSbEmMD5g==
X-Received: by 2002:a05:620a:e14:: with SMTP id y20mr36949586qkm.335.1626904213646;
        Wed, 21 Jul 2021 14:50:13 -0700 (PDT)
Received: from t490s (bras-base-toroon474qw-grc-65-184-144-111-238.dsl.bell.ca. [184.144.111.238])
        by smtp.gmail.com with ESMTPSA id c16sm9607474qtv.32.2021.07.21.14.50.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jul 2021 14:50:12 -0700 (PDT)
Date:   Wed, 21 Jul 2021 17:50:11 -0400
From:   Peter Xu <peterx@redhat.com>
To:     kernel test robot <lkp@intel.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        clang-built-linux@googlegroups.com, kbuild-all@lists.01.org,
        Axel Rasmussen <axelrasmussen@google.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Jerome Glisse <jglisse@redhat.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Alistair Popple <apopple@nvidia.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v5 17/26] hugetlb/userfaultfd: Hook page faults for uffd
 write protection
Message-ID: <YPiWk1ip4rWFe/eN@t490s>
References: <20210715201622.211762-1-peterx@redhat.com>
 <202107202342.QQMFPRAI-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <202107202342.QQMFPRAI-lkp@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 20, 2021 at 11:37:36PM +0800, kernel test robot wrote:
> config: s390-randconfig-r023-20210716 (attached as .config)

[...]

> >> mm/hugetlb.c:5063:29: error: implicit declaration of function 'huge_pte_uffd_wp' [-Werror,-Wimplicit-function-declaration]
>            if (userfaultfd_wp(vma) && huge_pte_uffd_wp(huge_ptep_get(ptep)) &&
>                                       ^
>    12 warnings and 1 error generated.

I remember I raised this question once on why s390 redefines a lot of huge pte
operations on its own even if they're defined the same in generic hugetlb.h..
I think there was a plan to rework that but definitely not landed yet.

Will sqaush below into the patch "mm/hugetlb: Introduce huge pte version of
uffd-wp helpers":

---8<---
diff --git a/arch/s390/include/asm/hugetlb.h b/arch/s390/include/asm/hugetlb.h
index 60f9241e5e4a..19c4b4431d27 100644
--- a/arch/s390/include/asm/hugetlb.h
+++ b/arch/s390/include/asm/hugetlb.h
@@ -115,6 +115,21 @@ static inline pte_t huge_pte_modify(pte_t pte, pgprot_t newprot)
        return pte_modify(pte, newprot);
 }
 
+static inline pte_t huge_pte_mkuffd_wp(pte_t pte)
+{
+       return pte;
+}
+
+static inline pte_t huge_pte_clear_uffd_wp(pte_t pte)
+{
+       return pte;
+}
+
+static inline int huge_pte_uffd_wp(pte_t pte)
+{
+       return 0;
+}
+
 static inline bool gigantic_page_runtime_supported(void)
 {
        return true;
---8<---

Thanks,

-- 
Peter Xu

