Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 567123AAF03
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jun 2021 10:44:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231181AbhFQIqL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Jun 2021 04:46:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229712AbhFQIqK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jun 2021 04:46:10 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4025C061574
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jun 2021 01:44:01 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id v9so5787349wrx.6
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jun 2021 01:44:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qse5cGxpg1Wx1K/bFNdJr9abCnEgN9q8mxTJmYsQZpY=;
        b=RKz7GWfEoYX/wB//GhA2SxpmZrhOz/Is37pPWrWzXguZKd7CXPjsZ4s7jqc9DhCjVH
         +D744kyllXPUmwoT2MsQ1Wj46SMJZ+NQ4JsKzo/HBgBdTMV0qBdEudSLO2zpoOxb217l
         z+yUfieKJm0Xvay4hafzUsmwM9iQKJpGuDLp487db7eF6QohcJHROgfKg9qAYYOHlroC
         EO/+QVAm5vWbDwGQadcJvKlmRZtM/PojwHH/yYy0J3vZF0sJkmSNIdVM2qWorDab1OJE
         STTJ1VcgXNk1smE+f1jijBz6UjPZ3TfL8fbRiolK5o5ufKhH/OO1OiXSQOePhcBBu0J+
         mgZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qse5cGxpg1Wx1K/bFNdJr9abCnEgN9q8mxTJmYsQZpY=;
        b=e3OtQAet4fAB5ybc7fbHeLoQGIr7LB2K6Y3HV71anmYoicooFv2fl7LfAYfT8Dqusw
         hb4PaQ2KjkSIh4nd2CGSvcGVOgNPTm2jNfsTCZGJSOUZD3ieGd8xM3ep/ZgZPBq/SLYl
         rADs13I/aS7Dk34XTnkiYN4+R3xnN9VR1ao1A9JGFDeTGbrW3pBtrdT4z3W+l+p9Nopl
         vQ0+rytSgtM63cC0ysSurMuuU5iOfR3opN74tqFOGBpTDHxqcj76F5+PCvt37TJkeAYH
         XSR8xOSLczlE36dB5IiyJTId3RLnwPSzq9LnkWZ3B9kV6NGFp4LXF7KVdGSoimvF5S0Q
         mF2w==
X-Gm-Message-State: AOAM531Xvho7F3pZZYfNCe89SJA5UHHtqiC9ma8xB9ayKpTxLnWV3gdd
        CF6PhO7Y+PSJXaH0eod3jApe7AZ0ECqB6Al3A7UPsA==
X-Google-Smtp-Source: ABdhPJxOBpMutGoMuzup8QLNPLn8QcJqEWEo5782gvYAl8dZNlSDV39AzkhvczUy3q4r3U76ISw1EGO0x+5bYVo/XJo=
X-Received: by 2002:a5d:5151:: with SMTP id u17mr4339152wrt.302.1623919440466;
 Thu, 17 Jun 2021 01:44:00 -0700 (PDT)
MIME-Version: 1.0
References: <20210617081330.98629-1-dja@axtens.net>
In-Reply-To: <20210617081330.98629-1-dja@axtens.net>
From:   David Gow <davidgow@google.com>
Date:   Thu, 17 Jun 2021 16:43:49 +0800
Message-ID: <CABVgOSmYiVA008enEkGy4XTooVQ7DftXvWySFLL16bZETocpqg@mail.gmail.com>
Subject: Re: [PATCH] mm/vmalloc: unbreak kasan vmalloc support
To:     Daniel Axtens <dja@axtens.net>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Uladzislau Rezki <urezki@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 17, 2021 at 4:13 PM Daniel Axtens <dja@axtens.net> wrote:
>
> In commit 121e6f3258fe ("mm/vmalloc: hugepage vmalloc mappings"),
> __vmalloc_node_range was changed such that __get_vm_area_node was no
> longer called with the requested/real size of the vmalloc allocation, but
> rather with a rounded-up size.
>
> This means that __get_vm_area_node called kasan_unpoision_vmalloc() with
> a rounded up size rather than the real size. This led to it allowing
> access to too much memory and so missing vmalloc OOBs and failing the
> kasan kunit tests.
>
> Pass the real size and the desired shift into __get_vm_area_node. This
> allows it to round up the size for the underlying allocators while
> still unpoisioning the correct quantity of shadow memory.
>
> Adjust the other call-sites to pass in PAGE_SHIFT for the shift value.
>
> Cc: Nicholas Piggin <npiggin@gmail.com>
> Cc: David Gow <davidgow@google.com>
> Cc: Dmitry Vyukov <dvyukov@google.com>
> Cc: Andrey Konovalov <andreyknvl@gmail.com>
> Cc: Uladzislau Rezki (Sony) <urezki@gmail.com>
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=213335
> Fixes: 121e6f3258fe ("mm/vmalloc: hugepage vmalloc mappings")
> Signed-off-by: Daniel Axtens <dja@axtens.net>
> ---

This fixes the KUnit test failure I was seeing on x86_64, thanks!

Tested-by: David Gow <davidgow@google.com>

Cheers,
-- David
