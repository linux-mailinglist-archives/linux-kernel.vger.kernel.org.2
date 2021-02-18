Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E55A131F2BE
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Feb 2021 00:04:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229656AbhBRXD6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Feb 2021 18:03:58 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:25684 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229649AbhBRXDz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Feb 2021 18:03:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1613689348;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=FU+AIYqDGgm8srMw7KnfiWhYBmq4BR3BSBFf66+l9Sc=;
        b=Z7fTwP3EDBJuICg4JPriWWyFehPMfLtVxTxdC3S3TBgeTJCHQe1aLfUVCrcznTdeafV+He
        uRcnklbiimFliLEOUKWNPQsehSMjEeYlZUYcq2uf+fQDqLni7seY2ib5jE8irHLwAOxbMH
        DX6Bh4Uiw1/V3A28Bel7xBbWr1aaS74=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-181-OiA8WiqCOJG8k8f7LsoudQ-1; Thu, 18 Feb 2021 18:02:27 -0500
X-MC-Unique: OiA8WiqCOJG8k8f7LsoudQ-1
Received: by mail-qk1-f198.google.com with SMTP id r15so2333227qke.5
        for <linux-kernel@vger.kernel.org>; Thu, 18 Feb 2021 15:02:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=FU+AIYqDGgm8srMw7KnfiWhYBmq4BR3BSBFf66+l9Sc=;
        b=rTIrP1qZ3IYPeSnhT0Ttd1mfFLwJQIQhBbcNEbys9PUmvRumx7dlAj+Vm/9XkR6D4e
         Kp4GIRRV/kv2BXAughUpPrMIwZSqLQXu7EThbqineWVB/DqQA2vDzmGPBDsOBu9swFeV
         +tMiSi3Kn94DbClhw2G7r/8++kl7sSI2u+ZrdCfwnYoV3TLthoofNrDnvJK9FE3ueUKQ
         bMLdsPQn/NMZOJ4R2LNla7sxT9b4lGuf0gtvLiHp40vpaGy+vfl3JfSu2D+xr04YHpz7
         1vkehucnyM602ofWuSE9zkBVouofXSnoa/i2Uo5iYDL+w0KX3QHrREYVcLppoc0/lRad
         5H2w==
X-Gm-Message-State: AOAM532Ke8zViCVoAqo+byk0J7DADVFon7p323dFCVmiBrz+I8FqCSwM
        hlg8RVewaGv9xXX2FY8U4OFXf5r4vQib9LOatlFbPIuImyt1HZUsHws3GgIvKZQBQbCqDGnzfGe
        u6KeOo+pe8HBdMC/5CCnTd4HL
X-Received: by 2002:ad4:5ecc:: with SMTP id jm12mr4018444qvb.33.1613689346907;
        Thu, 18 Feb 2021 15:02:26 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxjIop6wWlrtUWew3t2FDo9DLD6rg6n78m0yu7ZvLqgdBvXGS0U7xBcDcd0OHbtsr2xsCDcfQ==
X-Received: by 2002:ad4:5ecc:: with SMTP id jm12mr4018431qvb.33.1613689346688;
        Thu, 18 Feb 2021 15:02:26 -0800 (PST)
Received: from xz-x1 (bras-vprn-toroon474qw-lp130-20-174-93-89-182.dsl.bell.ca. [174.93.89.182])
        by smtp.gmail.com with ESMTPSA id u126sm4902865qkc.107.2021.02.18.15.02.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Feb 2021 15:02:26 -0800 (PST)
Date:   Thu, 18 Feb 2021 18:02:24 -0500
From:   Peter Xu <peterx@redhat.com>
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Axel Rasmussen <axelrasmussen@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Matthew Wilcox <willy@infradead.org>,
        Andrea Arcangeli <aarcange@redhat.com>
Subject: Re: [PATCH v3 1/4] hugetlb: Pass vma into huge_pte_alloc() and
 huge_pmd_share()
Message-ID: <20210218230224.GC6669@xz-x1>
References: <20210218215434.10203-1-peterx@redhat.com>
 <20210218215434.10203-2-peterx@redhat.com>
 <76fee968-cfc2-787f-7e48-af781563756e@oracle.com>
 <20210218222757.GA6669@xz-x1>
 <9d93ec4c-4cb9-c3c8-5b73-ae00c4fa9435@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <9d93ec4c-4cb9-c3c8-5b73-ae00c4fa9435@oracle.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 18, 2021 at 02:38:18PM -0800, Mike Kravetz wrote:
> I thought the error was caused by not deleting the line
> 
> 	pte_t *huge_pte_alloc(struct mm_struct *mm,
> 
> when adding
> 
> 	pte_t *huge_pte_alloc(struct mm_struct *mm, struct vm_area_struct *vma,
> 
> as above.

Sorry about that!  I'll repost.

-- 
Peter Xu

