Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B51EA3132B6
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Feb 2021 13:50:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230196AbhBHMtn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Feb 2021 07:49:43 -0500
Received: from mail.baikalelectronics.com ([87.245.175.226]:56314 "EHLO
        mail.baikalelectronics.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229742AbhBHMsz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 07:48:55 -0500
Date:   Mon, 8 Feb 2021 15:48:04 +0300
From:   Serge Semin <Sergey.Semin@baikalelectronics.ru>
To:     <alex_luca@163.com>, Arnd Bergmann <arnd@arndb.de>
CC:     <linux-kernel@vger.kernel.org>, Zhang Kun <zhangkun@cdjrlc.com>
Subject: Re: [PATCH] bus: bt1-apb:Fix duplicate included linux/clk.h
Message-ID: <20210208124804.vgaszr2h4rv64ujg@mobilestation>
References: <20210207142050.23445-1-alex_luca@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20210207142050.23445-1-alex_luca@163.com>
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 07, 2021 at 10:20:50PM +0800, alex_luca@163.com wrote:
> From: Zhang Kun <zhangkun@cdjrlc.com>
> 
> Remove one of the duplicate header hlinux/clk.h which isn't necessary.

Thanks!
Acked-by: Serge Semin <fancer.lancer@gmail.com>

Arnd, could you merge it in?

-Sergey

> 
> Signed-off-by: Zhang Kun <zhangkun@cdjrlc.com>
> ---
>  drivers/bus/bt1-apb.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/bus/bt1-apb.c b/drivers/bus/bt1-apb.c
> index b25ff941e7c7..e9e196cd9253 100644
> --- a/drivers/bus/bt1-apb.c
> +++ b/drivers/bus/bt1-apb.c
> @@ -19,7 +19,6 @@
>  #include <linux/nmi.h>
>  #include <linux/of.h>
>  #include <linux/regmap.h>
> -#include <linux/clk.h>
>  #include <linux/reset.h>
>  #include <linux/time64.h>
>  #include <linux/clk.h>
> -- 
> 2.17.1
> 
> 
