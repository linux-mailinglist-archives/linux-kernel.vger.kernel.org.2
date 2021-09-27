Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43B5541918B
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Sep 2021 11:31:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233716AbhI0Jcs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Sep 2021 05:32:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233699AbhI0Jcn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Sep 2021 05:32:43 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45726C061575
        for <linux-kernel@vger.kernel.org>; Mon, 27 Sep 2021 02:31:06 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id g41so74426061lfv.1
        for <linux-kernel@vger.kernel.org>; Mon, 27 Sep 2021 02:31:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=tGZj9UfzMOvrlmJlZWhVCYko1Gj7jAZ5QKpn2O8GHnQ=;
        b=fH7ElhPz/j0dkKN0IQlRwL6IKNF50qPdlSMdP3FrEeL1cT4duKYSrOaeKFQE5tK8MH
         NKI948ew/JhYYQ+jjF5z0G1HI1dHwAWv2H4R4LPPB9e0kyWGUgdsuD0ZPeeKEnzbihqn
         kd+XgcA0my6muCpI2/S1tm/wco+vpwCQvlNfb26uFYxFICWUZQaWLHxD//8pnErb+XHa
         wX4XqByN7PkBbMUXlZidhCn5rssyvGK3qzWxHqaHJ5Hh10vwDQzFtD01sJCxUdUotmsR
         ptOLfSNmuocRCfcbmwyvq3+nlmZ3ASxRX8qAkaNw2ZxHQUQIRevcyWlZYqXHR9ZTKBJH
         xnJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=tGZj9UfzMOvrlmJlZWhVCYko1Gj7jAZ5QKpn2O8GHnQ=;
        b=0IWrHQQBRU7zXxsHjPxzrNn86HBjkasmXMAFOnam6pDQPqf/CcGppqiJKwv/j7OWH8
         oglTa0Pm0jVUp+C8gdxR9VHgN2P7Vbj2RxvbyZbNxdszPWFbyp/dpINAiYgUrmSuT4Qr
         hriTckGIAd7QySWkAZoZbHG4cc7n/d0849vvez8Iu9dyHDusPzKMDHbeQeiE8rkw3/wj
         QNOJrQZZIP7LcQk5o84Kih6Hb1NS72kSRYHYG/TaVSRGsHeUUdk+be4Y8rfwJfw6kNkV
         /foIPaLZWtkGgPVwpDruaoP0B2vJAxFTX6nLutYzQmgr+R5tjK4WPeqdDcOq6jE6YRid
         0pLQ==
X-Gm-Message-State: AOAM532yNy73s/JyNd4dIbbP0LvAmJRXriAO9ZMwyxc7Wej8P487p8d9
        PE+ymAUyErCUeqa5mymAUzuz7A==
X-Google-Smtp-Source: ABdhPJyZTPI/P8FivbJz92AxtI5RRIDNYzf9SMmh9JOwXEWai1lvhn8xX3PqLTWDDMSVbdhS3dZcNA==
X-Received: by 2002:a05:651c:21b:: with SMTP id y27mr27606230ljn.489.1632735064625;
        Mon, 27 Sep 2021 02:31:04 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id u27sm1540438lfm.38.2021.09.27.02.31.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Sep 2021 02:31:04 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id 625B510306C; Mon, 27 Sep 2021 12:31:03 +0300 (+03)
Date:   Mon, 27 Sep 2021 12:31:03 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Nadav Amit <nadav.amit@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Peter Xu <peterx@redhat.com>,
        Nadav Amit <namit@vmware.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Minchan Kim <minchan@kernel.org>,
        Colin Cross <ccross@google.com>,
        Suren Baghdasarya <surenb@google.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>
Subject: Re: [RFC PATCH 4/8] mm/madvise: define madvise behavior in a struct
Message-ID: <20210927093103.g3cszw75gfctwtzk@box.shutemov.name>
References: <20210926161259.238054-1-namit@vmware.com>
 <20210926161259.238054-5-namit@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210926161259.238054-5-namit@vmware.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 26, 2021 at 09:12:55AM -0700, Nadav Amit wrote:
> From: Nadav Amit <namit@vmware.com>
> 
> The different behaviors of madvise are different in several ways, which
> are distributed across several functions. Use the design pattern from
> iouring in order to define the actions that are required for each
> behavior.
> 
> The next patches will get rid of old helper functions that are modified
> in this patch and the redundant use of array_index_nospec(). The next
> patches will add more actions for each leaf into the new struct.
> 
> No functional change is intended.
> 
> Cc: Andrea Arcangeli <aarcange@redhat.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Minchan Kim <minchan@kernel.org>
> Cc: Colin Cross <ccross@google.com>
> Cc: Suren Baghdasarya <surenb@google.com>
> Cc: Mike Rapoport <rppt@linux.vnet.ibm.com>
> Signed-off-by: Nadav Amit <namit@vmware.com>
> ---
>  mm/madvise.c | 168 +++++++++++++++++++++++++++++++++------------------
>  1 file changed, 109 insertions(+), 59 deletions(-)
> 
> diff --git a/mm/madvise.c b/mm/madvise.c
> index 17e39c70704b..127507c71ba9 100644
> --- a/mm/madvise.c
> +++ b/mm/madvise.c
> @@ -29,6 +29,7 @@
>  #include <linux/swapops.h>
>  #include <linux/shmem_fs.h>
>  #include <linux/mmu_notifier.h>
> +#include <linux/nospec.h>
>  
>  #include <asm/tlb.h>
>  
> @@ -39,6 +40,101 @@ struct madvise_walk_private {
>  	bool pageout;
>  };
>  
> +struct madvise_info {
> +	u8 behavior_valid: 1;
> +	u8 process_behavior_valid: 1;
> +	u8 need_mmap_read_only: 1;
> +};
> +
> +static const struct madvise_info madvise_info[MADV_SOFT_OFFLINE+1] = {

MADV_SOFT_OFFLINE+1 smells bad.

And I don't like the change in general. Given that MADV_SOFT_OFFLINE is
101, the array will be mostly empty.

I donno. I don't see any improvement with the patch. But maybe it's only me.

-- 
 Kirill A. Shutemov
