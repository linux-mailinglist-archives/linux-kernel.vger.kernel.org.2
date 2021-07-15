Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 613CB3C990D
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jul 2021 08:52:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238903AbhGOGzh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jul 2021 02:55:37 -0400
Received: from 8bytes.org ([81.169.241.247]:38500 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236519AbhGOGzf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jul 2021 02:55:35 -0400
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 0D83D352; Thu, 15 Jul 2021 08:52:40 +0200 (CEST)
Date:   Thu, 15 Jul 2021 08:52:33 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        Sven Peter <sven@svenpeter.dev>, Will Deacon <will@kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        Hector Martin <marcan@marcan.st>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Marc Zyngier <maz@kernel.org>,
        Mohamed Mediouni <mohamed.mediouni@caramail.com>,
        Stan Skowronek <stan@corellium.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Mark Kettenis <mark.kettenis@xs4all.nl>,
        "open list:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>,
        Alexander Graf <graf@amazon.com>,
        Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>,
        Rob Herring <robh+dt@kernel.org>,
        Rouven Czerwinski <r.czerwinski@pengutronix.de>
Subject: Re: [PATCH v4 0/3] Apple M1 DART IOMMU driver
Message-ID: <YO/bMUAOLRgOJOvl@8bytes.org>
References: <20210627143405.77298-1-sven@svenpeter.dev>
 <7261df01-34a9-4e53-37cd-ae1aa15b1fb4@arm.com>
 <CAK8P3a18XK2mfMGbZ+M32Mbabhbkd+=DNrnzampOah_j=rWozw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a18XK2mfMGbZ+M32Mbabhbkd+=DNrnzampOah_j=rWozw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 14, 2021 at 10:51:34PM +0200, Arnd Bergmann wrote:
> The question is how we can best allow one but not the other.

By only allowing to allocate domains of type IDENTITY and DMA, but fail
to allocate UNMANAGED domains.

Regards,

	Joerg
