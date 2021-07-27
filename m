Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98D453D7CA5
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jul 2021 19:54:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231150AbhG0RyA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jul 2021 13:54:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:44318 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229581AbhG0Rx4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jul 2021 13:53:56 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A5E9360F6C;
        Tue, 27 Jul 2021 17:53:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627408436;
        bh=i1c5TttSwSevX6xNBu5xODSh9Wk6yPIXqWvUpmumCsI=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=R4psZNpHJy5zZ9pFYdN0ofLOFbt8u0Wnz490suFLF/51SKek2yg7Trh3vZmF1+w0a
         /+nz3Ah+qJRX8aDk1XuIXR7rkBTmIteZgLLWwtjpy1aI4QvKLUBPBM5S9iNOngUPVt
         d7poUNL0PeIha3Z/5DBE2OPVJ8MG9NqXVOEEOqNRb+3NtNrFnlUdroEx8rB90RGz4k
         Da2xvzTCAd8scLQlRRC7uQHh3zTuJhfzVWP+cdh9CEZe98hrEQVFJoktvbm/xBoIir
         WL8bLRZ3DwBd0DIJCMPa7NM3cOaQmp0kPsiNZNESYuUu9gekFH+vUPCooxoIBIY4rg
         /CFnm4YzaD5NA==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20210726105719.15793-3-chun-jie.chen@mediatek.com>
References: <20210726105719.15793-1-chun-jie.chen@mediatek.com> <20210726105719.15793-3-chun-jie.chen@mediatek.com>
Subject: Re: [v14 02/21] dt-bindings: ARM: Mediatek: Add mmsys document binding for MT8192
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
Date:   Tue, 27 Jul 2021 10:53:54 -0700
Message-ID: <162740843452.2368309.13157283201271440368@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Chun-Jie Chen (2021-07-26 03:57:00)
> This patch adds the mmsys document binding for MT8192 SoC.
>=20
> Signed-off-by: Chun-Jie Chen <chun-jie.chen@mediatek.com>
> Reviewed-by: Chun-Kuang Hu <chunkuang.hu@kernel.org>
> Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>
> Acked-by: Rob Herring <robh@kernel.org>
> ---

Applied to clk-next
