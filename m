Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB096330478
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Mar 2021 21:25:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232848AbhCGUYt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Mar 2021 15:24:49 -0500
Received: from mail.baikalelectronics.com ([87.245.175.226]:55726 "EHLO
        mail.baikalelectronics.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232831AbhCGUYW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Mar 2021 15:24:22 -0500
Date:   Sun, 7 Mar 2021 23:24:20 +0300
From:   Serge Semin <Sergey.Semin@baikalelectronics.ru>
To:     Arnd Bergmann <arnd@arndb.de>
CC:     Serge Semin <fancer.lancer@gmail.com>,
        Wang Hai <wanghai38@huawei.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH -next] bus: bt1-apb: remove duplicate include
Message-ID: <20210307202420.zlcpm2zfht5x6uz7@mobilestation>
References: <20200819024351.37982-1-wanghai38@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200819024351.37982-1-wanghai38@huawei.com>
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd,
Could you merge this patch in via your repo?

On Wed, Aug 19, 2020 at 10:43:51AM +0800, Wang Hai wrote:
> Remove linux/clk.h which is included more than once
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Wang Hai <wanghai38@huawei.com>

Acked-by: Serge Semin <fancer.lancer@gmail.com>

-Sergey

> ---
>  drivers/bus/bt1-apb.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/bus/bt1-apb.c b/drivers/bus/bt1-apb.c
> index b25ff941e7c7..74b1b712ef3a 100644
> --- a/drivers/bus/bt1-apb.c
> +++ b/drivers/bus/bt1-apb.c
> @@ -22,7 +22,6 @@
>  #include <linux/clk.h>
>  #include <linux/reset.h>
>  #include <linux/time64.h>
> -#include <linux/clk.h>
>  #include <linux/sysfs.h>
>  
>  #define APB_EHB_ISR			0x00
> -- 
> 2.17.1
> 
