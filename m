Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3EBD13D50E3
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jul 2021 03:24:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231336AbhGZAnr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Jul 2021 20:43:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:36520 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230152AbhGZAnq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Jul 2021 20:43:46 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B15C360C41;
        Mon, 26 Jul 2021 01:24:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627262656;
        bh=QvcjzfCS0Eqk4twCKVhgTFa4Bf6DevWQt9Q9RUKD9UE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XZZPYDjh02jo8RpvYGOb8gne/5M1xA7gIlzQT6NxXBR5g7qApHEHSvniT+zgVLpJM
         yeOPBGTPgRPdEULchizYjCi+6AcFkoH8niYDebu+hylkfcJA99RmWTnjLkugfsfZAg
         aTs6GKjMlXWR74HhtJuh+NbTtcZ1NVYWohoK+z3nKb2DM8GwDUYevIRitE8EoL9rB3
         eWZSjg+egoCNltkRmInPRuYsUKnxHD+jgjEKnFy/bzKHAAfJr+2bTEZDZjJHCONg/t
         FzqWwB4r9Q7Fj2yOXkfddjM1cml8+VHt1fhrA69JhHSGxwI49XFAO3iymyifp3JusL
         2SYwALJMXRJBQ==
Date:   Mon, 26 Jul 2021 09:24:09 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Daniel Baluta <daniel.baluta@oss.nxp.com>
Cc:     robh+dt@kernel.org, s.hauer@pengutronix.de, festevam@gmail.com,
        ping.bai@nxp.com, qiangqing.zhang@nxp.com, alice.guo@nxp.com,
        yibin.gong@nxp.com, linux-imx@nxp.com, peng.fan@nxp.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        daniel.baluta@gmail.com, linux-kernel@vger.kernel.org,
        Daniel Baluta <daniel.baluta@nxp.com>
Subject: Re: [PATCH v3] arm64: dts: imx8mp: Add dsp node
Message-ID: <20210726012408.GD5901@dragon>
References: <20210723110540.1332145-1-daniel.baluta@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210723110540.1332145-1-daniel.baluta@oss.nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 23, 2021 at 02:05:40PM +0300, Daniel Baluta wrote:
> From: Daniel Baluta <daniel.baluta@nxp.com>
> 
> i.MX8 MPlus SoC integrates Cadence HIFI4 DSP. This core runs either a
> custom firmware or the open source SOF firmware [1]
> 
> DSP device is handled by SOF OF driver found in
> sound/soc/sof/sof-of-dev.c
> 
> Notice that the DSP node makes use of:
> 	- dsp_reserved, a reserved memory region for various Audio
> 	  resources (e.g firmware loading, audio buffers, etc).
> 	- Messaging Unit (mu2) for passing notifications betweem ARM
> 	  core and DSP.
> 
> [1] https://thesofproject.github.io/latest/platforms/index.html
> Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>

Applied, thanks!
