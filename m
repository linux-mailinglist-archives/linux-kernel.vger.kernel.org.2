Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BC953E50AF
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Aug 2021 03:41:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237240AbhHJBlm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Aug 2021 21:41:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234710AbhHJBlm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Aug 2021 21:41:42 -0400
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF920C0613D3
        for <linux-kernel@vger.kernel.org>; Mon,  9 Aug 2021 18:41:20 -0700 (PDT)
Received: by mail-qk1-x732.google.com with SMTP id a19so20703829qkg.2
        for <linux-kernel@vger.kernel.org>; Mon, 09 Aug 2021 18:41:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=jSSgod6BCV7HGeJ5Sg1uN+xOqGDa0ESfr2yf+KMt7Os=;
        b=NT/EZu4AHorIdqU60o5QtGc0fMe6Cl77W5uoGWCbmy3ERIZoZRDfnOIbarE2J19l/g
         p24uY2gVC58VBwUWJnDHQfpoQEionBEllQiSB3mrnXXZUemE3PNmfV31/1RlOaKOu4i1
         3+/6ayglaF33MVtaBcdh8R5AdL5+V1uD+B64M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=jSSgod6BCV7HGeJ5Sg1uN+xOqGDa0ESfr2yf+KMt7Os=;
        b=cqlUMpeTCuaE0Grou/FJPf5lEn/2DKlsu2dbXvp4PoBR7/95mlQhpUxYNaAupq6wBX
         prES51EKgyP19L73hVnbzLViWjZU+UmwcDNuLS/g0hAy8/MUx+ZVwDLdFbxyKgVT2z2y
         8HIsg/NrXGuRqwcCog3G0nvlkG04XRwRreWra6dP7LxMiA6/buuBAl9GKmcTaVQhMIiz
         IcOkM8LnF4GRGjChrwJGEkIqaZEyAurAMivxwpbqbNhyYOqWetZgIwOOTHddEXaZQkQP
         m/DBMfI0i6+81XHff/T6jhCrmO1kDzMVCoGWngOeCPy8lJvZARLEmMvX2xub5MjJ6Ul1
         zBig==
X-Gm-Message-State: AOAM5331cfXP8P9OXwWwhv83oHhQcBuZfpsYZfqMTVqyJJYljhQH0OKC
        XKIrBmm10+lnNUOyPqaKwncISMdPYyXbPls7ZyqP8A==
X-Google-Smtp-Source: ABdhPJw5ifiTMQJbxsCLosZIdWLAslKoKuYfUEpFwa4RjWeDGob+kedEk35Si9WAeU7uq0r2wGpPeY2GJZlIe3lYBq8=
X-Received: by 2002:a37:6d8:: with SMTP id 207mr12046983qkg.328.1628559680048;
 Mon, 09 Aug 2021 18:41:20 -0700 (PDT)
MIME-Version: 1.0
References: <20210806103423.3341285-1-stevensd@google.com> <20210806103423.3341285-4-stevensd@google.com>
 <PH0PR11MB48241565DC7BF06AD01301D3CDF79@PH0PR11MB4824.namprd11.prod.outlook.com>
In-Reply-To: <PH0PR11MB48241565DC7BF06AD01301D3CDF79@PH0PR11MB4824.namprd11.prod.outlook.com>
From:   David Stevens <stevensd@chromium.org>
Date:   Tue, 10 Aug 2021 10:41:08 +0900
Message-ID: <CAD=HUj57PENg8-nbp6oR_+Kxqzkp7rZhXi_JBJ8+_v3w4L=4Hw@mail.gmail.com>
Subject: Re: [PATCH v2 3/9] dma-iommu: bounce buffers for untrusted devices
To:     "Mi, Dapeng1" <dapeng1.mi@intel.com>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        Will Deacon <will@kernel.org>, Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 10, 2021 at 10:19 AM Mi, Dapeng1 <dapeng1.mi@intel.com> wrote:
>
> Hi David,
>
> I like this patch set and this is crucial for reducing the significant vI=
OMMU performance. It looks you totally rewrite the IOMMU mapping/unmapping =
part and use the dynamically allocated memory from buddy system as bounce b=
uffer instead of using the legacy SWIOTLB bounce buffer. As I know, some le=
gacy devices' DMA could not access the memory larger than 32-bit memory spa=
ce and the dynamically allocated memory address could exceed the 32-bit mem=
ory space. Is it a problem?

My understanding is that when devices with that sort of limitation sit
behind an IOMMU, the IOVA is what matters, not the physical address.
The bounce bounce buffers use the same limits for IOVA allocation as
the regular dma-iommu path, so compatible IOVAs will be allocated for
the bounce buffers.

-David

> Thx,
> Dapeng Mi
