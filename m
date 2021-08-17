Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC9A93EEADB
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Aug 2021 12:22:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239534AbhHQKW5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Aug 2021 06:22:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:51056 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235204AbhHQKW4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Aug 2021 06:22:56 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 571F060F14;
        Tue, 17 Aug 2021 10:22:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629195743;
        bh=ZFAq4tNzIQzTRviQ8r6LSwQW3bkr+2nmdMRbQ7RZRsg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Go0Bezt4k+PVI8Qj0upYozJ00NOmTbzPu4M0awDHqDcsgWJdndB7ISgtdfZtLeaYG
         Dt9d7RxnVcyOrXoGBSHtYJr9o+y+nXSEXaEKexgxEWYGa+ZH76KIv2sY2VHfmE8q5r
         1SpEt34BkbGag+m6/yS+DwxaaVFiuSXKf+sZMdfujmWgXRHtoezgHH3f5STy6hl0to
         OGbx8Yt1h0u8LdYH+oXiCJywSnX9Ps942ktu6kpWVIR3+MQocxZVIAzX+t5YV1Vfef
         rNTPgDPsj3BIb0KopXt1U+xVS/1cVsfXAWdlGHMd3n6eSZRUZtnkvwd0UYUVjDJdTg
         3vMg5Cku7rj2A==
Date:   Tue, 17 Aug 2021 15:52:18 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Chunfeng Yun <chunfeng.yun@mediatek.com>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        Stanley Chu <stanley.chu@mediatek.com>
Subject: Re: [PATCH v3 1/9] dt-bindings: phy: mediatek: tphy: support type
 switch by pericfg
Message-ID: <YRuN2tvQtO294+sE@matsya>
References: <1629191987-20774-1-git-send-email-chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1629191987-20774-1-git-send-email-chunfeng.yun@mediatek.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17-08-21, 17:19, Chunfeng Yun wrote:
> Add support type switch by pericfg register between USB3, PCIe,
> SATA, SGMII, this is used to replace the way through efuse or
> jumper.

Applied all, thanks

-- 
~Vinod
