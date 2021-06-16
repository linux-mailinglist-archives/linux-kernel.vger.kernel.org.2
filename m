Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 295223A9113
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 07:17:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231245AbhFPFTw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Jun 2021 01:19:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231176AbhFPFTv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jun 2021 01:19:51 -0400
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F31E0C061574
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jun 2021 22:17:44 -0700 (PDT)
Received: by mail-qt1-x82f.google.com with SMTP id v6so942482qta.9
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jun 2021 22:17:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iLn8eUCvJy2CWcSIXe6ohsWZex4qVXD74p7z6FMJPUo=;
        b=jDOToH5ThQyIZ/Z8kPwh8R97YYJUPgyXIvwYI7ELfesGT1LRFmc0oQizSpW5Du/1jT
         n8n511S9H2jKWIPPzwbEGsCQVrh6jqMZwL99GOCEoFmIgU2xBUW+YvuQbG8TA+PazhFY
         uMdw/pNT41Ub0lKjlBja/JS0DV7IUisf06CVE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iLn8eUCvJy2CWcSIXe6ohsWZex4qVXD74p7z6FMJPUo=;
        b=g0DvCTqnYs9r7447VhrPjZZvoQ4tX+VVwC0ActmN4gdaWKpBjKZC4qMYQDLyKrHQNF
         /tze8mdUajGC9sR0yXobzsVMeJpt0zNuFMMP/9JWTHi7IJvUOwBaIkKm8kiGI5x/bN29
         LcWsSlR2ErFj6L33rspaPuY1o7P5onLUZ3LzAWl0VwcJ1K/3PQ422PzYzp/4pAPSNqX8
         fLEPxFiFnk8hlrhNd0G6MhEvylLUggm+h3fzuVpd+fC0poPpV/8lL+tmy4fryl/r8QHM
         VamnFV/xVQXTSBIQC3JH05xhfH22Z263ugr99+7wf+/3s3ovS2CJdoKVU4AQfTRKglWL
         leMw==
X-Gm-Message-State: AOAM5307cLICN0J23roZ9BN7u1+GUjJv4s5O4htsUTp0Ze0T/v6ofMCe
        8EDyJ3yMvfe0vE7digRMsGeMnz9cg3LjRg==
X-Google-Smtp-Source: ABdhPJwDo8yu4dhOJ57MkdWBSpKKq9m/A4FjQnG8wzJrVgm9SIeULC3gjSXI0iolEYgau1S5fQIEqQ==
X-Received: by 2002:ac8:5f4c:: with SMTP id y12mr1348102qta.8.1623820663992;
        Tue, 15 Jun 2021 22:17:43 -0700 (PDT)
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com. [209.85.222.181])
        by smtp.gmail.com with ESMTPSA id i13sm651445qtr.43.2021.06.15.22.17.43
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Jun 2021 22:17:43 -0700 (PDT)
Received: by mail-qk1-f181.google.com with SMTP id u30so1384553qke.7
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jun 2021 22:17:43 -0700 (PDT)
X-Received: by 2002:a05:6638:151:: with SMTP id y17mr2452891jao.128.1623820213046;
 Tue, 15 Jun 2021 22:10:13 -0700 (PDT)
MIME-Version: 1.0
References: <20210616035240.840463-1-tientzu@chromium.org> <20210616035240.840463-10-tientzu@chromium.org>
 <CALiNf28=3vqAs+8HsjyBGOiPNR2F3yT6OGnLpZH_AkWqgTqgOA@mail.gmail.com> <20210616045918.GA27537@lst.de>
In-Reply-To: <20210616045918.GA27537@lst.de>
From:   Claire Chang <tientzu@chromium.org>
Date:   Wed, 16 Jun 2021 13:10:02 +0800
X-Gmail-Original-Message-ID: <CALiNf2-+vL8rw5fi=DcR=V7d55Ls3-OXoxC87Pvrf1Kz14D_+A@mail.gmail.com>
Message-ID: <CALiNf2-+vL8rw5fi=DcR=V7d55Ls3-OXoxC87Pvrf1Kz14D_+A@mail.gmail.com>
Subject: Re: [PATCH v11 09/12] swiotlb: Add restricted DMA alloc/free support
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

On Wed, Jun 16, 2021 at 12:59 PM Christoph Hellwig <hch@lst.de> wrote:
>
> On Wed, Jun 16, 2021 at 12:04:16PM +0800, Claire Chang wrote:
> > Just noticed that after propagating swiotlb_force setting into
> > io_tlb_default_mem->force, the memory allocation behavior for
> > swiotlb_force will change (i.e. always skipping arch_dma_alloc and
> > dma_direct_alloc_from_pool).
>
> Yes, I think we need to split a "use_for_alloc" flag from the force flag.

How about splitting is_dev_swiotlb_force into is_swiotlb_force_bounce
(io_tlb_mem->force_bounce) and is_swiotlb_force_alloc
(io_tlb_mem->force_alloc)?
