Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C2B83FCFE4
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Sep 2021 01:23:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238727AbhHaXYC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Aug 2021 19:24:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232815AbhHaXYB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Aug 2021 19:24:01 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F003C061575
        for <linux-kernel@vger.kernel.org>; Tue, 31 Aug 2021 16:23:05 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id y34so2373793lfa.8
        for <linux-kernel@vger.kernel.org>; Tue, 31 Aug 2021 16:23:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=qTGMUJ1fnMBo+Q1kt2wvOXORnThBqbNZ7LIT9ecQXE4=;
        b=mER5XiOy8koaS6tZs5Ukk1lV155l26r6AQblG/hlIf0ZFf/+gW0mM16KEMts/pyGmA
         ilRwF+Z4fobIIzSuTSpXu33eLW6jkFJniOlhjt2hbdwlxgPpimuujwWKFM2TS+HEUVN9
         LhNOezSMIVpxmqtKpJPIN904HC5vZoWULfSRKYezTueepxfIzQhdkCISGTJ1RQN+UC15
         pTtKleTC00QRxfN+DoT5bvHjGkFoaujebReNJhvEk4cSVSMMZ+anYLaUeYFwYqSfASXh
         gCVnsEMoFaU0R5rHnxOsfbyk36zn7uexsEeE6kiidqNVD3f9w+tJXYVLRdTrKFzKCqmQ
         aoQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=qTGMUJ1fnMBo+Q1kt2wvOXORnThBqbNZ7LIT9ecQXE4=;
        b=HNdHBmIPvsuIR5mkl5qZSQPQnsoEoua8jdm7XN455fwdMtCrs5kANQ7zkgWrViOFP4
         5IBP7rgTfJhhaczi9qGgkhVFe2hA8XvT0kPaNp4CNyXaDBcx03nM8iM56bEBqhais1Vd
         3Bq5wpD6loEJBQFvNTBsg+rgiuvRgn5pLT6tDMiCE2GJywxge/fYXeaBZ3CCDmIn7C9l
         wrCOsI25P+4tm5+OMX/1GU4LkKYBMYGvx2oygs8Fd/pWabUKKpP8N7ea7ThYgRNgktrU
         fYewIJiTxPq5kPGQddMguB58rmjyztHEfKqeO462UwSTBLxc0Jr3Ai4jX8eJqoTyY0gU
         55ig==
X-Gm-Message-State: AOAM533b5rqYcZIAxA2BCtLRINV1RFTB6hMD444V8GXWrBjGjcjjWpK2
        xSX5yIS1adOeB3SmTCJrQzeisA==
X-Google-Smtp-Source: ABdhPJycZ4wjWM84EJAwhegxR/lYKX5fd5MCyesH6ustBkwr//aIlTUP29jnFMcZJ7aYxNztQGRJIQ==
X-Received: by 2002:a05:6512:e99:: with SMTP id bi25mr22941004lfb.486.1630452182771;
        Tue, 31 Aug 2021 16:23:02 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id k3sm2263434lja.109.2021.08.31.16.23.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Aug 2021 16:23:01 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id B7BC9102EFE; Wed,  1 Sep 2021 02:23:01 +0300 (+03)
Date:   Wed, 1 Sep 2021 02:23:01 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Qi Zheng <zhengqi.arch@bytedance.com>
Cc:     akpm@linux-foundation.org, tglx@linutronix.de, hannes@cmpxchg.org,
        mhocko@kernel.org, vdavydov.dev@gmail.com,
        kirill.shutemov@linux.intel.com, mika.penttila@nextfour.com,
        david@redhat.com, vbabka@suse.cz, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        songmuchun@bytedance.com
Subject: Re: [PATCH v2 1/2] mm: introduce pmd_install() helper
Message-ID: <20210831232301.ilehcpc3n5bqodsz@box.shutemov.name>
References: <20210831132111.85437-1-zhengqi.arch@bytedance.com>
 <20210831132111.85437-2-zhengqi.arch@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210831132111.85437-2-zhengqi.arch@bytedance.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 31, 2021 at 09:21:10PM +0800, Qi Zheng wrote:
> Currently we have three times the same few lines repeated in the
> code. Deduplicate them by newly introduced pmd_install() helper.
> 
> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
> Reviewed-by: David Hildenbrand <david@redhat.com>
> Reviewed-by: Muchun Song <songmuchun@bytedance.com>
> ---
>  include/linux/mm.h |  1 +
>  mm/filemap.c       | 11 ++---------
>  mm/memory.c        | 34 ++++++++++++++++------------------
>  3 files changed, 19 insertions(+), 27 deletions(-)
> 
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index a3cc83d64564..0af420a7e382 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -2463,6 +2463,7 @@ static inline spinlock_t *pud_lock(struct mm_struct *mm, pud_t *pud)
>  	return ptl;
>  }
>  
> +extern void pmd_install(struct mm_struct *mm, pmd_t *pmd, pgtable_t *pte);
>  extern void __init pagecache_init(void);
>  extern void __init free_area_init_memoryless_node(int nid);
>  extern void free_initmem(void);

mm/internal.h would be a better fit for the declaration.

Otherwise:

Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

-- 
 Kirill A. Shutemov
