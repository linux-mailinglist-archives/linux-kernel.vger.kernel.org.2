Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FBDF3C7FFF
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jul 2021 10:27:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238489AbhGNI3m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jul 2021 04:29:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:37930 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238478AbhGNI3i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jul 2021 04:29:38 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B211B613AF;
        Wed, 14 Jul 2021 08:26:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626251207;
        bh=etEuofD648HZ8+Qajl/tkZx7/aRwzO+o/d0lVwIk6pY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=joeWvwFalRc791zBVG4uATUst/eI5qgXrAKyNRrIlt6BX1tyB8+DOxWqBgkuAJCEa
         tnXo2SOEvZJmqVe8/icU4uQ544URv8579zGPUIRAZv5hpp4JP+ww0nzINRnpY6RBcN
         2S4ttC65nPWuCjSxOwIH2ZgSlQEbaa+XQehZk6fG7TBbImtfHpm2zhMF8EkQ2+lPkd
         bQbFR7IqOvmqQ2CPIstQEc6dUtJ3CjMzxBqmS2FuYN3pat2+t+idVMauoNN+I8+mbB
         12qGHeL9tUNRNsLwqDQM720l1jEIqN1KjBLVmvR3IYYm7RqOBVfrS8yfWyAq058Sq+
         WmzbnBTycvAhg==
Date:   Wed, 14 Jul 2021 16:26:42 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc:     Russell King <linux@armlinux.org.uk>,
        Rob Herring <robh+dt@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
        thomas.petazzoni@bootlin.com, herve.codina@bootlin.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] ARM: dts: imx6qdl-sr-som: Increase the PHY reset
 duration to 10ms
Message-ID: <20210714082641.GL4419@dragon>
References: <20210625121353.3698240-1-maxime.chevallier@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210625121353.3698240-1-maxime.chevallier@bootlin.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 25, 2021 at 02:13:53PM +0200, Maxime Chevallier wrote:
> The AR803x PHY used on this modules seems to require the reset line to
> be asserted for around 10ms in order to avoid rare cases where the PHY
> gets stuck in an incoherent state that prevents it to function
> correctly.
> 
> The previous value of 2ms was found to be problematic on some setups,
> causing intermittent issues where the PHY would be unresponsive
> every once in a while on some sytems, with a low occurrence (it typically
> took around 30 consecutive reboots to encounter the issue).
> 
> Bumping the delay to the 10ms makes the issue dissapear, with more than
> 2500 consecutive reboots performed without the issue showing-up.
> 
> Fixes: 208d7baf8085 ("ARM: imx: initial SolidRun HummingBoard support")
> Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
> Tested-by: Hervé Codina <herve.codina@bootlin.com>

Applied, thanks.
