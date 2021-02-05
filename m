Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68DC2310D8F
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Feb 2021 17:04:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232448AbhBEOV6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 09:21:58 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:21435 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231470AbhBEOOr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 09:14:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612540278;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Qhf4TNEhH0EGCGCZK51EvQLn7nw/eKkkAOlVlNYf01I=;
        b=aCeEScBieGMVRV1f+t9dhMUKW+zzNXsgbNCtqEDz2v8J8brOPkiQkUa8SKyHc2wWC9w7LL
        oRt8mRbRaaRaVQUCAIqgzqqSfTrKsuxet1oZUv4ejnBicWcrZ9+uceqlkf7tQlrcwA5igM
        aoa4k+yk/x0e+Xk+cyjW83e0blViKIE=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-497-rELZijoRMcy2-P0K1Lh3IA-1; Fri, 05 Feb 2021 10:51:17 -0500
X-MC-Unique: rELZijoRMcy2-P0K1Lh3IA-1
Received: by mail-qv1-f70.google.com with SMTP id d26so5282181qve.7
        for <linux-kernel@vger.kernel.org>; Fri, 05 Feb 2021 07:51:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Qhf4TNEhH0EGCGCZK51EvQLn7nw/eKkkAOlVlNYf01I=;
        b=RiXvYOFjXEfY4UH7op53eZNyB7TlvTJhp/SL2Vuwe/B/GCH+TMciWG7xFOHdRJ4p7W
         9sohOU1IU7c+UUAxGn70vdw5ufZO5N0bNa6vlP1u4946Rxp0adL5OfTvJVxt+zFiw/mV
         7DEAlyD12w6fDUYQJji7UnKEQsG8W3eOz3qCizwEgzwDGqe1T6Y6DVjPlvpOQMeFvQrh
         QjFrqLlmK2cd+XXBvRdp9uJEq9DjttDuyXTI0KOqROyyAwjn7IunaCr/9NlLAqudujxv
         SSSPVGWaSU96hUgrkWJWa4+lbF19UYStbZpFtVCTz9Xhia2Lis8YbP9akxIB5YLAj8yp
         d6+w==
X-Gm-Message-State: AOAM530q8iGVoBFUmuSgex9YAyBzFScaGLNNsbvUE/2FSHxj7ZJQ6fe3
        Kud3RNK0v0gi4qudHRyTkc5ck3lZiLXaTL+1wY8+p1F1t+VesNqMh78gQRux2WcZk5L9vHtKF0z
        YNhdxdZ34pXNcH6U7FFXkokh0
X-Received: by 2002:a0c:b65c:: with SMTP id q28mr4984742qvf.49.1612540276660;
        Fri, 05 Feb 2021 07:51:16 -0800 (PST)
X-Google-Smtp-Source: ABdhPJx65hKAWOtradxhKRwERZJrVuxyF50k/DMuxYN6CnarSiL5rSmCDPUWP2lrSSsI8LQyC/NhLA==
X-Received: by 2002:a0c:b65c:: with SMTP id q28mr4984720qvf.49.1612540276506;
        Fri, 05 Feb 2021 07:51:16 -0800 (PST)
Received: from xz-x1 (bras-vprn-toroon474qw-lp130-20-174-93-89-182.dsl.bell.ca. [174.93.89.182])
        by smtp.gmail.com with ESMTPSA id a16sm7843159qta.69.2021.02.05.07.51.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Feb 2021 07:51:15 -0800 (PST)
Date:   Fri, 5 Feb 2021 10:51:14 -0500
From:   Peter Xu <peterx@redhat.com>
To:     "Zhang, Wei" <wzam@amazon.com>
Cc:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Kirill Shutemov <kirill@shutemov.name>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Matthew Wilcox <willy@infradead.org>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        "Pressman, Gal" <galpress@amazon.com>, Jan Kara <jack@suse.cz>,
        Jann Horn <jannh@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        David Gibson <david@gibson.dropbear.id.au>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v2 4/4] hugetlb: Do early cow when page pinned on src mm
Message-ID: <20210205155114.GY6468@xz-x1>
References: <20210204145033.136755-1-peterx@redhat.com>
 <20210204145033.136755-5-peterx@redhat.com>
 <329ADC08-552E-423B-9230-99643B81C14A@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <329ADC08-552E-423B-9230-99643B81C14A@amazon.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 05, 2021 at 02:58:33PM +0000, Zhang, Wei wrote:
> Hi Peter,

Hi, Wei,

> 
> Gal and I worked together. We tested the patch v2 and can confirm it is working as intended.
> 
> Thank you very much for your quick response!

My thanks too on the quick testing!  Sorry that I'll need to post v3; please
feel free to hold off the testing until I got some r-bs with the new version.

Thanks,

-- 
Peter Xu

