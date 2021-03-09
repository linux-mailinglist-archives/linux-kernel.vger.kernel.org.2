Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42B8A331CE7
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Mar 2021 03:21:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230234AbhCICVV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 21:21:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230301AbhCICVH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 21:21:07 -0500
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27878C06174A
        for <linux-kernel@vger.kernel.org>; Mon,  8 Mar 2021 18:21:07 -0800 (PST)
Received: by mail-pf1-x432.google.com with SMTP id m6so8503047pfk.1
        for <linux-kernel@vger.kernel.org>; Mon, 08 Mar 2021 18:21:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=9bGq9kHaxz4ieImbA52oG7Wty2DH5Z2+L9jd9skILhQ=;
        b=Y+4R14mZu6I94rC8QSoez7DJAMGBLNDKd678iRXgTDfVAox7b7CagA4IGLgGLqDsb1
         kqKLVLzx0aqGWW14eIvbxXFjulOfwJybI/gWxaBTZToe5vZlfic8a5O4ePprOwoDZfQq
         lUxQwzwKkE441eKniwRc9xc9csfFqDKn3n0gBeEM8AFM+zOkiIgXmW9DL1jbLuO2/Pbt
         p3iS8aowU66jIht1PiKeIiSgkF0qwmwkKSyeFBDZyL6sosrDsegcHFBNZTstu+jm+MPF
         MRgt82z1LLdwDzNfP8UHgTO9a6stAdIdd/JR8B1BS7dIcmxL+kUVq8EFV1gowt9C1GZQ
         L1HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=9bGq9kHaxz4ieImbA52oG7Wty2DH5Z2+L9jd9skILhQ=;
        b=bl7owu8QMOT3dMgdzBaEcHDwwHl3fPxb7xt+eZa/OKiGqq0/ZZDLKZXzBRq13oDyH8
         qGzgqukL/wnCQ8Gf4Awr2ekjUnpX7tzjJs1hZvuFP0/d7tYmNIhTdU+mWEVauI+J/vMN
         G4vQhRTxXKKHiTdhTWpg4HPUX0Lmd2TQZSbrgtmEP+o5zAOTcLW068pWr8Pi5f+2wi2d
         8jPDgdADbjmYciNFYGDBO6c8qu+mCn0GWt3GWDuOLBZ8JFFd9Jyx583oPhAHLPrfDkcE
         VvmHNXu4UIuNFLI9cEleQ0NAqj3P/4DplqtMciCxJRiagtgTZzKQmHaSjLqILnSTtwPl
         a7gg==
X-Gm-Message-State: AOAM530rnrGfTyz6vFl9jFQ+czlop+/VwQ3t66/wgMTwIJyni1LhMa7S
        QiI3Qv2XTg+34kE0dO4vb0o=
X-Google-Smtp-Source: ABdhPJzSADszP6X8rpqEUnfBA3fu76HLyan3RFIkVdZJ4XQ3bW8pfq4FCtjHk0zsWNVmfl4SmWY4bg==
X-Received: by 2002:a63:5962:: with SMTP id j34mr22779391pgm.331.1615256466723;
        Mon, 08 Mar 2021 18:21:06 -0800 (PST)
Received: from google.com ([2620:15c:211:201:4ccc:acdd:25da:14d1])
        by smtp.gmail.com with ESMTPSA id q25sm3400915pfh.34.2021.03.08.18.21.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Mar 2021 18:21:05 -0800 (PST)
Sender: Minchan Kim <minchan.kim@gmail.com>
Date:   Mon, 8 Mar 2021 18:21:03 -0800
From:   Minchan Kim <minchan@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>,
        John Dias <joaodias@google.com>,
        Michal Hocko <mhocko@suse.com>,
        David Hildenbrand <david@redhat.com>,
        Jason Baron <jbaron@akamai.com>
Subject: Re: [PATCH v2] mm: page_alloc: dump migrate-failed pages
Message-ID: <YEbbj08NSSbd7364@google.com>
References: <20210308202047.1903802-1-minchan@kernel.org>
 <20210308162128.9b4a7d4c1576a72fd4878bdb@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210308162128.9b4a7d4c1576a72fd4878bdb@linux-foundation.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 08, 2021 at 04:21:28PM -0800, Andrew Morton wrote:
> On Mon,  8 Mar 2021 12:20:47 -0800 Minchan Kim <minchan@kernel.org> wrote:
> 
> > alloc_contig_range is usually used on cma area or movable zone.
> > It's critical if the page migration fails on those areas so
> > dump more debugging message.
> > 
> > page refcount, mapcount with page flags on dump_page are
> > helpful information to deduce the culprit. Furthermore,
> > dump_page_owner was super helpful to find long term pinner
> > who initiated the page allocation.
> > 
> > Admin could enable the dump like this(by default, disabled)
> > 
> > 	echo "func dump_migrate_failure_pages +p" > control
> > 
> > Admin could disable it.
> > 
> > 	echo "func dump_migrate_failure_pages =_" > control
> > 
> > ...
> >
> > --- a/mm/page_alloc.c
> > +++ b/mm/page_alloc.c
> > @@ -8453,6 +8453,34 @@ static unsigned long pfn_max_align_up(unsigned long pfn)
> >  				pageblock_nr_pages));
> >  }
> >  
> > +#if defined(CONFIG_DYNAMIC_DEBUG) || \
> > +	(defined(CONFIG_DYNAMIC_DEBUG_CORE) && defined(DYNAMIC_DEBUG_MODULE))
> > +static DEFINE_RATELIMIT_STATE(alloc_contig_ratelimit_state,
> > +		DEFAULT_RATELIMIT_INTERVAL, DEFAULT_RATELIMIT_BURST);
> > +int alloc_contig_ratelimit(void)
> > +{
> > +	return __ratelimit(&alloc_contig_ratelimit_state);
> > +}
> 
> Wow, that's an eyesore.  We're missing helpers in the ratelimit code. 
> Can we do something like
> 
> /* description goes here */
> #define RATELIMIT2(interval, burst)
> ({
> 	static DEFINE_RATELIMIT_STATE(_rs, interval, burst);
> 
> 	__ratelimit(_rs);
> })
> 
> #define RATELIMIT()
> 	RATELIMIT2(DEFAULT_RATELIMIT_INTERVAL, DEFAULT_RATELIMIT_BURST)
> 
> > +void dump_migrate_failure_pages(struct list_head *page_list)
> > +{
> > +	DEFINE_DYNAMIC_DEBUG_METADATA(descriptor,
> > +			"migrate failure");
> > +	if (DYNAMIC_DEBUG_BRANCH(descriptor) &&
> > +			alloc_contig_ratelimit()) {
> > +		struct page *page;
> > +
> > +		WARN(1, "failed callstack");
> > +		list_for_each_entry(page, page_list, lru)
> > +			dump_page(page, "migration failure");
> > +	}
> > +}
> 
> Then we can simply do
> 
> 	if (DYNAMIC_DEBUG_BRANCH(descriptor) && RATELIMIT())

Sounds good idea to me. There are many places to take the
benefit. However, let me leave it until we could discuss
this patch. We could clean them up as follow patch.

Thank you.
