Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A10930AAF6
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 16:20:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231587AbhBAPTe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 10:19:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:36114 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230091AbhBAOzT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 09:55:19 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 80B7F64E08;
        Mon,  1 Feb 2021 14:54:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612191269;
        bh=UfY3ArU2Ba52g7BMgBfvsVQ2y0huUNSig9ApYXP8TIU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ulg+rsdevXRtCjtTFGOizv2sb4y2ls4EABbPyo9gn2WsK0n6vSp6Na2wilJ5T5C0m
         hK8/LsVRjMUQ+Aa+l+vRce00wC3jqhrVTXlZUgaMHnxcgp/kH+mC0fj/JXC+InheOY
         y7UjHKCM553yfX5RjpOE6MnP8Gz/jLjFS8YLb4RkzK8r4RQv+/6W0uJiBsZB4BaOjz
         BFJDSELZCG/g5ezyx7N4LFcjaaXXvRHoLCyO4SKbB67p1jOrG7dvwUBmGGuhT9NwiT
         +pvv1lmrEIC2y1CrJsa7PUN3NzkH77p+147UW3/uy5+jPO4ZHz2gkWwxlXCxRWDio1
         AwGMEZD4oK6Mg==
Date:   Mon, 1 Feb 2021 14:54:23 +0000
From:   Will Deacon <will@kernel.org>
To:     Yong Wu <yong.wu@mediatek.com>
Cc:     Joerg Roedel <joro@8bytes.org>, Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Evan Green <evgreen@chromium.org>,
        Tomasz Figa <tfiga@google.com>,
        linux-mediatek@lists.infradead.org, srv_heupstream@mediatek.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org, youlin.pei@mediatek.com,
        Nicolas Boichat <drinkcat@chromium.org>, anan.sun@mediatek.com,
        chao.hao@mediatek.com
Subject: Re: [PATCH v6 00/33] MT8192 IOMMU support
Message-ID: <20210201145422.GA15263@willie-the-truck>
References: <20210111111914.22211-1-yong.wu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210111111914.22211-1-yong.wu@mediatek.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 11, 2021 at 07:18:41PM +0800, Yong Wu wrote:
> This patch mainly adds support for mt8192 Multimedia IOMMU and SMI.
> 
> mt8192 also is MTK IOMMU gen2 which uses ARM Short-Descriptor translation
> table format. The M4U-SMI HW diagram is as below:
> 
>                           EMI
>                            |
>                           M4U
>                            |
>                       ------------
>                        SMI Common
>                       ------------
>                            |
>   +-------+------+------+----------------------+-------+
>   |       |      |      |       ......         |       |
>   |       |      |      |                      |       |
> larb0   larb1  larb2  larb4     ......      larb19   larb20
> disp0   disp1   mdp    vdec                   IPE      IPE
> 
> All the connections are HW fixed, SW can NOT adjust it.
> 
> Comparing with the preview SoC, this patchset mainly adds two new functions:
> a) add iova 34 bits support.
> b) add multi domains support since several HW has the special iova
> region requirement.
> 
> change note:
> v6:a) base on v5.11-rc1. and tlb v4:
>       https://lore.kernel.org/linux-mediatek/20210107122909.16317-1-yong.wu@mediatek.com/T/#t 

I've queued this up apart from patches 6 and 7.

Thanks,

Will
