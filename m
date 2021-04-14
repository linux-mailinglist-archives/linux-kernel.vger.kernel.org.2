Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE33D35F2AF
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 13:45:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233586AbhDNLmB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 07:42:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231668AbhDNLl4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 07:41:56 -0400
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83FA5C061574
        for <linux-kernel@vger.kernel.org>; Wed, 14 Apr 2021 04:41:33 -0700 (PDT)
Received: by mail-qt1-x82a.google.com with SMTP id o2so1740729qtr.4
        for <linux-kernel@vger.kernel.org>; Wed, 14 Apr 2021 04:41:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vuwN2tps+A9iGF/qWHJo0OKDNEJp6OUg5buE8ubsh+M=;
        b=lOa2FIKMpFcGcgOps89l43t3sEAOetiZcbF6/1KxJDlnOmuEOwaRkcD7cjK1bDrKVN
         B1Y2gwmq0+eNEAE2/fYb3p8K5+P/gmzguNSWZOFlLYNMfIchgOyv5a/dBbgBEWQZnxRM
         SRh59l2LYd3uXf4FI+xMiDn/Hh5DB06DliKIVfqcOJmNaSLf1czsSB8cD9JE3Fr3vERq
         HPr8Vu3RMEu83moP+TTnH8KQymECCnSAND+vdd0g4rEzseJ69WeF+BffSb77smaP4inO
         sqonwy40eLCYwq4jo28jHsandWRYysbHo5Zfld3O/8mUdtsv+8HxtzyQo1ggNVH9MR8A
         ADKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vuwN2tps+A9iGF/qWHJo0OKDNEJp6OUg5buE8ubsh+M=;
        b=gfAg+gANU902d0MEwymiNxm6aro7AY5Zyec6m/9YFle9f3gPo5yNuOe8UMX13hopgi
         UPL814A7TmWOPyM84w1qDIIemG62Zr4DOtDXIyqWAkGMP06r2W0AOM137nudRymIR5Ah
         gb5k8RDqpUUqact0BUoq7Vp9wvWJSHjq5TwRC7Rs53eo9DCWLAmPFj4gVTncGlx4NlQz
         lmWsweaTY8u5MR2d+s/7ARCwtWca7C6ZR3DLl/zptF0ujv5okvM93FOKm68hYcoFZ6IM
         u/yLZ1xSFCSM5YeTN0Na7D5+PCAZ5dKLOF9UCMgig65hm5KHv0KAGBr5mz7yP/24x07j
         GGTw==
X-Gm-Message-State: AOAM530QUKLzsSvyM4x6FPf+P0oM25zzIFG5ciFG4Dy6YZe5txoTCaLf
        dDGQosY7qTqXQH6oaLY3nND9LBmbulvnZCq0UibdHheyj3gaGw==
X-Google-Smtp-Source: ABdhPJwPl8i36Umu1G4a9Ow3HV4gVUZJJGNOLDjrXEAQWNZwCO9VlfZ0EiUu+OSe/wt+8nBBntLmteq+qo7uX83CN7o=
X-Received: by 2002:a05:622a:216:: with SMTP id b22mr35132063qtx.263.1618400492664;
 Wed, 14 Apr 2021 04:41:32 -0700 (PDT)
MIME-Version: 1.0
References: <CAMdYzYrQ5f-mv_VmTq_CRf9tR=j3mwRpKHNLmPFgCF9whsGFRw@mail.gmail.com>
 <871rbeo7wf.wl-maz@kernel.org> <CAMdYzYruPyiT89FrbJhuV=c36PyRwZ7sT45abnv8rTv85AKRow@mail.gmail.com>
 <87y2dmmggt.wl-maz@kernel.org> <CAMdYzYrNa_wJa9mvBkhDrvdNaDugR9Y=LEnbcVHxjxJS0UFcMg@mail.gmail.com>
 <87tuoambdb.wl-maz@kernel.org>
In-Reply-To: <87tuoambdb.wl-maz@kernel.org>
From:   Peter Geis <pgwipeout@gmail.com>
Date:   Wed, 14 Apr 2021 07:41:20 -0400
Message-ID: <CAMdYzYo2+h+=39cw1t=11HUih-O+NUs4hhNaPbrU6si-AbqNiA@mail.gmail.com>
Subject: Re: [RFC] ITS fails to allocate on rk3568/rk3566
To:     Marc Zyngier <maz@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 13, 2021 at 11:51 AM Marc Zyngier <maz@kernel.org> wrote:
>
> On Tue, 13 Apr 2021 16:03:51 +0100,
> Peter Geis <pgwipeout@gmail.com> wrote:
> >
> > On Tue, Apr 13, 2021 at 10:01 AM Marc Zyngier <maz@kernel.org> wrote:
>
> [...]
>
> > > What happens if you hack all the allocations to happen in the low 4GB
> > > of the PA space?
> >
> > It seems to work correctly.
> > The downstream hacks used GFP_DMA32 which gets discarded by
> > kmalloc_fix_flags on certain allocations.
> > Switching to GFP_DMA seems to have satisfied it, but it feels wrong
> > using this code.
> > Need to check the corner cases to make sure I'm not missing something.
>
> The problem is that GFP_DMA doesn't always mean the same thing.
> Overall, we need to hear from Rockchip about the exact nature of the
> problem, and then we *may* be able to work something out.

From what I've read, GFP_DMA allocates as low as possible, while
GFP_DMA32 ensures it's in the 32 bit address range, am I understanding
this correctly?
Is there a reason GFP_DMA is permitted while GFP_DMA32 is not, aside
from backwards compatibility?
(I saw the notes about how we aren't really supposed to rely on these flags)

I've also confirmed that their disabling shareability and caching is necessary.

>
> I'd also like to understand whether it is broken because you happen to
> have pre-release silicon that will never make it into the wild, or if
> this is the real thing that is going to ship on millions of devices.

My understanding is these chips are samples prior to the full
production run, but we are waiting on official comment from Rockchip
about this particular errata.

>
> Thanks,
>
>         M.
>
> --
> Without deviation from the norm, progress is not possible.
