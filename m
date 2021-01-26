Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6CD730500A
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 04:42:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236800AbhA0Dm2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 22:42:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728373AbhAZWP0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 17:15:26 -0500
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F6D5C061573
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jan 2021 14:14:43 -0800 (PST)
Received: by mail-io1-xd31.google.com with SMTP id u17so37054504iow.1
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jan 2021 14:14:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Ekn1N2bwuzZRoWAtKJs99FQ8E0MbiDKLziersW7caRE=;
        b=IVxDhTJujLfkfoIIHKc5PJhCnxU1zxb6K0BO2zVXx3XO2okWVsdslArZoUQ/Bs3yFl
         6RS2cJemdD1ghGFEvfhtopOsBrcSQld/kZQ5U29amm+fUc4KihggM+sNuwH8+bF0neHi
         mzmTnTV9tUz+N/WtcT5IaAm3S9619FGUvdyQdn7w/8QfYhYAnf9maE/fdwqlDFoYpmjM
         uvW1vYLZZfzVCQBUXpf34KAVPNjYJNJTDXDgaAhFAdicE3YE8uT9V8Aztn+YPawfHaeP
         wt8f8ImLqz2aILOjIB/YSeWgvQATSGm/iOKAXoyK69R7JhXmPkjiMlwlghLvMKUYjaWj
         6u6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Ekn1N2bwuzZRoWAtKJs99FQ8E0MbiDKLziersW7caRE=;
        b=GS1lda7QdUi24YpYqdmZeMyK3+tVzoCMlJded48VgudX32MjBviWjVCjFGlX5wxSXP
         R1RUta6eNe95JJsBLrrf0oboR//CWlhqHoABP+YlhLhlBYUhNc26DP0fuIWRV/iUVaeU
         bs6zuNF0Ed2OUdW6cKyjauSOQcZ5aIrFBP0Bm9+rHebAapGm5dKes49tBbdUF+zc0nEY
         E8wn71OgLMyvmHmg56HWH8/J7KNDXHTNIQqrZgGPSU+zvPcr9FUtEje+RTDdK9nGEATh
         9yIdmBdlAEaTTuP/yiQ5cqzkrCH6vyBeeS0TX1tJF6de2nRPhiA6xQ/zkOPeYGJbA4hQ
         Wpdg==
X-Gm-Message-State: AOAM530CazTnvqWyGEyXD95ktJ0je5k4X2ONYoW6wHyp/byzwSpa+yaG
        3BKP+3PzKj42uad8U7CkIlxPmg==
X-Google-Smtp-Source: ABdhPJx9Qh13rzQgMYKQ04fWd8ka0XyNGIEtj7npA85zTJkIxdNfE0dZentJ6fMXENctTjswu/i+Mw==
X-Received: by 2002:a05:6e02:1b8b:: with SMTP id h11mr6409894ili.32.1611699282533;
        Tue, 26 Jan 2021 14:14:42 -0800 (PST)
Received: from google.com ([2620:15c:183:200:697e:4b38:5872:adfe])
        by smtp.gmail.com with ESMTPSA id e9sm13859463ilc.73.2021.01.26.14.14.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Jan 2021 14:14:41 -0800 (PST)
Date:   Tue, 26 Jan 2021 15:14:38 -0700
From:   Yu Zhao <yuzhao@google.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        Alex Shi <alex.shi@linux.alibaba.com>,
        Michal Hocko <mhocko@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Roman Gushchin <guro@fb.com>, Vlastimil Babka <vbabka@suse.cz>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 03/10] mm: don't pass "enum lru_list" to lru list
 addition functions
Message-ID: <YBCUTinnVrlVVm6n@google.com>
References: <20210122220600.906146-1-yuzhao@google.com>
 <20210122220600.906146-4-yuzhao@google.com>
 <20210126220111.GO308988@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210126220111.GO308988@casper.infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 26, 2021 at 10:01:11PM +0000, Matthew Wilcox wrote:
> On Fri, Jan 22, 2021 at 03:05:53PM -0700, Yu Zhao wrote:
> > +++ b/mm/swap.c
> > @@ -231,7 +231,7 @@ static void pagevec_move_tail_fn(struct page *page, struct lruvec *lruvec)
> >  	if (!PageUnevictable(page)) {
> >  		del_page_from_lru_list(page, lruvec, page_lru(page));
> >  		ClearPageActive(page);
> > -		add_page_to_lru_list_tail(page, lruvec, page_lru(page));
> > +		add_page_to_lru_list_tail(page, lruvec);
> >  		__count_vm_events(PGROTATED, thp_nr_pages(page));
> >  	}
> 
> Is it profitable to do ...
> 
> -		del_page_from_lru_list(page, lruvec, page_lru(page));
> +		enum lru_list lru = page_lru(page);
> +		del_page_from_lru_list(page, lruvec, lru);
> 		ClearPageActive(page);
> -		add_page_to_lru_list_tail(page, lruvec, page_lru(page));
> +		lru &= ~LRU_ACTIVE;
> +		add_page_to_lru_list_tail(page, lruvec, lru);

Ok, now we want to trade readability for size. Sure, I'll see how
much we could squeeze.
