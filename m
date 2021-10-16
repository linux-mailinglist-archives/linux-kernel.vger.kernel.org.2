Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA50943011A
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Oct 2021 10:18:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239889AbhJPIUK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Oct 2021 04:20:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234696AbhJPIUJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Oct 2021 04:20:09 -0400
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6CADC061570
        for <linux-kernel@vger.kernel.org>; Sat, 16 Oct 2021 01:18:01 -0700 (PDT)
Received: by mail-qk1-x733.google.com with SMTP id r15so10667573qkp.8
        for <linux-kernel@vger.kernel.org>; Sat, 16 Oct 2021 01:18:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qBtpU0NGPIyDBRgcGwvLgPN1ll4gwJNEf+HjL9X73VA=;
        b=Svky82E+cm9/m7Rm3TkkYcCfLhrwFCLYape5s/vX7y1SArchGjSrpVdR4u04WcjJHC
         dxIV4TSQOFdrhl3b8UoWWEhlDceZy9zDEcSgxFKgo/5/TDJLazI+9oIPm15vCEHSW/W0
         SPBI9BaeJ19e76aD/8agQF5wpyuPazOJbgu5RYbImd2UYIIvMXAA+e40dUrMH+ddholE
         bTp7J/IC7sw5oFglWoz64qD/011k1dzblixGkjH029lC/SI5fGqTmi6Hv5cj6iTadLhQ
         N8sN+asP+7vNqwxsXJJsqdhQlASS8S7F92xIUF7j7PYO9ADYbxvt6k8ky/Jq97FRzrZh
         cHdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qBtpU0NGPIyDBRgcGwvLgPN1ll4gwJNEf+HjL9X73VA=;
        b=YFqDmZL1k9y39nMrn+9pu6Up772HxEeEoJGGIcXANabAa9ZrepNkLIX9EsBdxm1Z0l
         D8aUFV3WxgOMS15/0X/3u7EhEsrUthF3dl22MXSjZcWbfVvfc1u61wlMMNCFZ/ZGo/0G
         jdLkaIy9djDMAFvxvnl+mOAAP+zEfMSzRxPTrciUdvECZDBbLvdC1xIsopQCHPksrQfD
         cmeCXc15QJYXjcJcVd52Fxfm62q1E8hqFge3esNckS4CLmebAFC8vT5qQls9MJlR9ok1
         7CkFzUcma60u1SA4IYYDwftijYYzJTVAzD1Gv1hLc0E1GSI3OIm55iUgaYqTucPMLt6Z
         xzgw==
X-Gm-Message-State: AOAM533FI049Z5MFlJ0RyBqo6xCEV8oNqhGMz2Pdj8UyFcFE2zmuwN/6
        4WR7t7kT2i7SodSlRr9MrTNbHN1Jtia/q3BfUO8=
X-Google-Smtp-Source: ABdhPJwzN1J2loBo26KOeJXP9ghtavDiKtZPbbfijp5NsfnBsPQ2A9tuxgOVlehqIZc9wo7hLD+So6Q738MhLiy7m54=
X-Received: by 2002:a37:643:: with SMTP id 64mr13573728qkg.412.1634372280989;
 Sat, 16 Oct 2021 01:18:00 -0700 (PDT)
MIME-Version: 1.0
References: <1634278529-16983-1-git-send-email-huangzhaoyang@gmail.com>
 <20211015130035.aacc18a4d1ee141b306c2272@linux-foundation.org> <YWpBf2VUr/w507ak@casper.infradead.org>
In-Reply-To: <YWpBf2VUr/w507ak@casper.infradead.org>
From:   Zhaoyang Huang <huangzhaoyang@gmail.com>
Date:   Sat, 16 Oct 2021 16:17:39 +0800
Message-ID: <CAGWkznE6x=x_xOcnD4-2d0_kkYSFbV2ReWUL_an=CnEZubH9Cg@mail.gmail.com>
Subject: Re: [PATCH] mm: skip current when memcg reclaim
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Zhaoyang Huang <zhaoyang.huang@unisoc.com>,
        "open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 16, 2021 at 11:06 AM Matthew Wilcox <willy@infradead.org> wrote:
>
> On Fri, Oct 15, 2021 at 01:00:35PM -0700, Andrew Morton wrote:
> > On Fri, 15 Oct 2021 14:15:29 +0800 Huangzhaoyang <huangzhaoyang@gmail.com> wrote:
> >
> > > From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> > >
> > > Sibling thread of the same process could refault the reclaimed pages
> > > in the same time, which would be typical in None global reclaim and
> > > introduce thrashing.
> >
> > "None" -> "node", I assume?
>
> I think that's "non-global", ie memcg based.
It is exactly what I mean. memcg based reclaim could be worse for page
thrashing.
