Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C8B53884E7
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 04:46:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237344AbhESCr5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 May 2021 22:47:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237317AbhESCry (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 May 2021 22:47:54 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 925CBC06175F
        for <linux-kernel@vger.kernel.org>; Tue, 18 May 2021 19:46:35 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id 6so8396083pgk.5
        for <linux-kernel@vger.kernel.org>; Tue, 18 May 2021 19:46:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3oKf702PEbD0KgHhqbOOlCx3u4B7PMOfRt+UxLAg7G8=;
        b=DahOTgTUjM1KUUHRUvQbkfghT7XtTaeR1ZD8p+YUtUmYNg3rK1uKrPiyZc+vKyshFQ
         CjRg1ccugRwRw5P4GMqx2celpfFUSO7M7ordUkGM5KK/v/0WuHnkoQ2rMyo5R7eheO3v
         jTgmQRkS4G4ISSRyPK/NhRZS71pqmAjfQqDWkuSTRBqM3krlbEOp1+OKc0uv061wBv7y
         FAhG+QzGTqycf3jSoAWruoOqYSMgU/9dSJLI/MyG0R5ZdwLzEyrYh3nK/f5m6iJiTh51
         wZEYaCFVHm9LtYn0IGdKaNCj0hfwvtHOysJ2KBr+TnZewhqvK9Kv9iJ/YNbz1EGKMqC/
         iBGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3oKf702PEbD0KgHhqbOOlCx3u4B7PMOfRt+UxLAg7G8=;
        b=KBaqnow+7ZmdkVJepK0RnQ9P8yqVQ+/nHRPHDsA7qG4zRJEst5EQlHnEc5mZBwbRPQ
         pj5xrk8/IeRcCbBaK4FePZ1FCo/Np3hXTiBikWkagV+OgwqcrIV50D/Akb3n1ooU7ICJ
         IjqkmdbCb3o/F3EreFtfc6fmvDaTpxwCKdhs6uQzj/U+g1dc9SQU3Y0TeUaBgqW4OU71
         RkwNt3N9Vd1aZkgJxUjbr+t/+4k9YzNAbOajKjzujVeHyej9XoNtc73RD3RCaIjNSQr/
         5jGSvcMihA79BL/EMM55UabYj+T6jh+Q+Cfi0zDof1Z3HGYUNY+w1CUucLRJWhoK1N3U
         Zt8Q==
X-Gm-Message-State: AOAM531Wv9N97PYwojAwRXsCYMYuLZvwjIJ8bWDb8xQcj31UVRVgphzG
        TP9EQKAbcFJXUc1f1qfnx9vQSL4tzdJcNdRpsR2nog==
X-Google-Smtp-Source: ABdhPJwh1S1YjqxpZ8b/6I4sMVGYr8Hl+pSnoVcWipGGK/3QdtG6o06lxtCcQyuYS/BfPh9GDOTmyMf5O2ZhB4uEtQY=
X-Received: by 2002:a05:6a00:2493:b029:2c4:b6dd:d389 with SMTP id
 c19-20020a056a002493b02902c4b6ddd389mr8454656pfv.2.1621392394921; Tue, 18 May
 2021 19:46:34 -0700 (PDT)
MIME-Version: 1.0
References: <20210518200910.29912-1-wenhui@gwmail.gwu.edu>
In-Reply-To: <20210518200910.29912-1-wenhui@gwmail.gwu.edu>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Wed, 19 May 2021 10:45:59 +0800
Message-ID: <CAMZfGtUOaeWS870RoU93PVqritd2hR6bWBzuH2uWfxYh5pmp6Q@mail.gmail.com>
Subject: Re: [External] [PATCH v2] memcontrol: use flexible-array member
To:     wenhuizhang <wenhui@gwmail.gwu.edu>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Shakeel Butt <shakeelb@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <guro@fb.com>, Michal Hocko <mhocko@suse.com>,
        Yang Shi <shy828301@gmail.com>, Alex Shi <alexs@kernel.org>,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        Wei Yang <richard.weiyang@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 19, 2021 at 4:09 AM wenhuizhang <wenhui@gwmail.gwu.edu> wrote:
>
> Change depracated zero-length-and-one-element-arrays into flexible

s/depracated/deprecated/g

> array member.Zero-length and one-element arrays detected by Lukas's CodeChecker.
> Zero/one element arrays causes undefined behaviours if sizeof() used.

s/causes/cause/g

>
> Signed-off-by: wenhuizhang <wenhui@gwmail.gwu.edu>

Reviewed-by: Muchun Song <songmuchun@bytedance.com>

Thanks.
