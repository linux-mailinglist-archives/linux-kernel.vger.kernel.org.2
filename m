Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 356E038F87F
	for <lists+linux-kernel@lfdr.de>; Tue, 25 May 2021 05:08:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229981AbhEYDKU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 May 2021 23:10:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbhEYDKT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 May 2021 23:10:19 -0400
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41E04C061574
        for <linux-kernel@vger.kernel.org>; Mon, 24 May 2021 20:08:49 -0700 (PDT)
Received: by mail-qk1-x733.google.com with SMTP id j184so7047464qkd.6
        for <linux-kernel@vger.kernel.org>; Mon, 24 May 2021 20:08:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UUICKcc/sKdAjzKNgq2l5eqYx+k5eTShYrWAkwN1nE8=;
        b=TELw0+2UEzjgBQgY3N9cHf7cvJQg4x1GF5jHbOj/Xhbu2EVYn5hJJdXJJYpk6Mpk8G
         l2k+90bOTlHqSiuws+ej9C6F14blJi9bSItZInf5oUYtu07o9RuIUrgGf8YFYR9loGpy
         S0ow3K1ouDjzn61e3PW37PZcm998eK6VcTTFc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UUICKcc/sKdAjzKNgq2l5eqYx+k5eTShYrWAkwN1nE8=;
        b=A6T2Oi8MIGenP0//k3SntnETss3aDQyIh9k0Eud69jglH+K29JlNSUFzWV5gAhbZNH
         uFduLOKwJVKkxwvc9tR8D2DB8meoP0pwu1+FODPbdXduSCCplGq9Tm/aSTyPR4Cm5KQb
         PPS/HqwjO5GxlbwNKZc8vnGuZg+Q2MyHyRkRvYTauUm2QnwSNM/yWhB785+TeK9FQnox
         /uQdvapcWEWBcwfDRLnimhZYc/tLk0hFhdz70/GBHkaNWU0OOCQBB0W+4WIFLns38GCt
         6q1NISyDn8li/J0hWyVf2QYgjbnKrRTyHPf/Lt05k/PZqacIY6jAlEaWPXBeMzW/mE46
         KsMw==
X-Gm-Message-State: AOAM532PzaZ4IrOsl+rrCK6lnSRRw0wCLd9ogSYhgjgFnLsYcFO+1jjb
        UUB5YBTj8DVKV+55xCwRP5yQyK9WxtqEeQ==
X-Google-Smtp-Source: ABdhPJy+z/ub9tvkXELka58/31srshAna1wP280ZJNr0MxfKhBUDgTrNRlah8hFMkb+WIQN3dYTO1g==
X-Received: by 2002:a37:e205:: with SMTP id g5mr33222860qki.449.1621912127376;
        Mon, 24 May 2021 20:08:47 -0700 (PDT)
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com. [209.85.222.170])
        by smtp.gmail.com with ESMTPSA id t11sm12576232qkm.123.2021.05.24.20.08.44
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 May 2021 20:08:46 -0700 (PDT)
Received: by mail-qk1-f170.google.com with SMTP id j184so7047360qkd.6
        for <linux-kernel@vger.kernel.org>; Mon, 24 May 2021 20:08:44 -0700 (PDT)
X-Received: by 2002:a05:6638:22b4:: with SMTP id z20mr26846805jas.128.1621912112776;
 Mon, 24 May 2021 20:08:32 -0700 (PDT)
MIME-Version: 1.0
References: <20210518064215.2856977-1-tientzu@chromium.org>
 <20210518064215.2856977-5-tientzu@chromium.org> <CALiNf2_AWsnGqCnh02ZAGt+B-Ypzs1=-iOG2owm4GZHz2JAc4A@mail.gmail.com>
 <YKvLDlnns3TWEZ5l@0xbeefdead.lan>
In-Reply-To: <YKvLDlnns3TWEZ5l@0xbeefdead.lan>
From:   Claire Chang <tientzu@chromium.org>
Date:   Tue, 25 May 2021 11:08:21 +0800
X-Gmail-Original-Message-ID: <CALiNf2-M-CQdQaHiFTMfOkON6PEd0Yu_TvaCXKx9vXJ-7o5ffg@mail.gmail.com>
Message-ID: <CALiNf2-M-CQdQaHiFTMfOkON6PEd0Yu_TvaCXKx9vXJ-7o5ffg@mail.gmail.com>
Subject: Re: [PATCH v7 04/15] swiotlb: Add restricted DMA pool initialization
To:     Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc:     Rob Herring <robh+dt@kernel.org>, mpe@ellerman.id.au,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        boris.ostrovsky@oracle.com, jgross@suse.com,
        Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        benh@kernel.crashing.org, paulus@samba.org,
        "list@263.net:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>,
        sstabellini@kernel.org, Robin Murphy <robin.murphy@arm.com>,
        grant.likely@arm.com, xypron.glpk@gmx.de,
        Thierry Reding <treding@nvidia.com>, mingo@kernel.org,
        bauerman@linux.ibm.com, peterz@infradead.org,
        Greg KH <gregkh@linuxfoundation.org>,
        Saravana Kannan <saravanak@google.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        heikki.krogerus@linux.intel.com,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        linux-devicetree <devicetree@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        linuxppc-dev@lists.ozlabs.org, xen-devel@lists.xenproject.org,
        Nicolas Boichat <drinkcat@chromium.org>,
        Jim Quinlan <james.quinlan@broadcom.com>,
        Tomasz Figa <tfiga@chromium.org>, bskeggs@redhat.com,
        Bjorn Helgaas <bhelgaas@google.com>, chris@chris-wilson.co.uk,
        Daniel Vetter <daniel@ffwll.ch>, airlied@linux.ie,
        dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
        jani.nikula@linux.intel.com, Jianxiong Gao <jxgao@google.com>,
        joonas.lahtinen@linux.intel.com, linux-pci@vger.kernel.org,
        maarten.lankhorst@linux.intel.com, matthew.auld@intel.com,
        rodrigo.vivi@intel.com, thomas.hellstrom@linux.intel.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 24, 2021 at 11:49 PM Konrad Rzeszutek Wilk
<konrad.wilk@oracle.com> wrote:
>
> On Tue, May 18, 2021 at 02:48:35PM +0800, Claire Chang wrote:
> > I didn't move this to a separate file because I feel it might be
> > confusing for swiotlb_alloc/free (and need more functions to be
> > non-static).
> > Maybe instead of moving to a separate file, we can try to come up with
> > a better naming?
>
> I think you are referring to:
>
> rmem_swiotlb_setup
>
> ?

Yes, and the following swiotlb_alloc/free.

>
> Which is ARM specific and inside the generic code?
>
> <sigh>
>
> Christopher wants to unify it in all the code so there is one single
> source, but the "you seperate arch code out from generic" saying
> makes me want to move it out.
>
> I agree that if you move it out from generic to arch-specific we have to
> expose more of the swiotlb functions, which will undo's Christopher
> cleanup code.
>
> How about this - lets leave it as is now, and when there are more
> use-cases we can revisit it and then if need to move the code?
>
Ok! Sounds good!
