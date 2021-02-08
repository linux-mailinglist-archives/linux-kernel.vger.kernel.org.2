Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BBEA313174
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Feb 2021 12:55:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232956AbhBHLy4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Feb 2021 06:54:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232256AbhBHLfN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 06:35:13 -0500
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCCC5C061786
        for <linux-kernel@vger.kernel.org>; Mon,  8 Feb 2021 03:34:05 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id f14so24039187ejc.8
        for <linux-kernel@vger.kernel.org>; Mon, 08 Feb 2021 03:34:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SIdoO/BXrCF5ZGx1sncTZthErRH1ESME+fQ4iZ40G4Y=;
        b=R4FfWcgnRp7kfMDn8OHGmLFT1VfRqhYLNtKbqtkWdlb75NiARoNYeuQ8plgw69PUvK
         SrMHBkIe3taDYqbOgv3c7/zQ+MxGUpsl5Jfwyzx4OaASuL8ztU0r+HTymMJR6J0YvC16
         zIfDdvWJe+eVik/zwfB7GuuftSM9ixQbVyhf0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SIdoO/BXrCF5ZGx1sncTZthErRH1ESME+fQ4iZ40G4Y=;
        b=DYODFsTRueBRuKpk7N0g3gAmn0961mZVlTyy1mZBud5Cr9EdvH6V5y/Ye/W49cbrfQ
         NaSPFjHveSr+yH9xCrj+1y+w5KU8qVeAW50aveeXJQAeuy5C8PxaePoF4Tw2kdbzv/qy
         jYYpjIyCZdJzIqwhOHJgF+fUKabWfqA/hg5IJYd6oOZ8EHO7SFGNuyAeqD4iJGROCyiM
         m42ZbIa+OiPkuzPTi/b2e6qpWsjlxCB5dbrzGuB/mmMfzuB9gClaxLeonLbaRCY8ww/n
         7vwZ+OEipa0wzeYoupdtQER1UceGhYA++72U61dfCC9zCB70s+ksup91dDVjU1nWSZ+F
         qvgw==
X-Gm-Message-State: AOAM530brQhos0dPpj1HnjLtEUhmTj0IRIJkgoSdUpB6YHdz6jVA09jt
        cxVG1w9WYKZF9ShXWw4ui2zaDj3BAcDskg==
X-Google-Smtp-Source: ABdhPJzP3iP8rHJpGjLJOmKy9wfjwqTs9XWloUJ+jqqHAbZK5sqDllVJT6+ZFj9ebkzA5kt2+/mNHQ==
X-Received: by 2002:a17:906:b001:: with SMTP id v1mr16423006ejy.217.1612784044140;
        Mon, 08 Feb 2021 03:34:04 -0800 (PST)
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com. [209.85.221.48])
        by smtp.gmail.com with ESMTPSA id i13sm8421683ejj.2.2021.02.08.03.34.03
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Feb 2021 03:34:03 -0800 (PST)
Received: by mail-wr1-f48.google.com with SMTP id g6so3657922wrs.11
        for <linux-kernel@vger.kernel.org>; Mon, 08 Feb 2021 03:34:03 -0800 (PST)
X-Received: by 2002:a5d:6404:: with SMTP id z4mr6111438wru.103.1612784042646;
 Mon, 08 Feb 2021 03:34:02 -0800 (PST)
MIME-Version: 1.0
References: <20210202095110.1215346-1-hch@lst.de> <20210207184855.GA27553@lst.de>
In-Reply-To: <20210207184855.GA27553@lst.de>
From:   Tomasz Figa <tfiga@chromium.org>
Date:   Mon, 8 Feb 2021 20:33:50 +0900
X-Gmail-Original-Message-ID: <CAAFQd5BzAvgiTLGFse+ZWUrFtZ1Ysf+p+e-4rW8gq_iP0xhWEA@mail.gmail.com>
Message-ID: <CAAFQd5BzAvgiTLGFse+ZWUrFtZ1Ysf+p+e-4rW8gq_iP0xhWEA@mail.gmail.com>
Subject: Re: add a new dma_alloc_noncontiguous API v2
To:     Christoph Hellwig <hch@lst.de>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Ricardo Ribalda <ribalda@chromium.org>,
        Sergey Senozhatsky <senozhatsky@google.com>,
        "open list:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christoph,

On Mon, Feb 8, 2021 at 3:49 AM Christoph Hellwig <hch@lst.de> wrote:
>
> Any comments?
>

Sorry for the delay. The whole series looks very good to me. Thanks a lot.

Reviewed-by: Tomasz Figa <tfiga@chromium.org>

Best regards,
Tomasz

> On Tue, Feb 02, 2021 at 10:51:03AM +0100, Christoph Hellwig wrote:
> > Hi all,
> >
> > this series adds the new noncontiguous DMA allocation API requested by
> > various media driver maintainers.
> >
> > Changes since v1:
> >  - document that flush_kernel_vmap_range and invalidate_kernel_vmap_range
> >    must be called once an allocation is mapped into KVA
> >  - add dma-debug support
> >  - remove the separate dma_handle argument, and instead create fully formed
> >    DMA mapped scatterlists
> >  - use a directional allocation in uvcvideo
> >  - call invalidate_kernel_vmap_range from uvcvideo
> > _______________________________________________
> > iommu mailing list
> > iommu@lists.linux-foundation.org
> > https://lists.linuxfoundation.org/mailman/listinfo/iommu
> ---end quoted text---
