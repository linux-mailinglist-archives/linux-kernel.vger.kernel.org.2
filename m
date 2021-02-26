Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E00EE3265F4
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Feb 2021 17:58:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229915AbhBZQ6K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Feb 2021 11:58:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:52058 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229550AbhBZQ6I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Feb 2021 11:58:08 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1AD7F64F0D;
        Fri, 26 Feb 2021 16:57:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614358647;
        bh=D6Ll0Gy5CJCzeg9qJEhC+n1ib3HpyruXYBbUWhZU4Yc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Qy2sdYiF2mQY/XJoT3V8jzCdI2nQKbFWesmeSF5YoCtnXAeYIGK3nBTi/Qth7JPjJ
         dyYlIlww6Cn12G9EFHYCWff/a8IFAiJu8v48ad1QyhrwchAFioUDG00vU0nrrzjkw0
         pCuYNoTJXUNUO3EQZhqQBxV6xhIZMAhrmC/xi3YRxMqy90CUwuxTh5f/BJ37OTYLoZ
         ZpIy5SeQ0oBMZfuIIqiAIeJlJbs68POHA1hrruKcRcTbxjGsLl3+X/fRyMN7J3dCsY
         gMySPfclEcYDkvWkV68dj4CNBmS08x7RZ0dQm+fRgLut/eRVTg8iL0o/6s02EznXyT
         XY0dxlbF8qJBw==
Date:   Fri, 26 Feb 2021 17:57:23 +0100
From:   Maxime Ripard <mripard@kernel.org>
To:     Jagan Teki <jagan@amarulasolutions.com>
Cc:     Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-amarula@amarulasolutions.com
Subject: Re: [PATCH v3 6/7] drm: sun4i: dsi: Use drm_panel_bridge, connector
 API
Message-ID: <20210226165723.szblbiswz5vgapq2@hendrix>
References: <20210214194102.126146-1-jagan@amarulasolutions.com>
 <20210214194102.126146-7-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210214194102.126146-7-jagan@amarulasolutions.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Feb 15, 2021 at 01:11:01AM +0530, Jagan Teki wrote:
> Use drm_panel_bridge to replace manual panel handling code.
>
> This simplifies the driver to allows all components in the
> display pipeline to be treated as bridges, paving the way
> to generic connector handling.
>
> Use drm_bridge_connector_init to create a connector for display
> pipelines that use drm_bridge.
>
> This allows splitting connector operations across multiple bridges
> when necessary, instead of having the last bridge in the chain
> creating the connector and handling all connector operations
> internally.
>
> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>

Most of the code removed in that patch was actually introduced earlier
which feels a bit weird. Is there a reason we can't do that one first,
and then introduce the bridge support?

Maxime
