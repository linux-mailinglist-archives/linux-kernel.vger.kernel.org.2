Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 036BA346FC9
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 04:03:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235001AbhCXDDN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 23:03:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232312AbhCXDDK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 23:03:10 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AB88C061763
        for <linux-kernel@vger.kernel.org>; Tue, 23 Mar 2021 20:03:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ak58R9ppaBaibHUKtsrX/8kQSpkyoQcxYj1ybi6FKGg=; b=XnVPA8W+06Gb4w5qHIAcSFjSbu
        LgG4D0IIObSiMqKNNUNIv9JA+Mf+aQxaHeSjSKnIg0jUyB4sPr8/OL5YsLBFvXeO6awA77Wc3pFKv
        sKSIvUwzlq1ETQpM7lCp1tRZ8uoNbjzuhNZL4iiURfzCdrfPSVfzoGXncw+eg7swztK0ACN2jHtWV
        V/uDgDDY4lFGN/ydCJVSrI4+OByhWOM0a1M/w9T8azFAcqEIXMVB+wkNEjylahsX24xccK/EuQU3v
        zXMPnzZp2ImBULAkZ07HH++gK25Qe9pb2VdXi4/CCnkyBkpTb4+TCS9xPXqOl1thSogfev5E+5wxh
        NeJwujJw==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lOtmq-00AqRi-HN; Wed, 24 Mar 2021 03:02:27 +0000
Date:   Wed, 24 Mar 2021 03:02:24 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Minchan Kim <minchan@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>, gregkh@linuxfoundation.org,
        surenb@google.com, joaodias@google.com, jhubbard@nvidia.com,
        digetx@gmail.com
Subject: Re: [PATCH v5] mm: cma: support sysfs
Message-ID: <20210324030224.GO1719932@casper.infradead.org>
References: <20210323195050.2577017-1-minchan@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210323195050.2577017-1-minchan@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 23, 2021 at 12:50:50PM -0700, Minchan Kim wrote:
> +	/* the number of CMA page successful allocations */
> +	atomic64_t nr_pages_succeeded;

> +void cma_sysfs_alloc_pages_count(struct cma *cma, size_t count)
> +{
> +	atomic64_add(count, &cma->nr_pages_succeeded);
> +}

I don't understand.  A size_t is a byte count.  But the variable is called
'nr_pages'.  So which is it, a byte count or a page count?

> +static ssize_t alloc_pages_success_show(struct kobject *kobj,
> +					struct kobj_attribute *attr, char *buf)
> +{
> +	struct cma_kobject *cma_kobj = container_of(kobj,
> +						    struct cma_kobject, kobj);
> +	struct cma *cma = cma_kobj->cma;
> +
> +	return sysfs_emit(buf, "%llu\n",
> +			  atomic64_read(&cma->nr_pages_succeeded));

... if it's in bytes, it should probably be reported in kilobytes
and be suffixed with a 'K' like many other stats.

