Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A684F3B847F
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jun 2021 15:55:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236081AbhF3N6J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Jun 2021 09:58:09 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:47470 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236279AbhF3N4I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jun 2021 09:56:08 -0400
Received: from maud (unknown [IPv6:2600:8800:8c04:8c00::912b])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: alyssa)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 3BA061F43564;
        Wed, 30 Jun 2021 14:53:32 +0100 (BST)
Date:   Wed, 30 Jun 2021 09:53:26 -0400
From:   Alyssa Rosenzweig <alyssa@collabora.com>
To:     Sven Peter <sven@svenpeter.dev>
Cc:     Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
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
Subject: Re: [PATCH v4 1/3] iommu: io-pgtable: add DART pagetable format
Message-ID: <YNx3Vvs9VjvIpx2f@maud>
References: <20210627143405.77298-1-sven@svenpeter.dev>
 <20210627143405.77298-2-sven@svenpeter.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210627143405.77298-2-sven@svenpeter.dev>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reviewed-by: Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>
