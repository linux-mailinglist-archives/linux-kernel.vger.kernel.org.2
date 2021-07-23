Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04E203D31F6
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jul 2021 04:41:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233484AbhGWCA0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jul 2021 22:00:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:43550 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233255AbhGWCAZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jul 2021 22:00:25 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 97A6260EBD;
        Fri, 23 Jul 2021 02:40:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627008059;
        bh=Uw/UjQroG3bccpoxxRjplCXJ+f0gWEBZ71qxaMpzeVY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZtER0km0G4OiTFBdh0DML9qrqBJGDbeSJxzxSOQ715pehQj2V0OIotByT5oCowYU6
         iGb9eMUMBLugYphdv6YwXP5Ff0BGyTr7QLXha7cyXT4oLnlHOEKnZO5EXa8nY5g2iS
         jKFsv0cgQ5ml/sIVCNA9wX+b+4mm/im5BDSP5A4Ffb9Lb14z+8edSXlRooTUm0NouY
         dpr3HpwTFWWPATlpJw8urhUDtfXDqY+v1pY7EXXNU8UQPeiT7dpwe2zQr6R5Rtgysg
         JAlxsWnEjQWPalWftGJ4SrrNtohgeAjteDCKYVc4+OM0RaV1jxrLWe/GgJUri4bFeD
         I7/xniChtkNEg==
Date:   Fri, 23 Jul 2021 10:40:54 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Michael Walle <michael@walle.cc>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Li Yang <leoyang.li@nxp.com>,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH] arm64: dts: ls1028: sl28: fix networking for variant 2
Message-ID: <20210723024054.GC28658@dragon>
References: <20210702194914.10921-1-michael@walle.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210702194914.10921-1-michael@walle.cc>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 02, 2021 at 09:49:14PM +0200, Michael Walle wrote:
> The PHY configuration for the variant 2 is still missing the flag for
> in-band signalling between PHY and MAC. Both sides - MAC and PHY - have
> to match the setting. For now, Linux only supports setting the MAC side
> and thus it has to match the setting the bootloader is configuring.
> Enable in-band signalling to make ethernet work.
> 
> Fixes: ab43f0307449 ("arm64: dts: ls1028a: sl28: add support for variant 2")
> Signed-off-by: Michael Walle <michael@walle.cc>

Applied, thanks!
