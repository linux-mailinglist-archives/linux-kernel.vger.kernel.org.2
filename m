Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED5E03E8513
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Aug 2021 23:18:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234273AbhHJVSh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Aug 2021 17:18:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229582AbhHJVS0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Aug 2021 17:18:26 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D92F2C0613C1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Aug 2021 14:18:03 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id w20so723241lfu.7
        for <linux-kernel@vger.kernel.org>; Tue, 10 Aug 2021 14:18:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=O2QGnhDG5CSFWe5z6crf4E+5alhrIaUs/gP83zlfZBI=;
        b=tmtzT47381evbjLQpTnvmFQRXXJoB0NJyL05u/jg9ydoMZmqZfePU27QxbY2NHMkGQ
         BmkLyxl3a17yBIMTkZ3LibcLX3p2A1P12Zo+OfdjNFNjmV6TfTEMAeHFD/DYo9JMx0p4
         8X8miZg5EpID649V56KR7uqqin/BJBd9lXkLY9LvT2MRXekvFfRcNuafav08Kf/nzRBr
         MKt+Co7QjoJs3v88DUtKg9TRg68c2ztvNeQQLu7PNcCg/cRU7mdChqxSZTGFkDRqNmtz
         PrGpq3lRIg2jGO/S2B0+Q0aHrtdeQ5Wy/+OHlwrMxQF/PYnsqyjrAAskVkGPyQFWD/Ix
         JwCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=O2QGnhDG5CSFWe5z6crf4E+5alhrIaUs/gP83zlfZBI=;
        b=uaAhZ05pvJJRJIY221Tk0LLdgac+3DtsuOQC1x1JIwL8bGb7dOzvdGMX8xu5dPB+mA
         pyopocy+FkqC7rh5S+liUy3pgWwyRgQyjMXcWISRisEgwCah18axHOb37afG7nmlnqfJ
         THxPNASB+BGw0Ywr0aDyLpaKjacXxN5xYQzVXC1et6UorcRgamWudvMKhxHaGeezZ2az
         OK6+rOVHGRYE3L3Xf44UEpugkwWxH4tZ/tD5i/bboroyMOnEixgKahKU51384OvNZBfT
         w8wXk+Q3fwelUlzU4PJvz4n/gJrPjhH8xtrZPLq9k5yyPusmR8NKdo61kLsPgr0JGTYt
         CyVw==
X-Gm-Message-State: AOAM532iRorQYOod5VK+asR0Sm00OHSHaUQQDNhs5WlD+c+n+79lESoT
        KZLfjDJI732AecYj1qX7oq+/w/Fp4z4jxgXlFMij+A==
X-Google-Smtp-Source: ABdhPJwSjT1TOy4jCVN4TEDzLsf9wTHNWPDJhQA1WEafUY3JEYUClPK0FKoIycqvFSxxCvh4e3tHkWoLmG9QtQ/EgPg=
X-Received: by 2002:a05:6512:23a7:: with SMTP id c39mr23004537lfv.358.1628630282092;
 Tue, 10 Aug 2021 14:18:02 -0700 (PDT)
MIME-Version: 1.0
References: <20210809223740.59009-1-npache@redhat.com> <YRKa0yzEDALtvSZO@cmpxchg.org>
 <a7afc485-9036-8f09-e582-f2eb45620670@redhat.com>
In-Reply-To: <a7afc485-9036-8f09-e582-f2eb45620670@redhat.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Tue, 10 Aug 2021 14:17:50 -0700
Message-ID: <CALvZod5L+cyON5qRX3eSdHbo+-H7VDQeFuYYNqpK5diCcv9OMw@mail.gmail.com>
Subject: Re: [PATCH v3] vm_swappiness=0 should still try to avoid swapping
 anon memory
To:     Nico Pache <npache@redhat.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Linux MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Rafael Aquini <aquini@redhat.com>,
        Waiman Long <llong@redhat.com>, Michal Hocko <mhocko@suse.com>,
        hakavlad@inbox.lv
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 10, 2021 at 12:24 PM Nico Pache <npache@redhat.com> wrote:
>
>
[...]
> >
> > I'm wondering how you're getting anon scans with swappiness=0. If you
> > look at get_scan_count(), SCAN_FRACT with swappines=0 should always
> > result in ap = fraction[0] = 0, which never yields any anon scan
> > targets. So I'm thinking you're running into sc->file_is_tiny
> > situations, meaning remaining file pages alone are not enough to
> > restore watermarks anymore. Is that possible?
>
> Yes DEACTIVATE_ANON is enabling the file_is_tiny case in shrink_node(). That is what im trying to prevent in the swappiness=0 case.
>

Can you please explain how DEACTIVATE_ANON is enabling the file_is_tiny case?
