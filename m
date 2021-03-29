Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 800CD34C1EF
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Mar 2021 04:26:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230202AbhC2CZg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Mar 2021 22:25:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:50848 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229719AbhC2CZf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Mar 2021 22:25:35 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C3E5061554;
        Mon, 29 Mar 2021 02:25:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616984735;
        bh=QWb/HF9UilknbtV40E2RWyidJoP+mF2Xzwk3N0FcIZA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=b4eBbqabuaDEvyEgdx4kiGdmCAKVeeXQcLNGN39y8qyReSeAQbOZ0lvFa3WTKmarI
         R21Ylo75DtDN0Sr7qFdFD8M1jlScwFWR1svvOIjUdtJ3HKBpMUJQSkshM34HN9IUwG
         PbFJHfROp+Q0BPIdVHlV/T80JS8QbrM0ryK31Zu/Ew4zKpH6KGhq7TamljA0VAgm47
         vtwL//g7eoFYoJ/pxtqCH4YWm6BuUi38EcCVFdoMKGJ0pjl0bKeJWl58cu/t3AQ+ge
         L6A7TvNCerY6NoaEkhLgUqAvuV/sMIQF3J27o+QWASEeYxxUyrvVA60rW6KMObMZhv
         SrfHb3t+F7Tkw==
Date:   Mon, 29 Mar 2021 10:25:30 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Oliver =?iso-8859-1?Q?St=E4bler?= <oliver.staebler@bytesatwork.ch>
Cc:     robh+dt@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] arm64: dts: imx8mm/q: Fix pad control of SD1_DATA0
Message-ID: <20210329022529.GN22955@dragon>
References: <CAOMZO5B_uHS_Z2LuMwHDmn9erORrsrNBMHMjkW-hW+pnfHZThQ@mail.gmail.com>
 <20210324132841.5841-1-oliver.staebler@bytesatwork.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210324132841.5841-1-oliver.staebler@bytesatwork.ch>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 24, 2021 at 02:28:41PM +0100, Oliver Stäbler wrote:
> Fix address of the pad control register
> (IOMUXC_SW_PAD_CTL_PAD_SD1_DATA0) for SD1_DATA0_GPIO2_IO2.  This seems
> to be a typo but it leads to an exception when pinctrl is applied due to
> wrong memory address access.
> 
> Signed-off-by: Oliver Stäbler <oliver.staebler@bytesatwork.ch>

Applied, thanks.
