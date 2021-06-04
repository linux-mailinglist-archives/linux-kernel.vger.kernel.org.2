Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DE8E39BC53
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Jun 2021 17:55:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231315AbhFDP5L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Jun 2021 11:57:11 -0400
Received: from mail-lj1-f176.google.com ([209.85.208.176]:42731 "EHLO
        mail-lj1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229924AbhFDP5K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jun 2021 11:57:10 -0400
Received: by mail-lj1-f176.google.com with SMTP id a4so12160192ljq.9
        for <linux-kernel@vger.kernel.org>; Fri, 04 Jun 2021 08:55:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=oFCNS8GD7XvNmkv9HevhbndY3QsLqxRxLrMyqE667So=;
        b=UbOamRQHTZORVcXzhrMn/JyMDM+zIvF6b53/bvhyd4Z6Z+1vnCWIG5EUV4KwH20QQB
         dtyHuIrAJX1kPAafBIXocSAdE57/cmfu2mW1cNn4jAR2ykCkvgFzpvPrfkFaovSXgDab
         00bqljuG+JwZrwO/9hYvcFYeel1GtYmrq34SU3fDfWS2+htGxnml5R1Hr7jMDrgVWuEN
         FipvcGl5PvEb/pukv9AEvBurqWxdSon+MWxcgF/B3QCRn1AEnuvVlXMoCOt6nBrvva85
         eyuoN4uT53nlRD2IJ5MLjbugLz1YWD/LsFyqM8wrymTHxG2v6OIpy6IQRv/nkLXtAHel
         j+Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=oFCNS8GD7XvNmkv9HevhbndY3QsLqxRxLrMyqE667So=;
        b=EONvB8CrTTdXsJg6lAaUcINwmFxCnN9sZlALevYscS6Z+TnaNd+Jxi68iB2NmhevUT
         p8R56q33GrfY88MbVxW9rFVciX0IKS/ogdZTkGrRlJ0+LkRcYjfBT7oiOb5Vs5FTZs+d
         awDxtO+8Hclq9WEDQZ7XAoEYaoutsaTS4Q4iG0i5B4pI9sSN9Q35cLcCLrSGXpC20efr
         1BQnmO2dsQYTeYQ+Vinjq6ngsnENisG/e0600uBlvQYupMUzSsYpCZBMr5ZeT2C++gPr
         XM8TWFBSZH3hitQ5hTDtiKJnK03ZtU9W4ARAwgGOvKVUecFVMs6OwdkydVnXe7O/VEgE
         Euaw==
X-Gm-Message-State: AOAM5307QA27bz0ye+Hi67TpXe6PODUV3aaqZy3C2GXVOXWTcDWihpZd
        daQPZftLQa7SrecbVuwRSJbdnw==
X-Google-Smtp-Source: ABdhPJwpjzyw/b3727kENoSPhg40Ytzl4GcMz+cvzzRZKYIuveBTVYT4ONLVB+m+zT7XDDPLSmF1zA==
X-Received: by 2002:a2e:b60d:: with SMTP id r13mr4103967ljn.220.1622822063167;
        Fri, 04 Jun 2021 08:54:23 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id v1sm646109lfq.284.2021.06.04.08.54.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Jun 2021 08:54:22 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id E0D401027A9; Fri,  4 Jun 2021 18:54:34 +0300 (+03)
Date:   Fri, 4 Jun 2021 18:54:34 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Hugh Dickins <hughd@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
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
Subject: Re: [PATCH 4/7] mm/thp: fix page_address_in_vma() on file THP tails
Message-ID: <20210604155434.uexotqaf5dmh3ygj@box.shutemov.name>
References: <alpine.LSU.2.11.2106011353270.2148@eggly.anvils>
 <alpine.LSU.2.11.2106011409390.2148@eggly.anvils>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LSU.2.11.2106011409390.2148@eggly.anvils>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 01, 2021 at 02:11:22PM -0700, Hugh Dickins wrote:
> From: Jue Wang <juew@google.com>
> 
> Anon THP tails were already supported, but memory-failure may need to use
> page_address_in_vma() on file THP tails, which its page->mapping check did
> not permit: fix it.
> 
> hughd adds: no current usage is known to hit the issue, but this does fix
> a subtle trap in a general helper: best fixed in stable sooner than later.
> 
> Fixes: 800d8c63b2e9 ("shmem: add huge pages support")
> Signed-off-by: Jue Wang <juew@google.com>
> Signed-off-by: Hugh Dickins <hughd@google.com>
> Cc: <stable@vger.kernel.org>

Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

-- 
 Kirill A. Shutemov
