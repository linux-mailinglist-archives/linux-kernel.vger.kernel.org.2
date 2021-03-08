Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E26593305B1
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Mar 2021 02:49:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233567AbhCHBtR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Mar 2021 20:49:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:37540 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233228AbhCHBtQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Mar 2021 20:49:16 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 23B9565146;
        Mon,  8 Mar 2021 01:49:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615168155;
        bh=ZwAJ2lUN3NP4lfGo3eGOwJSf0HpCoViSdgSH22igC2Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KFg9ijPNudqmqKBE1ayyuvu5za3zPCJrbLanCaBHkYP+KNZBuf7rG+PT/QZR5CQUr
         OqA7qdojLyWAYP/2+NOjk4RQ2+nsq/dTlOFBVyeAtJA3S+7YGXFREkkAW5kz77TIlP
         bai9kQZGoT0FbWvOIooRtb3i2TIzWG+jeBv/F4xD1RqFW1h8fkoEqVsSv2iOPBbxyZ
         VTM67xjV+/G8R7vq9O8Jgb4/FltAtmTxMBEwOSWmqI0AKAuAcFHSFRWRMtf7h6cQNz
         TowLIk8JSVxVISCtotyHJVzoZBNvM8WSG78sT3yPH3BkyD9dTD5AJUGjB8Hleso5qA
         andZ3uE5r3hJw==
Date:   Mon, 8 Mar 2021 09:49:10 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     peng.fan@oss.nxp.com
Cc:     s.hauer@pengutronix.de, robh+dt@kernel.org, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH V2] arm64: dts: imx8mp: add wdog2/3 nodes
Message-ID: <20210308014910.GY543@dragon>
References: <1615113003-24612-1-git-send-email-peng.fan@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1615113003-24612-1-git-send-email-peng.fan@oss.nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 07, 2021 at 06:30:03PM +0800, peng.fan@oss.nxp.com wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> There is wdog[2,3] in i.MX8MP, so add them.
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>

Applied, thanks.
