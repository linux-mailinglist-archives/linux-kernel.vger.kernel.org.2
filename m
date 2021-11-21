Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF1B94582A9
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Nov 2021 10:17:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235124AbhKUJUt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Nov 2021 04:20:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:47800 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229746AbhKUJUs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Nov 2021 04:20:48 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id BE11560C49;
        Sun, 21 Nov 2021 09:17:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637486263;
        bh=8ODT3lpmGxpqhucq5wEa0vqwkac8CvlsvfAS4mIdHmI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fRsUNXMpSy09/9+h7UpeAqPmUXorYsdI62gdr+HUfWb94EkJ1RYVxSde1aGcuUWFP
         o5+nUjCeFkD+Q/mL4/oA3q8PJ9oSyKOQtcfFXTaUFBNEYBZfTB0SXPXi0xj9NXekbd
         Ebun0cBqrjt+9xePkhc95evcT4ZdaVEr6kMHPkIdAGK7bGxoci8qb6MP1cVM4PjAPa
         PlYyj6IfT2cPZDZtZvn4+poXev/IQHsphYD7+w7AirDvdq8a9+yWHcBtQ/+3/SnsaF
         qSwpnLv7JGWKYPGzN1ZU+ihMyEKzr49j+fKmzNd8MZGd/Qvw8DAtLdzFEsOI/VTLBw
         M1OtpYCxFOgwg==
Date:   Sun, 21 Nov 2021 17:17:38 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Meng Li <Meng.Li@windriver.com>
Cc:     leoyang.li@nxp.com, robh+dt@kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH] arch: arm64: dts: add delay between CS and CLK signal
 for flash device
Message-ID: <20211121091738.GO31998@dragon>
References: <20211103033838.16015-1-Meng.Li@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211103033838.16015-1-Meng.Li@windriver.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 03, 2021 at 11:38:38AM +0800, Meng Li wrote:
> Based on commit d59c90a2400f("spi: spi-fsl-dspi: Convert
> TCFQ users to XSPI FIFO mode ") and 6c1c26ecd9a3("spi:
> spi-fsl-dspi: Accelerate transfers using larger word size if possible"),
> on ls1043a-rdb platform, the spi work mode is changed from TCFQ
> mode to XSPI mode. In order to keep the transmission sequence matches
> with flash device, it is need to add delay between CS and CLK signal.
> The strategy of generating delay value refers to QorIQ LS1043A
> Reference Manual.
> 
> Signed-off-by: Meng Li <Meng.Li@windriver.com>

Updated the subject as below and applied the patch.

  arm64: dts: fsl-ls1043a-rdb: add delay between CS and CLK signal for flash device

Shawn
