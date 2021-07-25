Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1098C3D506F
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jul 2021 00:29:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230272AbhGYVs5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Jul 2021 17:48:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:34792 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229531AbhGYVsz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Jul 2021 17:48:55 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 94F8F60F43;
        Sun, 25 Jul 2021 22:29:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627252165;
        bh=LXdv3SNozGddEOtTXiweAPm33gFyubUEqk9QT+fHMHc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=NBPZZmLXXECARRRpEYQnILLiWAelyx07J8u147xeLgLnvwVuOuCbSyWtEgjGZdGXZ
         qczGtqvXBsxZc3Az2W3EwEoNOBBYlO16DwuPkJprDfNylmKUSeVQ3oCdothZgb2Bni
         9rQiM6bwtcPjqV3EfCv8OvpNve5f6FFEM6tPO6mUf1oWARwt2aBLkvV4tYPGnS0ifn
         reMmxDr85ZhAAxogPTTL8v3QrLWdyVkGkF5/MmZ6l9GlDyP2q3+tFQJpEqTHYN4Wqj
         lSlGFU29w6nStaab2+shG0nR9K87pYEGuvSnGCORJ80K0d5pqHvRyeMrP6BLDerHKd
         qZfasI1lM/seA==
Received: by mail-ej1-f51.google.com with SMTP id o5so13601005ejy.2;
        Sun, 25 Jul 2021 15:29:25 -0700 (PDT)
X-Gm-Message-State: AOAM532JlAfb+maw244hpLVG1+kfIBa/6vW+pkTWe/54pZw7vG61U4NQ
        ELpflc0AkmGRSJy1Ac+GQTG8pRf9AlqzkAMGTA==
X-Google-Smtp-Source: ABdhPJwfSEK/zGq4H+iwJok9IKltb7Tkin7X2hIbv0FMn04qW6BMg5NfENWFO8APXBMeuB8xHMIhsh3UlasWyhyEfQE=
X-Received: by 2002:a17:906:95ce:: with SMTP id n14mr5509121ejy.130.1627252164182;
 Sun, 25 Jul 2021 15:29:24 -0700 (PDT)
MIME-Version: 1.0
References: <20210723214031.3251801-1-atish.patra@wdc.com> <20210723214031.3251801-4-atish.patra@wdc.com>
In-Reply-To: <20210723214031.3251801-4-atish.patra@wdc.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Sun, 25 Jul 2021 16:29:12 -0600
X-Gmail-Original-Message-ID: <CAL_JsqKG9xkSAQGkBE8_BEE+O9S+z09M8C9+gWN-58aXEZWqgg@mail.gmail.com>
Message-ID: <CAL_JsqKG9xkSAQGkBE8_BEE+O9S+z09M8C9+gWN-58aXEZWqgg@mail.gmail.com>
Subject: Re: [RFC 3/5] dma-mapping: Enable global non-coherent pool support
 for RISC-V
To:     Atish Patra <atish.patra@wdc.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Christoph Hellwig <hch@lst.de>, devicetree@vger.kernel.org,
        Dmitry Vyukov <dvyukov@google.com>,
        Frank Rowand <frowand.list@gmail.com>,
        Guo Ren <guoren@linux.alibaba.com>,
        Linux IOMMU <iommu@lists.linux-foundation.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Tobias Klauser <tklauser@distanz.ch>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 23, 2021 at 3:40 PM Atish Patra <atish.patra@wdc.com> wrote:
>
> Currently, linux,dma-default is used to reserve a global non-coherent pool
> to allocate memory for dma operations. This can be useful for RISC-V as
> well as the ISA specification doesn't specify a method to modify PMA
> attributes or page table entries to define non-cacheable area yet.
> A non-cacheable memory window is an alternate options for vendors to
> support non-coherent devices. "dma-ranges" must be used in conjunction with
> "linux,dma-default" property to define one or more mappings between device
> and cpu accesible memory regions.

'dma-ranges' applies to buses. And, well, maybe devices when the bus
is not well defined. It is not a reserved-memory property.

Rob
