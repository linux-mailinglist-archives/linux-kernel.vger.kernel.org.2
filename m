Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68244319373
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Feb 2021 20:54:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230436AbhBKTxk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Feb 2021 14:53:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:36548 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229940AbhBKTw0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Feb 2021 14:52:26 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id C080464E15;
        Thu, 11 Feb 2021 19:51:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613073105;
        bh=3GyocaC5z5Ok2h+VErVxeQ0NnYDCjrGbznwV298VfRM=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=FUrXvzOfuxssLcLjLSXBgqiebxKYMcEOhK3zsdTP2U8AkgyE8YnQNuYZalj/BwWsf
         y2Ies+p80BrhIT+/RQj/AyGwK/YN8hM7IiyKk/kCAcDnfoKpjaJHBZufpnZR8M84s5
         uYsSqiYelGvJzYAZMwffabnZxvvWH/WFPYn+q82aQowP9NyCUdUA550Vlqw+z5npax
         adaKVbqgbNczRk7CTMfKxLBnlEVqIMUYYxzRa/QxlpkXhDdTFqfGvovCsHlOMflo5f
         PZsOcU9SR0/ypRL8LQ9aZRBfaWfpc9oQoJRr19ZggO8IyVaADujr2ROoOepEPl0srb
         sZBpswM3D7Z3A==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20210120093040.1719407-12-lee.jones@linaro.org>
References: <20210120093040.1719407-1-lee.jones@linaro.org> <20210120093040.1719407-12-lee.jones@linaro.org>
Subject: Re: [PATCH 11/20] clk: st: clkgen-pll: Demote unpopulated kernel-doc header
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Gallimore <stephen.gallimore@st.com>,
        Pankaj Dev <pankaj.dev@st.com>, linux-clk@vger.kernel.org
To:     lee.jones@linaro.org
Date:   Thu, 11 Feb 2021 11:51:44 -0800
Message-ID: <161307310452.1254594.4196599201990630125@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Lee Jones (2021-01-20 01:30:31)
> And remove an incorrect entry.
>=20
> Fixes the following W=3D1 kernel build warning(s):
>=20
>  drivers/clk/st/clkgen-pll.c:142: warning: cannot understand function pro=
totype: 'struct clkgen_pll '
>=20
> Cc: Michael Turquette <mturquette@baylibre.com>
> Cc: Stephen Boyd <sboyd@kernel.org>
> Cc: Stephen Gallimore <stephen.gallimore@st.com>
> Cc: Pankaj Dev <pankaj.dev@st.com>
> Cc: linux-clk@vger.kernel.org
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---

Applied to clk-next
