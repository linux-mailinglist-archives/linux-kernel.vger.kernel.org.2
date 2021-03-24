Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21C09347028
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 04:32:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235104AbhCXDbv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 23:31:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235062AbhCXDbf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 23:31:35 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 385D9C061763
        for <linux-kernel@vger.kernel.org>; Tue, 23 Mar 2021 20:31:35 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id y200so16338624pfb.5
        for <linux-kernel@vger.kernel.org>; Tue, 23 Mar 2021 20:31:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=j9te7omEbpKZ/N4rlb8wG4FVpFTLsGLsOoHiGZQa/MQ=;
        b=vA5er0UpZRPIE11eaIlIxYJor2VwhaBGCYr32FNWFPKbvFjNaEM9t7yzW5jrDyT9C4
         yZv7GGnhzIAx7XnfwalWMgqfeC7lCdMUuPbEdtP2PW4Nd4pP4jjJkCts0hE9A6ctt0tY
         qq0iS4S5DGINTxLrsaqQypVEnqcbTbDnr/UBjDDVosozQvUEvl4CkJAmQ2Dm2ZMZehT8
         h7bHj8GbwY/ytrJJ3DyUnTEtR5GU1KNURGVPP70bDIXWcudWhgmfFCoqFRysV11rwJC1
         k64u0LlfiuacrdGSV+jDVhSLJ/m05dkbwpdjJBRjAB2xWESNH2omF+dE72v1DcwUpgDH
         dmlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=j9te7omEbpKZ/N4rlb8wG4FVpFTLsGLsOoHiGZQa/MQ=;
        b=eGJUJlR78cH09x5AfeEP3DdnN7hmiiJgue/8CxSFgOeIS4x0ZaEWjWmJk49UTF960/
         0afD+2Rpbu4gRDqohly1/pUYYYJdU25wD1pwdN16vklJKfAMSexMPcXpRHDtFgz9FHzk
         VFv5x/vT4HI1cmEPdAYrRXb3XMSNUu5clZv5DIZ7ZRaJ4Pd8QlwPN9h8JNC2C+8/wo9B
         5m/ld8h+lW5P+MDuwEfgnzPDMnzCn7hqYCXbt/rT4pwNCZu1JWQQUrB715zEdggjLdpc
         E8mkPgs+CN6HSI7rSXFOnHiGeK6NsXRTR+hXUMfGniP1Qa3OnN/8/hH0Rv/j7J7qUFwv
         J9mg==
X-Gm-Message-State: AOAM532ymTi5DboFVewJj8lRS3CCaN5AS2XOS4keITp79iahHNNtjypM
        Vv18bphmB8Q4GG3IwtBFcW8=
X-Google-Smtp-Source: ABdhPJxMn7EGa6KEQcrL6Cy9awi9U1hljgaVowP+kN5H7zJTo4qA5jMFFERacDq6VlECDstvXx3t9Q==
X-Received: by 2002:a62:7b83:0:b029:1f1:5ef3:b4d9 with SMTP id w125-20020a627b830000b02901f15ef3b4d9mr1274163pfc.65.1616556694767;
        Tue, 23 Mar 2021 20:31:34 -0700 (PDT)
Received: from google.com ([2620:15c:211:201:7dfa:1e53:536:7976])
        by smtp.gmail.com with ESMTPSA id 143sm571513pfx.144.2021.03.23.20.31.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Mar 2021 20:31:33 -0700 (PDT)
Sender: Minchan Kim <minchan.kim@gmail.com>
Date:   Tue, 23 Mar 2021 20:31:31 -0700
From:   Minchan Kim <minchan@kernel.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>, gregkh@linuxfoundation.org,
        surenb@google.com, joaodias@google.com, jhubbard@nvidia.com,
        digetx@gmail.com
Subject: Re: [PATCH v5] mm: cma: support sysfs
Message-ID: <YFqyk0/yXs2kMP76@google.com>
References: <20210323195050.2577017-1-minchan@kernel.org>
 <20210324030224.GO1719932@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210324030224.GO1719932@casper.infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 24, 2021 at 03:02:24AM +0000, Matthew Wilcox wrote:
> On Tue, Mar 23, 2021 at 12:50:50PM -0700, Minchan Kim wrote:
> > +	/* the number of CMA page successful allocations */
> > +	atomic64_t nr_pages_succeeded;
> 
> > +void cma_sysfs_alloc_pages_count(struct cma *cma, size_t count)
> > +{
> > +	atomic64_add(count, &cma->nr_pages_succeeded);
> > +}
> 
> I don't understand.  A size_t is a byte count.  But the variable is called
> 'nr_pages'.  So which is it, a byte count or a page count?

It's page count. I followed the cma_alloc interface since it has
size_t count variable for nr_pages.

Let's go with unsigned long nr_pages:
void cma_sysfs_alloc_pages_count(struct cma *cma, unsigned long
nr_pages)

> 
> > +static ssize_t alloc_pages_success_show(struct kobject *kobj,
> > +					struct kobj_attribute *attr, char *buf)
> > +{
> > +	struct cma_kobject *cma_kobj = container_of(kobj,
> > +						    struct cma_kobject, kobj);
> > +	struct cma *cma = cma_kobj->cma;
> > +
> > +	return sysfs_emit(buf, "%llu\n",
> > +			  atomic64_read(&cma->nr_pages_succeeded));
> 
> ... if it's in bytes, it should probably be reported in kilobytes
> and be suffixed with a 'K' like many other stats.
> 
