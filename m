Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 328D7372298
	for <lists+linux-kernel@lfdr.de>; Mon,  3 May 2021 23:41:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229918AbhECVmQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 May 2021 17:42:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:25433 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229894AbhECVmO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 May 2021 17:42:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1620078079;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kMuIpJEdiBjBQ12iiG/AQDfkJBD+hRImjx6hu1Pa3Cs=;
        b=dkH1Xngpsh7F3K8qhq869AyTtZU1L6A1KfhxxUPHoNXutZnzdzRebe6lJrwU4FYSRoryiO
        YN7OMnhp5cwh42g9uYsmFkeLS9SNo2SwkcURrp+fnP2uNLezBd6Uzb7xYzlbMCxKXDnTJE
        iz/guJLRf4YUU40lMMtbekdbHzRo5tI=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-267--cPfwXH7OBKUnDzo1dJ8JA-1; Mon, 03 May 2021 17:41:18 -0400
X-MC-Unique: -cPfwXH7OBKUnDzo1dJ8JA-1
Received: by mail-qk1-f200.google.com with SMTP id s10-20020a05620a030ab02902e061a1661fso6169217qkm.12
        for <linux-kernel@vger.kernel.org>; Mon, 03 May 2021 14:41:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=kMuIpJEdiBjBQ12iiG/AQDfkJBD+hRImjx6hu1Pa3Cs=;
        b=OU+IBagUu+0wed5ot9N6PKkiCPZOdeMDpER1n4xHm/HcGZNnWkajoP6SXH0IGnQtXD
         Qz4C4Weriau1SbGerOU+3Xozn51Rj34rWK992x20HurKbe5gRNnI12iU1X3VfRoHSlLB
         3QI0SR3XkUsoelaFLddC24BnuyfTQcK0ZKQJfsmYm2MOxBHotKgHWDpD5tW/lyG0EEIf
         8rsibjNDXuXwjUjTiWoeadVreu3B8HFcQag6NZ2Nwl3ouAfPRBM5pGiMt6+IFNMufLkZ
         vAMvUqlwhNpf98lDRn96A5EWTrOI49PmHxrtKy9SLmzSAXcSvEvmxPG7mX0YSP+QI8Sq
         XMbg==
X-Gm-Message-State: AOAM533weob2oC40Z0D9UFaAjnG60xrGMKaaw3SrnefUS1UV8psEfvvN
        CYiQcFUaKFAKVpgpeNOfVbsWd3woFf/QPQrgXLPiRvWFuXkKzuUfjpGPUG2kPqSrFlkkW8MmyTG
        csP/PmIU2N1XWYaqMz8N/IAAw
X-Received: by 2002:a05:6214:a8b:: with SMTP id ev11mr14875763qvb.42.1620078077734;
        Mon, 03 May 2021 14:41:17 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwPK3fT4Ub0m/HBBvdYVkwXeOOIcz2fSJruHuTp9A5QoYF+XqL1ZeJdFlwiIxW/fNL1icAEow==
X-Received: by 2002:a05:6214:a8b:: with SMTP id ev11mr14875754qvb.42.1620078077569;
        Mon, 03 May 2021 14:41:17 -0700 (PDT)
Received: from t490s (bras-base-toroon474qw-grc-72-184-145-4-219.dsl.bell.ca. [184.145.4.219])
        by smtp.gmail.com with ESMTPSA id 4sm908389qtc.40.2021.05.03.14.41.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 May 2021 14:41:17 -0700 (PDT)
Date:   Mon, 3 May 2021 17:41:15 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Axel Rasmussen <axelrasmussen@google.com>
Subject: Re: [PATCH 2/2] mm/hugetlb: Fix cow where page writtable in child
Message-ID: <YJBt+61zIh9wOCaq@t490s>
References: <20210501144110.8784-1-peterx@redhat.com>
 <20210501144110.8784-3-peterx@redhat.com>
 <c69c12d6-1615-e528-37a7-4776abfc7200@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c69c12d6-1615-e528-37a7-4776abfc7200@oracle.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 03, 2021 at 01:53:03PM -0700, Mike Kravetz wrote:
> On 5/1/21 7:41 AM, Peter Xu wrote:
> > When fork() and copy hugetlb page range, we'll remember to wrprotect src pte if
> > needed, however we forget about the child!  Without it, the child will be able
> > to write to parent's pages when mapped as PROT_READ|PROT_WRITE and MAP_PRIVATE,
> > which will cause data corruption in the parent process.
> > 
> > This issue can also be exposed by "memfd_test hugetlbfs" kselftest (if it can
> > pass the F_SEAL_FUTURE_WRITE test first, though).
> > 
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> > ---
> >  mm/hugetlb.c | 2 ++
> >  1 file changed, 2 insertions(+)
> 
> Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>

Thanks!

> 
> I think we need to add, "Fixes: 4eae4efa2c29" as this is now in v5.12

I could be mistaken, but my understanding is it's broken from the most initial
cow support of hugetlbfs in 2006...  So if we want a fixes tag, maybe this?

Fixes: 1e8f889b10d8d ("[PATCH] Hugetlb: Copy on Write support")

-- 
Peter Xu

