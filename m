Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 393123691B1
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Apr 2021 14:02:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242241AbhDWMDB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Apr 2021 08:03:01 -0400
Received: from smtp06.smtpout.orange.fr ([80.12.242.128]:56399 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231472AbhDWMC4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Apr 2021 08:02:56 -0400
Received: from [192.168.1.18] ([86.243.172.93])
        by mwinf5d63 with ME
        id wC2J2400121Fzsu03C2JFL; Fri, 23 Apr 2021 14:02:19 +0200
X-ME-Helo: [192.168.1.18]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Fri, 23 Apr 2021 14:02:19 +0200
X-ME-IP: 86.243.172.93
Subject: AW: [PATCH 1/4] clk: mvebu: Fix a memory leak in an error handling
 path
To:     Walter Harms <wharms@bfs.de>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        "gregory.clement@bootlin.com" <gregory.clement@bootlin.com>,
        "thomas.petazzoni@free-electrons.com" 
        <thomas.petazzoni@free-electrons.com>
Cc:     "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>
References: <cover.1619157996.git.christophe.jaillet@wanadoo.fr>
 <27db232fdd14e14d493f29a5404d9e643f09cc96.1619157996.git.christophe.jaillet@wanadoo.fr>
 <3e38da0e86c045d3aefd46f375e8b48e@bfs.de>
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Message-ID: <f26e2ad3-d1b8-de96-febe-5b8f52abdf8f@wanadoo.fr>
Date:   Fri, 23 Apr 2021 14:02:17 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <3e38da0e86c045d3aefd46f375e8b48e@bfs.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 23/04/2021 à 13:42, Walter Harms a écrit :
> nitpicking:
>   clk_name could be replaced with cpuclk[cpu].clk_name

Agreed, Thx.
I'll wait a few days to see if there are other comments before sending a 
v2. (especially if 4/4 is correct or not)
I'll also add "clk-cpu:" after "clk: mvebu:"

> and the commit msg is from the other patch (free  cpuclk[cpu].clk_name)
> 

But here, I don't follow you.
What do you mean? Which other patch?

Do you mean that the commit message has to be updated accordingly?
(ie: s/clk_name/cpuclk[cpu].clk_name/ must be freed)


> jm2c,
> 
> re,
>   wh
> ________________________________________
> Von: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> Gesendet: Freitag, 23. April 2021 08:25:01
> An: mturquette@baylibre.com; sboyd@kernel.org; gregory.clement@bootlin.com; thomas.petazzoni@free-electrons.com
> Cc: linux-clk@vger.kernel.org; linux-kernel@vger.kernel.org; kernel-janitors@vger.kernel.org; Christophe JAILLET
> Betreff: [PATCH 1/4] clk: mvebu: Fix a memory leak in an error handling path
> 
> WARNUNG: Diese E-Mail kam von außerhalb der Organisation. Klicken Sie nicht auf Links oder öffnen Sie keine Anhänge, es sei denn, Sie kennen den/die Absender*in und wissen, dass der Inhalt sicher ist.
> 
> 
> If an error occurs in the for_each loop, clk_name must be freed.
> 
> In order to do so, sightly rearrange the code:
>     - move the allocation to simplify error handling
>     - use kasprintf instead of kzalloc/sprintf to simplify code and avoid a
>       magic number
> 
> Fixes: ab8ba01b3fe5 ("clk: mvebu: add armada-370-xp CPU specific clocks")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
> The { } around the 1 line block after kasprintf is intentional and makes
> sense with 2/2
> ---
>   drivers/clk/mvebu/clk-cpu.c | 10 +++++-----
>   1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/clk/mvebu/clk-cpu.c b/drivers/clk/mvebu/clk-cpu.c
> index c2af3395cf13..a11d7273fcc7 100644
> --- a/drivers/clk/mvebu/clk-cpu.c
> +++ b/drivers/clk/mvebu/clk-cpu.c
> @@ -195,17 +195,17 @@ static void __init of_cpu_clk_setup(struct device_node *node)
>          for_each_of_cpu_node(dn) {
>                  struct clk_init_data init;
>                  struct clk *clk;
> -               char *clk_name = kzalloc(5, GFP_KERNEL);
> +               char *clk_name;
>                  int cpu, err;
> 
> -               if (WARN_ON(!clk_name))
> -                       goto bail_out;
> -
>                  err = of_property_read_u32(dn, "reg", &cpu);
>                  if (WARN_ON(err))
>                          goto bail_out;
> 
> -               sprintf(clk_name, "cpu%d", cpu);
> +               clk_name = kasprintf(GFP_KERNEL, "cpu%d", cpu);
> +               if (WARN_ON(!clk_name)) {
> +                       goto bail_out;
> +               }
> 
>                  cpuclk[cpu].parent_name = of_clk_get_parent_name(node, 0);
>                  cpuclk[cpu].clk_name = clk_name;
> --
> 2.27.0
> 
> 

