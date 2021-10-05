Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36C90422B43
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 16:41:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235175AbhJEOmu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Oct 2021 10:42:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:22797 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234084AbhJEOmt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Oct 2021 10:42:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1633444858;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wzU/i4Pg+46qgDCgZNJOC2Q5GF1N36X0X0hspBjPG1E=;
        b=LLWBuOCyUtI0SbhTXUVjoTpBIHsTyoFefhrOybKTuqOOrPukW6mvYXTMKmM7uxDLkCHgu4
        tcXcQT9iPAG5XLaFFKJJP5WYf2Y0ka8+cBMy6Vua78B6Jsad4LMQL3qw06n/wGBpecRAgS
        lqTowjZAMUHqwE0tJoM1vEhVjlYUQqI=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-338-0uRaLsIuNNG3Dmd5EsTCAg-1; Tue, 05 Oct 2021 10:40:57 -0400
X-MC-Unique: 0uRaLsIuNNG3Dmd5EsTCAg-1
Received: by mail-qv1-f72.google.com with SMTP id z6-20020a056214060600b0037a3f6bd9abso21386472qvw.3
        for <linux-kernel@vger.kernel.org>; Tue, 05 Oct 2021 07:40:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=wzU/i4Pg+46qgDCgZNJOC2Q5GF1N36X0X0hspBjPG1E=;
        b=UZxzYL69h0Drcv3d4MPY3atcnL2ZJl2yJzxyukadeascR6b/w3UtJ5m3GnXvujHIXJ
         rr3lf1eeTU33pVRtXDHG6RW887rIGywoLz+q0HQDefIowuOGeeeEx0atiIHrHSkVI+P6
         3Tb5uRQRs0BCnNjtWBuBcuYaMZsrLEyU+SmKGBISH/vLhJZbp8MnEuH0jI9qAtsN/0cd
         pESvPT38KUzQ3Gtlu9CgO4tBvqZH+sLTNB04aC9YtK8lgSVfVr0nDrKSxfOA/fPb4SVv
         dEJjybsS+qRMxX4dDCAbPeB8qm6ee7qRU7GxH5PWlmc/YUH1KtGzFWFuhkuHVSO4jH3d
         PBnQ==
X-Gm-Message-State: AOAM533TXV1h1+KhERZT77i1a0/EJn7pcjZJvElSdkTNJY4ievE26htS
        x0DNayGJSj4wvRTCYGz0XbBT78/GYMQhg5v3va99Xu4Fsx0pqtRB8KtBcR2mPX2qzSiIknJel/c
        JRIOWUkumdqrzWut2whikpZPQ
X-Received: by 2002:ac8:12:: with SMTP id a18mr19699739qtg.157.1633444853046;
        Tue, 05 Oct 2021 07:40:53 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy+t2B4lIEFPAbmTXO3075yF8VAAPnvFzGUfF6eQo+6mowEgcIC92iA+n3CUeM44w62NVx2MQ==
X-Received: by 2002:ac8:12:: with SMTP id a18mr19699434qtg.157.1633444849664;
        Tue, 05 Oct 2021 07:40:49 -0700 (PDT)
Received: from t490s ([2607:fea8:56a2:9100::bed8])
        by smtp.gmail.com with ESMTPSA id m5sm11623756qtk.88.2021.10.05.07.40.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Oct 2021 07:40:48 -0700 (PDT)
Date:   Tue, 5 Oct 2021 10:40:47 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH 3/3] mm/smaps: Simplify shmem handling of pte holes
Message-ID: <YVxj753GsZB/m7/J@t490s>
References: <20210917164756.8586-1-peterx@redhat.com>
 <20210917164756.8586-4-peterx@redhat.com>
 <4bcf5e1d-cd86-319a-889f-782755955e04@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4bcf5e1d-cd86-319a-889f-782755955e04@suse.cz>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Vlastimil,

On Tue, Oct 05, 2021 at 01:15:05PM +0200, Vlastimil Babka wrote:
> > Since at it, use the pte_hole() helper rather than dup the page cache lookup.
> 
> pte_hole() is for checking a range and we are calling it for single page,
> isnt't that causing larger overhead in the end? There's xarray involved, so
> maybe Matthew will know best.

Per my understanding, pte_hole() calls xas_load() too at last, just like the
old code; it's just that the xas_for_each() of shmem_partial_swap_usage() will
only run one iteration, iiuc.

> 
> > Still keep the CONFIG_SHMEM part so the code can be optimized to nop for !SHMEM.
> > 
> > There will be a very slight functional change in smaps_pte_entry(), that for
> > !SHMEM we'll return early for pte_none (before checking page==NULL), but that's
> > even nicer.
> 
> I don't think this is true, 'unlikely(IS_ENABLED(CONFIG_SHMEM))' will be a
> compile-time constant false and shortcut the rest of the 'if' evaluation
> thus there will be no page check? Or I misunderstood.

The page check I was referring is this one in smaps_pte_entry():

	if (!page)
		return;

After the change, with !SHMEM the "else" block will be kept there (unlike the
old code as you mentioned it'll be optimized), the smaps_pte_hole_lookup() will
be noop so it'll be a direct "return" in that "else", then it should return a
bit earlier by not checking "!page" (because in that case pte_none must have
page==NULL).

Thanks,

-- 
Peter Xu

