Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCDDA40BB34
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Sep 2021 00:19:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235692AbhINWUd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 18:20:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:54764 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235673AbhINWUV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 18:20:21 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id EA6516115B;
        Tue, 14 Sep 2021 22:19:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631657943;
        bh=x7ffoGwn9F4ZSmybMmYQZLl6zg5IA1R+UOiKagSf6Lw=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=BXJNtckld0tvyok+8nK5rEJ390gmaPJnEoNitNdVtrSgsDEqgzABEshFO2XeZ6VpL
         7UsvMqHn3HmcvEJbAFxvbyCQzlUedGVGUQGKpJ9L2Cz7tREoifajjA6prwz9yxeoOf
         4bkBOODNDylNMOe5uLzPqZAlps/kkqrGrXHz22RqlTF6FW6ffN5Liae7XtXLvVeaxA
         uW4tVJKUgq+X3NbZPCQmdnlX5jyGXPKE70YgIZJ93YWF5XPkWp/B6JoweFipH8XU9z
         leJUi0EBwOInkbhObzNAkiuXxFNQ9qIxd8vbJ/h9gNb5CeqmNnlSnJ0i2ksR7yb3gi
         aNIxnaW6gan3g==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20210914021633.26377-13-chun-jie.chen@mediatek.com>
References: <20210914021633.26377-1-chun-jie.chen@mediatek.com> <20210914021633.26377-13-chun-jie.chen@mediatek.com>
Subject: Re: [v3 12/24] clk: mediatek: Add MT8195 imgsys clock support
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, srv_heupstream@mediatek.com,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        Chun-Jie Chen <chun-jie.chen@mediatek.com>
To:     Chun-Jie Chen <chun-jie.chen@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Rob Herring <robh+dt@kernel.org>
Date:   Tue, 14 Sep 2021 15:19:01 -0700
Message-ID: <163165794184.763609.8685073457952732841@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Chun-Jie Chen (2021-09-13 19:16:21)
> Add MT8195 imgsys clock controllers which provide clock gate
> control for image IP blocks.
>=20
> Signed-off-by: Chun-Jie Chen <chun-jie.chen@mediatek.com>
> Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>
> ---

Applied to clk-next
