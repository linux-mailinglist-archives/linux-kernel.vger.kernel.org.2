Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B946437F7EF
	for <lists+linux-kernel@lfdr.de>; Thu, 13 May 2021 14:29:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233858AbhEMMao (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 May 2021 08:30:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233305AbhEMMah (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 May 2021 08:30:37 -0400
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A97FC061574
        for <linux-kernel@vger.kernel.org>; Thu, 13 May 2021 05:29:26 -0700 (PDT)
Received: by mail-ot1-x331.google.com with SMTP id u19-20020a0568302493b02902d61b0d29adso22649651ots.10
        for <linux-kernel@vger.kernel.org>; Thu, 13 May 2021 05:29:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+ezfSFfJxSbieIos+EnfafkeKIzxk7khtzg+M9RSJd8=;
        b=sAcBuSmpbS+D8fp3Ei+oMaQjsQjQNu0BkNztT7iN1crix8HzuIh591hLpJjTikEA/q
         Dcti+KYeyftxmGmDQBIi0UZM6U6Ul777Uh//0pRa24iQBOeZcCQzr2dsSczINxewDKWr
         j+FyKybKFwejM6NSknzKgLelnIcBpui7MHSjGSt2rabrKgj9yUwnlbNjrUUUMkCF87zL
         4JwLtSzOhMDd++lQUUzwXMnm//wsU+B0XXWQ/dSp2s5YQHv0M6xuON3hXDhLJ2G3D6oZ
         Gzt7pS+T0F54Pt5r9zapQ55w0XxgvXisPyKJDzab9YscaWVxepHuns2GVgRI6fCW1CUZ
         73yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+ezfSFfJxSbieIos+EnfafkeKIzxk7khtzg+M9RSJd8=;
        b=OWgiZ1h9K27Sbf3GoARNQPvS4y2ZjkYKyiTyofq78FJ0vq9u8JxA74IgxAtk0Psi3B
         XWOBjZ5CZlTfMgKYz9lHoXLQEOwK95Jdw8KOKUPDITJaZnPqCaqVo+CwMOIBZc6gAzb0
         KDxV12fZ65c4nbhjH3BcCUW0EbXn2cOnm3bev9L8B6QKXuhDz/R+eX84dAh6lwegN59U
         LydgHyGBoLGW32tvyU+QsBJc4qKuDwQo9m9H7LiMGwKoZmWaRebDk79meJ9n3Vo+HFah
         6yBj5JxRfD1kApP9J5GFgiXiqzKdXSUogZvQjEIOT+w8D3msbiFcutMtF3CiJXIiPkxR
         G6bw==
X-Gm-Message-State: AOAM532JDytp5XFJgHGn9jbcgAJmgVq9cr3kjhPEaYO3emOg6/8o1LTv
        920Yk2oM4oPmj/nJuZ0v2aKM7/M0CD3ZoPvvA/lRDQ==
X-Google-Smtp-Source: ABdhPJxwfJ0VI3VMKc0QUe+/3wr9AdpfCaTuLaJ8HM4mJxTqRiy4fBg7C/PMhd3TFygFaSFrQ/99rSn1iMs3EmDVhJY=
X-Received: by 2002:a9d:1ea9:: with SMTP id n38mr36276163otn.233.1620908965175;
 Thu, 13 May 2021 05:29:25 -0700 (PDT)
MIME-Version: 1.0
References: <20210511173448.GA54466@hyeyoo> <20210512195227.245000695c9014242e9a00e5@linux-foundation.org>
 <20210513031220.GA133011@hyeyoo> <20210512204024.401ff3de38649d7d0f5a45e8@linux-foundation.org>
 <20210513062809.GA319973@hyeyoo> <a36ab9a1-f07a-42ca-bb11-5bd0c70660bb@suse.cz>
 <YJ0ACtMpasnoZdUp@elver.google.com> <20210513120339.GA772931@hyeyoo>
In-Reply-To: <20210513120339.GA772931@hyeyoo>
From:   Marco Elver <elver@google.com>
Date:   Thu, 13 May 2021 14:29:13 +0200
Message-ID: <CANpmjNP9AQ2PH9wtZbZ3bT=0YAqnaPpxAN0LgrjBO_PhzG5tjQ@mail.gmail.com>
Subject: Re: [PATCH v3] mm, slub: change run-time assertion in kmalloc_index()
 to compile-time
To:     Hyeonggon Yoo <42.hyeyoo@gmail.com>
Cc:     Vlastimil Babka <vbabka@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        David Rientjes <rientjes@google.com>,
        Pekka Enberg <penberg@kernel.org>,
        Christoph Lameter <cl@linux.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 13 May 2021 at 14:03, Hyeonggon Yoo <42.hyeyoo@gmail.com> wrote:
> On Thu, May 13, 2021 at 12:31:38PM +0200, Marco Elver wrote:
[...]
> what about checking size it on top of kmalloc_index? because by definition of
> KMALLOC_SHIFT_HIGH, it's not always 25. it can be less than 25. for some
> situations.
>
> below is what I suggested beofre. for just reference:

This doesn't solve the problem. We want the compiler to complain
whenever kmalloc_index() is used with non-constant in normal code. But
it should be possible to use it in allocator tests regardless of size.
Either that or export kmalloc_slab(), but I think that's worse. I'll
send my patch with an updated comment.

> --- include/linux/slab.h.orig   2021-05-12 17:56:54.504738768 +0900
> +++ include/linux/slab.h        2021-05-13 15:06:25.724565850 +0900
> @@ -346,9 +346,18 @@ static __always_inline enum kmalloc_cach
>   * 1 =  65 .. 96 bytes
>   * 2 = 129 .. 192 bytes
>   * n = 2^(n-1)+1 .. 2^n
> + *
> + * Note: there's no need to optimize kmalloc_index because it's evaluated
> + * in compile-time.
>   */
>  static __always_inline unsigned int kmalloc_index(size_t size)
>  {
> +       if (__builtin_constant_p(size)) {
> +               BUILD_BUG_ON_MSG(size > KMALLOC_MAX_CACHE_SIZE , "unexpected size in kmalloc_index()");
> +       } else if (size > KMALLOC_MAX_CACHE_SIZE) {
> +               BUG();
> +       }
> +
>         if (!size)
>                 return 0;
>
> @@ -382,8 +391,6 @@ static __always_inline unsigned int kmal
>         if (size <=  8 * 1024 * 1024) return 23;
>         if (size <=  16 * 1024 * 1024) return 24;
>         if (size <=  32 * 1024 * 1024) return 25;
> -       if (size <=  64 * 1024 * 1024) return 26;
> -       BUG();
>
>         /* Will never be reached. Needed because the compiler may complain */
>         return -1;
