Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5C853C62AC
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jul 2021 20:31:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235960AbhGLSeX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jul 2021 14:34:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235896AbhGLSeU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jul 2021 14:34:20 -0400
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7ED8C0613E8
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jul 2021 11:31:30 -0700 (PDT)
Received: by mail-qv1-xf2b.google.com with SMTP id i4so8538710qvq.10
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jul 2021 11:31:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=91QVBsn60C5sxxxstdN+oyAoFM1Vz8Xrhf5wNCClAZ0=;
        b=a019hXVML1QTTEfMxq4xOcak1XJogepYRETIyj3+hyPTloWky9q429jsqUoXR7NVUp
         x0sleTMvkwrpFBp5Iq492/WoP65dbpZlQV0HMy3pWuYArruuTgwsz2kNgmgvcfB0Uf8A
         zDuf0ZV/XAINwDV7rOhVLr2StoZ41vBZMq4y+WzvgRTKLKILuFcPWYjse+WchS9SplIV
         aQi/Q0AzrsPNr6udTmAyz7xaxLOL4RHnMtQohfkumhs2UOheE+1WjeKcsex9RZix8MRU
         IVEcs/d+bN2CTr2OCyJfFWTq0bnSxNX0smTokjuWD78ZfZS/wzfyHrDGXqBkR8ux7Lx7
         4MOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=91QVBsn60C5sxxxstdN+oyAoFM1Vz8Xrhf5wNCClAZ0=;
        b=rOvLijdZKfCqQHYHxli/Jm13fgDWREez1MtvQXdFsdesagqKMKKh9GsSYmNXsnHDoa
         eiCKAXCXL54gchVfXj/aHBndCyyKjGeGMZBIbQMB+uh+Ov0aWRvFu27M4W/j5UyE6gzb
         IGr6TBrOCHfgyGx8/P2Ob7t7/3fU1WqhPp4NYYQjpwwwGt3Kcybuas614JAFMGZmnUnQ
         Dzg68f3kCX5rWmhIT/4ZTX8RqPN4/iyOIGgQd6kph+AoLanxuSmtunA1fmvgtaA8XCJ5
         fuFInnlsCrTa67bt33L7wgeYo9bH0qiNSIALXRp40j8q5K285MQ4guWfck3naRfLMaCU
         Fg0Q==
X-Gm-Message-State: AOAM533gXcxKs3FPNLqTtDe5GWw3DjVVBRV1Qjiyn2G+o24kUsPIs9Kn
        woaGvkG1+BjN193h4Ui2YwdYmQ==
X-Google-Smtp-Source: ABdhPJy1mAKtVsdu1BKkSpdIw3PhdMIO5F6wAuKWr6F1MoPxiv4FZkGIUcRiLa3CFNZlpp0QbqBqcQ==
X-Received: by 2002:a05:6214:224c:: with SMTP id c12mr431607qvc.7.1626114689982;
        Mon, 12 Jul 2021 11:31:29 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:a40c])
        by smtp.gmail.com with ESMTPSA id 71sm5935964qtc.97.2021.07.12.11.31.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jul 2021 11:31:28 -0700 (PDT)
Date:   Mon, 12 Jul 2021 14:31:27 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     tj@kernel.org, mhocko@kernel.org, vdavydov.dev@gmail.com,
        akpm@linux-foundation.org, shakeelb@google.com, guro@fb.com,
        songmuchun@bytedance.com, shy828301@gmail.com, alexs@kernel.org,
        richard.weiyang@gmail.com, vbabka@suse.cz, axboe@kernel.dk,
        iamjoonsoo.kim@lge.com, david@redhat.com, willy@infradead.org,
        apopple@nvidia.com, minchan@kernel.org, linmiaohe@huawei.com,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-mm@kvack.org, kernel-team@android.com
Subject: Re: [PATCH v2 1/1] mm, memcg: inline mem_cgroup_{charge/uncharge} to
 improve disabled memcg config
Message-ID: <YOyKfySwuBfgtEvW@cmpxchg.org>
References: <20210709171554.3494654-1-surenb@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210709171554.3494654-1-surenb@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 09, 2021 at 10:15:54AM -0700, Suren Baghdasaryan wrote:
> Inline mem_cgroup_{charge/uncharge} and mem_cgroup_uncharge_list functions
> functions to perform mem_cgroup_disabled static key check inline before
> calling the main body of the function. This minimizes the memcg overhead
> in the pagefault and exit_mmap paths when memcgs are disabled using
> cgroup_disable=memory command-line option.
> This change results in ~0.4% overhead reduction when running PFT test
> comparing {CONFIG_MEMCG=n} against {CONFIG_MEMCG=y, cgroup_disable=memory}
> configurationon on an 8-core ARM64 Android device.
> 
> Signed-off-by: Suren Baghdasaryan <surenb@google.com>

Acked-by: Johannes Weiner <hannes@cmpxchg.org>

Thanks!
