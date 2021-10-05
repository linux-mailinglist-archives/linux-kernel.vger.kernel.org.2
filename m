Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78722421EC0
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 08:13:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232456AbhJEGPV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Oct 2021 02:15:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:46500 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232346AbhJEGPM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Oct 2021 02:15:12 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 570336124D;
        Tue,  5 Oct 2021 06:13:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633414402;
        bh=f2A1722pIMZGnFLoNArraeXWVgOjZLleLjAJ2wactIM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jCNJVsMP/6OnotGjQXsLwHCkJtH7Bsg8Hc/f6KsJfECyV2Ikkuqtb1U6GB0h3pqim
         qKWGhwyb92Wr1rsUzksYok6wT9i6GfilHphpPrRe6IROLEbCswlwLYdnuBe/Oklfkt
         eHu7iEkdO4R2J8/YKhZnnskb47THB5hjzfwP1HQ/1Vkglj2qxcFOBnbfo7tfPfbCzv
         Bfwr0eom5kfcUMICwTCSczNk6H+7m3/DihbHsHDkH/IuHOXLAASBa3QS/aDXdt2csI
         Kme0nMHX7rImXJDebwszVSsFbYsgPzgKoH3kpsVZDHO3TCXXajDtPUEV9/mO47+PIV
         pHtEwUeSC6gxw==
Date:   Tue, 5 Oct 2021 14:13:09 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Oleksij Rempel <o.rempel@pengutronix.de>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        devicetree@vger.kernel.org, Fabio Estevam <festevam@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Sam Ravnborg <sam@ravnborg.org>
Subject: Re: [PATCH v1] ARM: dts: imx6: skov: provide panel support for lt2
 variants
Message-ID: <20211005061301.GT20743@dragon>
References: <20210930125221.30127-1-o.rempel@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210930125221.30127-1-o.rempel@pengutronix.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 30, 2021 at 02:52:21PM +0200, Oleksij Rempel wrote:
> Add support for the Logic Technologies LTTD800x480 L2RT 7" 800x480 TFT
> Resistive Touch Module.
> 
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>

Applied, thanks!
