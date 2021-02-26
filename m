Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 911CB32605E
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Feb 2021 10:44:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230368AbhBZJn7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Feb 2021 04:43:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230402AbhBZJnx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Feb 2021 04:43:53 -0500
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5DFDC061574
        for <linux-kernel@vger.kernel.org>; Fri, 26 Feb 2021 01:43:08 -0800 (PST)
Received: by mail-qk1-x729.google.com with SMTP id h8so8492106qkk.6
        for <linux-kernel@vger.kernel.org>; Fri, 26 Feb 2021 01:43:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=E8MT/YBSt9+GOAVKSt/z+/x/oAmJs4mba4MVCW+FEPI=;
        b=YlJGaB2HjeORjhsgYOy8pctb9+8JkGl/ZdIRVJcfQxCMoR62lL7XtrY95NgsqhINjE
         lSgvnnp9tfO6u1oKErjW0g+HTDOG3GFiOyn5d4dJiyFIJKbzFBupmPEB/V7jXmUb4d2q
         N9u5qLxflCWFXhFfzUGrtIkZV0aKvT2pOtERk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=E8MT/YBSt9+GOAVKSt/z+/x/oAmJs4mba4MVCW+FEPI=;
        b=qFNd+goNjcrze+b2eEox+fWtcYqAm5H6pE2JuOX2blBWpHRiAOpfHr4nUusuarXjf4
         LnFCguGYvAfD1wtftjm4HLAvf3J5tsWPatP0O0nOJRvOLfhg2W7krLZKNwrAsZjf+1D7
         kc0A1ig/MDF1NASn9rdxf2WOZPTeDqRhSWDoT5T2qRjtnqtd8Cnu79Wlusr4xhWxk/j8
         YOgtYB4CMy620/xH8BLd4XGLe/lHzezrAhY4z6t+MCrP9Bgzp3QBHe7oHF2JyYUVOaSC
         lj1GscIohazKo1h6poQb+AKzhMhEJd2x0lhGyhbrvWAZ8z32cYzc/yLta8Gz2aGsgbJj
         7WNw==
X-Gm-Message-State: AOAM531De+5s9Hx/XWKzoyu56s1CDEO7RRibror0Ck6bYsgjWychJ6zM
        Gw25ZelQNUXyqRo0sEp8a101sFn4nrAwnQ==
X-Google-Smtp-Source: ABdhPJwn9Ersyt1z6l48t/+GdLkwBJh/pPErHkk/MjCqQn0l5an3YX2VGFeaQUb2C0XpLZh52gbMpg==
X-Received: by 2002:ae9:ec17:: with SMTP id h23mr1662165qkg.193.1614332588003;
        Fri, 26 Feb 2021 01:43:08 -0800 (PST)
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com. [209.85.160.174])
        by smtp.gmail.com with ESMTPSA id o12sm6086151qko.117.2021.02.26.01.43.07
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Feb 2021 01:43:07 -0800 (PST)
Received: by mail-qt1-f174.google.com with SMTP id f17so6228818qth.7
        for <linux-kernel@vger.kernel.org>; Fri, 26 Feb 2021 01:43:07 -0800 (PST)
X-Received: by 2002:a02:b61a:: with SMTP id h26mr2057255jam.90.1614332168202;
 Fri, 26 Feb 2021 01:36:08 -0800 (PST)
MIME-Version: 1.0
References: <20210209062131.2300005-1-tientzu@chromium.org>
 <20210209062131.2300005-13-tientzu@chromium.org> <CALiNf298+DLjTK6ALe0mYrRuCP_LtztMGuQQCS90ubDctbS0kw@mail.gmail.com>
 <20210226051740.GB2072@lst.de>
In-Reply-To: <20210226051740.GB2072@lst.de>
From:   Claire Chang <tientzu@chromium.org>
Date:   Fri, 26 Feb 2021 17:35:57 +0800
X-Gmail-Original-Message-ID: <CALiNf29tSQ1R8zh35neQWuWqDPek+Jr8QzyPQQvTsW2cZBMEUw@mail.gmail.com>
Message-ID: <CALiNf29tSQ1R8zh35neQWuWqDPek+Jr8QzyPQQvTsW2cZBMEUw@mail.gmail.com>
Subject: Re: [PATCH v4 12/14] swiotlb: Add restricted DMA alloc/free support.
To:     Christoph Hellwig <hch@lst.de>
Cc:     Rob Herring <robh+dt@kernel.org>, mpe@ellerman.id.au,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        boris.ostrovsky@oracle.com, jgross@suse.com,
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
        Jim Quinlan <james.quinlan@broadcom.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 26, 2021 at 1:17 PM Christoph Hellwig <hch@lst.de> wrote:
>
> On Fri, Feb 26, 2021 at 12:17:50PM +0800, Claire Chang wrote:
> > Do you think I should fix this and rebase on the latest linux-next
> > now? I wonder if there are more factor and clean up coming and I
> > should wait after that.
>
> Here is my preferred plan:
>
>  1) wait for my series to support the min alignment in swiotlb to
>     land in Linus tree
>  2) I'll resend my series with the further swiotlb cleanup and
>     refactoring, which includes a slightly rebased version of your
>     patch to add the io_tlb_mem structure
>  3) resend your series on top of that as a baseline
>
> This is my current WIP tree for 2:
>
>   http://git.infradead.org/users/hch/misc.git/shortlog/refs/heads/swiotlb-struct

Sounds good to me. Thanks!
