Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91AA43DDB12
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Aug 2021 16:31:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234151AbhHBObS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Aug 2021 10:31:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233940AbhHBObP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Aug 2021 10:31:15 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CFB4C06175F
        for <linux-kernel@vger.kernel.org>; Mon,  2 Aug 2021 07:31:03 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id x14so24736709edr.12
        for <linux-kernel@vger.kernel.org>; Mon, 02 Aug 2021 07:31:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XeXjmAxnn6bEcuGhZh/BIcTWI5vzIDESsI93f1PiLoE=;
        b=toS+5mRuTcVYgg7zw4XizQ+WwQfU+62wIlhCzJrtDorwdg8/RxsAK4/ynvS3IrHny1
         eadvYXrsW14AzHZ9LpPbhiFZZfRoXwWeFoI7p3Jj8/4oBf9kAVXfTfdHZTu2MswYePAK
         pfBC5yExNJQj0IqSFJE+JqdI8RdjGca3vDRTpfIJmjKgi9zLZN+qlnhOjlnxImRrSHcL
         Mila1QFQzofqo0q6Z3rkoBfOu68tU3aQwS5TQ7c2q2nsq1wrd70nFR1HUn51+IyvWo+Q
         RTEwW5l3BE+IqT5VY4ExBYxlHR2FmmlHoephh6jQMIjEy8msXpJUeA4RAfWZJNi9Ke5l
         iR9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XeXjmAxnn6bEcuGhZh/BIcTWI5vzIDESsI93f1PiLoE=;
        b=Z1cjovn7BwnhNGz52HKsHSpZmn3fBRGICibEGBcz4Bvrfqex0axYcG5F2CFSsniuVu
         525OmOiPiYzaAQmu7Mx4trclyap2QfdfvPdCwjnSim0TbDb/IjWvL5aR4ksjG9RRRWPh
         DsujPvz5+ynQiiSDyYp1neSSmCn6qRw0XK7M1qomNA3tBN3fQB4u43nK8PAZLjvvqWhQ
         D3hiUXN8NCljcdmWjmr+6Vi6ibc/vzVz2RttzyIOM23wnruBKM64v22faQF7souxumRV
         d+iZihOgQe51DfShkUrOVsv8yxs//96j4NvInN0jCY5cBBhrm2ezUZ2UY9Wl6/jiXRaM
         013w==
X-Gm-Message-State: AOAM530C949EB2sSdKRIgTNfEbUEcyDZFvF9V2cuhfL3btMZctN2Qwhc
        tY4K+TqQBnw4dNGPOK2B1Ig+vKiWZELu0oWOosiR/vaBfTKtgQ==
X-Google-Smtp-Source: ABdhPJyqOYtTpraCk56Pd9IsLpqSeNqMtG7xGUSBWd3kM7Oz/Nxrrbz69kBxVvvqjTypUZBhKEWuNsCccTFk90GBUSM=
X-Received: by 2002:a50:cd86:: with SMTP id p6mr19718540edi.212.1627914661663;
 Mon, 02 Aug 2021 07:31:01 -0700 (PDT)
MIME-Version: 1.0
References: <20210731192637.3653796-1-lrizzo@google.com> <YQf9h+qvWCx6D7XT@8bytes.org>
In-Reply-To: <YQf9h+qvWCx6D7XT@8bytes.org>
From:   Luigi Rizzo <lrizzo@google.com>
Date:   Mon, 2 Aug 2021 16:30:50 +0200
Message-ID: <CAMOZA0LEr+xM6RrsJErPMqHP7-0GdLmNDqbGVKbKTn92=Ncejg@mail.gmail.com>
Subject: Re: [PATCH] amd/iommu: fix logic bug in amd_iommu_report_page_fault()
To:     Joerg Roedel <joro@8bytes.org>
Cc:     Will Deacon <will@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        David Rientjes <rientjes@google.com>,
        Luigi Rizzo <rizzo.unipi@gmail.com>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 2, 2021 at 4:13 PM Joerg Roedel <joro@8bytes.org> wrote:
>
> On Sat, Jul 31, 2021 at 12:26:37PM -0700, Luigi Rizzo wrote:
> > amd_iommu_report_page_fault() has two print paths, depending on whether or
> > not it can find a pci device. But the code erroneously enters the second
> > path if the rate limiter in the first path triggers:
> >   if (dev_data && ratelimit(A)) { A; } else if (ratelimit(B)) { B; }
> > The correct code should be
> >   if (dev_data) { if (ratelimit(A)) { A;} } else if (ratelimit(B)) { B; }
> >
> > Signed-off-by: Luigi Rizzo <lrizzo@google.com>
> > ---
> >  drivers/iommu/amd/iommu.c | 8 +++++---
> >  1 file changed, 5 insertions(+), 3 deletions(-)
>
> Thanks, but I queued this patch already:
>
>         https://lore.kernel.org/r/YPgk1dD1gPMhJXgY@wantstofly.org


Ah didn't realize that. Thank you!

Two questions on the topic:
1. how comes only the AMD driver is so verbose in reporting io page faults?
   Neither intel nor other iommu drivers seem to log anything

2. Would it make sense to have a control to disable such logging,
   either per-device or globally? Eg something like this (negative
   logic so it must be set explicitly to disable logging).


@ -985,6 +985,7 @@ struct device {
     defined(CONFIG_ARCH_HAS_SYNC_DMA_FOR_CPU_ALL)
        bool                    dma_coherent:1;
 #endif
+       bool                    no_log_fault:1;

...
+               if (!pdev->dev.no_log_fault && __ratelimit(&dev_data->rs))
+                       dev_err(&pdev->dev, "Event logged [IO_PAGE_FAULT dom


cheers
luigi
