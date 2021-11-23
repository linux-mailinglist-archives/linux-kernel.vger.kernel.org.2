Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98FFB45A274
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Nov 2021 13:21:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235078AbhKWMYC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Nov 2021 07:24:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:49400 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231790AbhKWMX7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Nov 2021 07:23:59 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 36C9560F26;
        Tue, 23 Nov 2021 12:20:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637670051;
        bh=A1btUYxVBrGGIWB3bMOkUCLWjbNgGl95g6UPJKXRwxA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=coVIVyT7gBoihBcoyDJ34YlX4bb0ZBuR7HYyEeFiOwypnH8E3wZjanvSkh1+MZvne
         FPwoy5122ZxlSi8MoLpp1W99sVHiLhNDEkCBrDLz3qYsYfjL7VL0WNTtKeV0YA4n6Q
         y4veXjVpGu8dAwf2Ks32uHOwD1hSK52NEVwSbUvlLi/4MnfXPd8oB0kCW5j/qdvmHP
         b1eDYZUibxBnTef5NRfzfw4wovUOJ0qqzfThMqo0D/+E1hMC+UTLpP9Q6ZXW2FFLjf
         rdDEJlfFaBOmJbGFPG5DWq+lwgKKRoh9gJH7uIqrDpNPYDYD4rR2aoUZTelPu/rddo
         E3SQNGmVx7Eag==
Date:   Tue, 23 Nov 2021 20:20:45 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Adam Ford <aford173@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org, tharvey@gateworks.com,
        aford@beaconembedded.com, Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Peng Fan <peng.fan@nxp.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] soc: imx: gpcv2: keep i.MX8MM VPU-H1 bus clock active
Message-ID: <20211123122044.GD4216@dragon>
References: <20211120193916.1309236-1-aford173@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211120193916.1309236-1-aford173@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 20, 2021 at 01:39:16PM -0600, Adam Ford wrote:
> Enable the vpu-h1 clock when the domain is active because reading
> or writing to the VPU-H1 IP block cause the system to hang.
> 
> Fixes: 656ade7aa42a ("soc: imx: gpcv2: keep i.MX8M* bus clocks enabled")
> Signed-off-by: Adam Ford <aford173@gmail.com>

Applied, thanks!
