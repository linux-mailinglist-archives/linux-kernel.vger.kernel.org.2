Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 719203911FE
	for <lists+linux-kernel@lfdr.de>; Wed, 26 May 2021 10:08:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231846AbhEZIKG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 May 2021 04:10:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230384AbhEZIKC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 May 2021 04:10:02 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A709C061574;
        Wed, 26 May 2021 01:08:29 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id p7so51859wru.10;
        Wed, 26 May 2021 01:08:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=yVcIsLaop0xFTxRezXJ3MSLuEhLYr+XKBNJbxOwir5s=;
        b=WYbaBVSv16q5MTWMzaif39kIsCho53bHWXwf9Z/KMlYAAxCZtALxyQhWH7Gg2eWYd7
         6nIhK9oO6tCBAo0juIZBBzEjU9QtK64YV6Azt2YNR9VGCRWQx1lrkX9agrTnGVlRgrm9
         2L0hOPcam6w7yvn7vfkiNshrSVNvUNPYw5tRd5UvKNQ/eTdNhO+UIPFdy+wzBGHK1zKf
         pMBmBj8Fmq6Z1i1B19jl3skq2f//GGGJ/dFr5YkSnFvA9pyH6H2NjU+/QFvFSDZCmawD
         wMYJ3tL5Sz1ifLpT2cbzTnLzdnoLMICiKJIRQx7o6Yx9zM4Ppfa9XTfAy/B9Wrg5bNqN
         Uy7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=yVcIsLaop0xFTxRezXJ3MSLuEhLYr+XKBNJbxOwir5s=;
        b=nxwLYRmO+fqiP2A8DZkLXZUdasGEQr9frxieSS9BDTP0v5V+BjwnD+7d9dTyXzqEcm
         d/ELzvUQIVePsM2lCeA5e0b0a7iP+VIsuwt65ghupY5CKCvjV/LqWqJcJGem2sjFyNu4
         omItGAGwL9wx4J/W0Gz1I2GhtMFKuNl+NQhV2No5vQTYv5PsbEjM634O/NljT2noF6NR
         94hH+uhp3xzfOLIbVhzXQ5DGQC+5nq7jGTMu1gfX5NC7UX5nrazpqr9dQ8LvsuefgULT
         99TxQwaNoTAarwfC5wCK07U8eeGrZd2DX0b1rIVz9emAcLDohREKa5QyvCH7vW8iPI8h
         w1YA==
X-Gm-Message-State: AOAM531BhTgFXHSkKGbuB89JYpzmjZJZHpE1ogseCM8F8pQ+hbK0IziO
        ZfTTOXSuNcV3v0+jfBdtpUc4sPG7yvG/hFgqjKg=
X-Google-Smtp-Source: ABdhPJzpuvOh0m7CXA37jLlei4+4VCuO9+LSYcUU5crIHmY5LaVh8NoHsVAadYTaqLaToEjoFwwVSXWkbmaHkBcqU40=
X-Received: by 2002:a5d:43cb:: with SMTP id v11mr1351884wrr.198.1622016508091;
 Wed, 26 May 2021 01:08:28 -0700 (PDT)
MIME-Version: 1.0
References: <20210425123607.26537-1-kevin3.tang@gmail.com> <20210425123607.26537-5-kevin3.tang@gmail.com>
 <20210430092249.n75to2das5m6p4zb@gilmour> <CAFPSGXYJxWJDo1cz+kJB8J9YayGx1hYa=04K5OJ3DHh9ifbuRQ@mail.gmail.com>
 <YKI26bZGAA+ZNLLj@8bytes.org> <bc0e3025-60bd-c6b4-117f-592dc1c1a2f0@arm.com> <CAAfSe-ughdeZ7YaVsXuWeGNq-+Q+_z+P=aeKpj957kE6d-hLmQ@mail.gmail.com>
In-Reply-To: <CAAfSe-ughdeZ7YaVsXuWeGNq-+Q+_z+P=aeKpj957kE6d-hLmQ@mail.gmail.com>
From:   Chunyan Zhang <zhang.lyra@gmail.com>
Date:   Wed, 26 May 2021 16:07:51 +0800
Message-ID: <CAAfSe-sRjSw=7vAX21OPL5+OfLXJNS9RNf8Lg5Hy56LZwPBwCA@mail.gmail.com>
Subject: Re: [PATCH v5 4/6] drm/sprd: add Unisoc's drm display controller driver
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Joerg Roedel <joro@8bytes.org>, Kevin Tang <kevin3.tang@gmail.com>,
        Maxime Ripard <maxime@cerno.tech>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>,
        ML dri-devel <dri-devel@lists.freedesktop.org>,
        DTML <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

resend for switching to plain text mode.

On Wed, 26 May 2021 at 15:59, Chunyan Zhang <zhang.lyra@gmail.com> wrote:
>
> Hi Robin,
>
> On Tue, 18 May 2021 at 00:35, Robin Murphy <robin.murphy@arm.com> wrote:
>>
>> On 2021-05-17 10:27, Joerg Roedel wrote:
>> > On Fri, Apr 30, 2021 at 08:20:10PM +0800, Kevin Tang wrote:
>> >> Cc  Robin & Joerg
>> >
>> > This is just some GPU internal MMU being used here, it seems. It doesn=
't
>> > use the IOMMU core code, so no Ack needed from the IOMMU side.
>>
>> Except the actual MMU being used is drivers/iommu/sprd_iommu.c - this is
>
> Yes, it is using drivers/iommu/sprd_iommu.c.
>
>>
>>
>> just the display driver poking directly at the interrupt registers of
>> its associated IOMMU instance.
>
>
> Actually the display driver is poking its own interrupt registers in whic=
h some interrupts are caused by using IOMMU, others are purely its own ones=
:
> +/* Interrupt control & status bits */
> +#define BIT_DPU_INT_DONE               BIT(0)
> +#define BIT_DPU_INT_TE                 BIT(1)
> +#define BIT_DPU_INT_ERR                        BIT(2)
> +#define BIT_DPU_INT_UPDATE_DONE                BIT(4)
> +#define BIT_DPU_INT_VSYNC              BIT(5)
> +#define BIT_DPU_INT_MMU_VAOR_RD                BIT(16)
> +#define BIT_DPU_INT_MMU_VAOR_WR                BIT(17)
> +#define BIT_DPU_INT_MMU_INV_RD         BIT(18)
> +#define BIT_DPU_INT_MMU_INV_WR         BIT(19)
>
> From what I see in the product code, along with the information my collea=
gues told me, these _INT_MMU_ interrupts only need to be dealt with by clie=
nt devices(i.e. display). IOMMU doesn't even have the INT_STS register for =
some early products which we're trying to support in the mainstream kernel.
>
>>
>> I still think this is wrong, and that it
>> should be treated as a shared interrupt, with the IOMMU driver handling
>> its own registers and reporting to the client through the standard
>> report_iommu_fault() API, especially since there are apparently more
>> blocks using these IOMMU instances than just the display.
>
> For the next generation IOMMU, we will handle interrupts in IOMMU drivers=
 like you say here.
> But like I explained above, we have to leave interrupt handling in the cl=
ient device driver since the IOMMU we 're using in this display device does=
n't have an INT_STS register in the IOMMU register range.
>
> Thanks for the review,
> Chunyan
>
>>
>> Robin.
