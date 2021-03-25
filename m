Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D91C349BC8
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Mar 2021 22:42:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231159AbhCYVli (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 17:41:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:57548 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230470AbhCYVl0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 17:41:26 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D75CE61A41;
        Thu, 25 Mar 2021 21:41:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616708485;
        bh=RPr0+GAQJYl2SXFGMPkIt54GGFqTX+CVANOyfY1QFiY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=k5NiMFpnmGFDfTsTgKkHIfzy4Q87nBn6/uezhrr7m3mdolnhlED3LoG2wzf7SLR0T
         6pJzRE49SLYcBdd4RAg+iDP6Hp19foyZiJFV1U4ve6HWe9qMn5bVFVEFjZ1V15mpeV
         in8BH2QDhzOkk4kZeC/xFj0gzIgg2AIUXregXyHPu4glOXPYvR7pCBjb9tYWgChXnG
         D+eZZZCxkB6I66pyymVQi+/j4qs6M9S0Lb1FncI41V8nC1n7SFypn5EVyWrbNgdIGv
         eD8ZxcfeA9cYjZODc8ytNDL+5RbW8uEXJnrsSvNWz/E1/QPT7wOpKO2oz5jn4NSMzz
         JkxGn/cloYGJQ==
Received: by mail-ot1-f42.google.com with SMTP id l12-20020a9d6a8c0000b0290238e0f9f0d8so3396036otq.8;
        Thu, 25 Mar 2021 14:41:25 -0700 (PDT)
X-Gm-Message-State: AOAM530X5Q+aMS4MPWv4Txjyfi6DksEIc9x/aobSURkMt838RhzTUZFw
        aLaQPsnY0aUC0kb2GrY0Z2O9ff1ACs4yA/UbOA4=
X-Google-Smtp-Source: ABdhPJxlCcqleUvoMM0qnZXW4lBarEjgZ1ug3Hjq78DPfvPnEuxx7Lua3VGxdB55kpr9ovRvIeqvFoRKnXWmtETo1pU=
X-Received: by 2002:a05:6830:148c:: with SMTP id s12mr9471035otq.251.1616708485174;
 Thu, 25 Mar 2021 14:41:25 -0700 (PDT)
MIME-Version: 1.0
References: <20210320151903.60759-1-sven@svenpeter.dev> <c1bcc0609e920bc6@bloch.sibelius.xs4all.nl>
 <20210323205346.GA1283560@robh.at.kernel.org> <43685c67-6d9c-4e72-b320-0462c2273bf0@www.fastmail.com>
In-Reply-To: <43685c67-6d9c-4e72-b320-0462c2273bf0@www.fastmail.com>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Thu, 25 Mar 2021 22:41:09 +0100
X-Gmail-Original-Message-ID: <CAK8P3a0fvnYLrG=cGiOQ6u8aZnriTeM0R=MW7FX=94mO13Rq0w@mail.gmail.com>
Message-ID: <CAK8P3a0fvnYLrG=cGiOQ6u8aZnriTeM0R=MW7FX=94mO13Rq0w@mail.gmail.com>
Subject: Re: [PATCH 0/3] Apple M1 DART IOMMU driver
To:     Sven Peter <sven@svenpeter.dev>
Cc:     Rob Herring <robh@kernel.org>,
        Mark Kettenis <mark.kettenis@xs4all.nl>,
        "open list:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Hector Martin <marcan@marcan.st>,
        Marc Zyngier <maz@kernel.org>,
        Mohamed Mediouni <mohamed.mediouni@caramail.com>,
        Stan Skowronek <stan@corellium.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 25, 2021 at 8:53 AM Sven Peter <sven@svenpeter.dev> wrote:
> On Tue, Mar 23, 2021, at 21:53, Rob Herring wrote:
>
> I'm probably just confused or maybe the documentation is outdated but I don't
> see how I could specify "this device can only use DMA addresses from
> 0x00100000...0x3ff00000 but can map these via the iommu to any physical
> address" using 'dma-ranges'.

It sounds like this is a holdover from the original powerpc iommu, which also
had a limited set of virtual addresses in the iommu.

I would think it's sufficient to describe it in the iommu itself,
since the limitation
is more "addresses coming into the iommu must be this range" than "this device
must use that address range for talking to the iommu".

If the addresses are allocated by the iommu driver, and each iommu only has
one DMA master attached to it, having a simple range property in the iommu
node should do the trick here. If there might be multiple devices on the same
iommu but with different address ranges (which I don't think is the case), then
it could be part of the reference to the iommu.

         Arnd
