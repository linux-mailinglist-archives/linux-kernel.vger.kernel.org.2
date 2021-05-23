Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 430DB38D861
	for <lists+linux-kernel@lfdr.de>; Sun, 23 May 2021 04:59:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231558AbhEWDAs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 May 2021 23:00:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:48240 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231516AbhEWDAq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 May 2021 23:00:46 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 47907611C1;
        Sun, 23 May 2021 02:59:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621738760;
        bh=ladddHdgU4ilqNmFJ5nGJWq1vJbpf1bZ8MS3j/XpGc0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=a5TvZp7T++Su2xE+je/D/RJknC3tdKiRywMWzkbyky9/eWb0IaCGLDVp8uXOo+0SE
         exR1JKSkTtUGa7yCgy90740Tw/diAsxSouJ5ielOYPZEK96XXlELbzZBfJzH5IlRa/
         W6/NOmBb1J1YI8mOyK8jTv0GMumOVicgWQFUSG49fgZVjv94zj0OD5c1SqARAYiZ0W
         gGpi7cQSNGj9YbZl4hQN9RhYqAzU0IHrLfTzZZiuPXde5XfHWaowMu/UjGdWXibQAO
         pLpXCdCckh81lPpWMnpbDPByjLM3S1D3e5cEGNqCEna7rqFj8UC2oKabeqVnyJLtMS
         0DSisAbcCh1vA==
Date:   Sun, 23 May 2021 10:59:13 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc:     robh+dt@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, p.zabel@pengutronix.de,
        l.stach@pengutronix.de, krzk@kernel.org, agx@sigxcpu.org,
        marex@denx.de, andrew.smirnov@gmail.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, ping.bai@nxp.com,
        frieder.schrempf@kontron.de, aford173@gmail.com, abel.vesa@nxp.com
Subject: Re: [PATCH V3 02/13] soc: imx: gpcv2: move domain mapping to domain
 driver probe
Message-ID: <20210523025912.GP8194@dragon>
References: <20210510040045.13225-1-peng.fan@oss.nxp.com>
 <20210510040045.13225-3-peng.fan@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210510040045.13225-3-peng.fan@oss.nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 10, 2021 at 12:00:34PM +0800, Peng Fan (OSS) wrote:
> From: Lucas Stach <l.stach@pengutronix.de>
> 
> As long as the power domain driver is active we want power control
> over the domain (which is what the mapping bit requests), so there
> is no point in whacking it for every power control action, simply
> set the bit in driver probe and clear it when the driver is removed.
> 
> Tested-by: Frieder Schrempf <frieder.schrempf@kontron.de>
> Reviewed-by: Frieder Schrempf <frieder.schrempf@kontron.de>
> Signed-off-by: Lucas Stach <l.stach@pengutronix.de>

You forgot your SoB.  I fixed it up and applied the series.

Shawn
