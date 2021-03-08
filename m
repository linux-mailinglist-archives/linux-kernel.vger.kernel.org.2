Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E233A330DA1
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Mar 2021 13:31:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229704AbhCHMbA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 07:31:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:40308 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229471AbhCHMai (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 07:30:38 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3F08F64EBC;
        Mon,  8 Mar 2021 12:30:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615206637;
        bh=1H+Rm/HRG67SRYINbJHS0oBbjsuz6H5MGQm5tGIaYFY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MCYCjX1qI/amv05iG1pOVraEyQbDL7c8JkAHZXAn5fZTq3/07MUrnj6WTsu98QxLe
         n62PZ9raXTxm/AQ41k467h4Bg+ADvJOEubp17IumUlXXtBHhlOkFzuHbi7ALd6GVCq
         0FrRClAfaxMhHzcx1MYoDSfaxOQuD8VDdUrtHBHHvcZhwkIC/GrW0O9BGSsPFrqCdc
         4wBS2Ej9jvsUbFVsHDKY7opIFNp3/9C8p8SS8OtWzEr5j87QhEUdVfe46/1YlsITwO
         aVx4v8tvSz3maHY/CRPaiP3XjGbJBPrOJUbSh3tT1RSiVMewS7IA+W8whHmtgxZmKn
         GtPOLwC+wGfRQ==
Date:   Mon, 8 Mar 2021 20:30:31 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Adrien Grassein <adrien.grassein@gmail.com>
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>, catalin.marinas@arm.com,
        will@kernel.org, DTML <devicetree@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 00/10] Add peripheral support for imx8mm-nitrogen-r2
 board
Message-ID: <20210308123030.GA11246@dragon>
References: <20210223191652.436397-1-adrien.grassein@gmail.com>
 <20210308004616.GM543@dragon>
 <CABkfQAHkJ=4Zwhbz0MxhbedK71JzaaQFXR5tN1k=8JmDysGGjA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABkfQAHkJ=4Zwhbz0MxhbedK71JzaaQFXR5tN1k=8JmDysGGjA@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 08, 2021 at 12:54:05PM +0100, Adrien Grassein wrote:
> Le lun. 8 mars 2021 à 01:46, Shawn Guo <shawnguo@kernel.org> a écrit :
> >
> > On Tue, Feb 23, 2021 at 08:16:43PM +0100, Adrien Grassein wrote:
> > > Adrien Grassein (10):
> > >   arm64: dts: imx8mm-nitrogen-r2: add wifi/bt chip
> > >   arm64: dts: imx8mm-nitrogen-r2: rework USDHC1
> > >   arm64: dts: imx8mm-nitrogen-r2: add USB support
> > >   arm64: dts: imx8mm-nitrogen-r2: add espi2 support
> > >   arm64: dts: imx8mm-nitrogen-r2: add UARTs
> > >   arm64: dts: imx8mm-nitrogen-r2: rework UART 2
> > >   arm64: dts: imx8mm-nitrogen-r2: add PWMs
> > >   arm64: dts: imx8mm-nitrogen-r2: add FlexSPI
> > >   arm64: dts: imx8mm-nitrogen-r2: add audio
> > >   arm64: defconfig: Enable wm8960 audio driver.
> >
> > Applied all, thanks.
> 
> Thanks,
> 
> But I think you missed one (arm64: dts: imx8mm-nitrogen-r2: add espi2
> support) that I don't see on your tree.

Hmm, looks like it did not get posted. 

https://lore.kernel.org/linux-arm-kernel/20210223191652.436397-1-adrien.grassein@gmail.com/

Shawn
