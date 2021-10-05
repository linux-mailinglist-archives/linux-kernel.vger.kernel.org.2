Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36F68421CDA
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 05:22:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231273AbhJEDYo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Oct 2021 23:24:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:41200 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229659AbhJEDYm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Oct 2021 23:24:42 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id DD28C6137C;
        Tue,  5 Oct 2021 03:22:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633404172;
        bh=QYJejplqlgftlfqkicmALO/wogBxdt5G0cyTWggxdNw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QrSz6bU8oQdwRGiesTgJ+Qp4EbubTKGiK8GXrEyXjtStNH4orL2kTGiwvLTkOiE2B
         8832F47agVbKuYl4wfS/HlcnhAiODSTiQMdzrvPF2VbLRYqbY2vkqsgAFJOoUd2C6m
         R2D2UDTpFl9u9BQBxS8T6EnJ9tAWpUrk6gmyPZ1jChtir8v3RqoNqaGzIUhJJTHVVr
         qvfBnvqd7j8rcN5Ll3GIdNq5CaeiFWIzAxwFYxEQV6iwFzBANramF3nmpDn6+NTOK+
         pXOsI4AG0KnH4l2qTm0n2j39/xg6/JWRLJvkD581wFB2NDI6a4M16zd1vuAaBw2VCM
         ayzSkX1W18Oew==
Date:   Tue, 5 Oct 2021 11:22:47 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Marcel Ziswiler <marcel@ziswiler.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Fabio Estevam <festevam@gmail.com>,
        Andreas Kemnade <andreas@kemnade.info>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pascal Zimmermann <pzimmermann@dh-electronics.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Russell King <linux@armlinux.org.uk>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/9] ARM: imx_v6_v7_defconfig: enable mtd physmap
Message-ID: <20211005032245.GA20743@dragon>
References: <20210920144938.314588-1-marcel@ziswiler.com>
 <20210920144938.314588-2-marcel@ziswiler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210920144938.314588-2-marcel@ziswiler.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 20, 2021 at 04:49:30PM +0200, Marcel Ziswiler wrote:
> From: Marcel Ziswiler <marcel.ziswiler@toradex.com>
> 
> Enable CONFIG_MTD_PHYSMAP which is nowadays required for
> CONFIG_MTD_PHYSMAP_OF.
> 
> Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
> Reviewed-by: Fabio Estevam <festevam@gmail.com>

Applied, thanks!
