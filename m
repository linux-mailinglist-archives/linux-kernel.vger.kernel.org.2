Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D52537F373
	for <lists+linux-kernel@lfdr.de>; Thu, 13 May 2021 09:14:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231523AbhEMHPi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 May 2021 03:15:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:43016 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229786AbhEMHPf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 May 2021 03:15:35 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5688E611AE;
        Thu, 13 May 2021 07:14:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620890065;
        bh=0fEBt5fI0Eg0nGajGJJ6qWeJfhNCHhY52h4OwQz6Wu4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BfHwhKtaQ7Si5X1OQiJW4V+ztM7xOdofCREI3K6vzbp/U/avbG2gcyQerQlVMCDEz
         aOAzO/vd9xD2lpXh4ECFQCFP1AQNyRFKELxbHjLsEafayuUekuutMAm9R5L7f0P5sW
         GklgMB9e3PqynRU9NGfFSLFd1r1HMaR1ZvAfWiQafl9hU09f7S3mQyxtXy40RPFmWR
         wfsZbsXGcDycipH5pyKF1KL8/jpJpK4H9vZXPugoEHkoymyZtfEq6CGQsoe/bjBxpI
         w3xNHEDJV6pGA+1D+77FtKhkATpi3Gtd27LgJ8BtipMnrNlrX4lE6b6uJpqnszFm4g
         r0zpfi41qKatQ==
Date:   Thu, 13 May 2021 15:14:21 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Richard Zhu <hongxing.zhu@nxp.com>
Cc:     l.stach@pengutronix.de, linux-imx@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: imx8mq-evk: add one regulator used to power
 up pcie phy
Message-ID: <20210513071420.GQ3425@dragon>
References: <1618367174-30968-1-git-send-email-hongxing.zhu@nxp.com>
 <1618367174-30968-2-git-send-email-hongxing.zhu@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1618367174-30968-2-git-send-email-hongxing.zhu@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 14, 2021 at 10:26:14AM +0800, Richard Zhu wrote:
> Both 1.8v and 3.3v power supplies can be used by i.MX8MQ PCIe PHY.
> In default, the PCIE_VPH voltage is suggested to be 1.8v refer to data
> sheet. When PCIE_VPH is supplied by 3.3v in the HW schematic design,
> the VREG_BYPASS bits of GPR registers should be cleared from default
> value 1b'1 to 1b'0. Thus, the internal 3v3 to 1v8 translator would be
> turned on.
> 
> Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
> Reviewed-by: Lucas Stach <l.stach@pengutronix.de>

Applied, thanks.
