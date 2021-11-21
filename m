Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF98B458205
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Nov 2021 06:26:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237888AbhKUF2q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Nov 2021 00:28:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233791AbhKUF2p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Nov 2021 00:28:45 -0500
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82E32C061574
        for <linux-kernel@vger.kernel.org>; Sat, 20 Nov 2021 21:25:40 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id bi37so63917920lfb.5
        for <linux-kernel@vger.kernel.org>; Sat, 20 Nov 2021 21:25:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=X4pH5l/YZV5sg5PI2rPGcwYaytwkxVMA0LOTHcYQe2U=;
        b=bArzITR3je/r66rDQ7SZtkKWpDlr63MpCcrcB3bfQwAdlv4yOP5NM5wx2A3XToSJcY
         Dwzwnk+icBr9Gn/IIdK/H/v0WX5Y28vw9BMKt0h4JACHtqbcgJsQuBOClWuDmTIHmARC
         J1L2L0e0L1Q1jBK4HtS0ZmtUfOs21ZbXKesAh4rA2eJy7/JXc/Y2YGUuQWDwwjQENrzo
         KcuFcFtPQKhm/BFsQlvAmBjuE1RlYKlQpj0MoIJjPXKo/6BOmzF/YsCoghoOUHU3foUw
         QGgjoU1hENtCAFRwKFdEUrTL7T9JrzSK4Y3PCU79rtKtDI+isMJrTiFpE4vFwo4GLd7z
         LeRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=X4pH5l/YZV5sg5PI2rPGcwYaytwkxVMA0LOTHcYQe2U=;
        b=vbHe4MVkt/Lfpa8C6qVKss3drIgUlSGVTbpXXupCeOan8YOWIPsAMvxmzfY+vnktHa
         oj7Vjv5w7TaxOltuSUj6EpM3zIIt9AR3qaZC5VCfZHfKzE8Owd2vgyJFN00elWT/7024
         EOqRS0msGx3evcunC+5Bv2llcGg47lcWU96Ap00TPVEc98N0Q6kzUqoGZw2Opy64Eb61
         5W+41C7tXGKrR0esyJO7ge9sR+t8C8MzsXChu0OOvOn0jbiq4pZ5i/9FcrcFKaVwKg/M
         ctCbXW/xs8jSYzFKiavQB/qVEMIYth7d0xoSv2AYKKNVODwuBP2ZYEoFhhQ/YBQi+XTe
         yN8Q==
X-Gm-Message-State: AOAM531+AIsmZGLiHywUo3vaFiViiIXHVkriMxWPXNSmo3VR0ywvkJDT
        Hl63NGJEhwdg+1V2cK4L7/NasSJucAnveUKzu34u+A==
X-Google-Smtp-Source: ABdhPJx0hg1xPtGgP7bsOKI/crWchsvO76PM1qgyi4ppfnWtVhWlnzyMA3NDpjFSTkkLYeLT1WT772R2NW+wHLYC7sE=
X-Received: by 2002:a05:6512:5c2:: with SMTP id o2mr46048931lfo.8.1637472338463;
 Sat, 20 Nov 2021 21:25:38 -0800 (PST)
MIME-Version: 1.0
References: <20211120201230.920082-1-shakeelb@google.com> <YZnMnyKRk8d/Ilyo@casper.infradead.org>
In-Reply-To: <YZnMnyKRk8d/Ilyo@casper.infradead.org>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Sat, 20 Nov 2021 21:25:27 -0800
Message-ID: <CALvZod7TBEPAj_62WYGxFGXOkv0pu0Erv2tqj-io6LnNDt6-nw@mail.gmail.com>
Subject: Re: [PATCH] mm: split thp synchronously on MADV_DONTNEED
To:     Matthew Wilcox <willy@infradead.org>
Cc:     David Hildenbrand <david@redhat.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Yang Shi <shy828301@gmail.com>, Zi Yan <ziy@nvidia.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 20, 2021 at 8:35 PM Matthew Wilcox <willy@infradead.org> wrote:
>
> On Sat, Nov 20, 2021 at 12:12:30PM -0800, Shakeel Butt wrote:
> > This patch let such applications not worry about the low level handling
> > of THPs in the kernel and splits the THPs synchronously on
> > MADV_DONTNEED.
>
> I don't mind the synchronous split, but I have concerns about the
> implementation.  I don't think it's worth another pointer in task_struct.

Are you concerned about the size of task_struct? At least on my config
this additional pointer was just filling the holes and not increasing
the size. I can check a couple other configs as well.

> It's also the case that splitting is likely to succeed, so I think a
> better implementation would try to split and then put the page on the
> global deferred list if splitting fails.

Actually this is what this patch is doing. See the second loop in
split_local_deferred_list().
