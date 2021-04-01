Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60A6C350C18
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Apr 2021 03:49:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232884AbhDABss (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Mar 2021 21:48:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:50474 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229497AbhDABsm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Mar 2021 21:48:42 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0872F6023F;
        Thu,  1 Apr 2021 01:48:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617241722;
        bh=llB1PBxOwriT2KB88xNWqRmVzTqkcfQJvdyDOxSw/gc=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=QgH7L8Rg2ojIqlubkguMFnNLyoWe6gmH/mYl4+TwFjSxEvv5r5Sygi1J+KYPwE4O8
         Jx7OCtuCVSTIs4nvWxdIFGuNATht0+/Gl1Mnth0tcQ0A8UR7y66MGfJRgTbfCmt1yD
         memC7ZB51SH0TgPFbWOmolaY8bDOmoyyt5wUJ/73xDqxWorLjpyKRqSxcplM1OComW
         qnYY1zwnm/D4vumn9FpGWrNQfeQqErP9RpuF1Z0kTW9chcqrq2uoKJjqncICK/+Nx1
         fdJCCSp9PZzpg0jSo9p8Kpr2gTVHPKSICBU1+d+PMtL914THs1TVMFk7xd9FQ/8tCr
         uVMRvsSFqNAxg==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20210331090018.3464094-1-quanyang.wang@windriver.com>
References: <20210331090018.3464094-1-quanyang.wang@windriver.com>
Subject: Re: [PATCH] clk: zynqmp: move zynqmp_pll_set_mode out of round_rate callback
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jolly Shah <jolly.shah@xilinx.com>,
        Rajan Vaja <rajan.vaja@xilinx.com>,
        Quanyang Wang <quanyang.wang@windriver.com>,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Michal Simek <michal.simek@xilinx.com>,
        quanyang.wang@windriver.com
Date:   Wed, 31 Mar 2021 18:48:40 -0700
Message-ID: <161724172079.2260335.16388981768978108196@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting quanyang.wang@windriver.com (2021-03-31 02:00:18)
> From: Quanyang Wang <quanyang.wang@windriver.com>
>=20
> The round_rate callback should only perform rate calculation and not
> involve calling zynqmp_pll_set_mode to change the pll mode. So let's
> move zynqmp_pll_set_mode out of round_rate and to set_rate callback.
>=20
> Reported-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> Signed-off-by: Quanyang Wang <quanyang.wang@windriver.com>
> ---

Any Fixes tag?
