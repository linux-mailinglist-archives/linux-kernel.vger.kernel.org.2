Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6B7F42E714
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Oct 2021 05:10:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232976AbhJODMm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Oct 2021 23:12:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:44218 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229526AbhJODMe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Oct 2021 23:12:34 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 18555611CC;
        Fri, 15 Oct 2021 03:10:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634267428;
        bh=kXgOJ8sBfwFLadg5Fg+80nI5My/aKal1KpkR8dG4Ymg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YfAcv55P3FDIh7z2OYlmAembI3fq9+KxD9DP8ju1N7cBDAdypgBhThZPqZppbyFir
         Ci/MIwB8SjZ8HPUHbtsMzHJlZYhk9Y+w0mHK0xkLDh/rFVJDM0eqtvzzXS4PcMX4vL
         NwntbMR7L6Kh/k1j5LqsnKC6xEQRR1rzqwTsw7/8uZ8ZzWPiB3TIsXcbCxqI5a6lAD
         2AxhgwJ4Qt//l502YLBiimSehKPcXejNOGMfNlH0EDDAfJ/ER7V/kcsWPB/LeFiXFO
         RIowAzjCzxaVJQdQJ+jkFdoKkAFQod+kRgCMrcfgUrvFwIi0n9bh2XaLM0Ovci/ji3
         WKLtR61bv6wSQ==
Date:   Fri, 15 Oct 2021 11:10:22 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Peng Fan <peng.fan@nxp.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] soc: imx: imx8m-blk-ctrl: off by one in
 imx8m_blk_ctrl_xlate()
Message-ID: <20211015031021.GC22881@dragon>
References: <20211011123638.GB15188@kili>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211011123638.GB15188@kili>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 11, 2021 at 03:36:38PM +0300, Dan Carpenter wrote:
> The > comparison should be >= to prevent reading one element beyond the
> end of the array.  The onecell_data->domains[] array is allocated in
> imx8m_blk_ctrl_probe() and it has "onecell_data->num_domains" elements.
> 
> Fixes: 5b340e7813d4 ("soc: imx: add i.MX8M blk-ctrl driver")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

Applied, thanks!
