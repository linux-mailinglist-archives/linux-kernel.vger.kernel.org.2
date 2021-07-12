Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07FA53C6372
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jul 2021 21:14:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236306AbhGLTRd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jul 2021 15:17:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234302AbhGLTRc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jul 2021 15:17:32 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E6B9C0613DD
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jul 2021 12:14:43 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id u25so25959488ljj.11
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jul 2021 12:14:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/rM+aoSbmTqJDqFPwIB6NFP4YePrQAdzLRW/vT9PMLI=;
        b=R5bRUKi0sBMrWMFjTDrfEVpFQCedcMn2pFztQ0BTYyXRN1kiL63+eWT1lMJ9Vdg/Mi
         PfNutfK/HGWPYbqAx8LPAIFLPl+yTLxfqZ0NccuCqSljXZZ3T+iv0mpXMxfLkBKcKuxb
         uwplwVJ+fi/9Y3oHlYYo/pJ8JQZPRqdkmLln8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/rM+aoSbmTqJDqFPwIB6NFP4YePrQAdzLRW/vT9PMLI=;
        b=K7/0l3vJ2ygUYYaDMZPOvOzbE1zJ688n4X3VFhdNhVH/siYY7a7VhUMZ1TfpVSpqFM
         5pEmbPKAy3++VFya/8jspWVqK6sEJEu1CpVz+T5qvJIaBS2gC721R9tWqhha+bvqJdT1
         /uCJEVJNaKbhRBEemb4m/p7e3VDiVO8GS/vknlQDUhPc3q1BK9XPUMSypd2p450Kceg+
         xmfjEOKEzuHSYMZ6njs2o/ju2elRBSNcUs0gQMjNHgoyHFXxxDGiE2Orjcb44fN2imrJ
         i2SU/+ZMn70qGyq7iKwjgsYBBRpTKTYztBdqsw1ezLtPmMVoAZiYZkOwX+InIIDbUlsB
         dBQw==
X-Gm-Message-State: AOAM533E1h7vJrwt1WFt7JXxCvq6rfJPHu1UnU52T8x+w9rxJWuYBtaf
        FGwCxWYMLkLPqIltLz6YllAqqquN2Qjd73lF
X-Google-Smtp-Source: ABdhPJyXPZYNxn1eWuE6edtA1mrOnY1fwknDrjXTzjr9AG9e0MUVGx2RznYFWcy5lWgBpZMnp9g8SQ==
X-Received: by 2002:a2e:8215:: with SMTP id w21mr602217ljg.160.1626117281334;
        Mon, 12 Jul 2021 12:14:41 -0700 (PDT)
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com. [209.85.167.47])
        by smtp.gmail.com with ESMTPSA id s21sm1277312lfi.166.2021.07.12.12.14.40
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Jul 2021 12:14:41 -0700 (PDT)
Received: by mail-lf1-f47.google.com with SMTP id n14so45373986lfu.8
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jul 2021 12:14:40 -0700 (PDT)
X-Received: by 2002:ac2:42d6:: with SMTP id n22mr217501lfl.41.1626117280288;
 Mon, 12 Jul 2021 12:14:40 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wjB5XBk4obhMPfrU3mnOakV9VgHAYOo-ZGJnB2X0DnBWA@mail.gmail.com>
 <a9473821-1d53-0037-7590-aeaf8e85e72a@jonmasters.org>
In-Reply-To: <a9473821-1d53-0037-7590-aeaf8e85e72a@jonmasters.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 12 Jul 2021 12:14:24 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh0mRAyL9GNVjhw2ki7vRevvUnovCzawn2FO7e_dOfU-w@mail.gmail.com>
Message-ID: <CAHk-=wh0mRAyL9GNVjhw2ki7vRevvUnovCzawn2FO7e_dOfU-w@mail.gmail.com>
Subject: Re: Linux 5.14-rc1
To:     Jon Masters <jcm@jonmasters.org>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        Matthew Auld <matthew.auld@intel.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 12, 2021 at 12:08 AM Jon Masters <jcm@jonmasters.org> wrote:
>
> I happened to be installing a Fedora 34 (x86) VM for something and did a
> test kernel compile that hung on boot. Setting up a serial console I get
> the below backtrace from ttm but I have not had chance to look at it.

It's a NULL pointer in qxl_bo_delete_mem_notify(), with the code
disassembling to

  16: 55                    push   %rbp
  17: 48 89 fd              mov    %rdi,%rbp
  1a: e8 a2 02 00 00        callq  0x2c1
  1f: 84 c0                test   %al,%al
  21: 74 0d                je     0x30
  23: 48 8b 85 68 01 00 00 mov    0x168(%rbp),%rax
  2a:* 83 78 10 03          cmpl   $0x3,0x10(%rax) <-- trapping instruction
  2e: 74 02                je     0x32
  30: 5d                    pop    %rbp
  31: c3                    retq

and that "cmpl $3" looks exactly like that

        if (bo->resource->mem_type == TTM_PL_PRIV

and the bug is almost certainly from commit d3116756a710 ("drm/ttm:
rename bo->mem and make it a pointer"), which did

-       if (bo->mem.mem_type == TTM_PL_PRIV ...
+       if (bo->resource->mem_type == TTM_PL_PRIV ...

and claimed "No functional change".

But clearly the "bo->resource" pointer is NULL.

Added guilty parties and dri-devel mailing list.

Christian? Full report at

   https://lore.kernel.org/lkml/a9473821-1d53-0037-7590-aeaf8e85e72a@jonmasters.org/

but there's not a whole lot else there that is interesting except for
the call trace:

  ttm_bo_cleanup_memtype_use+0x22/0x60 [ttm]
  ttm_bo_release+0x1a1/0x300 [ttm]
  ttm_bo_delayed_delete+0x1be/0x220 [ttm]
  ttm_device_delayed_workqueue+0x18/0x40 [ttm]
  process_one_work+0x1ec/0x390
  worker_thread+0x53/0x3e0

so it's presumably the cleanup phase and perhaps "bo->resource" has
been deallocated and cleared?

                  Linus
