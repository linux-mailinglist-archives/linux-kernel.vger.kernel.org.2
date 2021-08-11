Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED24D3E874F
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Aug 2021 02:41:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235770AbhHKAl6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Aug 2021 20:41:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231423AbhHKAl5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Aug 2021 20:41:57 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 810FAC061765
        for <linux-kernel@vger.kernel.org>; Tue, 10 Aug 2021 17:41:34 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id d11so690330eja.8
        for <linux-kernel@vger.kernel.org>; Tue, 10 Aug 2021 17:41:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+IKe5IV7lT/U5uUeCk8dwVAQVUVWQi0SX4MD0PFARrk=;
        b=VpErF9BeqvJ1lvp3C6qQVShFP+IPiAWshgdKLp0P6z5k1tr0AEcTxGz7UXnNvecgkT
         YT99OYu7LRWl/Fy8NL6FIcxXcEsQLWAxQyNk05Zd8sc8Qx8x7XwvaM2sLY8/poHHrPu/
         DyjfK5DuBXeRhweChIlCA1+mwEa406UsmTGdff6uEJHY9SaVQJnQwoVW60I0hdrHNxvT
         B7PAjoDqxdm+RkuigKCXFaq8jWVK9FfgEfezb2NHeiW/Q1qHn1shnvOneg5hIHS3xcg3
         YHRkeLwJ1ju+oYqRCy4vCIsyP4fSsn+uZS9kDF6Io8A5TEIZ4DCoY+wVtUa1vrnoYB34
         k4Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+IKe5IV7lT/U5uUeCk8dwVAQVUVWQi0SX4MD0PFARrk=;
        b=J/fTj8tqb6Vdf6DAOd9zXX0GReQmJP9GPPR46gCQX4/Tg7bRf8wbfAQlVcTXU9f067
         FhW2hN8gM9eUkeCRX7zuV9TY4oy1Smb42PnM337kYo77VBTG1O7xCZWUXd1DvIpBQr/k
         8bctohRqaw4dLO+PD9fNj/9aH5x7TUkRJlwDLl25qXTcojqJAfjeQrccQ0pU2R8E657j
         igZiyXusRosv4lAi0kMikguztPp9/YLBlzs7tuSL/JHMgGHLFRXaGS3JxUhjpiFSu8z0
         UDeKILw9PcuLv2hEnnbFE9ayN2o3Q7AS9T5SX42Ji8qqga1Xf752Ka6+yRHlIWbeLvDf
         MdSA==
X-Gm-Message-State: AOAM533IvfSmFeixrRxsh43yKXne5GtFVgBO4B7iem5SDaKWVQMzllvK
        n55UgpqKM89QnPRIG0d/Cals9KPJnsiJRdpl6eM=
X-Google-Smtp-Source: ABdhPJzhKYKVAFCRyomt10DfXYeqMxabU4psPm98irB3JQRDdIK4pz5dLQpzfGjYi+Bm/E+rvMoR2ThLD7k0wAPtJa0=
X-Received: by 2002:a17:906:d147:: with SMTP id br7mr1138362ejb.126.1628642493014;
 Tue, 10 Aug 2021 17:41:33 -0700 (PDT)
MIME-Version: 1.0
References: <ef00ee9e0cf2b8fbcdf639d5038c373b69c0e1e1.1628639145.git.andreyknvl@gmail.com>
 <CALvZod6d=Ri1K-cZMi_6MXuDnoRPdz5mCPN6DXRB8YyotV6d2w@mail.gmail.com>
In-Reply-To: <CALvZod6d=Ri1K-cZMi_6MXuDnoRPdz5mCPN6DXRB8YyotV6d2w@mail.gmail.com>
From:   Andrey Konovalov <andreyknvl@gmail.com>
Date:   Wed, 11 Aug 2021 02:41:22 +0200
Message-ID: <CA+fCnZcQEEkpe+OtCYfWZb1nzov0FChQgTF3yuK6=M5bN_YLWA@mail.gmail.com>
Subject: Re: [PATCH] mm/slub, kasan: fix checking page_alloc allocations on free
To:     Shakeel Butt <shakeelb@google.com>
Cc:     andrey.konovalov@linux.dev,
        Andrew Morton <akpm@linux-foundation.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 11, 2021 at 2:18 AM Shakeel Butt <shakeelb@google.com> wrote:
>
> On Tue, Aug 10, 2021 at 4:47 PM <andrey.konovalov@linux.dev> wrote:
> >
> > From: Andrey Konovalov <andreyknvl@gmail.com>
> >
> > A fix for stat counters f227f0faf63b ("slub: fix unreclaimable slab stat
> > for bulk free") used page_address(page) as kfree_hook() argument instead
> > of object. While the change is technically correct, it breaks KASAN's
> > ability to detect improper (unaligned) pointers passed to kfree() and
> > causes the kmalloc_pagealloc_invalid_free test to fail.
> >
> > This patch changes free_nonslab_page() to pass object to kfree_hook()
> > instead of page_address(page) as it was before the fix.
> >
> > Fixed: f227f0faf63b ("slub: fix unreclaimable slab stat for bulk free")
> > Signed-off-by: Andrey Konovalov <andreyknvl@gmail.com>
>
> The fix is already in the mm tree:
> https://lkml.kernel.org/r/20210802180819.1110165-1-shakeelb@google.com

Ah, I missed this.

Please CC kasan-dev for KASAN-related fixes.

Thanks!
