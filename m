Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B0BF3E429B
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Aug 2021 11:27:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234452AbhHIJ2R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Aug 2021 05:28:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234417AbhHIJ2P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Aug 2021 05:28:15 -0400
Received: from theia.8bytes.org (8bytes.org [IPv6:2a01:238:4383:600:38bc:a715:4b6d:a889])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91FCBC061798;
        Mon,  9 Aug 2021 02:27:54 -0700 (PDT)
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 3CAC31DCE; Mon,  9 Aug 2021 11:27:49 +0200 (CEST)
Date:   Mon, 9 Aug 2021 11:27:26 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Sven Peter <sven@svenpeter.dev>
Cc:     Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Arnd Bergmann <arnd@kernel.org>, devicetree@vger.kernel.org,
        Hector Martin <marcan@marcan.st>, linux-kernel@vger.kernel.org,
        Marc Zyngier <maz@kernel.org>,
        Mohamed Mediouni <mohamed.mediouni@caramail.com>,
        Stan Skowronek <stan@corellium.com>,
        linux-arm-kernel@lists.infradead.org,
        Mark Kettenis <mark.kettenis@xs4all.nl>,
        iommu@lists.linux-foundation.org, Alexander Graf <graf@amazon.com>,
        Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>,
        Rob Herring <robh+dt@kernel.org>, r.czerwinski@pengutronix.de
Subject: Re: [PATCH v5 0/3] Apple M1 DART IOMMU driver
Message-ID: <YRD0/qZek2iCwsJi@8bytes.org>
References: <20210803121651.61594-1-sven@svenpeter.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210803121651.61594-1-sven@svenpeter.dev>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 03, 2021 at 02:16:48PM +0200, Sven Peter wrote:
> Sven Peter (3):
>   iommu/io-pgtable: Add DART pagetable format
>   dt-bindings: iommu: add DART iommu bindings
>   iommu/dart: Add DART iommu driver

Applied, thanks. This driver now lives in the apple/dart branch of the
IOMMU tree.

