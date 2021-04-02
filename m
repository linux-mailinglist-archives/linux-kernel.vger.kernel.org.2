Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56208352C24
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Apr 2021 18:09:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235193AbhDBPIn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Apr 2021 11:08:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbhDBPIm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Apr 2021 11:08:42 -0400
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 164CAC0613E6
        for <linux-kernel@vger.kernel.org>; Fri,  2 Apr 2021 08:08:41 -0700 (PDT)
Received: by mail-qv1-xf32.google.com with SMTP id by2so2593596qvb.11
        for <linux-kernel@vger.kernel.org>; Fri, 02 Apr 2021 08:08:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=wQrnvPmgQ6qoU6cE/YM7bFQYQMf4u2P6Aw0WF5mGCKQ=;
        b=soEf7o4uAGlR8/3IIWjii9z5BYCoxP8IMb+pEB5sAxBW1TtPlXWO1ZNG0c2iYhaLJc
         zjYcTheQxWUm1rBlZ5sW6aoGr5KKX0DMFhR1zyIrgiZ1cvXlOrEsXPK4N5GHcMHqp2ko
         E+kp4giH0V9+y1zHWlTaUz+xMoGf3VWxvKR4Pog75+WW27irDqxMGl77XrTswEj7qhd6
         esa5NAvFzti7TUtLsN1fQZ/PtPgyWb3FaYwZp1McYHIjLpGAVz7jJXD/VxgVulu+4zXT
         nJRU5Vg3bERufdWPlrA2ioFeIWmc+sZVgiwQMAn5ahKobritjRvdg2bJcrNn2KazmZxr
         91Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=wQrnvPmgQ6qoU6cE/YM7bFQYQMf4u2P6Aw0WF5mGCKQ=;
        b=Eb6u+XloguGbEG+zz0uu9jH/WOjuwnTx7yP3CDEO8x9yWKXccZZPeHbcDuqBfBtsSQ
         gE+k7Xj3yM0TTE7F2v903F/o4W03fsWX3dhoDQFP7sCQSjl4jFBwe5bMmXw1AdGwcKAI
         pUyuX6NiLRZwcu0k52QVpjQNfrNGz+WQsuqGK66tfV7SQpLT/hFcXHWdSJZGJaoIdgQm
         V9RfS8x9P+pmvt60YbRCK/1fpYo7HUq7lEgET52ffPytN1XErqoAsGt3Xw1VTVFMiW0G
         qV0zYsJssCJwpKxEty+OAewh+bpHD/2pSZw6APzLW5iCt8CyMUOd3SFHdF0AaCuytBBP
         idmQ==
X-Gm-Message-State: AOAM531LYkPLn7xhFDeYTCawPhOwsjUE2fmaxHXql1lCKxcoAd6/rspV
        66caQyta0m8LonqDu3YFKMODWw==
X-Google-Smtp-Source: ABdhPJxV9vtRuenDA6lHn0krwhP/45IY0QtV5dowvTXo/xtrDOWP+uFWfrbidICJYHaEHTk6XzpqZw==
X-Received: by 2002:ad4:410d:: with SMTP id i13mr13015900qvp.44.1617376120417;
        Fri, 02 Apr 2021 08:08:40 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:8ca7])
        by smtp.gmail.com with ESMTPSA id 75sm7322604qkd.114.2021.04.02.08.08.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Apr 2021 08:08:39 -0700 (PDT)
Date:   Fri, 2 Apr 2021 11:08:38 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     guro@fb.com, mhocko@kernel.org, akpm@linux-foundation.org,
        shakeelb@google.com, vdavydov.dev@gmail.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        duanxiongchun@bytedance.com
Subject: Re: [RFC PATCH 02/15] mm: memcontrol: bail out early when !mm in
 get_mem_cgroup_from_mm
Message-ID: <YGczdhFJNVphX8uj@cmpxchg.org>
References: <20210330101531.82752-1-songmuchun@bytedance.com>
 <20210330101531.82752-3-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210330101531.82752-3-songmuchun@bytedance.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 30, 2021 at 06:15:18PM +0800, Muchun Song wrote:
> When mm is NULL, we do not need to hold rcu lock and call css_tryget for
> the root memcg. And we also do not need to check !mm in every loop of
> while. So bail out early when !mm.
> 
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>

Good observation.

Acked-by: Johannes Weiner <hannes@cmpxchg.org>
