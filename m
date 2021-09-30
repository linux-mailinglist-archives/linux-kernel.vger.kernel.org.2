Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BBF941DF8A
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Sep 2021 18:49:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352366AbhI3QvS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Sep 2021 12:51:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352360AbhI3QvR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Sep 2021 12:51:17 -0400
Received: from mail-oo1-xc33.google.com (mail-oo1-xc33.google.com [IPv6:2607:f8b0:4864:20::c33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DA4DC06176A
        for <linux-kernel@vger.kernel.org>; Thu, 30 Sep 2021 09:49:34 -0700 (PDT)
Received: by mail-oo1-xc33.google.com with SMTP id k11-20020a4abd8b000000b002b5c622a4ddso2051339oop.1
        for <linux-kernel@vger.kernel.org>; Thu, 30 Sep 2021 09:49:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=44d3gnYmT27t8uddNQ3yxOlO4++yDknbqHA9EiC9gdY=;
        b=cLouT4HFtWsCwPY2St5rtRgkF3AAxwYH1AEm5cF99lFjEFxfBHV7Q8JzRtKmP4I2o6
         0rt19x9uuZEQE9ukIb9twZ4KeyaWeQvLid56QeSrHhhJqZrNjGs9/4cL44+dMsHOjpDZ
         Nf6l+Hhd92pQm0NRYhsy1Z/SMT6gMjexCX4U53tZ7NbDS+Dwzt64R3D7DdozbRwRXWzw
         9vpwTH0SJz5RCqXwwq0cf2pGvCSJWy1WDoG8FtPTCMFW5lmozRqTypNDlu5tOtoQFG8A
         Ol07nV9IS3mhcGc1LPkrQmAdaTKj9xBq5rkFTzTzkCR9K7rzeqHFDxrbcVNw8oJMFbzm
         Pc2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=44d3gnYmT27t8uddNQ3yxOlO4++yDknbqHA9EiC9gdY=;
        b=KeW4m4Bs3wqOvh9Yt7wWTi1YRcJppxFICdgyYiSiEQyg5QOrg/h9tIg3seZohufNBr
         /epCxl7MMQJSC956E+ckjDbM/rR/5LDgjfUfPP/xMqTtblnAb2g5UT+Fz2JHPmITSUpP
         4CGtqKxpEpKwvV4O0XwYcY2RXXBSaE92BVsIYs5NnOkHIPkgyp7YWau71Qj7nv7Chvqq
         7NbR5xcvBTPsG2b9Cg6y/e5RxgUu25IIidk3RGwaOOv2oLHHXcSSgQE+CvghiCpO8fm6
         LBB+Ox72VU/MshZNRT2Pa7Z+H2xo+eAvCO3SF7ogN1x+xEKb+N6E1VFvBGPOVVxw2hFW
         f26A==
X-Gm-Message-State: AOAM532O4eBtbUzo/Vh21asEGafpjADL9uZNmpkY779onk/jKOclnKTw
        KIwj+yI4kJEPZzzX9nf+jKf9kgpEk2kaAQ==
X-Google-Smtp-Source: ABdhPJxz0iVgkHdi/uoTIH21qWRPOPxzc+ZHokNo8Bv/sOITJWR/nWR3POSxzfc5/PY3hg/CGIO7wA==
X-Received: by 2002:a05:6820:512:: with SMTP id m18mr5776292ooj.48.1633020573699;
        Thu, 30 Sep 2021 09:49:33 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id x62sm664859oig.24.2021.09.30.09.49.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Sep 2021 09:49:33 -0700 (PDT)
Date:   Thu, 30 Sep 2021 09:49:21 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.anvils
To:     Matthew Wilcox <willy@infradead.org>
cc:     Hugh Dickins <hughd@google.com>, Song Liu <song@kernel.org>,
        Rongwei Wang <rongwei.wang@linux.alibaba.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        William Kucharski <william.kucharski@oracle.com>
Subject: Re: [PATCH v2 1/2] mm, thp: check page mapping when truncating page
 cache
In-Reply-To: <YVXXq0ssvW6P525J@casper.infradead.org>
Message-ID: <f889db88-7b7d-ddb0-a7ed-3eda85d3eb96@google.com>
References: <CAPhsuW4cP4qV2c_wXP89-2fa+mALv-uEe+Qdqr_MD3Ptw03Wng@mail.gmail.com> <68737431-01d2-e6e3-5131-7d7c731e49ae@linux.alibaba.com> <CAPhsuW4x2UzMLwZyioWH4dXqrYwNT-XKgzvrm+6YeWk9EgQmCQ@mail.gmail.com> <dde441c4-febe-cfa1-7729-b405fa331a4e@linux.alibaba.com>
 <CAPhsuW5FONP=1rPh0oPLHsehjfGSDQWn8hKH4v=azdd=+WK2sA@mail.gmail.com> <YVSopxYWegtQJ3iD@casper.infradead.org> <CAPhsuW6_2_LxQRrs7xF3omgO22+6goDR=bEjKGRopaS-pHJB2Q@mail.gmail.com> <67906bf5-4de9-8433-3d70-cc8fc5cc2347@linux.alibaba.com>
 <CAPhsuW4_-ju9QgB7J4imrhQvH6ZqoOkVtVOVX11Yk_ZRakwQ+A@mail.gmail.com> <3d264ed9-f8fd-60d4-7125-f9f745ebeb52@google.com> <YVXXq0ssvW6P525J@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 30 Sep 2021, Matthew Wilcox wrote:
> On Wed, Sep 29, 2021 at 10:24:44PM -0700, Hugh Dickins wrote:
> > 
> > Aside from the above page->index mischeck in find_lock_entries(),
> > I now think this bug needs nothing more than simply removing the
> > VM_BUG_ON_PAGE(PageTail(page), page) from truncate_inode_page().
> 
> I don't think that's right.  This bug was also observed when calling
> truncate(), so there's clearly a situation where two concurrent calls
> to truncate_pagecache() leaves a THP in the cache.

I assume you're thinking of one of the fuzzer blkdev ones:
https://lore.kernel.org/linux-mm/CACkBjsbtF_peC7N_4mRfHML_BeiPe+O9DahTfr84puSG_J9rcQ@mail.gmail.com/
or
https://lore.kernel.org/lkml/CACkBjsYwLYLRmX8GpsDpMthagWOjWWrNxqY6ZLNQVr6yx+f5vA@mail.gmail.com/

I haven't started on those ones yet: yes, I imagine one or both of those
will need a further fix (S_ISREG() check somewhere if we're lucky; but
could well be nastier); but for the bug in this thread, I expect
removing the VM_BUG_ON_PAGE(PageTail) to be enough.

If you're thinking of something else, please send a link if you can - thanks.

Hugh
