Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83282330571
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Mar 2021 01:47:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233420AbhCHAqm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Mar 2021 19:46:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:59864 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231730AbhCHAqb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Mar 2021 19:46:31 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 95B526513E;
        Mon,  8 Mar 2021 00:46:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615164390;
        bh=d90gxdD+vvWb39os4oJFI8hOjj5XrRkMszo1D6pv1ZI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=g0kpiXw9dVQLehjqgeD7DsS/dWmSGA13zRPbtaBLsehZap5OstXmGNzn4H4cYPt46
         c0UDRpgl6BFnSehx/fEjdJVWxr6sl42snw3NP7AfZyCcyQffp4s0uNo/cBeSZmpaL+
         YTJ8NBFA/T9ZGfESLC1ZfB2rJeY/FPh1B2xwRFuq4/tmqA0wA7l2P7FqVcEIWGGX3q
         as47QTqrH5QmeKIS/dl/cCf8gNMypudonL0/U2vVCvpWmSTrlstL4/6rfwlfJShC7U
         swYPKdi6VGoHPAi9Jp16hFVbg5JG5yPHWgCFriDJ39dgoJ470n+2+cz5M3FwwF7HbE
         CLYWy+7A6z+sQ==
Date:   Mon, 8 Mar 2021 08:46:25 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Adrien Grassein <adrien.grassein@gmail.com>
Cc:     krzk@kernel.org, robh+dt@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        catalin.marinas@arm.com, will@kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 00/10] Add peripheral support for imx8mm-nitrogen-r2
 board
Message-ID: <20210308004616.GM543@dragon>
References: <20210223191652.436397-1-adrien.grassein@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210223191652.436397-1-adrien.grassein@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 23, 2021 at 08:16:43PM +0100, Adrien Grassein wrote:
> Adrien Grassein (10):
>   arm64: dts: imx8mm-nitrogen-r2: add wifi/bt chip
>   arm64: dts: imx8mm-nitrogen-r2: rework USDHC1
>   arm64: dts: imx8mm-nitrogen-r2: add USB support
>   arm64: dts: imx8mm-nitrogen-r2: add espi2 support
>   arm64: dts: imx8mm-nitrogen-r2: add UARTs
>   arm64: dts: imx8mm-nitrogen-r2: rework UART 2
>   arm64: dts: imx8mm-nitrogen-r2: add PWMs
>   arm64: dts: imx8mm-nitrogen-r2: add FlexSPI
>   arm64: dts: imx8mm-nitrogen-r2: add audio
>   arm64: defconfig: Enable wm8960 audio driver.

Applied all, thanks.
