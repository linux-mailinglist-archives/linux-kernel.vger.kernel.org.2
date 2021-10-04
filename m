Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C96D4210EB
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Oct 2021 16:06:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233450AbhJDOIi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Oct 2021 10:08:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233312AbhJDOIg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Oct 2021 10:08:36 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51A59C061749
        for <linux-kernel@vger.kernel.org>; Mon,  4 Oct 2021 07:06:47 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id y23so32858777lfb.0
        for <linux-kernel@vger.kernel.org>; Mon, 04 Oct 2021 07:06:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=I5iiIUW34DuiTSF34m8K0qNYgofVcVIOCi6xjuMFs7U=;
        b=3kKfkFlAkxuo4h6f/0sKIcUascSJ1EjVtDaSc8mCz0mj2hiSUImHVOKBixi4ZXJ1Zh
         nf3oKrJdV0S6Pjxbj5UOnRW+JUK37P29cFNoWpwkY+ELXLvLY3QOPFyCiQplYH+7NyR/
         7KDIsN0v0grmhqRZG0V+albGTp7C+A6aWp7F/Q7Nmv1l3SbrOr/YadY2efvoa0d7RoN3
         l9YCobpIhuudY2yGYUZgUxKeH4qrJ5IZ66fthZ2U1uASotK3VM9ZQqVGVkAymap7Vt0v
         se3xf6LlY331tb9U4q7FskeOEe46Hq3Gc6YXaTeoHVyURSV5iY32K76etywNbvy/qCIv
         mQUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=I5iiIUW34DuiTSF34m8K0qNYgofVcVIOCi6xjuMFs7U=;
        b=EZBYer90aOmrDP9z2FRg/6ZmTK818GAmmVz6srB9DoaOfTemuGGXhxY4ryRGFF7Wz9
         9wCs0LpXvAlxXCzNKw0tsMWN3iZil0x+lWg9NnyJ0KxKH95UyMo/W0JzmZMwlzv83I6L
         aWHJzKzKWkOBmjJ9EWkJ8ubfiDi2YqNHkUov4EqxUJ+nwtP+Y9ZOFMqsW+CA4XMtPTU1
         E3VTPAfMAC0ystZutvNBNLwdLhSRxewLnNN1Ob6LUJaC1I+VXAd1nVpDVzjuLR1RLpNX
         yjDg13RNc6M2bmL+1ZsGgWea579SXHcO2rY8N5HErIvT+FIbe0NEbehbbVbUy3AqvJ1X
         TR4w==
X-Gm-Message-State: AOAM531ZTeDUvjzY2pB+MtsR/PWWDLBU3BAkyfy/6avptSU/yS1ewyNP
        2kL+RyRh/LHik1P2ClbIly3w7Q==
X-Google-Smtp-Source: ABdhPJykedCpqepvR4UG4/lr+U/Wj7wVzLKNTIYtri7nFzzWco7d85ytJzGv0IGm0ILetCdz5mkUEQ==
X-Received: by 2002:a19:dc5b:: with SMTP id f27mr15017676lfj.145.1633356399534;
        Mon, 04 Oct 2021 07:06:39 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id v27sm1770788lfp.0.2021.10.04.07.06.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Oct 2021 07:06:38 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id C563710306D; Mon,  4 Oct 2021 17:06:37 +0300 (+03)
Date:   Mon, 4 Oct 2021 17:06:37 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Yang Shi <shy828301@gmail.com>
Cc:     naoya.horiguchi@nec.com, hughd@google.com,
        kirill.shutemov@linux.intel.com, willy@infradead.org,
        peterx@redhat.com, osalvador@suse.de, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [v3 PATCH 2/5] mm: filemap: check if THP has hwpoisoned subpage
 for PMD page fault
Message-ID: <20211004140637.qejvenbkmrulqdno@box.shutemov.name>
References: <20210930215311.240774-1-shy828301@gmail.com>
 <20210930215311.240774-3-shy828301@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210930215311.240774-3-shy828301@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 30, 2021 at 02:53:08PM -0700, Yang Shi wrote:
> diff --git a/mm/filemap.c b/mm/filemap.c
> index dae481293b5d..2acc2b977f66 100644
> --- a/mm/filemap.c
> +++ b/mm/filemap.c
> @@ -3195,12 +3195,12 @@ static bool filemap_map_pmd(struct vm_fault *vmf, struct page *page)
>  	}
>  
>  	if (pmd_none(*vmf->pmd) && PageTransHuge(page)) {
> -	    vm_fault_t ret = do_set_pmd(vmf, page);
> -	    if (!ret) {
> -		    /* The page is mapped successfully, reference consumed. */
> -		    unlock_page(page);
> -		    return true;
> -	    }
> +		vm_fault_t ret = do_set_pmd(vmf, page);
> +		if (!ret) {
> +			/* The page is mapped successfully, reference consumed. */
> +			unlock_page(page);
> +			return true;
> +		}
>  	}
>  
>  	if (pmd_none(*vmf->pmd)) {

Hm. Is it unrelated whitespace fix?

-- 
 Kirill A. Shutemov
