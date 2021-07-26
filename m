Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A14B63D659A
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jul 2021 19:24:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240407AbhGZQnd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jul 2021 12:43:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238032AbhGZQnW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jul 2021 12:43:22 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A41E4C0619E1
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jul 2021 09:57:28 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id u3so16654521lff.9
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jul 2021 09:57:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4CjU2RsYvZ9x+m1FosmYIR8QGbXd8bRq67CFAxCYneo=;
        b=KE/UnX3ML3Xw/5e0wwlWbS/xgPSyv+N4V3ynbBhw+BEqgokKCdDHOAQhI2EC4em4FI
         cF66Zk05KBdsDmPSV049y02ENoBdBIMLG4JuUL2hXcmObOgnJ+De8vRbYqHytF8iNP4t
         sc/n9LmbTDHqiyzZI4oM96x5N3DbQsNV71w1NIcbajXRmFKqfDUx/qyexNcykqgooXDb
         VWGTrDPpa96AfCN0BPcHQo1ZHj7ILA7C8IZgGhGDMDPa/PAjuJIAAzwEwgYZDhJmYbQf
         QrZsjEpOLvAXRhLTggf9OOBrPFb+jgt+OJKMdnoh81XeQppUTCOTYevElzQAK8t3lWnx
         MeXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4CjU2RsYvZ9x+m1FosmYIR8QGbXd8bRq67CFAxCYneo=;
        b=kssacnRG+f5LLQQRVhJesll3Re69OTwetNUrkl2MV4WQIsbeBwGuSwszntf3nGs6XU
         AitN75qqttz1X5CQkumDbOIHd2iKWnR+EFEloCDEmtliBevDTdA1xsTPlmV1Cs5ScocF
         xcqdLyj7dCk+By5AJvyVnCi+2GGMJsHof1P7YmDkzn7ChxbN2HYHgt8vR1cj6jiN1eV6
         R6eh1jNoLIb00kHRBjB7vAZUYfYP0d3MXA3tT5//Tvgcfj6Z1/bhZDt6vitjiZ5eFT8f
         rEOZS0dEAmj6qB0A06wVUQoK2HcxhTk1JsOZGnPqTqJ+c2+99pRytRmK1FwJXlxjGHN/
         BC4w==
X-Gm-Message-State: AOAM5316Gk8i9lNRNL6G+g953aVj/Za6sWodyXlo8hLO+JkECgNgCE15
        6PisixMwjqgP/bmY1PqXVCOSSGX749OETt7/J9rYoQ==
X-Google-Smtp-Source: ABdhPJx+xXmD0VZj3AsK/ylqlmnDPoW3CElhkDtGeuoJOlJPgXEiMsg3GLTgBT867f0FFvwX6DilkeMJQOIR9Ca4ngc=
X-Received: by 2002:a19:771c:: with SMTP id s28mr13309197lfc.358.1627318646800;
 Mon, 26 Jul 2021 09:57:26 -0700 (PDT)
MIME-Version: 1.0
References: <CALvZod5-XtaeawPtEgnp9xwouy0KfuDbpykB6Z3b+8YJyCrLVA@mail.gmail.com>
 <ed4448b0-4970-616f-7368-ef9dd3cb628d@virtuozzo.com>
In-Reply-To: <ed4448b0-4970-616f-7368-ef9dd3cb628d@virtuozzo.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Mon, 26 Jul 2021 09:57:15 -0700
Message-ID: <CALvZod5Vj-_S2gRYpGgwhiCysXuA8z1WEV2ttP0t3Tdy2MU7KQ@mail.gmail.com>
Subject: Re: [PATCH] memcg: replace in_interrupt() by !in_task() in active_memcg()
To:     Vasily Averin <vvs@virtuozzo.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Roman Gushchin <guro@fb.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Cgroups <cgroups@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 26, 2021 at 9:53 AM Vasily Averin <vvs@virtuozzo.com> wrote:
>
> set_active_memcg() uses in_interrupt() check to select proper storage for
> cgroup: pointer on task struct or per-cpu pointer.
>
> It isn't fully correct: obsoleted in_interrupt() includes tasks with disabled BH.
> It's better to use '!in_task()' instead.
>
> Link: https://lkml.org/lkml/2021/7/26/487
> Fixes: 37d5985c003d ("mm: kmem: prepare remote memcg charging infra for interrupt contexts")
> Signed-off-by: Vasily Averin <vvs@virtuozzo.com>

Thanks.

Reviewed-by: Shakeel Butt <shakeelb@google.com>
