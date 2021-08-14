Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3811B3EC0CA
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Aug 2021 07:53:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237009AbhHNFyG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Aug 2021 01:54:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:39146 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232021AbhHNFyD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Aug 2021 01:54:03 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8DBB460EB2;
        Sat, 14 Aug 2021 05:53:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628920415;
        bh=1cqRShFpfw8fPELHbm8AMuujHc5fQOCOUAguLgWuT3c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=i4GOV/35BPo/L0RKOCRKaVmYqIwKrt75DRJQS4wg7zs7sev38YlmMcv2YLTndwHmI
         7ntvoy5GVjfHaMsp5luKmwH11zrbVnKOupW5f0l9L6Czfjzh9vFNbPizifu0/kyUYO
         cC5dm7/8wWcpJjVdDWny695TOdLiq6UZ9Gp7MvTQ+d3Cjc5hSEc2fotO/zbU268hQg
         /tfSmGg4oCJsfCcmfPGOmVZ7nsP84LcuirUb9huDDMaqRQy58UOifBvF2rKe6LBJGd
         +QQnrbYh02ppcU8nYDlbw4jqaS0WtOy/CKWe1rju+G/2uCujCK/Qx+QsSU1HwoOR8e
         GhcZR9P7Gw0ZQ==
Date:   Sat, 14 Aug 2021 13:53:29 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Oleksij Rempel <o.rempel@pengutronix.de>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        devicetree@vger.kernel.org, Fabio Estevam <festevam@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        David Jander <david@protonic.nl>
Subject: Re: [PATCH v1] ARM: dts: imx6qp-prtwd3: configure ENET_REF clock to
 125MHz
Message-ID: <20210814055328.GZ30984@dragon>
References: <20210811073835.32082-1-o.rempel@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210811073835.32082-1-o.rempel@pengutronix.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 11, 2021 at 09:38:35AM +0200, Oleksij Rempel wrote:
> By default ENET_REF is configured to 50MHz, which is usable for the RMII
> link. In case RGMII is used, we need 125MHz clock.
> 
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>

Applied, thanks!
