Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DEFA339C394
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Jun 2021 00:56:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231634AbhFDW6k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Jun 2021 18:58:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229774AbhFDW6h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jun 2021 18:58:37 -0400
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0B6CC061766
        for <linux-kernel@vger.kernel.org>; Fri,  4 Jun 2021 15:56:34 -0700 (PDT)
Received: by mail-ot1-x32c.google.com with SMTP id 36-20020a9d0ba70000b02902e0a0a8fe36so10624601oth.8
        for <linux-kernel@vger.kernel.org>; Fri, 04 Jun 2021 15:56:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=FnDgNE0dNPabtyI2dYZ3+dwe3uiezt6oBtZnVyRVbsQ=;
        b=MQrZjxjqB5TDz728+SZ0yR/naRwzsabVP2EXRIkN2Zs7e16978UTsfwBApajfC+xPp
         n5ul3MCgEuJFtFU7HYB3akUFtvJRvJbgS1WKWG60trstmkkhRZDfkiQQJgN1KeXQqWrn
         atgYQO04bvYwHKAoL7fsi2eYlk+ztYQvag7/2glGbYKipekToTVethwSMqi068uBL/6+
         45cYLIuvZGvEcLSXu+LbzWy4nyrQWGX1POSoCjeHfnNZIkeVvKBBvWMhPtMOb68lfzUg
         8SLiIdVazXxzOWRpfBxSbDKzLHaA03qffpQwVdfwPzCqCdoIcZQtpWdZ9ZcXJKzvDSv5
         NDmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=FnDgNE0dNPabtyI2dYZ3+dwe3uiezt6oBtZnVyRVbsQ=;
        b=MFSebPAJdcD5Phrn8QwevT+2DXnD8vqXgKeiNecJXKIIZiMc3v6WrD4l+RKzl79aZF
         qdxEMrB8hLOnznv0k6+WrRr9MYlplT0px4Ns3d/Tp5csG9HyITHLRJUSs4aaDekfkeMu
         MBV99rP8A6kGendYonfjV2MUZy/zu2mOmZ+C1SRz5GaylHXgWH5lDyPpJHX2taAnz/iG
         /f2ZwLowCRE9YP2gDiGtRAddhI04V4TzDzRJuvn1L2ENXWl8GSKQ2g4kt10xDZ6qPr2Y
         /S+gmKnEgB+FqqAfHctP7s3id5Rppl8C/qiSoMVk9okPmTsFfn/rZVAfSQseVQBHTQt3
         sNwA==
X-Gm-Message-State: AOAM533uXT3opDiOk2Ef0dpc2O6fE0VXKB0bjbQcZuNnrnn6pnabLD5F
        RIMU/gjOjq/b2ZzCf2JpFL5GTg==
X-Google-Smtp-Source: ABdhPJzMEzghsOQ2vwyvqjWVbjIXAPm0Cm9XFlmIQcMrzFInGYUjbU5pZxzeDf48tVMz8LWAIFMxOA==
X-Received: by 2002:a05:6830:400b:: with SMTP id h11mr5623567ots.106.1622847394005;
        Fri, 04 Jun 2021 15:56:34 -0700 (PDT)
Received: from eggly.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id f21sm741088oou.24.2021.06.04.15.56.32
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Fri, 04 Jun 2021 15:56:33 -0700 (PDT)
Date:   Fri, 4 Jun 2021 15:56:31 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@eggly.anvils
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
cc:     Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Yang Shi <shy828301@gmail.com>,
        Wang Yugui <wangyugui@e16-tech.com>,
        Matthew Wilcox <willy@infradead.org>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        Alistair Popple <apopple@nvidia.com>,
        Ralph Campbell <rcampbell@nvidia.com>, Zi Yan <ziy@nvidia.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Minchan Kim <minchan@kernel.org>, Jue Wang <juew@google.com>,
        Peter Xu <peterx@redhat.com>, Jan Kara <jack@suse.cz>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/7] mm/thp: fix page_vma_mapped_walk() if huge page
 mapped by ptes
In-Reply-To: <20210604162402.iclcdd3ywynkoamy@box.shutemov.name>
Message-ID: <alpine.LSU.2.11.2106041536340.14037@eggly.anvils>
References: <alpine.LSU.2.11.2106011353270.2148@eggly.anvils> <alpine.LSU.2.11.2106011411290.2148@eggly.anvils> <20210604162402.iclcdd3ywynkoamy@box.shutemov.name>
User-Agent: Alpine 2.11 (LSU 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 4 Jun 2021, Kirill A. Shutemov wrote:
> On Tue, Jun 01, 2021 at 02:13:21PM -0700, Hugh Dickins wrote:
> > 
> > Merged various other minor fixes and cleanups into page_vma_mapped_walk()
> > as I worked on it: which I find much easier to enumerate here than to
> > prise apart into separate commits.
> 
> But it makes it harder to review...
> 
> I tried to review it and superficially it looks good, but it has to be
> split into bunch of patches.

I had hoped to avoid that.  Okay, I'll try bisecting it into a
preliminary cleanup patch then the bugfix patch, and see if that
looks reviewable; divide it up further if not.  But my idea of
what's reviewable may differ.

Hugh
