Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14A403B4AD4
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jun 2021 01:10:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229924AbhFYXMS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Jun 2021 19:12:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:42150 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229816AbhFYXMR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jun 2021 19:12:17 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A600861948;
        Fri, 25 Jun 2021 23:09:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624662595;
        bh=79KnoWVb+3ep/BJmoVJPl2luYOgjPam8atccGxUFaqQ=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=afbd9dOByB5ZJoy1Yuzqzoy0I76srrttw3RdcEfSI2cuhk4/6o3+HK2+YUcLe7EAO
         1hfs7BtAnbQpMUiwHZ/jrZKV9T6kfCvNWdz6OGyQCGvH/3gHD6ItiSbeYuQZRppnT/
         ANz4yxUD6AREKu1JXaF/tTDJgQrFwAVNoRlplHaCSXf7zQUlnZD6Sax/q7l1Y/GqNn
         EwGx8fMg/LhQlYgYXjDwKshVNPsAtQPH8F5ICi/ZUg+UnQ24peY1I3UuADbc1+Hi32
         uJONiwABm4CJHlB0LvQE8b5Bvc3xddIaWNkSCLq0GacRzdTcIu96U4L6+Bc19GAQFs
         UTZWq7YAMmTPg==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <71a9fed5f762a71248b8ac73c0a15af82f3ce1e2.1619867987.git.christophe.jaillet@wanadoo.fr>
References: <71a9fed5f762a71248b8ac73c0a15af82f3ce1e2.1619867987.git.christophe.jaillet@wanadoo.fr>
Subject: Re: [PATCH] clk: zynqmp: pll: Remove some dead code
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        jolly.shah@xilinx.com, michal.simek@xilinx.com,
        mturquette@baylibre.com, quanyang.wang@windriver.com,
        rajan.vaja@xilinx.com, shubhrajyoti.datta@xilinx.com,
        tejasp@xilinx.com
Date:   Fri, 25 Jun 2021 16:09:54 -0700
Message-ID: <162466259437.3259633.17315460513843756213@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Christophe JAILLET (2021-05-01 04:24:32)
> 'clk_hw_set_rate_range()' does not return any error code and 'ret' is
> known to be 0 at this point, so this message can never be displayed.
>=20
> Remove it.
>=20
> Fixes: 3fde0e16d016 ("drivers: clk: Add ZynqMP clock driver")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---

Applied to clk-next
