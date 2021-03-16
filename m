Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9AFA33DF08
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 21:41:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231469AbhCPUlH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 16:41:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:44372 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231245AbhCPUki (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 16:40:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1615927238;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KX59dOzLD9yfpsQwlmLH6v3D1a9D72eLKsbU2fNBRlw=;
        b=BFvjNYfV75d92SfPmF/L/8uJLZ6xJyGEDDqpOELqmAZFG9Pttoi1FGovorWFDEtGpIK44m
        L1q9kNfHr/vxeSePeCb/CUKwM65Odkpkef3V6MkzR29f8RZ8Ge/wLYPLEZoyrPXFSQDDWL
        2NbpRU6Utk9Y8a4I5m9PT8sjtcq7MB0=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-161-OvriUeQXN-6q99-SOAdmzQ-1; Tue, 16 Mar 2021 16:40:36 -0400
X-MC-Unique: OvriUeQXN-6q99-SOAdmzQ-1
Received: by mail-qk1-f197.google.com with SMTP id y9so27658318qki.14
        for <linux-kernel@vger.kernel.org>; Tue, 16 Mar 2021 13:40:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=KX59dOzLD9yfpsQwlmLH6v3D1a9D72eLKsbU2fNBRlw=;
        b=PZ3svtH8uc4HglCQr3zzIQMRH9avVeNPRjxQWdqb2vVxsKE0KazwiEzwlU9NHdsR2n
         vdwgYqR2C8gcsNMk5FiSUsYJD5SVXaZasfFefKE5bS6vvkHQo3DiZerugBkSlGR99MDk
         HTIO38UcXgwK2pgMbJHoeZRCEm9O7ACbTO/7dwZ6TvWoJNY2vXjcxJkJmaUIJEkrXu7O
         jX2dycMTOMsaRkyu3PIIqzpDpIEqQHRCBkDPi02xxlIPEfb6Vd+6M0+ezN88QqZYv2h/
         ewIiIilQ25ELTapG5zjTk+EZ+Yb6o1GGLEasT4HOPTY4EpaG52lEgQH3bh4vts/hhPQy
         lupg==
X-Gm-Message-State: AOAM5324ombOMFD5lswWJyxCWeZaBIHEvgDrMalyWNp1THHNAycTMV/+
        c8MCz9SG7VK6FpADcLNkUs/30r5CaakRrynUb0vHUWqswctglpyJ5uO3BHZTcq3edcxLit6yiBP
        DD4tbwylIqXjIyIN/4mnFMkEq
X-Received: by 2002:a05:6214:1744:: with SMTP id dc4mr1409606qvb.40.1615927236154;
        Tue, 16 Mar 2021 13:40:36 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzVLVDc/WCDRFl89Ty0f/G8CmwPqPDE9IkMBT7e8iNmC2afJ+CcJZClP7WD/nN5ZReBRCdYig==
X-Received: by 2002:a05:6214:1744:: with SMTP id dc4mr1409575qvb.40.1615927235896;
        Tue, 16 Mar 2021 13:40:35 -0700 (PDT)
Received: from xz-x1 ([142.126.89.138])
        by smtp.gmail.com with ESMTPSA id 21sm15890887qkv.12.2021.03.16.13.40.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Mar 2021 13:40:35 -0700 (PDT)
Date:   Tue, 16 Mar 2021 16:40:34 -0400
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
Message-ID: <20210316204034.GE395976@xz-x1>
References: <20210316124007.20474-1-linmiaohe@huawei.com>
 <20210316124007.20474-2-linmiaohe@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210316124007.20474-2-linmiaohe@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 16, 2021 at 08:40:02AM -0400, Miaohe Lin wrote:
> +static inline void split_huge_pmd_if_needed(struct vm_area_struct *vma, unsigned long address)
> +{
> +	/*
> +	 * If the new address isn't hpage aligned and it could previously
> +	 * contain an hugepage: check if we need to split an huge pmd.
> +	 */
> +	if (address & ~HPAGE_PMD_MASK &&
> +	    range_in_vma(vma, address & HPAGE_PMD_MASK,
> +			 (address & HPAGE_PMD_MASK) + HPAGE_PMD_SIZE))

Since you're at it, maybe use ALIGN/ALIGN_DOWN too against HPAGE_PMD_SIZE?

> +		split_huge_pmd_address(vma, address, false, NULL);
> +}

-- 
Peter Xu

