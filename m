Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABAF84004EF
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Sep 2021 20:32:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348231AbhICSdy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Sep 2021 14:33:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:59606 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1346181AbhICSdx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Sep 2021 14:33:53 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9CF3960724;
        Fri,  3 Sep 2021 18:32:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630693973;
        bh=l/p1Mt+6Buj3XpMkEakyWxymjCSxUxk4W1rvVC61s4Y=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=f6KdmLDyoCj8nHr/oc0jQe6KrKWlhQDDVs0k69X/d/+YOu36J8pL16GkpIePEoFjj
         u/qOlKoRY0cVmbGT9yvRyGYZ41rg40sccPGZ2ndVD27M4QscQf1FBeNRbzxgsf4a41
         7csNMyf4kyuMlZDDj5FihxoxaX20rC1U+hBKVA9mEeAFZG8gbNpFnDdXlZtOz0SBk3
         6y8mu6y19xaSgY0g2B1YQWPPhTsU+jMoMC1X7cQ9CNgBi3yaSh7LBwpDpVwUXeV3Pl
         nR7/DtbxWjs0C7eetEn5gHwFCyrPf5kA7u48hBscwDwT/0bpUhaiarDMhCVKAKGXdR
         kYsRB9HijTGhA==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20210902075713.7563-1-miles.chen@mediatek.com>
References: <20210902075713.7563-1-miles.chen@mediatek.com>
Subject: Re: [PATCH] clk: rockchip: use module_platform_driver_probe
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org, wsd_upstream@mediatek.com,
        Miles Chen <miles.chen@mediatek.com>
To:     Heiko Stuebner <heiko@sntech.de>,
        Michael Turquette <mturquette@baylibre.com>,
        Miles Chen <miles.chen@mediatek.com>
Date:   Fri, 03 Sep 2021 11:32:52 -0700
Message-ID: <163069397238.405991.15295469394989512619@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Miles Chen (2021-09-02 00:57:13)
> Replace builtin_platform_driver_probe with module_platform_driver_probe
> because that rk3399 and rk3568 can be built as kernel modules.
>=20
> Cc: Stephen Boyd <sboyd@kernel.org>
> Signed-off-by: Miles Chen <miles.chen@mediatek.com>

Should it have a fixes tag?
