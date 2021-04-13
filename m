Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 569BA35E142
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Apr 2021 16:19:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230028AbhDMOTe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Apr 2021 10:19:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229558AbhDMOT2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Apr 2021 10:19:28 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E081C061574
        for <linux-kernel@vger.kernel.org>; Tue, 13 Apr 2021 07:19:08 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id f41so4244121lfv.8
        for <linux-kernel@vger.kernel.org>; Tue, 13 Apr 2021 07:19:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Z8E4aJWY8S1UewlX1deTBL/TSfNjGfLKOGHhOfD8DdQ=;
        b=wNEgu565JVChQOzqfu7VI4YMq9rsnsx91xg5exzQG4fW8BhPE9txEfAZNQXtJ6eguF
         QcePnkqE22FvS6FaytPrXYAvwp+kIPYuMuVwkzo1GEHTG0Mt4xLqwioGDVoAZtl/i/pr
         NgAjV893s9/nqObtXpgFP4Sv0Qdp1kMqwhW/mtN6B94EEWGF4NBz13U+VkDE4HjwnTGM
         jbLe73Brwf75Jqml/0fYWnXJ1AXfBALl/98zgVDvMrrXTC0DKS22seqxXgqd+sb3Ydma
         vT6OKSqnzY25RF9UmXy2rH2rymrl/4D+WPiTzf8M4SH1Q0bbr6THv5ALayWkD+XCzjzV
         oZyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Z8E4aJWY8S1UewlX1deTBL/TSfNjGfLKOGHhOfD8DdQ=;
        b=cTV9vorF0TBgXsFh5gsnJLIe9y3LRdqo7Xk8BXNXpQ3qpo/wmM6e8gunQX8/goBwaj
         GKyuucFqUyQ/T45DBRD58N94/Tk7Arc5UOL+zYEPde/V98RAlk7pkMHWb9i2ie7Ny6DG
         ugpgsIjU9tztrmNaEv5t2P44Tf6NC1iqet2rADYvU1b6IfzFMNKprCcSIvkc9fPKFCEr
         qy93brESMZYg0OxCyCn7ddLSCMREt9GN7pHU1BgSQ6bZ457IrN6jF1UzLRfYXbFPR0m5
         RvBE3p8LGIeD4GKzOpCwqJkS75XF77uPapvPl0y4mf4bwStkU6f80Sqb5Wi1iWGl1aaG
         /8Rw==
X-Gm-Message-State: AOAM532N6zoUGjmv9T5qqCWblWRK1Gmh/OViN28vRbnq6awc4Xe9DKiK
        76wC6ZwevdtW4I4dBbjTSio1T0F6hrKqzRjYTCUP5w==
X-Google-Smtp-Source: ABdhPJwxZXtINdMaf/cXfQkq4pbXsql3edDM43KiHd6FR2T4DmVGitIeVDELJNQp3WMnFtH1pMN1ymZ7b5Rc0vq4I5Y=
X-Received: by 2002:ac2:546c:: with SMTP id e12mr8204910lfn.299.1618323545033;
 Tue, 13 Apr 2021 07:19:05 -0700 (PDT)
MIME-Version: 1.0
References: <20210413065153.63431-1-songmuchun@bytedance.com> <20210413065153.63431-7-songmuchun@bytedance.com>
In-Reply-To: <20210413065153.63431-7-songmuchun@bytedance.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Tue, 13 Apr 2021 07:18:52 -0700
Message-ID: <CALvZod4RawjDccyoRFW2NqggYqQaY1p2jj5zzvwLZsYq2pWjZA@mail.gmail.com>
Subject: Re: [PATCH 6/7] mm: memcontrol: move obj_cgroup_uncharge_pages() out
 of css_set_lock
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     Roman Gushchin <guro@fb.com>, Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Xiongchun duan <duanxiongchun@bytedance.com>,
        fam.zheng@bytedance.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 12, 2021 at 11:58 PM Muchun Song <songmuchun@bytedance.com> wrote:
>
> The css_set_lock is used to guard the list of inherited objcgs. So there
> is no need to uncharge kernel memory under css_set_lock. Just move it
> out of the lock.
>
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>

Reviewed-by: Shakeel Butt <shakeelb@google.com>
