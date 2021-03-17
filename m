Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46CBF33F0DD
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 14:08:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230292AbhCQNH1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 09:07:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:50242 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230331AbhCQNHL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 09:07:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1615986431;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4pCvMxP4NIT/0WZCGZyEfttqqDQqWVhHTo9mUX6r6Us=;
        b=PRC9H+OHAH/l6DIX2UR4raHW4e95vdxZiJn23wXKxennpGM9twYs8XqYtQHfmcax93pfJ5
        lwipr17fz/edNfTSCnrAUf9kE5b58Y02G0oT7i4zYIqoRNsKtUXrfoO0X6/1EzRLxxGzTS
        SIVv0HPxFjVA3sCp2s8+2l/OOWmXyzU=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-345-r_EUq5XtPlmTLx7dTRlh6Q-1; Wed, 17 Mar 2021 09:07:09 -0400
X-MC-Unique: r_EUq5XtPlmTLx7dTRlh6Q-1
Received: by mail-qv1-f70.google.com with SMTP id dz17so27612222qvb.14
        for <linux-kernel@vger.kernel.org>; Wed, 17 Mar 2021 06:07:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=4pCvMxP4NIT/0WZCGZyEfttqqDQqWVhHTo9mUX6r6Us=;
        b=qlUKqMlKnqPt+kGzJV3otp+Q6EpVoF1u3WlDVBhjRzNBlMIoSfxpRpEdzZZMApzK4g
         q04whNqXH6/p8kjNUnUNAV7PWqVIaFhrIKlZ0qx2sVTP6PdH58YV7iFveAkJkw1p4O/C
         6xT9xTbRjq/kpO0N9AK9Hl7jx0S8jf3WvJDeN6uRNSXJyboxDXCN4lw0fkBQ60xjHj5k
         a0li91B4zvh4l0IAP4OFF/VIRHK1LELNd5RZrAcPiVqCDTjtGwYoCIM8eOOCyq8WDaoB
         9B1BGidZMVW6W1Q8wOdVEql92qFZQx0VZCSF9T/pZXSfWVNBTYgE4nWt/k5d+DPt5z9h
         FZ4Q==
X-Gm-Message-State: AOAM5328UtHHafr2bkLAgy3j95gWzGJOPyfbWWQUq4RzCGFB9ehVZUmm
        jgw/WizNuc7YG/pCXYTbYJGHm3Y0spdPzTryy3LDOe9uUEXrD/8D9IKfyXNxOSZ1lkhGpodgwTw
        oh4G4NfS1n7+pKTA9VVzM3nGV
X-Received: by 2002:a0c:ed2c:: with SMTP id u12mr5367307qvq.30.1615986428814;
        Wed, 17 Mar 2021 06:07:08 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyYMD2/BnuHTuih57TnWV4OIvckXueEoBqtOwxHahW6iI9M1d4S5aF11gjV8e8yFC6H+7mSRg==
X-Received: by 2002:a0c:ed2c:: with SMTP id u12mr5367281qvq.30.1615986428567;
        Wed, 17 Mar 2021 06:07:08 -0700 (PDT)
Received: from xz-x1 ([142.126.89.138])
        by smtp.gmail.com with ESMTPSA id b198sm17576424qkg.10.2021.03.17.06.07.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Mar 2021 06:07:08 -0700 (PDT)
Date:   Wed, 17 Mar 2021 09:07:06 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     akpm@linux-foundation.org, ziy@nvidia.com, willy@infradead.org,
        william.kucharski@oracle.com, vbabka@suse.cz,
        yulei.kernel@gmail.com, walken@google.com,
        aneesh.kumar@linux.ibm.com, rcampbell@nvidia.com,
        thomas_os@shipmail.org, yang.shi@linux.alibaba.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v2 1/6] mm/huge_memory.c: rework the function
 vma_adjust_trans_huge()
Message-ID: <20210317130706.GJ395976@xz-x1>
References: <20210316124007.20474-1-linmiaohe@huawei.com>
 <20210316124007.20474-2-linmiaohe@huawei.com>
 <20210316204034.GE395976@xz-x1>
 <f4bc08ee-36a0-0018-251b-16399a3182ad@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <f4bc08ee-36a0-0018-251b-16399a3182ad@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 17, 2021 at 10:18:40AM +0800, Miaohe Lin wrote:
> Hi:
> On 2021/3/17 4:40, Peter Xu wrote:
> > On Tue, Mar 16, 2021 at 08:40:02AM -0400, Miaohe Lin wrote:
> >> +static inline void split_huge_pmd_if_needed(struct vm_area_struct *vma, unsigned long address)
> >> +{
> >> +	/*
> >> +	 * If the new address isn't hpage aligned and it could previously
> >> +	 * contain an hugepage: check if we need to split an huge pmd.
> >> +	 */
> >> +	if (address & ~HPAGE_PMD_MASK &&
> >> +	    range_in_vma(vma, address & HPAGE_PMD_MASK,
> >> +			 (address & HPAGE_PMD_MASK) + HPAGE_PMD_SIZE))
> > 
> > Since you're at it, maybe use ALIGN/ALIGN_DOWN too against HPAGE_PMD_SIZE?
> > 
> 
> Many thanks for reply. Sounds good. :) Do you mean this?
> 
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index bff92dea5ab3..ae16a82da823 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -2301,44 +2301,38 @@ void split_huge_pmd_address(struct vm_area_struct *vma, unsigned long address,
>         __split_huge_pmd(vma, pmd, address, freeze, page);
>  }
> 
> +static inline void split_huge_pmd_if_needed(struct vm_area_struct *vma, unsigned long address)
> +{
> +       /*
> +        * If the new address isn't hpage aligned and it could previously
> +        * contain an hugepage: check if we need to split an huge pmd.
> +        */
> +       if (!IS_ALIGNED(address, HPAGE_PMD_SIZE) &&
> +           range_in_vma(vma, ALIGN_DOWN(address, HPAGE_PMD_SIZE),
> +                        ALIGN(address, HPAGE_PMD_SIZE)))
> +               split_huge_pmd_address(vma, address, false, NULL);
> +}
> +

Yes. Thanks,

-- 
Peter Xu

