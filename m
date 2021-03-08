Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A166A331530
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Mar 2021 18:49:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230475AbhCHRst (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 12:48:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230522AbhCHRsj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 12:48:39 -0500
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D85D8C06175F
        for <linux-kernel@vger.kernel.org>; Mon,  8 Mar 2021 09:48:38 -0800 (PST)
Received: by mail-lf1-x134.google.com with SMTP id e7so22433154lft.2
        for <linux-kernel@vger.kernel.org>; Mon, 08 Mar 2021 09:48:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=giD8jSsyZJtO1DBnfL0AaLcvwbpWQ52I68uSxFCyz/k=;
        b=QPpLMFgSpH9WgV4NcTrB7d+hZtjE/5GT3F2G644kSvUU9b3EGps3rmRAaXpJdfSNrw
         nBbGd4eLyVIbdTkY7G9viNOngWpUPb8hF3N6jNc8xSGecRsOjJJ18VOIDrclO79YnIej
         M+KgZzdCA1b5KoWhpxEZz0iXTRSimI/UDdN7cNiISFBjW9ksoNl6GN+FvNbU8wYWq6zk
         h7K3H4Ih+dZSluL+jMFMYRNXk+3Nv02Ztvu/bvSes259hNSUnyW9tNlloRckDhyGcL26
         +f9oprjrH1qwP+ILRdp54S1RPGcKQvitB+ByslpCOaMXBdB3UJXh/MvLiCoFJH04MSVA
         Y7Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=giD8jSsyZJtO1DBnfL0AaLcvwbpWQ52I68uSxFCyz/k=;
        b=LetvLWO0+dOYuc+j9Z05imNOW8AsszYwVncc1/IZTKPBbxB6NYlGSisqheluWDiHTz
         kG6oPfdCLf5FSIZn5/lyeissmiXdCdoVfRkz0E1c6sUw0gsBinlEG1ZLcWppRVoC96C5
         ZglaGadkFSsVFi6miMb6n2KL07uJD80iMpg793RqSnU3GLslNU47/8GhA+RucMy2W2qa
         82Do7SW3KTWRkMT2UkAuejeAQaQahijwRMwin8Q8I5rugkiLT4USGEpU3IKlxJVU7OZr
         Vb9+BD23JIkWuWZ7cbICcimkyXMmDRk3J29vPBPDVIjGvwLdz0Rb37X6JxeiNcCdo+ZS
         iP3w==
X-Gm-Message-State: AOAM53037WrPNvoqL7Le61Db0NPtF1OaZWzrEf5qgsnHz+K5iDgC5QQY
        Tkqy5Llj1KrEWO1m+7OetVFHRGuX0aR8jhLYYDRHUg==
X-Google-Smtp-Source: ABdhPJw7Hi0i7dAd1dfvZWz3HJ1oxl9iDjYmhMQmd2hfeQvGJcpHO+DIsojeXKaCQlDDTS3CbgYU6Vn1r2LSkTkJuX0=
X-Received: by 2002:a05:6512:6c6:: with SMTP id u6mr14739762lff.347.1615225717126;
 Mon, 08 Mar 2021 09:48:37 -0800 (PST)
MIME-Version: 1.0
References: <20210217001322.2226796-1-shy828301@gmail.com> <20210217001322.2226796-9-shy828301@gmail.com>
In-Reply-To: <20210217001322.2226796-9-shy828301@gmail.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Mon, 8 Mar 2021 09:48:22 -0800
Message-ID: <CALvZod7AJ9EAxDhDU-MddFieO9n6C4gEbbR=sprmRWvLJpHo_A@mail.gmail.com>
Subject: Re: [v8 PATCH 08/13] mm: vmscan: use a new flag to indicate shrinker
 is registered
To:     Yang Shi <shy828301@gmail.com>
Cc:     Roman Gushchin <guro@fb.com>, Kirill Tkhai <ktkhai@virtuozzo.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Dave Chinner <david@fromorbit.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 16, 2021 at 4:13 PM Yang Shi <shy828301@gmail.com> wrote:
>
> Currently registered shrinker is indicated by non-NULL shrinker->nr_deferred.
> This approach is fine with nr_deferred at the shrinker level, but the following
> patches will move MEMCG_AWARE shrinkers' nr_deferred to memcg level, so their
> shrinker->nr_deferred would always be NULL.  This would prevent the shrinkers
> from unregistering correctly.
>
> Remove SHRINKER_REGISTERING since we could check if shrinker is registered
> successfully by the new flag.
>
> Acked-by: Kirill Tkhai <ktkhai@virtuozzo.com>
> Acked-by: Vlastimil Babka <vbabka@suse.cz>
> Signed-off-by: Yang Shi <shy828301@gmail.com>

Reviewed-by: Shakeel Butt <shakeelb@google.com>
