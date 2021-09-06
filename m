Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA078401559
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Sep 2021 05:56:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238808AbhIFDzJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Sep 2021 23:55:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230228AbhIFDzI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Sep 2021 23:55:08 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2E88C061575
        for <linux-kernel@vger.kernel.org>; Sun,  5 Sep 2021 20:54:04 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id u11-20020a17090adb4b00b00181668a56d6so3617573pjx.5
        for <linux-kernel@vger.kernel.org>; Sun, 05 Sep 2021 20:54:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=c3csY8HsjlX5rCTMJueC2/d6U+TPTjCxZBWfcTbP1RI=;
        b=F5ZLl4Dr5TZ3vyhofbocW1JELtOGWQN4r6nzBdSx3iAqjG6KnT27Nzjc3k7eGqDuXz
         XehGCvUDaBW4iSV5VZlMzYSDXuE8fmU8Izi5Ndyqfaky5QmhXY0QKhq0cqVfSgG76I6b
         3jkxrI9ssfo5GvgSw8UpoklHWSyG7hA8N9dLPq/C5p4vZDUTafewXVWIJZELnMzYsyIX
         D62DggX5vCI4pLHIYRIU83TnOvqRqN6mwNbv2TUJfNh3VBO7d+9tIeNKglY7SFoRo/0H
         L3KxN92Xf2EOKP12+x8nKxzPFmbdj+5go/Q13uxHaaRU0WlaXQ8tHuWESw85W0AKBCw5
         M3KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=c3csY8HsjlX5rCTMJueC2/d6U+TPTjCxZBWfcTbP1RI=;
        b=Kza58ZgpxtVHs5Nk/F59aSPWhUwt84ySNw4tBp9EF2SrxItWYG2cxGI56tAMdxMozO
         fX5HHuELwt6wHeMTMwgwZpLSUbEumAkpxjSXL+ibiJRLG41l3xA6ZNKnqlMeR2fXmEoM
         NbrIqTfLwFMXCRzoW60nFc0DMn7gpiLPkdR4IG0Y6w6nTzQB9RV6eJacjxFv1gqdVdbb
         oPBQv5BJx0kzZLPZ9Shnb3UogF3CncQW2lIFst7aC2amTXGi/IRK69jXvvUPb+wxkj9I
         6ums3DCODnL0p34C0N/6Y+anRswMkL4+Wlv+58fSEwgCCPkHZ194MgGbMKwc7We6lGJ9
         skHQ==
X-Gm-Message-State: AOAM533ffpwQ8pBlT4slZOLIp8C0REt2Ri0JZJtwB4Kwivun1splV7eI
        gajFlGGhRIpXhidcON5c2GZUkfveK6VziDHJwXTy5w==
X-Google-Smtp-Source: ABdhPJxfby5NlM9BC9k1pPFwOiidLw2rgCkhKqLByvHN5mQB7wxXzCpypbZrvJkzV5Gk8pLlYGAbJzrot7Hx37MXhOQ=
X-Received: by 2002:a17:902:ab8c:b0:13a:22d1:88d with SMTP id
 f12-20020a170902ab8c00b0013a22d1088dmr2424417plr.33.1630900444340; Sun, 05
 Sep 2021 20:54:04 -0700 (PDT)
MIME-Version: 1.0
References: <20210906034658.48721-1-yanghui.def@bytedance.com>
In-Reply-To: <20210906034658.48721-1-yanghui.def@bytedance.com>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Mon, 6 Sep 2021 11:53:27 +0800
Message-ID: <CAMZfGtVE2eAMwWLzwSEp6g7hOReu++hCa00OuaPur-24UQHrhA@mail.gmail.com>
Subject: Re: [RESEND PATCH v3] mm/mempolicy: fix a race between offset_il_node
 and mpol_rebind_task
To:     yanghui <yanghui.def@bytedance.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 6, 2021 at 11:47 AM yanghui <yanghui.def@bytedance.com> wrote:
>
> Servers happened below panic:
> Kernel version:5.4.56
> BUG: unable to handle page fault for address: 0000000000002c48
> RIP: 0010:__next_zones_zonelist+0x1d/0x40
> [264003.977696] RAX: 0000000000002c40 RBX: 0000000000100dca RCX: 0000000000000014
> [264003.977872] Call Trace:
> [264003.977888]  __alloc_pages_nodemask+0x277/0x310
> [264003.977908]  alloc_page_interleave+0x13/0x70
> [264003.977926]  handle_mm_fault+0xf99/0x1390
> [264003.977951]  __do_page_fault+0x288/0x500
> [264003.977979]  ? schedule+0x39/0xa0
> [264003.977994]  do_page_fault+0x30/0x110
> [264003.978010]  page_fault+0x3e/0x50
>
> The reason of panic is that MAX_NUMNODES is passd in the third parameter
> in function __alloc_pages_nodemask(preferred_nid). So if to access
> zonelist->zoneref->zone_idx in __next_zones_zonelist the panic will happen.
>
> In offset_il_node(), first_node() return nid from pol->v.nodes, after
> this other threads may changed pol->v.nodes before next_node().
> This race condition will let next_node return MAX_NUMNODES.So put
> pol->nodes in a local variable.
>
> The race condition is between offset_il_node and cpuset_change_task_nodemask:
> CPU0:                                     CPU1:
> alloc_pages_vma()
>   interleave_nid(pol,)
>     offset_il_node(pol,)
>       first_node(pol->v.nodes)            cpuset_change_task_nodemask
>                       //nodes==0xc          mpol_rebind_task
>                                               mpol_rebind_policy
>                                                 mpol_rebind_nodemask(pol,nodes)
>                       //nodes==0x3
>       next_node(nid, pol->v.nodes)//return MAX_NUMNODES
>
> Signed-off-by: yanghui <yanghui.def@bytedance.com>

LGTM.

Reviewed-by: Muchun Song <songmuchun@bytedance.com>
