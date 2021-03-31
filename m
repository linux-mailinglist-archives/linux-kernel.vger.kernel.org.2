Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4C0634FF5C
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 13:17:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235168AbhCaLRS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Mar 2021 07:17:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:51292 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235113AbhCaLQy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Mar 2021 07:16:54 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B294D6195D;
        Wed, 31 Mar 2021 11:16:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617189413;
        bh=Fg1HIGN3CeImTBjCARQjOr8UdmTKiuMeaC+WX9KUH3c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QFacM2dyeASt+7G6DMjt9PCZ+5Uj8BCOdooiIW1caeOK7mqyl2DBvAAHunixct4hv
         BaC5Xu/ChiqfF9rBm/5y8orSCXLaUztAdVo446IlKI17PVqTwx+cz8Lz0T2KcJlnbA
         JLf8LY4YLP0IRCnI70bKi6RgjNmj5YBSvIOVZhmThyclNt9SpfahwPynxzUA93wqOH
         oycvZoE5zBMJB9sgSgTIBgqKS2S78FxfW+SBi0V4RKZAUxYDEQC93Mx2KhKyekp0Mk
         n9vG9cSkoWBLbWugXoP0NeioBqdaD2emvuc1HvJK4F8LHf27ldK8bFSxEaIUDDjh1Q
         gk8XIne0aZIPg==
Date:   Wed, 31 Mar 2021 16:46:49 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Bjarni Jonasson <bjarni.jonasson@microchip.com>,
        Steen Hegelund <steen.hegelund@microchip.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Andrew Lunn <andrew@lunn.ch>, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] phy: microchip: PHY_SPARX5_SERDES should depend on
 ARCH_SPARX5
Message-ID: <YGRaIbyivDr9MKGK@vkoul-mobl.Dlink>
References: <20210331081937.367408-1-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210331081937.367408-1-geert+renesas@glider.be>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31-03-21, 10:19, Geert Uytterhoeven wrote:
> The Microchip Sparx5 SerDes PHY is present only Microchip Sparx5 SoCs.
> Hence add a dependency on ARCH_SPARX5, to prevent asking the user about
> this driver when configuring a kernel without support for Sparx5 SoCs.

Applied, thanks

-- 
~Vinod
