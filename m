Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4906443875
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Nov 2021 23:27:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231308AbhKBW3z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Nov 2021 18:29:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:44878 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231304AbhKBW3y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Nov 2021 18:29:54 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7BE9060F58;
        Tue,  2 Nov 2021 22:27:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635892038;
        bh=RyrQhwn2Vy8Vb4phGtmF7ukr6z7ieGukP6hkFFWFro8=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=JhEp31JfEL9iQOgPzny6tMnrj9ohRow/wtpYwdJCiLxARrHmh6vw5gYmuKwYLi39I
         tYTMECMjRxcHmGd9pZvlLSOFVIy7eF21YEvtYNm15Fa309sbToj7PImcBs5fAmD2do
         9yzetaiUFAnR1u8sEvdOXSvOezRhUS+Q1EeTZYLgfsxK12VBQZP+dAGgCZrsynEkQv
         dV7Jv9YfBFAqEwP+CMGjOCybIjNG4VAh+I+t2MFJdQbQcE00P3gxVplFW9bt/oLTkA
         Z9ceH1yNcjO62FY869PLSGGPf/mJC0V/OjCKBnGacGfCryOdgkkShcnl1S6Hx5BpuO
         Ne0eb+X6LAyAw==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20211019062939.979660-1-ran.jianping@zte.com.cn>
References: <20211019062939.979660-1-ran.jianping@zte.com.cn>
Subject: Re: [PATCH v2 clk:mediatek] clk:mediatek: remove duplicate include in  clk-mt8195-imp_iic_wrap.c
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     matthias.bgg@gmail.com, chun-jie.chen@mediatek.com,
        ran.jianping@zte.com.cn, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Zeal Robot <zealci@zte.com.cn>
To:     cgel.zte@gmail.com, mturquette@baylibre.com, wenst@chromium.org
Date:   Tue, 02 Nov 2021 15:27:17 -0700
Message-ID: <163589203711.2993099.290279601118668410@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting cgel.zte@gmail.com (2021-10-18 23:29:39)
> From: Ran Jianping <ran.jianping@zte.com.cn>
>=20
> 'dt-bindings/clock/mt8195-clk.h' included in
> '/drivers/clk/mediatek/clk-mt8195-imp_iic_wrap.c' is duplicated.It is
> also included on the 13 line.
>=20
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: Ran Jianping <ran.jianping@zte.com.cn>
>=20
> v2:
>   delete extra empty line.
>=20
> ---

Applied to clk-next
