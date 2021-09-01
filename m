Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 849443FDF62
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Sep 2021 18:07:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241586AbhIAQIo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Sep 2021 12:08:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234050AbhIAQIn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Sep 2021 12:08:43 -0400
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18CE7C061575
        for <linux-kernel@vger.kernel.org>; Wed,  1 Sep 2021 09:07:46 -0700 (PDT)
Received: by mail-qv1-xf2e.google.com with SMTP id z2so23904qvl.10
        for <linux-kernel@vger.kernel.org>; Wed, 01 Sep 2021 09:07:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ENgS5NCsCBTF4mXrUN4mnxvn/rv2h7hXBulk866gSRk=;
        b=hUCCyobyzgyt/MRFzTijqMgOUI5qzMd1zgeqqthZmmgaEZ13QzRtAuChF2YAwYBViL
         OwSZ0+kn5VbJDrgWQKqPTHHF+QFSQUthIa62T+cst+BeZc4frqUyqsaoQ6r2bZoeSibT
         ttQnvFKqtontOT0prIiNBo+ig80AiTewp8Sxqxo5jvmfcDH+BfCfhl/8VoSrl4I+UfIN
         UkUOEiNvGUpTjOP3JprYUaqODoJ3vCQsdOnfQPrjzzj5viJdBD+XGLvl716LSxB0dUWr
         7LSOULkdURoi9VJP2mle9GvVXI8FL/GKx/EFefDkDfKr/XP++rxCoW3J/3yz4n6iOnRL
         RJjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ENgS5NCsCBTF4mXrUN4mnxvn/rv2h7hXBulk866gSRk=;
        b=agOEX3hiJFEpBY0o5KJ1GaZXjYRdktW0qjoLr8P68rnxLM+duvS3NP+3iEgv3/KpYs
         2WSSXfSei6SpIpGh/vuiYHFmQ9+50PjnrjdrCRfcL5TM++619GfX533GwwyqqW3peYIt
         5yDP5N8ffZu+JBVVDjRG6tsdlk4l3cwEKl0PZEaS2owhctC7qX/3B7C/59okbjNW6Qb/
         vM3I0fOW2wQZRmnQDIlxJyjCJY6TUoJeRbuaRcfPxEZwX8T4W2c7e4eYCpewKtM6yj/d
         5sZmMnSjQGrz5rXITflQ5bu8SqDGrVj8L821fRrIAcuod2s+zCFtm4kxhb6sYV03jqX0
         pnXw==
X-Gm-Message-State: AOAM531B+4mAV1JJJeNyACJ1T7wWvKLeYJv2RlZ4h2SWj614oZkEdOjo
        jRbX8aMNNHeNhC0P4Ty5eGGaDw==
X-Google-Smtp-Source: ABdhPJx+hJCNSdfKSSiAqLRegfFOCASpINnQ9G2ySwHo5jZJlX3gLxTbwzYUSXoTG+CL9BzmhPqrLg==
X-Received: by 2002:a0c:e042:: with SMTP id y2mr413898qvk.21.1630512463956;
        Wed, 01 Sep 2021 09:07:43 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-113-129.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.129])
        by smtp.gmail.com with ESMTPSA id h6sm117587qtn.51.2021.09.01.09.07.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Sep 2021 09:07:43 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1mLSm7-007sE0-0B; Wed, 01 Sep 2021 13:07:43 -0300
Date:   Wed, 1 Sep 2021 13:07:42 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     David Hildenbrand <david@redhat.com>
Cc:     Qi Zheng <zhengqi.arch@bytedance.com>, akpm@linux-foundation.org,
        tglx@linutronix.de, hannes@cmpxchg.org, mhocko@kernel.org,
        vdavydov.dev@gmail.com, kirill.shutemov@linux.intel.com,
        mika.penttila@nextfour.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        songmuchun@bytedance.com
Subject: Re: [PATCH v2 0/9] Free user PTE page table pages
Message-ID: <20210901160742.GR1200268@ziepe.ca>
References: <20210819031858.98043-1-zhengqi.arch@bytedance.com>
 <5b9348fc-95fe-5be2-e9df-7c906e0c9b81@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5b9348fc-95fe-5be2-e9df-7c906e0c9b81@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 01, 2021 at 02:32:08PM +0200, David Hildenbrand wrote:
 
> b) pmd_trans_unstable_or_pte_try_get() and friends are really ugly.

I suspect the good API here is really more like:

  ptep = pte_try_map(pmdp, &pmd_value)
  if (!ptep) {
     // pmd_value is guarenteed to not be a PTE table pointer.
     if (pmd_XXX(pmd_value))
  }

Ie the core code will do whatever stuff, including the THP data race
avoidance, to either return the next level page table or the value of
a pmd that is not a enxt level page table. Callers are much clearer in
this way.

Eg this is a fairly representative sample user:

static int smaps_pte_range(pmd_t *pmd, unsigned long addr, unsigned long end,
			   struct mm_walk *walk)
{
	if (pmd_trans_unstable(pmd))
		goto out;
	pte = pte_offset_map_lock(vma->vm_mm, pmd, addr, &ptl);

And it is obviously pretty easy to integrate any refcount into
pte_try_map and pte_unmap as in my other email.

Jason
