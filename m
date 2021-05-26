Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F25D5390EDC
	for <lists+linux-kernel@lfdr.de>; Wed, 26 May 2021 05:30:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231614AbhEZDcR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 May 2021 23:32:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231410AbhEZDcP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 May 2021 23:32:15 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B587BC061574
        for <linux-kernel@vger.kernel.org>; Tue, 25 May 2021 20:30:27 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id v12so17420415plo.10
        for <linux-kernel@vger.kernel.org>; Tue, 25 May 2021 20:30:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=y5w76b7HEyp3T0g1tHDuWx3/iumM0HDwwVPmTmEiu+I=;
        b=vU3F2Ae2W3UovSzLt2rEnrcQI0TTq6l+vpJPd/eE66SlsYLF07zVs7/tgyvFU4eMKg
         d5j8K2+LnMw8nw4CvJlPxyvfKmvWNPqzfUrhG51LOTVf9FYLO5cqf1tgcsjOSsx47rAt
         lG0LrG8o9clUiB+TmTeouOvd0Syv/itJcAvRo/ZjF5AeznlkRwVgiR92X42x9++nj1wB
         WuNyMzyQlsI6Mx09n2mAUz9RsU53eCHa5+MAti7fPciOp+HLj00wArWqIpdIKcL7WSdF
         8tNa+aLEnX+5xc1Wcq0InOf3s2wGNKNYHXK5djvwRfdpfmoZ2VpjYoeOTvPBT3SksI7k
         jIxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=y5w76b7HEyp3T0g1tHDuWx3/iumM0HDwwVPmTmEiu+I=;
        b=fWYeEJYEwPYWgbOF1BC/1bTI0pZoYliXbYDeYpDR+D5rm/gVUfwOt50YXQN1O2ATf4
         D1V2TmiNC1y530x7vQbu2K+UqFKlZQm5Wcs1rBmmD4QyI4F+xU6iI9pIqV7ByuhiQUF7
         AcWwjnxeyyVni1rCKve2xGLmvZJ3x7pGigsZG3yWkAyML4BBpoIGooBs5B/emjHzI3J3
         70u4yjxe4BhOoKiUhNFwNRxAiKgYUoIVG+GC6BFWizsyOi85AgKsLpbds/GKspgDjzL3
         9NVniosHp1bv4lv/4yZ1hKrIizuOSmTMti+/xfp3Nmkh4ZaZvl5LskVLXFTUfaxdeHTc
         lVNA==
X-Gm-Message-State: AOAM533mRXdHTCFTy/7Qo025PzOOY8CdXAQhBKeDWkxr+mBuCJY5VZqA
        sEYbi9Kn0JHjcsEAWPipAN+lrC1Nl2a5/MSLB+x9Yg==
X-Google-Smtp-Source: ABdhPJzHsfM9Lqly6YtQzpJc1P8G796gXX5S/HnxbZlUaIH0Oo+ng7hq9t3dVAasZrnNNNC4yaVAGs58PoW7DXpyt6I=
X-Received: by 2002:a17:902:d711:b029:f0:b127:8105 with SMTP id
 w17-20020a170902d711b02900f0b1278105mr34087065ply.20.1621999827170; Tue, 25
 May 2021 20:30:27 -0700 (PDT)
MIME-Version: 1.0
References: <20210526025625.601023-1-swboyd@chromium.org> <20210526025625.601023-3-swboyd@chromium.org>
In-Reply-To: <20210526025625.601023-3-swboyd@chromium.org>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Wed, 26 May 2021 11:29:50 +0800
Message-ID: <CAMZfGtVF+D_o3V8TEt5ro03TELT2RibWZp=b8H+4pNR1gJh6AQ@mail.gmail.com>
Subject: Re: [External] [PATCH v2 2/4] slub: Actually use 'message' in restore_bytes()
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Petr Mladek <pmladek@suse.com>, Joe Perches <joe@perches.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 26, 2021 at 10:56 AM Stephen Boyd <swboyd@chromium.org> wrote:
>
> The message argument isn't used here. Let's pass the string to the
> printk message so that the developer can figure out what's happening,
> instead of guessing that a redzone is being restored, etc.
>
> Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
> Acked-by: David Rientjes <rientjes@google.com>
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>
>

More convenient. LGTM.

Reviewed-by: Muchun Song <songmuchun@bytedance.com>
