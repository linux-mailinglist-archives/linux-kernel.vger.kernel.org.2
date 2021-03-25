Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79574348A06
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Mar 2021 08:21:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229869AbhCYHUi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 03:20:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:35440 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229653AbhCYHUT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 03:20:19 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4478061A1E;
        Thu, 25 Mar 2021 07:20:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616656819;
        bh=apXDG/9jYfIBFrCfWedmF8k03GKxmM8e1bEmTBDzhMA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YiDtu63mMVWwzbw+IO5YbcSvTfT276ecd8++ADpbG+YRw8V0tMTr7bRT49tJb8PhS
         +FuyCTESxPzQrQpS8m3zsk0XIdxAwPfXQF0ABheLSC5qHjym7axk8L6xIz1BA1Jvwo
         ha3S7W4lz3I/6aSKjeU2YfNrE61VMr/9UYWokqBzvDVXpai210o47qZfUh+Oa4Cdv5
         IBYRIT7VcNFUqAEXD6gLrdqoASttXKJmOtnoANYwKe/vnrINuua+Gbuw/vPcPdZ1R0
         jgHCamwIGTVxd7+0Fp1LSwYDgqdRJdjkrC2ZmyGeo1nn6cajURlFbrgKnQAiZvMgs3
         HMkyOp1hp9YzA==
Date:   Thu, 25 Mar 2021 12:50:15 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Chunfeng Yun <chunfeng.yun@mediatek.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Jie Qiu <jie.qiu@mediatek.com>, CK Hu <ck.hu@mediatek.com>,
        Cawa Cheng <cawa.cheng@mediatek.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-usb@vger.kernel.org
Subject: Re: [PATCH v5 04/13] dt-bindings: phy: mediatek: tphy: change
 patternProperties
Message-ID: <YFw5rx7KLDU2bVu5@vkoul-mobl.Dlink>
References: <20210316092232.9806-1-chunfeng.yun@mediatek.com>
 <20210316092232.9806-4-chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210316092232.9806-4-chunfeng.yun@mediatek.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16-03-21, 17:22, Chunfeng Yun wrote:
> The phy may be named as pcie-phy when the T-PHY only supports
> PCIe mode, it's also the similar case for SATA, named as
> sata-phy.

Applied, thanks

-- 
~Vinod
