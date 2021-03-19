Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1EE53411DC
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 02:01:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233372AbhCSBBJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 21:01:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231349AbhCSBAl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 21:00:41 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7207C06174A
        for <linux-kernel@vger.kernel.org>; Thu, 18 Mar 2021 18:00:40 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id m12so7459035lfq.10
        for <linux-kernel@vger.kernel.org>; Thu, 18 Mar 2021 18:00:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AT07gM1d/snjyMuDSqF2iBtIXpjEUy5a43Ltdcejjg4=;
        b=KM6wA1h7XMgkD3D79Vjsw2MmDWvfXJ31KEsqyx2fIBaUvQGNEqgs6PpaVuPo3zKImT
         Q3tiRKlgQ9AUuBHHTBLPq17XL96zfVNc4/DfUrqyy6ZjSJeIre8PkiAezAxIMnTOk/ib
         mikaQN9tKxbtsEjCV7/vZJTSd+UzINRP34wFQqGixick42qAE3kFIBSAyoYYUsMtvzuh
         IsKjzY860tn7jQE8vSWi41A90uiZjxHqdgDT1yeoTS+wp84b5EYtwmyCsG2IJxD6lQ2Y
         /CqaoK5eGrqUrIOVqw5eeOPef+Rj7XuoWsuM1ytcZnfyZQFQnV+KsHD7Or1RXsgem1pM
         lBEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AT07gM1d/snjyMuDSqF2iBtIXpjEUy5a43Ltdcejjg4=;
        b=ZwaNGKAGfsH+P3N/c443lozAlxC6KPjTQkRF6b32HJWhLPgM9lBzomJRGdM/h92+u0
         UYYmJKVvsFCFCMMeyXEFTvC2D/re6MDSa4na3lUUuPip4o7r/cP4YSgUoXGQPXwwvEvs
         DV34J6+tgk602QtODjG5IO/lhB5+FI+G3+Nuvm7UFJbv3lv/eAzC1x4ZYZq4YtoiStJH
         lB+U3cDLbS2SCHxmoX4x+9wZzEz/I1o0GAUrzdQbObFbk0XyYzSDbMPg9nwAnsfHmUeF
         4agrpBROqvDtvLObvs4JEtgKoRq/R+faRJwRwEZc24uQLXa3+IJeHBokZfsYgw2Z9fUL
         DOYA==
X-Gm-Message-State: AOAM5321GBaWRXsWWSx04yDVl0AgqxeXhMetmHtSduDUqaF5Py/5snKJ
        8znZDIni4AKU10JZD6K55OcUP+uFUeyINyq0arpm0Q==
X-Google-Smtp-Source: ABdhPJyAoTNzchIV4OsZupLeZBjHgM/VDsLdpg0/QqJnmE/7url1KCv7Er5GJi7lYwqVehF2EnRm9gV0C+awyzWwObg=
X-Received: by 2002:a19:c14a:: with SMTP id r71mr6731527lff.358.1616115638843;
 Thu, 18 Mar 2021 18:00:38 -0700 (PDT)
MIME-Version: 1.0
References: <20210318110658.60892-1-songmuchun@bytedance.com> <20210318110658.60892-3-songmuchun@bytedance.com>
In-Reply-To: <20210318110658.60892-3-songmuchun@bytedance.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Thu, 18 Mar 2021 18:00:27 -0700
Message-ID: <CALvZod7m6ZDrmv6s5dJ=j1mj2ee2nqx5ZNZmr=giYL+C1rC26A@mail.gmail.com>
Subject: Re: [PATCH v4 2/5] mm: memcontrol: directly access page->memcg_data
 in mm/page_alloc.c
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     Roman Gushchin <guro@fb.com>, Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Xiongchun duan <duanxiongchun@bytedance.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 18, 2021 at 4:08 AM Muchun Song <songmuchun@bytedance.com> wrote:
>
> The page_memcg() is not suitable for use by page_expected_state() and
> page_bad_reason(). Because it can BUG_ON() for the slab pages when
> CONFIG_DEBUG_VM is enabled. As neither lru, nor kmem, nor slab page
> should have anything left in there by the time the page is freed, what
> we care about is whether the value of page->memcg_data is 0. So just
> directly access page->memcg_data here.
>
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>

Reviewed-by: Shakeel Butt <shakeelb@google.com>
