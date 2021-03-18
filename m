Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8170333FDFE
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 05:04:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229683AbhCREDU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 00:03:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:35922 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229660AbhCREDE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 00:03:04 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3B68764F10;
        Thu, 18 Mar 2021 04:03:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616040184;
        bh=QKpRhbRT2nRuvTV5yoD93kUkrw1ANGBHrCM3HOS/ZmU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Cofg6HtKK7RUQpnqMv8R3oaTIwMaduOGyOHza3wIP4awBUVHsMoXJAB/4z65aDrPy
         lTP2Iq+hheInlKTfWKKD9ucxwWYW82qFu19MgDdLtLsq1zumweTownxrLiY+61QLFs
         gIXLsiPkc57NKf3YhYHzaiM6rNiT5/UO7G/MsFOGhg2zzkrMXfdshTwyFA57tc7UMt
         XlEsQgBGBsUaNMiEUSQoayhrUu63C+QleL+FBigzOOKf9fI9Mz6W96pDLF6jccUqHn
         LHrmp0yo3CWjPOi/VxEeUrQLdJ4f6VZkYP1A5c4QJtMCzzYknCKp/N2aGb9WI9+/Po
         yF0ggmgRrlSLw==
Date:   Thu, 18 Mar 2021 12:02:58 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Heiko Thiery <heiko.thiery@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Michael Walle <michael@walle.cc>,
        Lucas Stach <l.stach@pengutronix.de>,
        Baruch Siach <baruch@tkos.co.il>,
        Fabio Estevam <festevam@gmail.com>,
        Andrey Smirnov <andrew.smirnov@gmail.com>,
        Chris Healy <cphealy@gmail.com>
Subject: Re: [PATCH v3] arm64: configs: Enable PCIe support for imx8mq boards
Message-ID: <20210318040258.GW11246@dragon>
References: <20210317121136.7023-1-heiko.thiery@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210317121136.7023-1-heiko.thiery@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 17, 2021 at 01:11:37PM +0100, Heiko Thiery wrote:
> Enable PCI_IMX6 to get PCI support for imx8mq boards like imx8mq-evk,
> imx8mq-kontron-pitx-imx8m and imx8mq-zii-ultra.
> 
> The driver only has build-in support and cannot be compiled as module.
> 
> Signed-off-by: Heiko Thiery <heiko.thiery@gmail.com>

Applied, thanks.
