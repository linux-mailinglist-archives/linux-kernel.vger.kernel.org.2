Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A529D34AFC4
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 21:04:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230195AbhCZUEI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Mar 2021 16:04:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:60790 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229986AbhCZUDt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Mar 2021 16:03:49 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A60E161A02;
        Fri, 26 Mar 2021 20:03:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616789028;
        bh=4LKLYKqudMoB6aEd0Ps7uLTpOx51F1Icssxa7AiFOw0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=prkDcNQpdnFzJnZv4Ul12AA/8zLGY27K6F+rBjzHhJq5NBK64WHUpsTem8eBtcfq8
         HEU/kcqmBG6bk7WnfZ/IM91KhzhQE2pUDGa/zVEP4ococfpu86/s24LCtrU8wT2GyK
         m6gUaMsN8IGte6bF3v8K/u3vkltqzOTXU/j30NXMfmjBWUvpR3aJWYqOM0+15uxvEs
         LyEnaWEoeurwpOM/zxMXBSi9YSAaeaglJTAllj1WTCQJMYJTZ7QrGQhjLmJ3ajNCyS
         LXCywYD3hnmQcNFxE9Lud5JbQkq41i3G35jD0V1uR7vTEi10VW2BiRXNMLm/7ThHYG
         Kx2Z0hgshZvtw==
Received: by mail-ot1-f54.google.com with SMTP id y19-20020a0568301d93b02901b9f88a238eso6311170oti.11;
        Fri, 26 Mar 2021 13:03:48 -0700 (PDT)
X-Gm-Message-State: AOAM531uQ3TdQMWAMEyblGZEI/rkSNWF040dmZKC3+tccVON8I7jjC1l
        w3BixtdxNeuUdPmdWZZBKU8izULwbFZw/NB2M+8=
X-Google-Smtp-Source: ABdhPJyPEunl4Ngli4e/a9ttTgDySVGUAx1snwV7toHx9J8Evv0fmZt1qQLI1SgPLsSAWwUdD3HAzaFQDSDeIqyJHRs=
X-Received: by 2002:a05:6830:148c:: with SMTP id s12mr13387334otq.251.1616789027968;
 Fri, 26 Mar 2021 13:03:47 -0700 (PDT)
MIME-Version: 1.0
References: <20210320151903.60759-1-sven@svenpeter.dev> <c1bcc0609e920bc6@bloch.sibelius.xs4all.nl>
 <20210323205346.GA1283560@robh.at.kernel.org> <43685c67-6d9c-4e72-b320-0462c2273bf0@www.fastmail.com>
 <CAK8P3a0fvnYLrG=cGiOQ6u8aZnriTeM0R=MW7FX=94mO13Rq0w@mail.gmail.com>
 <c1bcd90d344c2b68@bloch.sibelius.xs4all.nl> <9f06872d-f0ec-43c3-9b53-d144337100b3@www.fastmail.com>
 <CAK8P3a2b7k6JkxecW=yu-NF+fkNCxJ3Ja36nQ7LK8hsuO=4=sw@mail.gmail.com> <c1bcd9821a8f8c05@bloch.sibelius.xs4all.nl>
In-Reply-To: <c1bcd9821a8f8c05@bloch.sibelius.xs4all.nl>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Fri, 26 Mar 2021 21:03:32 +0100
X-Gmail-Original-Message-ID: <CAK8P3a1CFHgjuzmefKcbC3MPeBD0USeTe7oZsTcQ=6tagG3Cvw@mail.gmail.com>
Message-ID: <CAK8P3a1CFHgjuzmefKcbC3MPeBD0USeTe7oZsTcQ=6tagG3Cvw@mail.gmail.com>
Subject: Re: [PATCH 0/3] Apple M1 DART IOMMU driver
To:     Mark Kettenis <mark.kettenis@xs4all.nl>
Cc:     sven@svenpeter.dev, Rob Herring <robh@kernel.org>,
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

On Fri, Mar 26, 2021 at 6:28 PM Mark Kettenis <mark.kettenis@xs4all.nl> wrote:

> I haven't figured out how the bypass stuff really works.  Corellium
> added support for it in their codebase when they added support for
> Thunderbolt, and some of the DARTs that seem to be related to
> Thunderbolt do indeed have a "bypass" property.  But it is unclear to
> me how the different puzzle pieces fit together for Thunderbolt.

As a general observation, bypass mode for Thunderbolt is what enabled
the http://thunderclap.io/ attack. This is extremely useful for debugging
a running kernel from another machine, but it's also something that
should never be done in a production kernel.

         Arnd
