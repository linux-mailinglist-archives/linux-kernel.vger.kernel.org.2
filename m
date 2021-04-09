Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BB6435A27D
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 18:00:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233288AbhDIQAh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Apr 2021 12:00:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232395AbhDIQAg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Apr 2021 12:00:36 -0400
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A394C061760
        for <linux-kernel@vger.kernel.org>; Fri,  9 Apr 2021 09:00:23 -0700 (PDT)
Received: by mail-qt1-x831.google.com with SMTP id f12so4539529qtf.2
        for <linux-kernel@vger.kernel.org>; Fri, 09 Apr 2021 09:00:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=fZt7Dp4aLxMqBfqyIc1s7KVYsybr4288xzsHlrCh6ZE=;
        b=glDmhT5fTA9NJEuSbIfNVmb9LUWolbSTkZB0wFF/OZJykSQKnfWYkfB9+qSoDgi174
         p43IUTF5028C0iyow6LjJRaq94gsPd3P87yxDRr/YI71NjKQwA5NK+ct/mcBEX99s5+1
         NvDo7qkHZhSeE3MMY2KAh7wDXF9HZYgL6cIuz/NvUpNc6Ew/6tHws8QTtz1Qld+kp/wc
         dkF8Rbvr0H0lUYq3abKyUpd1bZslps1Mw2EzZ4PXbe6/t7IxR2CpWVBp8P9qRZx3lnKc
         WhG7Pqevgarfu2GjUhuy6ZIv1r6FCOTVSmrnseGGNzKfvWg5NhzN4i0xMiIQUzAGPHDT
         B0BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=fZt7Dp4aLxMqBfqyIc1s7KVYsybr4288xzsHlrCh6ZE=;
        b=lvMFhvnc6c73bJXfsaeMHaT0WG45f1x9ZXoBudXfSDL0MrIB2+8uFPLLkao6DRLfSa
         zOA11M3fO76DTYgiLBgbBidVD/MQpovn9840VtbVaESvkaKbrT8/csCsk/OW/jUS13Hl
         fxbNQsRVN74K2mbvYpy7H1vv7+mmGJdV31WokJfG0jH3dJgKaaS2oMIx4cO7+lExRXm0
         BAt7Qpx3++y8kaSfW8AJxab0Fzo87HPE9bXJnEyuS+t9hj6Q00RtoNzrRh+pzySLSt0v
         ibGohPD+PGtkiaiRWGdeB52Ef5j3Mw7d3sPnn+lFfgtIU7HDqYITcayHbaGPMYmErlSY
         Sbaw==
X-Gm-Message-State: AOAM530hQs9LU2C5i5es5u7D2PhD5q+3CZdaWJu8KRqro+J9Q9g873oS
        ldIrcQO41+WNrJ3l1R2s4PsvXA==
X-Google-Smtp-Source: ABdhPJycyYeJHTmZOwqjpQPFnmZ1xFJzb/VKhsJS7zYXC9sgdnVqQKbYoGbgJHW7nlAq7ABq0q1yuw==
X-Received: by 2002:a05:622a:42:: with SMTP id y2mr13186638qtw.173.1617984022769;
        Fri, 09 Apr 2021 09:00:22 -0700 (PDT)
Received: from localhost (70.44.39.90.res-cmts.bus.ptd.net. [70.44.39.90])
        by smtp.gmail.com with ESMTPSA id h65sm1029491qkd.112.2021.04.09.09.00.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Apr 2021 09:00:21 -0700 (PDT)
Date:   Fri, 9 Apr 2021 12:00:21 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     guro@fb.com, mhocko@kernel.org, akpm@linux-foundation.org,
        shakeelb@google.com, vdavydov.dev@gmail.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        duanxiongchun@bytedance.com, fam.zheng@bytedance.com,
        bsingharora@gmail.com, shy828301@gmail.com,
        alex.shi@linux.alibaba.com
Subject: Re: [RFC PATCH v2 04/18] mm: memcontrol: simplify
 lruvec_holds_page_lru_lock
Message-ID: <YHB6FQ40Xn9E4psq@cmpxchg.org>
References: <20210409122959.82264-1-songmuchun@bytedance.com>
 <20210409122959.82264-5-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210409122959.82264-5-songmuchun@bytedance.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 09, 2021 at 08:29:45PM +0800, Muchun Song wrote:
> We already have a helper lruvec_memcg() to get the memcg from lruvec, we
> do not need to do it ourselves in the lruvec_holds_page_lru_lock(). So use
> lruvec_memcg() instead. And if mem_cgroup_disabled() returns false, the
> page_memcg(page) (the LRU pages) cannot be NULL. So remove the odd logic
> of "memcg = page_memcg(page) ? : root_mem_cgroup". And use lruvec_pgdat
> to simplify the code. We can have a single definition for this function
> that works for !CONFIG_MEMCG, CONFIG_MEMCG + mem_cgroup_disabled() and
> CONFIG_MEMCG.
> 
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>

Looks good to me.

Acked-by: Johannes Weiner <hannes@cmpxchg.org>

If you haven't done so yet, please make sure to explicitly test with
all three config combinations, just because the dummy abstractions for
memcg disabled or compiled out tend to be paper thin and don't always
behave the way you might expect when you do more complicated things.

Something like

boot
echo sparsefile >/dev/null (> ram size to fill memory and reclaim)
echo 1 >/proc/sys/vm/compact_memory

should exercise this new function in a couple of important scenarios.
