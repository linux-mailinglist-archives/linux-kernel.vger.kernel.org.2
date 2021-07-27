Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 176013D7CCA
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jul 2021 19:56:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229537AbhG0R4I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jul 2021 13:56:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:45974 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230488AbhG0R4G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jul 2021 13:56:06 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2DBC5600CD;
        Tue, 27 Jul 2021 17:56:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627408566;
        bh=2J9XXGcoeIBFFjJn8wQGMUVJY63v7Ypo97F5ivVXFJU=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=VNChKoR22Negr0KkTjJ+YSsjGbbu5kPvHlthUhdxpbyeSbKGL7HXt3jYqAoP4rsgR
         RjoXnCp/l0u7ZwoijJejyrQ0d55swsVRfEbJd6MzmS4tseXQOM3/PZRA5UfPltJiAe
         Fb05og7wH4iz7hfr1f0PwSM7m4l4+hBAN7jH1091lhU5bGEVckQ1Xu2P9UlYVLiIdF
         nd2XgqoPhRKbIc+wVJ/9r4dKe9Vk7uGbNQsDzUfIvGDLu0s190BPzo4KL+UBrlQE70
         ZDpNGJ2eOV9lXvG24wE/u++AHu12IQ06AqTXV+Z4Qk5ec+yp1c+3bP9J+c4EGAiVG4
         s7jSp4YaeJreA==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20210726105719.15793-13-chun-jie.chen@mediatek.com>
References: <20210726105719.15793-1-chun-jie.chen@mediatek.com> <20210726105719.15793-13-chun-jie.chen@mediatek.com>
Subject: Re: [v14 12/21] clk: mediatek: Add MT8192 imgsys clock support
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
Date:   Tue, 27 Jul 2021 10:56:04 -0700
Message-ID: <162740856405.2368309.3690105828191004296@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Chun-Jie Chen (2021-07-26 03:57:10)
> Add MT8192 imgsys and imgsys2 clock providers
>=20
> Signed-off-by: Weiyi Lu <weiyi.lu@mediatek.com>
> Signed-off-by: Chun-Jie Chen <chun-jie.chen@mediatek.com>
> ---

Applied to clk-next
