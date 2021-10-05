Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDF6D421CDB
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 05:23:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231363AbhJEDZC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Oct 2021 23:25:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:41312 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230097AbhJEDZB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Oct 2021 23:25:01 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 063756137D;
        Tue,  5 Oct 2021 03:23:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633404191;
        bh=gqXcAsMxdzuckRmjquUJAtYJLajECPb1Vtt0U4i7NS0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RY/87MlBke9qZnAy9w5WX8Ae3D5/nCP72H9jB8oetO77oryE3igQ/bCEriciGGNwE
         ltHGiLbWdG84U6w5KMY7xTI7LbaEDL/mle65fbHNCZVmyd46OYI6XSHFhB01ZifchB
         rxLDM+yklH8dVl295Z1Jv/EU9SIg0VnmDtrrhIkScoAoL5TBp/83AdzSh/ibHoKlrf
         jLKgdlQqamofEt02DYrctAxZ2UqccIpa4kk39tObYCX9Vd/mPj3pGvhKpT3iKRrLzt
         h9MLC+16nOsaLpPTUTf39jUt5oBBXhfzYgLpEEDjHFdvFOQii25bRMzxaNHs3GCAUM
         a1seJa/hV4ZDg==
Date:   Tue, 5 Oct 2021 11:23:06 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Marcel Ziswiler <marcel@ziswiler.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Fabio Estevam <festevam@gmail.com>,
        Andreas Kemnade <andreas@kemnade.info>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pascal Zimmermann <pzimmermann@dh-electronics.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Russell King <linux@armlinux.org.uk>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 3/9] ARM: imx_v6_v7_defconfig: change snd soc
 tlv320aic3x to i2c variant
Message-ID: <20211005032306.GB20743@dragon>
References: <20210920144938.314588-1-marcel@ziswiler.com>
 <20210920144938.314588-4-marcel@ziswiler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210920144938.314588-4-marcel@ziswiler.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 20, 2021 at 04:49:32PM +0200, Marcel Ziswiler wrote:
> From: Marcel Ziswiler <marcel.ziswiler@toradex.com>
> 
> Change CONFIG_SND_SOC_TLV320AIC3X to CONFIG_SND_SOC_TLV320AIC3X_I2C.
> I did double check all current mainline device trees and they are all
> using the I2C rather than the SPI variant.
> 
> Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
> Reviewed-by: Fabio Estevam <festevam@gmail.com>

Applied, thanks!
