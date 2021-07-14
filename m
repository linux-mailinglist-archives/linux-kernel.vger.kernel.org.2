Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F11193C82AE
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jul 2021 12:26:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239045AbhGNK2p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jul 2021 06:28:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238728AbhGNK2o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jul 2021 06:28:44 -0400
Received: from theia.8bytes.org (8bytes.org [IPv6:2a01:238:4383:600:38bc:a715:4b6d:a889])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3E7CC06175F
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jul 2021 03:25:52 -0700 (PDT)
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 7006E3D0; Wed, 14 Jul 2021 12:25:47 +0200 (CEST)
Date:   Wed, 14 Jul 2021 12:25:31 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Konrad Rzeszutek Wilk <konrad@darnok.org>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>, will@kernel.org,
        "open list:AMD IOMMU (AMD-VI)" <iommu@lists.linux-foundation.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] iommu/amd: Enable swiotlb if any device supports iommu
 v2 and uses identity mapping
Message-ID: <YO67m/jaBvco+I36@8bytes.org>
References: <20210708074232.924844-1-kai.heng.feng@canonical.com>
 <YObFJREB9/JlcNZP@8bytes.org>
 <fde11cec-d1bd-49be-f129-c69a973d1b3b@arm.com>
 <CAAd53p40RcG0oeYr9QAKMjYRtyq7he=d_b_a39n4Rt5JSVScRQ@mail.gmail.com>
 <f3bdedcb-5602-cbca-7df1-019e8b8c4217@arm.com>
 <YO4odF0EwqxfNLFq@fedora>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YO4odF0EwqxfNLFq@fedora>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 13, 2021 at 07:57:40PM -0400, Konrad Rzeszutek Wilk wrote:
> The SWIOTLB does have support to do late initialization (xen-pcifront
> does that for example - so if you add devices that can't do 64-bit it
> will allocate something like 4MB).

That sounds like a way to evaluate. I suggest to allocate the SWIOTLB
memory at boot and when the IOMMUs are initialized we re-evaluate what
we ended up with and free the SWIOTLB memory if its not needed.

If that turns out to be wrong during runtime (e.g. because a device is
switched to a passthrough default domain at runtime), we allocate a
small aperture for this device like the above mentioned 4MB.

(A boot option to always keep the aperture around might also be helpful
 for some setups)

Regards,

	Joerg
