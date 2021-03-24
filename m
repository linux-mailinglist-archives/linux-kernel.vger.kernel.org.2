Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78CCD347131
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 06:45:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235287AbhCXFpV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 01:45:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232940AbhCXFpR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 01:45:17 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38F08C061763
        for <linux-kernel@vger.kernel.org>; Tue, 23 Mar 2021 22:45:17 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id v3so13915099pgq.2
        for <linux-kernel@vger.kernel.org>; Tue, 23 Mar 2021 22:45:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=pK3YDZrisDgTcA/2AaWj7g0kwUq/wxiA7K4Ee2UeDHU=;
        b=imz7CzxEmupMHWBJCSBjziqXtI4nwrPVGcLYRZ6Xp6Z/w6HEbhsdSiEd+Z6AiZPqpB
         WKmR0kw94j0J8ty108744ekYmRysGdjMZ7TLkaVzTP+iXuFxmerIDQsld1z6W4MBTu4m
         SMZFQqjJzcoIB2QnhUWtf1040ry7E6xl3IplA/gn/5XJuV7Ak0h2jiRhYTCKWWtPliDl
         UJRdbOvL3Pydq+okU9ggKEOeXYembtXNy/qhWHYtBLHneOBjkx7ebFIi1rn7UW2Mhy+t
         C20kdY/hMzRI7UxNNIuAbp2kRPyItsqEqeu6R7W+AMQ8TX4bsS1mkMRnvlRQ2FmBkE4L
         R+CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=pK3YDZrisDgTcA/2AaWj7g0kwUq/wxiA7K4Ee2UeDHU=;
        b=UQJUDcxm0eH6BA4n3gDDbElWxfniPq7juoCGkvxeKQm4MPX8az91rz3WZxygbEIh4O
         EHMNqTDV7huxB5wyo8FPCuz3MEhBXMkT9XKsLJjDNbnDGgAL50B+Jh08JfTCQU8wyFWD
         YXh8+u7m/Xlc/i3T7F6AvHVYMbU+Pg4+7Et/mZBjDGRaGoYJ4vmG9g14jDaUrE5Plmmb
         nzYN9cb0Ds179BmnNxM+Lp5y+N3OUdri7cegrSo3ps3QkEEc+3YXJJNFkzDjPdbW9AYN
         rvTLuW6wU+ouLBqA9MB/waM1XZDNQ7k+3mVh0Hrbirpl4E9ihIG/zh1ljXUlayV5kdOu
         /TEA==
X-Gm-Message-State: AOAM532nBeG2nxRORq9RkK+SIxYCJJB5V7V6Q28knAe9BpVVq1QY1QGe
        S83vD/2C+9BtoyjbHIVTzOA=
X-Google-Smtp-Source: ABdhPJxbrFXmBxnqfIVsEUMeGRwhm8xx6WUL64OtwzLW8/dY+K9altNHiHQ9KTCus/vNE/IhDti8wg==
X-Received: by 2002:a63:1d5c:: with SMTP id d28mr1542016pgm.315.1616564716782;
        Tue, 23 Mar 2021 22:45:16 -0700 (PDT)
Received: from google.com ([2620:15c:211:201:7dfa:1e53:536:7976])
        by smtp.gmail.com with ESMTPSA id l10sm945741pfc.125.2021.03.23.22.45.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Mar 2021 22:45:15 -0700 (PDT)
Sender: Minchan Kim <minchan.kim@gmail.com>
Date:   Tue, 23 Mar 2021 22:45:13 -0700
From:   Minchan Kim <minchan@kernel.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>, gregkh@linuxfoundation.org,
        surenb@google.com, joaodias@google.com, jhubbard@nvidia.com,
        digetx@gmail.com
Subject: Re: [PATCH v5] mm: cma: support sysfs
Message-ID: <YFrR6TQckcuDdgeT@google.com>
References: <20210323195050.2577017-1-minchan@kernel.org>
 <20210324030224.GO1719932@casper.infradead.org>
 <YFqyk0/yXs2kMP76@google.com>
 <20210324043434.GP1719932@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210324043434.GP1719932@casper.infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 24, 2021 at 04:34:34AM +0000, Matthew Wilcox wrote:
> On Tue, Mar 23, 2021 at 08:31:31PM -0700, Minchan Kim wrote:
> > On Wed, Mar 24, 2021 at 03:02:24AM +0000, Matthew Wilcox wrote:
> > > On Tue, Mar 23, 2021 at 12:50:50PM -0700, Minchan Kim wrote:
> > > > +	/* the number of CMA page successful allocations */
> > > > +	atomic64_t nr_pages_succeeded;
> > > 
> > > > +void cma_sysfs_alloc_pages_count(struct cma *cma, size_t count)
> > > > +{
> > > > +	atomic64_add(count, &cma->nr_pages_succeeded);
> > > > +}
> > > 
> > > I don't understand.  A size_t is a byte count.  But the variable is called
> > > 'nr_pages'.  So which is it, a byte count or a page count?
> > 
> > It's page count. I followed the cma_alloc interface since it has
> > size_t count variable for nr_pages.
> 
> That's very confusing.  cma_alloc is wrong; if it needs to be an
> unsigned long, that's fine.  But it shouldn't be size_t.
> 
> 7.17 of n1256 defines:
> 
> 	size_t
> which is the unsigned integer type of the result of the sizeof operator
> 
> Do you want to submit a patch to fix cma_alloc as well?

Sure, but it will be separate patch.

> 
> > Let's go with unsigned long nr_pages:
> > void cma_sysfs_alloc_pages_count(struct cma *cma, unsigned long
> > nr_pages)
> 
> Works for me!

Thanks for review!
