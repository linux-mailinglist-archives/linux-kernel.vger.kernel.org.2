Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E08AD350CE3
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Apr 2021 05:05:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233309AbhDADFF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Mar 2021 23:05:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232565AbhDADFC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Mar 2021 23:05:02 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8D22C0613E6
        for <linux-kernel@vger.kernel.org>; Wed, 31 Mar 2021 20:05:01 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id g8so595909lfv.12
        for <linux-kernel@vger.kernel.org>; Wed, 31 Mar 2021 20:05:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZpcCB/yZQjtxmSvNwUXuvC5WufLzW9NTW+SZzfG26SM=;
        b=mJnD+5/FcW5QnDfIuw+SnVPNl2bvvbhjw1V0N75DirqvwNJIO/pUXTfBBZMvOc1NRs
         YeyW0p4U684hJpTDV2eplcbtYR7zA8ezWrYqx7mrzgSZxe1ZcIFzcMG4Kd0PA/m22tQj
         goSs7P1t/a9nRxjGJFaN/WIIKHq5LOuA0ExkAenn8kiUOuNgVYj/DIERFC9U4Cya4XrR
         GuXstKeU5Brz8B66dJ3XPlzh+xT9YRBc3weiwmLoYPvE94zZrCjz5kw9S5d5BswVTGug
         koBeOdILy8N2MLFcBO7lCwyn6AwkSItbPLUQX4LdB96mXpALU5F73fhfnJbOOass8lPD
         G8+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZpcCB/yZQjtxmSvNwUXuvC5WufLzW9NTW+SZzfG26SM=;
        b=e1xD6kPr5iwAOu+AzUykRpdER/XXOyxC54NB7TT/Cm9GMZVaUGF1wr3h+TMD1Ym10b
         d60rZ+lcmFWRFyOZNhHw6Y8W4Xz09men7LNKyDdJNO0fZ6KiNJJL12A3bJxZemeCEke5
         C3hD3w8Bj6xzcld52BdNWfOAZYOMu3gnY5gWjDcM4Ekt8NjnIHD6fajViZNDAxwZaF62
         tO9Bz4LpHfG5AnEIvVTBGNWYgVa3h2IFd3jlmc7PcRmGrUw0upHe5xM7UQiSHdzuLp0O
         NRBfFIEdxBGzPANWKrJOse6DWrO6/6LT8UHgDXkHsTQKY6PWwdUl/4wWM6hzgdtEzGvh
         1elg==
X-Gm-Message-State: AOAM532HAwzS7B+VgIXu19/jHoTT9lCiZWR1A2RHnwXeBezHRp9wR1K/
        e0AExE0ccI/tQgq/9fdtfLLYPLG8gcEFwrxZBqIhVA==
X-Google-Smtp-Source: ABdhPJxeBWfBerpuLkGNVe2O9e6TVk7trrvnG4MJ2jJfArwOZuk4pADR9W1gH8d8mGTZ2Te3q51sil8dMXGkjBnNdw0=
X-Received: by 2002:a05:6512:2356:: with SMTP id p22mr3918376lfu.347.1617246299839;
 Wed, 31 Mar 2021 20:04:59 -0700 (PDT)
MIME-Version: 1.0
References: <20210401030141.37061-1-songmuchun@bytedance.com>
In-Reply-To: <20210401030141.37061-1-songmuchun@bytedance.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Wed, 31 Mar 2021 20:04:48 -0700
Message-ID: <CALvZod6pg1N4FLEAtjD5=nfBr9vA-3G-BBezbW=PhuOY+d__1g@mail.gmail.com>
Subject: Re: [PATCH] mm: memcontrol: fix forget to obtain the ref to objcg in split_page_memcg
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     Roman Gushchin <guro@fb.com>, Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Xiongchun duan <duanxiongchun@bytedance.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 31, 2021 at 8:02 PM Muchun Song <songmuchun@bytedance.com> wrote:
>
> Christian Borntraeger reported a warning about "percpu ref
> (obj_cgroup_release) <= 0 (-1) after switching to atomic".
> Because we forgot to obtain the reference to the objcg and
> wrongly obtain the reference of memcg.
>
> Reported-by: Christian Borntraeger <borntraeger@de.ibm.com>
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>

Looks good to me.

Reviewed-by: Shakeel Butt <shakeelb@google.com>
