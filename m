Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4C703CBB53
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jul 2021 19:42:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230431AbhGPRpZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jul 2021 13:45:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:35154 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230165AbhGPRpY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jul 2021 13:45:24 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2F6DE613CC
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jul 2021 17:42:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626457349;
        bh=HzwbWDV5zQYwFTjKz9i1yl8X4HOyO/PDoBsFo0wvaQk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=UI9VNz6+GmC4EVq8BhacVQ41h/XRu9ypuff64Hh8Sqe3J3dN+EOtwWck8mOmfTMq1
         P5uVcjLX5K4qzI177YDsDw4ZGiATujNXiT/U2w6N/kBIo51xZLA17BSJD/iCl+uFVW
         R/0iRG/e6Hzso096DUB/VWHVo+LAJVb2n5xyWIOIrKlT4otpWp2rU4QNoIROFOcTa2
         Hj9KUDymiOq05JoSXqCKIy9jT6++KwmrL8CnBMYYBWUhPKj3+4a3ZpVeahLZNzayxF
         513/mlruzX+4bgV2W7N6VLqN/cTDAd9KVQHh7pJ18woSbb6nIya+frh6/0+Xdpf4NZ
         DA67o2tdt36Bg==
Received: by mail-ed1-f43.google.com with SMTP id w14so13962906edc.8
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jul 2021 10:42:29 -0700 (PDT)
X-Gm-Message-State: AOAM532U6e+IXDYssRgNRhWE2D5gRGOCbev2B0ANEzteiJ+r6mx8Cnaz
        hyYTxwqVB7OVwKcZWFkJl2zU2KQ31FulW2dA4g==
X-Google-Smtp-Source: ABdhPJyaXcDoB4L/3QfxDeIb3GmDGi8Do/zLELL+0HTQ9aq+BedwPsPJgMcDgFyL5WZYW02X40zGPVUUlAOB8a6mNOc=
X-Received: by 2002:aa7:c641:: with SMTP id z1mr7027145edr.289.1626457347787;
 Fri, 16 Jul 2021 10:42:27 -0700 (PDT)
MIME-Version: 1.0
References: <20210715173750.10852-1-jason-jh.lin@mediatek.com> <20210715173750.10852-6-jason-jh.lin@mediatek.com>
In-Reply-To: <20210715173750.10852-6-jason-jh.lin@mediatek.com>
From:   Rob Herring <robh@kernel.org>
Date:   Fri, 16 Jul 2021 11:42:15 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+mF4O2H2fZQZRPTaB4yAFTRg7F4cYnaqD4xwN3XiZfCw@mail.gmail.com>
Message-ID: <CAL_Jsq+mF4O2H2fZQZRPTaB4yAFTRg7F4cYnaqD4xwN3XiZfCw@mail.gmail.com>
Subject: Re: [PATCH v3 05/12] dt-bindings: arm: mediatek: change mmsys txt to
 yaml file
To:     "jason-jh.lin" <jason-jh.lin@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        fshao@google.com, nancy.lin@mediatek.com, singo.chang@mediatek.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 15, 2021 at 11:55 AM jason-jh.lin <jason-jh.lin@mediatek.com> wrote:
>
> Change mediatek,mmsys.txt to mediatek,mmsys.yaml
>
> Signed-off-by: jason-jh.lin <jason-jh.lin@mediatek.com>
> ---
>  .../bindings/arm/mediatek/mediatek,mmsys.txt  |  32 ------
>  .../bindings/arm/mediatek/mediatek,mmsys.yaml | 102 ++++++++++++++++++
>  2 files changed, 102 insertions(+), 32 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/arm/mediatek/mediatek,mmsys.txt
>  create mode 100644 Documentation/devicetree/bindings/arm/mediatek/mediatek,mmsys.yaml

There's already a reviewed patch for this[1]. Not sure why it isn't applied?

Rob

[1] https://lore.kernel.org/lkml/20210519161847.3747352-1-fparent@baylibre.com/
