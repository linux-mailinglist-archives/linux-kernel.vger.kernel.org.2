Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01DF53C2644
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jul 2021 16:49:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232328AbhGIOwd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jul 2021 10:52:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232230AbhGIOwb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jul 2021 10:52:31 -0400
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8670EC0613DD
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jul 2021 07:49:47 -0700 (PDT)
Received: by mail-qk1-x733.google.com with SMTP id i125so9498095qke.12
        for <linux-kernel@vger.kernel.org>; Fri, 09 Jul 2021 07:49:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=sl7zNgfOy4Ks0Fk6pkfy9FhpGYHd/QTs7j+H3rSlVoM=;
        b=QA6tQE9mCvmjOaTfcc2lhfJ7BmUP0CTjYUCkE42z/dXIUmI+XlkPMDOIo3wA9Ewd8i
         TJcT0Rjq4p0GKVFYWW4j9Z1BcCOpXN4vxlhh0bU60qcdL/HIkNQKC8c3XQYi+hCe6xVR
         7LkNosRmU6md/syD7lrW9ODys7pLAhmCYjFS3RlKMHmbyHNwnwns2S+NrAp/9socbAT1
         UV55cIljPhKM/izeG48aY0Wy97a79OseJ1N8UaBbkZTZ1fslg1hFWwkdoblX5UjI3Lc6
         uzOf7aOyTsRBNkJWX+cX40JVq0JY0KnTTyyXoH1lR6JySxF1VylzyMoTh1CsWjQnkLg+
         1TJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=sl7zNgfOy4Ks0Fk6pkfy9FhpGYHd/QTs7j+H3rSlVoM=;
        b=aDAhnus+jL6t8EKS5ZXPUKU+42WYISdWhwUovljOSy6dwJXWkUOvAZ/KI/FA0okCj2
         daOlgDJ0Cn0DGmfhRO6EoTRQiVSh7WwySa19H5KdtxoT2otTWjhBNDW0uFbcYmuEg5vR
         T+JuvkKkrvehARp1CQ+r1+KI8FPNG4FadlzWHksOXFz4RPJDJBpk3LcuUrlgpisbRN7t
         PnZPNOS+sQUf+KlgVFeBazu91fJ5gk+gzYQSrm0y6j7bnHGIrmhmaBum7r98OldM1BWW
         5L/yzJKj2r8EA2m0r2Vkj2RxuLXyorPG9Ef4fEzM6cKkt6lymi2MucCqjltipS5vveYS
         WJBQ==
X-Gm-Message-State: AOAM531ORi0a3HGcaygQHkeCycoFjZMzXHxAjhVhkIBJjH+Le0iUy0Tr
        zs1zkc7qEsv7Pl9vCJT8554Syw==
X-Google-Smtp-Source: ABdhPJxVjlU9+Tbsjk5O64L0DrdYKOqi50sg11zdiPNqvEJpCOIPUhs2uVvO7S1pUh3kMex5WXyFrw==
X-Received: by 2002:ae9:f44c:: with SMTP id z12mr15623147qkl.265.1625842186810;
        Fri, 09 Jul 2021 07:49:46 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:8649])
        by smtp.gmail.com with ESMTPSA id x9sm2329117qtf.76.2021.07.09.07.49.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jul 2021 07:49:46 -0700 (PDT)
Date:   Fri, 9 Jul 2021 10:49:45 -0400
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
Subject: Re: [PATCH 3/3] mm, memcg: inline swap-related functions to improve
 disabled memcg config
Message-ID: <YOhiCbrBjWnJaJMt@cmpxchg.org>
References: <20210709000509.2618345-1-surenb@google.com>
 <20210709000509.2618345-4-surenb@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210709000509.2618345-4-surenb@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 08, 2021 at 05:05:09PM -0700, Suren Baghdasaryan wrote:
> Inline mem_cgroup_try_charge_swap, mem_cgroup_uncharge_swap and
> cgroup_throttle_swaprate functions to perform mem_cgroup_disabled static
> key check inline before calling the main body of the function. This
> minimizes the memcg overhead in the pagefault and exit_mmap paths when
> memcgs are disabled using cgroup_disable=memory command-line option.
> This change results in ~1% overhead reduction when running PFT test
> comparing {CONFIG_MEMCG=n} against {CONFIG_MEMCG=y, cgroup_disable=memory}
> configuration on an 8-core ARM64 Android device.
> 
> Signed-off-by: Suren Baghdasaryan <surenb@google.com>

Looks reasonable to me as well.

Acked-by: Johannes Weiner <hannes@cmpxchg.org>
