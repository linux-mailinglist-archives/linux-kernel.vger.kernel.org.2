Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61D1935A347
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 18:27:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233934AbhDIQ1n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Apr 2021 12:27:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229665AbhDIQ1m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Apr 2021 12:27:42 -0400
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D149C061760
        for <linux-kernel@vger.kernel.org>; Fri,  9 Apr 2021 09:27:29 -0700 (PDT)
Received: by mail-qk1-x72c.google.com with SMTP id q26so6387332qkm.6
        for <linux-kernel@vger.kernel.org>; Fri, 09 Apr 2021 09:27:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=LjrPz2s8A9wB9g0uw7ei0A966rFvFTwMq2h7wfTVNEI=;
        b=cEkeJQ7Yo/U8WUtvJkxyLqjM00FlFriq23RSEutb7fQpsQXbaWooEUM46FjU3qaPWU
         yjgVQcQarxtZH0u/3srZMcyZyhyyMuA12/rExznBOiFsAe9zYdz5AdV0n7zHSuUaA2T/
         1Y5QZHlzFe7/5vS82uVNeUsQjowWsqNcO41TmLLj8+5bZQgFDancNOMdDMt4QDnXlGWH
         fzBg6hJ+xnGtvQiHqSct+DvpA9uCb3sxN0mw39lOOeehk5ld3MJSJIfvxCop6vcrAKLE
         8y43RPPhPKcaqP/AJzAb0+K1Qw47hZzlQC3pLB87AOmn3/ovXwwaitera1iDAWuJLt2m
         bWiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=LjrPz2s8A9wB9g0uw7ei0A966rFvFTwMq2h7wfTVNEI=;
        b=JgDDrYnmeRJo8r5zfWOXVhPBlxl4Vv4zy2JUTHy0fH4QJQO7rRI4TdJLeKA44y+0ca
         62DYX74y0K7XCP78QMxOTv1Z3F4WCdT1CHmO6INdudXSzj3rSiNPoAPkF86IwnXqkKk9
         VJ1VUzdHQeh/cScno18buOzFBiNuhsxf3J6ldNamTuR/gQcChGnQfi+nKh/sfRceKFHv
         i3Qt5/0RnLyQPJ2fx3QQyXmf1Vawq/5PtETI3mlyI3tYwagAd+W/ZxM2WsPs6ki6FBW+
         ZUF0cALzHsIc1kEwAiPMxX8jVLy9mDpWvczDB0XLVRSwjgJ2xC0I3QoJOYMJeosob1FL
         ZIgw==
X-Gm-Message-State: AOAM532kRV8gZJQOjx8/wXO+yACZWqyB5FxNooarT2xvX07n+beEIL/n
        w/a7JOSYF89FAJ0gYo/p296O0w==
X-Google-Smtp-Source: ABdhPJw9IByqUYH8m38ORw7YCYBB7s9HYJU7n5MHBiv8feb5avOqDYhLDTefZNXWuHD4YqkwPnEvhw==
X-Received: by 2002:a37:76c2:: with SMTP id r185mr14303169qkc.204.1617985648354;
        Fri, 09 Apr 2021 09:27:28 -0700 (PDT)
Received: from localhost (70.44.39.90.res-cmts.bus.ptd.net. [70.44.39.90])
        by smtp.gmail.com with ESMTPSA id v2sm2044427qkv.39.2021.04.09.09.27.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Apr 2021 09:27:27 -0700 (PDT)
Date:   Fri, 9 Apr 2021 12:27:27 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     guro@fb.com, mhocko@kernel.org, akpm@linux-foundation.org,
        shakeelb@google.com, vdavydov.dev@gmail.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        duanxiongchun@bytedance.com, fam.zheng@bytedance.com,
        bsingharora@gmail.com, shy828301@gmail.com,
        alex.shi@linux.alibaba.com
Subject: Re: [RFC PATCH v2 05/18] mm: memcontrol: simplify the logic of objcg
 pinning memcg
Message-ID: <YHCAb1cZFuqLiy6r@cmpxchg.org>
References: <20210409122959.82264-1-songmuchun@bytedance.com>
 <20210409122959.82264-6-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210409122959.82264-6-songmuchun@bytedance.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 09, 2021 at 08:29:46PM +0800, Muchun Song wrote:
> The obj_cgroup_release() and memcg_reparent_objcgs() are serialized by
> the css_set_lock. We do not need to care about objcg->memcg being
> released in the process of obj_cgroup_release(). So there is no need
> to pin memcg before releasing objcg. Remove those pinning logic to
> simplfy the code.

Hm yeah, it's not clear to me why inherited objcgs pinned the memcg in
the first place, since they are reparented during memcg deletion and
therefor have no actual impact on the memcg's lifetime.

> There are only two places that modifies the objcg->memcg. One is the
> initialization to objcg->memcg in the memcg_online_kmem(), another
> is objcgs reparenting in the memcg_reparent_objcgs(). It is also
> impossible for the two to run in parallel. So xchg() is unnecessary
> and it is enough to use WRITE_ONCE().

Good catch.

> Signed-off-by: Muchun Song <songmuchun@bytedance.com>

Looks like a nice cleanup / simplification:

Acked-by: Johannes Weiner <hannes@cmpxchg.org>
