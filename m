Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F9A9427563
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Oct 2021 03:29:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232196AbhJIBbY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Oct 2021 21:31:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232036AbhJIBbX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Oct 2021 21:31:23 -0400
Received: from mail-vs1-xe2c.google.com (mail-vs1-xe2c.google.com [IPv6:2607:f8b0:4864:20::e2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDB4CC061570
        for <linux-kernel@vger.kernel.org>; Fri,  8 Oct 2021 18:29:27 -0700 (PDT)
Received: by mail-vs1-xe2c.google.com with SMTP id x192so10181593vsx.5
        for <linux-kernel@vger.kernel.org>; Fri, 08 Oct 2021 18:29:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zhpGrSlXA1wygmc3CulYlorWz1ODlaz9GQXVN48Dydk=;
        b=pFaczzzB4KLTBena7k9TQdpEz6xyBWwvM7JVNoKYrSK7KYMSxO1eVpm724lEzjyuSN
         ioi9CxpoHoJ6VaqAzSiX/G8nySLixq9asvU09Hc5dLEPBoGbb7M8/nbIo5Q4x9Rz8hYW
         JQacbfEkceUngBU16qyU2i+xdOtautp8B2kNoJhBmnuWgA2zKFHpTHmoLzxKis6ah0Fp
         4lOEuGczo2n2g2ypodAb4tsOE9iywhqL7DPtiGbL0MYLg6PjrpGU2/NuQN2sokezS+Og
         F+qif+E/v9WyTb+W3Ac2rTtaOzP8wrvM/DyR6hbb15KY2+rCLkrZSANi9VYJ+sGxDv/y
         NWVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zhpGrSlXA1wygmc3CulYlorWz1ODlaz9GQXVN48Dydk=;
        b=nr0XgZJCdTbisrxC7Xx0A7/wQpozoe4nB8cL46QN21CAH1tbAX2muUdLSdkpQep62E
         ab0bjYexNVWgAier9p4FWsPdQ7cVoEwD96jkm9NudeYUr7Vzyt/3wathmlXeyHNGSdQN
         1MUi6U0huxafhgC70n3xejCaJQZfX3SJ1uqS4ytbfwyGMKKY4Oe28+2yEsUHwpsVnLqC
         kXJE33iV5xqoaGb7ts8xvfbAm4ywtkKt09A34dBuaNK622B8TkdU1hchjVMXbT3VrVHT
         XS/Op7lviGkddnYyGQpntobukD3D1/BY7EVV0By//bAo6ZCqa4rrYUXYfnpA+vKzk0Uu
         cO/A==
X-Gm-Message-State: AOAM532u3oATE8eH9mEAi1N686ky/diW51S4GPsk5dl4YGT5aTzxkgpF
        CToYhq/2xTmSyR202cHakxoyJ4iIq1EwK6ym1UikCwpOy/I=
X-Google-Smtp-Source: ABdhPJwtt0d3id77E1FYy7Ij0m5SJIklxXhHR6JAMnCXKAuBIizjvfyVelSS8GMzUpq2STHoVXe69oaHlJZ7nPKCq3g=
X-Received: by 2002:a05:6102:cd2:: with SMTP id g18mr3932425vst.25.1633742967037;
 Fri, 08 Oct 2021 18:29:27 -0700 (PDT)
MIME-Version: 1.0
References: <CAPm50aLPxJCiVTqqwiz00oMNiqHggB84sXB3x=tv_HUAd5UktQ@mail.gmail.com>
 <20211008095123.73b4bubwrpdj6tuz@box.shutemov.name>
In-Reply-To: <20211008095123.73b4bubwrpdj6tuz@box.shutemov.name>
From:   Hao Peng <flyingpenghao@gmail.com>
Date:   Sat, 9 Oct 2021 09:28:56 +0800
Message-ID: <CAPm50a+E6mm_qA9h9MSvh4K+WA8Qf6mU=2yig5GyVw9GFJzr8g@mail.gmail.com>
Subject: Re: [PATCH v2] mm/huge_memory.c: disable THP with large THP size on
 small present memory
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     David Hildenbrand <david@redhat.com>, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 8, 2021 at 5:51 PM Kirill A. Shutemov <kirill@shutemov.name> wrote:
>
> On Fri, Oct 08, 2021 at 09:22:00AM +0800, Hao Peng wrote:
> > From: Peng Hao <flyingpeng@tencent.com>
> >
> > After setting the page size to 64k on ARM64, the supported huge page
> > size is 512M and 1TB. Therefore, if the thp is enabled, the size
> > of the thp is 512M. But if THP is enabled, min_free_kbytes will
> > be recalculated. At this time, min_free_kbytes is calculated based
> > on the size of THP.
> >
> > On an arm64 server with 64G memory, the page size is 64k, with thp
> > enabled.
> > cat /proc/sys/vm/min_free_kbytes
> > 3335104
> >
> > Therefore, when judging whether to enable THP by default, consider
> > the size of thp.
> >
> > V2: title suggested by David Hildenbrand
> >
> > Signed-off-by: Peng Hao <flyingpeng@tencent.com>
> > ---
> >  mm/huge_memory.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> > index 5e9ef0fc261e..03c7f571b3ae 100644
> > --- a/mm/huge_memory.c
> > +++ b/mm/huge_memory.c
> > @@ -437,7 +437,7 @@ static int __init hugepage_init(void)
> >          * where the extra memory used could hurt more than TLB overhead
> >          * is likely to save.  The admin can still enable it through /sys.
> >          */
> > -       if (totalram_pages() < (512 << (20 - PAGE_SHIFT))) {
> > +       if (totalram_pages() < (512 << (HPAGE_PMD_SHIFT - PAGE_SHIFT))) {
>
> On x86-64 HPAGE_PMD_SHIFT is 21, so you double the amount of memory
> required to enabled THP by default. It doesn't seem to be the intent of
> the patch.
>
> What about something like
>
>         if (totalram_pages() < 256 * HPAGE_PMD_NR)
>
> ?
>
I think that setting the threshold to 512M here is also a rough
estimate. If it is 512M
of memory and 2M of THP is used, there are only 256 pages in total.
This is actually
too small. In addition, THP is disabled by default, but you can also enable THP
dynamically.
Thanks.
> >                 transparent_hugepage_flags = 0;
> >                 return 0;
> >         }
> > --
> > 2.27.0
> >
>
> --
>  Kirill A. Shutemov
