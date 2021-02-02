Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B46630BFA6
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 14:39:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232626AbhBBNhF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 08:37:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:33008 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232420AbhBBNeu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 08:34:50 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 521FC64F51;
        Tue,  2 Feb 2021 13:34:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612272845;
        bh=Qc82Rs1BO/kqAuHM5fqbYivehM9Zpe/q/Rk+nnanzSg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Rq0QnvC6dVMTqTSjlBcM3j0Fae/zpps7YBL8rDHFtXiYCHsNkpgUTppGN6K4hqIrb
         edDS1gAiPwbetu6tWSl9Vta07jbjBtsbXymdYJVMz0BAFERuwrWqOoE8JEWlITWUym
         kSBu1Hvj7++Q3KhFAOn7GYFAJRobhWTnQzDhPpgPkDJBb2+vmwtgNEI1rTZfcDLk34
         uH8V0g7QGutVlEEhLHM96YbjM0IeXlx42/IDhP1pbBV96U0TPX8TeQz8BzqVldtr7O
         8bOnNEZUbb1tqrf/yES4UgRiBbNfflqqdQt3ypOMeBlaUFdtPWOuacG/CjCSQXYwjZ
         s0ZTqM/4rso+w==
Date:   Tue, 2 Feb 2021 13:33:58 +0000
From:   Will Deacon <will@kernel.org>
To:     Yong Wu <yong.wu@mediatek.com>
Cc:     Joerg Roedel <joro@8bytes.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Evan Green <evgreen@chromium.org>,
        Tomasz Figa <tfiga@google.com>,
        linux-mediatek@lists.infradead.org, srv_heupstream@mediatek.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org, youlin.pei@mediatek.com,
        Nicolas Boichat <drinkcat@chromium.org>, anan.sun@mediatek.com,
        chao.hao@mediatek.com
Subject: Re: [PATCH v6 00/33] MT8192 IOMMU support
Message-ID: <20210202133358.GA17070@willie-the-truck>
References: <20210111111914.22211-1-yong.wu@mediatek.com>
 <20210201145422.GA15263@willie-the-truck>
 <1612231425.2524.12.camel@mhfsdcap03>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1612231425.2524.12.camel@mhfsdcap03>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 02, 2021 at 10:03:45AM +0800, Yong Wu wrote:
> On Mon, 2021-02-01 at 14:54 +0000, Will Deacon wrote:
> > On Mon, Jan 11, 2021 at 07:18:41PM +0800, Yong Wu wrote:
> > > This patch mainly adds support for mt8192 Multimedia IOMMU and SMI.
> > > 
> > > mt8192 also is MTK IOMMU gen2 which uses ARM Short-Descriptor translation
> > > table format. The M4U-SMI HW diagram is as below:
> > > 
> > >                           EMI
> > >                            |
> > >                           M4U
> > >                            |
> > >                       ------------
> > >                        SMI Common
> > >                       ------------
> > >                            |
> > >   +-------+------+------+----------------------+-------+
> > >   |       |      |      |       ......         |       |
> > >   |       |      |      |                      |       |
> > > larb0   larb1  larb2  larb4     ......      larb19   larb20
> > > disp0   disp1   mdp    vdec                   IPE      IPE
> > > 
> > > All the connections are HW fixed, SW can NOT adjust it.
> > > 
> > > Comparing with the preview SoC, this patchset mainly adds two new functions:
> > > a) add iova 34 bits support.
> > > b) add multi domains support since several HW has the special iova
> > > region requirement.
> > > 
> > > change note:
> > > v6:a) base on v5.11-rc1. and tlb v4:
> > >       https://lore.kernel.org/linux-mediatek/20210107122909.16317-1-yong.wu@mediatek.com/T/#t 
> > 
> > I've queued this up apart from patches 6 and 7.
> 
> Thanks very much for the applying. I'd like to show there is a little
> conflict with a smi change[1] in /include/soc/mediatek/smi.h.
> 
> This is the detailed conflict:
> 
> --- a/include/soc/mediatek/smi.h
> +++ b/include/soc/mediatek/smi.h
> @@ -9,7 +9,7 @@
>  #include <linux/bitops.h>
>  #include <linux/device.h>
>  
> -#ifdef CONFIG_MTK_SMI
> +#if IS_ENABLED(CONFIG_MTK_SMI)   <---The smi patch change here.
>  
>  #define MTK_LARB_NR_MAX   16  <---This iommu patchset delete this line.
> 
> 
> This code is simple. Please feel free to tell me how to do this if this
> is not convenient to merge.

Thanks, but this should be trivial to resolve, so I don't think we need to
worry about it.

Will
