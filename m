Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B278A3C2621
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jul 2021 16:41:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232244AbhGIOns (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jul 2021 10:43:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbhGIOnq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jul 2021 10:43:46 -0400
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86F75C0613E5
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jul 2021 07:41:02 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id d10so433287qtw.7
        for <linux-kernel@vger.kernel.org>; Fri, 09 Jul 2021 07:41:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=3JgiNUXxlzmxCCmJFKLX2XQrMvSQ47grP8G7croHJv8=;
        b=E+KAr3tVzEE4YSt4qtQihiuI/V1XaVI9rO+GadU0W08b/nvVmYmGZ9ZBJmNFkZ/bXl
         wgEZIJFjJELuTAVJkuZs8tufYgT0F9q2l/UPn3QL0cgzR6cBf8FpZVfLGyGEWksF5YxZ
         QeloOh2VDkyQlP07XgJcq+onfh235/pkW7Li5qF5XBfONUM3Twy0woET+2bDuWdEdCwC
         fqBC6Hrh3GtA3LcpaZA9/BI58nJ7W2aPE+mzke3dN8OYqJVxx1yAgWjeUzJVE7cALPiI
         keJuVKb3Vmd7G6dLETjobK64Rb1aMdec8GKSfLXaXtpueWgs5IqyTEARZr1Px0Q28TaC
         yjMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=3JgiNUXxlzmxCCmJFKLX2XQrMvSQ47grP8G7croHJv8=;
        b=Uvfs8+0lPdo56SIihO65NR104Piue/cJgJndbQThLl7B5l8WN5Z1PSP5HWPtUhge4Q
         M492/PQEkTVSmDMZv4xj3Gt1fOqI41IJ8GjYMVaU4KmlEY++RT0UEDqspvtld7qsB/+8
         a5c+HQeW1UooiGKHBD4mOXiEiEfUFnGjRmU835mUtp26X81XjvrhZwcwrpabDpWEjba4
         4NMOX3JJLEmGd5BQeWOP5/0/zos43w5iujYllcfFHqQfQqJjRVoYU9u5O5SFPYgX3ZsC
         a+20i8vOOWyEnIDKhkxrFTMcEOpqeCKXLdsDdh4XSvQ2vr2u/b19BvFZ2Jv+pZ6N7uCG
         dCOQ==
X-Gm-Message-State: AOAM531PovJnqwpFurw7hhV/DT9pFyuq0JooQHAaJGQuzudAwZpsUq5X
        Hjg1twjtByj1uOZBBXVlsHdBZw==
X-Google-Smtp-Source: ABdhPJwGTOB6LcO4whlt2Ii0auykxKpRndmtrMXg2MaHVysHBhuvA7aPBAPk+op/jyXWwdR2glwBKA==
X-Received: by 2002:ac8:5716:: with SMTP id 22mr34090635qtw.82.1625841661638;
        Fri, 09 Jul 2021 07:41:01 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:8649])
        by smtp.gmail.com with ESMTPSA id t125sm2501780qkf.41.2021.07.09.07.41.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jul 2021 07:41:01 -0700 (PDT)
Date:   Fri, 9 Jul 2021 10:41:00 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     tj@kernel.org, mhocko@kernel.org, vdavydov.dev@gmail.com,
        akpm@linux-foundation.org, shakeelb@google.com, guro@fb.com,
        songmuchun@bytedance.com, shy828301@gmail.com, alexs@kernel.org,
        alexander.h.duyck@linux.intel.com, richard.weiyang@gmail.com,
        vbabka@suse.cz, axboe@kernel.dk, iamjoonsoo.kim@lge.com,
        david@redhat.com, willy@infradead.org, apopple@nvidia.com,
        minchan@kernel.org, linmiaohe@huawei.com,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-mm@kvack.org, kernel-team@android.com
Subject: Re: [PATCH 1/3] mm, memcg: add mem_cgroup_disabled checks in
 vmpressure and swap-related functions
Message-ID: <YOhf/DhU3ATIrblp@cmpxchg.org>
References: <20210709000509.2618345-1-surenb@google.com>
 <20210709000509.2618345-2-surenb@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210709000509.2618345-2-surenb@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 08, 2021 at 05:05:07PM -0700, Suren Baghdasaryan wrote:
> Add mem_cgroup_disabled check in vmpressure, mem_cgroup_uncharge_swap and
> cgroup_throttle_swaprate functions. This minimizes the memcg overhead in
> the pagefault and exit_mmap paths when memcgs are disabled using
> cgroup_disable=memory command-line option.
> This change results in ~2.1% overhead reduction when running PFT test
> comparing {CONFIG_MEMCG=n, CONFIG_MEMCG_SWAP=n} against {CONFIG_MEMCG=y,
> CONFIG_MEMCG_SWAP=y, cgroup_disable=memory} configuration on an 8-core
> ARM64 Android device.
> 
> Signed-off-by: Suren Baghdasaryan <surenb@google.com>

Acked-by: Johannes Weiner <hannes@cmpxchg.org>
