Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D36073566E9
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 10:34:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245066AbhDGIen (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 04:34:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234223AbhDGIem (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 04:34:42 -0400
Received: from theia.8bytes.org (8bytes.org [IPv6:2a01:238:4383:600:38bc:a715:4b6d:a889])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 067DFC06174A
        for <linux-kernel@vger.kernel.org>; Wed,  7 Apr 2021 01:34:33 -0700 (PDT)
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 9C5AE2A6; Wed,  7 Apr 2021 10:34:31 +0200 (CEST)
Date:   Wed, 7 Apr 2021 10:34:30 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Yong Wu <yong.wu@mediatek.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Tomasz Figa <tfiga@chromium.org>,
        linux-mediatek@lists.infradead.org, srv_heupstream@mediatek.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org,
        Krzysztof Kozlowski <krzk@kernel.org>, youlin.pei@mediatek.com,
        Nicolas Boichat <drinkcat@chromium.org>, anan.sun@mediatek.com,
        chao.hao@mediatek.com
Subject: Re: [PATCH v2 1/2] iommu/mediatek-v1: Allow building as module
Message-ID: <YG1ulkL15n2MiE7E@8bytes.org>
References: <20210326032337.24578-1-yong.wu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210326032337.24578-1-yong.wu@mediatek.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 26, 2021 at 11:23:36AM +0800, Yong Wu wrote:
> This patch only adds support for building the IOMMU-v1 driver as module.
> Correspondingly switch the config to tristate and update the iommu_ops's
> owner to THIS_MODULE.
> 
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>

Applied both, thanks.
