Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C3DC344766
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 15:35:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231175AbhCVOe7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 10:34:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230292AbhCVOeY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 10:34:24 -0400
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A21BC061574
        for <linux-kernel@vger.kernel.org>; Mon, 22 Mar 2021 07:34:23 -0700 (PDT)
Received: by mail-qt1-x835.google.com with SMTP id a11so12455681qto.2
        for <linux-kernel@vger.kernel.org>; Mon, 22 Mar 2021 07:34:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=dgiA9EKcb76B1bqLH03HrKnpAcqLt9hekpmCfkhncBM=;
        b=EBPrZQ6PQF33CulUgZLclPe1IXGwkWh3ADuOa9EgjQgFIahJ9GlGNh7SlhkI+elRmq
         dzfK9alFsD7t1YCwWcYOlrPF8Mj/R09IiyZarhTK1NzPUNChZFiSklUMPysQ661DMZuH
         5ksYkQqXg46X80Loj9iWMmubDjA2yp612HvTkBShMzpIKcOTuVdS1joaTBBl/T+z+GHs
         v8O59o4DeBrBGOp8Lvrf0LVXhSIXsLGp4tL3mM1QzzniiTAG6uxkqW/MWUBEnl7rQCfQ
         VtkMoXcnt0euUHkDR4XRCa8Ttdryk+f2bFr+BimSIcoP/mxPX7AQsEmmAkGUVEv4sH22
         nFHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=dgiA9EKcb76B1bqLH03HrKnpAcqLt9hekpmCfkhncBM=;
        b=AAIcezKCgdnDKNrgSWXcGA7/yYTExv58g5/vz4EXhreaCoB10Kccig4BtX/LJ2eBRk
         rIrxVp00y8vf5E/k0anwVlPJpXpDMIrsL7PtZQkegLUVlIytNjbv4EqKH7u2DOmuJrOW
         u9FXisEQcKBhEboMZdYFdTsVGQe9Wprw6J1Tq5xYMyIyO25D/mniRjqByiIrJdOjQ2OU
         3SgYYsbYlsI4ORer8J0tTyosvEYyQtF8wGZZEZv9U/I8cQGW75VGVzbcINVBbMxfHhGx
         Y/ATV4y7FOo9X4r7xhr0anjJBaO+aenCqm8hN92JOwHg9Hs0T8TuZxFSw5zp6FSHB6Kb
         h6nA==
X-Gm-Message-State: AOAM533m+uBugbfxlNgeLmWIem0wbgmOJn+7wx6JqaW0EJOeigc1eCZm
        xgDLsKC41tB9zXZ72wMxnrXNPw==
X-Google-Smtp-Source: ABdhPJx+Ya3oBgg5/bfd+IQ2NmX25h21HO5+95dpSWRQU5r2IvHK7POVRsnH3kNoOejTbhWlH4uc/g==
X-Received: by 2002:ac8:5ad5:: with SMTP id d21mr187641qtd.198.1616423662401;
        Mon, 22 Mar 2021 07:34:22 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:b54e])
        by smtp.gmail.com with ESMTPSA id d2sm10921327qkk.42.2021.03.22.07.34.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Mar 2021 07:34:21 -0700 (PDT)
Date:   Mon, 22 Mar 2021 10:34:18 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     guro@fb.com, mhocko@kernel.org, akpm@linux-foundation.org,
        shakeelb@google.com, vdavydov.dev@gmail.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        duanxiongchun@bytedance.com
Subject: Re: [PATCH v5 6/7] mm: memcontrol: inline __memcg_kmem_{un}charge()
 into obj_cgroup_{un}charge_pages()
Message-ID: <YFiq6h8+DS1ZQLrP@cmpxchg.org>
References: <20210319163821.20704-1-songmuchun@bytedance.com>
 <20210319163821.20704-7-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210319163821.20704-7-songmuchun@bytedance.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 20, 2021 at 12:38:19AM +0800, Muchun Song wrote:
> There is only one user of __memcg_kmem_charge(), so manually inline
> __memcg_kmem_charge() to obj_cgroup_charge_pages(). Similarly manually
> inline __memcg_kmem_uncharge() into obj_cgroup_uncharge_pages() and
> call obj_cgroup_uncharge_pages() in obj_cgroup_release().
> 
> This is just code cleanup without any functionality changes.
> 
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>

Acked-by: Johannes Weiner <hannes@cmpxchg.org>
