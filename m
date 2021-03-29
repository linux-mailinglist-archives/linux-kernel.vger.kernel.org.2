Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5C6E34C0C1
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Mar 2021 03:00:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231600AbhC2BAR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Mar 2021 21:00:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:45794 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229861AbhC2A75 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Mar 2021 20:59:57 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B2D7961879;
        Mon, 29 Mar 2021 00:59:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616979597;
        bh=OevAKViQWBfdT16CE4GyR+nY9lrxPiNu+4V4jgret8c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rTminsS00Cw2+efwXvVv0F/6KDOjDW5qC5A/BGUbG4ZS7OM0xgVby58ZJThjSHfgx
         fRsjLxobk9GU6kWqwvJgFV/4BcDeo70MUWbNZ6DxEU7ErDNPk28mTA17gcHde6ohsK
         FKwpg3krWJYV8tvjvuk+YD4MA7Kt/W3bD2NQVVDXwUVQYhte5jNNXVAJ0sw5VexifA
         qCx6Opd1/c+HaEPGuqeyTRaI4z7MbIRgOApe2d+FvyehipYbW8vrfVJt0YEi87+0Ng
         vZIUiLibWOQbKG2lFUetWgjrdSPNW+5BfYQPUS263U1oTpkEY/WMHeQLhsKHLYNo2J
         LZSdlsBSa3q8Q==
Date:   Mon, 29 Mar 2021 08:59:52 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Dong Aisheng <aisheng.dong@nxp.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Liu Ying <victor.liu@nxp.com>, Peng Fan <peng.fan@nxp.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] firmware: imx: scu-pd: Update comments for single global
 power domain
Message-ID: <20210329005951.GE22955@dragon>
References: <20210317093117.16091-1-ulf.hansson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210317093117.16091-1-ulf.hansson@linaro.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 17, 2021 at 10:31:17AM +0100, Ulf Hansson wrote:
> Since the introduction of the PM domain support for the scu-pd, the genpd
> framework has been continuously improved. More preciously, using a single
> global power domain can quite easily be deployed for imx platforms.
> 
> To avoid confusions, let's therefore make an update to the comments about
> the missing pieces.
> 
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>

Applied, thanks.
