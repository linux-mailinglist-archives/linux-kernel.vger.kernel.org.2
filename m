Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3045F3D7CE3
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jul 2021 19:57:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232100AbhG0R5f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jul 2021 13:57:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:47068 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230208AbhG0R5c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jul 2021 13:57:32 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 32F506056B;
        Tue, 27 Jul 2021 17:57:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627408652;
        bh=HUyhatCxcGH3OM0itBe6EZjaJZ2ADW7P1VbpjXcwZvI=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=urs4o1XCJp2ln1RmGUFnDlz7TkmbLYFabKl7SM+AeARAMLgXOJ40CYMK859Ah/gIq
         zJyotdvntdT2XAXdI9ksNnlcOYFWUKq+WUKyybV0ycW7a0IZugTlJRq4XkJGba+qta
         sAfx4PSt5p9MnY1Fyu0GOsqUOv4vCl1gXKtrgZoCdv+rn652MVsP7oRURpaDiyzQgb
         BJGsB+7FtpK4ed5TvYbICr30jX5fXKwtU6RXgJo2cFdq5beTAT4DSWijPpw3eNISj3
         udW7sb7zP+jXGkIhnPZZkHZ6CbTQ1v8hp7tSh0wJfuo0N/dSwpAea0sIzQ2v64kplP
         u5xy0BrASS9nw==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20210726105719.15793-20-chun-jie.chen@mediatek.com>
References: <20210726105719.15793-1-chun-jie.chen@mediatek.com> <20210726105719.15793-20-chun-jie.chen@mediatek.com>
Subject: Re: [v14 19/21] clk: mediatek: Add MT8192 scp adsp clock support
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, srv_heupstream@mediatek.com,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        Weiyi Lu <weiyi.lu@mediatek.com>,
        Chun-Jie Chen <chun-jie.chen@mediatek.com>
To:     Chun-Jie Chen <chun-jie.chen@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Rob Herring <robh+dt@kernel.org>
Date:   Tue, 27 Jul 2021 10:57:30 -0700
Message-ID: <162740865000.2368309.11701590537224350739@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Chun-Jie Chen (2021-07-26 03:57:17)
> Add MT8192 scp adsp clock provider
>=20
> Signed-off-by: Weiyi Lu <weiyi.lu@mediatek.com>
> Signed-off-by: Chun-Jie Chen <chun-jie.chen@mediatek.com>
> ---

Applied to clk-next
