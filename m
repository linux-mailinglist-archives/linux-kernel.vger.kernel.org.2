Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 668993EDDFD
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Aug 2021 21:40:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230438AbhHPTkx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Aug 2021 15:40:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:41138 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229587AbhHPTkw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Aug 2021 15:40:52 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9D37060F55
        for <linux-kernel@vger.kernel.org>; Mon, 16 Aug 2021 19:40:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629142820;
        bh=0NGchtMPqXcGzx6gjhgUu5kP909HOdwGq6mHakCZGwc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=PNgp5i1ZmTHXE84/dACTXBnZfelmk/5B0bB2QynpkqE3XleOGZjJiMRroy4GLv9Mr
         m5oCH5UVNMnpPL8RsV6R0zOYQSISSWlYOK6KIicnnkGOPZq5Z/yeQV2MBBGZZpZFm8
         ylJ+kPVxVPad3Xk+XT2ZaS76thIkTyOKoUQhjvbyS9ZamVQ8CjqFkdY1aVNv4Pvzwf
         HfnNcaDnMDKokNdezBiT4Yup3MRkaGd2uvz+akT+i/O18MHfcZ7CUCM7vxV+Z7RZD5
         19NBtR8U0l1zhigcXR2tV4NejYYb+/uqgx39MUp5jW9MNoVNo3OgCtaa+AOwje9aeX
         ZYZG3ZhheI+iQ==
Received: by mail-ed1-f47.google.com with SMTP id q3so24027242edt.5
        for <linux-kernel@vger.kernel.org>; Mon, 16 Aug 2021 12:40:20 -0700 (PDT)
X-Gm-Message-State: AOAM531haTWKRcwytXcavQqYB5kR6DGu1vRUu0IJSxrpLUbQqUaRYGpu
        s3YO6YZgFJwLT+cS9ngzsJbGv8mmAgWe7MGp6g==
X-Google-Smtp-Source: ABdhPJyCHRTGwHhoWZVCC+L/ijlQKyXy+VyzVmiuJ6Onoccah+VfC+GD5IBBssfJrxh921yFciVB2LUPAtWxyYPXGrQ=
X-Received: by 2002:a50:9b52:: with SMTP id a18mr218882edj.165.1629142819250;
 Mon, 16 Aug 2021 12:40:19 -0700 (PDT)
MIME-Version: 1.0
References: <20210816132618.11707-1-will@kernel.org>
In-Reply-To: <20210816132618.11707-1-will@kernel.org>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Mon, 16 Aug 2021 14:40:08 -0500
X-Gmail-Original-Message-ID: <CAL_JsqKCxMPOZ-O6wpLbv7Fi2cuuo8mGZBjsA3Mhw0kcpBvK5w@mail.gmail.com>
Message-ID: <CAL_JsqKCxMPOZ-O6wpLbv7Fi2cuuo8mGZBjsA3Mhw0kcpBvK5w@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] Don't fail device probing due to of_dma_set_restricted_buffer()
To:     Will Deacon <will@kernel.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux IOMMU <iommu@lists.linux-foundation.org>,
        Claire Chang <tientzu@chromium.org>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Christoph Hellwig <hch@lst.de>,
        Robin Murphy <robin.murphy@arm.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 16, 2021 at 8:26 AM Will Deacon <will@kernel.org> wrote:
>
> Hi all,
>
> This is v2 of the patch I previously posted here:
>
>   https://lore.kernel.org/r/20210805094736.902-1-will@kernel.org
>
> Changes since v1 are:
>
>   * Move of_dma_set_restricted_buffer() into of/device.c (Rob)
>   * Use IS_ENABLED() instead of 'static inline' stub (Rob)
>
> This applies on Konrad's devel/for-linus-5.15 branch in swiotlb.git
>
> Cheers,
>
> Will
>
> Cc: Claire Chang <tientzu@chromium.org>
> Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Robin Murphy <robin.murphy@arm.com>
>
> --->8
>
> Will Deacon (2):
>   of: Move of_dma_set_restricted_buffer() into device.c
>   of: restricted dma: Don't fail device probe on rmem init failure
>
>  drivers/of/address.c    | 33 ---------------------------------
>  drivers/of/device.c     | 39 ++++++++++++++++++++++++++++++++++++++-
>  drivers/of/of_private.h |  7 -------
>  3 files changed, 38 insertions(+), 41 deletions(-)

Reviewed-by: Rob Herring <robh@kernel.org>
