Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61555331B14
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Mar 2021 00:43:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231949AbhCHXmh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 18:42:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231176AbhCHXme (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 18:42:34 -0500
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6DB1C06175F
        for <linux-kernel@vger.kernel.org>; Mon,  8 Mar 2021 15:42:33 -0800 (PST)
Received: by mail-lf1-x129.google.com with SMTP id x4so17247912lfu.7
        for <linux-kernel@vger.kernel.org>; Mon, 08 Mar 2021 15:42:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=i3wczvVopU3eBDGEG7ZNdbOyFhgV2A3fVVB7AWEQiZg=;
        b=PNrAT/GB0kR/7bfQEgCzcjgTKuBDVnyKYXXcLOygNFWcCCbzwM3J03XVXUhypZqIBg
         lGMmWIGpGtZAD2jUWPQHXkuGMolwsFtAGBvwvfU5iCh1nLxkwnpcdwUzLxO9W/lqbkxE
         40rOK2m7w2jkKRSCwRTblKiwMx3gKKeRF/zh3Ko7Ol7RvDZzKwlPv4Dq3GVnXTDMS61d
         Syap6vPMxttc6c70sla32n4CudwRhrMY+vlvXnLcrxtV956aMyXncOFsWv1Yv1f4g/5j
         +4xHMQag/4A8da/t30dIA90dP0pWWrr4T2uTWRutQrMpsUWTiyvGz6WLn/GHzRt2DEv4
         7kRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=i3wczvVopU3eBDGEG7ZNdbOyFhgV2A3fVVB7AWEQiZg=;
        b=WqQsUEr8k1AvQgkDhpllA6M+PNEMz8M+cWVb3qdURHfvlnFug7SMW62lFy8+kQFBP3
         NmghI5mPYO68oLGb5IGopPIRxhFo+SgDaNreymjYgIpwSSOmPTc+GFHBRc1KNT26pY4c
         R9ClY6ulcXLGDzBdRvpcZdOPQvEY8M0Wfa9DsfkXRdFIfMnw1YJCkBkwmsFq5znlW2pv
         qdxISWxkpppIlUqojWZw7020abOzKgpoPeMb1kMXIgPTcbGjH8sipIbRfdtU43YAkS3I
         vupLRGWb/qsoPvAFYxOSX0iBw/YXklTHCD4xLqle+5KoTo9I6sR0WLsvmzsKOMJyUsxR
         KoZw==
X-Gm-Message-State: AOAM531tVW0C+4vbB4BhJ0Ungif6qScqNDflFFpTT2yerpgA2tVQBo+E
        C6387bhu1Bhcb42Cx463H+yt+Svhplmiyy7Blt8Y5A==
X-Google-Smtp-Source: ABdhPJwtnqfnyTJerkr1SGe1W/uEu8OjrsiI8T1EwhTZ46JEs6h5twRB6jLutZ83oSow3wdnPh+YQo0ti0w4zf6gMWc=
X-Received: by 2002:a19:c14a:: with SMTP id r71mr15617369lff.358.1615246951991;
 Mon, 08 Mar 2021 15:42:31 -0800 (PST)
MIME-Version: 1.0
References: <20210217001322.2226796-1-shy828301@gmail.com> <20210217001322.2226796-13-shy828301@gmail.com>
In-Reply-To: <20210217001322.2226796-13-shy828301@gmail.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Mon, 8 Mar 2021 15:42:20 -0800
Message-ID: <CALvZod7Nci=fMN98h28gz8KMsWguNuujxrK6FZeuNigg8-_j4Q@mail.gmail.com>
Subject: Re: [v8 PATCH 12/13] mm: memcontrol: reparent nr_deferred when memcg offline
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
> Now shrinker's nr_deferred is per memcg for memcg aware shrinkers, add to parent's
> corresponding nr_deferred when memcg offline.
>
> Acked-by: Vlastimil Babka <vbabka@suse.cz>
> Acked-by: Kirill Tkhai <ktkhai@virtuozzo.com>
> Acked-by: Roman Gushchin <guro@fb.com>
> Signed-off-by: Yang Shi <shy828301@gmail.com>

Reviewed-by: Shakeel Butt <shakeelb@google.com>
