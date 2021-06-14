Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D90FC3A65AC
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jun 2021 13:43:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235933AbhFNLlr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Jun 2021 07:41:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:56190 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234923AbhFNLar (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jun 2021 07:30:47 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4CD2261057;
        Mon, 14 Jun 2021 11:28:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623670121;
        bh=3JCgb2d2Kf5Ts1j/kSKpvVV46p9odt+P0FjGxU7En2o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uMPp4sHiQd6sK49rC1Yr35ZUjMwjvhYMBLAj+vqvlme2HfiJeHG5pN8hrp36Ht86k
         5UwgXZi2T7Xn78jv186Wlh/mxqBjmzOXIMQYzdN62khgbnLQdX3Q8s/61d8hk3xvZi
         CzF2F1MPgVgpRLgCbBkQuKUQfXoM98je/vrqq+V8DLZdVi0r0tKrww5T7hAwpwMZ+s
         AokGrSud8h1c49qBp8KUYJIFxwinaZNuZSF1a6sxRs8VpDXwe4jF4FC/r7XvOdoz+H
         z4YVtCv2XR5fuDkzIYMPR4evFcqefxUHogtY0yKmK+VKdV80EWYAxPxXa17VvZdPZU
         vjzAImNOEWJFQ==
Date:   Mon, 14 Jun 2021 16:58:31 +0530
From:   Manivannan Sadhasivam <mani@kernel.org>
To:     Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-actions@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/2] Add Ethernet DTS for Actions Semi Owl S500 SoCs
Message-ID: <20210614112831.GB38584@thinkpad>
References: <cover.1623401998.git.cristian.ciocaltea@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1623401998.git.cristian.ciocaltea@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 11, 2021 at 12:11:31PM +0300, Cristian Ciocaltea wrote:
> This patchset adds the required DTS changes for providing the ethernet
> functionality on the Actions S500 SoCs family.
> 
> For the moment I have been able to test the Ethernet MAC on the RoseaplePi
> SBC only.
> 
> Also, please note the patches depend on some clock changes that are
> currently under review:
> https://lore.kernel.org/lkml/cover.1623354574.git.cristian.ciocaltea@gmail.com/
> 

Waiting for the clk patches to be merged...

Thanks,
Mani

> Thanks,
> Cristi
> 
> Changes in v2:
> - Added Reviewed-by tag from Mani in patch 1/2
> - Joined the groups sharing common function "eth_rmii" and switch the
>   order of "ref_clk-pinconf" and "phy_clk-pinmux", per Mani's review,
>   in patch 2/2
> 
> Cristian Ciocaltea (2):
>   ARM: dts: owl-s500: Add ethernet support
>   ARM: dts: owl-s500-roseapplepi: Add ethernet support
> 
>  arch/arm/boot/dts/owl-s500-roseapplepi.dts | 45 ++++++++++++++++++++++
>  arch/arm/boot/dts/owl-s500.dtsi            | 10 +++++
>  2 files changed, 55 insertions(+)
> 
> -- 
> 2.32.0
> 
