Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FDF734AC20
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 17:00:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230250AbhCZQAP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Mar 2021 12:00:15 -0400
Received: from sibelius.xs4all.nl ([83.163.83.176]:61899 "EHLO
        sibelius.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230223AbhCZP7y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Mar 2021 11:59:54 -0400
Received: from localhost (bloch.sibelius.xs4all.nl [local])
        by bloch.sibelius.xs4all.nl (OpenSMTPD) with ESMTPA id ff3d25fc;
        Fri, 26 Mar 2021 16:59:46 +0100 (CET)
Date:   Fri, 26 Mar 2021 16:59:46 +0100 (CET)
From:   Mark Kettenis <mark.kettenis@xs4all.nl>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     sven@svenpeter.dev, robh@kernel.org,
        iommu@lists.linux-foundation.org, joro@8bytes.org, will@kernel.org,
        robin.murphy@arm.com, marcan@marcan.st, maz@kernel.org,
        mohamed.mediouni@caramail.com, stan@corellium.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
In-Reply-To: <CAK8P3a0fvnYLrG=cGiOQ6u8aZnriTeM0R=MW7FX=94mO13Rq0w@mail.gmail.com>
        (message from Arnd Bergmann on Thu, 25 Mar 2021 22:41:09 +0100)
Subject: Re: [PATCH 0/3] Apple M1 DART IOMMU driver
References: <20210320151903.60759-1-sven@svenpeter.dev> <c1bcc0609e920bc6@bloch.sibelius.xs4all.nl>
 <20210323205346.GA1283560@robh.at.kernel.org> <43685c67-6d9c-4e72-b320-0462c2273bf0@www.fastmail.com> <CAK8P3a0fvnYLrG=cGiOQ6u8aZnriTeM0R=MW7FX=94mO13Rq0w@mail.gmail.com>
Message-ID: <c1bcd90d344c2b68@bloch.sibelius.xs4all.nl>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Arnd Bergmann <arnd@kernel.org>
> Date: Thu, 25 Mar 2021 22:41:09 +0100
> 
> On Thu, Mar 25, 2021 at 8:53 AM Sven Peter <sven@svenpeter.dev> wrote:
> > On Tue, Mar 23, 2021, at 21:53, Rob Herring wrote:
> >
> > I'm probably just confused or maybe the documentation is outdated but I don't
> > see how I could specify "this device can only use DMA addresses from
> > 0x00100000...0x3ff00000 but can map these via the iommu to any physical
> > address" using 'dma-ranges'.
> 
> It sounds like this is a holdover from the original powerpc iommu,
> which also had a limited set of virtual addresses in the iommu.
> 
> I would think it's sufficient to describe it in the iommu itself,
> since the limitation is more "addresses coming into the iommu must
> be this range" than "this device must use that address range for
> talking to the iommu".
> 
> If the addresses are allocated by the iommu driver, and each iommu
> only has one DMA master attached to it, having a simple range
> property in the iommu node should do the trick here. If there might
> be multiple devices on the same iommu but with different address
> ranges (which I don't think is the case), then it could be part of
> the reference to the iommu.

The ADT has properties on the iommu node that describe the adresses it
accepts for translation ("vm-base" and "vm-size").  So I think we can
safely assume that the same limits apply to all DMA masters that are
attached to it.  We don't know if the range limit is baked into the
silicon or whether it is related to how the firmware sets things up.
Having the properties on the iommu node makes it easy for m1n1 to
update the properties with the right values if necessary.

Some of the DARTs provide a bypass facility.  That code make using the
standard "dma-ranges" property tricky.  That property would need to
contain the bypass address range.  But that would mean that if the
DART driver needs to look at that property to figure out the address
range that supports translation it will need to be able to distinguish
between the translatable address range and the bypass address range.

Cheers,

Mark
