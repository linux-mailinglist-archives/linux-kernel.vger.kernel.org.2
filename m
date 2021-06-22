Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 298913B0641
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jun 2021 15:55:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231396AbhFVN5O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Jun 2021 09:57:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229786AbhFVN5N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jun 2021 09:57:13 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4205CC061574
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jun 2021 06:54:56 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id s6so23745969edu.10
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jun 2021 06:54:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=P7b5G3A0+58gTpXa0/n5lleUJqlnrASAuqzNx+IB8OE=;
        b=Do7Q+4WVU0WjOoWN7dbhO+1BES2mXGeaLQiaGBDhR9Gm3cUN3Fjg6WG7we7cfzgJuR
         fORpsoTEVuyHROhZnXXzltRfHNofIorWoBTq/5nqwHnfJ/rqMgiVfvIvpDRWIxawoPRT
         x+YF0vcRsSvdf4dWRJbLozaa/4mBIr7qyl2RH1RMtFcMCi0qnhwrlbg1uRynBNt7Ee4m
         uFP1fCjD4whgY4sS+yS1Hf1jeVRvB3lO1A0qeJuVvuxNELRTFU6Ijv00UBtCyeisD87O
         5ZlE5BuSMN14eZOQ1A99vPtzBR54G3ro7W59NMoei/GHo+Qv8+V2Cq83g2ei20nPUHKn
         bRTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=P7b5G3A0+58gTpXa0/n5lleUJqlnrASAuqzNx+IB8OE=;
        b=P08FDBcGLXp6YzPhSwAs0aH/Teu748TfyDIFo+7uUcE8Um6RZDnHY77P69My21NQNi
         GuGIFUUnzT90CdA6Y6Huls0/UxtjcQojlbzI2oiEizlKws3zEEf65aKrofMW57Lf18C6
         FknoEKQJMCszEOvn+q2mGSlU5ArUorPe05IWxX0R9OTI4JZQ4UQ/gOuJStStHxcBxOBc
         A2UKsEj8+SMSUQbgD5Si2wI1FRvbznPZtuhmmJPYXrAA5OaTAzXIY/LJcfoIyIrO0har
         Q5waklXhZKVs6nvvgDp4XUWGoO65SIqwpWc5hcKsLCXy1qDFods0kHnNNFzgm+mwCXM7
         52qw==
X-Gm-Message-State: AOAM5323hzXfEPrYC011TWSzaCwc5QEzqXqNppwAfN7qCfMJtWimLCdZ
        z7A1xVeppIpd4q2gnbdd97fonPRnoW8y8lckvr8=
X-Google-Smtp-Source: ABdhPJwW6EaB1bmA1xujcy7BGJIRwEuHmi2zdTinLMNFFthY6zB2HCEAPGIQHaohEk1ZUfALmzQ7FTNoQaVgHf/h6k4=
X-Received: by 2002:a05:6402:1014:: with SMTP id c20mr5097086edu.70.1624370094862;
 Tue, 22 Jun 2021 06:54:54 -0700 (PDT)
MIME-Version: 1.0
References: <20210620114756.31304-1-Kuan-Ying.Lee@mediatek.com> <20210620114756.31304-3-Kuan-Ying.Lee@mediatek.com>
In-Reply-To: <20210620114756.31304-3-Kuan-Ying.Lee@mediatek.com>
From:   Andrey Konovalov <andreyknvl@gmail.com>
Date:   Tue, 22 Jun 2021 16:54:34 +0300
Message-ID: <CA+fCnZdGQ-_USQ_dCkmp+=MGS01yRtn1eLpGRLvbq=j-SQDrog@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] kasan: integrate the common part of two KASAN
 tag-based modes
To:     Kuan-Ying Lee <Kuan-Ying.Lee@mediatek.com>
Cc:     Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-mediatek@lists.infradead.org, wsd_upstream@mediatek.com,
        chinwen.chang@mediatek.com, nicholas.tang@mediatek.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 20, 2021 at 2:48 PM Kuan-Ying Lee
<Kuan-Ying.Lee@mediatek.com> wrote:
>
> 1. Move kasan_get_free_track() and kasan_set_free_info()
>    into tags.c

Please mention that the patch doesn't only move but also combines
these functions for SW_TAGS and HW_TAGS modes.

> --- /dev/null
> +++ b/mm/kasan/report_tags.h
> @@ -0,0 +1,55 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (c) 2014 Samsung Electronics Co., Ltd.
> + * Copyright (c) 2020 Google, Inc.
> + */
> +#ifndef __MM_KASAN_REPORT_TAGS_H
> +#define __MM_KASAN_REPORT_TAGS_H
> +
> +#include "kasan.h"
> +#include "../slab.h"
> +
> +const char *kasan_get_bug_type(struct kasan_access_info *info)

As mentioned by Alex, don't put this implementation into a header. Put
it into report_tags.c. The declaration is already in kasan.h.


> +{
> +#ifdef CONFIG_KASAN_TAGS_IDENTIFY
> +       struct kasan_alloc_meta *alloc_meta;
> +       struct kmem_cache *cache;
> +       struct page *page;
> +       const void *addr;
> +       void *object;
> +       u8 tag;
> +       int i;
> +
> +       tag = get_tag(info->access_addr);
> +       addr = kasan_reset_tag(info->access_addr);
> +       page = kasan_addr_to_page(addr);
> +       if (page && PageSlab(page)) {
> +               cache = page->slab_cache;
> +               object = nearest_obj(cache, page, (void *)addr);
> +               alloc_meta = kasan_get_alloc_meta(cache, object);
> +
> +               if (alloc_meta) {
> +                       for (i = 0; i < KASAN_NR_FREE_STACKS; i++) {
> +                               if (alloc_meta->free_pointer_tag[i] == tag)
> +                                       return "use-after-free";
> +                       }
> +               }
> +               return "out-of-bounds";
> +       }
> +#endif
> +
> +       /*
> +        * If access_size is a negative number, then it has reason to be
> +        * defined as out-of-bounds bug type.
> +        *
> +        * Casting negative numbers to size_t would indeed turn up as
> +        * a large size_t and its value will be larger than ULONG_MAX/2,
> +        * so that this can qualify as out-of-bounds.
> +        */
> +       if (info->access_addr + info->access_size < info->access_addr)
> +               return "out-of-bounds";
> +
> +       return "invalid-access";
> +}
