Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FA77348A04
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Mar 2021 08:21:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229758AbhCYHUg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 03:20:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:35402 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229508AbhCYHUH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 03:20:07 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C7EA661A17;
        Thu, 25 Mar 2021 07:20:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616656806;
        bh=KRphrLadXZdI9BDmHT6N1Pw/Szyl1lgk6OeGqFuzH38=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VFaaIpWCI73SZU9FE2Es4jmtZso4WsNaf0FAsUzk52iF52YjipZWYBjD3wigNjsfg
         zehgj/ji5TIcO5pT0AVd37mxbJbTAg3CcT/T/QtelPGFbvIV5+Qw6hZDmGxnNdNGvx
         iEapAiiWk2p5SdfWfszL93oUis5l4mprwzsvYFZB/N+MUY6QJA3y5EodmX9KWYS7Uc
         NEaLJvfpLxY2W54nYL8ce88k0nsmlR4vvRcD9RxHtye2JSjuQt/bHsp0QF5fuMk8rk
         XV9P4m1IPqc9ll7Ket07T6DpwFFkX+YvjWsJxo9rglzJuUJtILjeO8S03UZPfpXCpc
         uvymEcaP18NOQ==
Date:   Thu, 25 Mar 2021 12:50:03 +0530
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
Subject: Re: [PATCH v5 03/13] dt-bindings: phy: mediatek: hdmi-phy: modify
 compatible items
Message-ID: <YFw5oyqo+dLHKclH@vkoul-mobl.Dlink>
References: <20210316092232.9806-1-chunfeng.yun@mediatek.com>
 <20210316092232.9806-3-chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210316092232.9806-3-chunfeng.yun@mediatek.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16-03-21, 17:22, Chunfeng Yun wrote:
> mt7623-hdmi-tx is compatible to mt2701-hdmi-tx, and the compatible
> "mediatek,mt7623-hdmi-tx" is not supported in driver, in fact uses
> "mediatek,mt2701-hdmi-tx" instead on MT7623, so changes the
> compatible items to make dependence clear.

Applied, thanks

-- 
~Vinod
