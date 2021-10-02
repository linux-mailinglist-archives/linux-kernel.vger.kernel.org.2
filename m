Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2917F41FC5F
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Oct 2021 15:50:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233353AbhJBNwP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Oct 2021 09:52:15 -0400
Received: from ssl.serverraum.org ([176.9.125.105]:36105 "EHLO
        ssl.serverraum.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233303AbhJBNwO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Oct 2021 09:52:14 -0400
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 3D83E22247;
        Sat,  2 Oct 2021 15:50:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1633182627;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9RBHsJgd0XITPQCFP1JPbGV3C58losMUiz+4xOzAv5M=;
        b=sWpD+le2geJ1RENKYX/MzbeT8E4/7KKF3TvoiwAxa8C3Kk5wcyGqwAc/QcfwHv2jZyjF1h
        SxZv89b4gsmNda8Un0jiiM2nxbCqYqYI2a5PnPyH2ljWfzHr3bcnstUuFEpFGWJeoO/JDF
        tFi/mRo2JlIcIpzwPPDW1yynBvZofYw=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Sat, 02 Oct 2021 15:50:26 +0200
From:   Michael Walle <michael@walle.cc>
To:     Robin Murphy <robin.murphy@arm.com>, etnaviv@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc:     "Lukas F . Hartmann" <lukas@mntre.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Russell King <linux+etnaviv@armlinux.org.uk>,
        Christian Gmeiner <christian.gmeiner@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Subject: Re: [PATCH v2 0/3] drm/etnaviv: IOMMU related fixes
In-Reply-To: <20210907164945.2309815-1-michael@walle.cc>
References: <20210907164945.2309815-1-michael@walle.cc>
User-Agent: Roundcube Webmail/1.4.11
Message-ID: <06f099f8799acb9506826050a8610ffa@walle.cc>
X-Sender: michael@walle.cc
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 2021-09-07 18:49, schrieb Michael Walle:
> This patch series fixes usage of the etnaviv driver with GPUs behind a
> IOMMU. It was tested on a NXP LS1028A SoC. Together with Lucas' MMU 
> patches
> [1] there are not more (GPU internal) MMU nor (system) IOMMU faults on 
> the
> LS1028A.
> 
> [1] 
> https://lists.freedesktop.org/archives/etnaviv/2021-August/003682.html
> 
> changes since v1:
>  - don't move the former dma_mask setup code around in patch 2/3. Will
>    avoid any confusion.
> 
> Michael Walle (3):
>   drm/etnaviv: use PLATFORM_DEVID_NONE
>   drm/etnaviv: fix dma configuration of the virtual device
>   drm/etnaviv: use a 32 bit mask as coherent DMA mask
> 
>  drivers/gpu/drm/etnaviv/etnaviv_drv.c | 41 ++++++++++++++++++++-------
>  1 file changed, 31 insertions(+), 10 deletions(-)

ping? :)

-michael
