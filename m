Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5194E3095FA
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Jan 2021 15:41:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229636AbhA3Oi6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Jan 2021 09:38:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:41200 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231861AbhA3OOf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Jan 2021 09:14:35 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id C952A64E0F;
        Sat, 30 Jan 2021 14:13:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612016032;
        bh=gcL64xQ/H7WgYF3vPVXQ8XFfZ+TTeXHbLUs+HD0ScDQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=h7ocjYC/PsUM6QJcyTY4NcPUn76ZqFcFEnz/Pc/kSwVoc0sW9X95Znom5MRjh5yOV
         2tQVnNg7SIJBHmrHLqn7k6mnWDysd6LJy7yGUtvD3NPLqzJm5LXLsPW+tuqv10cuwQ
         gITDMV5OHlBY6yfsec0cuncVC64lSI2iUCx9xcDhGHfjxsYUOKz6K6GTDgwvcYePrI
         nC0BdTORwbG5uvYZZPYomgUVf74pU6Prznp8dx6cM5KfzmFgv28orK4m7fSuMnBqWO
         IjD2tRZtHqZeArqbKOOZxi1he/VqHvCAk35vNlsg9ZjNDVKySeDxF9phs1amh6ZJHz
         sVC5Ky6Q1m26A==
Date:   Sat, 30 Jan 2021 22:13:46 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     linux-kernel@vger.kernel.org, Russell King <linux@armlinux.org.uk>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Ahmad Fatoum <a.fatoum@pengutronix.de>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 20/21] clk: imx: Move 'imx6sl_set_wait_clk()'s prototype
 out to accessible header
Message-ID: <20210130141345.GN907@dragon>
References: <20210126124540.3320214-1-lee.jones@linaro.org>
 <20210126124540.3320214-21-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210126124540.3320214-21-lee.jones@linaro.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 26, 2021 at 12:45:39PM +0000, Lee Jones wrote:
> Fixes the following W=1 kernel build warning(s):
> 
>  drivers/clk/imx/clk-imx6sl.c:156:6: warning: no previous prototype for ‘imx6sl_set_wait_clk’ [-Wmissing-prototypes]
> 
> Cc: Russell King <linux@armlinux.org.uk>
> Cc: Shawn Guo <shawnguo@kernel.org>
> Cc: Sascha Hauer <s.hauer@pengutronix.de>
> Cc: Pengutronix Kernel Team <kernel@pengutronix.de>
> Cc: Fabio Estevam <festevam@gmail.com>
> Cc: NXP Linux Team <linux-imx@nxp.com>
> Cc: Ahmad Fatoum <a.fatoum@pengutronix.de>
> Cc: linux-arm-kernel@lists.infradead.org
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Applied, thanks.
