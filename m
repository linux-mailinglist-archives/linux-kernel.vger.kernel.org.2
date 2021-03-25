Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8672F3497B4
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Mar 2021 18:17:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229868AbhCYRQj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 13:16:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:40770 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229642AbhCYRQU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 13:16:20 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0483561A16;
        Thu, 25 Mar 2021 17:16:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616692580;
        bh=phmny67lf++X1rkQVwR6baI2+MCDEs3wLD7iAm3xsOs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=E8VU9MDHPFOdaovt8n/9YdPSCpUyUpJaxNyRawPd3nCxPu/Vk7czI8/ZJWaoeeuTf
         2R7t9YGqqT/43VsL64M8tIUa4sP8SqicY5T75O78nf6c9waYFoto0mjNPEw3OJZS40
         eFElJ8FxMP5Cc2QPIYS1oEnsKLetLwI5kqj58e/Dcpq010+0kokWUrmdQxxi27C1l4
         0yboQp8QEF6PNrPe4ufEMHy19PVfjXOFF2pLq0Q6egatY2jaDG+COxaggbchnJh0mx
         zCuXAfWT4A5r5anmO/0tHnwfW7ulOWdETLsGuZmLoWMKzLg8Yn/UfHrjcj2SMRApos
         XxOBd/1Q+3mJQ==
Date:   Thu, 25 Mar 2021 17:16:14 +0000
From:   Will Deacon <will@kernel.org>
To:     Yong Wu <yong.wu@mediatek.com>
Cc:     Joerg Roedel <joro@8bytes.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Tomasz Figa <tfiga@chromium.com>,
        linux-mediatek@lists.infradead.org, srv_heupstream@mediatek.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org,
        Krzysztof Kozlowski <krzk@kernel.org>, youlin.pei@mediatek.com,
        Nicolas Boichat <drinkcat@chromium.org>, anan.sun@mediatek.com,
        chao.hao@mediatek.com
Subject: Re: [PATCH 1/2] iommu/mediatek-v1: Alloc building as module
Message-ID: <20210325171614.GA15433@willie-the-truck>
References: <20210323055801.16885-1-yong.wu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210323055801.16885-1-yong.wu@mediatek.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 23, 2021 at 01:58:00PM +0800, Yong Wu wrote:
> This patch only adds support for building the IOMMU-v1 driver as module.
> Correspondingly switch the config to tristate.
> 
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> ---
> rebase on v5.12-rc2.
> ---
>  drivers/iommu/Kconfig        | 2 +-
>  drivers/iommu/mtk_iommu_v1.c | 9 ++++-----
>  2 files changed, 5 insertions(+), 6 deletions(-)

Both of these patches look fine to me, but you probably need to check
the setting of MODULE_OWNER after:

https://lore.kernel.org/r/f4de29d8330981301c1935e667b507254a2691ae.1616157612.git.robin.murphy@arm.com

Will
