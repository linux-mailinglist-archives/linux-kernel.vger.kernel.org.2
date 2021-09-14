Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F07440BB30
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Sep 2021 00:19:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235712AbhINWU2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 18:20:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:54684 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235633AbhINWUP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 18:20:15 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 69D2A61164;
        Tue, 14 Sep 2021 22:18:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631657937;
        bh=tIdO8AvfEw7TMRf2V6g/vWLh8elNlsAu49gIboFy68U=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=MSikHtQdLObbGYYkdEBkHoeG7GG4u+lU/qRMPrpaQhFTkFjU6CTPN9grOzFAYHPeQ
         8bqEo3ZFrTp+cgpbRbd4dftGQ8eaXsek8dzMmHELctkXndryIP9RFnBOi9CLBR6pFm
         Q+Tv0HChF0g3nCROodCKkho97hnQj0U4Qol63Stm+8B7GIrHWIw+KFxpqqEpI8rbJY
         xinqlsd/7oIXDqXJDCetapkyOn/ReUg3rdXVOSsFO9bwAcg1Msihb7G484OBvqxCTm
         pxPAJY2r6o0+gjERNmBHOmvF/icmLddQzbH/k7jeYBEN7KgF4xPZlvWPjYyS0zL9OI
         Ywni7JgCyFdJA==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20210914021633.26377-12-chun-jie.chen@mediatek.com>
References: <20210914021633.26377-1-chun-jie.chen@mediatek.com> <20210914021633.26377-12-chun-jie.chen@mediatek.com>
Subject: Re: [v3 11/24] clk: mediatek: Add MT8195 ccusys clock support
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
Date:   Tue, 14 Sep 2021 15:18:56 -0700
Message-ID: <163165793627.763609.7958043375772890349@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Chun-Jie Chen (2021-09-13 19:16:20)
> Add MT8195 ccusys clock controller which provides clock gate
> control in Camera Computing Unit.
>=20
> Signed-off-by: Chun-Jie Chen <chun-jie.chen@mediatek.com>
> Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>
> ---

Applied to clk-next
