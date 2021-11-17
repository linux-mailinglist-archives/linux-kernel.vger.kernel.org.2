Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E9CB454298
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Nov 2021 09:25:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234498AbhKQI1t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Nov 2021 03:27:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229944AbhKQI1s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Nov 2021 03:27:48 -0500
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EB10C061746
        for <linux-kernel@vger.kernel.org>; Wed, 17 Nov 2021 00:24:50 -0800 (PST)
Received: by mail-yb1-xb32.google.com with SMTP id v64so5132047ybi.5
        for <linux-kernel@vger.kernel.org>; Wed, 17 Nov 2021 00:24:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+dwLMWwu2Sg6Zp6UBhanSJhQWX+9Ri/lE7Vz/ZzVQW8=;
        b=KEd38Wn7TzD3I3/2UFVRny4FBayUkc4zOIqRwirdxOvtJbh68KYi4Dwor3Rr4gYaZ4
         TCKkY4lEI/isRi8POMt6NdUlOrn3BV5OjCU5rABCJLuJs/MeK18g+hSoapeInRiUQTZS
         2Rkz6dPgn//ebUyRv96jQnVZ6dQLJejuPzaonL/4CWAwl2ldG+Js/BFbCNJwP7r9zn5n
         UjKBFYeh42Tloizcn3tswp2r7hv+6rY8dnJ2FNl20h57jfdhaiuLFD6/45Xy7KO7N/kx
         o+IPi0QrJIC7XKGkZJeYiYlEi169lRYd9xq2NK0z36M5MdZFIsqYlkKdW3el/H1T/sXZ
         KfQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+dwLMWwu2Sg6Zp6UBhanSJhQWX+9Ri/lE7Vz/ZzVQW8=;
        b=uUE8Ca34b8kL/hcrz6y2fW7LOzTvRealhNimUh2NX/e0nw9NjhgRQLhiT7yK9G/2xZ
         2dlMa9/un1ZsCs9m4GeQK+FvysG8GD9n1X5l02Gj6suooUnmozgPI7IFfA761835d2PZ
         1fV/gXxXpHkyqAwPzPrdbujUUlQi0eQy7PihQlMw2CpCXvyqF4j79VOrU0Kq7Xx+YZhD
         gIi0Ao9XPE0hucx9OXtzdmwI9LurvYh2co1TVUQgB0BPOsg1pVOBzXwFMOW0HSpHz2zN
         fPpLlVfUymtO87zGa79YIdoNiwD8Yh9Ptapyql9Z7KrsYCKF6zuvIYHBws2SqTppIfBl
         je2A==
X-Gm-Message-State: AOAM5310Hxa+wJYOGd6pxyr5b8CYz2IiaPOqv4hNymZ7Tuq7hSYFshR4
        aGWovNVHFhMYr0jzqp8HWg0Im20V0xa0PNvxJfc6+A==
X-Google-Smtp-Source: ABdhPJwGJbbxTf6Disa8MHoyMDjfXsaOHQj50AZDsVTHLxfNBX/W1iLb8oDmjtVG3srUA3wmNoCScUe6NSE8AHKMeww=
X-Received: by 2002:a5b:648:: with SMTP id o8mr16436713ybq.208.1637137489382;
 Wed, 17 Nov 2021 00:24:49 -0800 (PST)
MIME-Version: 1.0
References: <20211101093518.86845-1-songmuchun@bytedance.com>
 <20211115210917.96f681f0a75dfe6e1772dc6d@linux-foundation.org>
 <CAMZfGtX+GkVf_7D8G+Ss32+wYy1bcMgDpT5FJDA=a9gdjW36-w@mail.gmail.com> <20211116120104.f96b7f21a333c2c8d140e015@linux-foundation.org>
In-Reply-To: <20211116120104.f96b7f21a333c2c8d140e015@linux-foundation.org>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Wed, 17 Nov 2021 16:24:10 +0800
Message-ID: <CAMZfGtWQRHFWAyrfoZ3tV67FFLJH7T=Wi2QVoiO=S9w=s0S7Kg@mail.gmail.com>
Subject: Re: [PATCH 0/4] remove PDE_DATA()
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Alexey Dobriyan <adobriyan@gmail.com>, gladkov.alexey@gmail.com,
        LKML <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 17, 2021 at 4:01 AM Andrew Morton <akpm@linux-foundation.org> wrote:
>
> On Tue, 16 Nov 2021 16:26:12 +0800 Muchun Song <songmuchun@bytedance.com> wrote:
>
> > >
> > > because new instances are sure to turn up during the development cycle.
> > >
> > > But I can handle that by staging the patch series after linux-next and
> > > reminding myself to grep for new PDE_DATA instances prior to
> > > upstreaming.
> >
> > I'd be happy if you could replace PDE_DATA() with inode->i_private.
> > In this case, should I still introduce pde_data() and perform the above
> > things to make this series smaller?
>
> I do tend to think that pde_data() would be better than open-coding
> inode->i_private everywhere.  More explanatory, easier if we decide to
> change it again in the future.
>

Got it. I'll do that in the next version. Thanks.
