Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34F56447CE9
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Nov 2021 10:35:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237654AbhKHJiE convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 8 Nov 2021 04:38:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236889AbhKHJiB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Nov 2021 04:38:01 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D675C061714
        for <linux-kernel@vger.kernel.org>; Mon,  8 Nov 2021 01:35:16 -0800 (PST)
Received: from lupine.hi.pengutronix.de ([2001:67c:670:100:3ad5:47ff:feaf:1a17] helo=lupine)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1mk13X-00085V-CC; Mon, 08 Nov 2021 10:35:11 +0100
Received: from pza by lupine with local (Exim 4.94.2)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1mk13V-0003Jc-1w; Mon, 08 Nov 2021 10:35:09 +0100
Message-ID: <a2a8cca55604755458a2b5daec59290b239a142a.camel@pengutronix.de>
Subject: Re: [PATCH v3 2/3] phy/rockchip: add naneng combo phy for RK3568
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     Yifeng Zhao <yifeng.zhao@rock-chips.com>, heiko@sntech.de,
        robh+dt@kernel.org
Cc:     devicetree@vger.kernel.org, vkoul@kernel.org,
        michael.riesch@wolfvision.net, linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-phy@lists.infradead.org, kishon@ti.com, cl@rock-chips.com
Date:   Mon, 08 Nov 2021 10:35:09 +0100
In-Reply-To: <20211025080632.32063-3-yifeng.zhao@rock-chips.com>
References: <20211025080632.32063-1-yifeng.zhao@rock-chips.com>
         <20211025080632.32063-3-yifeng.zhao@rock-chips.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.38.3-1 
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2001:67c:670:100:3ad5:47ff:feaf:1a17
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2021-10-25 at 16:06 +0800, Yifeng Zhao wrote:
> This patch implements a combo phy driver for Rockchip SoCs
> with NaNeng IP block. This phy can be used as pcie-phy, usb3-phy,
> sata-phy or sgmii-phy.
> 
> Signed-off-by: Yifeng Zhao <yifeng.zhao@rock-chips.com>
> ---
> 
> Changes in v3:
> - Using api devm_reset_control_get_optional_exclusive and dev_err_probe

Reviewed-by: Philipp Zabel <p.zabel@pengutronix.de>

regards
Philipp
