Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1AAAB39D8A6
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jun 2021 11:24:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230303AbhFGJZy convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 7 Jun 2021 05:25:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230410AbhFGJZv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jun 2021 05:25:51 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30AA8C061766
        for <linux-kernel@vger.kernel.org>; Mon,  7 Jun 2021 02:24:00 -0700 (PDT)
Received: from lupine.hi.pengutronix.de ([2001:67c:670:100:3ad5:47ff:feaf:1a17] helo=lupine)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1lqBUE-0005sj-Ns; Mon, 07 Jun 2021 11:23:58 +0200
Received: from pza by lupine with local (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1lqBUD-0000Jo-JL; Mon, 07 Jun 2021 11:23:57 +0200
Message-ID: <9f5bee632ed493b150c47f3127242c259a385192.camel@pengutronix.de>
Subject: Re: [PATCH] reset: berlin: support module build
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     Jisheng Zhang <Jisheng.Zhang@synaptics.com>
Cc:     linux-kernel@vger.kernel.org
Date:   Mon, 07 Jun 2021 11:23:57 +0200
In-Reply-To: <20210520171316.395de63e@xhacker.debian>
References: <20210520171316.395de63e@xhacker.debian>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.30.5-1.1 
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2001:67c:670:100:3ad5:47ff:feaf:1a17
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2021-05-20 at 17:13 +0800, Jisheng Zhang wrote:
> Make reset-berlin driver to be tristate module, support to build as
> a module, this is useful for GKI.
> 
> Partially revert commit ed4dba99cae8 ("reset: berlin: make it
> explicitly non-modular")
> 
> Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
> ---
>  drivers/reset/Kconfig        |  4 ++--
>  drivers/reset/reset-berlin.c | 10 ++++++++--
>  2 files changed, 10 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/reset/Kconfig b/drivers/reset/Kconfig
> index 3e7f55e44d84..1e7443a4dae1 100644
> --- a/drivers/reset/Kconfig
> +++ b/drivers/reset/Kconfig
> @@ -43,8 +43,8 @@ config RESET_BCM6345
>  	  This enables the reset controller driver for BCM6345 SoCs.
>  
>  config RESET_BERLIN
> -	bool "Berlin Reset Driver" if COMPILE_TEST
> -	default ARCH_BERLIN
> +	tristate "Berlin Reset Driver"
> +	depends on ARCH_BERLIN || COMPILE_TEST

Is there a reason not to keep "default ARCH_BERLIN"?

regards
Philipp
