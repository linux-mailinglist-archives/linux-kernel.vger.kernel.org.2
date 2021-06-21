Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70C493AEA84
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jun 2021 15:54:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230235AbhFUNzy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Jun 2021 09:55:54 -0400
Received: from mout.kundenserver.de ([217.72.192.73]:37675 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229747AbhFUNzw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jun 2021 09:55:52 -0400
Received: from mail-wm1-f46.google.com ([209.85.128.46]) by
 mrelayeu.kundenserver.de (mreue108 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1MQeDw-1lb2K03u6Q-00NjKM; Mon, 21 Jun 2021 15:53:34 +0200
Received: by mail-wm1-f46.google.com with SMTP id m3so10583863wms.4;
        Mon, 21 Jun 2021 06:53:34 -0700 (PDT)
X-Gm-Message-State: AOAM530MXXQE4mKLHbh1noeYyyRLtHZ4YcD8rp9/edvq04IvLgBB1+Ck
        FabfaSMtmqrPDsDXPckSv/r1RjqP1hUelE3rvME=
X-Google-Smtp-Source: ABdhPJw493ZkeJn6Qtnt0HQKPzDF/wWCQngLy4cn5egAOAwLzehc5RUr8VSFHkWig0MgcgLR54Gxv9aeKx7kxIrTKm8=
X-Received: by 2002:a1c:c90f:: with SMTP id f15mr27500984wmb.142.1624283614520;
 Mon, 21 Jun 2021 06:53:34 -0700 (PDT)
MIME-Version: 1.0
References: <fdee3a286defb103aa07b5493b805d1987885165.1624281224.git.michal.simek@xilinx.com>
In-Reply-To: <fdee3a286defb103aa07b5493b805d1987885165.1624281224.git.michal.simek@xilinx.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 21 Jun 2021 15:51:17 +0200
X-Gmail-Original-Message-ID: <CAK8P3a1twOhC8DFxpLxpk8bcy0+JfGZUSE9bX4tdMetVLGTcSQ@mail.gmail.com>
Message-ID: <CAK8P3a1twOhC8DFxpLxpk8bcy0+JfGZUSE9bX4tdMetVLGTcSQ@mail.gmail.com>
Subject: Re: [PATCH v2] clk: zynqmp: fix compile testing without ZYNQMP_FIRMWARE
To:     Michal Simek <michal.simek@xilinx.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Michal Simek <monstr@monstr.eu>, git <git@xilinx.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Punit Agrawal <punit1.agrawal@toshiba.co.jp>,
        Quanyang Wang <quanyang.wang@windriver.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-clk <linux-clk@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:Q0lQsOJJlDknj+DFICyZc3Ei5FFgpGGBLXjXD4Mqnun7FSDskTa
 hKG8tJ1kreUuheVYGDeyO+aglco0VUYsPwJXY7x62HKdMAvaM/o6RFIk1y2HE9VK6TboLsc
 NXa9ebfGIaw8CKIJqXrkbKwna3dGau7PECDDyxP+7mJNybJaQYSbJpTMgeO6yv9fLmZSJhR
 QEGd4EXbK25uqLd+XNyVA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:ArZFVgSvc2s=:qry7NKJzY6z9p60eKzxMWf
 V/w4v+GQ4Xw1L/AhwvWulbsrdGav7o2gp0DYyalXoj1bLwpA8g2bNW1YAUjwTIUYhdbC9o5nv
 lzUAR/Y5oeig8OYdD+ncviY6HVeSLXqNvK4bkYHr1VTh5OoBa549nhdNL0Vhn8L4N7Qd5CM6q
 chNbUNiMT8ijn5cIWqM8Ednpwi0C99Tear5Xmcn3rKIUK1qfxZ8UEQ+EmE9FTmDxjPs2jNkop
 s32i6b7SwhTKjwBNUcIoE4puX+t1aS84C8XxftxZlyuEY1IdIUiqJAx5cNZ17lDe8sQgxsGbj
 ygGx/sbEStQfuuQGS/q9P6WoGlK0OmNY8ZcmmnA2a2qxmvnbNrf88YOjz/lRt8u/CAp9j3nWn
 MS6KpmgaYNHZ+UnFetF1NW3Gj6IN9Ap7V2BwDKakBItsosjgU1GJKer6yTL1O/y2zkvli6nhP
 dLIiBdH0z6nu0aIIpmwUrfKqdI8Sljm426a5UMBrJbe3pxy2i0EjfYW1sEB7MuRYbWjpRdC9h
 0XBdrDkdPbCnLvlOfUu14/kwUFikxwfQny4SGJBb01wDThqMSmDQM3nkYCYAov4Z9CdEjV05+
 GwkHee7xoT9XeHGt9dqFPj88AkYsBEuTfx9tVs5Rqzj7qhUYzR0viJIyePqXnaXQAyOdcojvx
 /Yxo=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 21, 2021 at 3:14 PM Michal Simek <michal.simek@xilinx.com> wrote:
>
> From: Arnd Bergmann <arnd@arndb.de>
>
> When the firmware code is disabled, the incomplete error handling
> in the clk driver causes compile-time warnings:
>
> drivers/clk/zynqmp/pll.c: In function 'zynqmp_pll_recalc_rate':
> drivers/clk/zynqmp/pll.c:147:29: error: 'fbdiv' is used uninitialized [-Werror=uninitialized]
>   147 |         rate =  parent_rate * fbdiv;
>       |                 ~~~~~~~~~~~~^~~~~~~
> In function 'zynqmp_pll_get_mode',
>     inlined from 'zynqmp_pll_recalc_rate' at drivers/clk/zynqmp/pll.c:148:6:
> drivers/clk/zynqmp/pll.c:61:27: error: 'ret_payload' is used uninitialized [-Werror=uninitialized]
>    61 |         return ret_payload[1];
>       |                ~~~~~~~~~~~^~~
> drivers/clk/zynqmp/pll.c: In function 'zynqmp_pll_recalc_rate':
> drivers/clk/zynqmp/pll.c:53:13: note: 'ret_payload' declared here
>    53 |         u32 ret_payload[PAYLOAD_ARG_CNT];
>       |             ^~~~~~~~~~~
> drivers/clk/zynqmp/clk-mux-zynqmp.c: In function 'zynqmp_clk_mux_get_parent':
> drivers/clk/zynqmp/clk-mux-zynqmp.c:57:16: error: 'val' is used uninitialized [-Werror=uninitialized]
>    57 |         return val;
>       |                ^~~
>
> As it was apparently intentional to support this for compile testing
> purposes, change the code to have just enough error handling for the
> compiler to not notice the remaining bugs.
>
> Fixes: 21f237534661 ("clk: zynqmp: Drop dependency on ARCH_ZYNQMP")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Michal Simek <michal.simek@xilinx.com>
> ---
>
> Changes in v2:
> Based on discussion here
> Link: https://lore.kernel.org/r/20210421134844.3297838-1-arnd@kernel.org
> I have updated error return value which I got from clock core based on
> error cases.
>
> zynqmp_clk_mux_get_parent() should return num_parents() as error defined in
> clk_core_get_parent_by_index() where num_parents is incorrect index.
>
> Extend zynqmp_pll_get_mode() with PLL_MODE_ERROR to handle error case.
>
> zynqmp_pll_recalc_rate() returns 0 because __clk_core_init() consider 0 as
> default rate. But maybe -1ul which was used by Arnd is also good option.

Looks good to me. You changed more than I did now, so it might be better
to change my authorship to Co-developed-by, probably not worth respinning
for that.

       Arnd
