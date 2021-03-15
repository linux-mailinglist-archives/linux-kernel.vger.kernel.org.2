Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D788F33AB74
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Mar 2021 07:12:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229506AbhCOGKi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 02:10:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:38424 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229607AbhCOGJw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 02:09:52 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 71FF164E37;
        Mon, 15 Mar 2021 06:09:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615788592;
        bh=T94j7sYi6GcxX3+JcqadeuddWMHwuXRw56OIQYndKdY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uKa3HNIzkBZvxlA+PIVYpRltRsuhQdRuCvBVWGKocoSSLfYd+sIAvRtK87MwnYkQi
         vyWgS3HCWQodkJw7jhMu0Wefby5xpk1Ac5ooQQUP3iv5gWVA0oAdGaCVxO/3eWWI9I
         eWz/aYTVF/0GwJgApxTxD47xDUPffLoib9VpZdC2kKmCF7VjqQplR/dDU2wfVpnxT/
         MbV0SXIVLOwIlHHTAK1GTv9wwR0D+laeLlSLSSsIRbK6yOvl/0WKslheSi1DQfcafH
         r3DNgEvRVJ3XNANouNdbFmkyIOy/MEzURNouCUTfxE4zq4SFO3kuRWmfvHLb09EDDE
         ydMTF+Hf3yoIQ==
Date:   Mon, 15 Mar 2021 14:09:46 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Sebastian Reichel <sebastian.reichel@collabora.com>
Cc:     Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com
Subject: Re: [PATCHv2 0/4] Bx50v3 DT improvements
Message-ID: <20210315060945.GI11246@dragon>
References: <20210308151829.60056-1-sebastian.reichel@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210308151829.60056-1-sebastian.reichel@collabora.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 08, 2021 at 04:18:25PM +0100, Sebastian Reichel wrote:
> Bx50v3 DT improvements
> 
> These are a bunch of small unrelated improvements for the GE Bx50v3
> device tree (and BA16 system on module, which is currently only used
> by Bx50v3).
> 
> Changes since PATCHv1 [1]:
>  * change patch prefix for BA16 patches
>  * remove extra newline from PATCH 1/4
>  * keep 'status' at the end of FEC in PATCH 2/4
> 
> [1] https://lore.kernel.org/lkml/20210223183346.138575-1-sebastian.reichel@collabora.com/
> 
> Thanks for reviewing/merging them,
> 
> -- Sebastian
> 
> Ian Ray (1):
>   ARM: dts: imx: bx50v3: Define GPIO line names
> 
> Sebastian Reichel (3):
>   ARM: dts: imx6q-ba16: add USB OTG VBUS enable GPIO
>   ARM: dts: imx6q-ba16: improve PHY information
>   ARM: dts: imx: bx50v3: i2c GPIOs are open drain

Applied all, thanks.
