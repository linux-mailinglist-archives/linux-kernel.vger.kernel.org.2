Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18BB63956C5
	for <lists+linux-kernel@lfdr.de>; Mon, 31 May 2021 10:19:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230320AbhEaIUl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 May 2021 04:20:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230250AbhEaIUg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 May 2021 04:20:36 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 646C6C061574
        for <linux-kernel@vger.kernel.org>; Mon, 31 May 2021 01:18:55 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id 131so13967616ljj.3
        for <linux-kernel@vger.kernel.org>; Mon, 31 May 2021 01:18:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=OVp+wPFCFyJ+KzFwSbEA0g+1392ap9nudUknWsgT4Fw=;
        b=i9aZOtW9avfIMt2gE5xSAYQKfGHn6chKwsndAAOKCsL3WDHD9F/9g3Uki7lqf4flcQ
         5eBxFBGY8YzipqXiicXV8vCIdPh6aEPrTsNr4sttn7lf4GUjQNlV0vbIg+adz6EPlpte
         aL/fe47lGw5i8onn44OiUE4S0/NycpJbfhevxtyCiMUzdlQhWJaXVF93V225msKLAqaQ
         aoGxrrrXe6R1NXZrSs6rcgwtU3JnuyNy4y2EGM7kMcce+Abgww/1VCA8sRvKUi9q7VsA
         54NoNfySu//7buDdu1a4TNh4trPbc/BS0PNkmtTbfTJxWK7TzGMpdvHl7O9a0IZR5AoT
         XqLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=OVp+wPFCFyJ+KzFwSbEA0g+1392ap9nudUknWsgT4Fw=;
        b=duW6pdkjnlMDjw113RxJWOnb+BXonbKIT2F7+nBbHAQQp+Hk2p9SFiF/lP0d5Jpi4k
         8NAHV2SZ3n1J0auUA8QdntCM1n34Iib0/Qq3+TGg5v8+J5aHjepJG4VKncot83e9/f6V
         JTdOWcqJ/DHB3frUGrg2UWWagMbZssrQyYxWwkBl7b9EkmbiVQxNsjkb4BsNvNtios4Z
         6lYs3yVFn2gat4lodxGwsttZlBcvNTNTxR9Q1Ty93tCINLdVHY3ciAmMatBZxg/XWzxZ
         ecKMT74QXDbdfiryVUu/UCM+Pn7FCDpHRog0T8NsY9n8h0uFIAJKUfCBS76OOcw5lDHc
         3EpA==
X-Gm-Message-State: AOAM530W8lqqnctdLdOT9B49q4tJwdKKcUQtzsGapqh0+R7QX4W+xQQz
        xbmMMrM0SsEvwKmFdVepRA7tBA==
X-Google-Smtp-Source: ABdhPJwieaHPWorJZ0rfE2GNJZbjRbclneCqk8ih2fHLZQ9Ig7teqHk08zcrfZYThg6rMjHRiLVuAw==
X-Received: by 2002:a2e:b04c:: with SMTP id d12mr15695403ljl.465.1622449133698;
        Mon, 31 May 2021 01:18:53 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id t14sm1261988lfk.186.2021.05.31.01.18.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 May 2021 01:18:52 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id 8E2D71027A9; Mon, 31 May 2021 11:19:02 +0300 (+03)
Date:   Mon, 31 May 2021 11:19:02 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Hugh Dickins <hughd@google.com>
Cc:     Yang Shi <shy828301@gmail.com>, willy@infradead.org,
        jhubbard@nvidia.com, kirill.shutemov@linux.intel.com,
        vbabka@suse.cz, akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] mm: dump_page: print total mapcount for compound page
Message-ID: <20210531081902.nm3lsw2lp3utrafy@box>
References: <20210528175403.4506-1-shy828301@gmail.com>
 <alpine.LSU.2.11.2105281222500.22433@eggly.anvils>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LSU.2.11.2105281222500.22433@eggly.anvils>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 28, 2021 at 12:47:31PM -0700, Hugh Dickins wrote:
> > page if possible.  But how to implement it safely seems controversial.
> > Some ideas and potential problems have been discussed by
> > https://lore.kernel.org/linux-mm/alpine.LSU.2.11.2105261733110.16920@eggly.anvils/.
> > 
> > So I prepared this patch to show a possible approach to get some
> > feedback.  The same thing could be decoded by the reader of page dump
> > as well by using the same formula used by this patch.  However it sounds
> > more convenient to have kernel do the math.
> >  
> >  mm/debug.c | 35 +++++++++++++++++++++++++++++------
> >  1 file changed, 29 insertions(+), 6 deletions(-)
> 
> Adding that code to come up with a deceptive approximation to a number
> which most sites won't care about: speaking for me, I'll say no.

I agree. The approximation may bring more confusion than help debugging.

-- 
 Kirill A. Shutemov
