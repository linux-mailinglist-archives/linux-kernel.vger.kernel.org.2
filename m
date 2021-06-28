Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B2703B5E57
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jun 2021 14:46:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232996AbhF1MtF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Jun 2021 08:49:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232566AbhF1MtC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jun 2021 08:49:02 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7368C061574
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jun 2021 05:46:36 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id a18so10196829lfs.10
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jun 2021 05:46:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=bE94dkEiagNN+9+kFZlZw382SA94vUnxjwE0fje0Xk0=;
        b=Ht6Gea2SfQjaOGwZUSX+vM/eLTPlMEdb/841pVZfh+X68ssJ1KJDHcIP4x+pWOYZPj
         t507EHUiwc06CyBU/9L/T/wwPHRyOJKOMbq7acJb03LCk6Fu7c98WPFUiyYL9dcjes/O
         kR7VdZUEuquwEjystBKf8BJr/j1YtBuj4S+DbiOcsrqJiOyonmBQL03PDuKJzgzMjZnx
         sRjoeMZxy0tu9vK291N7BDHMWi/7Mxlw1wjnOaIUg41nDmWg7TZaPL/7OZf24MSsdWKm
         OUo1EtZQKY2OcT5a6oEKfexbrIFtzp5kIUpdQOQ04a+MWXtGOya3iCUPJ40pkYBjfhaV
         IwAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=bE94dkEiagNN+9+kFZlZw382SA94vUnxjwE0fje0Xk0=;
        b=uBi8JESdrPd6jAM7zqzuX8AakNTbQgrVeXixQNZ574k2nAGJcEK29o5KclptVOnQSp
         afbtGtCt9pK5eDXaXSn4P0NGh2tNzOBe8l9EYZYRCwLhSBp23Zzf3yWtBTwRZDW5qF64
         xJjb+qhISUxn0DejMafvR7Esgq1+Kn2ewRH1FctkOEfVXhVepoISFsgRFPt0Icv1nfkJ
         6zHpeA7v1aY7Iqq9NEyRwLRSLLagom1QBgyfETmGqbXKrzweBjc2MLXJyQz6lpzQy8ZK
         cMlkWsPg8v0EmHe4hrOnkXuABorQH3Iz1NJ+W1SmW8FuYCn24fv+Fu1W54qP20+AD6ZE
         8Qlg==
X-Gm-Message-State: AOAM532dolAO00oksFh1YW9CZ3Umz/UltC7mwPLu6Qn2skwRvL9PZ/Pd
        4sJVpwP30ucZR1Up3O9AnMwwjA==
X-Google-Smtp-Source: ABdhPJx3x4IfClwhHCvXuiTmI3sq3nF9lEkNhcJjaCr83013VKYnGJ8cEjohV6J5iX9lASPr1gWtVA==
X-Received: by 2002:a05:6512:138a:: with SMTP id p10mr18835229lfa.505.1624884395244;
        Mon, 28 Jun 2021 05:46:35 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id q23sm1219833lfe.170.2021.06.28.05.46.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Jun 2021 05:46:34 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id E241710280E; Mon, 28 Jun 2021 15:46:33 +0300 (+03)
Date:   Mon, 28 Jun 2021 15:46:33 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     akpm@linux-foundation.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Vlastimil Babka <vbabka@suse.cz>,
        William Kucharski <william.kucharski@oracle.com>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v12 24/33] mm/swap: Add folio_rotate_reclaimable()
Message-ID: <20210628124633.vlckysu3zvvkyy4v@box.shutemov.name>
References: <20210622114118.3388190-1-willy@infradead.org>
 <20210622114118.3388190-25-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210622114118.3388190-25-willy@infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 22, 2021 at 12:41:09PM +0100, Matthew Wilcox (Oracle) wrote:
> Convert rotate_reclaimable_page() to folio_rotate_reclaimable().  This
> eliminates all five of the calls to compound_head() in this function,
> saving 75 bytes at the cost of adding 15 bytes to its one caller,
> end_page_writeback().  We also save 36 bytes from pagevec_move_tail_fn()
> due to using folios there.  Net 96 bytes savings.
> 
> Also move its declaration to mm/internal.h as it's only used by filemap.c.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Acked-by: Vlastimil Babka <vbabka@suse.cz>
> Reviewed-by: William Kucharski <william.kucharski@oracle.com>
> Reviewed-by: Christoph Hellwig <hch@lst.de>

Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

-- 
 Kirill A. Shutemov
