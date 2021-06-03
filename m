Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D73173996C9
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Jun 2021 02:09:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229702AbhFCALk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 20:11:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:42833 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229541AbhFCALj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 20:11:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1622678994;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=v9TFuqUMq/k60JKSCAwSr1veIDdXtfQJPUfWX3pA8Mg=;
        b=Y5JQuEDa+vPaIEMrJdDKbjoBw0PVDQCsmWYVIaTviZQpHHorQVFja8HsuzAARmNd7eijw6
        2+UgeOf4AJJ5Hq6v7I4dDEhRcZ0is1DyQy9qDWL8+1ahd/twp9jDTQpBic3/WwWFYWf7Ns
        WZoYbAkbdXbbTyqvCxDLl/oZ3ylx1NQ=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-481-k4yTtMn_O1igEdWRYzoByw-1; Wed, 02 Jun 2021 20:09:53 -0400
X-MC-Unique: k4yTtMn_O1igEdWRYzoByw-1
Received: by mail-qk1-f197.google.com with SMTP id k125-20020a3788830000b02903a65618d46cso2951900qkd.3
        for <linux-kernel@vger.kernel.org>; Wed, 02 Jun 2021 17:09:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=v9TFuqUMq/k60JKSCAwSr1veIDdXtfQJPUfWX3pA8Mg=;
        b=n1plZFMgwXz021Ykfb7HUYMrkElrKsc9CCkOQ+TKjYjFIjQfrmHApDboW8rDwX/miy
         4DnTKGue7fvc4Tn2H3EnTx8yBM8aA3DfPMVZ10N2YTICqY7ru+1IdrEC6HDQsL3gqMFe
         E+TtQrkhCci9CzOLkTOdwZmcZvzHWpuIiyE7tFZax2rOjAXbwq1G5pcAHS8FEsFF0nC3
         x21QyB3DFixEYvgSw3j7tpyXkN8OLpR5iYJqZH51OelW7CB5gS4lP2sqYSqMLi98xIkg
         rqqW2TDOMIJxmpa0XlvU9mY9cOv73ldXmZHsOEdTE/jALcWI0Tr1vb2UUaNsAOIljqk/
         7vJg==
X-Gm-Message-State: AOAM530AVEv0QImyqGzTsyWuP6ynvCKeHge2xiWmzrloy1BNSUKVqyHn
        F9vnBAtbAZFpISrv0qaZJIey1HO8IPF1lDPlKpXYgU1vKWDkVZi4sY/wp/rQCPdz+6IhgWAjxbU
        bZoojtbP7w2FTt9bbCJ0curb0
X-Received: by 2002:a05:6214:258d:: with SMTP id fq13mr31503105qvb.50.1622678993183;
        Wed, 02 Jun 2021 17:09:53 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxnjibePn3UM3Ts1rkGOVCiBrTlz4+fsoM2BGTlD9eTFmcyMkdFRh9llqTC+jW08tZfXcDYPA==
X-Received: by 2002:a05:6214:258d:: with SMTP id fq13mr31503079qvb.50.1622678992928;
        Wed, 02 Jun 2021 17:09:52 -0700 (PDT)
Received: from t490s (bras-base-toroon474qw-grc-61-184-147-118-108.dsl.bell.ca. [184.147.118.108])
        by smtp.gmail.com with ESMTPSA id c12sm277980qtv.83.2021.06.02.17.09.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jun 2021 17:09:52 -0700 (PDT)
Date:   Wed, 2 Jun 2021 20:09:50 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Axel Rasmussen <axelrasmussen@google.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Hugh Dickins <hughd@google.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Jerome Glisse <jglisse@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH v3 00/27] userfaultfd-wp: Support shmem and hugetlbfs
Message-ID: <YLgdzo0wHIi5RaLj@t490s>
References: <20210527201927.29586-1-peterx@redhat.com>
 <YLeYREkg/RrNjQ7v@t490s>
 <20210602153606.93cfe1dfdaa2e11a2d863df2@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210602153606.93cfe1dfdaa2e11a2d863df2@linux-foundation.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 02, 2021 at 03:36:06PM -0700, Andrew Morton wrote:
> On Wed, 2 Jun 2021 10:40:04 -0400 Peter Xu <peterx@redhat.com> wrote:
> 
> > On Thu, May 27, 2021 at 04:19:00PM -0400, Peter Xu wrote:
> > > This is v3 of uffd-wp shmem & hugetlbfs support, which completes uffd-wp as a
> > > kernel full feature, as it only supports anonymous before this series.  It's
> > > based on latest v5.13-rc3-mmots-2021-05-25-20-12.
> > 
> > Andrew,
> > 
> > Any suggestion on how I should move on with this series?
> > 
> 
> It is large, and thinly reviewed.  I haven't seriously looked at it
> yet.  If nothing much else happens I might toss it in there for some
> additional exposure but I do think more input from other developers is
> needed before we go further.

It's just that the 1st RFC series was posted ~6 months ago and the major things
should be mostly the same since then (we've got a few patches merged; but
mostly for the sake of dependencies of other projects):

https://lore.kernel.org/lkml/20210115170907.24498-1-peterx@redhat.com/

So I start to doubt whether I should ask you for help (after bothering at least
Mike and Hugh already :), as I have very little confidence that this series
will be reviewed thoroughly in the near future if I do nothing.

But I definitely agree with you, it's still relatively large changeset with not
so much review done.  Let's keep it there for some more time, then.

Thanks,

-- 
Peter Xu

