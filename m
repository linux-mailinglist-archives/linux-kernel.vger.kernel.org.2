Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D70A842E6BD
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Oct 2021 04:43:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232508AbhJOCp0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Oct 2021 22:45:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:38388 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229819AbhJOCpY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Oct 2021 22:45:24 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9CFFD610D1;
        Fri, 15 Oct 2021 02:43:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634265798;
        bh=K2Yhvo08IS7HwYmqlxy4jK7odHyBfaUniFOBRvQPcbA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BD8AKSU/K7nF2FjDQOXHUFiueFsj8i5B+XdLky6BgcREW8jxNJK3Lf8p1GmBy4QqF
         y9yTivarACac+gBNjDpSD/ZBGLq6NPFGE8Hno2+VM22Pej+HJGRqcXKqCvu5+zykCZ
         fD3uKxsDSiddecfXJs3eWzbp9OcoY89x+s3Vn1JzRaFdc633fn/nxw0IeQIJBn16ml
         ky2tF1t/cE3XB3aQMHf5VLnMQhtrcEbkkGxRLLWYInbpcMOqM4V0R0DwQw//Bko0ui
         Hc/TKgZXU5xA5BSi1bZrWJLPxGSFQ/WlNszAezl3CMpqb8kvNiHptqkb6mp7IXgILt
         ms4zKTBixwtXA==
Date:   Fri, 15 Oct 2021 10:43:12 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Tim Harvey <tharvey@gateworks.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] arm64: dts: imx8mm-venice-gw7901.dts: disable
 pgc_gpumix
Message-ID: <20211015024312.GF10197@dragon>
References: <20211006153836.13760-1-tharvey@gateworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211006153836.13760-1-tharvey@gateworks.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 06, 2021 at 08:38:36AM -0700, Tim Harvey wrote:
> Since commit b21269b12e48 ("arm64: dts: imx8mm: add GPC node") the
> GW7901 will hang during kernel init because it does not power the unused
> GPU voltage rails on the IMX8MM. Disable pgc_gpumix to work around this.
> 
> We also disable the GPU devices that depend on the gpumix power domain
> and pgc_gpu to avoid them staying in a probe deferred state forever.
> 
> Additionally as the MIPI voltage rail is also not connected on this
> board we disable pgc_mipi and disp_blk_ctrl.
> 
> Signed-off-by: Tim Harvey <tharvey@gateworks.com>

Applied, thanks!
