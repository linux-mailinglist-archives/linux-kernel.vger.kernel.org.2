Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFF8335A5CC
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 20:31:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234440AbhDIScB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Apr 2021 14:32:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234313AbhDISb5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Apr 2021 14:31:57 -0400
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72F78C061762
        for <linux-kernel@vger.kernel.org>; Fri,  9 Apr 2021 11:31:44 -0700 (PDT)
Received: by mail-qk1-x72c.google.com with SMTP id v70so6778564qkb.8
        for <linux-kernel@vger.kernel.org>; Fri, 09 Apr 2021 11:31:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=EKQ+PAGgShMzePeTUtIKBivxK+r/dnGaqdyGytm2oWo=;
        b=fCEschyGAMMn6VF4XHS2XGgUN9Ekoe7/0ZKT+fdRYNG7iwqBjCt2ZG5MVCQm2UpImR
         pfQNJorBT9ui+crcKlywulA7fWeM4vq4q+AO/ZjSi27KoqxrN5PnfUypmrs9SV9ZHDHX
         jcpSE8p93+s/UfWmuKIb/sQceslqTjla1XbJLG8Wvfzx1TvgnO8ZI2imcWGp3TOZTjra
         FSrmmjhLDszTkpV71RNqsEaptogyES14WFo/IJ40KpsNYFItGKyuxbbC1Ib2CiKGgOqn
         I1jZRD8UpUPNlquDvJ5it8pNSInv3pLslaHtP7fWLkvpnicHWZsagsIXQXRaK87JU+8N
         UYaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=EKQ+PAGgShMzePeTUtIKBivxK+r/dnGaqdyGytm2oWo=;
        b=XO+n3Y9VkY87uX3FpXjggx5Gny12/MCElKOwf0lhnF50AmsAE+RWcJxP9fowzOZJLV
         f7DQ9FYkFtpHa/MW/XTdHtLRU4A+ImUtYfhxoncTxBL5pPsPXVFGjYK8uXhMpk0ZLgGF
         3dFqxC+LvHeXeaXi7hRUAUVGbb7oIQfXZkTMeKBxOVd0KKNWNoVp2p2ZeNyWc4F5b+H2
         crawQfXQ1IQtDGT2T5rUUo5uLvO410MqJwoYNahd+Hx3j5jwvCCnoVra+Uw5TS/Pbl0k
         fQ6Q2exQxCwUZEXdGi9XxTrk+pMzSpwqAqDSXcMqa5/j5qL1HVClJFtMtm3cDbf611ba
         /Lng==
X-Gm-Message-State: AOAM531zM+2N9khDK2oraFPLKQ8Xi+sdUyyw9ifTm+KCVSIwMNgGIXys
        xM8gO7t1V26CBuua9+HRmdpaFg==
X-Google-Smtp-Source: ABdhPJxMTMAOXo89w9z138HDZgi/fLJzWSprm2eXuSdZMKg1xOZTvnQCJpE9XfEYswibLPl3BEUsLg==
X-Received: by 2002:a05:620a:10ba:: with SMTP id h26mr2158205qkk.155.1617993103749;
        Fri, 09 Apr 2021 11:31:43 -0700 (PDT)
Received: from localhost (70.44.39.90.res-cmts.bus.ptd.net. [70.44.39.90])
        by smtp.gmail.com with ESMTPSA id 79sm2411128qki.37.2021.04.09.11.31.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Apr 2021 11:31:43 -0700 (PDT)
Date:   Fri, 9 Apr 2021 14:31:42 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     guro@fb.com, mhocko@kernel.org, akpm@linux-foundation.org,
        shakeelb@google.com, vdavydov.dev@gmail.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        duanxiongchun@bytedance.com, fam.zheng@bytedance.com,
        bsingharora@gmail.com, shy828301@gmail.com,
        alex.shi@linux.alibaba.com
Subject: Re: [RFC PATCH v2 09/18] mm: vmscan: remove noinline_for_stack
Message-ID: <YHCdjgaB8IjOMq4z@cmpxchg.org>
References: <20210409122959.82264-1-songmuchun@bytedance.com>
 <20210409122959.82264-10-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210409122959.82264-10-songmuchun@bytedance.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 09, 2021 at 08:29:50PM +0800, Muchun Song wrote:
> The noinline_for_stack is introduced by commit 666356297ec4 ("vmscan:
> set up pagevec as late as possible in shrink_inactive_list()"), its
> purpose is to delay the allocation of pagevec as late as possible to
> save stack memory. But the commit 2bcf88796381 ("mm: take pagevecs off
> reclaim stack") replace pagevecs by lists of pages_to_free. So we do
> not need noinline_for_stack, just remove it (let the compiler decide
> whether to inline).
> 
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>

Good catch.

Acked-by: Johannes Weiner <hannes@cmpxchg.org>

Since this patch is somewhat independent of the rest of the series,
you may want to put it in the very beginning, or even submit it
separately, to keep the main series as compact as possible. Reviewers
can be more hesitant to get involved with larger series ;)
