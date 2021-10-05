Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FEB1421E83
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 07:58:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232266AbhJEGAp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Oct 2021 02:00:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:42546 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231752AbhJEGAo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Oct 2021 02:00:44 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D524761526;
        Tue,  5 Oct 2021 05:58:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633413534;
        bh=UU2mtTMd4/UUEcJ77iSfSDWdfsOvw0yaD/BUWFVhNLU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qcEBwufB+AWKP2W7R287RTRoxt6QO1djIwS2LmZ6Gi8NsVy7slnUf4C6NP/D0hhIc
         Q6hHyuArNQv4lntkg4gsz2y71e6gwa6xs1svtQwcEUIpq4+H8mE37CB6jsLIgf4z7q
         qU0nTRTYqm8rvt9WjK3LtUZ1e3lJusXg+Utm/GOSXnDjrG/QwRlRyGgDrrpHUXZVrO
         1Bm+eELmjXex5tCdmKmwGXzcMuddpePaghS8OnX1n7yzVdE2b1B5sGi5ZW3H9jr4d/
         yZNyYEP1b8ay2S/WuFAOQoF+psDjp2HoAFkelLFI0uEBW69fQdM2RFRKLBkfAMFQX3
         LdYQxN6K+843g==
Date:   Tue, 5 Oct 2021 13:58:48 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Oleksij Rempel <o.rempel@pengutronix.de>
Cc:     Sascha Hauer <s.hauer@pengutronix.de>, kernel@pengutronix.de,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Fabio Estevam <festevam@gmail.com>, linux-imx@nxp.com
Subject: Re: [PATCH v3] ARM: imx6: disable the GIC CPU interface before
 calling stby-poweroff sequence
Message-ID: <20211005055848.GP20743@dragon>
References: <20210928134940.1329-1-o.rempel@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210928134940.1329-1-o.rempel@pengutronix.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 28, 2021 at 03:49:40PM +0200, Oleksij Rempel wrote:
> Any pending interrupt can prevent entering standby based power off state.
> To avoid it, disable the GIC CPU interface.
> 
> Fixes: 8148d2136002 ("ARM: imx6: register pm_power_off handler if "fsl,pmic-stby-poweroff" is set")
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>

Applied, thanks!
