Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E2933DFD1A
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Aug 2021 10:41:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236654AbhHDIlv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Aug 2021 04:41:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235307AbhHDIlu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Aug 2021 04:41:50 -0400
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3E75C0613D5
        for <linux-kernel@vger.kernel.org>; Wed,  4 Aug 2021 01:41:37 -0700 (PDT)
Received: by mail-ot1-x335.google.com with SMTP id 61-20020a9d0d430000b02903eabfc221a9so1043356oti.0
        for <linux-kernel@vger.kernel.org>; Wed, 04 Aug 2021 01:41:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ry/C788Ax+QRjoem679Qz9xjcGp3R8vxYXF3Ug8T/cU=;
        b=CdeSijkPZlqUImGIAEzCPBTp6l7WQasuELwBXyk/ZoG5VDeh1gjR+9z3QgEETkKMXx
         ESlpE0ZjQ6Hm4EczMgQduF7lq//myVLatAB4ctFpbLT5+96N383jrCYI+6OROefnr406
         vQk/G+owiXqx6JVCRyqvTddr/+DGhRXI+vd61ALTEzm5pGxtmfJp9fAHE+I7gsVluHKn
         HzgA76R4usQfRo5H8GM4t39wQzbxhwP7HYrKHuoMo1v4E8IHXBPydAKh5qHaWXy8oW+Y
         J+Qikv9yXbG5K5ClLtSz4jV/dOrpGWZf0sJpFAB0kWfvC8KHFw9VjvZb5H7RQw8e0C6m
         s+2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ry/C788Ax+QRjoem679Qz9xjcGp3R8vxYXF3Ug8T/cU=;
        b=jYb7ghB0yR2qdjGm9dJ4LswTw6gvlWFSQ1fIvsVxtHMMa9ntf199xJYZwd68EFj6ni
         upVwoxqgXRyY56Gh6yCg0sKb+CyAYiXGS6gi0N6urkMTg9feV9WvfTOhnTvOP9xwHjsD
         FMCJM5zR/neehnTyQxQ1Pm/gtl8F8Fi/pQz0ohy560OkmaqBGUlc/9XVoyA3+e5Kn9yb
         8Und0LV/u4VTOU+OzOXhspMmLDG/xoHdIM39SG3CwYi+LM3RqTYdnHvPJ0htxryOJ0HS
         IMI25msVYbMeg/al3M8o51FIn2MaZ01VFn+jNUsX0Eu7nK93J18LLjsb+tNW/roX2Ngm
         SS7w==
X-Gm-Message-State: AOAM531Oq3UwDIvAGrwmKRoh6Us2/YTrdCHldpe/6/lNiUCRAgMdwdA+
        JfoEYo84hBp8tKdbiX3yoJV6f4gD/RnwOLmBuIi73A==
X-Google-Smtp-Source: ABdhPJwULOwQJrId2LR6uf4OqnUiOnC6+yQnX9X5/0EP+lRGGxsuaAeYFWMZ2K7UDJwoWl0nMWJTt4uXnmlICOmyUos=
X-Received: by 2002:a05:6830:1490:: with SMTP id s16mr2295783otq.233.1628066496794;
 Wed, 04 Aug 2021 01:41:36 -0700 (PDT)
MIME-Version: 1.0
References: <20210804082230.10837-1-Kuan-Ying.Lee@mediatek.com> <20210804082230.10837-3-Kuan-Ying.Lee@mediatek.com>
In-Reply-To: <20210804082230.10837-3-Kuan-Ying.Lee@mediatek.com>
From:   Marco Elver <elver@google.com>
Date:   Wed, 4 Aug 2021 10:41:25 +0200
Message-ID: <CANpmjNMAw=rcp_V+G_vjRjArj+09AkOxtC+wUNs-e1RRvfQm6w@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] kasan, slub: reset tag when printing address
To:     Kuan-Ying Lee <Kuan-Ying.Lee@mediatek.com>
Cc:     Nicholas Tang <nicholas.tang@mediatek.com>,
        Andrew Yang <andrew.tang@mediatek.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Chinwen Chang <chinwen.chang@mediatek.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        kasan-dev@googlegroups.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 4 Aug 2021 at 10:23, Kuan-Ying Lee <Kuan-Ying.Lee@mediatek.com> wrote:
>
> The address still includes the tags when it is printed.
> With hardware tag-based kasan enabled, we will get a
> false positive KASAN issue when we access metadata.
>
> Reset the tag before we access the metadata.
>
> Fixes: aa1ef4d7b3f6 ("kasan, mm: reset tags when accessing metadata")
> Signed-off-by: Kuan-Ying Lee <Kuan-Ying.Lee@mediatek.com>
> Suggested-by: Marco Elver <elver@google.com>

Note, in this case Suggested-by is inappropriate, because I did not
suggest the change in any way (you already had it in v1). I just
commented on the fact that it's missing a Fixes so stable can pick it
up and some clarification.

Reviewed-by: Marco Elver <elver@google.com>

> ---
>  mm/slub.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/mm/slub.c b/mm/slub.c
> index b6c5205252eb..f77d8cd79ef7 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -576,8 +576,8 @@ static void print_section(char *level, char *text, u8 *addr,
>                           unsigned int length)
>  {
>         metadata_access_enable();
> -       print_hex_dump(level, kasan_reset_tag(text), DUMP_PREFIX_ADDRESS,
> -                       16, 1, addr, length, 1);
> +       print_hex_dump(level, text, DUMP_PREFIX_ADDRESS,
> +                       16, 1, kasan_reset_tag((void *)addr), length, 1);
>         metadata_access_disable();
>  }
>
> --
> 2.18.0
