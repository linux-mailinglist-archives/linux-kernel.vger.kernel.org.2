Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 512B03489FD
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Mar 2021 08:20:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229624AbhCYHUC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 03:20:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:35366 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229448AbhCYHTx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 03:19:53 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id DD0D561A1A;
        Thu, 25 Mar 2021 07:19:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616656792;
        bh=g243cFH6HzGVN9Dded6fTHsxRaAv/nLJsBc+qCK+vEE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tLmgKPGT4azqd8RHFMTFdwA0SXDBiGGWim2zVgc7YrjLvWzfyEEkvfsTQ51u/KMvK
         q+LXly0bmWdsbq/l7llE/xQxZSVgbqc5fX6zysFBRjIjm8SDqDFZS1qwLrakZh1E/v
         zt6e2m/n0poTuePcK25wbFUbjQzhwcJkPT/yPDfSwg3fnlJ9rFd3QdqcGuuKuFfrsS
         6ToHZrO3KzqSQDgpJzAtlvcsvI0J3gALkKoY/PZYY77PFuDaXjEUGAgoLMW0xPAbiy
         7VJKXmPQ6VL3FExDuJRLa5lB3UvdAGvYfSFiijUsfIxWFg+oYMN3XgMFbw7zMkj3zn
         oKXjxN3uRYnEA==
Date:   Thu, 25 Mar 2021 12:49:48 +0530
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
Subject: Re: [PATCH v5 02/13] dt-bindings: phy: mediatek: dsi-phy: modify
 compatible dependence
Message-ID: <YFw5lNeunVShUL9I@vkoul-mobl.Dlink>
References: <20210316092232.9806-1-chunfeng.yun@mediatek.com>
 <20210316092232.9806-2-chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210316092232.9806-2-chunfeng.yun@mediatek.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16-03-21, 17:22, Chunfeng Yun wrote:
> mt7623-mipi-tx is compatible to mt2701-mipi-tx, and use
> "mediatek,mt2701-mipi-tx" instead on MT7623, so modify
> the compatible items to make dependence clear.

Applied, thanks

-- 
~Vinod
