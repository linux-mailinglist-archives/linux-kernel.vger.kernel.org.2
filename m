Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EEDF8305016
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 04:45:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237010AbhA0Dog (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 22:44:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:52258 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727304AbhAZWZ7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 17:25:59 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1CEA920665;
        Tue, 26 Jan 2021 22:25:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611699917;
        bh=CoU9O01KVr4DWjJVSl5ku8nkaGtSHWQMM1dUjHH4D1Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=twPNmo72uAXJ6QVBm5A2LBiUtuDjPMG42HhkdXLbE+weZFsQlg7VkaAwFA4q/UvFa
         86KzGPMwOveXMNXjZGo8EeZzEuTqv3F9dmQN5N/kZdl7+Cy6OJ6eg1T7fr8Lc2HRzT
         m/BGqx9FZkBz0CMw8PO+fPN2XloBzUXQD81i28Msgq+LOI1IBjommGcyKhfR0d5gj6
         JgHKSLMQ+d9OeAPsKBZI6XmdYud34aWreyxXvA/bi2EsXnbRNHVuHz44OBK01tILr0
         xYswsSiZUrXH82JPkovBHMLXRjYNTICd0RBj/4BmnVRIJx1OBOehfmdE/wSL9kPLBV
         nJQv94OUZU3zw==
Date:   Tue, 26 Jan 2021 22:25:12 +0000
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
Message-ID: <20210126222511.GC30460@willie-the-truck>
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

This is looking good and I'd really like to see it merged, especially as it
has changes to the io-pgtable code. Please could you post a new version ASAP
to address the comments on patches 6 and 7?

Will
