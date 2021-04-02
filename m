Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 222BD352D38
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Apr 2021 18:10:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236115AbhDBPWZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Apr 2021 11:22:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236050AbhDBPWT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Apr 2021 11:22:19 -0400
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8BF7C061788
        for <linux-kernel@vger.kernel.org>; Fri,  2 Apr 2021 08:22:14 -0700 (PDT)
Received: by mail-qv1-xf35.google.com with SMTP id t16so2595008qvr.12
        for <linux-kernel@vger.kernel.org>; Fri, 02 Apr 2021 08:22:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=HqOSSjP8VsKEgoLReA8Ec/GP45XGwwALUfgS/ucZBPM=;
        b=KYQa9bztnFxv6sAzKeiaQcAYtIsQwZ0luHax+BysFvRuTXQu0GO2uAvJMu1kcAe36c
         dmqdOJVSQeks1xf68at2nxJWx5Bbv6g05ah2X//bP3T2/Ys2vds1FRkHy246K/NVLbnM
         kvwS9On3JQrzInxrmjnheYDibvhFzlMWVZWYRWzHFNPjD2xtv6fzwMfSeBJY57Rwj5Rb
         4rq/LgPcjapkP3QXh/R1Bdn3mF14MtU3RM1iULXOGAgW3aGRen/B/4KC+LEualyEbHpK
         bzDuM6gGk7zxYPKW3ywGAA6yhoCmNnDIDYFA6rKio700BVLIzZEpCsnbQmnY4ug2zimj
         BsRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=HqOSSjP8VsKEgoLReA8Ec/GP45XGwwALUfgS/ucZBPM=;
        b=Nawh3k2s6cBNgXQXccLQi5OHNMt1dI0Jj6UieeMfgRc5VveiaCttoE5MYcNgaREUoA
         MrA9kseIn/7a72tp0mY2Gpa4CCRYkEh9N09GxETyncX4cbvYiVLLnk+QMuz8sw/QEQHR
         HtGbeuW6I1hgyUEz/Zu4liHZVYNHiKTn2TudUPVDRSsVfrpD2XqK2B0rvFGVR0DnkOL7
         FaMFzkRdtrQ4eEAAwAR1bEUYVs0U8EdlZdEVX9M7xIX5RDlSQ3h1nLq1daW52ZKl9NYc
         BJAyE1lis0R+f2Q3TUsKUhcQC8aFvOCDW7eRWWnbSuuWP/QgGPRBYNYLuJz7rtweDFKD
         bxpg==
X-Gm-Message-State: AOAM532Aay3PfvyzUBOiXfFcRhU5elibhuNG/d6Y29/OHK86wH9oUykt
        j9YXNw63KYyShNNE5ZPnacvt2Q==
X-Google-Smtp-Source: ABdhPJx0n2GqdaR7E5PJlOTvX1JWTrudxl2iL00LAIetmK8ViYSynmVhAhRg/LqLIFVhRXwRjiPedg==
X-Received: by 2002:a0c:9cc2:: with SMTP id j2mr13569952qvf.2.1617376933225;
        Fri, 02 Apr 2021 08:22:13 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:8ca7])
        by smtp.gmail.com with ESMTPSA id t24sm6800763qto.23.2021.04.02.08.22.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Apr 2021 08:22:12 -0700 (PDT)
Date:   Fri, 2 Apr 2021 11:22:11 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     guro@fb.com, mhocko@kernel.org, akpm@linux-foundation.org,
        shakeelb@google.com, vdavydov.dev@gmail.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        duanxiongchun@bytedance.com
Subject: Re: [RFC PATCH 03/15] mm: memcontrol: remove the pgdata parameter of
 mem_cgroup_page_lruvec
Message-ID: <YGc2ozMAYph04nm2@cmpxchg.org>
References: <20210330101531.82752-1-songmuchun@bytedance.com>
 <20210330101531.82752-4-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210330101531.82752-4-songmuchun@bytedance.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 30, 2021 at 06:15:19PM +0800, Muchun Song wrote:
> All the callers of mem_cgroup_page_lruvec() just pass page_pgdat(page)
> as the 2nd parameter to it (except isolate_migratepages_block()). But
> for isolate_migratepages_block(), the page_pgdat(page) is also equal
> to the local variable of @pgdat. So mem_cgroup_page_lruvec() do not
> need the pgdat parameter. Just remove it to simplify the code.
> 
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>

There is a minor benefit in not doing the page_pgdat() lookup twice.
But I think it only really matters on 32-bit NUMA, where we have more
than one node but not enough space in page->flags to store the nid,
and so page_to_nid() is out-of-line and needs to go through section.

Those setups aren't really around anymore, and certainly don't justify
the hassle (and potential bugs) of the awkward interface.

Acked-by: Johannes Weiner <hannes@cmpxchg.org>
