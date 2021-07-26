Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE3C83D5A36
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jul 2021 15:20:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233563AbhGZMjp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jul 2021 08:39:45 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:34062 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233287AbhGZMjh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jul 2021 08:39:37 -0400
Received: from maud (unknown [IPv6:2600:8800:8c04:8c00::ffa6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: alyssa)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 1F5A91F424CD;
        Mon, 26 Jul 2021 14:19:57 +0100 (BST)
Date:   Mon, 26 Jul 2021 09:19:52 -0400
From:   Alyssa Rosenzweig <alyssa@collabora.com>
To:     Sven Peter <sven@svenpeter.dev>
Cc:     Robin Murphy <robin.murphy@arm.com>, Will Deacon <will@kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        Arnd Bergmann <arnd@kernel.org>,
        Rouven Czerwinski <r.czerwinski@pengutronix.de>,
        devicetree@vger.kernel.org, Marc Zyngier <maz@kernel.org>,
        Hector Martin <marcan@marcan.st>, linux-kernel@vger.kernel.org,
        Petr Mladek via iommu <iommu@lists.linux-foundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Alexander Graf <graf@amazon.com>,
        Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>,
        Mohamed Mediouni <mohamed.mediouni@caramail.com>,
        Mark Kettenis <mark.kettenis@xs4all.nl>,
        linux-arm-kernel@lists.infradead.org,
        Stan Skowronek <stan@corellium.com>
Subject: Re: [PATCH v4 3/3] iommu: dart: Add DART iommu driver
Message-ID: <YP62eOnGSpXOumX+@maud>
References: <20210627143405.77298-1-sven@svenpeter.dev>
 <20210627143405.77298-4-sven@svenpeter.dev>
 <f3574c75-db2d-47fc-bda5-0f0f627fb524@arm.com>
 <30b00cf1-6366-4075-be8a-992fb1778306@www.fastmail.com>
 <69259ab4-0da9-ddc7-97b0-9ef1e33a39ec@arm.com>
 <de9dcabd-a3c3-4f34-9f09-6e23deed3a98@www.fastmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <de9dcabd-a3c3-4f34-9f09-6e23deed3a98@www.fastmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> I'll let my current version simmer for a bit and wait until it's been
> tested by a few people and will send it in a week or so then!

New version has my T-b :)
