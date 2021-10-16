Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A26E4300F3
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Oct 2021 09:50:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243824AbhJPHwX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Oct 2021 03:52:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:51040 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239843AbhJPHwW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Oct 2021 03:52:22 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C7645610D1;
        Sat, 16 Oct 2021 07:50:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634370614;
        bh=peegsGPL08iXPi6LRtl7ulow0Bk5w/c+yQ3A08eros0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UV71IlmNRcqoVS2SwY7fAQHeDSrJU1d/W5yFizORIJvw+k+Z1fpv/MD/nUe+a/Trv
         DTEFbcwhL/d0Z1g64Y8dCt8aezzrgTaoxk+bUoiLbYgoQ4+wRdvmjHwlIzCbLZ1aa0
         AgNOTGLk39rLQCund3Zc98I8M8pB01zffZxmxesAqlP64Sp1dAFUcp9Y6ZF+JCK7n1
         avPzGLfybHpHAqE+p1Tk9wYYStwK5syR9onMFRID3wq+4SQXssqC71bUpx6cfheVzN
         3jH1BcCGpX0NkfDByi+pdKR8xQW5837g8RCPL8rhFEB/wUi6pC6lLa2fG94rxn6Bj2
         d68xM9ZuAn+qg==
Date:   Sat, 16 Oct 2021 15:50:08 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Frieder Schrempf <frieder@fris.de>
Cc:     devicetree@vger.kernel.org,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>
Subject: Re: [PATCH v2 0/6] Devicetree fixes and additions for Kontron SL/BL
 i.MX8MM boards
Message-ID: <20211016075007.GB25810@dragon>
References: <20211015124841.28226-1-frieder@fris.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211015124841.28226-1-frieder@fris.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 15, 2021 at 02:48:34PM +0200, Frieder Schrempf wrote:
> From: Frieder Schrempf <frieder.schrempf@kontron.de>
> 
> This is a set of enhancements and fixes for the devicetrees of the Kontron
> SL/BL i.MX8MM SoMs and boards.
> 
> See the individual patches for more information and changelogs.
> 
> For v2, the review comments from Shawn ahve been taken into account
> (thanks!) and the patches 7 and 8 have been dropped, as they were already
> applied separately.
> 
> Frieder Schrempf (6):
>   arm64: dts: imx8mm-kontron: Add support for ultra high speed modes on
>     SD card
>   arm64: dts: imx8mm-kontron: Make sure SOC and DRAM supply voltages are
>     correct
>   arm64: dts: imx8mm-kontron: Set lower limit of VDD_SNVS to 800 mV
>   arm64: dts: imx8mm-kontron: Fix polarity of reg_rst_eth2
>   arm64: dts: imx8mm-kontron: Fix CAN SPI clock frequency
>   arm64: dts: imx8mm-kontron: Fix connection type for VSC8531 RGMII PHY

Applied all, thanks!
